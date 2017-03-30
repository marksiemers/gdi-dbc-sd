CONTACTS = [
  { id: 1, url: '/contacts/1', first_name: "Mark", last_name: "Siemers", email: "mark.siemers@devbootcamp.com",
    interests: [{ description: 'Ruby', best: false }, { description: 'Making Sauerkraut', best: true }, { description: 'Volleyball', best: false }]
  },
  { id: 2, url: '/contacts/2', first_name: "Nate", last_name: "Kandler", email: "nate.kandler@devbootcamp.com",
    interests: [{ description: 'Guitar', best: true }, { description: 'JavaScript', best: false }, { description: 'Surfing', best: false }]
  },
  { id: 3, url: '/contacts/3', first_name: "Kevin", last_name: "Solorio", email: "kevin@devbootcamp.com",
    interests: [{ description: 'Swift', best: false }, { description: 'Flying Airplanes', best: true }, { description: 'Hockey', best: false }]
  },
  { id: 4, url: '/contacts/4', first_name: "Kimbra", last_name: "Brookstein", email: "kimbra.brookstein@devbootcamp.com",
    interests: [{ description: 'Social Media', best: false }, { description: 'Nephew', best: true }, { description: 'Homeownership', best: false }]
  },
  { id: 5, url: '/contacts/5', first_name: "Courtney", last_name: "Lach", email: "courtney@girldevelopit.com",
    interests: [{ description: 'GDI', best: true }, { description: 'Nittany Lions', best: true }]
  },
  { id: 6, url: '/contacts/6', first_name: "Shana", last_name: "Moore", email: "shana@girldevelopit.com",
    interests: [{ description: 'Ruby on Rails', best: true }, { description: 'Android Development', best: false }]
  }
]

def supported_request?
  true
end

before do
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
  status(415) and '' unless supported_request?
end

def should_return_json?
  (!request.preferred_type.nil? && request.preferred_type.entry == 'application/json') ||
  (request.accept?('application/json') && !request.accept?('text/html'))
end

def return_contacts
  if should_return_json?
    CONTACTS.to_json
  else
    erb :'contacts/index', layout: false
  end
end

get '/' do
  return_contacts
end

get '/contacts' do
  return_contacts
end

get '/contacts/json' do
  CONTACTS.to_json
end

def return_contact
  if should_return_json?
    contact.to_json
  else
    erb :'contacts/show', layout: false
  end
end

def return_404
  status 404
  return 'Contact not found'
end

def contact
  @contact ||= CONTACTS.find{|contact| contact[:id] == params[:id].to_i }
end

get '/contacts/:id' do
  if contact
    return_contact
  else
    return_404
  end
end

get '/contacts/:id/json' do
  contact.to_json
end
