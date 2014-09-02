require 'spec_helper'

describe Oga::XML::Lexer do
  context 'lexing inline Javascript' do
    before do
      @javascript = 'if ( number < 10 ) { }'
    end

    example 'lex inline Javascript' do
      lex("<script>#{@javascript}</script>").should == [
        [:T_ELEM_START, nil, 1],
        [:T_ELEM_NAME, 'script', 1],
        [:T_TEXT, @javascript, 1],
        [:T_ELEM_END, nil, 1]
      ]
    end

    example 'lex inline Javascript containing an XML comment' do
      lex("<script>#{@javascript}<!--foo--></script>").should == [
        [:T_ELEM_START, nil, 1],
        [:T_ELEM_NAME, 'script', 1],
        [:T_TEXT, @javascript, 1],
        [:T_ELEM_END, nil, 1],
        [:T_COMMENT, 'foo', 1]
      ]
    end
  end
end
