# Cana

![License](https://img.shields.io/hexpm/l/cana) ![Hex.pm](https://img.shields.io/hexpm/v/cana)

Cana is a simple email address validator based on RFC3696, RFC5322, RFC5321,
Wikipedia and various other reading.

## Project goals

Cana is a small, single purpose library, only for email address validation.

## Installation

Add cana to your mix.exs.

```elixir
def deps do
  [
    {:cana, "~> 0.1.0"}
  ]
end
```

## Examples
```elixir
iex> Cana.validate_email_address("justin@progressiveaspect.com")
{:ok, %{domain: "progressiveaspect.com", local: "justin"}}

iex> Cana.validate_email_address("badad\"dress@badplace.com")
{:error, "expected string \"@\" at column: 5"}
```

## Benchmarks

Taken with a teaspoon of salt; test of 10000 items.
```
Operating System: Linux
CPU Information: Intel(R) Core(TM) i7-4771 CPU @ 3.50GHz
Number of Available Cores: 2
Available memory: 7.75 GB
Elixir 1.10.4
Erlang 23.0.3

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
parallel: 1
inputs: none specified
Estimated total run time: 14 s

Benchmarking invalid...
Benchmarking valid...

Name              ips        average  deviation         median         99th %
invalid         19.62       50.97 ms    ±13.79%       48.41 ms       91.28 ms
valid           10.76       92.94 ms    ±11.02%       88.66 ms      123.64 ms

Comparison: 
invalid         19.62
valid           10.76 - 1.82x slower +41.97 ms
```

## License
Copyright (c) 2020 Justin McPherson

This project is licensed under the terms of the MIT license, please see the
LICENCE.md file for more details.