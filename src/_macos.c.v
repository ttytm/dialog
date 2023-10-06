module dialog

import webview

fn dialog__file_dialog() ?string {
	w := webview.create()
	defer {
		w.destroy()
	}
	return dialog_c__file_dialog()
}

fn dialog__message(text string, opts MessageOptions) bool {
	$if macos {
		w := webview.create()
		defer {
			w.destroy()
		}
	}
	return dialog_c__message(text, opts)
}

fn dialog__color_picker(opts ColorPickerOptions) ?Color {
	return none
}
