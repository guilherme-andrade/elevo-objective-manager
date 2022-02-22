## Usage

Clone the repository and run the following commands from the root of the repository:

```sh
docker compose build
docker compose run --rm server rails db:create db:migrate db:seed
docker compose up
```

## Running Tests

From the root of the repository, run the following command:

```sh
docker compose run --rm server rspec
```

> Note: 2 tests are failing in the current version of the project, both of them related to mistakes in my implementation of the tests using the rswag gem.




