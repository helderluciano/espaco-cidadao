class ApplicationController < ActionController::Base
   protect_from_forgery
   include SessionsHelper

   #rails generate migration add_comentariodados_to_comentarios micropost_id:integer user_id:integer
end
