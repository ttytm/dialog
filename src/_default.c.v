module dialog

fn dialog__message(message string, opts MessageOptions) bool {
	return dialog_c__message(message, opts)
}

fn dialog__prompt(message string, opts PromptOptions) ?string {
	return dialog_c__prompt(message, opts)
}

fn dialog__file_dialog(opts FileDialogOptions) ?string {
	return dialog_c__file_dialog(opts.action, &char(opts.path.str), &char(opts.filename.str))
}

fn dialog__open_file(opts FileOpenOptions) ?string {
	return dialog_c__file_dialog(.open, &char(opts.path.str), unsafe { nil })
}

fn dialog__open_dir(opts FileOpenOptions) ?string {
	return dialog_c__file_dialog(.open_dir, &char(opts.path.str), unsafe { nil })
}

fn dialog__save_file(opts FileSaveOptions) ?string {
	return dialog_c__file_dialog(.save, &char(opts.path.str), &char(opts.filename.str))
}

fn dialog__color_picker(opts ColorPickerOptions) ?Color {
	return dialog_c__color_picker(opts)
}
