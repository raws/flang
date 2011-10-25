var editor;

$(function() {
	var RubyMode = require("ace/mode/ruby").Mode;
	editor = ace.edit("command_editor");
	editor.getSession().setMode(new RubyMode());
	editor.getSession().setTabSize(2);
	editor.getSession().setUseSoftTabs(true);
	editor.setShowPrintMargin(false);
	$("#command_editor").css("fontSize", "14px");
	
	if ($("#command_editor").hasClass("read_only")) {
		editor.setReadOnly(true);
	}
	
	$("form.new_command, form.edit_command").submit(function() {
		$("#command_body").val(editor.getSession().getValue());
	});
});
