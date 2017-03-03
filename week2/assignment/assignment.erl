-module(assignment).
-export([test1/0, test2/0, listToRange/1, processAllText/1]).
-import(index, [get_file_contents/1]).

test1() ->
    findLines(transformLines(processAllText(get_file_contents("dickens-christmas.txt"))), "have").

test2() ->
    get_file_contents("dickens-christmas.txt").

processAllText(Xs) ->
    map(fun processLine/1, Xs).

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

last([]) ->
    badarg;
last([X]) ->
    X;
last([_X | Xs]) ->
    last(Xs).

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

transformLines(Xs) ->
    transformLines(Xs, [], 1).
transformLines([], Accum, _Num) ->
    Accum;
transformLines([X | Xs], Accum, Num) ->
    transformLines(Xs, Accum ++ [{Num, X}], Num + 1).

findLines([], _Y) ->
    [];
findLines([ {Num, Zs} | Xs], Y) ->
    case member(Zs, Y) of   
        true -> [Num | findLines(Xs, Y)];
        false -> findLines(Xs, Y)
    end.

listToRange([]) ->
    [];
listToRange([X | Xs]) ->
    listToRange(quick_sort(Xs), [], {X, X}).
listToRange([], Accum, Temp) ->
    Accum ++ [Temp];
listToRange([X | Xs], Accum, {Start, End} = Range) ->
    case (End + 1) == X of
        true -> listToRange(Xs, Accum, {Start, X});
        false -> listToRange(Xs, Accum ++ [Range], {X, X})
    end.

% Quicksort sort ------------------------------------------------
quick_sort([]) ->
    [];
quick_sort([X | Xs]) ->
    quick_sort(filter(Xs, fun(Z) -> Z < X end)) ++ 
    [X] ++ 
    quick_sort(filter(Xs, fun(Z) -> Z >= X end)).
