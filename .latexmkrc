# (optional:) $pdf_previewer = "emacsclient -nc %S";
$pdf_previewer = "";
$pdf_update_method = 4;
$pdf_update_command = "emacsclient -n -e '(jf-revert-file-visiting-buffer %S)'";
 