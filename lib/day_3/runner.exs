alias AdventOfCode2024.Day3

prompt_1 = ~S"mul(123,456)"
prompt_2 = ~S"xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
prompt_3 = ~S"xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

Day3.parse_prompt(prompt_1) |> IO.inspect(label: "prompt_1")

Day3.parse_prompt_with_operation(prompt_1)
|> IO.inspect(label: "parse_prompt_with_operation_1")

Day3.parse_prompt(prompt_2) |> IO.inspect(label: "prompt_2")

Day3.parse_prompt_with_operation(prompt_2)
|> IO.inspect(label: "parse_prompt_with_operation_2")

Day3.parse_prompt(prompt_3) |> IO.inspect(label: "prompt_3")

Day3.parse_prompt_with_operation(prompt_3)
|> IO.inspect(label: "parse_prompt_with_operation_3")
