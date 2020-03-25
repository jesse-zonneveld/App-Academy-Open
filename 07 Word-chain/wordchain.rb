require "set"

class Wordchain
    def initialize(dictionary_file_name, source, target)
        @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
        @dictionary = Set.new(@dictionary)
        @source = source
        @current_words = [@source]
        @all_seen_words = { @source => nil }
        @target = target
    end

    attr_reader :current_words

    def run
        until @current_words.empty? || @all_seen_words.include?(@target)
            explore_current_words
        end 
        build_path
    end

    def build_path
        path = []
        current_word = @target
        until current_word == nil
            path << current_word
            current_word = @all_seen_words[current_word]
        end
        p path.reverse
    end

    def explore_current_words
        new_current_words = []
        @current_words.each do |current_word|
            adjacent_words(current_word).each do |adj_word|
                next if @all_seen_words.include?(adj_word)
                new_current_words << adj_word
                @all_seen_words[adj_word] = current_word
            end
        end
        @current_words = new_current_words
    end

    def adjacent_words(word)
        words = []
        word.each_char.with_index do |old_letter, i|
            ("a".."z").each do |new_letter|
                next if old_letter == new_letter
                test_word = word.dup
                test_word[i] = new_letter
                words << test_word if @dictionary.include?(test_word)
            end
        end
        words
    end

end

if __FILE__ == $PROGRAM_NAME
    w = Wordchain.new("dictionary.txt", "cat", "jaw")
    w.run

end