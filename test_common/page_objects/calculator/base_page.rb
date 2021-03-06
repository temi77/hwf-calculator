require_relative '../../sections'
require_relative '../../messaging'
module Calculator
  module Test
    # @abstract
    # @private
    class BasePage < ::SitePrism::Page
      include ActiveSupport::NumberHelper
      include ::Calculator::Test::I18n

      section :feedback, '[data-behavior=calculator_feedback]' do
        include ::Calculator::Test::FeedbackSection
      end
      section :previous_answers, :table_with_header, t('hwf_components.previous_questions.label') do
        @i18n_scope = 'hwf_components.previous_questions'
        include ::Calculator::Test::PreviousQuestionsSection
      end

      def messaging
        @messaging ||= ::Calculator::Test::Messaging.instance
      end

      def load_page
        load
      end

      def feedback_message_with_detail(msg)
        feedback.message_with_detail(msg)
      end

      def feedback_message_with_header(header)
        feedback.message_with_header(header)
      end

      def positive_message
        feedback.positive_message
      end

      def has_positive_message?
        feedback.has_positive_message?
      end

      def negative_message
        feedback.negative_message
      end

      def go_back_to_question(q)
        previous_answers.send(q.to_sym).navigate_to
      end

      def back_via_browser_button
        page.evaluate_script('window.history.back()')
      end

      # Finds a previous question with a given answer in the 'Previous answers' section of any pa
      # @param [Symbol] question The question to find
      # @param [Symbol,String,Array] answer Can be a string (the expected answer), a symbol (will get translated)
      #   or an array of either of the above
      # @return [Boolean] True if found, else false
      def has_previous_question?(question, answer:)
        previous_answers.send(question).has_answer?(text: translated_answer(question: question, answer: answer))
      end

      def has_feedback_message_with_header?(key)
        header = messaging.translate("hwf_decision.#{key}.heading")
        feedback.message_with_header(header)
      end

      def has_feedback_message_with_detail?(key, fee: nil, disposable_capital: nil)
        options = {}
        options[:fee] = number_to_currency(fee, precision: 0, unit: '£') unless fee.nil?
        options[:disposable_capital] = number_to_currency(disposable_capital, precision: 0, unit: '£') unless disposable_capital.nil?
        msg = messaging.t("hwf_decision.#{key}.detail", options)
        feedback_message_with_detail(msg)
        true
      rescue Capybara::ElementNotFound
        false
      end

      def has_no_feedback_messages?
        feedback.has_no_messages?
      end
      private

      def translated_answer(question:, answer:)
        case answer
        when Array then answer.map { |a| translated_answer(question: question, answer: a) }.join(', ')
        when Symbol then messaging.t("hwf_components.previous_questions.#{question}.options.#{answer}")
        else answer
        end
      end
    end
  end
end
