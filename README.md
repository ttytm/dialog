# dialog

> A cross-platform utility library for V to open system dialogs - open files, message boxes,
> color-pickers etc.

## Linux

<div align="center">

![file_dialog](https://github.com/ttytm/dialog/assets/34311583/6ba6e96b-3581-4382-8074-79918a99dcbd)

</div>

<details aling="center">
<summary><kbd>Toggle More Linux Screenshots</kbd></summary>

![color_picker_gtk3](https://github.com/ttytm/dialog/assets/34311583/8e587c8c-2f12-41ee-9a10-4c3f92e72885)
![messgae](https://github.com/ttytm/dialog/assets/34311583/c07909aa-20d3-4f1c-9c7e-f0cbee1e5839)
![color_picker_gtk2](https://github.com/ttytm/dialog/assets/34311583/37619ed0-8fe2-4e5c-af11-70d7f2304b2b)

</details>

## Windows

<div align="center">

![file_dialog](https://github.com/ttytm/dialog/assets/34311583/5cfaff5c-4a82-4e3a-a2cb-d1b5de326d95)

</div>

<details>
<summary><kbd>Toggle More Windows Screenshots</kbd></summary>

![color_picker](https://github.com/ttytm/dialog/assets/34311583/10a3a3d4-2b0f-4277-ad94-90af40ae4a62)
![message](https://github.com/ttytm/dialog/assets/34311583/c102876b-75dd-4f1f-b0b0-e0319fdaa4e2)

</details>

## macOS

<div align="center">

![file_dialog](https://github.com/ttytm/dialog/assets/34311583/f7c4375e-d2e4-4121-ad34-db0473d8fabe)

</div>

<details>
<summary><kbd>Toggle More macOS Screenshots</kbd></summary>

![message](https://github.com/ttytm/dialog/assets/34311583/7a217d9a-8e09-4eb6-b369-9e6eb2257ad6)

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
// file_dialog opens a file dialog and returns the selected path or `none` if the selection was canceled.
pub fn file_dialog() ?string

// message launches a message box and returns `true` if `OK` or `Yes` was pressed.
pub fn message(text string, opts MessageOptions) bool

// color_picker opens an RGBA color picker dialog and returns the selected color or `none` if the
// selection was canceled. Optionally, it takes a `color` and `opacity` argument. `color` sets the
// dialogs initial color. On Linux, `opacity` can be set to `false` to disable the opacity slider.
// TODO: macOS support
pub fn color_picker(opts ColorPickerOptions) ?Color
```

### Example

```v
module main

import dialog

selected_choice := dialog.message('Info', buttons: .yes_no)
dump(selected_choice)

selected_file := dialog.file_dialog()
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
