-module(notify_and_wait_protocol).
-behaviour(ranch_protocol).

-export([init/4]).

init(_, _, _, [{msg, Msg}, {pid, TestPid}]) ->
	TestPid ! Msg,
	receive after 2500 -> ok end.
