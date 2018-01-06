module Calculator
  module Test
    module En
      class NotEligiblePage < BasePage
        include ActiveSupport::NumberHelper
        set_url '/calculation/no_remission_available'

        # Verifies that the final not eligible message is present
        # @param [OpenStruct] user The user containing the fee and the monthly_gross_income
        #
        # @return [Boolean] true if all OK
        # @raise [Capybara::ElementNotFound] If the correct message was not found
        def valid_for_final_message?(user)
          marital_status = user.marital_status.downcase
          expected_header = messaging.translate "hwf_decision.no_remission.#{marital_status}.heading"
          expected_detail = messaging.translate "hwf_decision.no_remission.#{marital_status}.negative.detail",
            fee: number_to_currency(user.fee, precision: 0, unit: '£'),
            total_income: number_to_currency(user.monthly_gross_income, precision: 0, unit: '£')
          feedback_message_with_header(expected_header)
          feedback_message_with_detail(expected_detail)
          true
        end

      end
    end
  end
end