defmodule Helper do
  @doc """

  """
  def boolean_to_integer(val), do: if(val, do: 1, else: 0)

  @spec string_to_int(nil | binary | integer) :: integer
  def string_to_int(nil), do: 0
  def string_to_int(val) when is_binary(val), do: String.to_integer(val)
  def string_to_int(val) when is_integer(val), do: val

  @doc """
  генерирует новый токен в диапазоне от 100_000 до 2_000_000
  Bibl.get_token/0
  """
  def get_token(), do: Enum.random(1..1000)

  @spec money_to_decimal(Map.t()) :: Decimal.t()
  @doc """
  Переводит тип %Ptfd.Money{bills: "integer", coins: "integer"} в decimal
  """
  def money_to_decimal(%{bills: bills, coins: coins}), do: Decimal.from_float(bills + coins / 100)

  def digit_add_zero(digit) do
    if digit < 10 do
      "0" <> Integer.to_string(digit)
    else
      Integer.to_string(digit)
    end
  end

  def human_money(money) do
    cond do
      is_integer(money) ->
        :erlang.float_to_binary(money / 100, decimals: 2)

      is_map(money) ->
        to_string(money.bills) <> "." <> digit_add_zero(money.coins)

      true ->
        "0.00"
    end
  end

  @spec now_naive_date_time :: NaiveDateTime.t()
  def now_naive_date_time(), do: NaiveDateTime.from_erl!(:calendar.local_time())

  @doc """
  Переводит текущее время в тип %{day: xday, month: xmonth, year: xyear}
  """
  def now_date() do
    {{xyear, xmonth, xday}, _} = :calendar.local_time()
    %{day: xday, month: xmonth, year: xyear}
  end

  def now_string_date() do
    {{year, month, day}, _} = :calendar.local_time()

    xmonth_str = "#{if(month < 10, do: "0#{month}", else: month)}"
    xday_str = "#{if(day < 10, do: "0#{day}", else: day)}"

    "#{xday_str}.#{xmonth_str}.#{year}"
  end

  def human_date_from_timestamp(stamp) do
    {{year, month, day}, _} = NaiveDateTime.to_erl(stamp)
    "#{day} #{name_month_by_num(month)} #{year}"
  end

  def human_date(stamp) do
    {{year, month, day}, _} = NaiveDateTime.to_erl(stamp)
    "#{day}.#{month}.#{year}"
  end

  def human_datetime_from_timestamp(stamp) do
    {{year, month, day}, {hour, minute, second}} = NaiveDateTime.to_erl(stamp)
    "#{day}.#{month}.#{year} #{hour}:#{minute}:#{second}"
  end

  def human_datetime_from_timestamp2(stamp) do
    {{year, month, day}, {hour, minute, second}} = NaiveDateTime.to_erl(stamp)
    m = if month < 10, do: "0#{month}", else: "#{month}"
    d = if day < 10, do: "0#{day}", else: "#{day}"
    h = if hour < 10, do: "0#{hour}", else: "#{hour}"
    mn = if minute < 10, do: "0#{minute}", else: "#{minute}"
    s = if second < 10, do: "0#{second}", else: "#{second}"
    "#{year}-#{m}-#{d} #{h}:#{mn}:#{s}"
  end

  def human_address(address) do
    if address["street"] == nil do
      " " <> address.street <> ", д. " <> address.home <> ", " <> address.flat
    else
      " " <> address["street"] <> ", д. " <> address["home"] <> ", " <> address["flat"]
    end
  end

  @doc """
  Переводит %Ptfd.DateTime в тип NaiveDateTime
  """
  def ptfd_dt_to_ndt(dt) do
    %{year: year, month: month, day: day, hour: hour, minute: minute, second: second} = dt.date

    NaiveDateTime.new!(year, month, day, hour, minute, second)
  end

  @doc """
  функция возвращает текущую локальную дату в формате "2019-05-16T15:43:35.079+06:00"
  """
  def get_dt_utc do
    {{year, month, day}, {hour, minute, second}} = :calendar.local_time()
    {:ok, date_time} = NaiveDateTime.new(year, month, day, hour, minute, second)

    "#{NaiveDateTime.to_iso8601(date_time)}.000+06:00"
  end

  def get_date_utc do
    {{year, month, day}, {hour, minute, second}} = :calendar.local_time()
    {:ok, date_time} = NaiveDateTime.new(year, month, day, hour, minute, second)

    "#{NaiveDateTime.to_date(date_time) |> Date.to_string()}+06:00"
  end

  @doc """
  извлекает значение тега - tag из xml
  возвращает nil, если тег не найден или строку
  """
  def get_tag_value_from_xml(xml, tag) do
    open_tag = "<#{tag}>"
    close_tag = "</#{tag}>"
    # проверяем наличие открывающего тега
    if String.match?(xml, ~r/#{open_tag}/) and String.match?(xml, ~r/#{close_tag}/) do
      [_one, two] = String.split(xml, open_tag, parts: 2)
      [value, _] = String.split(two, close_tag, parts: 2)
      {:ok, value}
    else
      {:error, nil}
    end
  end

  def name_month_by_num(1), do: "января"
  def name_month_by_num(2), do: "ферваля"
  def name_month_by_num(3), do: "марта"
  def name_month_by_num(4), do: "апреля"
  def name_month_by_num(5), do: "мая"
  def name_month_by_num(6), do: "июня"
  def name_month_by_num(7), do: "июля"
  def name_month_by_num(8), do: "августа"
  def name_month_by_num(9), do: "сентября"
  def name_month_by_num(10), do: "октября"
  def name_month_by_num(11), do: "ноября"
  def name_month_by_num(12), do: "декабря"
  def name_month_by_num(num) when is_binary(num), do: name_month_by_num(String.to_integer(num))

  def get_short_account_number(val) do
    case Application.get_env(:ofd_models, :owner) do
      :ttc -> to_string(string_to_int(val) - 99_000_000_000)
      :bee -> string_to_int(val)
    end
  end

  ##############################################################################
  # Сравнивает две erlang даты с точностью до минут(без секунд).
  def yymmdd_hhmm_tuples_equal?(yymmdd_hhmmss1, yymmdd_hhmmss2) do
    {{yy1, mm1, dd1}, {ho1, mi1, _se1}} = yymmdd_hhmmss1
    {{yy2, mm2, dd2}, {ho2, mi2, _se2}} = yymmdd_hhmmss2
    yy1 == yy2 and mm1 == mm2 and dd1 == dd2 and ho1 == ho2 and mi1 == mi2
  end

  def get_uri_map(parms) do
    # %{
    #   "f" => "620300138818",
    #   "i" => "1274059104",
    #   "s" => "25750.0",
    #   "t" => "20190306T162950"
    # }
    map1 = URI.decode_query(parms)

    map = %{
      date_time: str_time_to_tuple_date_time(map1["t"]),
      fiscal_mark: map1["i"],
      state_number: nil,
      sum: str_float_to_tuple_int(map1["s"])
    }

    if Map.has_key?(map1, "f"), do: Map.put(map, :state_number, map1["f"]), else: map
  end

  def str_float_to_tuple_int(str) do
    lstr = String.split(str, ".")

    {String.to_integer(hd(lstr)), String.to_integer(hd(tl(lstr)))}
  end

  def str_time_to_tuple_date_time(str) do
    <<y::binary-size(4)>> <>
      <<m::binary-size(2)>> <>
      <<d::binary-size(2)>> <>
      <<_t::binary-size(1)>> <>
      <<h::binary-size(2)>> <>
      <<min::binary-size(2)>> <>
      <<_sec::binary-size(2)>> = str

    {{String.to_integer(y), String.to_integer(m), String.to_integer(d)},
     {String.to_integer(h), String.to_integer(min), 0}}
  end

  def phone_number_format(phone_number) do
    String.replace(phone_number, " ", "")
    |> String.replace("+7", "")
    |> String.replace("(", "")
    |> String.replace(")", "")
    |> String.replace("-", "")
  end

  def convert_map_keys_from_string_to_atom(param) do
    Enum.reduce(param, %{}, fn {key, val}, acc ->
      first = String.first(key) |> String.downcase()
      new_key = first <> String.slice(key, 1..String.length(key))

      new_val =
        cond do
          is_map(val) -> convert_map_keys_from_string_to_atom(val)
          is_list(val) -> Enum.map(val, fn item -> convert_map_keys_from_string_to_atom(item) end)
          true -> val
        end

      Map.put(acc, String.to_atom(new_key), new_val)
    end)
  end

  @doc """
  Преобразует JSON структуру в map
  """
  def ani_struct_to_map(any_struct) do
    Enum.reduce(any_struct, %{}, fn {key, val}, acc ->
      new_val =
        cond do
          is_map(val) -> ani_struct_to_map(val)
          is_list(val) -> Enum.map(val, fn y -> ani_struct_to_map(y) end)
          true -> val
        end

      first = String.first(key) |> String.downcase()
      new_key = first <> String.slice(key, 1..String.length(key))

      Map.put(acc, String.to_atom(new_key), new_val)
    end)
  end

  def normalize_map(map) when is_map(map) do
    Map.new(map, fn {key, val} ->
      {
        if(is_atom(key), do: key, else: String.to_atom(key)),
        if(is_map(val) or is_list(val), do: normalize_map(val), else: val)
      }
    end)
  end

  def normalize_map(list) when is_list(list),
    do: Enum.map(list, fn item -> normalize_map(item) end)

  # Archive tables related functions
  def date_to_month_str(date),
    do: "#{date.year}_#{if(date.month < 10, do: "0#{date.month}", else: date.month)}"

  @spec archive_table_name(binary, map() | binary) :: any
  def archive_table_name(tablename, date) when is_binary(date) do
    y = string_to_int(String.slice(date, 0, 4))
    m = string_to_int(String.slice(date, 4, 2))
    d = Date.new!(y, m, 1)
    archive_table_name(tablename, d)
  end

  def archive_table_name(tablename, date) when is_map(date) do
    no_archive = not Application.get_env(:ofd_models, :use_archive_tables)
    cur = now_date()

    if no_archive or (cur.year <= date.year and cur.month <= date.month) do
      tablename
    else
      "#{tablename}_#{date_to_month_str(date)}"
    end
  end

  @doc """
  period :: {yyyy, mm}
  """
  def period_tuple_to_string({year, month}) do
    to_string(year) <> if month < 10, do: "0" <> to_string(month), else: to_string(month)
  end

  def date_to_table_name(table, %{year: year, month: month}) do
    now = now_date()

    if year >= now.year and month >= now.month do
      table
    else
      "#{table}_#{year}_#{if month < 10, do: "0#{month}", else: "#{month}"}"
    end
  end

  def table_names_list(table, start_date, end_date) do
    no_archive = not Application.get_env(:ofd_models, :use_archive_tables)

    if no_archive do
      [table]
    else
      start_date =
        if Map.has_key?(start_date, :hour),
          do: NaiveDateTime.to_date(start_date),
          else: start_date

      end_date =
        if Map.has_key?(end_date, :hour), do: NaiveDateTime.to_date(end_date), else: end_date

      start_d = start_date |> Date.end_of_month()
      end_d = end_date |> Date.end_of_month()

      if start_d.year == end_d.year and start_d.month == end_d.month do
        [date_to_table_name(table, start_d)]
      else
        table_names_list(table, start_d, end_d, [date_to_table_name(table, start_d)])
      end
    end
  end

  # if today is May 2021, then current month table - "tickets" should be added to the list,
  # because archive table "tickets_2021_05" doesn't exist yet
  defp table_names_list(table, start_date, end_date, acc) do
    next_date = Date.add(start_date, 1) |> Date.end_of_month()
    now = now_date()

    if next_date.year >= now.year and next_date.month >= now.month do
      acc ++ [table]
    else
      if next_date.year >= end_date.year and next_date.month >= end_date.month do
        acc ++ [date_to_table_name(table, next_date)]
      else
        table_names_list(
          table,
          next_date,
          end_date,
          acc ++ [date_to_table_name(table, next_date)]
        )
      end
    end
  end

  def is_valid_date(date) do
    if is_nil(date) and not is_map(date) and is_nil(date.year) and is_nil(date.month) do
      false
    else
      true
    end
  end

  def get_next_month_date(date) do
    NaiveDateTime.new!(Date.add(Date.end_of_month(date), 1), Time.new!(0, 0, 0))
  end

  def sql_table_name(period, type) when is_nil(period) or period == "" do
    case type do
      :ticket -> "tickets"
      :report -> "shifts"
    end
  end

  def service_id(type) do
    case type do
      :report -> "IbdOfdZReportActual"
      :ticket -> "IbdOfdcheckActual"
    end
  end
end
