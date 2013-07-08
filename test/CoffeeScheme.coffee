should = require 'should'
CoffeeScheme = require("../src/CoffeeScheme").CoffeeScheme

describe 'CoffeeScheme', ->
    cs = null
    beforeEach ->
        cs = new CoffeeScheme
    afterEach ->

    it "should be a CoffeeScheme object", ->
        cs.should.be.a('object')

    it "should check a list", ->
        cs.should.have.property('checkList')
        cs.checkList( [1,2,3] ).should.be.ok
        cs.checkList( 1 ).should.not.be.ok

    it "should check a value", ->
        cs.should.have.property('checkValue')
        cs.checkValue( [1,2,3] ).should.not.be.ok
        cs.checkValue( 1 ).should.be.ok

    it "should have car", ->
        cs.should.have.property('car')
        cs.car( [1,2,3] ).should.equal 1
        should.not.exist cs.car( 1 )

    it "should have cdr", ->
        cs.should.have.property('cdr')
        cs.cdr( [1,2,3] ).should.eql [2,3]
        should.not.exist cs.cdr( 1 )

    it "should look up function", ->
        cs.should.have.property('lookUp')
        plus = cs.lookUp('+')
        plus( [1,2,3] ).should.equal 6

        minus = cs.lookUp('-')
        minus( [1,2,3] ).should.equal -4

        star = cs.lookUp('*')
        star( [1,2,3] ).should.equal 6

        slash = cs.lookUp('/')
        slash( [6,3] ).should.equal 2

    it "should have eval", ->
        cs.should.have.property('eval')
        cs.eval( 1 ).should.eql 1
        plus = cs.eval('+')
        plus( [1,2,3] ).should.equal 6
        cs.eval(['+', 1 ,2 ,3]).should.equal 6
        cs.eval(['-' ,['+', 1 ,2 ,3] , 5]).should.equal 1
        cs.eval(['*' ,['+', 1 ,2 ,3] , 5]).should.equal 30
        cs.eval(['/' ,['*' ,['+', 1 ,2 ,3] , 5],6]).should.equal 5
