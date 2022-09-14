=begin

For horizontal_rule:
"+-" + "-" * message length + "-+"

etc.

=end

## Modify/complete code below, do not make implementation details public

class Banner
  def initialize(message, banner_width=(message.length + 4))
    @message = message

    if banner_width < (message.length + 4)
      puts "Error: Banner width too small for given message." 
      return
    elsif banner_width > 111
      puts "Error: Banner width must be less than 112."
    else
      @banner_width = banner_width - 2
    end
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+#{'-' * @banner_width}+"   
  end

  def empty_line
    "|#{' ' * @banner_width}|"
  end

  def message_line
    "|#{@message.center(@banner_width)}|"
  end
end

## Test Cases:

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

banner = Banner.new('Test message with a big banner width.', 111)
puts banner

banner = Banner.new('This should print an error message because the banner width is too small.', 20)
puts banner # raises an error because `banner` has been assigned `nil`, return value of #puts

banner = Banner.new('This one is too big, so we get another error message.', 300)
puts banner # raises an error for same reason as above
