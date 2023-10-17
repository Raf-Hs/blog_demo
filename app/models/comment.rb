class Comment < ApplicationRecord
  belongs_to :post

  # Agrega una validación para el campo 'email' usando una expresión regular
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "debe ser una dirección de correo válida" }
end
