prost(1):-!,fail.
prost(A):-prost(A,2).
prost(A,A):-!.
prost(A,B):-R is A mod B,R=0,!,fail.
prost(A,B):-B1 is B+1,prost(A,B1).

pandig(A,N):-pandig(_,A,N,_,0,1),!.
pandig(_,_,N,_,N,_):-!.
pandig(A,0,N,_,K,0):-!,pandig(A,A,N,_,K,1).
pandig(_,B,N,_,K,1):-C is B mod 10, B1 is B div 10,K1 is K+1,pandig(B1,B1,N,C,K1,0),!.
pandig(_,B,_,C,_,0):-D is B mod 10,D=C,!,fail.
pandig(A,B,N,C,K,0):-B1 is B div 10,pandig(A,B1,N,C,K,0).

prov(0,N,N):-!.
prov(A,N,K):-K1 is K+1,R is A mod 10,R>0,R=<N,A1 is A div 10,prov(A1,N,K1),!.

numb(B,B,N,N,_):-!.
numb(A,B,N,K,Q):-K1 is K+1,M is K1*Q,S is B+M,Q1 is Q*10,numb(A,S,N,K1,Q1).

ind1:-read(N),max_pandig(N,Max_numb),write(Max_numb).
max_pandig(N,Max_numb):-max_pandig(N,Max_numb,0,0,0).
max_pandig(_,B,B,1,_):-!.
max_pandig(_,_,0,_,1):-!,fail.
max_pandig(N,A,0,0,0):-numb(B,0,N,0,1),max_pandig(N,A,B,0,1),!.
max_pandig(N,Max_numb,B,0,1):-prov(B,N,0),pandig(B,N),prost(B),max_pandig(N,Max_numb,B,1,1),!.
max_pandig(N,A,B,0,1):-B1 is B-1,max_pandig(N,A,B1,0,1).




