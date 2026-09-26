# Neovim keys

Everything mapped, plus the standard keys I want in reach. Vim is a full setup
in its own right, with fewer of the extras; where it differs is collected at
the end.

## Modes

Insert and replace:

| Key | Does |
| --- | --- |
| `i` `a` | enter insert mode before, after the cursor |
| `I` `A` | enter insert mode at the first non-blank, at the end of the line |
| `o` `O` | open a line below, above, and enter insert mode |
| `R` | enter replace mode — overwrite as you type |

Visual:

| Key | Does |
| --- | --- |
| `v` `V` `<C-v>` | enter visual mode — charwise, linewise, blockwise |
| `gv` | enter visual mode on the last selection |

Back to normal:

| Key | Does |
| --- | --- |
| `<Esc>` `<C-[>` `jk` | go back to normal mode |
| `<C-o>` | from insert mode, run one normal command and come back |

## Motions

Along the line:

| Key | Goes to |
| --- | --- |
| `h` `l` | left, right one character |
| `<Space>` | right one character, onto the next line at the end |
| `0` `^` | the start of the line, the first non-blank |
| `$` `g_` | the end of the line, the last non-blank |

By word:

| Key | Goes to |
| --- | --- |
| `w` `b` | the start of the next, previous word |
| `e` `ge` | the end of the next, previous word |
| `W` `B` `E` | the same, counting only whitespace as a separator |

Through the file:

| Key | Goes to |
| --- | --- |
| `j` `k` | down, up one line |
| `gg` `G` | the first, last line |
| `{count}gg` `{count}G` | line `{count}` |

By block:

| Key | Goes to |
| --- | --- |
| `{` `}` | the previous, next blank line |
| `%` | the matching bracket, or `#if` and `#endif` |

Within the window:

| Key | Goes to |
| --- | --- |
| `H` `M` `L` | the top, middle, bottom line on screen |

Scrolling:

| Key | Scrolls |
| --- | --- |
| `<C-e>` `<C-y>` | one line down, up |
| `<C-d>` `<C-u>` | half a screen down, up |
| `<C-f>` `<C-b>` | a full screen down, up |
| `zt` `zz` `zb` | the cursor line to the top, middle, bottom |

Going back:

| Key | Goes to |
| --- | --- |
| `<C-o>` `<C-i>` | an older, newer position in the jump list |
| `g;` `g,` | an older, newer position in the change list |
| `` `. `` | the position of the most recent change |

## Searching

Through the file:

| Key | Searches |
| --- | --- |
| `/` `?` | forward, backward for what you type |
| `*` `#` | forward, backward for the word under the cursor |
| `n` `N` | repeat the last search, same direction and reversed |

Along the line:

| Key | Searches |
| --- | --- |
| `f{char}` `F{char}` | forward, backward for `{char}` |
| `t{char}` `T{char}` | forward, backward, stopping one short of `{char}` |
| `;` `,` | repeat the last search, same direction and reversed |

Clearing the highlight:

| Key | Does |
| --- | --- |
| `<C-l>` | clear search highlighting, then redraw |

Search and replace:

| Command | Does |
| --- | --- |
| `:[range]s/{pattern}/{string}/[flags]` | replace matches with `{string}` |
| `:g/{pattern}/{command}` | run `{command}` on every matching line |
| `:v/{pattern}/{command}` | run `{command}` on every non-matching line |

The optional bracketed parts:

| Part | Is |
| --- | --- |
| `[range]` | `%` the whole file, `'<,'>` the visual selection |
| `[flags]` | `g` every match on the line, `c` confirm each |

An empty `{pattern}` reuses the last search, so `/{pattern}` to see what
matches, then `:%s//{string}/g`. `:g` and `:v` cover the whole file.

## Operators

| Operator | Does |
| --- | --- |
| `d` | delete |
| `c` | change — delete, then enter insert mode |
| `y` | yank |
| `gu` `gU` `g~` | lower, upper, toggle the case |
| `gc` | toggle comment |
| `gq` | format |
| `>` `<` `=` | indent, unindent, reindent |

An operator needs a motion or a text object after it — `de`, `cw`, `yl`, `dap`,
`gUiw`. Double it to act on the whole line — `dd`, `yy`, `gqq`, `gcc`.

Shortcut keys:

| Key | Same as |
| --- | --- |
| `D` `C` `Y` | `d$` `c$` `y$` |
| `S` | `cc` |
| `x` `s` | `dl` `cl` |
| `u` `U` `~` | `gu` `gU` `g~`, from visual mode |

## Text objects

Always preceded by an operator, or used from visual mode. Pressing one on its
own in normal mode does something else entirely.

