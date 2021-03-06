-module(assignment).
-export([perimeter/1, area/1, enclose/1, bits/1, tailVerBits/1]).

% auxiliary func 
getModuleOfVector({X1, Y1}, {X2, Y2}) ->
    math:sqrt(math:pow(X1-X2)+math:pow(Y1-Y2)).

% auxiliary func
getSidesOfTriangle({_, {AX,AY}, {BX,BY}, {CX,CY}}) ->
    AB = getModuleOfVector({AX,AY}, {BX,BY}),
    BC = getModuleOfVector({BX,BY}, {CX,CY}),
    AC = getModuleOfVector({AX,AY}, {CX,CY}),
    {AB, BC, AC}.

area({circle, _, R}) ->
    math:pi()*R*R;
area({rectangle, _, H,W}) ->
    H*W;
area({triangle, {AX,AY}, {BX,BY}, {CX,CY}}) ->
    {AB, BC, AC} = getSidesOfTriangle({triangle, {AX,AY}, {BX,BY}, {CX,CY}}),
    P = (AB+BC+AC) / 2,
    math:sqrt(P * (P-AB) * (P-BC) * (P-AC)).


perimeter({circle, _, R}) ->
    2*math:pi()*R;
perimeter({rectangle, _, H,W}) ->
    2*(H+W);
perimeter({triangle, {AX,AY}, {BX,BY}, {CX,CY}}) ->
    {AB, BC, AC} = getSidesOfTriangle({triangle, {AX,AY}, {BX,BY}, {CX,CY}}),
    AB+BC+AC.

enclose({circle, {X, Y}, R}) ->
    {rectangle, {X, Y}, 2*R, 2*R};
enclose({rectangle, {X,Y}, H, W}) ->
    % the smallest enclosing rectangle of a rectangle will be that rectangle
    {rectangle, {X,Y}, H, W};
enclose({triangle, {AX,AY}, {BX,BY}, {CX,CY}}) ->
    % points of the rectangle
    A = lists:max([AX, BX, CX]), 
    B = lists:min([AX, BX, CX]),
    C = lists:max([AY, BY, CY]),
    D = lists:min([AY, BY, CY]),
    % sides of the rectangle
    H = A - B,
    W = C - D,
    % centre of the rectangle
    X = (A + B) / 2,
    Y = (C + D) / 2,
    {rectangle, {X,Y}, H, W}. 

%direct recursion
bits(N) when N =< 0 ->
    0;
bits(N) when is_integer(N) ->
    (N rem 2) + bits(N div 2).

%auxiliary func
bitsLoop(0, ACCUM) ->
    ACCUM;
bitsLoop(CURR, ACCUM) ->
    bitsLoop((CURR div 2), (ACCUM + (CURR rem 2))).

%tail recursion
tailVerBits(N)  when is_integer(N), N >= 0 ->
    bitsLoop(N, 0).

