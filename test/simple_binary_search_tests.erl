%%%-------------------------------------------------------------------
%%% @author brian
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 08. Nov 2015 10:20 PM
%%%-------------------------------------------------------------------
-module(simple_binary_search_tests).
-author("brian").

-include_lib("eunit/include/eunit.hrl").

-define(NUMBER_OF_ITEMS,100000).

simple_binary_search_tes() ->
 { setup, fun() -> start() end, fun stop/1,
   { inorder,
     [
       fun get_ranges__after_init__returns_empty_list/0,
       fun set_ranges_after_init__does_set_server_state/0
     ]
   }
 }.

binary_search_performance_tes() ->
  { setup, fun() -> start() end, fun stop/1,
    { inorder,
      [
        fun get_ranges__after_init__returns_empty_list/0,
        fun set_ranges_after_init__does_set_server_state/0,
        fun binary_search_performance/0
      ]
    }
  }.

start() ->
  simple_binary_search:start(simple_binary_search).

stop(_) ->
  simple_binary_search:stop(simple_binary_search).

get_ranges__after_init__returns_empty_list() ->
  {ok, Ranges } = simple_binary_search:get_ranges(),
  ?assert(length(Ranges) =:= 0).

set_ranges_after_init__does_set_server_state() ->
  List = lists:seq(1,?NUMBER_OF_ITEMS),
  {ok} = simple_binary_search:set_ranges(List),
  {ok, Ranges} = simple_binary_search:get_ranges(),
  ?assert(length(Ranges) =:= ?NUMBER_OF_ITEMS).

binary_search_performance() ->
  NumberOfIterations = 1000,
  {Min, Max, _, Avg } =
    profiler:test_avg(simple_binary_search, binary_search, [50000], NumberOfIterations),
  ?debugFmt("~p searches took an average of ~p mics with a min time of ~p mics and a max of ~p mics",
    [NumberOfIterations, Avg, Min, Max]).





