// dialog
//
// A cross-platform utility library to open system dialogs - open files, message boxes, color-pickers etc.
// License: MIT
// Source: https://github.com/ttytm/dialog
module dialog

import os

[params]
pub struct MessageOptions {
	level   MessageLevel
	buttons MessageButtons
}

[params]
pub struct PromptOptions {
	level MessageLevel
	text  string // is the initial input text.
}

[params]
pub struct FileDialogOptions {
	action   FileAction
	path     string // is the default folder the dialog will attempt to open in.
	filename string // is the default text that will appear in the filename input. Only when the action is `.save`.
}

[params]
pub struct FileOpenOptions {
	path string // is the default folder the dialog will attempt to open in.
}

[params]
pub struct FileSaveOptions {
	path     string // is the default folder the dialog will attempt to open in.
	filename string // is the default text that will appear in the filename input.
}

[params]
pub struct ColorPickerOptions {
	color   Color // is the initial color.
	opacity bool = true // can be set to `false` to disable the opacity slider on Linux.
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

// Color represents an RGBA color struct.
// Example:
// ```v
// c := Color{
// 	r: 93
// 	g: 135
// 	b: 191
// 	a: 255
// }
// ```
// Example: color_picker(color: Color{93, 135, 191, 255})
pub type Color = C.osdialog_color

// message launches a message box and returns `true` if `OK` or `Yes` was pressed.
pub fn message(message string, opts MessageOptions) bool {
	return dialog__message(message, opts)
}

// prompt launches an input prompt with an "OK" and "Cancel" button.
pub fn prompt(message string, opts PromptOptions) ?string {
	return dialog__prompt(message, opts)
}

// file_dialog opens a file dialog and returns the selected path or `none` if the selection was canceled.
pub fn file_dialog(opts FileDialogOptions) ?string {
	return dialog__file_dialog(opts)
}

// open_file opens a file dialog and reads the file contents of the selected path.
// Optionally, `path` can be specified as the default folder the dialog will attempt to open in.
// It returns an error if the selection is cancelled or the reading // the file fails.
pub fn open_file(opts FileOpenOptions) !string {
	if path := dialog__open_file(opts) {
		return os.read_file(path) or { error('error: failed to read file from "${path}". ${err}') }
	}
	return error('error: no path selected.')
}

// open_dir opens a file dialog and returns a list with the paths of the selected directory contents.
// Optionally, `path` can be specified as the default folder the dialog will attempt to open in.
// It returns an error if the selection is cancelled or the reading the directory contents fails.
pub fn open_dir(opts FileOpenOptions) ![]string {
	if path := dialog__open_dir(opts) {
		dir_contents := os.ls(path) or {
			return error('error: failed to read directory contents from "${path}". ${err}')
		}
		return dir_contents.map(os.join_path(path, it))
	}
	return error('error: no path selected.')
}

// save_file opens a file dialog and saves the given content to the selected path.
// Optionally, `path` can be specified as the default folder the dialog will attempt to open in.
// `filename` can be provided to set the default text that will appear in the filename input.
// It returns an error if the selection is cancelled or the writing the file fails.
pub fn save_file(content string, opts FileSaveOptions) ! {
	if path := dialog__save_file(opts) {
		os.write_file(path, content) or {
			return error('error: failed to save file to "${path}". ${err}')
		}
	}
	return error('error: no path selected.')
}

// color_picker opens an RGBA color picker dialog and returns the selected color or `none` if the
// selection was canceled. Optionally, it takes a `color` and `opacity` argument. `color` sets the
// dialogs initial color. On Linux, `opacity` can be set to `false` to disable the opacity slider.
// TODO: macOS support
pub fn color_picker(opts ColorPickerOptions) ?Color {
	return dialog__color_picker(opts)
}
