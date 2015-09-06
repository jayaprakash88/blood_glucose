json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :address, :age, :phone_no
  json.url patient_url(patient, format: :json)
end
