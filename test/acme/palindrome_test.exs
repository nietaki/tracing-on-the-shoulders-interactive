defmodule Acme.PalindromeTest do
  use ExUnit.Case

  alias Acme.Palindrome

  doctest Palindrome

  test "Palindrome.is_palindrome? on a palindrome" do
    assert Palindrome.is_palindrome?("kayak")
  end

  test "Palindrome.is_palindrome? is case-insensitive do
  end" do
    assert Palindrome.is_palindrome?("Rotor")
  end

  test "Palindrome.is_palindrome? on a normal word" do
    refute Palindrome.is_palindrome?("catapult")
  end
end
