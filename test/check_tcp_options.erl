-module(check_tcp_options).
-behaviour(ranch_protocol).

-export([init/4]).

init(_, Socket, _, [{pid, TestPid}|TcpOptions]) ->
  {ok, TcpOptions} =
    inet:getopts(Socket, [Key || {Key, _} <- TcpOptions]),
	TestPid ! checked,
	receive after 2500 -> ok end.
