%%%-------------------------------------------------------------------
%%% @author brian
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Nov 2015 2:50 PM
%%%-------------------------------------------------------------------
-module(simple_numeric_comparer).
-author("brian").

%% API
-export([comparer/2, sorter/2]).

comparer(Number1, Number2) ->
  if
    Number1 < Number2 -> -1;
    Number1 > Number2 -> 1;
    true              -> 0
  end.

sorter(Number1, Number2) ->
  if
    Number1 =< Number2  -> true;
    true                -> false
  end.
