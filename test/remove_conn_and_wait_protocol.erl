-module(remove_conn_and_wait_protocol).
-behaviour(ranch_protocol).

-export([init/4]).

init(Ref, _Socket, _Transport, [{remove, MaybeRemove}]) ->
	case MaybeRemove of
		true ->
			ranch:remove_connection(Ref);
		false ->
			ok
	end,
	receive after 2500 -> ok end.
