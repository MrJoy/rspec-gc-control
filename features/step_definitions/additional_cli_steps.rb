Then /^on JRuby the output should contain "([^"]*)"$/ do |string|
  if(defined?(JRuby))
    all_output.should =~ regexp(string)
  end
end

Then /^the output should contain "([^"]*)" except on JRuby$/ do |string|
  if(!defined?(JRuby))
    all_output.should =~ regexp(string)
  else
    all_output.should_not =~ regexp(string)
  end
end
