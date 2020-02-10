function tocke = sampleT(t, n)

%naredi randomsample brez ponavljanja iz tock pcd
stTock = length(t);

tocke = zeros(n, 3);
randomIndices = randperm(stTock);
randomIndices = randomIndices(1:n);

%sample-ane tocke pcd datoteke (za hitrejsi izris tock)
tocke(1:n, 1) = t(randomIndices, 1);
tocke(1:n, 2) = t(randomIndices, 2);
tocke(1:n, 3) = t(randomIndices, 3);

end
    