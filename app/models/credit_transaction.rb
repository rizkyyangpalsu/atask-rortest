class CreditTransaction < Transaction
  private

  def update_wallet_balances
    Wallet.transaction do
      target_wallet.update!(balance: target_wallet.balance + amount)
    end
  end
end
