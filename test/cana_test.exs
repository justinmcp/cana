defmodule CanaTest do
  use ExUnit.Case
  doctest Cana

  @valid_email_addresses [
    # https://en.wikipedia.org/wiki/Email_address#Examples
    {~S(simple@example.com), "simple", "example.com"},
    {~S(very.common@example.com), "very.common", "example.com"},
    {~S(disposable.style.email.with+symbol@example.com), "disposable.style.email.with+symbol",
     "example.com"},
    {~S(other.email-with-hyphen@example.com), "other.email-with-hyphen", "example.com"},
    {~S(fully-qualified-domain@example.com), "fully-qualified-domain", "example.com"},
    {~S(user.name+tag+sorting@example.com), "user.name+tag+sorting", "example.com"},
    {~S(x@example.com), "x", "example.com"},
    {~S(example-indeed@strange-example.com), "example-indeed", "strange-example.com"},
    {~S(admin@mailserver1), "admin", "mailserver1"},
    {~S(example@s.example), "example", "s.example"},
    {~S(" "@example.org), " ", "example.org"},
    {~S("john..doe"@example.org), "john..doe", "example.org"},
    {~S(mailhost!username@example.org), "mailhost!username", "example.org"},
    {~S(user%example.com@example.org), "user%example.com", "example.org"},

    # RFC3696
    {~S("Abc@def"@example.com), ~S(Abc@def), "example.com"},
    {~S(Abc\@def@example.com), ~S(Abc@def), "example.com"},
    {~S(Fred\ Blogs@example.com), ~S(Fred Blogs), "example.com"},
    {~S(Joe.\\Blow@example.com), ~S(Joe.\Blow), "example.com"},
    {~S(customer/department=shipping@example.com), "customer/department=shipping", "example.com"},
    {~S($A12345@example.com), "$A12345", "example.com"},
    {~S(!def!xyz%abc@example.com), "!def!xyz%abc", "example.com"},
    {~S(_somename@example.com), "_somename", "example.com"},

    # https://gist.github.com/cjaoude/fd9910626629b53c4d25
    {~S(email@example.com), "email", "example.com"},
    {~S(firstname.lastname@example.com), "firstname.lastname", "example.com"},
    {~S(email@subdomain.example.com), "email", "subdomain.example.com"},
    {~S(firstname+lastname@example.com), "firstname+lastname", "example.com"},
    {~S(email@123.123.123.123), "email", "123.123.123.123"},
    {~S(email@[123.123.123.123]), "email", "123.123.123.123"},
    {~S("email"@example.com), "email", "example.com"},
    {~S(1234567890@example.com), "1234567890", "example.com"},
    {~S(email@example-one.com), "email", "example-one.com"},
    {~S(_______@example.com), "_______", "example.com"},
    {~S(email@example.name), "email", "example.name"},
    {~S(email@example.museum), "email", "example.museum"},
    {~S(email@example.co.jp), "email", "example.co.jp"},
    {~S(firstname-lastname@example.com), "firstname-lastname", "example.com"}
    ## Seems these three are incorrect: the "dot-atom" and "quoted-string"
    ## forms are exclusive; RFC5322
    # {~S(much.”more\ unusual”@example.com), ~S(much.”more\ unusual”), "example.com"},
    # {~S(very.unusual.”@”.unusual.com@example.com), ~S(very.unusual.”@”.unusual.com), "example.com"},
    # {~S(very.”(),:;<>[]”.VERY.”very@\\ "very”.unusual@strange.example.com), ~S(very.”(),:;<>[]”.VERY.”very@\\ "very”.unusual@), "strange.example.com"}
  ]

  @invalid_email_addresses [
    # https://en.wikipedia.org/wiki/Email_address#Examples
    ~S(Abc.example.com),
    ~S(A@b@c@example.com),
    ~S(a"b(c\)d,e:f;g<h>i[j\k]l@example.com),
    ~S(just"not"right@example.com),
    ~S(this is"not\allowed@example.com),
    ## Seems this is incorrect: space, quote and backslash can be quoted by
    ## the backslash character; RFC3696
    # ~S(this\ still\"not\\allowed@example.com),
    ~S(1234567890123456789012345678901234567890123456789012345678901234+x@example.com),
    ~S(i_like_underscore@but_its_not_allow_in_this_part.example.com),

    # RFC3696
    ~S(john..doe@example.com),

    # https://gist.github.com/cjaoude/fd9910626629b53c4d25
    ~S(plainaddress),
    ~S(#@%^%#$@#$@#.com),
    ~S(@example.com),
    ~S(Joe Smith <email@example.com>),
    ~S(email.example.com),
    ~S(email@example@example.com),
    ~S(.email@example.com),
    ~S(email.@example.com),
    ~S(email..email@example.com),
    ~S(あいうえお@example.com),
    ~S[email@example.com (Joe Smith)],
    ## Out of scope; domain resolution is addressed in RFC5321, some
    ## suggestions on TLD verification in RFC3696
    # ~S(email@example),
    # ~S(email@example.web),
    ~S(email@-example.com),
    ~S(email@111.222.333.44444),
    ~S(email@example..com),
    ~S(Abc..123@example.com),
    ~S/”(),:;<>[\]@example.com/,
    ~S(just”not”right@example.com),
    ~S(this\ is"really"not\allowed@example.com),

    # Cana
    ~S(.john@example.com),
    ~S(john.@example.com),
    ~S(.john.@example.com)
  ]

  ##

  describe "ranges" do
    test "email address must be at least 6 characters" do
      assert {:error, "email address length (5) is outside of range 6..320"} =
               Cana.validate_email_address("a@b.c")
    end

    test "email address must be no more than 320 characters" do
      assert {:error, "email address length (321) is outside of range 6..320"} =
               Cana.validate_email_address(
                 ~s(#{String.duplicate("a", 63)}@#{String.duplicate("b", 63)}.#{
                   String.duplicate("c", 63)
                 }.#{String.duplicate("d", 63)}.#{String.duplicate("e", 62)}.au)
               )
    end

    test "local part must be no more than 64 characters" do
      assert {:error, "local part length(65) is outside the range 1..64"} =
               Cana.validate_email_address(~s(#{String.duplicate("a", 65)}@b.au))
    end

    test "domain part, labels must be no longer than 63 characters" do
      assert {:error, "domain label may not exceed 63 characters"} =
               Cana.validate_email_address(~s(a@#{String.duplicate("b", 64)}.au))
    end

    test "domain part must be no more than 255 characters" do
      assert {:error, "domain part length(256) is outside the range 4..255"} =
               Cana.validate_email_address(
                 ~s(#{String.duplicate("a", 63)}@#{String.duplicate("b", 63)}.#{
                   String.duplicate("c", 63)
                 }.#{String.duplicate("d", 63)}.#{String.duplicate("e", 61)}.au)
               )
    end
  end

  describe "examples" do
    test "success on valid email address" do
      @valid_email_addresses
      |> Enum.each(fn {address, local, domain} ->
        assert {:ok, %{local: ^local, domain: ^domain}} = Cana.validate_email_address(address)
      end)
    end

    test "failure on invalid address" do
      @invalid_email_addresses
      |> Enum.each(fn address ->
        assert {:error, _} = Cana.validate_email_address(address)
      end)
    end
  end

  describe "benchmarks" do
    @tag benchmark: true
    test "performance" do
      Benchee.run(%{
        "valid" => fn ->
          @valid_email_addresses
          |> Stream.cycle()
          |> Stream.take(10000)
          |> Enum.each(fn {address, _, _} ->
            Cana.validate_email_address(address)
          end)
        end,
        "invalid" => fn ->
          @invalid_email_addresses
          |> Stream.cycle()
          |> Stream.take(10000)
          |> Enum.each(fn address ->
            Cana.validate_email_address(address)
          end)
        end
      })
    end
  end
end
