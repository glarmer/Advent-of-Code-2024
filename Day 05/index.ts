import * as fs from "fs";
const text = fs.readFileSync("input.txt", "utf-8");

const splittedArray = text.split("\n\n");
const rules = splittedArray[0].split("\n");
const updates = splittedArray[1].split("\n");

let ruleMap: Map<string, string[]> = new Map();

rules.forEach((element) => {
  element = element.replace("\r", "");
  const rule = element.split("|");
  const number1 = rule[0];
  const number2 = rule[1];

  if (ruleMap.has(number1)) {
    ruleMap.get(number1)?.push(number2);
  } else {
    const numbers: string[] = [];
    numbers.push(number2);
    ruleMap.set(number1, numbers);
  }
});

let checkValid = function (ruleMap, update) {
  let valid = true;
  var index = 0;
  update.forEach((page) => {
    var priorPages = update.slice(0, index);
    if (ruleMap.has(page) && priorPages.length > 0) {
      const rules = ruleMap.get(page);
      rules?.forEach((rule) => {
        const index2 = priorPages.indexOf(rule);
        if (index2 > -1) {
          [update[index], update[index2]] = [update[index2], update[index]];
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

updates.forEach((element) => {
  element = element.replace("\r", "");
  const update = element.split(",");
  var valid = checkValid(ruleMap, update);
  if (!valid) {
    while (!valid) {
      valid = checkValid(ruleMap, update);
      console.log("Invalid");
      console.log(update);
    }
    taskTwoCount += +update[update.length / 2 - 0.5];
  } else {
    console.log(update);
    console.log(update[update.length / 2 - 0.5]);
    taskOneCount += +update[update.length / 2 - 0.5];
  }
});

console.log(taskOneCount);
console.log(taskTwoCount);
