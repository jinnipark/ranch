-module(trap_exit_protocol).
-behaviour(ranch_protocol).

-export([init/4]).

init(_Ref, Socket, Transport, _Opts = []) ->
	process_flag(trap_exit, true),
	loop(Socket, Transport).

loop(Socket, Transport) ->
	case Transport:recv(Socket, 0, infinity) of
		{ok, Data} ->
			Transport:send(Socket, Data),
			loop(Socket, Transport);
		_ ->
			ok = Transport:close(Socket)
	end.
