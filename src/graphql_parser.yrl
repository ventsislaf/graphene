Terminals '{' '}' ':' ',' name.
Nonterminals query_def query queries query projections names.

Rootsymbol query_def.

query_def     -> '{' queries '}'            : [{query_def, '$2'}].

queries       -> query                      : ['$1'].
queries       -> query queries              : ['$1'|'$2'].

query         -> name '{' names '}'         : {query, #{ name => value('$1'), alias => value('$1'), filters => [], projections => '$3'}}.

names         -> name                       : [value('$1')].
names         -> name names                 : [value('$1') | '$2'].

Erlang code.

value({_Token, _TokenLine, Value}) -> Value.
