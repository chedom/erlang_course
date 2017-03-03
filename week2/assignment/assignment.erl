-module(assignment).
-export([getIndexes/1, compareTwoWords/2]).
-import(index, [get_file_contents/1]).

getIndexes(FileName) ->
    NormalizedLines = normalizeLines(processAllText(get_file_contents(FileName))),
    quick_sort(fun({W, _}) -> W end, makeIndexes(NormalizedLines, [])).


makeIndexes([], Accum) ->
    Accum;
makeIndexes([{ _Num, Ys } | Xs] = Lines, Accum) ->
    case Ys of
        [] -> makeIndexes(Xs, Accum);
        [Z | _Zs] ->
            FindedLines = findLines(Lines, Z),
            NewLines = deleteWordFromLines(Lines, Z, FindedLines),
            makeIndexes(NewLines, Accum ++ [{Z, listToRange(FindedLines)}])
    end.





processAllText(Xs) ->
    map(fun processLine/1, Xs).

processLine(Xs) ->
    filter(splitWords(map(fun nocap/1, Xs)), fun(X) -> length(X) > 2 end).


splitWords(Str) ->
    splitWords(Str, [], []).
splitWords([], Accum, Temp) ->
    filter(Accum ++ [Temp], fun(X) -> X /= [] end);
splitWords([C | Cs], Accum, Temp) ->
    case checkCorrectChar(C) of
        true -> splitWords(Cs, Accum, Temp ++ [C]);
        false -> splitWords(Cs, Accum ++ [Temp], [])
    end.

checkCorrectChar(C) ->
    (($A =< C) and (C =< $Z)) orelse (($a =< C) and (C =< $z)).

normalizeLines(Xs) ->
    normalizeLines(Xs, [], 1).
normalizeLines([], Accum, _Num) ->
    Accum;
normalizeLines([X | Xs], Accum, Num) ->
    normalizeLines(Xs, Accum ++ [{Num, X}], Num + 1).

findLines([], _Y) ->
    [];
findLines([ {Num, Zs} | Xs], Y) ->
    case member(Zs, Y) of   
        true -> [Num | findLines(Xs, Y)];
        false -> findLines(Xs, Y)
    end.

deleteWordFromLines(AllLines, Word, LinesForDel) ->
    map(
        fun({Num, Xs} = Line) ->
            case member(LinesForDel, Num) of    
                true -> {Num, filter(Xs, fun(Zs) -> Zs /= Word end)};
                false -> Line
            end
        end,
        AllLines
    ).

compareTwoWords(First, Second) ->
    Diffs = getDiff(First, Second),
    Pattern = ["ing", "ed", "s", "es", "ies"],
    Coincidence = flatMap(fun(X) -> filter(Pattern, fun(Z) -> compareDiffWithPat(X, Z) end) end, Diffs),
    Coincidence.
    
    
compareDiffWithPat(Diff, Pattern) ->
    ActualDiff = getLastN(Diff, length(Pattern)),
    io:write(ActualDiff),
    ActualDiff == Pattern.

getDiff([], Ys) ->
    [Ys];
getDiff(Xs, []) ->
    [Xs];
getDiff([Z | Xs], [Z | Ys]) ->
    getDiff(Xs, Ys);
getDiff(Xs, Ys) ->
    [Xs, Ys].

listToRange([]) ->
    [];
listToRange([X | Xs]) ->
    listToRange(quick_sort(fun(Z) -> Z end , Xs), [], {X, X}).
listToRange([], Accum, Temp) ->
    Accum ++ [Temp];
listToRange([X | Xs], Accum, {Start, End} = Range) ->
    case (End + 1) == X of
        true -> listToRange(Xs, Accum, {Start, X});
        false -> listToRange(Xs, Accum ++ [Range], {X, X})
    end.

% Quicksort sort ------------------------------------------------
quick_sort(_F, []) ->
    [];
quick_sort(F, [X | Xs]) ->
    quick_sort(F, filter(Xs, fun(Z) -> F(Z) < F(X) end)) ++ 
    [X] ++ 
    quick_sort(F, filter(Xs, fun(Z) -> F(Z) >= F(X) end)).

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

map(_F, []) ->
    [];
map(F, [X | Xs]) ->
    [F(X) | map(F, Xs)].

flatMap(_F, []) ->
    [];
flatMap(F, [X | Xs]) ->
    F(X) ++ flatMap(F, Xs).

member([], _X) ->
    false;
member([X | _Xs], X) ->
    true;
member([_Y | Xs], X) ->
    member(Xs, X).

reverse(Xs) ->
    shunt(Xs, []).

shunt([], Ys) ->
    Ys;
shunt([X | Xs], Ys) ->
    shunt(Xs, [X | Ys]).

getLastN(Xs, N) ->
    getFirstN(reverse(Xs), N).   

getFirstN([], _N) ->
    [];
getFirstN(_Xs, 0) ->
    [];
getFirstN([X | Xs], N) ->
    [X | getFirstN(Xs, N - 1)].

dropLastN(Xs, N) ->
    reverse(dropFirstN(reverse(Xs), N)).

dropFirstN([], _N) ->
    [];
dropFirstN(Xs, 0) ->
    Xs;
dropFirstN([X | Xs], N) ->
    dropFirstN(Xs, N - 1).
