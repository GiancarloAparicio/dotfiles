const fs = require("fs");
const path = require("path");
const url = require("url");

function findFilesInDir(startPath, filter) {
  var results = [];

  if (!fs.existsSync(startPath)) {
    console.log("no dir ", startPath);
    return;
  }

  var files = fs.readdirSync(startPath);
  for (var i = 0; i < files.length; i++) {
    var filename = path.join(startPath, files[i]);
    var stat = fs.lstatSync(filename);
    if (stat.isDirectory()) {
      results = results.concat(findFilesInDir(filename, filter)); //recurse
    } else if (filename.indexOf(filter) >= 0) {
      results.push(filename);
    }
  }
  return results;
}

function fileUrl(str) {
  if (typeof str !== "string") {
    throw new Error("Expected a string");
  }

  var pathName = path.resolve(str).replace(/\\/g, "/");

  // Windows drive letter must be prefixed with a slash
  if (pathName[0] !== "/") {
    pathName = "/" + pathName;
  }

  return encodeURI("file://" + pathName);
}

module.exports = {
  onWillParseMarkdown: function (markdown) {
    return new Promise((resolve, reject) => {
      home = require("os").homedir();
      path_media = `${home}/brain/🧠 Cerebro digital/300 - 🗄️ Resources/380 - 🗃️ Attachments/`;

      // Regex
      remove_UUID = /#?\^\w{4,16}/gm;
      change_media =
        /(\!\[\[(.*?\.(?:jpeg|gif|svg|png|jpg|svg|pdf|mp3|mp4|webm))\|?(.*?)?\]\])/gm;
      change_wiki_links = /(?:!?\[\[(.*?)(?:#.*?)?\|(.*?)\]\])/gm;

      // Changes
      markdown = markdown.replace(remove_UUID, ($0) => "");
      markdown = markdown.replace(
        change_media,
        (whole, link, media, message) =>
          `@import "http://localhost:5555/Media/${encodeURI(media)}"`
      );
      markdown = markdown.replace(
        change_wiki_links,
        (whole, file, message) => `[${message}](${encodeURI(file)})`
      );

      return resolve(markdown);
    });
  },
  onDidParseMarkdown: function (html, { cheerio }) {
    return new Promise((resolve, reject) => {
      return resolve(html);
    });
  },
  onWillTransformMarkdown: function (markdown) {
    return new Promise((resolve, reject) => {
      regex = /(---(.|\n)*?---)/m;
      markdown = markdown.replace(regex, (whole, meta) => `${meta} \n [TOC]\n`);

      regex = /(#anki)/m;
      markdown = markdown.replace(regex, (whole, tag) => `${tag} \n`);

      return resolve(markdown);
    });
  },
  onDidTransformMarkdown: function (markdown) {
    return new Promise((resolve, reject) => {
      return resolve(markdown);
    });
  },
};
