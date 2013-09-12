var gui   = require('nw.gui');
var win   = gui.Window.get();
var util  = require('util');
var EJS   = require('ejs');
//var fs    = require('fs');

var appState;

$(document).ready(function() {

  resetAppState();

  populateContent({}, 'main_content' )

  win.show();

  $('#debugger').click(function() {
	  win.showDevTools();
  });

});

function clearMain () {
  $('#main_content').remove();
}

function populateContent (data, file) {
  var content_ejs = EJS.compile(fs.readFileSync('appdir/views/'+file+'.ejs', 'utf8'));
  $('#content').html(content_ejs(data));
  initButtons();
}

function initButtons() {
  
  $('button').click( function () { } );

  $('#quit').click( function () { win.close(); } );

}

function resetAppState() {
  appState = {};
}

