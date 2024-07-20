# Vim Piper

A simple wrapper over the Piper text-to-speech system.

## Introduction

Vim Piper is a Vim plugin that integrates the Piper text-to-speech system into Vim. It allows you to easily convert text within Vim to speech using Piper.

## Installation

### Using vim-plug

Add the following to your `~/.vimrc` or `~/.config/nvim/init.vim`:

```vim
Plug 'wolandark/vim-piper'
```

Then run `:PlugInstall` in Vim.

# Configuration

You can configure the following variables in your ~/.vimrc.

```vim
let g:piper_bin = '/path/to/piper'
let g:piper_voice = '/path/to/voice/model.onnx'
```

The default values are:
```vim
let g:piper_bin = '/home/woland/tmp/piper/piper-bin/piper/piper'
let g:piper_voice = '/home/woland/tmp/piper/piper-voices/en/en_US/joe/medium/en_US-joe-medium.onnx'
```
# Functions
The plugin provides the following functions:

   - PassVisualSelection(): Utility function to get the visual selection.
   - SpeakWord(): Speak the word under the cursor.
   - SpeakCurrentLine(): Speak the current line.
   - SpeakCurrentParagraph(): Speak the current paragraph.
   - SpeakVisualSelection(): Speak the visual selection.
   - SpeakCurrentFile(): Speak the current file.

# Mappings
The following mappings are defined by default:

- nnoremap <Leader>tw :call SpeakWord()<CR>
- nnoremap <Leader>tc :call SpeakCurrentLine()<CR>
- nnoremap <Leader>tp :call SpeakCurrentParagraph()<CR>
- nnoremap <Leader>tf :call SpeakCurrentFile()<CR>

# License
Same as Vim.
