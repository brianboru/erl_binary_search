%%%-------------------------------------------------------------------
%%% @author brian
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Nov 2015 9:11 AM
%%%-------------------------------------------------------------------
-module(binary_search_tests).
-author("brian").

-include_lib("eunit/include/eunit.hrl").

search__list_with_five_items__find_first_item_test() ->
  L = [1,2,3,4,5],
  {found, Number, Index} = binary_search:search(1, L),

  ?assertEqual(Number, 1),
  ?assertEqual(Index, 1).

search__list_with_five_items__find_middle_item_test() ->
  L = [1,2,3,4,5],
  {found, Number, Index} = binary_search:search(3, L),

  ?assertEqual(Number, 3),
  ?assertEqual(Index, 3).

search__list_with_five_items__find_last_item_test() ->
  L = [1,2,3,4,5],
  {found, Number, Index} = binary_search:search(5, L),

  ?assertEqual(Number, 5),
  ?assertEqual(Index, 5).

search__list_with_five_items__search_for_smaller_non_existing_item_test() ->
  L = [1,2,3,4,5],
  {notfound, Number} = binary_search:search(0, L),
  ?assertEqual(Number, 0).

search__list_with_five_items__search_for_larger_non_existing_item_test() ->
  L = [1,2,3,4,5],
  {notfound, Number} = binary_search:search(6, L),
  ?assertEqual(Number, 6).

search__list_with_eight_items__find_first_item_test() ->
  L = [1,2,3,4,5,6,7,8],
  {found, Number, Index} = binary_search:search(1, L),

  ?assertEqual(Number, 1),
  ?assertEqual(Index, 1).

search__list_with_eight_items__find_middle_item_test() ->
  L = [1,2,3,4,5,6,7,8],
  {found, Number, Index} = binary_search:search(4, L),

  ?assertEqual(Number, 4),
  ?assertEqual(Index, 4).

search__list_with_eight_items__find_last_item_test() ->
  L = [1,2,3,4,5,6,7,8],
  {found, Number, Index} = binary_search:search(8, L),

  ?assertEqual(Number, 8),
  ?assertEqual(Index, 8).

search__list_with_ten_thousand_items__find_first_item_test() ->
  L = lists:seq(1,10000),
  {found, Number, Index} = binary_search:search(1, L),

  ?assertEqual(Number, 1),
  ?assertEqual(Index, 1).

search__list_with_ten_thousand_items__find_middle_item_test() ->
  L = lists:seq(1,10000),
  {found, Number, Index} = binary_search:search(5000, L),

  ?assertEqual(Number, 5000),
  ?assertEqual(Index, 5000).

search__list_with_ten_thousand_items__find_even_item_test() ->
  L = lists:seq(1,10000),
  {found, Number, Index} = binary_search:search(2400, L),
  ?assertEqual(Number, 2400),
  ?assertEqual(Index, 2400).

search__list_with_ten_thousand_items__find_odd_item_test() ->
  L = lists:seq(1,10000),
  {found, Number, Index} = binary_search:search(2401, L),
  ?assertEqual(Number, 2401),
  ?assertEqual(Index, 2401).


search__list_with_ten_thousand_items__find_last_item_test() ->
  L = lists:seq(1,10000),
  {found, Number, Index} = binary_search:search(10000, L),
  ?assertEqual(Number, 10000),
  ?assertEqual(Index, 10000).

search__list_with_100K_items__find_item_test() ->
  L = lists:seq(1,100000),
  {found, Number, Index} = binary_search:search(99999, L),
  ?assertEqual(Number, 99999),
  ?assertEqual(Index, 99999).

search__list_with_100K_items__find_item_time_test() ->
  L = lists:seq(1,100000),
  NumSearches = 100,
  {Min, Max, Med, Avg } = profiler:test_avg(binary_search, search, [50000, L], NumSearches),
  ?debugFmt("== ~p Searches ==", [NumSearches]),
  ?debugFmt("== times are microseconds (1/1000th of millisecond)", []),
  ?debugFmt("== Min: ~p | Max: ~p | Med: ~p | Avg: ~p~n", [Min, Max, Med, Avg]).

