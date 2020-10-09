defmodule Cana.Validator do
  # parsec:Cana.Validator
  import NimbleParsec

  free_quote = utf8_char(empty(), [?"])
  escaped_quote = string(~S/\"/) |> replace("\"")
  escaped_space = string(~S/\ /) |> replace(" ")
  escaped_backslash = string(~S/\\/) |> replace("\\")
  escaped_at = string(~S/\@/) |> replace("@")
  at = string("@")
  dot = string(".")
  open_square = string("[")
  close_square = string("]")

  quoted_local =
    ignore(free_quote)
    |> utf8_string(
      [?a..?z, ?A..?Z, ?0..?9, ?\s, ?!, ?#..?/, ?=, ??, ?^, ?_, ?`, ?{, ?|, ?}, ?~, ?@],
      min: 1,
      max: 64
    )
    |> ignore(free_quote)

  unquoted_local =
    empty()
    |> utf8_string([not: ?.], 1)
    |> repeat(
      lookahead_not(string(".."))
      |> lookahead_not(string(".@"))
      |> choice([
        utf8_string([?a..?z, ?A..?Z, ?0..?9, ?!, ?#..?-, ?/, ?=, ??, ?^, ?_, ?`, ?{, ?|, ?}, ?~],
          min: 1,
          max: 64
        ),
        dot,
        escaped_quote,
        escaped_space,
        escaped_backslash,
        escaped_at
      ])
    )
    |> reduce({Enum, :join, [""]})

  local_part =
    choice([
      quoted_local,
      unquoted_local
    ])

  ip_address =
    optional(ignore(open_square))
    |> times(
      empty()
      |> utf8_string([?0..?9], max: 3)
      |> ignore(dot),
      3
    )
    |> utf8_string([?0..?9], max: 3)
    |> optional(ignore(close_square))
    |> reduce({Enum, :join, ["."]})

  domain_name =
    repeat(
      empty()
      |> lookahead_not(string("-"))
      |> utf8_string([?a..?z, ?A..?Z, ?0..?9, ?-], min: 1)
      |> optional(ignore(dot))
    )

  domain_part =
    choice([
      ip_address,
      domain_name
    ])

  defparsec :validate_email_address,
            local_part
            |> concat(at)
            |> concat(domain_part)

  # parsec:Cana.Validator
end
