class Machine
  def start
    flip_switch(:on) # best practice to remove unnecessary calls to `self`
  end

  def stop
    flip_switch(:off) # although `self.flip_switch` is allowed for the private method since Ruby 2.7
  end

  def reveal_switch # FE
    puts switch
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end
