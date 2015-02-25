class Hash
  def pick_pairs!(keys)
    self.select! {|k, v| keys.include? k}
  end

  def pick_pairs(keys)
    self.clone.pick_pairs!(keys)
  end
end
