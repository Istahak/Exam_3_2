-- Hamiltonian code

1. FUNCTION Hamiltonian_Cycle(G):
2.     Initialize path[] with -1
3.     Set path[0] = 0  // Start from vertex 0
4.     
5.     IF Hamiltonian_Util(G, path, 1) == TRUE:
6.         PRINT path[] and path[0] (to complete the cycle)
7.     ELSE:
8.         PRINT "No Hamiltonian Cycle exists"
9.     ENDIF
10. END FUNCTION

11. FUNCTION Hamiltonian_Util(G, path, pos):
12.     IF pos == |V|:  // If all vertices are in path
13.         IF G[path[pos-1]][path[0]] == 1:  // Check edge back to start
14.             RETURN TRUE
15.         ELSE:
16.             RETURN FALSE
17.         ENDIF
18.     ENDIF
       
19.     FOR v FROM 1 TO |V|-1:  // Try all vertices except 0
20.         IF Is_Safe(v, G, path, pos) == TRUE:
21.             path[pos] = v  // Add vertex to path
22.             
23.             IF Hamiltonian_Util(G, path, pos + 1) == TRUE:
24.                 RETURN TRUE
25.             ENDIF
               
26.             path[pos] = -1  // BACKTRACK
27.         ENDIF
28.     ENDFOR

29.     RETURN FALSE
30. END FUNCTION

31. FUNCTION Is_Safe(v, G, path, pos):
32.     IF G[path[pos - 1]][v] == 0:  // Check adjacency
33.         RETURN FALSE
34.     ENDIF
35.     FOR i FROM 0 TO pos-1:
36.         IF path[i] == v:  // Check if already included
37.             RETURN FALSE
38.         ENDIF
39.     ENDFOR
40.     RETURN TRUE
41. END FUNCTION



-- TSP problem B & B
1. FUNCTION TSP_Branch_Bound(cost_matrix):
2.     Create a priority queue Q
3.     Initialize root node with:
       - Level = 0
       - Path = [0] (Start from city 0)
       - Lower bound = Compute_Lower_Bound(cost_matrix)
       - Reduced matrix = Reduce_Cost_Matrix(cost_matrix)
4.     Insert root node into Q

5.     WHILE Q is not empty:
6.         Dequeue the node with the lowest bound from Q
7.         IF node level == N-1:
8.             Compute total cost of completing the cycle
9.             Update best_solution if cost is lower
10.            CONTINUE

11.        FOR each unvisited city j:
12.            Create a child node with:
13.                - Path extended with j
14.                - Updated reduced matrix
15.                - New lower bound
16.            IF child’s bound < current best solution:
17.                Insert child node into Q

18.     RETURN best_solution

19. FUNCTION Compute_Lower_Bound(matrix):
20.     Reduce each row and column by subtracting the smallest element
21.     Sum all reductions as the lower bound
22.     RETURN lower bound

23. FUNCTION Reduce_Cost_Matrix(matrix):
24.     Subtract row minima and column minima to obtain a reduced matrix
25.     RETURN reduced matrix



-- 0 / 1 Knapsack
1. FUNCTION Knapsack_Branch_Bound(W, weights, values, N):
2.     Compute value/weight ratio for each item
3.     Sort items in decreasing order of value/weight ratio
4.     
5.     Create a priority queue Q
6.     Create root node with:
       - Level = 0
       - Value = 0
       - Weight = 0
       - Upper bound = Compute_Bound(0, 0, 0)
7.     Insert root node into Q

8.     WHILE Q is not empty:
9.         Dequeue the node with the highest bound from Q
10.        IF node is a leaf (level == N) OR weight > W:
11.            CONTINUE

12.        Create left child (Include current item):
13.            - weight = node.weight + weights[level]
14.            - value = node.value + values[level]
15.            - Compute upper bound
16.            - IF weight ≤ W and bound > current best solution:
17.                Insert left child into Q

18.        Create right child (Exclude current item):
19.            - weight = node.weight
20.            - value = node.value
21.            - Compute upper bound
22.            - IF bound > current best solution:
23.                Insert right child into Q

24.     RETURN best solution

25. FUNCTION Compute_Bound(level, weight, value):
26.     IF weight ≥ W:
27.         RETURN 0  // Infeasible solution

28.     Initialize bound = value
29.     Remaining weight = W - weight

30.     FOR i = level TO N-1:
31.         IF weights[i] ≤ remaining weight:
32.             Add full item’s value to bound
33.             Subtract weight from remaining weight
34.         ELSE:
35.             Add fraction of item’s value (Greedy heuristic)
36.             BREAK
37.     RETURN bound


-- Job Assignment Problem


1. FUNCTION Job_Assignment_Branch_Bound(cost_matrix):
2.     N = number of jobs (size of matrix)
3.     Create a priority queue Q
4.     
5.     Create a root node with:
       - Level = 0
       - Assigned workers = []
       - Cost = 0
       - Lower bound = Compute_Lower_Bound(cost_matrix, [])
6.     Insert root node into Q

7.     best_solution = ∞

8.     WHILE Q is not empty:
9.         Dequeue the node with the lowest bound from Q
10.        IF node.level == N:  // All workers assigned
11.            UPDATE best_solution if node.cost is lower
12.            CONTINUE

13.        FOR each unassigned job j:
14.            Create child node with:
15.                - Assigned workers extended with (level → j)
16.                - Cost = node.cost + cost[level][j]
17.                - New lower bound = Compute_Lower_Bound(cost_matrix, assigned)
18.            IF lower bound < best_solution:
19.                Insert child into Q

20.     RETURN best_solution

21. FUNCTION Compute_Lower_Bound(cost_matrix, assigned):
22.     Initialize bound = sum of assigned costs
23.     FOR each unassigned worker:
24.         Add the minimum remaining cost for that worker
25.     RETURN bound


-- Algorithm Engineering Online Lectures