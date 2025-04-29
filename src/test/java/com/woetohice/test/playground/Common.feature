Feature: Common resources for all endpoint tests

Background:
    * def fakerType = Java.type('com.github.javafaker.Faker')
    * def faker = new fakerType()