class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0 && valid_transaction?(balance - amount) # && amount <= self.balance # at first I simply added the && condition for amount to be less than balance--but this fix ignores the problem with #balance=(new_balance) below
      success = (self.balance -= amount)
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  # LS solution: changed the method below. In Ruby, setter methods always return the argument that was passed in, even when you add an explicit return statement.
  # need to let the setter method do its one job.
  def balance=(new_balance)
    @balance = new_balance
  end

  # original code below:
  # def balance=(new_balance)
  #   if valid_transaction?(new_balance)
  #     @balance = new_balance
  #     true
  #   else
  #     false
  #   end
  # end

  # FE: what does a setter method return if you mutate its argument in the method body? e.g:
  def client=(new_name)
    if new_name.start_with?('A')
      @client = new_name
      new_name.upcase!
    else
      @client = new_name
    end
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # Expected output: => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output before I fixed error: => $80 withdrawn. Total balance is $50.
p account.balance         # => 50
# additional tests below:
p account.withdraw(20) # => $20 withdrawn. Total balance is $30.
p account.balance # => 30

p account.client = 'Bob' # => Bob
p account.client = 'Alex' # => ALEX (@client has been set to the same object referred to by the argument. mutating the argument also mutates @client)
