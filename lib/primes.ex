defmodule RustNif.ElixirPrimes do
  def prime_numbers(numbers) do
    prime_numbers(numbers, [])
  end

  defp prime_numbers([], result) do
    {:ok, result |> Enum.reverse()}
  end

  defp prime_numbers([number | rest], result) do
    new_result = result |> add_if_prime_number(number)

    prime_numbers(rest, new_result)
  end

  defp add_if_prime_number(numbers, 1), do: numbers
  defp add_if_prime_number(numbers, 2), do: [2 | numbers]

  defp add_if_prime_number(numbers, n) do
    range = 2..(n - 1)

    case Enum.any?(range, fn x -> rem(n, x) == 0 end) do
      false -> [n | numbers]
      _ -> numbers
    end
  end
end

defmodule RustNif.RustPrimes do
  use Rustler, otp_app: :rust_nif, crate: :rustprimes

  def prime_numbers(_nums), do: :erlang.nif_error(:nif_not_loaded)
end
