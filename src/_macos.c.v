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

[deprecated]
fn dialog__file_dialog() ?string {
	w := webview.create()
	defer {
		w.destroy()
	}
	return unsafe { dialog_c__file_dialog(.open, nil, nil) }
}

fn dialog__open_file(opts FileOpenOptions) ?string {
	w := webview.create()
	defer {
		w.destroy()
	}
	return dialog_c__file_dialog(.open, &char(opts.path.str), unsafe { nil })
}

fn dialog__open_dir(opts FileOpenOptions) ?string {
	w := webview.create()
	defer {
		w.destroy()
	}
	return dialog_c__file_dialog(.open_dir, &char(opts.path.str), unsafe { nil })
}

fn dialog__save_file(opts FileSaveOptions) ?string {
	w := webview.create()
	defer {
		w.destroy()
	}
	return dialog_c__file_dialog(.save, &char(opts.path.str), &char(opts.filename.str))
}

fn dialog__color_picker(opts ColorPickerOptions) ?Color {
	return none
}
