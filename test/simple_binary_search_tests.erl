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

search_test() ->
  _Pid = simple_binary_search:start_link(),
  {Time, Result } = timer:tc(simple_binary_search, search, [5]),
  ?debugFmt("Result: ~p in ~p microseconds", [Result, Time]),

  ?assert(true).

%% search2_test() ->
%%   _Pid = simple_binary_search:start_link(),
%%   Result = simple_binary_search:search2(5),
%%   ?debugFmt("Result: ~p", [Result]),
%%   ?assert(true).
