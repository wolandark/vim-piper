# Vim Piper

A simple wrapper over the Piper text-to-speech system.

## Introduction

Vim Piper is a Vim plugin that integrates the Piper text-to-speech system into Vim. It allows you to easily convert text within Vim to speech using Piper.<br>
If you don't care about natural sounding tts, you can use [vim-espeak](https://github.com/wolandark/vim-espeak).

## Dependency 
This plugin depends on the following:
- piper-tts
- a piper voice
- aplay command from alsa-utils package (probably already installed)
- Vim or Neovim

# Getting piper
On Arch Linux, do the following:
```bash
yay -S piper-tts-bin piper-voices-en-us # or your language of choice
```
You may also find piper and it's voices in the repositories of other distros, if not, simply grab the pre-compiled binaries of piper from [here](https://github.com/rhasspy/piper/releases/tag/2023.11.14-2), and manually download your desired voices from [here](https://huggingface.co/rhasspy/piper-voices/tree/main).<br> Once the download is finished, you can refer to the [Configuration](#configuration) section of this README to find out out to setup vim-piper.

# Installation

## Using vim-plug

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
let g:piper_bin = '/usr/bin/piper-tts'
let g:piper_voice = '/usr/share/piper-voices/en/en_US/joe/medium/en_US-joe-medium.onnx'
```
So if you install piper-tts and piper-voices-en-us from AUR,  everything will work out of the box.

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
- vnoremap <Leader>tv :call SpeakVisualSelection()<CR>

# Demo
### SpeakWord()
https://github.com/user-attachments/assets/d34e58f5-a411-4f40-811a-c912afff0cae
### SpeakCurrentLine()
https://github.com/user-attachments/assets/b7a8db7a-a90f-4eb9-9108-8686d58cacbd
### SpeakCurrentParagraph()
https://github.com/user-attachments/assets/bad5ac11-7377-46a0-9e19-baab4b7ae8e6
### SpeakCurrentFile()
https://github.com/user-attachments/assets/6afc5a8c-5188-479a-af56-80a949e319a0
### SpeakVisualSelection()
https://github.com/user-attachments/assets/657173b3-8bb1-46fc-bc9c-67b49b608bf9

# License
Same as Vim.

# Enjoy!
