---
layout: post
category : development
tagline: 
tags : [development, c#, nunit]
title : Testing Template With NUnit
description: Testing Template With NUnit
---
{% include JB/setup %}

## Prerequisites

Visual Studio 2008-2013, NUnit (Obtained via Nuget), Moq (Obtained via Nuget)

## Overview

I've created a template for unit tests when using NUnit, I find it's really useful because it covers 95% of testing scenarios I encounter on a day-to-day basis.  I've followed the Given-When-Then terminology (Same as Arrange-Act-Assert) as it feels more natural to me.  It's always essentially down to preference but I like using this as a template because:

- Having a single point of object creation means it's really, really easy when refactoring signatures (especially if you don't have ReSharper)

- It reads well and it's intent is pretty clear i.e. the naming of the tests is very close to natural language 

- The [SetUp] and [TearDown] methods allow you to adequately prepare before each test which is useful if you're testing something like IO

There's no reason this can't be extended or even have this as a generic base class either.

{% highlight csharp %}
using Moq;
using NUnit.Framework;

namespace NUnitExample
{
    [TestFixture]
    public class TestExampleClass
    {
        #region Dependencies

        private Mock<IExampleMockDependency> _mockExampleDependency;

        #endregion

        [SetUp]
        public void SetupBeforeAllTests()
        {
            // Run code here which each test will need in order to run i.e. Create files/setup directories, initialise variables
            _mockExampleDependency = new Mock<IExampleMockDependency>();
        }

        [TearDown]
        public void TearDownAfterAllTests()
        {
            // Run code here which will tear down after each test i.e. Remove files created etc
        }

        /// <summary>
        /// Single method to create object so if the signature changes it only needs to be changed in one place
        /// </summary>
        /// <returns>Example class object</returns>
        private ExampleClass CreateObject()
        {
            return new ExampleClass(_mockExampleDependency);
        }

        /// <summary>
        /// Can also use [TestCases] to input the values if you are testing for multiple values
        /// </summary>
        [Test]
        public void GivenIHaveSomething_WhenIDoSomething_ThenSomethingShouldHappen()
        {
            // Given (setting up the mocks and the object itself to be tested)
            const int mockedExampleValue = 3;
            const int expectedResult = 16;

            _mockExampleDependency.Setup(x => x.MethodBelongingToDependency()).Returns(mockedExampleValue);
            var exampleClass = CreateObject();
            
            // When
            var result = exampleClass.MethodOnClassBeingTested();

            //Then
            Assert.AreEqual(result, expectedResult);
        }
    }
{% endhighlight %}

If anyone has any better way to achieve the same results, please let me know in the comments!
