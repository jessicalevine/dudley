class Hash
  # Destructively symbolizes hash keys. Recursive, so if the key's value is also
  # a hash, symbolize_keys! is also called on that hash.
  def symbolize_keys!
    keys.each do |key|
      val = delete(key)
      val.symbolize_keys! if val.is_a? Hash

      self[(key.to_sym rescue key) || key] = val
    end
    self
  end
end
