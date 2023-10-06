module dialog

fn dialog__file_dialog() ?string {
	return dialog_c__file_dialog()
}

fn dialog__message(text string, opts MessageOptions) bool {
	return dialog_c__message(text, opts)
}

fn dialog__color_picker(opts ColorPickerOptions) ?Color {
	return dialog_c__color_picker(opts)
}
