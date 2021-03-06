require_relative 'question_section'
module Calculator
  module Test
    module QuestionRadioListSection
      extend ActiveSupport::Concern
      include QuestionSection

      # Selects the radio button labelled with the value given
      # @param [String] value The option to select
      def set(value)
        within @root_element do
          choose(value)
        end
      end

      # Validates that the value provided is selected in the radio button list
      # note that this uses has_selector which means it will wait for the value
      # to arrive, subject to timeout of course.
      # @param [String] value The value to validate is selected
      # @return [Boolean] true if it is selected, else false
      def has_value?(value)
        within @root_element do
          has_selector?(:radio_button, value, checked: true)
        end
      end
    end
  end
end
