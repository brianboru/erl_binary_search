%%%-------------------------------------------------------------------
%%% @author brian
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Nov 2015 9:06 AM
%%%-------------------------------------------------------------------
-module(binary_search).
-author("brian").

%% API
-export([search/2]).

%%%===================================================================
%%% API functions
%%%===================================================================
search(Number, List) ->
  Length = length(List),
  search_region(Number, 1, Length , List).


%%%===================================================================
%%% Internal functions
%%%===================================================================
search_region(Number, Start,End,List) when Start =< End ->

  MidPoint = find_midpoint(Start,End),
  ValueAtMidPoint = element_at_index(MidPoint, List),

  io:format("search region for ~p | Start ~p | End ~p~n",[Number, Start, End]),
  if
    ValueAtMidPoint < Number ->
      search_region(Number, MidPoint + 1, End, List);

    ValueAtMidPoint > Number ->
      search_region(Number, Start, MidPoint - 1, List);

    ValueAtMidPoint =:= Number ->
      {found, Number, MidPoint};

    true ->
      { notfound, Number}
  end;

search_region(Number, Start, End, _) when Start > End ->
  {notfound, Number}.

find_midpoint(Start, End) ->
  (Start + End) div 2.

element_at_index(Index, List) ->
  lists:nth(Index, List).


