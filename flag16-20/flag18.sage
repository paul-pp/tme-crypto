# Liste des empreintes MAC
empreintes_mac = [
    "64e5d0688eb26f5dca605ea0f7d32f9ff8772062ded3db867cb67e1927a02b13",
    "2511b92e04978a0672b0dac55e19604377c6b4731ff036320053da4fbb502204",
    "1380d5905d0d568d69076d53c7d4e8b28a1b9603e8c7dfc2ba994d7fe47e74b2",
    "18bbb54bbf7c3da0dae023814c694001dcf756b22c04f94969eea614b7946808",
    "7a85f244a222499ab0c150ab4c660180081f7c793897bf1de7d4a1c04ab4dcc4",
    "70cd4caa7daf31b43b9ad8a6743e2db1a754559ade139fc49f2368e42088c33a",
    "f6171a94a0f09283ec5162ab945614201d1dacf817f6d8fd5e89473f040ecdf8",
    "caa5cc7f281b9545375472633ed0a130cd02c10a7136661040a42d082ebcb9a7",
    "eb8ca096cf05f4ed17d4f8f5af269caff78c0d30dec3b7fb8fa60affea94872c",
    "595d5b6df7f043bb923463e679ec901c8ea53db61a0e817635c6da390d82d3ee",
    "1b381733a8bb5d1e1701a2c67aa46d5274ce864a4669bcc181c213876872557c",
    "78cebdc56f92159c56c39f61d6590b8ead53794a0c82dcfc3255fef576c9b2ac",
    "200bed8223d20d6493d2a496a132bafbdd9500152a7984a6dea4b6bdd09f04d8",
    "5453131c631c8f1df3861bb13c36116958c0b833c853008f1f823e63c19669f5",
    "e84af1b2c7fa827c6fce8503e73d3008fd0c9de1deaacab5df02e736bd63f0e2",
    "0b0ed092a2825deab09abe340795db3254009919d94ab468d9477716095732dd",
    "291f9a9008b91ce67b57a0a1df1eb424abe31ca0cd5d3c93b155fa87dd8d4ad7"
]

# Fonction d'extraction des parties X, A, B, C d'une empreinte
def extraire_X_A_B_C(empreinte):
    binaire = bin(int(empreinte, 16))[2:].zfill(256)
    return (
        int(binaire[0:64],2),
        int(binaire[64:128],2),
        int(binaire[128:192],2),
        int(binaire[192:256],2)
    )

# Extraction des neuf premiers éléments sans boucle
X1, A1, B1, C1 = extraire_X_A_B_C(empreintes_mac[0])
X2, A2, B2, C2 = extraire_X_A_B_C(empreintes_mac[1])
X3, A3, B3, C3 = extraire_X_A_B_C(empreintes_mac[2])
X4, A4, B4, C4 = extraire_X_A_B_C(empreintes_mac[3])
X5, A5, B5, C5 = extraire_X_A_B_C(empreintes_mac[4])
X6, A6, B6, C6 = extraire_X_A_B_C(empreintes_mac[5])
X7, A7, B7, C7 = extraire_X_A_B_C(empreintes_mac[6])
X8, A8, B8, C8 = extraire_X_A_B_C(empreintes_mac[7])
X9, A9, B9, C9 = extraire_X_A_B_C(empreintes_mac[8])


p = 2^64 - 59
Anneau = PolynomialRing(Zmod(p), 'x')
x = Anneau.gen()

# Construction du polynôme d'interpolation pour A
points = [
    (X1, A1), (X2, A2), (X3, A3),
    (X4, A4), (X5, A5), (X6, A6),
    (X7, A7), (X8, A8), (X9, A9)
]
polynome_R = Anneau.lagrange_polynomial(points)


cle = polynome_R(0)
cle_hex = hex(cle)[2:]

print(f"R(0) : {cle_hex}")
