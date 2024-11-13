class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :transaction_type, :amount, :created_at, :source_wallet_id, :target_wallet_id

  # Optional: Include readable names for source and target wallets if needed
  def source_wallet_owner
    Wallet.find(object.source_wallet_id).entity.name if object.source_wallet_id
  end

  def target_wallet_owner
    Wallet.find(object.target_wallet_id).entity.name if object.target_wallet_id
  end
end