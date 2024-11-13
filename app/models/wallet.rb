class Wallet < ApplicationRecord
  belongs_to :entity, polymorphic: true
  has_many :outgoing_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'
  has_many :incoming_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def calculate_balance
    incoming_transactions.sum(:amount) - outgoing_transactions.sum(:amount)
  end

  def update_balance
    self.balance = incoming_transactions.sum(:amount) - outgoing_transactions.sum(:amount)
    save!
  end

  def transfer_to(target_wallet, amount)
    Wallet.transaction do
      DebitTransaction.create!(source_wallet: self, amount: amount)
      CreditTransaction.create!(target_wallet: target_wallet, amount: amount)
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Transaction failed: #{e.message}")
    false
  end
end
