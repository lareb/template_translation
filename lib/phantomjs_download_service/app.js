const phantom = require("phantom");
const express = require('express');
const crypto = require('crypto');
const bodyParser = require('body-parser');
const tmp = require('tmp');

const port = 8000
const app = express();
app.use(bodyParser.json());

var _ph, _page, _outObj;
var filePath, outputPath, format, quality, width, height;
var prefix = 'CreativeSuite-';

app.listen(port, () => console.log(`Phantom listening on ${port}!`))

app.post('/generate', function(request, response, next){
  filePath = request.body.filePath;
  outputPath = request.body.outputPath;
  format = request.body.format;
  quality = request.body.quality;

  height = request.body.dimension.height;
  width = request.body.dimension.width;

  console.log(`\n`, filePath, format, quality, height, width);

  phantom
    .create()
    .then(function(ph){
      _ph = ph;
      return _ph.createPage();
    })
    .then(function(page){
      _page = page;
      _page.property('viewportSize', {
        width: width ,
        height: height
      });
      _page.property('clipRect', {
        top: 0,
        left: 0,
        width: width,
        height: height
      });
      return _page.open(filePath);
    })
    .then(function(){
      return _page.render(outputPath, {format: format, quality: quality})
    })
    .then(function(){
      console.log(`Page printed on ${outputPath}\n`);
      response.send({outputPath: outputPath});
      let pageClosePromise = _page.close();
      pageClosePromise
      .then(function(){
        _ph.exit();
      });
    }).catch(function(e){
      console.log(e);
    })
})
