def get_balance(filename, date)
	require 'csv'
	txn_array = []
	if (date == "")
		date = Date.today.to_s
	end	
	CSV.foreach(filename) do |row|
		if (row[0] <= date) 
			amt = "-" + row[3]
			txn_array << row[1].inspect + "," + row[0].inspect + "," + amt
			txn_array << row[2].inspect + "," + row[0].inspect + "," + row[3]
		end
	end
	if (txn_array.length > 0)
	  txn_array = txn_array.sort!
	  puts "Ledger balances till date: " + date
	  puts "------------------------------------------"
	  person = ""
	  balance = 0
	  firstline = true
	  txn_array.each do |line|
		txn = line.split(',')
		if (person === txn[0])
			balance += txn[2].to_f			
		else	
			if (firstline == false)
				puts "Balance for :" + person + " is §" + balance.to_s
			end
			firstline = false
			person = txn[0]
			balance = txn[2].to_f	 
		end
	  end
	  puts "Balance for :" + person + " is §" + balance.to_s
	else
		puts "No transactions found in ledger file for the given date"
	end
 end

get_balance("transactions.csv", "2015-01-17")
