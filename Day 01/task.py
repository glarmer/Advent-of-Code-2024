list1, list2 = [], []
for line in open("input.txt","r").read().splitlines():
  list1.append(int(line.split("   ")[0]))
  list2.append(int(line.split("   ")[1]))
list1.sort()
list2.sort()
count, count2 = 0, 0
for i in range(len(list1)):
  occurances = 0
  count += abs(list1[i] - list2[i])
  for j in range(len(list2)):
    if list1[i] == list2[j]:
      occurances += 1
  count2 += list1[i] * occurances
print(count, " ", count2)