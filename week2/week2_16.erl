-module(week2_16).
-export([polindrome/1]).

polindrome(Xs) ->
    polin(trans(Xs)).

polin(Xs) ->
    Xs == reverse(Xs).

% reverse([]) ->
%     [];
% reverse([X | Xs]) ->
%     reverse(Xs) ++ [X].
trans([]) ->
    [];
trans([X | Xs]) ->
    case lists:member(X, ".,\ ;:\t\n\'") of
        true -> trans(Xs);
        false -> [nocap(X) | trans(Xs)]
    end.

nocap(X) ->
    case $A=< X andalso X =< $Z of
        true -> X + 32;
        false -> X
    end.
reverse(Xs) ->
    shunt(Xs, []).

shunt([], Ys) ->
    Ys;
shunt([X | Xs], Ys) ->
    shunt(Xs, [X | Ys]).
    
