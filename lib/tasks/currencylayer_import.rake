namespace :currencylayer_import do
  desc "Daily import of most accurate currency"
  task daily: :environment do
    bank = Money.default_bank
    bank.expire_rates! if bank.expired?
    restructured_rates =
      Currencylayer::TargetRatesPresenter.new(bank.update_rates).restructure
    Currencylayer::RatingQuotes.new(bank.source,
                                    restructured_rates,
                                    bank.rates_timestamp)
                                .upsert
  end
end
