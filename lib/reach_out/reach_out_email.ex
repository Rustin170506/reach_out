defmodule ReachOut.ReachOutEmail do
  import Swoosh.Email

  def reach_out(%{name: name, email: email}) do
    new()
    |> put_provider_option(:template_id, System.get_env("SENDGRID_TEMPLATE_ID"))
    |> put_provider_option(:dynamic_template_data, %{name: name})
    |> to({name, email})
    |> from({System.get_env("FROM_NAME"), System.get_env("FROM_EMAIL")})
  end
end
