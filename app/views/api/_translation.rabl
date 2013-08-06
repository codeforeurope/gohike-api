node(locals[:node]) do
  h = {}
  @object.translations.each do |translation|
    h[translation.locale] = translation.send locals[:node]
  end
  h
end