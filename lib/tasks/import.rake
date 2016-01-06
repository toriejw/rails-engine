require "csv"
require "open-uri"

def files_list
  { customers: "https://raw.githubusercontent.com/turingschool-examples/sales_engine/master/data/customers.csv",
    invoice_items: "https://raw.githubusercontent.com/turingschool-examples/sales_engine/master/data/invoice_items.csv",
    invoices: "https://raw.githubusercontent.com/turingschool-examples/sales_engine/master/data/invoices.csv",
    items: "https://raw.githubusercontent.com/turingschool-examples/sales_engine/master/data/items.csv",
    merchants: "https://raw.githubusercontent.com/turingschool-examples/sales_engine/master/data/merchants.csv",
    transactions: "https://raw.githubusercontent.com/turingschool-examples/sales_engine/master/data/transactions.csv" }
end

def load_and_parse_file(url)
  file = open(url)
  CSV.parse(file, headers: true, force_quotes: true)
end

def format_currency(number)
  number[0...-2] + "." + number[-2..-1]
end

def import_customers
  parsed_file = load_and_parse_file(files_list[:customers])

  parsed_file.each do |row|
    Customer.create!( first_name: row.field("first_name"),
                      last_name:  row.field("last_name"),
                      created_at: row.field("created_at"),
                      updated_at: row.field("updated_at") )
  end
  puts "Customers imported."
end

def import_invoice_items
  parsed_file = load_and_parse_file(files_list[:invoice_items])

  parsed_file.each do |row|
    InvoiceItem.create!( item_id:    row.field("item_id"),
                         invoice_id: row.field("invoice_id"),
                         quantity:   row.field("quantity"),
                         unit_price: format_currency(row.field("unit_price")),
                         created_at: row.field("created_at"),
                         updated_at: row.field("updated_at") )
  end
  puts "InvoiceItems imported."
end

def import_invoices
  parsed_file = load_and_parse_file(files_list[:invoices])

  parsed_file.each do |row|
    Invoice.create!( customer_id: row.field("customer_id"),
                     merchant_id: row.field("merchant_id"),
                     created_at:  row.field("created_at"),
                     updated_at:  row.field("updated_at"),
                     status:      row.field("status") )
  end
  puts "Invoices imported."
end

def import_items
  parsed_file = load_and_parse_file(files_list[:items])

  parsed_file.each do |row|
    Item.create!( name: row.field("name"),
                  description: row.field("description"),
                  unit_price:  format_currency(row.field("unit_price")),
                  merchant_id: row.field("merchant_id"),
                  created_at:  row.field("created_at"),
                  updated_at:  row.field("updated_at") )
  end
  puts "Items imported."
end

def import_merchants
  parsed_file = load_and_parse_file(files_list[:merchants])

  parsed_file.each do |row|
    Merchant.create!( name:       row.field("name"),
                      created_at: row.field("created_at"),
                      updated_at: row.field("updated_at") )
  end
  puts "Merchants imported."
end

def import_transactions
  parsed_file = load_and_parse_file(files_list[:transactions])

  parsed_file.each do |row|
    Transaction.create!( invoice_id:         row.field("invoice_id"),
                         credit_card_number: row.field("credit_card_number"),
                         result:             row.field("result"),
                         created_at:         row.field("created_at"),
                         updated_at:         row.field("updated_at") )
  end
  puts "Transactions imported."
end

namespace :data do
  desc "Import data and add to database"
  task :import => :environment do
    import_customers
    import_invoice_items
    import_invoices
    import_items
    import_merchants
    import_transactions

    puts "All data has been imported!"
  end
end
