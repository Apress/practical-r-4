// get_internetlivestats.js

var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'livestats.html'

page.open('https://www.internetlivestats.com', function (status) {
  var content = page.content;
  fs.write(path,content,'w')
  phantom.exit();
});