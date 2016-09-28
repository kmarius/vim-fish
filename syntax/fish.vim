if exists('b:current_syntax')
    finish
endif

syntax case match

syntax keyword fishKeyword begin function end and or
syntax keyword fishConditional if else switch
syntax keyword fishRepeat while for in
syntax keyword fishLabel case

syntax match fishComment /#.*/
syntax match fishSpecial /\\$/
syntax match fishSubscriptRange /\.\./ contained
syntax match fishIdentifierSubscript /\[\zs[^]]\+\ze\]/ contained contains=fishSubscriptRange
syntax match fishIdentifier /\$\+[[:alnum:]_]\+\%(\[[^]]\+\]\)*/ contains=fishIdentifierSubscript
syntax match fishEscapeQuote /\\['\\]/ contained
syntax match fishEscapeDQuote /\\["$\\]/ contained
syntax region fishString start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=fishEscapeQuote
syntax region fishString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=fishEscapeDQuote,fishIdentifier
syntax match fishCharacter /\v\\[abefnrtv *?~%#(){}\[\]<>&;"']|\\[xX][0-9a-f]{1,2}|\\o[0-7]{1,2}|\\u[0-9a-f]{1,4}|\\U[0-9a-f]{1,8}|\\c[a-z]/
syntax match fishStatement /[a-zA-Z0-9_-]\+/
syntax match fishCommandSub /(\s*\zs[a-zA-Z0-9_-]\+/

syntax region fishLineContinuation matchgroup=fishStatement
            \ start='[a-zA-Z0-9_-]\+' skip='\\$' end='$\|\ze[;|]'
            \ contains=fishSpecial,fishIdentifier,fishString,fishCharacter,fishCommandSub,fishComment

highlight default link fishKeyword Keyword
highlight default link fishConditional Conditional
highlight default link fishRepeat Repeat
highlight default link fishLabel Label
highlight default link fishComment Comment
highlight default link fishSpecial Special
highlight default link fishSubscriptRange Special
highlight default link fishIdentifier Identifier
highlight default link fishString String
highlight default link fishCharacter Special
highlight default link fishEscapeQuote Special
highlight default link fishEscapeDQuote Special
highlight default link fishStatement Statement
highlight default link fishCommandSub fishStatement

let b:current_syntax = 'fish'
