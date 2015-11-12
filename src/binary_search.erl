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

-include("simple_numeric_list_header.hrl").

%%%===================================================================
%%% API functions
%%%===================================================================
search(Number, List) ->
  Length = length(List),
  search_region(Number, 1, Length , List, fun simple_numeric_comparer:comparer/2).

%%%===================================================================
%%% Internal functions
%%%===================================================================
search_region(Number, Start, End, List, Comparer) when Start =< End ->

  MidPoint = find_midpoint(Start,End),
  ValueAtMidPoint = element_at_index(MidPoint, List),

  % run the compare function
  CompareResult = Comparer(ValueAtMidPoint, Number),

  io:format("search region for ~p | Start ~p | End ~p~n",[Number, Start, End]),
  if
    CompareResult < 0 -> search_region(Number, MidPoint + 1, End, List, Comparer);
    CompareResult > 0 -> search_region(Number, Start, MidPoint - 1, List, Comparer);
    true              -> {found, Number, MidPoint}
  end;

search_region(Number, Start, End, _, _) when Start > End ->
  {notfound, Number}.

find_midpoint(Start, End) ->
  (Start + End) div 2.

element_at_index(Index, List) ->
  lists:nth(Index, List).




