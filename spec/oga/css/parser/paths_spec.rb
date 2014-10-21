require 'spec_helper'

describe Oga::CSS::Parser do
  context 'paths' do
    example 'parse a single path' do
      parse_css('foo').should == parse_xpath('descendant-or-self::foo')
    end

    example 'parse a path using two selectors' do
      parse_css('foo bar').should == parse_xpath(
        'descendant-or-self::foo/descendant-or-self::bar'
      )
    end
  end
end