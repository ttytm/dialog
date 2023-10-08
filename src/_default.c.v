module dialog

fn dialog__message(message string, opts MessageOptions) bool {
	return dialog_c__message(message, opts)
}

fn dialog__prompt(message string, opts PromptOptions) ?string {
	return dialog_c__prompt(message, opts)
}

fn dialog__file_dialog() ?string {
	return dialog_c__file_dialog()
}

fn dialog__color_picker(opts ColorPickerOptions) ?Color {
	return dialog_c__color_picker(opts)
}
