-module(week2_9).
-export([double/1, evens/1, median/1, mode/1]).

% double
double([]) -> 
    [];
double([X | Xs]) ->
    [X | [X | double(Xs)]].

% evens
evens([]) ->
    [];
evens([X | Xs]) when X rem 2 == 0 ->
    [X | evens(Xs)];
evens([_X | Xs]) ->
    evens(Xs).

% median
median(Xs) when length(Xs) rem 2 == 1 ->
   median(Xs, 1, (length(Xs) div 2) + 1);
median(Xs) ->
   (median(Xs, 1, (length(Xs) div 2) + 1) + median(Xs, 1, length(Xs) div 2)) div 2.

median([X | _Xs], CURR, FIND) when CURR == FIND ->
    X;
median([_X | Xs], CURR, FIND) ->
    median(Xs, CURR + 1, FIND).

%mode
mode([]) ->
    [];
mode(Xs) ->
    PAIR = groupEl(Xs, []),
    MAX = findMaxOccur(PAIR, 0),
    filter(PAIR, [], MAX).

%groupEl
groupEl([], ACCUM) ->
    ACCUM;
groupEl([X | Xs], ACCUM) ->
    groupEl(Xs, updateTuple(ACCUM, X)).

%updateTuple
updateTuple([], Num) ->
    [{Num, 1}];
updateTuple([X | Xs], Num) ->
    case X of
        {Num, Count} -> [{Num, Count + 1} | Xs];
        _ -> [X | updateTuple(Xs, Num)]
    end.
%find max occurrences
findMaxOccur([], MaxOccur) ->
    MaxOccur;
findMaxOccur([{_, Occur} | Xs], MaxOccur) ->
    case Occur > MaxOccur of
        true -> findMaxOccur(Xs, Occur);
        _ -> findMaxOccur(Xs, MaxOccur)
    end.

%filter
filter([], Accum, _) ->
    Accum;
filter([X | Xs], Accum, Occur) ->
    case X of 
        {Num, Occur} -> filter(Xs, [Num | Accum], Occur);
        _ -> filter(Xs, Accum, Occur)
    end.

