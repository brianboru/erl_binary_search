%%%-------------------------------------------------------------------
%%% @author brian
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Nov 2015 12:07 AM
%%%-------------------------------------------------------------------
-module(issuer_comparer).
-author("brian").

-include("definitions.hrl").

%% API
-export([sorter/2, comparer/2]).

sorter(A, B) ->
  if
    A#issuer_range.low =< B#issuer_range.high -> true;
    true                                      -> false
  end.

comparer(Range, Number) ->
  if
    (Range#issuer_range.low =< Number#issuer_range.low) and (Range#issuer_range.high >= Number#issuer_range.high) -> 0;
    Range#issuer_range.high < Number#issuer_range.low -> -1;
    Range#issuer_range.low > Number#issuer_range.low -> 1
  end.