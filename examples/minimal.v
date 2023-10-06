module main

import dialog

selected_choice := dialog.message('Info', buttons: .yes_no)
dump(selected_choice)

selected_file := dialog.file_dialog()
dump(selected_file)

selected_color := dialog.color_picker()
dump(selected_color)
