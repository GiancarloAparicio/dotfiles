#!/bin/sh

######################################################################
# @author      : Giancarlo Aparicio
# @created     : mar 07 feb 2023 20:55:50 -05
#
# @description : Se conecta a multiples servidores o a un cluster y ejecuta un comando en todas las sessiones
######################################################################

THIS_BASENAME=$(basename "$0")
TMUX_SESSION_NAME="tmux-cssh"
HOSTS=""
USER=""
IDENTITY=""
FILENAME=""
SSH_COMMAND="ssh"
SSH_ARGS=""
SYNCHRONIZE_PANES="true"
TMUX_LAYOUT="tiled"
QUIET="false"

# Config-file in home directory
CONFIG_FILENAME=".tmux-cssh"
USE_CONFIG_FILENAME="$(echo ~)/${CONFIG_FILENAME}"
CONFIG_SETTING_NAME=""

# Outputs script syntax and help
syntax() {
	echo "Syntax: ${THIS_BASENAME} [-h|-u [user]|-c|--certificate|-i|--identity [path to certificate-/identity-file]|-sc [ssh-server-connect-string]|-sa [additional ssh arguments]|-ss,-csc [ssh-command]|-ts [session-name]|-ns|-tl [tmux-layout]|-set|-q|-f [filename]|-cs [name of config-parameters to use]|[-dc,-ds][-cf config-file]]"
	echo

	echo "-h | --help                                This help."
	echo

	echo "-u | --user                                User to use."
	echo

	echo "-c | --certificate"
	echo "-i | --identity                            Path to ssh key (identity/-certificate-file) to use."
	echo

	echo "-sc | --ssh-server-connect-string          SSH-connection-string, multiple."
	echo

	echo "-sa | --ssh_args                           SSH connection arguments, used on every session."
	echo

	echo "-ss, -cs |"
	echo "	--ssh_command, --custom-cssh-command     SSH command to use."
	echo

	echo "-ts | --tmux-session-name                  Alternative tmux-session-name, default: ${THIS_BASENAME}"
	echo

	echo "-tl | --tmuxlayout                         Use different layouts (tiled, even-vertical... ) see in man tmux for more information"
	echo

	echo "-set | --set-epoch-time                    Like -ts, but quickly set the current epoch time, overwrites -ts"
	echo

	echo "-ns | --new-session                        Initializes a new session, like -ts [name]."
	echo

	echo "-q | --quiet                               Quiet-mode."
	echo

	echo "-f | --filename                            Filename of textfile to get -sc connection-strings from, line separated, multiple."
	echo

	echo "-cs | --config-setting                     Name of config-settings which should be gotten from config-file '${USE_CONFIG_FILENAME}'. This can be a grep-regular expression to find the name(s), multiple."
	echo

	echo "-dc | --dont-clusterize                    Don't clusterize ..."
	echo "-ds | --dont-synchronize                   Don't synchronize keyboard in panes, default: tmux should synchronize."
	echo

	echo "-cf | --config-file                        Config-file to use, (Default ${USE_CONFIG_FILENAME}), Designed for option to switch between multiples config-files via one tmux-cssh call."
	echo

	echo "* Other arguments will be interpreted as '-sc'."
	echo

    echo "* For a maybe newer version of ${THIS_BASENAME} take a look on https://github.com/zinic/tmux-cssh"
	echo
}

# Output given parameters if not in quiet-mode
output() {
	if [ "${QUIET}" != "true" ]; then
		echo "$@"
	fi
}

# Analyse given parameter into environment
analyseParameters() {
	# Walk through parameters
	while [ $# -gt 0 ]; do
		case "$1" in
		-h | --help)
			syntax
			exit
			;;
		-u | --user)
			USER="$2"
			shift
			;;
		-c | --certificate | -i | --identity)
			IDENTITY="$2"
			shift
			;;
		-sc | --ssh-server-connect-string)
			if [ "$2" != "" ]; then
				if [ -z "$HOSTS" ]; then
					HOSTS="$2"
				else
					HOSTS="${HOSTS},$2"
				fi
			fi
			shift
			;;
		-sa | --ssh_args)
			SSH_ARGS="${SSH_ARGS} $2"
			shift
			;;
		-ss | -csc | --ssh_command | --custom-ssh-command)
			SSH_COMMAND="$2"
			shift
			;;
		-ts | --tmux-session-name)
			TMUX_SESSION_NAME="$2"
			shift
			;;
		-tl | --tmuxlayout)
			case "$2" in
			h | H) TMUX_LAYOUT="even-horizontal" ;;
			v | V) TMUX_LAYOUT="even-vertical" ;;
			t | T) TMUX_LAYOUT="tiled" ;;
			*) TMUX_LAYOUT="$2" ;;
			esac
			shift
			;;
		-set | --set-epoch-time) TMUX_SESSION_NAME="$(date +"%s")" ;;
		-ns | --new-session) TMUX_SESSION_NAME="${TMUX_SESSION_NAME}_$(date +%s)" ;;
		-q | -quiet) QUIET="true" ;;
		-f | --filename)
			FILENAME="${FILENAME} $2"
			shift
			;;
		-cs | --config-setting)
			get_parameters_from_config_settings_name "$2"
			shift
			;;
		-dc | --dont-clusterize | -ds | --dont-synchronize) SYNCHRONIZE_PANES="false" ;;
		-cf | --config-file)
			USE_CONFIG_FILENAME="$2"
			shift
			;;
		*)
			if [ "$1" != "" ]; then
				if [ -z "$HOSTS" ]; then
					HOSTS="$1"
				else
					HOSTS="${HOSTS},$1"
				fi
			fi
			;;
		esac

		shift
	done
}

