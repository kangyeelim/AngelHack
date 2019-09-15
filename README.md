# README

# About
This is a Singapore stock screener website, created during Angelhack Singapore 2019. Stocks listed on SGX are screened according to an investing system, instead of specific financial ratios. 

Developers: Iskandar, Kang Yee, Jia Ying, Felicia, Evon

# Getting started:
1. git clone https://github.com/kangyeelim/AngelHack.git 

2. git update-index --assume-unchanged config/database.yml 

3. Install Postgresql and follow the instructions

4. If you are on Windows, go to config/database.yml and update your username and password. 

# Database initialisation
1. rake db:create (to create databases in your Postgresql account)
2. rake db:migrate
3. rake db:set_test_environment (to populate data in dev environment)

# Status:
This is an ongoing project. Instructions are subject to change, depending on what workflow we settle down to. 
