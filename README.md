# rspec-gc-control

## Summary

This gem extends RSpec to allow you to control how often GC cycles happen
in order to trade increased memory usage for faster test runs.  It's an
encapsulated and reusable version of the code shown in this article:

<http://www.rubyinside.com/careful-cutting-to-get-faster-rspec-runs-with-rails-5207.html>


## Requirements

For this to work, you need a Ruby that supports explicit control over the
garbage collector, and RSpec 2.11.1 or higher.

Supported Rubies include MRI 1.9.2 and 1.9.3, and most likely Rubinius.

Unsupported Rubies are:

* MRI 1.8.x:  No support for `GC.count`.
* JRuby:  `GC.enable` / `GC.disable` are no-ops.

On unsupported platforms, attempting to enable explicit GC control via this
plugin will produce a warning and have no other effect.


## Installation and Usage

Install the gem:

```ruby
gem install rspec-gc-control
```

Or if you're using bundler, add this line to your `Gemfile` and run
`bundle install`:

```ruby
gem 'rspec-gc-control'
```

Once you have the gem installed, edit your `spec_helper.rb` file to set
`gc_every_n_examples` to an appropriate value.  You may want to play with this
value while watching memory consumption for the process to get a feeling for
how significant a tradeoff you're making in terms of increased memory usage.

```ruby
RSpec.configure do |c|
  c.gc_every_n_examples = 10
end
```

You'll know it's working if you see output like the following at the end of
your test run:

```
Finished in 6.45 seconds (including 7 forced GC cycle(s), totalling 0.67116 seconds)
71 examples, 0 failures, 1 pending
```
