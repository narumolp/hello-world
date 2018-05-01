

//: Playground - noun: a place where people can play

//test1


var str = "Welcome to Counting Sort Algorithm Playground\n"
print(str)
enum CountingSortError:Error {
  case emptyArray
}

func countingSort( _ inArray: [Int] ) throws -> [Int] {
  guard inArray.count > 0 else {
    throw CountingSortError.emptyArray
  }
  
  // example input_array:  [4, 0, 4, 2, 0, 3, 5, 5]
  
  // 1) First we create array ‘counts’ with the size of (maxValue - minValue + 1) and
  // initialize it by filling all elements with zeros.
  // e.g 5 - 0 + 1 = 6 our counts array will have a size of 6 and ranges from 0 to 5.
  // index  : [0, 1, 2, 3, 4, 5]
  // counts : [0, 0, 0, 0, 0, 0]
  
  let maxElement = inArray.max() ?? 0
  let minElement = inArray.min() ?? 0
  var counts = [Int].init(repeating: 0, count: maxElement + 1 - minElement)
  
  prettyPrint(array: inArray, title: "input: ")

  // 2) Construct key-value histrogram.
  // Count the occurence of each distict element in input array and store in 
  // 'counts' array. Also create 'keys' array to store all the distict
  // elements by constructing a range of numbers from min to max with an 
  // increment of 1. From the example we start from 0,1,2.. 5.
  // As you can see, '0' occurs twice, '5' occurs twice, '3' occurs once.
  // (Notice that we transpose array element into indices (position))
  // keys      : [0, 1, 2, 3, 4, 5]
  // counts    : [2, 0, 1, 1, 2, 2]
  
  let keys = Array(minElement...maxElement)
  for item in inArray {
    // normalize to index 0
    let idx =  item - minElement
    counts[idx] += 1
  }
  print("\n------- Step 1. ------- ")
  prettyPrint(array: keys, title: "keys:")
  prettyPrint(array: counts, title: "counts:")

  // 3) Make the prefixSums array whose element is calculated by following rule
  //    i)  prefixSums[0] = counts[0] , and
  //    ii) prefixSums[i] = prefixSums[i-1] + count[i]
  // Following our example,
  // keys       = [0, 1, 2, 3, 4, 5]
  // prefixSums = [2, 2, 3, 4, 6, 8]
  var prefixSums: [Int] = counts
  for idx in 1 ..< counts.count {
    prefixSums[idx] = prefixSums[idx - 1] + counts[idx]
  }
  //print("\n")
  print("\n------ Step 2. ------ ")
  prettyPrint(array: keys, title: "keys:")
  prettyPrint(array: prefixSums, title: "pfSums:")
  
  // 4) Make the final (sorted) array by reading out one element at a time
  // e.g looking at our input_array,
  // first we see number 4,
  //    find number 4 in ‘keys’ and we find 6 in ‘prefixSums’, so we put 4 under index 6.
  // The next number is 0,
  //    find number 0 in ‘keys’ and we find 2 in ‘prefixSums’, so we put 0 under index 2.
  // The next number is 4,
  //    find number 4 in ‘keys’ and we find 6 in ‘prefixSums’, so we put 4 under index 5
  //    (index 6 was already taken)
  // The next number is 2,
  //    find number 2 in ‘keys’ and we find 3 in ‘prefixSums’, so we put 2 under index 3.
  //
  // Continue on with the rest of elements from the input_array until finish.
  //
  // Remember, in step 2 we projected the elements of inputs array into
  // keys array ? now we do the opposite.
  // index:  [1, 2, 3, 4, 5, 6, 7, 8]
  // sorted: [0, 0, 2, 3, 4, 4 ,5, 5]
  // Note:
  //  Everytime we found (remove) an element of interest in 'keys'
  //  array we need to subtract 1 from 'prefixSums' array because we need to
  //  place the next redundant element in the 1 step lower index in our 
  //  final sorted array e.g there are 2 zero's, first 0 is placed at index 2
  //  the second 0 will be placed at index 1
  
  var sorted = [Int].init(repeating: 0, count: inArray.count)
  
  for idx in 0 ..< inArray.count {
    // reading out element from input array (key)
    let key = inArray[idx]
    
    // nomalize to index 0. This is for the case where
    // minimum value is not 0. E.g. input array of [3, 7, -11, 0, 12]
    // would have element -11 at index 1 and 12 at index 24
    let index = key - minElement

    // get the value by reading out from prefixSums table
    let prefixSumAtIndex = prefixSums[index]
    
    // place our element in sorted array
    // shift down by one because swift array starts at index 0.
    sorted[prefixSumAtIndex - 1] = key
  
    // reduce the number of count at the index by one
    prefixSums[index] -= 1
  }
  
  /* to print array of indeces */
  let indices = Array(1...inArray.count)
  
  print("\n------- Step 3. ------- ")
  prettyPrint(array: indices, title: "index:")
  prettyPrint(array: sorted, title: "sorted:")
  return sorted
}

func example1() {
  let array1 = [10, 7, -5, 11, 0, 1, 8, 7]
  print("\nREGULAR SIZE / RANGE \n")
  try? countingSort(array1)
}
func example2() {
  let array2 = [10, 6, 6, 7, 5, 10, 9, 9, 8, 5, 4, 4, 7]
  print("\nLARGE SIZE, SMALL RANGE \n")
  try? countingSort(array2)
}

func example3() {
  let array3: [Int] = [-7, 10]
  print("\nSMALL SIZE, LARGE RANGE \n")
  try? countingSort(array3)
}

/////////////////////////////////////////////////
/// Uncomment each line to run each example. ////
example1()
//example2()
//example3()