| Object | Selects |
| --- | --- |
| `iw` | inner word — the word under the cursor |
| `aw` | a word — that word plus the whitespace after it |
| `ip` | inner paragraph — the block of lines up to a blank line |
| `ap` | a paragraph — that block plus the blank lines after it |
| `i(` `a(` | inside the parentheses, and including them |
| `i{` `a{` | inside the braces, and including them |
| `i[` `a[` | inside the square brackets, and including them |
| `i"` `i'` | inside the quotes |
| `ic` | inner class — the body of a class or struct, braces included |
| `ac` | a class — the whole class or struct |
| `if` | inner function — the body of a function, braces not included |
| `af` | a function — the whole function, signature included |

`ic` `ac` `if` `af` come from `nvim-treesitter-textobjects`, so a parser for
the language must be installed. The rest are builtin and work anywhere.

The cursor can be anywhere inside the object — anywhere in the word or
paragraph, anywhere between the brackets or quotes, anywhere in the class or
function. This is how they differ from motions, which always run from the
cursor position.

The treesitter objects go further: with `lookahead` enabled, the cursor can be
before the class or function and the object resolves to the next one.

## Pasting

| Key | Does |
| --- | --- |
| `p` `P` | paste after, before the cursor — or below, above the line for a whole-line yank |

Swapping:

| Keys | Does |
| --- | --- |
| `xp` | swap the character with the one after it |
| `ddp` | swap the line with the one below |
| `ddkP` | swap the line with the one above |

## Simple changes

| Key | Does |
| --- | --- |
| `r{char}` | replace the character under the cursor with `{char}` |
| `~` | toggle the case of the character under the cursor, then move right |
| `J` | join the line below onto this one, replacing its indent with a space |
| `gJ` | join the line below onto this one, exactly as it is |
| `<C-a>` `<C-x>` | increment, decrement the number under the cursor |

## Miscellaneous

| Key | Does |
| --- | --- |
| `gx` | open the URL under the cursor |
| `<F5>` | toggle spell checking |

## Undo

| Key | Does |
| --- | --- |
| `u` `<C-r>` | undo, redo |
| `g-` `g+` | go back, forward through the undo states in time order |

`u` and `<C-r>` walk one branch. Undo a few steps, then type something new, and
the branch you undid is still there — `<C-r>` can no longer reach it, `g-` can.

`undofile` is on, so all of this survives closing the file.

## Repeating

| Key | Does |
| --- | --- |
| `.` | repeat the last change |

Macros:

| Key | Does |
| --- | --- |
| `q{register}` | start recording into `{register}` — `q` again to stop |
| `@{register}` | play `{register}` back |
| `@@` | play back whichever was last played |
| `Q` | play back whichever was last recorded |

`@@` and `Q` differ on the first run after recording: `Q` works straight away,
`@@` has nothing to repeat until you have played something once.

## Windows

| Key | Does |
| --- | --- |
| `<C-w>s` `<C-w>v` | split horizontally, vertically |
| `<C-w>h` `<C-w>j` `<C-w>k` `<C-w>l` | go to the window left, below, above, right |
| `<C-w>w` | cycle to the next window |
| `<C-w>c` `<C-w>o` | close this window, every other window |
| `<C-w>H` `<C-w>J` `<C-w>K` `<C-w>L` | move this window to the far left, bottom, top, right |
| `<C-w>x` | exchange this window with the next |
| `<C-w>r` | rotate every window forwards |

`<C-w>H` and `<C-w>L` leave the window as a full-height vertical split,
`<C-w>J` and `<C-w>K` as a full-width horizontal split.

The control key (`ctrl`) can stay held for the lower case keys — `<C-w><C-h>`,
`<C-w><C-w>`, `<C-w><C-r>` and so on all work. Not `c` though: `<C-c>`
interrupts, so `<C-w><C-c>` prints the hint about exiting.

## Quickfix

A list of positions to step through, filled by anything that produces one —
`:vimgrep`, `:grep`, `:make`, or a picker.

| Key | Does |
| --- | --- |
| `[q` `]q` | jump to the previous, next entry |

Commands:

| Command | Does |
| --- | --- |
| `:copen` `:cclose` | open, close the quickfix window |
| `:cfirst` `:clast` | jump to the first, last entry |

The quickfix window is an ordinary buffer, so `j` and `k` move down and up the
list, and `<CR>` jumps to the entry under the cursor.

`[q` and `]q` are what save the window hopping: they move you through the list
from wherever you are, so the window can stay closed.

## Fuzzy finding

Every one opens a picker.

Files:

| Key | Lists |
| --- | --- |
| `<C-p>` | every file under the current directory, minus what git ignores |
| `<leader>f` | every file tracked by git |
| `<leader>F` | only the files git reports as changed — modified, staged or untracked |

Where you have been:

| Key | Lists |
| --- | --- |
| `<leader>b` | the open buffers |
| `<leader>h` | files edited recently, across sessions, in this directory |

Searching the text:

| Key | Searches |
| --- | --- |
| `<leader>s` | the whole project, re-running `ripgrep` as you type |
| `<leader>w` | the word under the cursor, or the selection from visual mode |

Searching lines already open:

| Key | Searches |
| --- | --- |
| `<leader>l` | lines in every loaded buffer |
| `<leader>L` | lines in this buffer |

