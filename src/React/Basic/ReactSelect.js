"use strict";

var React = require("react");
var Select = require("react-select");

exports.singleSelect = function(unionDict) {
  return Select.default;
};

exports.multiSelect = function(unionDict) {
  return function(props) {
    return React.createElement(
      Select.default,
      Object.assign({ multi: true }, props)
    );
  };
};

exports.asyncSingleSelect = function(unionDict) {
  return Select.Async;
};

exports.asyncMultiSelect = function(unionDict) {
  return function(props) {
    return React.createElement(
      Select.Async,
      Object.assign({ multi: true }, props)
    );
  };
};
