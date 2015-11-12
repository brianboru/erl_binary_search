%%%-------------------------------------------------------------------
%%% @author brian
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Nov 2015 2:51 PM
%%%-------------------------------------------------------------------
-module(simple_numeric_comparer_tests).
-author("brian").

-include_lib("eunit/include/eunit.hrl").

comparer__a_less_than_b__returns_less_than_zero_test() ->
  R = simple_numeric_comparer:comparer(1,2),
  ?assert(R < 0).

comparer__a_equal_to_b__returns_zero_test() ->
  R = simple_numeric_comparer:comparer(2,2),
  ?assert(R =:= 0).

comparer__a_greater_than_b__returns_more_than_zero_test() ->
  R = simple_numeric_comparer:comparer(2,1),
  ?assert(R > 0).

sorter__a_less_than_b__returns_true_test() ->
  ?assert(simple_numeric_comparer:sorter(1,2)).

sorter__a_equal_to_b__returns_true_test() ->
  ?assert(simple_numeric_comparer:sorter(2,2)).

sorter__a_greater_than_b__returns_false_test() ->
  ?assert(simple_numeric_comparer:sorter(2,1) =:= false).