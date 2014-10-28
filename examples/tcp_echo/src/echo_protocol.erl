%% Feel free to use, reuse and abuse the code in this file.

-module(echo_protocol).
-behaviour(ranch_protocol).

-export([init/4]).

init(_Ref, Transport, Socket, _Opts) ->
	loop(Socket, Transport).

loop(Socket, Transport) ->
	case Transport:recv(Socket, 0, 5000) of
		{ok, Data} ->
			Transport:send(Socket, Data),
			loop(Socket, Transport);
		_ ->
			ok = Transport:close(Socket)
	end.
