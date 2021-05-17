def linorm(vect):
   linf = 0
   for t in vect:
        if abs(t) > linf:
            linf = abs(t)
   return linf


orig_stdout = sys.stdout


fout0 = open('/home/alice/output/Trs0','w')
fout1 = open('/home/alice/output/Trs1','w')
fout2 = open('/home/alice/output/Trs2','w')
fout3 = open('/home/alice/output/Trs3','w')
fout4 = open('/home/alice/output/Trs4','w')
fout5 = open('/home/alice/output/Trs5','w')
fout6 = open('/home/alice/output/Trs6','w')
fout7 = open('/home/alice/output/Trs7','w')
fout8 = open('/home/alice/output/Trs8','w')
fout9 = open('/home/alice/output/Trs9','w')
fout10 = open('/home/alice/output/Trs10','w')
fout11 = open('/home/alice/output/Trs11','w')
fout12 = open('/home/alice/output/Trs12','w')
fout13 = open('/home/alice/output/Trs13','w')
fout14 = open('/home/alice/output/Trs14','w')
fout15 = open('/home/alice/output/Trs15','w')
fout16 = open('/home/alice/output/Trs16','w')
fout17 = open('/home/alice/output/Trs17','w')
fout18 = open('/home/alice/output/Trs18','w')
fout19 = open('/home/alice/output/Trs19','w')
fout20 = open('/home/alice/output/Trs20','w')
fout21 = open('/home/alice/output/Trs21','w')
fout22 = open('/home/alice/output/Trs22','w')
fout23 = open('/home/alice/output/Trs23','w')
fout24 = open('/home/alice/output/Trs24','w')
fout25 = open('/home/alice/output/Trs25','w')
fout26 = open('/home/alice/output/Trs26','w')
fout27 = open('/home/alice/output/Trs27','w')
fout28 = open('/home/alice/output/Trs28','w')
fout29 = open('/home/alice/output/Trs29','w')
fout30 = open('/home/alice/output/Trs30','w')
fout31 = open('/home/alice/output/Trs31','w')
fout32 = open('/home/alice/output/Trs32','w')
fout33 = open('/home/alice/output/Trs33','w')
fout34 = open('/home/alice/output/Trs34','w')
fout35 = open('/home/alice/output/Trs35','w')
fout36 = open('/home/alice/output/Trs36','w')
fout37 = open('/home/alice/output/Trs37','w')
fout38 = open('/home/alice/output/Trs38','w')
fout39 = open('/home/alice/output/Trs39','w')
fout40 = open('/home/alice/output/Trs40','w')
fout41 = open('/home/alice/output/Trs41','w')
fout42 = open('/home/alice/output/Trs42','w')
fout43 = open('/home/alice/output/Trs43','w')
fout44 = open('/home/alice/output/Trs44','w')
fout45 = open('/home/alice/output/Trs45','w')
fout46 = open('/home/alice/output/Trs46','w')
fout47 = open('/home/alice/output/Trs47','w')
fout48 = open('/home/alice/output/Trs48','w')
fout49 = open('/home/alice/output/Trs49','w')
fin = open('/home/alice/output/allTrs','r')

for line in fin:
    pows = eval(line)
    linf = linorm(pows)

    name = 'fout'+str(linf)
    sys.stdout = eval(name)
    print pows
    sys.stdout = orig_stdout

fout0.close()
fout1.close()
fout2.close()
fout3.close()
fout4.close()
fout5.close()
fout6.close()
fout7.close()
fout8.close()
fout9.close()
fout10.close()
fout11.close()
fout12.close()
fout13.close()
fout14.close()
fout15.close()
fout16.close()
fout17.close()
fout18.close()
fout19.close()
fout20.close()
fout21.close()
fout22.close()
fout23.close()
fout24.close()
fout25.close()
fout26.close()
fout27.close()
fout28.close()
fout29.close()
fout30.close()
fout31.close()
fout32.close()
fout33.close()
fout34.close()
fout35.close()
fout36.close()
fout37.close()
fout38.close()
fout39.close()
fout40.close()
fout41.close()
fout42.close()
fout43.close()
fout44.close()
fout45.close()
fout46.close()
fout47.close()
fout48.close()
fout49.close()












