// dialog
//
// A cross-platform utility library to open system dialogs - open files, message boxes, color-pickers etc.
// License: MIT
// Source: https://github.com/ttytm/dialog
module dialog

[params]
pub struct MessageOptions {
	level   MessageLevel
	buttons MessageButtons
}

[params]
pub struct PromptOptions {
	level MessageLevel
	text  string
}

[params]
pub struct ColorPickerOptions {
	color   Color
	opacity bool = true
}

pub enum FileAction {
	open
	open_dir
	save
}

pub enum MessageButtons {
	ok
	ok_cancel
	yes_no
}

pub enum MessageLevel {
	info
	warning
	error
}

pub type Color = C.osdialog_color

// file_dialog opens a file dialog and returns the selected path or `none` if the selection was canceled.
// TODO: file_dialog params struct
pub fn file_dialog() ?string {
	return dialog__file_dialog()
}

// message launches a message box and returns `true` if `OK` or `Yes` was pressed.
pub fn message(message string, opts MessageOptions) bool {
	return dialog__message(message, opts)
}

// prompt launches an input prompt with an "OK" and "Cancel" button.
pub fn prompt(message string, opts PromptOptions) ?string {
	return dialog__prompt(message, opts)
}

// color_picker opens an RGBA color picker dialog and returns the selected color or `none` if the
// selection was canceled. Optionally, it takes a `color` and `opacity` argument. `color` sets the
// dialogs initial color. On Linux, `opacity` can be set to `false` to disable the opacity slider.
// TODO: macOS support
pub fn color_picker(opts ColorPickerOptions) ?Color {
	return dialog__color_picker(opts)
}
