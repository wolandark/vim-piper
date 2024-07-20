# Vim Piper

A simple wrapper over the Piper text-to-speech system.

## Introduction

Vim Piper is a Vim plugin that integrates the Piper text-to-speech system into Vim. It allows you to easily convert text within Vim to speech using Piper.

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

# License
Same as Vim.
