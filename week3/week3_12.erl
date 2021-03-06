-module(week3_12).
-export([
    play/1,
    echo/1,
    play_two/3,
    rock/1,
    no_repeat/1,
    enum/1,
    cycle/1,
    rand/1,
    val/1,
    tournament/2,
    groupChoices/1,
    leastFreaq/1,
    mostFreaq/1,
    randomStrategy/1,
    getChoices/3,
    getResultForStrategy/2,
    bestStrategy/1
]).


%
% play one strategy against another, for N moves.
%

play_two(StrategyL,StrategyR,N) ->
    play_two(StrategyL, StrategyR, [], [], N).

% tail recursive loop for play_two/3
% 0 case computes the result of the tournament

% FOR YOU TO DEFINE
% REPLACE THE dummy DEFINITIONS

play_two(_Strategy1, _Strategy2, Moves1, Moves2, 0) ->
    Result = tournament(Moves1, Moves2),
    io:format("Result: ~p~n",[Result]);
play_two(Strategy1, Strategy2, Moves1, Moves2, N) ->
    NewMoves1 = [Strategy1(Moves2) | Moves1],
    NewMoves2 = [Strategy2(Moves1) | Moves2],
    play_two(Strategy1, Strategy2, NewMoves1, NewMoves2, N - 1).

%
% interactively play against a strategy, provided as argument.
%

play(Strategy) ->
    io:format("Rock - paper - scissors~n"),
    io:format("Play one of rock, paper, scissors, ...~n"),
    io:format("... r, p, s, stop, followed by '.'~n"),
    play(Strategy,[], []).

% tail recursive loop for play/1

play(Strategy,MovesL, MovesR) ->
    {ok,P} = io:read("Play: "),
    PlayL = expand(P),
    case PlayL of
	stop ->
	    io:format("Stopped~n"),
        Total = tournament(MovesL, MovesR),
        io:format("Total: ~p~n",[Total]);
	_    ->
        PlayR = Strategy(MovesL),
	    Result = result(PlayL,PlayR),
	    io:format("Result: ~p~n",[Result]),
	    play(Strategy,[PlayL|MovesL], [PlayR | MovesR])
    end.

%
% auxiliary functions
%

% transform shorthand atoms to expanded form
    
expand(r) -> rock;
expand(p) -> paper;		    
expand(s) -> scissors;
expand(X) -> X.

% result of one set of plays

result(rock,rock) -> draw;
result(rock,paper) -> lose;
result(rock,scissors) -> win;
result(paper,rock) -> win;
result(paper,paper) -> draw;
result(paper,scissors) -> lose;
result(scissors,rock) -> lose;
result(scissors,paper) -> win;
result(scissors,scissors) -> draw.

% result of a tournament

tournament(PlaysL,PlaysR) ->
    lists:sum(
      lists:map(fun outcome/1,
		lists:zipwith(fun result/2,PlaysL,PlaysR))).

outcome(win)  ->  1;
outcome(lose) -> -1;
outcome(draw) ->  0.

% transform 0, 1, 2 to rock, paper, scissors and vice versa.

enum(0) ->
    rock;
enum(1) ->
    paper;
enum(2) ->
    scissors.

val(rock) ->
    0;
val(paper) ->
    1;
val(scissors) ->
    2.

% give the play which the argument beats.

beats(rock) ->
    scissors;
beats(paper) ->
    rock;
beats(scissors) ->
    paper.

lose(rock) ->
    paper;
lose(paper) ->
    scissors;
lose(scissors) ->
    rock.

%
% strategies.
%
echo([]) ->
     paper;
echo([Last|_]) ->
    Last.

rock(_) ->
    rock.



% FOR YOU TO DEFINE
% REPLACE THE dummy DEFINITIONS

no_repeat([]) ->
    paper;
no_repeat([X|_]) ->
    beats(X).

cycle(Xs) ->
    enum(length(Xs) rem 3).

rand(_) ->
    enum(rand:uniform(3) - 1).

leastFreaq([]) ->
    paper;
leastFreaq(Xs) ->
    [{Choice, _N} | _ZS] = getMin(Xs),
    lose(Choice).

mostFreaq([]) ->
    paper;
mostFreaq(Xs) ->
    [{Choice, _N} | _ZS] = getMax(Xs),
    lose(Choice).

randomStrategy(Xs) ->
    Strategies = [
        fun echo/1 , 
        fun rock/1, 
        fun no_repeat/1,  
        fun cycle/1,
        fun rand/1,
        fun leastFreaq/1,
        fun mostFreaq/1
    ],
    ChosenStrat = lists:nth(rand:uniform(length(Strategies)), Strategies),
    ChosenStrat(Xs).

bestStrategy(Xs) ->
    Strategies = [
        fun echo/1 , 
        fun rock/1, 
        fun no_repeat/1,  
        fun cycle/1,
        fun rand/1,
        fun leastFreaq/1,
        fun mostFreaq/1
    ],
    SortedStrategiesResults = lists:keysort(2, lists:map(fun(F) -> getResultForStrategy(F, Xs) end, Strategies)),
    {BestStrategy, _} = lists:last(SortedStrategiesResults),
    BestStrategy(Xs).

getResultForStrategy(Strategy, Xs) ->
    Rev = lists:reverse(Xs),
    {Strategy, tournament(Rev, getChoices(Strategy, Rev, []))}.

getChoices(_F, [], _Explored) ->
    [];
getChoices(F, [X | Xs], Explored) ->
   [F([X | Explored]) | getChoices(F, Xs, [X | Explored])].

groupChoices(Xs) ->
    lists:foldl(fun insert/2, [], Xs).

insert(X, Accum) ->
    Exist = lists:filter(fun({Choice, _}) -> Choice == X end, Accum),
    case Exist of
        [] -> [{X, 1} | Accum];
        [{Choice, N}] -> [{Choice, N + 1} | lists:delete({Choice, N}, Accum)]
    end.

getMin(Xs) ->
    lists:sort(fun({_, N1}, {_, N2}) -> N1 < N2 end, groupChoices(Xs)).

getMax(Xs) ->
    lists:sort(fun({_, N1}, {_, N2}) -> N1 > N2 end, groupChoices(Xs)).