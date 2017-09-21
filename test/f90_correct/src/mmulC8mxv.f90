!** Copyright (c) 1989, NVIDIA CORPORATION.  All rights reserved.
!**
!** Licensed under the Apache License, Version 2.0 (the "License");
!** you may not use this file except in compliance with the License.
!** You may obtain a copy of the License at
!**
!**     http://www.apache.org/licenses/LICENSE-2.0
!**
!** Unless required by applicable law or agreed to in writing, software
!** distributed under the License is distributed on an "AS IS" BASIS,
!** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!** See the License for the specific language governing permissions and
!** limitations under the License.

!* Tests for runtime library MATMUL routines

program p

  parameter(NbrTests=176)

  complex*8, dimension(4,3) :: arr1
  complex*8, dimension(3) :: arr2
  complex*8, dimension(4) :: arr3
  complex*8, dimension(4,4) :: arr4
  complex*8, dimension(0:3,-1:1) :: arr5
  complex*8, dimension(-3:-1) :: arr6
  complex*8, dimension(-1:2,0:3) :: arr7
  complex*8, dimension(2:5,2:4) :: arr8
  complex*8, dimension(2:4) :: arr9
  complex*8, dimension(2:5) :: arr10
  complex*8, dimension(4) :: arr11

  data arr1 /(0,1),(1,2),(2,3),(3,4), &
             (4,3),(5,4),(6,5),(7,6), &
             (8,8),(9,9),(10,10),(11,11)/
  data arr2 /(0,2),(1,3),(2,1)/
  data arr3 /(0,4),(1,3),(2,2),(3,1)/
  data arr4 /(0,1),(1,2),(2,3),(3,4), &
             (4,3),(5,2),(6,1),(7,0), &
             (8,0),(9,10),(10,11),(11,12), &
             (12,11),(13,10),(14,9),(15,8)/
  data arr5 /(0,-1),(1,-2),(2,-3),(3,-4), &
             (4,-3),(5,-2),(6,-1),(7,0), &
             (8,-7),(9,-8),(10,-9),(11,11)/
  data arr6 /(0,5),(1,4),(2,3)/
  data arr7 /(0,1),(1,2),(2,3),(3,4), &
             (4,-7),(5,-6),(6,-5),(7,-4), &
             (8,11),(9,10),(10,9),(11,10), &
             (12,-15),(13,-14),(14,-13),(15,-12)/
 data arr8 /(0,1),(1,2),(2,3),(3,4), &
             (4,3),(5,4),(6,5),(7,6), &
             (8,8),(9,9),(10,10),(11,11)/
  data arr9 /(0,2),(1,3),(2,1)/
  data arr10 /(0,4),(1,3),(2,2),(3,1)/

  complex*8 :: expect(NbrTests)
  complex*8 :: results(NbrTests)

  data expect /  &
  !test 1-8
  (1.000000,39.00000), (-2.000000,48.00000), (-5.000000,57.00000), &
  (-8.000000,66.00000), &
  !test 9-16
  (0.000000,0.000000), (-2.000000,48.00000), (-5.000000,57.00000), &
  (-8.000000,66.00000), &
  !test 17-24
  (-2.000000,48.00000), (-5.000000,57.00000), (-8.000000,66.00000), &
  (0.000000,0.000000), &
  !test 25-32
  (0.000000,0.000000), (1.000000,39.00000), (-2.000000,48.00000), &
  (-5.000000,57.00000), &
  !test 33-40
  (0.000000,0.000000), (-11.00000,21.00000), (-15.00000,27.00000), &
  (-19.00000,33.00000), &
  !test 41-48
  (-22.00000,40.00000), (-26.00000,46.00000), (-30.00000,52.00000), &
  (-34.00000,58.00000), &
  !test 49-56
  (2.000000,11.00000), (1.000000,18.00000), (0.000000,25.00000), &
  (-1.000000,32.00000), &
  !test 57-64
  (0.000000,0.000000), (2.000000,11.00000), (1.000000,18.00000), &
  (0.000000,25.00000), &
  !test 65-72
  (-26.00000,46.00000), (-30.00000,52.00000), (-34.00000,58.00000), &
  (0.000000,0.000000), &
  !test 73-80
  (5.000000,29.00000), (4.000000,34.00000), (3.000000,39.00000), &
  (0.000000,0.000000), &
  !test 81-88
  (0.000000,0.000000), (2.000000,11.00000), (0.000000,0.000000), &
  (0.000000,25.00000), &
  !test 89-96
  (-26.00000,46.00000), (0.000000,0.000000), (-34.00000,58.00000), &
  (0.000000,0.000000), &
  !test 97-128
  (0.000000,0.000000), (-26.00000,46.00000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (-34.00000,58.00000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), &
  !test 129-160
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (-26.00000,46.00000), &
  (0.000000,0.000000), (-34.00000,58.00000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), &
  !test 161-192
  (0.000000,0.000000), (51.00000,53.00000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (-33.00000,90.00000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), &
  !test 192-224
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (55.00000,29.00000), &
  (0.000000,0.000000), (-4.000000,83.00000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), &
  !test 225-232
  (3.000000,39.00000), (4.000000,34.00000), (5.000000,29.00000), &
  (0.000000,0.000000), &
  !test 233-240
  (-26.00000,46.00000), (0.000000,0.000000), (-34.00000,58.00000), &
  (0.000000,0.000000), &
  !test 241-272
  (0.000000,0.000000), (-34.00000,58.00000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (-26.00000,46.00000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), &
  !test 273-304
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (-26.00000,46.00000), &
  (0.000000,0.000000), (-34.00000,58.00000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), &
  !test 305-336
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (55.00000,29.00000), &
  (0.000000,0.000000), (-4.000000,83.00000), (0.000000,0.000000), &
  (0.000000,0.000000), (0.000000,0.000000), (0.000000,0.000000), &
  (0.000000,0.000000), &
  !test 337-344
  (5.000000,29.00000), (4.000000,34.00000), (3.000000,39.00000), &
  (0.000000,0.000000), &
  !test 345-352
  (1.000000,39.00000), (-2.000000,48.00000), (-5.000000,57.00000), &
  (-8.000000,66.00000)/

  results = -1

  ! tests 1-8
  arr3=0
  arr3 = matmul(arr1,arr2)
  call assign_result(1,4,arr3,results)
  !print *,"test 1,8"
  !print *,arr3
  
  ! tests 9-16
  arr3=0
  arr3(2:4) = matmul(arr1(2:4,:),arr2)
  call assign_result(5,8,arr3,results)
  !print *,"test 9,16"
  !print *,arr3
  
  ! tests 17-24
  arr3=0
  arr3(1:3) = matmul(arr1(2:4,:),arr2)
  call assign_result(9,12,arr3,results)
  !print *,"test 17,24"
  !print *,arr3
  
  !tests 25-32
  arr3=0
  arr3(2:4) = matmul(arr1(1:3,:),arr2)
  call assign_result(13,16,arr3,results)
  !print *,"test 25,32"
  !print *,arr3
  
  !tests 33-40
  arr3=0
  arr3(2:4) = matmul(arr1(2:4,1:2),arr2(1:2))
  call assign_result(17,20,arr3,results)
  !print *,"test 33,40"
  !print *,arr3
  
  !tests 41-48
  arr3=0
  arr3 = matmul(arr1(:,2:3),arr2(1:2))
  call assign_result(21,24,arr3,results)
  !print *,"test 41,48"
  !print *,arr3
  
  !tests 49-56
  arr3=0
  arr3 = matmul(arr1(:,1:2),arr2(2:3))
  call assign_result(25,28,arr3,results)
  !print *,"test 49,56"
  !print *,arr3
  
  !tests 57-64
  arr3=0
  arr3(2:4)  = matmul(arr1(1:3,1:2),arr2(2:3))
  call assign_result(29,32,arr3,results)
  !print *,"test 57,64"
  !print *,arr3
  
  !tests 65-72
  arr3=0
  arr3(1:3)  = matmul(arr1(2:4,2:3),arr2(1:2))
  call assign_result(33,36,arr3,results)
  !print *,"test 65,72"
  !print *,arr3
  
  !tests 73-80
  arr3=0
  arr3(1:3) = matmul(arr1(2:4,1:3:2),arr2(1:3:2))
  call assign_result(37,40,arr3,results)
  !print *,"test 73,80"
  !print *,arr3
  
  !tests 81-88
  arr3=0
  arr3(2:4:2)  = matmul(arr1(1:3:2,1:2),arr2(2:3))
  call assign_result(41,44,arr3,results)
  !print *,"test 81,88"
  !print *,arr3
  
  !tests 89-96
  arr3=0
  arr3(1:3:2)  = matmul(arr1(2:4:2,2:3),arr2(1:2))
  call assign_result(45,48,arr3,results)
  !print *,"test 89,96"
  !print *,arr3
  
  !tests 97-128
  arr4=0
  arr4(2,1:3:2)  = matmul(arr1(2:4:2,2:3),arr2(1:2))
  call assign_result(49,64,arr4,results)
  !print *,"test 97,128"
  !print *,arr4
  
  !tests 129-160
  arr4=0
  arr4(1:3:2,3)  = matmul(arr1(2:4:2,2:3),arr2(1:2))
  call assign_result(65,80,arr4,results)
  !print *,"test 129,160"
  !print *,arr4
  
  !tests 161-192
  arr7=0
  arr7(0,0:2:2)  = matmul(arr5(1:3:2,0:1),arr6(-3:-2))
  call assign_result(81,96,arr7,results)
  !print *,"test 161,192"
  !print *,arr7
  
  !tests 193-224
  arr7=0
  arr7(-1:1:2,2)  = matmul(arr5(1:3:2,0:1),arr6(-2:-1))
  call assign_result(97,112,arr7,results)
  !print *,"test 193,224"
  !print *,arr7
  
  !tests 225-332
  arr3=0
  arr3(3:1:-1) = matmul(arr1(2:4,3:1:-2),arr2(3:1:-2))
  call assign_result(113,116,arr3,results)
  !print *,"test 225,332"
  !print *,arr3
  
  !tests 333-240
  arr3=0
  arr3(3:1:-2)  = matmul(arr1(4:2:-2,2:3),arr2(1:2))
  call assign_result(117,120,arr3,results)
  !print *,"test 333,240"
  !print *,arr3
  
  !tests 241,272
  arr4=0
  arr4(2,3:1:-2)  = matmul(arr1(2:4:2,2:3),arr2(1:2))
  call assign_result(121,136,arr4,results)
  !print *,"test 241,272"
  !print *,arr4
  
  !tests 273-304
  arr4=0
  arr4(3:1:-2,3)  = matmul(arr1(4:2:-2,2:3),arr2(1:2))
  call assign_result(137,152,arr4,results)
  !print *,"test 273,304"
  !print *,arr4
  
  !tests 305-336
  arr7=0
  arr7(1:-1:-2,2)  = matmul(arr5(3:1:-2,0:1),arr6(-2:-1))
  call assign_result(153,168,arr7,results)
  !print *,"test 305,336"
  !print *,arr7
  
  !tests 337-344
  arr3=0
  arr3(1:3) = matmul(arr1(2:4,3:1:-2),arr2(3:1:-2))
  call assign_result(169,172,arr3,results)
  !print *,"test 337,344"
  !print *,arr3

  arr11 = 0

  ! tests 337-344
  arr10=0
  arr10 = arr11 + matmul(arr8,arr9)
  call assign_result(173,176,arr10,results)
  !print *,"test 337,344"
  !print *,arr10

  call check(results, expect, NbrTests*2)

end program

subroutine assign_result(s_idx, e_idx , arr, rslt)
  complex*8, dimension(1:e_idx-s_idx+1) :: arr
  complex*8, dimension(e_idx) :: rslt
  integer:: s_idx, e_idx

  rslt(s_idx:e_idx) = arr

end subroutine

