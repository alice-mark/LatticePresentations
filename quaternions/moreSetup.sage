depth1pts = []
depth2pts = []
depth3pts = []
depth4pts = []
depth234pts = []
depth24pts = []
for t in TFDpoints:
    d = depth(t[2][1])
    if d == 1:
        depth1pts.append(t)
    if d == 2:
        depth2pts.append(t)
        depth234pts.append(t)
        depth24pts.append(t)
    if d == 3:
        depth3pts.append(t)
        depth234pts.append(t)
    if d == 4:
        depth4pts.append(t)
        depth234pts.append(t)
        depth24pts.append(t)
