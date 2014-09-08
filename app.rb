require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require_relative 'models/contact'

LIMIT = 4

helpers do
  def not_last_page?(page_num)
    page_num < (Contact.all.length.to_f / LIMIT).ceil
  end

  def on_first_page?(page_num)
    page_num == 1
  end
end

get '/' do
  if params[:page]
    @page_num = params[:page].to_i

  else @page_num = 1
  end


  @contacts = Contact.limit(LIMIT).offset((@page_num - 1) * LIMIT)

  erb :index

end

get '/contact/:id' do
  @contact = Contact.find(params[:id])
end



