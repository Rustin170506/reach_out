defmodule ReachOut.ReachOutEmail do
  import Swoosh.Email

  def reach_out(%{name: name, email: email}) do
    new()
    |> to({name, email})
    |> from({"Rustin Liu", "rustin.liu@gmail.com"})
    |> subject("Hello, #{name}")
    |> text_body("Hello #{name}\n")
  end
end
