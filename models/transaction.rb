require_relative('../db/sql_runner')
require('pry')

class Transaction

  def initialize(options)
    @id = options['id'].to_i
    @merchant = options['merchant']
    @price = options['price']
    @date = options['date']
    @tag_id = options['tag_id']
  end

  def save()
    sql = "INSERT INTO transactions (merchant, price, date, tag_id) VALUES ('#{@merchant}', #{@price}, '#{@date}', #{@tag_id}) RETURNING id;"
    transaction = SqlRunner.run(sql)
    @id = transaction[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM transactions;"
    transactions = SqlRunner.run(sql)
    return transactions.map{|transaction| Transaction.new(transaction)}
  end

  def self.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  def self.total_spend
    sql = "SELECT SUM(price) FROM transactions;"
    sum = SqlRunner.run(sql)
    @total = sum[0]['sum']
  end

  # how does the above return a key value pair? what part creates a hash? because i have not created a columnn called 'sum'.





end