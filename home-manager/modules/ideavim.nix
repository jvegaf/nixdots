{ ... }:

# AIDEV-NOTE: IdeaVim configuration for JetBrains IDEs
{
  home.file.".ideavimrc".text = ''
    " vim settings
    set scrolloff=5
    set history=1000

    " status bar
    set showmode

    " leader
    nnoremap <space> <nop>
    let mapleader=' '
    let maplocalleader=','

    set clipboard+=unnamedplus

    " Highlight copied text
    Plug 'machakann/vim-highlightedyank'
    " Commentary plugin
    Plug 'tpope/vim-commentary'
    " Surround
    Plug 'tpope/vim-surround'
    " Easymotion
    Plug 'easymotion/vim-easymotion'
    " Multiple cursors
    Plug 'terryma/vim-multiple-cursors'
    nmap <C-n> <Plug>NextWholeOccurrence
    xmap <C-n> <Plug>NextWholeOccurrence
    nmap g<C-n> <Plug>NextOccurrence
    xmap g<C-n> <Plug>NextOccurrence
    xmap <C-x> <Plug>SkipOccurrence
    xmap <C-p> <Plug>RemoveOccurrence
    nmap <leader><C-n> <Plug>AllWholeOccurrences
    xmap <leader><C-n> <Plug>AllWholeOccurrences
    nmap <leader>g<C-n> <Plug>AllOccurrences
    xmap <leader>g<C-n> <Plug>AllOccurrences

    set ReplaceWithRegister
    set hlsearch
    set incsearch
    set number relativenumber
    set exchange
    set mini-ai
    set ignorecase
    set smartcase
    set gdefault
    set ideajoin
    set ideamarks
    set idearefactormode=normal
    set ideastatusicon=gray
    set highlightedyank
    Plug 'preservim/nerdtree'
    Plug 'justinmk/vim-sneak'

    set vim-paragraph-motion
    set textobj-indent
    set textobj-entire
    set argtextobj
    nmap <leader>nh :noh<CR>

    " highlight yank
    let g:highlightedyank_highlight_duration = "1000"
    let g:highlightedyank_highlight_color = "rgba(57, 197, 187, 155)"

    let g:NERDTreeMapActivateNode="l"
    let g:NERDTreeMapCloseDir="h"
    nnoremap <leader>e :NERDTreeToggle<CR>

    map <leader>,cc <Action>(ChangeColorScheme)

    nnoremap vv V

    " better escape
    inoremap jj <Esc>

    " location
    nmap <C-o> <Action>(Back)
    nmap <C-]> <Action>(Forward)

    " buffer
    nmap Q <Action>(CloseContent)
    nmap W <Action>(SaveContent)
    nmap <leader>xa <Action>(CloseAllEditors)
    nmap <leader>xo <Action>(CloseAllEditorsButActive)
    nmap <leader>xp <Action>(CloseAllUnpinnedEditors)

    " window
    nmap H <Action>(PreviousTab)
    nmap L <Action>(NextTab)
    nmap <leader>p <Action>(PinActiveEditorTab)

    nmap <leader>1 <Action>(GoToTab1)
    nmap <leader>2 <Action>(GoToTab2)
    nmap <leader>3 <Action>(GoToTab3)
    nmap <leader>4 <Action>(GoToTab4)
    nmap <leader>5 <Action>(GoToTab5)
    nmap <leader>6 <Action>(GoToTab6)
    nmap <leader>7 <Action>(GoToTab7)
    nmap <leader>8 <Action>(GoToTab8)
    nmap <leader>9 <Action>(GoToTab9)

    " tab
    map <leader>sh <Action>(MoveTabLeft)
    map <leader>sj <Action>(MoveTabDown)
    map <leader>sk <Action>(MoveTabUp)
    map <leader>sl <Action>(MoveTabRight)
    map <leader>ss <Action>(SplitHorizontally)
    map <leader>vs <Action>(SplitVertically)

    nmap <C-p> <Action>(JumpToLastWindow)
    nmap <M-i> <Action>(PrevSplitter)
    nmap <M-o> <Action>(NextSplitter)
    nmap <C-k> <C-w>k
    nmap <C-j> <C-w>j
    nmap <C-h> <C-w>h
    nmap <C-l> <C-w>l

    nmap <leader>ww <Action>(HideAllWindows)
    nmap <leader>wk <Action>(StretchSplitToTop)
    nmap <leader>wj <Action>(StretchSplitToBottom)
    nmap <leader>wh <Action>(StretchSplitToLeft)
    nmap <leader>wl <Action>(StretchSplitToRight)
    nmap <leader>wm <Action>(MaximizeEditorInSplit)
    nmap <leader>wu <Action>(UnsplitAll)

    " menu
    nmap <leader>mm <Action>(MainMenu)
    nmap <leader>ma <Action>(AnalyzeMenu)
    nmap <leader>mb <Action>(BuildMenu)
    nmap <leader>mc <Action>(CodeMenu)
    nmap <leader>mf <Action>(FindMenuGroup)
    nmap <leader>mg <Action>(GoToMenu)
    nmap <leader>ms <Action>(ScopeViewPopupMenu)
    nmap <leader>mt <Action>(EditorTabPopupMenu)
    nmap <leader>mw <Action>(ToolWindowsGroup)
    nmap <C-m> <Action>(ShowPopupMenu)

    " file
    nmap <leader>of <Action>(OpenFile)
    nmap <leader>yp <Action>(CopyAbsolutePath)
    nmap <leader>rf <Action>(RecentFiles)
    nmap <leader>rl <Action>(RecentLocations)
    nmap <leader>rp <Action>(ManageRecentProjects)
    nmap <leader>sh <Action>(LocalHistory.ShowHistory)
    nmap <leader>sf <Action>(ShowFilePath)
    nmap <leader>si <Action>(SelectIn)
    nmap <leader>fp <Action>(FindInPath)
    nmap <leader>rp <Action>(ReplaceInPath)
    nmap <leader>sw <Action>($SearchWeb)

    " tag
    nmap <leader>fu <Action>(FindUsages)
    nmap <leader>fs <Action>(FileStructurePopup)
    nmap <leader>su <Action>(ShowUsages)
    nmap <leader>hl <Action>(HighlightUsagesInFile)
    nmap <leader>qp <Action>(QuickPreview)
    nmap <leader>qd <Action>(QuickDefinition)
    nmap <leader>qD <Action>(QuickTypeDefinition)

    " code
    nmap <leader>ca <Action>(ShowIntentionActions)
    nmap <leader>ce <Action>(ShowErrorDescription)
    nmap <leader>om <Action>(OverrideMethods)
    nmap <leader>im <Action>(ImplementMethods)
    nmap <leader>cf <Action>(ReformatCode)
    nmap <leader>ic <Action>(InspectCode)
    nmap <leader>so <Action>(SelectAllOccurrences)
    nmap <leader>gg <Action>(Generate)
    nmap <leader>gt <Action>(GoToTest)

    " Move lines
    nmap <A-j> :m .+1<CR>==
    nmap <A-k> :m .-2<CR>==
    vmap <A-j> :m '>+1<CR>gv=gv
    vmap <A-k> :m '<-2<CR>gv=gv

    " run
    nmap <leader>rc <Action>(ContextRun)
    nmap <leader>rx<Action>(chooseRunConfiguration)
    nmap <leader>rr <Action>(Rerun)
    nmap <leader>rt <Action>(RunTests)
    nmap <leader>rs <Action>(Stop)

    " debug
    nmap <leader>dc <Action>(ContextDebug)
    nmap <leader>dx <Action>(Debug)
    nmap <leader>db <Action>(ToggleLineBreakpoint)
    nmap <leader>de <Action>(EditBreakpoint)
    nmap <leader>dv <Action>(ViewBreakpoints)

    " build
    nmap <leader>bb <Action>(BuildMenu)

    " refactor
    nmap <leader>rn <Action>(RenameElement)
    xnoremap \\r <Action>(Refactorings.QuickListPopupAction)
    nmap <leader>uw <Action>(Unwrap)
    nmap <leader>sw <Action>(SurroundWith)
    nmap <leader>sd <Action>(SafeDelete)
    nmap <leader>oi <Action>(OptimizeImports)

    " hierarchy
    nmap <leader>hc <Action>(CallHierarchy)
    nmap <leader>hm <Action>(MethodHierarchy)
    nmap <leader>ht <Action>(TypeHierarchy)

    " zen
    nmap <leader>z <Action>(ToggleZenMode)

    " []
    nmap [b <Action>(PreviousTab)
    nmap ]b <Action>(NextTab)
    nmap [g <Action>(GotoPreviousError)
    nmap ]g <Action>(GotoNextError)
    nmap [u <Action>(GotoPrevElementUnderCaretUsage)
    nmap ]u <Action>(GotoNextElementUnderCaretUsage)
    nmap [o <Action>(PreviousOccurence)
    nmap ]o <Action>(NextOccurence)
    nmap [[ <Action>(MethodUp)
    nmap ]] <Action>(MethodDown)
    nmap [c <Action>(JumpToLastChange)
    nmap ]c <Action>(JumpToNextChange)

    " goto
    nmap <leader>a <Action>(GotoAction)
    nmap ga <Action>(GotoAction)
    nmap gc <Action>(GotoClass)
    nmap gf <Action>(GotoFile)
    nmap gs <Action>(GotoSymbol)
    nmap gt <Action>(GoToTest)
    nmap gT <Action>(TextSearchAction)
    nmap go <Action>(GotoSuperMethod)
    nmap gd <Action>(GotoDeclaration)
    nmap gD <Action>(GotoTypeDeclaration)
    nmap gi <Action>(GotoImplementation)
    nmap gI <Action>(QuickImplementations)
    nmap gn <Action>(ShowNavBar)

    " terminal
    nmap <leader>tt <Action>(ActivateTerminalToolWindow)
    nmap <leader>to <Action>(Terminal.OpenInTerminal)

    " bookmark
    nmap mm <Action>(ToggleBookmark)
    nmap ms <Action>(ShowBookmarks)

    " todo
    nmap <leader>td <Action>(ActivateTODOToolWindow)

    " task
    nmap <leader>tk <Action>(tasks.goto)

    " idea join
    nmap \\jl <Action>(EditorJoinLines)

    " gist
    nmap \\cg <Action>(Github.Create.Gist)

    " vcs
    nmap <leader>v <Action>(VcsGroups)

    " IdeaVim settings
    nmap \\v <Action>(VimActions)
    nmap <leader>ir <Action>(IdeaVim.ReloadVimRc.reload)
    map <ESC><ESC> :nohlsearch<CR>

    " Copilot
    nmap <leader>ac <Action>(copilot.chat.show)
    nmap <leader>ai <Action>(copilot.chat.inline)

    " translation
    nmap \\tt <Action>($ShowTranslationDialogAction)
    nmap \\ts <Action>($TranslateTextComponent)
    nmap \\ti <Action>($InclusiveTranslateAction)
    nmap \\te <Action>($ExclusiveTranslateAction)

    " string manipulate
    nmap <leader>sm <Action>(osmedile.intellij.stringmanip.PopupChoiceAction)

    " continuous shift
    vnoremap < <gv
    vnoremap > >gv

    vnoremap <Esc> <Esc>
    vnoremap p "_dP

    " alias
    nnoremap <C-a> ggVG"+y
  '';
}
