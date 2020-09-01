module ApplicationHelper
    def date_us(date)
        date.strftime("%m/%d/%Y")
    end

    def app_name
        "Crypto Wallet App"
    end    
    def env_rails
       if Rails.env.development?
        "Development"
       elsif Rails.env.production?
        "Production"
       else
        "Test"
       end 
    end    
end
