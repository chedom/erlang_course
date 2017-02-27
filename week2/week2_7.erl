-module(week2_7).
-export([total_area/1, circles/1]).

all_areas([]) -> [];
all_areas([X | Xs]) -> [area(X) | all_areas(Xs)].
total_area(Xs) ->
    sum(all_areas(Xs)).

circles([])     -> [] ; 

circles( [X | Xs] ) ->
    case X of
	{circle,{_,_},_}=C ->
	    [ C | circles(Xs) ];
	_ ->
	    circles(Xs)
end.

area({circle, _, R}) ->
    math:pi()*R*R;
area({rectangle, _, H,W}) ->
    H*W.

sum(Xs) -> sum(Xs, 0).

sum([], ACCUM) -> ACCUM;
sum([X | Xs], ACCUM) -> sum(Xs, ACCUM + X).