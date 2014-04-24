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
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require twitter/bootstrap
//= require select2
//= require jqcloud
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/pt-BR

/**
* Select2 Brazilian Portuguese translation
*/
(function ($) {
    "use strict";

    $.extend($.fn.select2.defaults, {
        formatNoMatches: function () { return "Nenhum resultado encontrado"; },
        formatInputTooShort: function (input, min) { var n = min - input.length; return "Informe " + n + " caracter" + (n == 1? "" : "es"); },
        formatInputTooLong: function (input, max) { var n = input.length - max; return "Apague " + n + " caracter" + (n == 1? "" : "es"); },
        formatSelectionTooBig: function (limit) { return "Só é possível selecionar " + limit + " elemento" + (limit == 1 ? "" : "s"); },
        formatLoadMore: function (pageNumber) { return "Carregando mais resultados..."; },
        formatSearching: function () { return "Buscando..."; }
    });
})(jQuery);

// Initializes Bootstrap's Popovers
$(function () {
	$('[rel=popover]').popover({placement:'bottom',html:true});
});

// Adjust #wrap padding-top when navbar grows vertically (on small screns)
$(window).resize(function() {
  $("#wrap").css("padding-top", $("header").height() + 3);
});

// Function used within forms for deleting uploaded files.
// Remember to: (1) create a hidden field holding a boolean value
// 				(2) pass into this function the ID of the field of the previous step
//				(3) handle this hidden field value on Update call of your controller
function deleteUploadedField(toDeleteCheckbox,fieldName)
{
	if(confirm('Tem certeza?')) {
		$("#" + toDeleteCheckbox).val('true');
		// $("#" + fieldName).disabled = true;
		$('form').submit();
		return false;			
	}
}

$(function() {
	$(".select2-tagger").select2({
    		tokenSeparators: [",", " "], placeholder: 'Tags'
    	});
});

$(document).on('click propertychange keyup input paste', 'input', function(){
    var io = $(this).val().length ? 1 : 0 ;
    $(this).next('.icon_clear').stop().fadeTo(200,io);
}).on('click', '.icon_clear', function() {
    $(this).hide().prev('input').val('');
});

// Dynamic fields on Project Form
function remove_fields (link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).parent(".url_fields").hide();
}
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}
