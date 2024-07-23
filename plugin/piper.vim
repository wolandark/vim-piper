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
	let g:selection = join(lines, ' ')
	return g:selection
endfunction

"┌───────────────────────────┐
"│Speak Word Under The Cursor│
"└───────────────────────────┘
function! SpeakWord()
	let word_under_cursor = expand('<cword>')
	let command = 'echo '. word_under_cursor .' | '. g:piper_bin .' --model '. g:piper_voice .' --output-raw | aplay -r 22050 -f S16_LE -t raw -'
	call system(command)
	set lazyredraw
	redraw!
endfunction

"┌──────────────────┐
"│Speak Current Line│
"└──────────────────┘
function! SpeakCurrentLine()
	normal! "ayy
	" split by newlines, and join into a single line (Seemingly unnecessary but is worth the trouble)
	let line_text = join(split(@a, "\n"), " ")
	let command = 'echo '. shellescape(line_text) .' | '. g:piper_bin .' --model '. g:piper_voice .' --output-raw | aplay -r 22050 -f S16_LE -t raw -'
	call system(command)
	set lazyredraw
	redraw!
endfunction

"┌───────────────────────┐
"│Speak Current Paragraph│
"└───────────────────────┘
function! SpeakCurrentParagraph()
	normal! vap"ay
	" split by newlines, and join into a single line
	let paragraph_text = join(split(@a, "\n"), " ")
    let command = 'echo ' . shellescape(paragraph_text) . ' | ' . g:piper_bin . ' --model ' . g:piper_voice . ' --output-raw | aplay -r 22050 -f S16_LE -t raw -'
	call system(command)
	set lazyredraw
	redraw!
endfunction

"┌──────────────────────┐
"│Speak Visual Selection│
"└──────────────────────┘
function! SpeakVisualSelection()
	let g:selection = ''
	call PassVisualSelection()
	" shellescape to avoid errors
    let escaped_selection = shellescape(g:selection)
    let command = 'echo ' . escaped_selection . ' | ' . g:piper_bin . ' --model ' . g:piper_voice . ' --output-raw | aplay -r 22050 -f S16_LE -t raw -'
    call system(command)
	set lazyredraw
	redraw!
endfunction

"┌──────────────────┐
"│Speak Current File│
"└──────────────────┘
function! SpeakCurrentFile()
	execute "%y a"
	" split by newlines, and join into a single line
	let paragraph_text = join(split(@a, "\n"), " ")
	let escaped_file = shellescape(paragraph_text) 
	let command = 'echo ' . escaped_file . ' | '. g:piper_bin .' --model '. g:piper_voice .' --output-raw | aplay -r 22050 -f S16_LE -t raw -'
	call system(command)
	set lazyredraw
	redraw!
endfunction

"┌─────────────────┐
"│Map the functions│
"└─────────────────┘
nnoremap <Leader>tw :call SpeakWord()<CR>
nnoremap <Leader>tc :call SpeakCurrentLine()<CR>
nnoremap <Leader>tp :call SpeakCurrentParagraph()<CR>
nnoremap <Leader>tf :call SpeakCurrentFile()<CR>
vnoremap <Leader>tv :<C-U>call SpeakVisualSelection()<CR>
