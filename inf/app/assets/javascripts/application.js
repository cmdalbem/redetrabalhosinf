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
//= require bootstrap
//= require select2
//= require jqcloud

// TokenInput Settings
// Thanks to http://loopj.com/jquery-tokeninput/
$(function() {
	$("#project_tag_tokens").tokenInput( "/tags.json", {
		theme: "facebook"
		,preventDuplicates: true
		,propertyToSearch: "name"
		,hintText: "Digite tags para adicionar..."
		,noResultsText: "Sem resultados - pressione ENTER para adicionar"
		,searchingText: "Procurando por tags semelhantes..."
		,animateDropdown: false
		,allowFreeTagging: true // Enables the user to insert tags that weren't found. Later validation is done on the Controller for creating the tags within the BD.
	});	

});

// Initializes Bootstrap's Popovers
$(function () {
	$('[rel=popover]').popover({placement:'bottom',html:true});
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
	function formatResult(state) {
	    divclass = state.nprojects==0 ? "muted" : "";
	    return "<div class=\"" + divclass + "\"> " + state.text + "<span class=\"pull-right\">" + state.nprojects + "</span></div>";
	}

	function formatSelection(state) {
		return state.text;
	}

	$(".select2").select2({
		formatNoMatches: function () { return "Nenhum resultado encontrado"; }
        ,formatInputTooShort: function (input, min) { var n = min - input.length; return "Informe " + n + " caracter" + (n == 1? "" : "es"); }
        ,formatInputTooLong: function (input, max) { var n = input.length - max; return "Apague " + n + " caracter" + (n == 1? "" : "es"); }
        ,formatSelectionTooBig: function (limit) { return "Só é possível selecionar " + limit + " elemento" + (limit == 1 ? "" : "s"); }
        ,formatLoadMore: function (pageNumber) { return "Carregando mais resultados..."; }
        ,formatSearching: function () { return "Buscando..."; }
        ,data: select2Array
        ,formatResult: formatResult
        ,formatSelection: formatSelection
	});
});

$(function() {
	$(".select2-tagger").select2({
    		tokenSeparators: [",", " "], placeholder: 'Tags'
    	});
});

// Character counters.
// Thanks to http://bampa.se/2011/01/simple-jquery-character-counter/
$('#project_description').live('keyup keydown', function(e) {
  // global_constants.rb: PROJECT_DESCRIPTION_MAX_LENGTH = 1500
  var maxLen = 1500;
  var left = maxLen - $(this).val().length;
  $('#char_count').html(left);
});
$('#person_about').live('keyup keydown', function(e) {
	// global_constants.rb: PERSON_ABOUT_MAX_LENGTH = 300
  var maxLen = 300;
  var left = maxLen - $(this).val().length;
  $('#char_count').html(left);
});