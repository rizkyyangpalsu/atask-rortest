class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :validate_wallets

  after_create :update_wallet_balances

  private

  # Ensure the correct wallets are provided based on transaction type
  def validate_wallets
    if type == 'CreditTransaction'
      errors.add(:target_wallet, "must be present") unless target_wallet
      errors.add(:source_wallet, "must be nil") if source_wallet
    elsif type == 'DebitTransaction'
      errors.add(:source_wallet, "must be present") unless source_wallet
      errors.add(:target_wallet, "must be nil") if target_wallet
    end
  end

  def update_wallet_balances
    raise NotImplementedError, "Subclasses must implement `update_wallet_balances`"
  end
end
