## Matrices

Somme et produit de deux matrices.   
Ces fonctions sont valides seulement lorsque les dimensions sont correctes.   

## Utilisation

### Définition d'une Matrice

```elm
matr1 : Matrice number
matr1 = Matrice [[1,2],[3,4]]
```

### Somme de deux matrices

```elm 
matr1 = Matrice [[1,2],[3,4]]
matr2 = Matrice  [[1,2],[3,4],[5,6]]

s = somme matr1 matr2
--Just (Mat [[2,4],[6,8]])
```


### Produit de deux matrices


```elm
matr3 : Matrice number
matr3 = Matrice [[1,2,5],[3,4,6]]

matr4 : Matrice number
matr5 = Matrice [[1,2],[3,4],[5,6]]

p = produit matr3 matr4 
-- Just (Matrice [[32,40],[45,58]])

p2 = produit matr3 matr3
-- Nothing
```
