-module(week2_18).
-export([join/2, 
    concat/1, 
    member/2, 
    merge_sort/1, 
    quick_sort/1, 
    insert_sort/1, 
    perms/1
]).

% Joining lists together
join([], Ys) ->
    Ys;
join([X | Xs], Ys) ->
    [X | join(Xs, Ys)].

concat([]) ->
    [];
concat([Xs | Xss]) ->
    join(Xs, concat(Xss)).

% Testing membership
member(_N, []) ->
    false;
member(N, [N | _Xs]) ->
    true;
member(N, [_X | Xs ]) ->
    member(N, Xs).


% Sorting lists
% ##########################################################

% Merge sort ------------------------------------------------
merge_sort([]) ->
    [];
merge_sort([X]) ->
    [X];
merge_sort(Xs) ->
    L = length(Xs),
    {F, S} = split(L div 2, Xs),
    merge(merge_sort(F), merge_sort(S)).

merge([], Ys) ->
    Ys;
merge(Xs, []) ->
    Xs;
merge([X | Xs] = XS, [Y | Ys] = YS) ->
    case X =< Y of
        true -> [X | merge(Xs, YS)];
        false -> [Y | merge(XS, Ys)]
    end.

split(N, Xs) ->
    split(N, Xs, []).
split(_N, [], First) ->
    {First, []};
split(0, Xs, First) ->
    { First, Xs };
split(N, [X | Xs], First) ->
    split(N - 1, Xs, join(First, [X])).

% Quicksort sort ------------------------------------------------
quick_sort([]) ->
    [];
quick_sort([X | Xs]) ->
    quick_sort(filter(Xs, fun(Z) -> Z < X end)) ++ 
    [X] ++ 
    quick_sort(filter(Xs, fun(Z) -> Z >= X end)).


filter([], _F) ->
    [];
filter([X | Xs], F) ->
    case F(X) of    
        true -> [X | filter(Xs, F)];
        false -> filter(Xs, F)
    end.

% Insertion sort ------------------------------------------------
insert_sort(Xs) ->
    insert_sort(Xs, []).

insert_sort([], ACCUM) ->
    ACCUM;
insert_sort([X | Xs], ACCUM) ->
    insert_sort(Xs, insert(ACCUM, X)).

insert([], Y) ->
    [Y];
insert([X | Xs] = XS, Y) ->
    case Y =< X of  
        true -> [Y | XS];
        false -> [X | insert(Xs, Y)]
    end.

% Permutations
perms(Xs) ->
    perms(Xs, [[]]).
perms([], Accum) ->
    Accum;
perms([X | Xs], Accum) ->
    perms(Xs, flatMap(Accum, fun(Zs) -> insertMix(Zs, X) end)).

insertMix([], Y) ->
    [[Y]];
insertMix([X | Xs] = XS, Y) ->
    [[Y | XS] | map(insertMix(Xs, Y), fun(Zs) -> [X | Zs] end)].
   
map([], _F) ->
    [];
map([X | Xs], F) ->
    [F(X) | map(Xs, F)].
    
flatMap([], _F) ->
    [];
flatMap([X | Xs], F) ->
    F(X) ++ flatMap(Xs, F).