# This controller handles all final results from the calculator - either full, none or partial
class CalculationResultController < ApplicationController
  include CalculationStore
  before_action :start_again, unless: :calculation_state_valid?
  after_action :mark_as_complete

  private

  def mark_as_complete
    current_calculation.freeze
    repo.save current_calculation
  end

  def start_again
    redirect_to root_path
    false
  end
end
