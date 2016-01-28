class AddPoliticalPartyMembershipToContactsTable < ActiveRecord::Migration
  def up
    execute "create extension hstore"
    add_column :contacts, :political_party_membership, :hstore
  end

  def down
    remove_column :contacts, :political_party_membership
  end
end
