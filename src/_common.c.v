module dialog

#flag @VMODROOT/src/osdialog/osdialog.c
#flag darwin @VMODROOT/src/osdialog/osdialog_mac.m -framework AppKit
#flag windows @VMODROOT/src/osdialog/osdialog_win.c -lcomdlg32
#flag linux @VMODROOT/src/osdialog/osdialog_gtk2.c
$if linux {
	$if !gtk2 ? {
		#flag -DOSDIALOG_GTK3
	}
	#pkgconfig gtk+-3.0
}

#include "@VMODROOT/src/osdialog/osdialog.h"

@[typedef]
struct C.osdialog_color {
	r u8
	g u8
	b u8
	a u8
}

fn C.osdialog_message(level int, buttons int, message &char) int
fn C.osdialog_prompt(level int, message &char, text &char) &char
fn C.osdialog_color_picker(color &C.osdialog_color, opacity int) int
fn C.osdialog_file(action int, path &char, filename &char, filters C.osdialog_filters) &char

fn dialog__message(message string, opts MessageOptions) bool {
	$if macos {
		app := create()
		defer {
			destroy(app)
		}
	}
	return if C.osdialog_message(int(opts.level), int(opts.buttons), &char(message.str)) == 1 {
		true
	} else {
		false
	}
}

fn dialog__prompt(message string, opts PromptOptions) ?string {
	$if macos {
		app := create()
		defer {
			destroy(app)
		}
	}
	input := C.osdialog_prompt(int(opts.level), &char(message.str), &char(opts.text.str))
	unsafe {
		if input != nil {
			return input.vstring()
		}
	}
	return none
}

fn dialog__color_picker(opts ColorPickerOptions) ?Color {
	$if macos {
		app := create()
		defer {
			destroy(app)
		}
	}
	color := &opts.color
	if C.osdialog_color_picker(color, int(opts.opacity)) == 1 {
		return *color
	}
	return none
}

fn dialog__file_dialog_handler(action FileAction, path &char, filename &char) ?string {
	$if macos {
		app := create()
		defer {
			destroy(app)
		}
	}
	selected := C.osdialog_file(int(action), path, filename, unsafe { nil })
	unsafe {
		if selected != nil {
			return selected.vstring()
		}
	}
	return none
}

fn dialog__file_dialog(opts FileDialogOptions) ?string {
	return dialog__file_dialog_handler(opts.action, &char(opts.path.str), &char(opts.filename.str))
}

fn dialog__open_file(opts FileOpenOptions) ?string {
	return dialog__file_dialog_handler(.open, &char(opts.path.str), unsafe { nil })
}

fn dialog__open_dir(opts FileOpenOptions) ?string {
	return dialog__file_dialog_handler(.open_dir, &char(opts.path.str), unsafe { nil })
}

fn dialog__save_file(opts FileSaveOptions) ?string {
	return dialog__file_dialog_handler(.save, &char(opts.path.str), &char(opts.filename.str))
}
