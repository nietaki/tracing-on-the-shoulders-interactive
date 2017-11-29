defmodule Acme.Palindrome do

  @spec is_palindrome?(String.t) :: boolean
  def is_palindrome?(candidate) do
    reversed = String.reverse(candidate)
    String.downcase(reversed) == String.downcase(candidate)
  end
end
