module dialog

import webview

fn dialog__message(message string, opts MessageOptions) bool {
	w := webview.create()
	defer {
		w.destroy()
	}
	return dialog_c__message(message, opts)
}

fn dialog__prompt(message string, opts PromptOptions) ?string {
	w := webview.create()
	defer {
		w.destroy()
	}
	return dialog_c__prompt(message, opts)
}

fn dialog__file_dialog() ?string {
	w := webview.create()
	defer {
		w.destroy()
	}
	return dialog_c__file_dialog()
}

fn dialog__color_picker(opts ColorPickerOptions) ?Color {
	return none
}
