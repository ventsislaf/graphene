% GraphQL Lexer
%
% See the spec reference http://facebook.github.io/graphql/#sec-Appendix-Grammar-Summary
% The relevant version is also copied into this repo
%
% original version taken from: https://github.com/joshprice/graphql-elixir/blob/master/src/graphql_lexer.xrl

Definitions.

% Ignored tokens
WhiteSpace          = [\x{0009}\x{000B}\x{000C}\x{0020}\x{00A0}]
_LineTerminator     = \x{000A}\x{000D}\x{2028}\x{2029}
LineTerminator      = [{_LineTerminator}]
Comment             = #[^{_LineTerminator}]*
Comma               = ,
Ignored             = {WhiteSpace}|{LineTerminator}|{Comment}|{Comma}

% Lexical tokens
Punctuator          = [!$():=@\[\]{|}]|\.\.\.
Name                = [_A-Za-z][_0-9A-Za-z]*

% Int Value
Digit               = [0-9]
NonZeroDigit        = [1-9]
NegativeSign        = -
IntegerPart         = {NegativeSign}?(0|{NonZeroDigit}{Digit}*)
IntValue            = {IntegerPart}

% Float Value
FractionalPart      = \.{Digit}+
Sign                = [+\-]
ExponentIndicator   = [eE]
ExponentPart        = {ExponentIndicator}{Sign}?{Digit}+
FloatValue          = {IntegerPart}{FractionalPart}|{IntegerPart}{ExponentPart}|{IntegerPart}{FractionalPart}{ExponentPart}

% String Value
HexDigit            = [0-9A-Fa-f]
EscapedUnicode      = u{HexDigit}{HexDigit}{HexDigit}{HexDigit}
EscapedCharacter    = ["\\\/bfnrt]
StringCharacter     = ([^\"{_LineTerminator}]|\\{EscapedUnicode}|\\{EscapedCharacter})
StringValue         = "{StringCharacter}*"

% Boolean Value
BooleanValue        = true|false

% Reserved words
ReservedWord        = query|mutation|fragment|on|type|implements|interface|union|scalar|enum|input|extend|null

Rules.

{Ignored}           : skip_token.
{Punctuator}        : {token, {list_to_atom(TokenChars), TokenLine, nil}}.
{ReservedWord}      : {token, {list_to_atom(TokenChars), TokenLine, nil}}.
{IntValue}          : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{FloatValue}        : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{StringValue}       : {token, {string, TokenLine, list_to_binary(TokenChars)}}.
{BooleanValue}      : {token, {boolean, TokenLine, TokenChars == "true"}}.
{Name}              : {token, {name, TokenLine, list_to_binary(TokenChars)}}.

Erlang code.
