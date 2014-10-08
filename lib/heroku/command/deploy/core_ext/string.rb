class String

  def blink
    "\e[5m#{self}\e[0m"
  end

  def gray
    "\e[90m#{self}\e[0m"
  end

  def green
    "\e[92m#{self}\e[0m"
  end

  def red
    "\e[91m#{self}\e[0m"
  end

end
