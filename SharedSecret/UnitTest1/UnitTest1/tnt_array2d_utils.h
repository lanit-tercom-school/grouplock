/*
*
* Template Numerical Toolkit (TNT)
*
* Mathematical and Computational Sciences Division
* National Institute of Technology,
* Gaithersburg, MD USA
*
*
* This software was developed at the National Institute of Standards and
* Technology (NIST) by employees of the Federal Government in the course
* of their official duties. Pursuant to title 17 Section 105 of the
* United States Code, this software is not subject to copyright protection
* and is in the public domain. NIST assumes no responsibility whatsoever for
* its use by other parties, and makes no guarantees, expressed or implied,
* about its quality, reliability, or any other characteristic.
*
*/


#ifndef TNT_ARRAY2D_UTILS_H
#define TNT_ARRAY2D_UTILS_H

#include <cstdlib>
#include <cassert>

namespace TNT
{

template <class T>
Array2D<T> operator+(const Array2D<T> &A, const Array2D<T> &B)
{
	int m = A.dim1();
	int n = A.dim2();

	if (B.dim1() != m ||  B.dim2() != n )
		return Array2D<T>();

	else
	{
		Array2D<T> C(m,n);

		for (int i=0; i<m; i++)
		{
			for (int j=0; j<n; j++)
				C[i][j] = A[i][j] + B[i][j];
		}
		return C;
	}
}

template <class T>
Array2D<T> operator-(const Array2D<T> &A, const Array2D<T> &B)
{
	int m = A.dim1();
	int n = A.dim2();

	if (B.dim1() != m ||  B.dim2() != n )
		return Array2D<T>();

	else
	{
		Array2D<T> C(m,n);

		for (int i=0; i<m; i++)
		{
			for (int j=0; j<n; j++)
				C[i][j] = A[i][j] - B[i][j];
		}
		return C;
	}
}


template <class T>
Array2D<T> operator*(const Array2D<T> &A, const Array2D<T> &B)
{
	int m = A.dim1();
	int n = A.dim2();

	if (B.dim1() != m || B.dim2() != n)
		return Array2D<T>();

	else
	{
		Array2D<T> C(m, n);

		for (int i = 0; i<m; i++)
		{
			for (int j = 0; j<n; j++)
				C[i][j] = A[i][j] * B[i][j];
		}
		return C;
	}
}





template <class T>
Array2D<T> operator/(const Array2D<T> &A, const Array2D<T> &B)
{
	int m = A.dim1();
	int n = A.dim2();

	if (B.dim1() != m ||  B.dim2() != n )
		return Array2D<T>();

	else
	{
		Array2D<T> C(m,n);

		for (int i=0; i<m; i++)
		{
			for (int j=0; j<n; j++)
				C[i][j] = A[i][j] / B[i][j];
		}
		return C;
	}
}





template <class T>
Array2D<T>&  operator+=(Array2D<T> &A, const Array2D<T> &B)
{
	int m = A.dim1();
	int n = A.dim2();

	if (B.dim1() == m ||  B.dim2() == n )
	{
		for (int i=0; i<m; i++)
		{
			for (int j=0; j<n; j++)
				A[i][j] += B[i][j];
		}
	}
	return A;
}



template <class T>
Array2D<T>&  operator-=(Array2D<T> &A, const Array2D<T> &B)
{
	int m = A.dim1();
	int n = A.dim2();

	if (B.dim1() == m ||  B.dim2() == n )
	{
		for (int i=0; i<m; i++)
		{
			for (int j=0; j<n; j++)
				A[i][j] -= B[i][j];
		}
	}
	return A;
}



template <class T>
Array2D<T>&  operator*=(Array2D<T> &A, const Array2D<T> &B)
{
	int m = A.dim1();
	int n = A.dim2();

	if (B.dim1() == m ||  B.dim2() == n )
	{
		for (int i=0; i<m; i++)
		{
			for (int j=0; j<n; j++)
				A[i][j] *= B[i][j];
		}
	}
	return A;
}





template <class T>
Array2D<T>&  operator/=(Array2D<T> &A, const Array2D<T> &B)
{
	int m = A.dim1();
	int n = A.dim2();

	if (B.dim1() == m ||  B.dim2() == n )
	{
		for (int i=0; i<m; i++)
		{
			for (int j=0; j<n; j++)
				A[i][j] /= B[i][j];
		}
	}
	return A;
}

/**
    Matrix Multiply:  compute C = A*B, where C[i][j]
    is the dot-product of row i of A and column j of B.


    @param A an (m x n) array
    @param B an (n x k) array
    @return the (m x k) array A*B, or a null array (0x0)
        if the matrices are non-conformant (i.e. the number
        of columns of A are different than the number of rows of B.)


*/
template <class T>
Array2D<T> matmult(const Array2D<T> &A, const Array2D<T> &B)
{
    if (A.dim2() != B.dim1())
        return Array2D<T>();

    int M = A.dim1();
    int N = A.dim2();
    int K = B.dim2();

    Array2D<T> C(M,K);

    for (int i=0; i<M; i++)
        for (int j=0; j<K; j++)
        {
            T sum; //גלוסעמ: T sum = 0
			sum = 0;

            for (int k=0; k<N; k++)
                sum += A[i][k] * B [k][j];

            C[i][j] = sum;
        }

    return C;

}

template <class T>
bool operator==(const Array2D<T> &A, const Array2D<T> &B)
{
	int m = A.dim1();
	int n = A.dim2();

	if (B.dim1() != m || B.dim2() != n)
		return false;

	else
	{

		for (int i = 0; i<m; i++)
		{
			for (int j = 0; j<n; j++)
				if (A[i][j] != B[i][j]) return false;
		}
		return true;
	}
}

template <class T>
Array2D<T> operator*(const Array2D<T> &A, T p)
{
	int m = A.dim1();
	int n = A.dim2();

	Array2D<T> C(m,n);

	for (int i=0; i<m; i++)
	{
		for (int j=0; j<n; j++)
			C[i][j] = A[i][j] * p;
	}
	return C;
}

template <class T>
Array2D<T> operator*(T p, const Array2D<T> &A)
{
	int m = A.dim1();
	int n = A.dim2();

	Array2D<T> C(m, n);

	for (int i = 0; i<m; i++)
	{
		for (int j = 0; j<n; j++)
			C[i][j] = A[i][j] * p;
	}
	return C;
}

template <class T>
Array2D<T> operator%(const Array2D<T> &A, int p)
{
	int m = A.dim1();
	int n = A.dim2();

	Array2D<T> C(m, n);

	for (int i = 0; i<m; i++)
	{
		for (int j = 0; j<n; j++)
			C[i][j] = A[i][j] % p;
	}
	return C;
}

template <class T>
Array2D<T> operator%(const Array2D<T> &A, const Array2D<T> &B)
{
	int m = A.dim1();
	int n = A.dim2();

	if (B.dim1() != m || B.dim2() != n)
		return Array2D<T>();

	else
	{
		Array2D<T> C(m, n);

		for (int i = 0; i<m; i++)
		{
			for (int j = 0; j<n; j++)
				C[i][j] = A[i][j] % B[i][j];
		}
		return C;
	}
}

template <class T>
T det(const Array2D<T> &A)
{
	int m = A.dim1();
	int n = A.dim2();
	
	if (m != n || m == 0) {
		T nul;
		nul = 0;
		return nul; //גלוסעמ: return 0;
	}

	if (m == 1) 
		return A[0][0];

	T d;
	d = 0; //גלוסעמ: T d = 0;;

	for (int i = 0; i<n; ++i)
	{
		Array2D<T> B(n - 1, n - 1);

		for (int y = 1; y<n; y++)
			for (int x = 0; x<n; x++)
			{
				if (x == i) continue;
				if (x<i)
					B[x][y - 1] = A[x][y];
				else
					B[x - 1][y - 1] = A[x][y];
			}

		if (i % 2)
			d -= A[i][0] * det(B);
		else
			d += A[i][0] * det(B);
	}

	return d;
}

template <class T>
Array2D<T> minor(const Array2D<T> &A, int row, int col)
{
	int m = A.dim1();
	int n = A.dim2();

	if (m == 0 || n == 0)
		return Array2D<T>();

	if (m == 1 || n == 1)
		return Array2D<T>(0, 0);

	Array2D<T> B(m - 1, n - 1);

	int in = 0;
	for (int i = 0; i<m; i++) 
		if (i != row) 
		{
			int jn = 0;
			for (int j = 0; j<n; j++) 
				if (j != col)
				{
					B[in][jn] = A[i][j];
					jn++;
				}					
			in++;
		}

	return B;
}

/*
	Minor Matrix
*/

template <class T>
Array2D<T> allied(const Array2D<T> &A)
{
	int m = A.dim1();
	int n = A.dim2();

	if (m == 0 || n == 0)
		return Array2D<T>();

	if (m == 1 || n == 1)
		return Array2D<T>(1, 1);

	Array2D<T> B(m, n);

	for (int i = 0; i<m; i++) {
		for (int j = 0; j<n; j++) {
			T a;
			a = (i + j) % 2 ? -1 : 1;
			B[i][j] = det(minor(A, i, j)) * a; //גלוסעמ: B[i][j] = det(minor(A, i, j)) * ((i + j) % 2 ? -1 : 1);
		}
	}
	return B;
}

template <class T>
Array2D<T> inverse(const Array2D<T> &A)
{
	int m = A.dim1();
	int n = A.dim2();
	T d = det(A); //double d = det(A);
	
	T null;
	null = 0;
	
	if (m != n || m == 0 || d == null)//גלוסעמ: d == 0
		return Array2D<T>();

	if (m == 1 || n == 1)
		return Array2D<T>(1, 1);

	Array2D<T> B(m, n);

	T one;
	one = 1;
	T a = one / d;
	B = !allied(A) * a; //גלוסעמ: B = !allied(A) * (1 / d);

	return B;
}

template <class T>
Array2D<T> operator!(Array2D<T> &A)
{
	int m = A.dim1();
	int n = A.dim2();

	Array2D<T> B(n, m);

	for (int i = 0; i<m; i++)
		for (int j = 0; j<n; j++)
			B[j][i] = A[i][j];

	return B;
}



} // namespace TNT

#endif
