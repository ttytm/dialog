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
