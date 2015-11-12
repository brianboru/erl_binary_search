%%%-------------------------------------------------------------------
%%% @author brian
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Nov 2015 11:29 PM
%%%-------------------------------------------------------------------
-module(simple_binary_search).
-author("brian").

-behaviour(gen_server).

%% API
-export([start_link/0, start/1, stop/1, get_ranges/0, set_ranges/1, search/1,binary_search/1]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).


%%%===================================================================
%%% Macro definitions for api functions
%%%===================================================================
-define(SERVER, ?MODULE).
-define(SEARCH, search).
-define(BINARY_SEARCH, binary_search).
-define(GET_RANGE, get_range).
-define(SET_RANGE, set_range).

%%%===================================================================
%%% Module API
%%%===================================================================
-record(range_list, {numbers=[]}).

%%%===================================================================
%%% Module API
%%%===================================================================
get_ranges()            -> gen_server:call(?MODULE, {?GET_RANGE}).
set_ranges(List)        -> gen_server:call(?MODULE, {?SET_RANGE, List}).
search(Number)          -> gen_server:call(?MODULE, {?SEARCH, Number}).
binary_search(Number)   -> gen_server:call(?MODULE, {?BINARY_SEARCH, Number}).


%%--------------------------------------------------------------------
%% @doc
%% Starts the server
%%
%% @end
%%--------------------------------------------------------------------
-spec(start_link() ->
  {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%%--------------------------------------------------------------------
%% @doc
%% Starts the gen server as standalone with the Name specified
%% @end
%%--------------------------------------------------------------------
-spec(start(Name :: term()) ->
  {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start(Name) ->
  gen_server:start({local, Name}, ?MODULE, [], []).

%%--------------------------------------------------------------------
%% @doc
%% Stops the standalone gen server with the specified Name
%% @end
%%--------------------------------------------------------------------
-spec(stop(Name :: term()) ->
  {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
stop(Name) ->
  gen_server:cast(Name, stop).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%% @end
%%--------------------------------------------------------------------
-spec(init(Args :: term()) ->
  {ok, State :: #range_list{}} | {ok, State :: #range_list{}, timeout() | hibernate} |
  {stop, Reason :: term()} | ignore).
init([]) ->
  {ok, #range_list{numbers=[]}}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_call(Request :: term(), From :: {pid(), Tag :: term()},
    State :: #range_list{}) ->
  {reply, Reply :: term(), NewState :: #range_list{}} |
  {reply, Reply :: term(), NewState :: #range_list{}, timeout() | hibernate} |
  {noreply, NewState :: #range_list{}} |
  {noreply, NewState :: #range_list{}, timeout() | hibernate} |
  {stop, Reason :: term(), Reply :: term(), NewState :: #range_list{}} |
  {stop, Reason :: term(), NewState :: #range_list{}}).

handle_call({?GET_RANGE}, _From, State) ->
  {reply, {ok, State#range_list.numbers}, State};

handle_call({?SET_RANGE, List}, _From, _State) ->
  {reply, {ok}, #range_list{numbers=List}};

handle_call({?SEARCH, Number}, _From, State) ->
  Result = search_list_for_number(Number, State#range_list.numbers),
  {reply, Result, State};

handle_call({?BINARY_SEARCH, Number}, _From, State) ->
  Result = binary_search_for_number(Number, State#range_list.numbers),
  {reply, Result, State}.


%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_cast(Request :: term(), State :: #range_list{}) ->
  {noreply, NewState :: #range_list{}} |
  {noreply, NewState :: #range_list{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #range_list{}}).
handle_cast(stop, State) ->
  {stop, normal, State};

handle_cast(_Request, State) ->
  {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
-spec(handle_info(Info :: timeout() | term(), State :: #range_list{}) ->
  {noreply, NewState :: #range_list{}} |
  {noreply, NewState :: #range_list{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #range_list{}}).
handle_info(_Info, State) ->
  {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end
%%--------------------------------------------------------------------
-spec(terminate(Reason :: (normal | shutdown | {shutdown, term()} | term()),
    State :: #range_list{}) -> term()).
terminate(_Reason, _State) ->
  ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end
%%--------------------------------------------------------------------
-spec(code_change(OldVsn :: term() | {down, term()}, State :: #range_list{},
    Extra :: term()) ->
  {ok, NewState :: #range_list{}} | {error, Reason :: term()}).
code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
search_list_for_number(Number, List) ->
  Pred = fun(E) -> E =:= Number end,
  lists:filter(Pred, List).

binary_search_for_number(Number, List) ->
  Length = length(List),
  search_region(Number, 1, Length , List).



search_region(Number, Start,End,List) ->
  MidPoint = (Start + End) div 2,
  ValueAtMidPoint = lists:nth(MidPoint, List),

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
  end.
