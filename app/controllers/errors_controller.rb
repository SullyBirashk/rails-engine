class ErrorsController < ActionController
  def not_found
    if get "/api/v1/merchants/:merchant_id/items" =~ /^\/api/
      render :json => {:status => "not-found"}.to_json, :code => 404
    else
      render :text => "404 Not found", :status => 404 # You can render your own template here
    end
  end
end
