610. Triangle Judgement

SELECT *, IF(x+y>z and y+z>x and z+x>y, "Yes", "No") AS triangle 
FROM Triangle;