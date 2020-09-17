name: Build

on: [push]

jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2-beta
        with:
          node-version: '12'
      - run: docker pull pactfoundation/pact-cli:latest
      - name: install
        run: npm i
      - name: build
        run: TRAVIS_BRANCH=${TRAVIS_BRANCH:11} make ci
        env:
          PACT_BROKER_TOKEN: ${{ secrets.TEST_PACTFLOW_IO_PACT_BROKER_TOKEN }}
          PACT_BROKER_PUBLISH_VERIFICATION_RESULTS: true
          TRAVIS_COMMIT: ${{ github.sha }}
          TRAVIS_BRANCH: ${{ github.ref }}
