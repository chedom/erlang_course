-module(assignment).
-export([test1/0, test2/0, processLine/1, processAllText/1]).
-import(index, [get_file_contents/1]).

test1() ->
    processAllText(get_file_contents("dickens-christmas.txt")).

test2() ->
    get_file_contents("dickens-christmas.txt").

processAllText(Xs) ->
    filter(map(fun processLine/1, Xs), fun(X) -> X /= [] end).

processLine(Xs) ->
    filter(splitWords(map(fun nocap/1, Xs)), fun(X) -> length(X) > 2 end).

flatMap(_F, []) ->
    [];
flatMap(F, [X | Xs]) ->
    F(X) ++ flatMap(Xs, F).

map(_F, []) ->
    [];
map(F, [X | Xs]) ->
    [F(X) | map(F, Xs)].

member([], _X) ->
    false;
member([X | _Xs], X) ->
    true;
member([_Y | Xs], X) ->
    member(Xs, X).

splitWords(Str) ->
    splitWords(Str, [], []).
splitWords([], Accum, Temp) ->
    filter(Accum ++ [Temp], fun(X) -> X /= [] end);
splitWords([C | Cs], Accum, Temp) ->
    case $A =< C andalso  C =< $z of
        true -> splitWords(Cs, Accum, Temp ++ [C]);
        false -> splitWords(Cs, Accum ++ [Temp], [])
    end.

nocap(X) ->
    case $A=< X andalso X =< $Z of
        true -> X + 32;
        false -> X
    end.

filter([], _F) ->
    [];
filter([X | Xs], F) ->
    case F(X) of 
        true -> [X | filter(Xs, F)];
        false -> filter(Xs, F)
    end.
