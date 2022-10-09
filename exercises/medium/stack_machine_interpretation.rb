### PEDAC

=begin

Problem:

define a `Minilang` class which, when initialized and given a series of commands and numeric values in the form of a string argument,
  will execute commands on its stack if the instance method #eval is called on it, after which the object will store the correct value in its "register",
  which may also be printed by the "PRINT" command. the return value of this method is otherwise not used. print an error message if an invalid command is included.
  an error should also be printed if a required value is not available when it should be (the register is empty). processing should halt if an error is raised.
  register should be initialized to 0.

input: string (one or more numeric values and/or one or more uppercase commands)
output: print numeric value, do nothing (if no print command is given), or instead print an error message if unable to evaluate because of an invalid command.

Examples: given below

Data/Algorithm:

Noun/Verbs:

Nouns: Minilang, stack, register, commands, value, error
Verbs: Execute, evaluate, push, add, sub, mult, div, mod, pop, print

Minilang class/object
  -evaluate stack (instance method #eval)
    -if error is raised, halt eval and print error message (use exception block)
  stack
    -command verbs (string split into words, stored in array)
  register
    -(contains value, initialized to 0)
Error
  error message

# Hint: solution uses exceptions and Object#send method

Minilang

=end

### Previous solution to procedural version of this challenge:

# def minilang(string_of_commands)
#   register = [0]
#   stack = []

#   string_of_commands.split.each do |command|
#     if command.to_i.to_s == command
#       register[0] = command.to_i
#     end

#     case command
#     when 'PUSH' then stack.push(register[0])
#     when 'ADD' then register[0] += stack.pop
#     when 'SUB' then register[0] -= stack.pop
#     when 'MULT' then register[0] *= stack.pop
#     when 'DIV' then register[0] /= stack.pop 
#     when 'MOD' then register[0] %= stack.pop
#     when 'POP' then register[0] = stack.pop
#     when 'PRINT' then puts register[0]
#     end
#   end
# end

require 'pry-byebug'

### OO Minilang

class MinilangError < StandardError
end

class Minilang
  def initialize(program)
    @program = program
    @register = [0]
    @stack = []
  end

  def eval(argument_for_conversion_program=nil)
    # binding.pry
    string_of_commands = format(@program, argument_for_conversion_program)
    @commands = string_of_commands.split
    begin
      until @commands.empty? do
        @current_command = @commands.shift
        execute_current_command
      end
    rescue MinilangError => e
      puts e.message
    end
  end

  private

  def execute_current_command
    if inappropriate_command?
      raise MinilangError.new('Empty stack!')
    elsif @current_command.to_i.to_s == @current_command
      @register[0] = @current_command.to_i
    elsif valid_command?
      case @current_command
      when 'PUSH' then @stack.push(@register[0])
      when 'ADD' then @register[0] += @stack.pop
      when 'SUB' then @register[0] -= @stack.pop
      when 'MULT' then @register[0] *= @stack.pop
      when 'DIV' then @register[0] /= @stack.pop 
      when 'MOD' then @register[0] %= @stack.pop
      when 'POP' then @register[0] = @stack.pop
      when 'PRINT' then puts @register[0]
      end
    else
      raise MinilangError.new("Invalid token: #{@current_command}")
    end
  end

  def valid_command?
    %w(PUSH ADD SUB MULT DIV MOD POP PRINT).include?(@current_command)
  end

  def inappropriate_command?
    %w(ADD SUB MULT DIV MOD POP).include?(@current_command) &&
      @stack.empty?
  end
end

### Test cases:

# Minilang.new('PRINT').eval
# # 0

# Minilang.new('5 PUSH 3 MULT PRINT').eval
# # 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5

# Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB

# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

# Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'

minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)

minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40

FAHRENHEIT_TO_CENTIGRADE =
  '9 PUSH 32 PUSH %<degrees_f>d SUB PUSH 5 MULT DIV PRINT'

minilang = Minilang.new(FAHRENHEIT_TO_CENTIGRADE)

minilang.eval(degrees_f: 212)
# 100
minilang.eval(degrees_f: 32)
# 0
minilang.eval(degrees_f: -40)
# -40

APPROX_KPH_TO_MPH =
  '5 PUSH 3 PUSH %<kph>d MULT DIV PRINT'

minilang = Minilang.new(APPROX_KPH_TO_MPH)

minilang.eval(kph: 100)
# 60
minilang.eval(kph: 200)
# 120 (124 is more exact)

APPROX_MPH_TO_KPH =
  '3 PUSH 5 PUSH %<mph>d MULT DIV PRINT'

minilang = Minilang.new(APPROX_MPH_TO_KPH)

minilang.eval(mph: 60)
# 100
minilang.eval(mph: 100)
# 166 (160 is more exact)
