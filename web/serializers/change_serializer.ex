defimpl Poison.Encoder, for: Changeling.Change do
  def encode(change, _options) do
    %{
      title:             change.title,
      short_description: change.short_description,
      type:              change.change_type,
      authors:           split(change.authors),
      deployed:          change.deployed_on
    } |> Poison.Encoder.encode([])
  end

  defp split(string) do
    String.split(string, ",", trim: true)
  end
end
