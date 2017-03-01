-module(week2_18).
-export([join/2, concat/1, member/2, split/2]).

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
% merge_sort([]) ->
%     [];
% merge_sort([X]) ->
%     [X];
% merge_sort(XS) ->
%     {}

split(N, Xs) ->
    split(N, Xs, []).
split(_N, [], First) ->
    {First, []};
split(0, Xs, First) ->
    { First, Xs };
split(N, [X | Xs], First) ->
    split(N - 1, Xs, join(First, [X])).