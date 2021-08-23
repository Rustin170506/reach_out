defmodule ReachOut.ReachOutEmail do
  import Swoosh.Email

  def reach_out(%{name: name, email: email}) do
    new()
    |> put_provider_option(:template_id, "d-e82ee6e445804b9faab5fd5efd00e38c")
    |> put_provider_option(:dynamic_template_data, %{name: name})
    |> to({name, email})
    |> from({"Rustin Liu", "rustin.liu@gmail.com"})
  end
end
