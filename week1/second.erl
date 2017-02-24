-module(second).
-export([getGypLen/2, getTriangleArea/2, getTrianglePerim/2]).

getGypLen(X, Y) ->
    math:sqrt(first:square(X) + first:square(Y)).

getTriangleArea(X, Y) ->
    first:mult(0.5, first:mult(X, Y)).

getTrianglePerim(X, Y) ->
    X + Y + getGypLen(X,Y).



