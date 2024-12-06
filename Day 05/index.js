"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var fs = require("fs");
var text = fs.readFileSync("input.txt", "utf-8");
var splittedArray = text.split("\n\n");
var rules = splittedArray[0].split("\n");
var updates = splittedArray[1].split("\n");
var ruleMap = new Map();
rules.forEach(function (element) {
    var _a;
    element = element.replace("\r", "");
    var rule = element.split("|");
    var number1 = rule[0];
    var number2 = rule[1];
    if (ruleMap.has(number1)) {
        (_a = ruleMap.get(number1)) === null || _a === void 0 ? void 0 : _a.push(number2);
    }
    else {
        var numbers = [];
        numbers.push(number2);
        ruleMap.set(number1, numbers);
    }
});
var checkValid = function (ruleMap, update) {
    var valid = true;
    var index = 0;
    update.forEach(function (page) {
        var priorPages = update.slice(0, index);
        if (ruleMap.has(page) && priorPages.length > 0) {
            var rules_1 = ruleMap.get(page);
            rules_1 === null || rules_1 === void 0 ? void 0 : rules_1.forEach(function (rule) {
                var _a;
                var index2 = priorPages.indexOf(rule);
                if (index2 > -1) {
                    _a = [update[index2], update[index]], update[index] = _a[0], update[index2] = _a[1];
                    valid = false;
                }
            });
        }
        index += 1;
    });
    return valid;
};
var taskOneCount = 0;
var taskTwoCount = 0;
updates.forEach(function (element) {
    element = element.replace("\r", "");
    var update = element.split(",");
    var valid = checkValid(ruleMap, update);
    if (!valid) {
        while (!valid) {
            valid = checkValid(ruleMap, update);
            console.log("Invalid");
            console.log(update);
        }
        taskTwoCount += +update[update.length / 2 - 0.5];
    }
    else {
        console.log(update);
        console.log(update[update.length / 2 - 0.5]);
        taskOneCount += +update[update.length / 2 - 0.5];
    }
});
console.log(taskOneCount);
console.log(taskTwoCount);
