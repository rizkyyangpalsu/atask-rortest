class WalletsController < ApplicationController
  def balance
    wallet = current_entity.wallet
    wallet.update_balance
    render json: { balance: wallet.balance }, status: :ok
  end

  def transaction_history
    wallet = current_entity.wallet
    transactions = Transaction.where("source_wallet_id = ? OR target_wallet_id = ?", wallet.id, wallet.id).order(created_at: :desc)

    render json: transactions, status: :ok
  end

  def top_up
    wallet = current_entity.wallet
    amount = params[:amount].to_d

    CreditTransaction.create!(target_wallet: wallet, amount: amount)
    render json: { message: 'Top-up successful' }, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def transfer
    source_wallet = current_entity.wallet
    target_wallet = Wallet.find_by(id: params[:target_wallet_id])
    amount = params[:amount].to_d

    if source_wallet && target_wallet && source_wallet.transfer_to(target_wallet, amount)
      render json: { message: 'Transfer successful' }, status: :ok
    else
      render json: { error: 'Transfer failed' }, status: :unprocessable_entity
    end
  end
end
