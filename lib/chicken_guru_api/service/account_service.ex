defmodule CG.Service.AccountService do
  use Helper.BaseService

  alias CG.Repository.Account

  def create(attr) do
    IO.inspect(attr)
    required_param(attr, "account")
    required_param(attr["account"], ["email", "password", "repassword"])

    Account.add(attr["account"])
  end
end
