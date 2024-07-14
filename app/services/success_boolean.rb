module SuccessBoolean
  def success
    @success ||= false
  end

  def success?
    success
  end
end
