inputs = %{
  "small list" => Enum.to_list(1..100),
  "medium list" => Enum.to_list(1..1_000),
  "large list" => Enum.to_list(1..10_000),
  "jumbo list" => Enum.to_list(1..100_000)
}

Benchee.run(
  %{
    "elixir_native" => fn list -> RustNif.ElixirPrimes.prime_numbers(list) end,
    "rust_nif" => fn list -> RustNif.RustPrimes.prime_numbers(list) end
  },
  inputs: inputs
)
