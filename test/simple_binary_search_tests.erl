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

simple_binary_search_test_() ->
{ setup, fun start/0, fun stop/1,
  { inorder,
    [
      fun get_ranges__after_init__returns_empty_list/0,
      fun set_ranges_after_init__does_set_server_state/0
    ]
  }
}.

start() ->
  simple_binary_search:start_link().

stop(_Args) ->
  ?debugFmt("stop called", []).

get_ranges__after_init__returns_empty_list() ->
  {ok, Ranges } = simple_binary_search:get_ranges(),
  ?assert(length(Ranges) =:= 0).

set_ranges_after_init__does_set_server_state() ->
  List = lists:seq(1,?NUMBER_OF_ITEMS),
  {ok} = simple_binary_search:set_ranges(List),
  {ok, Ranges} = simple_binary_search:get_ranges(),
  ?assert(length(Ranges) =:= ?NUMBER_OF_ITEMS).




%% create__after_init__list_is_empty_test() ->
%%   Pid = simple_binary_search:start_link(),
%%   {get_list, Ranges} = simple_binary_search:get_ranges(),
%%   gen_server:stop(Pid),
%%   ?assert(length(Ranges) =:= 0).

%% set_ranges__list_with_two_items__updates_gen_server_state_test() ->
%%   Pid = simple_binary_search:start_link(),
%%   {get_list, Ranges} = simple_binary_search:get_ranges(),
%%   ?assert(length(Ranges) =:= 0),
%%
%%   simple_binary_search:set_ranges([1,2]),
%%   ?assert(length(Ranges) =:= 2),
%%
%%   gen_server:stop(Pid).



%% binary_search_with_empty_list_yields_not_found() ->
%%   _Pid = simple_binary_search:start_link(),
%%   simple_binary_search:set_ranges([]).
%%   {Time, Result } = timer:tc(simple_binary_search, search, [5]),
%%   ?debugFmt("Result: ~p in ~p microseconds", [Result, Time]),
%%
%%   ?assert(Result =:= {not_found}).

%% binary_search_test() ->
%%   _Pid = simple_binary_search:start_link(),
%%   simple_binary_search:set_ranges(lists:seq(1,10000)),
%%
%%   profiler:test_avg()
%%   Result = simple_binary_search:search2(5),
%%   ?debugFmt("Result: ~p", [Result]),
%%   ?assert(true).