get_parameters_from_config_settings_name() {
	configSettingName=$1

	# Check if a config-settings name is given
	if [ "${configSettingName}" != "" ]; then
		# If home-config-file available
		if [ -f "${USE_CONFIG_FILENAME}" ]; then
			output "* Searching for config setting name '${configSettingName}' ..."

			# Read every line from config-settings file
			analyseParametersString=""

			while read configSettingsRow; do
				# Seperate Name and parameters
				configSettingsName=$(echo ${configSettingsRow} | cut -d ":" -f 1)
				configSettingsParameters=$(echo ${configSettingsRow} | cut -d ":" -f 2-)

				# Match name against given settings-name
				matched=$(echo ${configSettingsName} | grep "^${configSettingName}$")

				# Matched ?
				if [ "${matched}" != "" ]; then
					output "* Matched config-settings '${matched}', analysing parameters, ${configSettingsParameters} ..."
					analyseParametersString="${analyseParametersString} ${configSettingsParameters}"
				fi
			done <"${USE_CONFIG_FILENAME}"

			# Analyse parameters string
			if [ "${analyseParametersString}" != "" ]; then
				analyseParameters ${analyseParametersString}
			fi
		else
			output "No config-file '${USE_CONFIG_FILENAME}' available."
		fi
	fi
}

# Set synchronization for given tmux-session-names
# Parameter: $1 = true if tmux should synchronize panes
#            $2 = TMUX-Session-Name
synchronizePanes() {
	# Set pane synchronisation
	if [ "$1" = "true" ]; then
		syncValue='on'
	else
		syncValue='off'
	fi

	tmux set-window-option -t "$2" synchronize-panes ${syncValue}
}

# Check if tmux is available
if [ -z "$(which tmux)" ]; then
	echo "${THIS_BASENAME}"
	echo

	echo "TMUX is not avaiable."
	echo

	exit
fi

# Check main parameters
analyseParameters "$@"

# Check if SSH-Command is available
if [ -z "$(which ${SSH_COMMAND})" ]; then
	echo "SSH-Command '${SSH_COMMAND}' not found via 'which'."

	exit
fi

# Check if filenames with connection-strings are given
if [ "$FILENAME" != "" ]; then
	output "* Reading file '${FILENAME}' with host-connection-string."

	# Walk through all given filenames
	for filename in $FILENAME; do
		# Walk through all available connection strings
		while read connHost; do
			output "* Adding host '${connHost}'"

			# Add connection string to currently set hosts
			HOSTS="$HOSTS $connHost"
		done <"${filename}"
	done
fi

# Check if tmux-session is available
if tmux ls 2>/dev/null | grep -wq "${TMUX_SESSION_NAME}"; then
	# Setup synchronizing panes
	synchronizePanes ${SYNCHRONIZE_PANES} ${TMUX_SESSION_NAME}

	# Attach to available tmux-session
	tmux attach -t "${TMUX_SESSION_NAME}"
	exit
fi

# Hosts available ?
if [ -z "${HOSTS}" ]; then
	output "* Hosts not given."
	syntax

	exit
fi

initTmuxCall="true"

# Walk through hosts
HOSTS=$(echo $HOSTS | tr , ' ')

for host in ${HOSTS}; do
	connectString=""
	hostname=""
	port=""

	# Separate host and port, if given
	if echo ${host} | grep -q ':'; then
		# Remove port from string
		hostname=$(echo $host | cut -d: -f1)
		connectString=${hostname}

		# Remove host from string
		port=$(echo $host | cut -d: -f2)
	else
		connectString=${host}
	fi

	# Add user-part
	if [ "${USER}" != "" ]; then
		connectString="${USER}@${connectString}"
	fi

	# Port
	if [ "${port}" != "" ]; then
		connectString="-p ${port} ${connectString}"
	fi

	# Add identity-part
	if [ "${IDENTITY}" != "" ]; then
		connectString="-i ${IDENTITY} ${connectString}"
	fi

	# Add ssh_args-part
	if [ "${SSH_ARGS}" != "" ]; then
		connectString="${SSH_ARGS} ${connectString}"
	fi

	# Finalize connect-string
	connectString="${SSH_COMMAND} ${connectString}"

	# Output
	output "* Connecting '${connectString}'"

	# First Call, inits the tmux-session
	if [ "${initTmuxCall}" = "true" ]; then
		tmux new-session -d -s "${TMUX_SESSION_NAME}" "${connectString}"

		# If our initial ssh connection has failed, do not mark initTmuxCall as false since tmux will have aborted.
		# We'll need to try to start a new tmux session for the next host.
		if tmux ls 2>/dev/null | grep -q "${TMUX_SESSION_NAME}"; then
			initTmuxCall="false"
		fi
	else
		tmux split-window -t "${TMUX_SESSION_NAME}" "${connectString}" && tmux select-layout -t "${TMUX_SESSION_NAME}" "${TMUX_LAYOUT}"
	fi
done

# If no session was able to start, say so and just exit.
if ! tmux ls 2>/dev/null | grep -q "${TMUX_SESSION_NAME}"; then
	echo "All connections have failed."
	exit 1
fi

# Setup synchronizing panes
synchronizePanes ${SYNCHRONIZE_PANES} ${TMUX_SESSION_NAME}

# Attach to tmux session
tmux attach-session -t "${TMUX_SESSION_NAME}"
