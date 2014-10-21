require 'spec_helper'

describe Oga::CSS::Parser do
  context 'axes' do
    example 'parse the > axis' do
      parse_css('x > y').should == parse_xpath('descendant-or-self::x/y')
    end

    example 'parse the > axis called on another > axis' do
      parse_css('a > b > c').should == parse_xpath('descendant-or-self::a/b/c')
    end

    example 'parse an > axis followed by an element with an ID' do
      parse_css('x > foo#bar').should == parse_xpath(
        'descendant-or-self::x/foo[@id="bar"]'
      )
    end

    example 'parse an > axis followed by an element with a class' do
      parse_css('x > foo.bar').should == parse_xpath(
        'descendant-or-self::x/foo[contains(concat(" ", @class, " "), "bar")]'
      )
    end

    example 'parse the + axis' do
      parse_css('x + y').should == s(
        :following_direct,
        s(:test, nil, 'x'),
        s(:test, nil, 'y')
      )
    end

    example 'parse the + axis called on another + axis' do
      parse_css('a + b + c').should == s(
        :following_direct,
        s(:following_direct, s(:test, nil, 'a'), s(:test, nil, 'b')),
        s(:test, nil, 'c')
      )
    end

    example 'parse the ~ axis' do
      parse_css('x ~ y').should == parse_xpath(
        'descendant-or-self::x/following-sibling::y'
      )
    end

    example 'parse the ~ axis followed by another node test' do
      parse_css('x ~ y z').should == parse_xpath(
        'descendant-or-self::x/following-sibling::y/z'
      )
    end

    example 'parse the ~ axis called on another ~ axis' do
      parse_css('a ~ b ~ c').should == parse_xpath(
        'descendant-or-self::a/following-sibling::b/following-sibling::c'
      )
    end

    example 'parse a pseudo class followed by the ~ axis' do
      parse_css('x:root ~ a').should == s(
        :following,
        s(:pseudo, s(:test, nil, 'x'), 'root'),
        s(:test, nil, 'a')
      )
    end

    example 'parse the ~ axis followed by a pseudo class' do
      parse_css('a ~ x:root').should == s(
        :following,
        s(:test, nil, 'a'),
        s(:pseudo, s(:test, nil, 'x'), 'root')
      )
    end
  end
end