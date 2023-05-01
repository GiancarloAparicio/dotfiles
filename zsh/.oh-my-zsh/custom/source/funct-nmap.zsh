#-------------------------------------------------------------------
# Functions nmap

_transform_url_to_domain(){
    local server=$1
    local regExpServer="^((http[s]?|ftp):\/{2})([^:\/ ]+)(\/\w+){0}\/?[^\w\-\.]*"

    if [[ $server =~ $regExpServer  ]]; then
        server=${match[3]}
    fi
    
    echo server
}

nmap-firewall(){
    local server=_transform_url_to_domain $1

    nmap -p80,443 --script http-waf-detect --script-args="http-waf-detect.aggro,http-waf-detect.detectBodyChanges" $server
    nmap -p80,443 --script http-waf-fingerprint --script-args http-waf-fingerprint.intensive=1 $server
}

nmap-http-errors(){
    local server=_transform_url_to_domain $1

    nmap -vv -p80,443 --script http-errors --script-args "httpspider.url=/docs/,httpspider.maxpagecount=3,httpspider.maxdepth=1" $server
}

nmap-subdomains(){
    local server=_transform_url_to_domain $1

    nmap -p80,443 --script dns-brute --script-args dns-brute.threads=25 $server
}
