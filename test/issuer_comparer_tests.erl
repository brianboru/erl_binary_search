%%%-------------------------------------------------------------------
%%% @author brian
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Nov 2015 12:08 AM
%%%-------------------------------------------------------------------
-module(issuer_comparer_tests).
-author("brian").

-include_lib("eunit/include/eunit.hrl").
-include("definitions.hrl").

sorter__with_four_entries__sorts_ascending_test() ->
  Ranges =
    [#issuer_range{ low=45, high=49, country = 372, currency = 978}] ++
    [#issuer_range{ low=40, high=44, country = 372, currency = 978}] ++
    [#issuer_range{ low=55, high=58, country = 372, currency = 978}] ++
    [#issuer_range{ low=50, high=54, country = 372, currency = 978}],

  SortedRanges = lists:sort(fun issuer_comparer:sorter/2, Ranges),

  {issuer_range, L1, H1, _, _} = lists:nth(1, SortedRanges),
  {issuer_range, L2, H2, _, _} = lists:nth(2, SortedRanges),
  {issuer_range, L3, H3, _, _} = lists:nth(3, SortedRanges),
  {issuer_range, L4, H4, _, _} = lists:nth(4, SortedRanges),

  ?assert((L1 =:= 40) and (H1 =:= 44)),
  ?assert((L2 =:= 45) and (H2 =:= 49)),
  ?assert((L3 =:= 50) and (H3 =:= 54)),
  ?assert((L4 =:= 55) and (H4 =:= 58)).

comparer__range_smaller_than_number__returns_minus_one_test() ->
  Range = #issuer_range{ low=40, high=44, country = 372, currency = 978},
  Number = #issuer_range{ low=45, high=45},

  Result = issuer_comparer:comparer(Range, Number),
  ?assert(Result =:= -1).

comparer__range_bigger_than_number__returns_one_test() ->
  Range = #issuer_range{ low=40, high=44, country = 372, currency = 978},
  Number = #issuer_range{ low=39, high=39},

  Result = issuer_comparer:comparer(Range, Number),
  ?assert(Result =:= 1).

comparer__range_surrounds_number__returns_zero_test() ->
  Range = #issuer_range{ low=40, high=44, country = 372, currency = 978},
  Number = #issuer_range{ low=42, high=42},

  Result = issuer_comparer:comparer(Range, Number),
  ?assert(Result =:= 0).



