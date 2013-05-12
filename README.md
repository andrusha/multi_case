multi_case [![Build Status](https://travis-ci.org/andrusha/multi_case.png)](https://travis-ci.org/andrusha/multi_case) [![Dependency Status](https://gemnasium.com/andrusha/multi_case.png)](https://gemnasium.com/andrusha/multi_case) [![Code Climate](https://codeclimate.com/github/andrusha/multi_case.png)](https://codeclimate.com/github/andrusha/multi_case)
==========

An improved `case` operator for ruby which allows you to make a choice based on how variable changes (a state machine of ifs).

Installation
------------

`gem install multi_case`

Usage
-----

### Interfaces

There are two interfaces available, one is an unobtrusive module, which can be
included into your class like so:  

```ruby
require 'multi_case'

class Cookie
  include MultiCase::API

  def eat_it!
    mutli_case weight_was, weight do
      multi(150 => 0..50) { puts "That was a good bite!" }
      multi(150 => 150..(+1.0/0.0)) { puts "Are you puked?!" }
    end
  end
end
```

Another one is to extend your `Kernel` making `multi_case` function global:  

```ruby
require 'multi_case/core_ext'

mutli_case ENV['petals_was'], ENV['petal'] do
  multi([] => (0..100).step(2)) { puts "Любит" }
  multi([] => (1..100).step(2)) { puts "Не любит" }
end
```

### Features

Most common use-case is to make a decision based on how your variable changes,
it also might be used as an unbotrusive state-machine implementation. For 
example, if you have a post and its state went from `:draft` to `:published`
you might want to notify all your subscribed users about that, which can be
implemented like so:  

```ruby
class Post
  def notify
    multi_case status_was, status do
      multi([] => :draft)         { Notification.needs_input(post).to_editors }
      multi(:draft => :published) { Notification.new_post(post).to_subscribers }
      multi([] => :destroyed)     { Notification.destoyed_post(post).to_admins }
    end
  end
end
```

It also returns values so it can be used to replace nested `case` statements:  

```ruby
beer_status = multi_case bottles_was, bottles do
  multi(0 => 1..10) { :party_time }
  multi(1..10 => 0) { :needs_refil }
end
```

Since it uses case-matching (`===`) internally you can use all its goodiness:  

```ruby
multi_case x, y do
  multi(String => /a+/i) { 0 }
  multi(1..100 => [:x, :y, :z]) { 0 }
end
```

### Syntax

`multi_case` expect two values and block which contains matchers, first value 
is matched against key of one-elemnt hash which is provided to `multi`,
second value is matched against value of said hash.  

`multi` expect you to provide one-elemnt hash and block, if hash has array in it
then all array elements are matched against value sequentially and empty array
means "match-all". The block provided to multi is executed in case of correct 
match and its result is what is returned by `multi_case`. 

### Implementation

The `mutli_case` statement is complete equivalent of nested `case` statements, 
so these two snippets are intedent to work exactly the same:  

```ruby
result = multi_case old_value, new_value do
  multi [:a, :b] => [:c, :d] { :e }
  multi [:f, :g] => [:h, :i] { :j }
  multi [] => [:k, :l] { :m }
  multi [:n, :o] => [] { :p }
  multi [:f, :g] => [:q, :r] { :s }
end
```  


```ruby
result = case old_value
when :a, :b
  case new_value
  when :c, :d then :e
  end
when :f, :g
  case new_value
  when :h, :i then :j
  when :q, :r then :s
  end
when :n, :o then :p
else
  case new_value
  when :k, :l then :m
  end
end
```

Copyright
=========
Copytright © 2013 Andrey Korzhuev. See LICENSE for details.
