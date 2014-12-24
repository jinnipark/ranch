-module(echo_protocol).
-behaviour(ranch_protocol).

-export([init/4]).

init(_Ref, Socket, Transport, _Opts = []) ->
	loop(Socket, Transport).

loop(Socket, Transport) ->
	case Transport:recv(Socket, 0, 5000) of
		{ok, Data} ->
			Transport:send(Socket, Data),
			loop(Socket, Transport);
		_ ->
			ok = Transport:close(Socket)
	end.
