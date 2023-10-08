# dialog

> A cross-platform utility library for V to open system dialogs - open files, message boxes,
> color-pickers etc.

## Showcase

<table align="center">
  <tr>
    <th>Linux</th>
    <th>Windows</th>
    <th>macOS</th>
  </tr>
  <tr>
    <td width="400">
      <img alt="Linux File Dialog" src="https://github.com/ttytm/dialog/assets/34311583/6ba6e96b-3581-4382-8074-79918a99dcbd">
    </td>
    <td width="400">
      <img alt="Windows File Dialog" src="https://github.com/ttytm/dialog/assets/34311583/911e8c71-0cc1-4426-a62c-04714b6b071f">
    </td>
    <td width="400">
      <img alt="macOS File Dialog" src="https://github.com/ttytm/dialog/assets/34311583/f7c4375e-d2e4-4121-ad34-db0473d8fabe">
    </td>
  </tr>
</table>

<details>
<summary><kbd>Toggle More</kbd></summary>

<table align="center">
  <tr>
    <th>Linux</th>
    <th>Windows</th>
    <th>macOS</th>
  </tr>
  <tr>
    <td width="400">
      <img alt="Linux Color Picker GTK3" src="https://github.com/ttytm/dialog/assets/34311583/8e587c8c-2f12-41ee-9a10-4c3f92e72885">
      <img alt="Linux Message" src="https://github.com/ttytm/dialog/assets/34311583/42e1081b-ee52-4286-abfd-ad9eda63d282">
      <img alt="Linux Message with Yes and No Buttons" src="https://github.com/ttytm/dialog/assets/34311583/07aa26bd-f887-417b-9c1a-56724ceb2589">
      <img alt="Linux Input Prompt" src="https://github.com/ttytm/dialog/assets/34311583/bc5e3ec1-88b5-4e1a-b46e-381b322b8a6c">
      <img alt="Linux Color Picker GTK2" src="https://github.com/ttytm/dialog/assets/34311583/37619ed0-8fe2-4e5c-af11-70d7f2304b2b">
    </td>
    <td width="400">
      <img alt="Windows Color Picker" src="https://github.com/ttytm/dialog/assets/34311583/966b1395-55ac-45b8-aa1b-516f673b64e8">
      <img alt="Windows Message" src="https://github.com/ttytm/dialog/assets/34311583/a73e0eaf-e56b-44e6-bcc5-31bb381c6e37">
      <img alt="Windows Message with Yes and No Buttons" src="https://github.com/ttytm/dialog/assets/34311583/16a1ad65-571e-4183-8c0b-119cbf126aec">
      <img alt="Windows Input Prompt" src="https://github.com/ttytm/dialog/assets/34311583/54e4a708-de38-44ea-ae61-be39c1bdbff9">
    </td>
    <td width="400">
      <img alt="macOS Message" src="https://github.com/ttytm/dialog/assets/34311583/15920c46-e529-405f-9731-3ac57ce46449">
      <img alt="macOS Message with Yes and No Buttons" src="https://github.com/ttytm/dialog/assets/34311583/11cba10b-3190-4114-b1ad-e49e56d4498c">
      <img alt="macOS Input Prompt" src="https://github.com/ttytm/dialog/assets/34311583/e6d496b4-3c20-4ece-8808-0eba99a59a45">
    </td>
  </tr>
</table>

</details>

## Installation

```sh
v install --git https://github.com/ttytm/dialog
```

On macOS, `dialog` currently uses V webview to ensure it can interop with system windows.

```sh
# macOS only dependency
v install --git https://github.com/ttytm/webview
~/.vmodules/webview/build.vsh
```

## Usage

```v ignore
// message launches a message box and returns `true` if `OK` or `Yes` was pressed.
pub fn message(message string, opts MessageOptions) bool

// prompt launches an input prompt with an "OK" and "Cancel" button.
pub fn prompt(message string, opts PromptOptions) ?string

// file_dialog opens a file dialog and returns the selected path or `none` if the selection was canceled.
pub fn file_dialog(opts FileDialogOptions) ?string

// open_file opens a file dialog reads the selected path.
// Optionally, `path` can be specified as the default folder the dialog will attempt to open in.
// It returns an error if the selection is cancelled or the reading the file fails.
pub fn open_file(opts FileOpenOptions) !string

// open_dir opens a file dialog and returns a list with the paths of the selected directory contents.
// Optionally, `path` can be specified as the default folder the dialog will attempt to open in.
// It returns an error if the selection is cancelled or the reading the directory contents fails.
pub fn open_dir(opts FileOpenOptions) ![]string

// save_file opens a file dialog and saves the given content to the selected path.
// Optionally, `path` can be specified as the default folder the dialog will attempt to open in.
// `filename` can be provided to set the default text that will appear in the filename input.
// It returns an error if the selection is cancelled or the writing the file fails.
pub fn save_file(opts FileSaveOptions) !

// color_picker opens an RGBA color picker dialog and returns the selected color or `none` if the
// selection was canceled. Optionally, it takes a `color` and `opacity` argument. `color` sets the
// dialogs initial color. On Linux, `opacity` can be set to `false` to disable the opacity slider.
pub fn color_picker(opts ColorPickerOptions) ?Color
```

> **Note**
> v doc provides an overview of all public definitions. \
> Use `v doc -comments dialog.src` in the terminal, or check out the module's [doc pages](https://ttytm.github.io/dialog/dialog.html) in the browser.

### Example

```v
module main

import dialog

dialog.message('Thanks for using dialog!')

if !dialog.message('Do you want to continue?', buttons: .yes_no) {
	dump('Canceled!')
}

input := dialog.prompt('What is your pets name?')
dump(input)

selected_file := dialog.open_file()
dump(selected_file)

selected_color := dialog.color_picker()
dump(selected_color)
```

```sh
v run examples/minimal.v
```

> **Note**
> When running and building on Windows, it is recommended to use `gcc` for compilation. E.g.:
>
> ```sh
> v -cc gcc run examples/minimal.v
> ```

## Disclaimer

The project is made public in an early stage. Best practices and quality will be paramount
throughout development, but it may undergo drastic changes while maturing.

If the library could already achieve it's goal of also helping your project, or just to share some
love, filling the ☆ of this repo with color will warm the heart of your fellow developer.

## Credits

- [AndrewBelt/osdialog](https://github.com/AndrewBelt/osdialog) - C project that `dialog` binds to.
- [vlang/v](https://github.com/vlang/v) - Simple-to-use, developer-friendly system programming with
  high interoperability.
