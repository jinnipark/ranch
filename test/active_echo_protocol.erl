-module(active_echo_protocol).
-behaviour(ranch_protocol).

-export([init/4]).

init(_Ref, Socket, Transport, _Opts = []) ->
	loop(Socket, Transport).

loop(Socket, Transport) ->
	{OK, Closed, Error} = Transport:messages(),
	Transport:setopts(Socket, [{active, once}]),
	receive
		{OK, Socket, Data} ->
			Transport:send(Socket, Data),
			loop(Socket, Transport);
		{Closed, Socket} ->
			ok;
		{Error, Socket, _} ->
			ok = Transport:close(Socket)
	end.
