// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require html5shiv-printshiv
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.details
//= require jquery.textchange
//= require preorder
//= require bootstrap-wysihtml5
//= require bootstrap.min
//= require_tree .


$(document).ready(function(){
    $(".imgthumb").click(function(){
    	$(".thumbnailcurrent").addClass("thumbnails");
    	$(".thumbnails").removeClass("thumbnailcurrent");
    	$(this).addClass("thumbnailcurrent");
    	$(this).removeClass("thumbnails");

        var img=($(this).attr("data-id"));

  		if (img==1) {

		 $('.imgbig').html('<img alt="Flappy1" height="275" src="http://imgur.com/mPPdKbV" width="391">');
		} else if (img==2) {

		 $('.imgbig').html('<img alt="Flappy1" height="275" src="http://imgur.com/SIZjY8u" width="391">');
		} else if (img==3) {

		 $('.imgbig').html('<img alt="Flappy1" height="275" src="http://imgur.com/1Iu2fSs" width="391">');
		}


});

    });
