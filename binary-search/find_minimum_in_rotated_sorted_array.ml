let find_min nums =
  let lhs = ref 0 in
  let rhs = ref (Array.length nums - 1) in

  while !lhs < !rhs do
    let mid = !lhs + ((!rhs - !lhs) / 2) in
    if nums.(mid) < nums.(!rhs) then rhs := mid else lhs := mid + 1
  done;
  nums.(!lhs)

let find_min2 nums =
  let rec binary_search lhs rhs =
    if lhs >= rhs then nums.(lhs)
    else
      let mid = lhs + ((rhs - lhs) / 2) in
      if nums.(mid) < nums.(rhs) then binary_search lhs mid
      else binary_search (mid + 1) rhs
  in
  binary_search 0 (Array.length nums - 1)

let () =
  let test_cases : (int array * int) list =
    [
      ([| 3; 4; 5; 6; 1; 2 |], 1);
      ([| 4; 5; 6; 1; 2; 3 |], 1);
      ([| 5; 1; 2; 3; 4 |], 1);
      ([| -2 |], -2);
      ([| 99; 1000; -999; -69 |], -999);
      ([| 4; 5; 0; 1; 2; 3 |], 0);
    ]
  in

  print_endline "Imperative implementation:";

  List.iter
    (fun (nums, expected) ->
      let got = find_min nums in
      Printf.printf "Expected: %d, Got: %d\n" expected got;
      assert (got = expected))
    test_cases;

  print_endline "\nRecursive implementation:";

  List.iter
    (fun (nums, expected) ->
      let got = find_min2 nums in
      Printf.printf "Expected: %d, Got: %d\n" expected got;
      assert (got = expected))
    test_cases
