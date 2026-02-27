# Rate Limiter REST API

A production-ready REST API rate limiter implemented in Bash.

## Badges
[![Build Status](https://travis-ci.org/travis-ci/travis-ci.svg?branch=master)](https://travis-ci.org/travis-ci/travis-ci)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

## Installation
1. Clone the repository: `git clone https://github.com/your-username/RateLimiter.git`
2. Install dependencies: `bash requirements.sh`
3. Create a `.env` file from the example: `cp .env.example .env`
4. Start the server: `bash main.sh`

## Usage
The API has the following endpoints:

* `GET /rate`: Returns the current rate limit status.
* `POST /rate`: Increments the rate limit counter.

Example usage with `curl`: