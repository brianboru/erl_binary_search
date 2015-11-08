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
-export([start_link/0,get_range_list/0,search/1,search2/1]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

-define(SERVER, ?MODULE).
-define(GET_RANGE_LIST, get_range_list).
-define(SEARCH, search).
-define(BINARY_SEARCH, binary_search).

-record(state, {numbers=[]}).

%%%===================================================================
%%% API
%%%===================================================================
get_range_list()  -> gen_server:call(?MODULE, {?GET_RANGE_LIST}).
search(Number)    -> gen_server:call(?MODULE, {?SEARCH, Number}).
search2(Number)   -> gen_server:call(?MODULE, {?BINARY_SEARCH, Number}).


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
  {ok, State :: #state{}} | {ok, State :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term()} | ignore).
init([]) ->
  List = lists:seq(0, 10000),
  {ok, #state{numbers=List}}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_call(Request :: term(), From :: {pid(), Tag :: term()},
    State :: #state{}) ->
  {reply, Reply :: term(), NewState :: #state{}} |
  {reply, Reply :: term(), NewState :: #state{}, timeout() | hibernate} |
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), Reply :: term(), NewState :: #state{}} |
  {stop, Reason :: term(), NewState :: #state{}}).

handle_call({?GET_RANGE_LIST}, _From, State) ->
  {reply, {get_list, State#state.numbers}, State};

handle_call({?SEARCH, Number}, _From, State) ->
  Result = search_list_for_number(Number, State#state.numbers),
  {reply, Result, State};

handle_call({?BINARY_SEARCH, Number}, _From, State) ->
  Result = binary_search(Number, State#state.numbers),
  {reply, Result, State}.


%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_cast(Request :: term(), State :: #state{}) ->
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #state{}}).
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
-spec(handle_info(Info :: timeout() | term(), State :: #state{}) ->
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #state{}}).
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
    State :: #state{}) -> term()).
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
-spec(code_change(OldVsn :: term() | {down, term()}, State :: #state{},
    Extra :: term()) ->
  {ok, NewState :: #state{}} | {error, Reason :: term()}).
code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
search_list_for_number(Number, List) ->
  Pred = fun(E) -> E =:= Number end,
  lists:filter(Pred, List).

binary_search(Number, List) ->
  Length = length(List),
  search_region(Number, 1, Length , List).



search_region(Number, Start,End,List) ->
  MidPoint = (Start + End) div 2,
  ValueAtMidPoint = lists:nth(MidPoint, List),

  io:format("search region for ~p | Start ~p | End ~p~n",[Number, Start, End]),
  if
    ValueAtMidPoint < Number ->
      search_region(Number, MidPoint, End, List);

    ValueAtMidPoint > Number ->
      search_region(Number, Start, MidPoint, List);

    ValueAtMidPoint =:= Number ->
      {found, Number, MidPoint};

    true ->
      { notfound, Number}
  end.
