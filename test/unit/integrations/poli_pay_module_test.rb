require 'test_helper'

class PoliPayModuleTest < Test::Unit::TestCase
  include OffsitePayments::Integrations

  def transaction_options
    {
      amount:       157.0,
      currency:     'AUD',
      return_url:   "http://example.org/return",
      homepage_url: 'http://example.org',
      password:     @password
    }
  end

  def test_token_url
    token = '6MIP8TMf1zwNfTnO2nx1+uq5Xd/6S7FN' # + to test escaping
    assert_equal "#{PoliPay::Interface.base_url}/Transaction/GetTransaction?token="+
                 '6MIP8TMf1zwNfTnO2nx1%2Buq5Xd%2F6S7FN',
                 PoliPay::QueryInterface.url(token)
  end

  def test_required_fields
    options = transaction_options.except(:homepage_url)
    assert_raise KeyError.new('key not found: :homepage_url') do
      PoliPay::Helper.new('22TEST', @login, options)
    end
  end
end