Commit history:

| Key | Lists |
| --- | --- |
| `<leader>c` | every commit in the repository |
| `<leader>C` | every commit that touched this file, or these lines from visual mode |

The editor itself:

| Key | Lists |
| --- | --- |
| `<leader>t` | the help tags |
| `<leader><Tab>` | every key mapping, in every mode |

## LSP

Only active in a buffer a language server has attached to. Everything here asks
`clangd`, and most of it answers in a picker.

Going somewhere:

| Key | Goes to |
| --- | --- |
| `gd` | the definition |
| `gD` | the declaration |
| `gy` | the definition of the type, rather than of the symbol |
| `gri` | the implementations — virtual functions only |
| `grr` | every reference |

Finding symbols:

| Key | Finds |
| --- | --- |
| `gO` | every symbol in this file — no query, the complete outline |
| `<leader>S` | a symbol anywhere in the project — type to search the index |

Call and type hierarchy:

| Key | Goes to |
| --- | --- |
| `<leader>r` | the incoming calls — what calls this |
| `<leader>R` | the outgoing calls — what this calls |
| `<leader>z` | the base classes |
| `<leader>Z` | the derived classes |

These need the cursor on the **name** of a function or type. Anywhere else they
report nothing, which reads like an answer rather than a miss.

Coming back:

| Key | Does |
| --- | --- |
| `<C-t>` | an older position on the tag stack |

Everything in the three tables above goes on the tag stack.

Source and header:

| Key | Does |
| --- | --- |
| `<leader>i` | switch between the source and the header |

Diagnostics:

| Key | Does |
| --- | --- |
| `[d` `]d` | jump to the previous, next diagnostic in the buffer, showing the message |
| `[D` `]D` | the same, for the first and last diagnostic |
| `<C-w>d` | show the diagnostic under the cursor |
| `<leader>q` | every diagnostic in this buffer |

Reading:

| Key | Does |
| --- | --- |
| `K` | hover — the type, the signature, the doc comment |
| `<C-s>` | signature help, with the current parameter marked — from insert mode |

Changing:

| Key | Does |
| --- | --- |
| `grn` | rename the symbol, everywhere in the project |
| `gra` | code actions — the fix for a diagnostic, or a refactor |

`gra` also works from visual mode, and that is not the same list — the
refactors that need a range, like extracting a function or a variable, only
appear over a selection.

## Inside a picker

A picker is a list with a preview of the entry under the cursor; type to narrow
it. These keys work while one is open.

| Key | Does |
| --- | --- |
| `<C-j>` `<C-k>` or `<C-n>` `<C-p>` or `<Down>` `<Up>` | down, up one entry |
| `<Tab>` | add the entry to a multi-selection |
| `<M-a>` | toggle the selection on every entry |
| `<CR>` | open the entry, or the quickfix list if several are selected |
| `<M-q>` | send the selection to the quickfix list |
| `<C-s>` `<C-v>` | open in a horizontal, vertical split |
| `<C-f>` `<C-b>` | half a page down, up |
| `<C-u>` | clear what you have typed |
| `<S-Down>` `<S-Up>` | scroll the preview a full page down, up |
| `<C-/>` | toggle the preview |
| `<Esc>` `<C-z>` | abort |

Some keys exist only in particular pickers.

| Key | Picker | Does |
| --- | --- | --- |
| `<C-g>` | `<leader>s` `<leader>S` | toggle live query and fuzzy filter |
| `<Left>` `<Right>` | `<leader>F` | stage, unstage the file |
| `<C-x>` | `<leader>F` | discard the changes, or delete the file if untracked — asks first |
| `<C-d>` | `<leader>c` | show the files the commit changed |
| `<C-q>` | after `<C-d>` | back to the commit list |
| `<C-y>` | `<leader>c` `<leader>C` | yank the commit hash |

## Where Vim differs

Vim uses `coc.nvim` and `fzf.vim` rather than the Neovim LSP client and
`fzf-lua`, and Neovim has builtins Vim lacks. Only the differences worth
knowing are here.

Not there at all:

| Key | In Neovim |
| --- | --- |
| `Q` | playback of the last recorded macro |
| `gc` `gcc` | comment operator |
| `gO` `<leader>S` | symbol search |
| `[D` `]D` | first, last diagnostic |
| `<C-s>` | signature help |
| `<leader>r` `<leader>R` | call hierarchy |
| `<leader>z` `<leader>Z` | type hierarchy |

Behaves differently:

| Key | In Vim |
| --- | --- |
| `<C-t>` | works the same, but `coc.nvim` does not record LSP jumps to unwind |
| `<C-w>d` | opens a window on a `#define`, not the diagnostic |
| `<leader>s` | waits for an argument, rather than searching as you type |
| `<leader><Tab>` | lists one mode at a time, not every mode at once |

Moving around a picker is the same, since both editors run `fzf` underneath.
The keys that act on an entry come from each plugin, so those differ and are
not listed here.
