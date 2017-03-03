-module(assignment).
-export([test/0, splitWords/1]).
-import(index, [get_file_contents/1]).

test() ->
    get_file_contents("index.erl").

flatMap([], _F) ->
    [];
flatMap([X | Xs], F) ->
    F(X) ++ flatMap(Xs, F).

member([], _X) ->
    false;
member([X | _Xs], X) ->
    true;
member([_Y | Xs], X) ->
    member(Xs, X).


splitWords(Str) ->
    splitWords(Str, [], []).
splitWords([], Accum, Temp) ->
    compact(Accum ++ [Temp]);
splitWords([C | Cs], Accum, Temp) ->
    case member(".,\ ;:\t\n\'-", C) of
        true -> splitWords(Cs, Accum ++ [Temp], []);
        false -> splitWords(Cs, Accum, Temp ++ [C])
    end.

compact([]) ->
    [];
compact([X | Xs]) ->
    case member([[], ""], X) of
        true -> compact(Xs);
        false -> [X | compact(Xs)]
    end.