-module(assignment).
-export([perimeter/1, area/1, enclose/1, bits/1]).

area({circle, _, R}) ->
    math:pi()*R*R;
area({rectangle, _, H,W}) ->
    H*W.

perimeter({circle, _, R}) ->
    2*math:pi()*R;
perimeter({rectangle, _, H,W}) ->
    2*(H+W).

