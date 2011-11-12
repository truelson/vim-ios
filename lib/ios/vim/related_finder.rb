module IOS
  module Vim

    class RelatedFinder

      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      def spec
        return @filename if @classifier.type == :spec
        return sentestingkit_spec if File.exists? sentestingkit_spec
        kiwi_spec
      end

      def kiwi_spec
        "#{@classifier.stem}Spec.m"
      end
      private :kiwi_spec

      def sentestingkit_spec
        "#{@classifier.stem}Test.m" 
      end
      private :sentestingkit_spec

    end

  end
end