module Calculator
  module Test
    module Setup
      attr_accessor :user
      def answer_questions_up_to_benefits
        answer_questions_up_to_disposable_capital
        answer_disposable_capital_question
      end

      def answer_questions_up_to_disposable_capital
        start_calculator_session
        answer_marital_status_question
        answer_court_fee_question
        answer_date_of_birth_question
      end

      def answer_questions_up_to_total_income
        answer_questions_up_to_number_of_children
        answer_number_of_children_question
      end

      def answer_questions_up_to_number_of_children
        answer_questions_up_to_benefits
        answer_benefits_question
      end

      def answer_disposable_capital_question
        disposable_capital_page.disposable_capital.set(user.disposable_capital)
        disposable_capital_page.next
      end

      def answer_date_of_birth_question
        date_of_birth_page.date_of_birth.set(user.date_of_birth)
        date_of_birth_page.next
      end

      def answer_benefits_question
        income_benefits_page.benefits.set(user.income_benefits)
        income_benefits_page.next
      end

      def answer_number_of_children_question
        number_of_children_page.number_of_children.set(user.number_of_children)
        number_of_children_page.next
      end

      def start_calculator_session
        start_page.load_page
        start_page.start_session
      end

      def answer_marital_status_question
        marital_status_page.marital_status.set(user.marital_status)
        marital_status_page.next
      end

      def answer_court_fee_question
        court_fee_page.fee.set(user.fee)
        court_fee_page.next
      end

      def given_i_am(user_name)
        self.user = personas.fetch(user_name)
        user.date_of_birth = (user.age.to_i.years.ago - 10.days).strftime('%-d/%-m/%Y')
        return if user.income_benefits.nil?
        user.income_benefits.map! do |b|
          messaging.t("hwf_pages.income_benefits.labels.benefits.#{b}")
        end
      end
    end
  end
end
