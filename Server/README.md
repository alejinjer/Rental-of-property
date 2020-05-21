## auth sercice

**GET** localhost:8080/auth?username=&password=
Returns user with following login and password

**POST** localhost:8080/auth?username=&password=&name=&surname=&email=&phone=
Create a new user

## search service

**GET** localhost:8080/apartments
Returns a list of apartments

**POST** localhost:8080/apartments?flats_number=&cost=&description=&address=&img_url=
Creates a new apartment

**PUT** localhost:8080/apartments?id=flats_number=&cost=&description=&address=&img_url=
Updates an apartment

**DELETE** localhost:8080/apartments?id=
Deletes an apartment
