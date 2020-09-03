namespace :dev do
  desc "Set dev environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner ("Deleting DB..."){%x(rails db:drop)}
      show_spinner ("Creating DB..."){%x(rails db:create)}
      show_spinner ("Migrating DB..."){%x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
      
    else
      puts " You are not in dev environment." 
    end  
  end


  desc "Add coins"
  task add_coins: :environment do
    show_spinner ("Adding coins...") do
    coins = [
      {
          description: "Litecoin",
          acronym: "LTC",
          url_image: "https://upload.wikimedia.org/wikipedia/commons/2/24/6_Full_Logo_S-2.png",
          mining_type: MiningType.all.sample
      },
      {
          description: "NEO",
          acronym: "NEO",
          url_image: "https://upload.wikimedia.org/wikipedia/commons/e/ea/Neo_symbol.svg",
          mining_type: MiningType.all.sample
      },
      {
        description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQvST0agouX8njt1-CxQfVz-Ra5WYpUFWrCFg&usqp=CAU",
          mining_type: MiningType.all.find_by(acronym: "PoW")
      },
      {
        description: "Etherium",
          acronym: "ETH",
          url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Ethereum-icon-purple.svg/1200px-Ethereum-icon-purple.svg.png",
          mining_type: MiningType.all.sample
      },
      {
        description: "Dash",
          acronym: "DASH",
          url_image: "https://www.pngkit.com/png/detail/135-1353048_dash-icon-dash-coin-logo-png.png",
          mining_type: MiningType.all.sample
      },
      {
        description: "Stellar",
          acronym: "XLM",
          url_image: "https://cdn4.iconfinder.com/data/icons/crypto-currency-and-coin-2/256/stellar_xlm-512.png",
          mining_type: MiningType.all.sample
      }
    ]
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Adding mining types"
  task add_mining_types: :environment do
    show_spinner ("Adding mining types...") do
      mining_types =[
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]
    
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end 
  end  
  private
    def show_spinner(msg_start, msg_end = "Done!")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin # Automatic animation with default interval
      yield
      spinner.success(msg_end)
    end
end