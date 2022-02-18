defmodule CG.Helpers.CryptoHelper do
  def hash(str), do: Base.encode16(:crypto.hash(:sha512, str))
end
