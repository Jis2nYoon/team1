/**
 * @license Copyright (c) 2003-2019, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {

  config.toolbar = [
    { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'] },
    { name: 'styles', items: ['Font', 'FontSize' ] },
    { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'] },
    '/',
    { name: 'document', items: [ 'Source', '-', 'Preview', 'Print' ] },
    { name: 'clipboard', items: [ 'Cut', 'Copy', 'Paste', '-', 'Undo', 'Redo' ] },
    { name: 'editing', items: [ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
    { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
    { name: 'about', items: [ 'About' ] }
  ];

// Remove some buttons provided by the standard plugins, which are
// not needed in the Standard(s) toolbar.
config.removeButtons = 'Underline,Subscript,Superscript';

// Set the most common block elements.
config.format_tags = 'p;h1;h2;h3;pre';

// Simplify the dialog windows.
config.removeDialogTabs = 'image:advanced;link:advanced';
  config.filebrowserBrowseUrl = "../ckfinder/ckfinder.html";
  config.filebrowserFlashBrowseUrl = "../ckfinder/ckfinder.html?type=Flash";
  config.filebrowserUploadUrl = "../ckfinder/core/connector/java/connctor.java?command=QuickUpload&type=Files";
  config.filebrowserImageUploadUrl = "../ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Images";
  config.filebrowserFlashUploadUrl = "../ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Flash";
};


