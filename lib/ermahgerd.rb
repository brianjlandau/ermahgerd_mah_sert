# Translated from Javascript
# Original code by J. Miller: http://jmillerdesign.com & https://github.com/jmillerdesign 
# 
# SOURCE: http://ermahgerd.jmillerdesign.com/js/filters.js?5

class Ermahgerd

  class WordTranslator
    
    SPECIAL_TRANSLATIONS = {
      'AWESOME'    => 'ERSUM',
      'BANANA'     => 'BERNERNER',
      'BAYOU'      => 'BERU',
      'FAVORITE'   => 'FRAVRIT',
      'FAVOURITE'  => 'FRAVRIT',
      'GOOSEBUMPS' => 'GERSBERMS',
      'LONG'       => 'LERNG',
      'MY'         => 'MAH',
      'THE'        => 'DA',
      'THEY'       => 'DEY',
      "WE'RE"      => 'WER',
      'YOU'        => 'U',
      "YOU'RE"     => 'YER'
    }
    
    attr_reader :word, :original_word
    
    def initialize(word)
      @word = word
      @original_word = word.dup
    end
    
    def translate
      return word if word.size == 1 # keep short words

      # Special cases
      return special_case if special_case
      
      drop_vowels_from_end
      reduce_duplicate_letters
      reduce_adjacent_vowels_to_one
      convert_ow_to_er
      convert_akes_to_erks
      replace_vowels_with_er
      convert_oh_to_er
      convert_my_to_mah
      convert_ing_to_in
      convert_erperd_to_erped
      meme_converter
      
      keep_first_y
      
      reduce_duplicate_letters
      
      convert_low_to_lo
      
      return word
    end
    
    private
    
    def special_case
      SPECIAL_TRANSLATIONS[word]
    end
    
    def drop_vowels_from_end
      word.gsub!(/[AEIOU]$/i, '') if original_word.size > 2
    end
    
    def reduce_duplicate_letters
      word.gsub!(/[^\w\s]|(.)(?=\1)/i, '')
    end

    def reduce_adjacent_vowels_to_one
      word.gsub!(/[AEIOUY]{2,}/i, 'E')
    end

    def convert_ow_to_er
      word.gsub!(/OW/i, 'ER')
    end
    
    def convert_akes_to_erks
      word.gsub!(/AKES/i, 'ERKS')
    end
    
    def replace_vowels_with_er
      word.gsub!(/[AEIOUY]/i, 'ER')
    end
    
    def convert_oh_to_er
      word.gsub!(/ERH/i, 'ER')
    end
    
    def convert_my_to_mah
      word.gsub!(/MER/i, 'MAH')
    end
    
    def convert_ing_to_in
      word.gsub!('ERNG', 'IN')
    end
    
    def convert_erperd_to_erped
      word.gsub!('ERPERD', 'ERPED')
    end
    
    def meme_converter
      word.gsub!('MAHM', 'MERM')
    end
    
    def keep_first_y
      if original_word[0] == 'Y'
        @word = 'Y' + word
      end
    end
    
    def convert_low_to_lo
      if (original_word[-3..-1] == 'LOW') && (word[-3..-1] == 'LER')
        @word = word[0, (word.length - 3)] + 'LO'
      end
    end
  end

  attr_reader :words

  def initialize(string)
    @words = string.upcase.split(' ')
  end

  def convert
    words.map { |word|
      prefix = word.match(/^\W+/).to_s
      suffix = word.match(/\W+$/).to_s
      word_without_punctuation = word.sub(prefix, '').sub(suffix, '')
      
      if word_without_punctuation
        prefix + translate(word_without_punctuation.dup) + suffix
      else
        word
      end
    }.join(' ')
  end

  private

  def translate(word)
    WordTranslator.new(word).translate
  end

end
