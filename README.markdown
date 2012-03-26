# AHValidation

## Overview

AHValidation is an extensible validation library designed specifically for Cocoa Touch. It allows one to add an arbitrary number of arbitrarily defined validation rules to any Cocoa object for the purpose of easily checking object validity and presenting user-friendly error messages. It does this by extending the `NSObject` class to provide methods for manipulating an object's associated collection of validation rules (objects of types deriving from `AHValidationRule`), along with the `validate` method, which returns a collection of zero or more messages corresponding to unfulfilled validation rules. The library provides a collection of pre-built rules, including `AHStringLengthRule`, `AHRegexRule`, and `AHNumericRangeRule` for achieving many common validation tasks. Adding new rules is as easy as providing a factory method for adding a rule to an object and defining a `passes` predicate which performs the actual validation test and returns the result as a boolean.

## Usage Examples

Using the library consists of two parts: adding validation rules to an object, and inquiring whether an object passes all its validation rules.

The `addValidationRule:` method is an extension to `NSObject` and is one way to add rules to an object. However, each subclass of `AHValidationRule` also supplies at least one utility method of the form `addRuleToObject:keyPath:message:` which allows one to attach rules in a more succinct manner. For example, to attach a rule requiring the `text` property of a `UITextField` to be between 5 and 50 characters, you could write this:

<pre>
    [AHStringLengthRule addRuleToObject:self.textField keyPath:@"text" 
                              minLength:[NSNumber numberWithInteger:5] 
                              maxLength:[NSNumber numberWithInteger:50] 
                                message:@"Username must be between 5 and 50 characters"];
</pre>

To retrieve the failure messages associated with any unfulfilled rules, simply call the `validate` method on an object with validation rules. If an object has no validation rules, or all of its rules are currently fulfilled, an empty array (**not** `nil`) will be returned.

## Built-In Rules and Their Usage

### AHStringLengthRule

This class provides two utility methods for performing validation against the length of NSString-valued properties:

`+addRuleToObject:keyPath:minLength:maxLength:message:` allows you to specify both upper and lower bounds on string length. The two numeric parameters are taken as `NSNumber`s and are optional. If either of them is missing, it is not validated against. If both of them are missing, a run-time assertion is triggered.

`+addNonemptyStringRuleToObject:keyPath:message:` is a specialized method for attaching a rule requiring the string property to be non-empty. It is equivalent to calling the previous method with a minLength of 1 and a maxLength of nil.

### AHNumericRangeRule

This class allows one to validate that a numeric value falls inside a given (inclusive) range. The following method adds a numeric range validation rule to an object:

`+addRuleToObject:keyPath:lowerBound:upperBound:message:`

The lowerBound and upperBound parameters function in much the same way as the minLength/maxLength parameters of the `AHStringLengthRule` class. If the property to be tested is not of `NSNumber` type, the class will attempt to coerce the value to a `double` by using the `doubleValue` method. If the receiving type does not implement `doubleValue`, an exception will be thrown. In general, this class should only be used to validate `NSNumber`s and strings whose contents can be correctly coerced to double type. Hopefully, this rule can be made more robust in the future.

### AHRegexRule

This class provides validation of string types against regexes. The rule passes if the property being tested has a match for the expression specified at rule creation time. The underlying `NSRegularExpression` object can be replaced at runtime. The class provides the following method for adding a regex rule to an object:

`+addRuleToObject:keyPath:expression:message:`, where the expression parameter takes a string to be compiled into a regular expression object. The matching is currently done in a case-insensitive manner, and allows the use of special characters `^` and `$` to mark the beginning and end of line, respectively. If other matching options are required, they can be added by a subclass of this rule class.

### AHObjectEqualityRule

This class provides validation of equality between properties on different objects. The rule passes if the objects are equal on the basis of the first object's `isEqual:` method. If the classes are not comparable (i.e., if the second object cannot be compared to the first object using the first's `isEqual` method), the result of this rule is undefined, including the possibility of a runtime exception.

## Extending the Library with New Rule Types

The `validate` method on `NSObject` iterates over the rules associated with an object and calls the `passes` predicate method on each one. If `passes` returns `NO`, the `failureMessage` property of the rule being tested is inserted into the message collection to be returned from `validate`. To add a new rule type, simply inherit from `AHValidationRule` and implement your own method for adding an instance of your subclass to the validation rule collection of an object. Then, implement the `passes` method to perform the test. For example, suppose you wanted to implement your own `StringPrefixRule`, which requires that a string value begins with another string (e.g., "Hello world" begins with "Hello"). Here is the entire implementation of such a class:

<pre>
+ (void)addRuleToObject:(id)obj keyPath:(NSString *)keyPath prefix:(NSString *)aPrefix message:(NSString *)message {
    AHValidationRule *rule = [[self alloc] initWithObject:obj keyPath:keyPath prefix:prefix message:message];
    [obj addValidationRule:rule];
}

- (id)initWithObject:(id)obj keyPath:(NSString *)keyPath prefix:(NSString *)aPrefix message:(NSString *)message {
   if((self = [super initWithObject:obj keyPath:keyPath message:message])) {
      prefix = aPrefix;
   }
   return self;
}

- (BOOL)passes {
   id value = [self.object valueForKey:self.keyPath];
   return [value hasPrefix:self.prefix];
}

You may wish to perform additional error checking, but this is essentially all that is required to implement a custom rule. 
