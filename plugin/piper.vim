" _____________________________________________________
"/\                                                    \
"\_|        _                       _                  |
"  | __   _(_)_ __ ___        _ __ (_)_ __   ___ _ __  |
"  | \ \ / / | '_ ` _ \ _____| '_ \| | '_ \ / _ \ '__| |
"  |  \ V /| | | | | | |_____| |_) | | |_) |  __/ |    |
"  |   \_/ |_|_| |_| |_|     | .__/|_| .__/ \___|_|    |
"  |                         |_|     |_|               |
"  |                                                   |
"  |   ________________________________________________|_
"   \_/__________________________________________________/
"
"
" A simple wrapper over piper text to speech system.
"
" Copyright © 2024 wolandark
"
" piper repository: https://github.com/rhasspy/piper
" plugin home: https://github.com/wolandark/vim-piper
"
"
"┌─────────┐
"│Load Once│
"└─────────┘
if exists("g:loaded_piper")
	finish
endif
let g:loaded_piper = 1

"┌──────────┐
"│Check vars│
"└──────────┘
if !exists('g:piper_bin')
	let g:piper_bin = '/usr/bin/piper-tts'
endif

if !exists('g:piper_voice')
	let g:piper_voice = '/usr/share/piper-voices/en/en_US/joe/medium/en_US-joe-medium.onnx'
endif

"┌────────────────────────────────────────────┐
"│Utility Function To Get The Visual Selection│
"└────────────────────────────────────────────┘
function! PassVisualSelection()
	let start = getpos("'<")
	let end = getpos("'>")
	let lines = getline(start[1], end[1])
	let lines[-1] = lines[-1][ : end[2] - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][start[2] - 1 : ]
	let g:selection = join(lines, "\n")
	return g:selection
endfunction

"┌───────────────────────────┐
"│Speak Word Under The Cursor│
"└───────────────────────────┘
function! SpeakWord()
	let word_under_cursor = expand('<cword>')
	call system('echo "'. word_under_cursor .'" | '. g:piper_bin .' --model '. g:piper_voice .' --output-raw | aplay -r 22050 -f S16_LE -t raw -')
	redraw!
endfunction

"┌──────────────────┐
"│Speak Current Line│
"└──────────────────┘
function! SpeakCurrentLine()
	" Yank the current line to the 'a' register
	normal! "ayy
	" Execute the Piper command using the contents of the 'a' register
	call system('echo "' . @a . '" | '. g:piper_bin .' --model '. g:piper_voice .' --output-raw | aplay -r 22050 -f S16_LE -t raw -')
	" Redraw the screen to clean up
	redraw!
endfunction

"┌───────────────────────┐
"│Speak Current Paragraph│
"└───────────────────────┘
function! SpeakCurrentParagraph()
	" Yank the current paragraph to the 'a' register
	normal! vap"ay
	" Get the contents of register 'a', split by newlines, and join into a single line
	let paragraph_text = join(split(@a, "\n"), " ")
	" Execute the Piper command using the contents of the paragraph
	call system('echo ' . shellescape(paragraph_text) . ' | '. g:piper_bin .' --model '. g:piper_voice .' --output-raw | aplay -r 22050 -f S16_LE -t raw -')
	" Redraw the screen to clean up
	redraw!
endfunction

"┌──────────────────────┐
"│Speak Visual Selection│
"└──────────────────────┘
function! SpeakVisualSelection()
	call PassVisualSelection()
	" Execute the Piper command using the contents of the 'a' register
	call system('echo "' . g:selection . '" | '. g:piper_bin .' --model '. g:piper_voice .' --output-raw | aplay -r 22050 -f S16_LE -t raw -')
	" Redraw the screen to clean up
	redraw!
endfunction

"┌──────────────────┐
"│Speak Current File│
"└──────────────────┘
function! SpeakCurrentFile()
	" Yank the current file to the 'a' register
	execute "%y a"
	" Get the contents of register 'a', split by newlines, and join into a single line
	let paragraph_text = join(split(@a, "\n"), " ")
	" Execute the Piper command using the contents of the paragraph
	call system('echo ' . shellescape(paragraph_text) . ' | '. g:piper_bin .' --model '. g:piper_voice .' --output-raw | aplay -r 22050 -f S16_LE -t raw -')
	" Redraw the screen to clean up
	redraw!
endfunction

"┌─────────────────┐
"│Map the functions│
"└─────────────────┘
nnoremap <Leader>tw :call SpeakWord()<CR>
nnoremap <Leader>tc :call SpeakCurrentLine()<CR>
nnoremap <Leader>tp :call SpeakCurrentParagraph()<CR>
nnoremap <Leader>tf :call SpeakCurrentFile()<CR>
vnoremap <Leader>tv :call SpeakVisualSelection()<CR>
