class DebitTransaction < Transaction
  private

  def update_wallet_balances
    Wallet.transaction do
      if source_wallet.balance >= amount
        source_wallet.update!(balance: source_wallet.balance - amount)
      else
        errors.add(:base, "Insufficient funds in source wallet")
        raise ActiveRecord::Rollback
      end
    end
  end
end
