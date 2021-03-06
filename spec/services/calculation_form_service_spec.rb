require 'rails_helper'
RSpec.describe CalculationFormService do
  describe '#for' do
    it 'returns NilForm when nil is passed' do
      expect(described_class.for(nil)).to be NilForm
    end

    it 'returns MaritalStatusForm when :marital_status is passed' do
      expect(described_class.for(:marital_status)).to be MaritalStatusForm
    end

    it 'returns FeeForm when :fee is passed' do
      expect(described_class.for(:fee)).to be FeeForm
    end

    it 'returns DateOfBirthForm when :date_of_birth is passed' do
      expect(described_class.for(:date_of_birth)).to be DateOfBirthForm
    end

    it 'returns DisposableCapitalForm when :disposable_capital is passed' do
      expect(described_class.for(:disposable_capital)).to be DisposableCapitalForm
    end

    it 'returns BenefitsReceivedForm when :benefits_received is passed' do
      expect(described_class.for(:benefits_received)).to be BenefitsReceivedForm
    end

    it 'returns NumberOfChildrenForm when :number_of_children is passed' do
      expect(described_class.for(:number_of_children)).to be NumberOfChildrenForm
    end

    it 'returns TotalIncomeForm when :total_income is passed' do
      expect(described_class.for(:total_income)).to be TotalIncomeForm
    end

    it 'raises an exception if a form is not registered' do
      expect { described_class.for(:we_wont_have_a_form_called_this) }.to raise_exception(ArgumentError)
    end
  end

  describe '#for_field' do
    it 'returns MaritalStatusForm when :marital_status is passed' do
      expect(described_class.for_field(:marital_status)).to be MaritalStatusForm
    end

    it 'returns FeeForm when :fee is passed' do
      expect(described_class.for_field(:fee)).to be FeeForm
    end

    it 'returns DateOfBirthForm when :date_of_birth is passed' do
      expect(described_class.for_field(:date_of_birth)).to be DateOfBirthForm
    end

    it 'returns DateOfBirthForm when :partner_date_of_birth is passed' do
      expect(described_class.for_field(:partner_date_of_birth)).to be DateOfBirthForm
    end

    it 'returns DisposableCapitalForm when :disposable_capital is passed' do
      expect(described_class.for_field(:disposable_capital)).to be DisposableCapitalForm
    end

    it 'returns BenefitsReceivedForm when :benefits_received is passed' do
      expect(described_class.for_field(:benefits_received)).to be BenefitsReceivedForm
    end

    it 'returns NumberOfChildrenForm when :number_of_children is passed' do
      expect(described_class.for_field(:number_of_children)).to be NumberOfChildrenForm
    end

    it 'returns TotalIncomeForm when :total_income is passed' do
      expect(described_class.for_field(:total_income)).to be TotalIncomeForm
    end

    it 'raises an exception if a form is not registered' do
      expect { described_class.for_field(:we_wont_have_a_field_called_this) }.to raise_exception(ArgumentError)
    end
  end
end
