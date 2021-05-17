import sys
import time


load('io.sage')
load('setup.sage')
load('heisvects.sage')
load('moreSetup.sage')
load('translate.sage')
load('allMyFunctions.sage')


#CoverBase(4.8,5,'baseTrs')

#CoverBall(4.8,12,'allTrs','baseTrs')

# at this point, a shell script chops up the output file into many pieces, each of which is dealt with separately in the next step.  They are all called Trs[num] and are numbered from 1-49.  The file 'shells.txt' describes their sizes, and how many parallel pieces we used for each. That information can also be gleaned from what's below in this file.


# a few pieces were small enough to just run without parallelizing.

#MakeCycles('Trs0',cycles0,1,0,3311)

#MakeCycles('Trs48','cycles48',300,0,221)

#MakeCycles('Trs49','cycles48',50,0,47)


#here's the part that parallelizes.  

import multiprocessing as mp

#pool = mp.Pool(mp.cpu_count())
#pool = mp.Pool(70)
#pool = mp.Pool(64)
#pool = mp.Pool(40)

#results=[]
#def collect_result(result):
 #   global results
  #  results.append(result)

#for num in range(60):
 #   pool.apply_async(MakeCycles, args=('Trs1','cycles1',110,num,6560), callback=collect_result)

#for num in range(100):
 #   pool.apply_async(MakeCycles, args=('Trs2','cycles2',3200,num,312685), callback=collect_result)

#for num in range(500):
 #   pool.apply_async(MakeCycles, args=('Trs3','cycles3',3000,num,1478190), callback=collect_result)

#for num in range(500):
 #   pool.apply_async(MakeCycles, args=('Trs4','cycles4',5200,num,2588308), callback=collect_result)

#for num in range(1000):
 #   pool.apply_async(MakeCycles, args=('Trs5','cycles5',3340,num,3332494), callback=collect_result)

#for num in range(1000):
 #   pool.apply_async(MakeCycles, args=('Trs6','cycles6',4101,num,4100361), callback=collect_result)

#for num in range(1000):
 #   pool.apply_async(MakeCycles, args=('Trs7','cycles7',4760,num,4756693), callback=collect_result)

#for num in range(1000):
 #   pool.apply_async(MakeCycles, args=('Trs8','cycles8',5070,num,5066351), #callback=collect_result)

#for num in range(1000):
 #   pool.apply_async(MakeCycles, args=('Trs9','cycles9',5020,num,5012086), #callback=collect_result)

#for num in range(1000):
 #   pool.apply_async(MakeCycles, args=('Trs10','cycles10',4710,num,4706852), callback=collect_result)

#for num in range(1000):
 #   pool.apply_async(MakeCycles, args=('Trs11','cycles11',4260,num,4254787), callback=collect_result)

#for num in range(1000):
 #   pool.apply_async(MakeCycles, args=('Trs12','cycles12',3750,num,3740926), callback=collect_result)

#for num in range(1000):
 #   pool.apply_async(MakeCycles, args=('Trs13','cycles13',3250,num,3247937), callback=collect_result)

#for num in range(700):
 #   pool.apply_async(MakeCycles, args=('Trs14','cycles14',4000,num,2799867), callback=collect_result)

for num in range(500):
    pool.apply_async(MakeCycles, args=('Trs15','cycles15',4800,num,2397784), callback=collect_result)

#for num in range(500):
 #   pool.apply_async(MakeCycles, args=('Trs16','cycles16',4110,num,2054506), callback=collect_result)

#for num in range(400):
 #   pool.apply_async(MakeCycles, args=('Trs17','cycles17',4400,num,1754672), callback=collect_result)

#for num in range(350):
 #   pool.apply_async(MakeCycles, args=('Trs18','cycles18',4250,num,1484063), callback=collect_result)

#for num in range(300):
 #   pool.apply_async(MakeCycles, args=('Trs19','cycles19',4200,num,1257646), callback=collect_result)

#for num in range(300):
 #   pool.apply_async(MakeCycles, args=('Trs20','cycles20',3600,num,1058799), callback=collect_result)

#for num in range(250):
 #   pool.apply_async(MakeCycles, args=('Trs21','cycles21',3600,num,885629), callback=collect_result)

#for num in range(200):
 #   pool.apply_async(MakeCycles, args=('Trs22','cycles22',3700,num,738498), callback=collect_result)

#for num in range(200):
 #   pool.apply_async(MakeCycles, args=('Trs23','cycles23',3060,num,610784), callback=collect_result)

#for num in range(150):
 #   pool.apply_async(MakeCycles, args=('Trs24','cycles24',3400,num,500698), callback=collect_result)

#for num in range(120):
 #   pool.apply_async(MakeCycles, args=('Trs25','cycles25',3400,num,407867), callback=collect_result)

#for num in range(120):
 #   pool.apply_async(MakeCycles, args=('Trs26','cycles26',2761,num,331206), callback=collect_result)

#for num in range(90):
 #   pool.apply_async(MakeCycles, args=('Trs27','cycles27',2970,num,266840), callback=collect_result)

#for num in range(90):
 #   pool.apply_async(MakeCycles, args=('Trs28','cycles28',2400,num,213531), callback=collect_result)

#for num in range(60):
 #   pool.apply_async(MakeCycles, args=('Trs29','cycles29',2830,num,169689), callback=collect_result)

#for num in range(60):
 #   pool.apply_async(MakeCycles, args=('Trs30','cycles30',2220,num,133052), callback=collect_result)

#for num in range(60):
 #   pool.apply_async(MakeCycles, args=('Trs31','cycles31',1750,num,104516), callback=collect_result)

#for num in range(54):
 #   pool.apply_async(MakeCycles, args=('Trs32','cycles32',1530,num,82505),callback=collect_result)

#for num in range(40):
 #   pool.apply_async(MakeCycles, args=('Trs33','cycles33',1610,num,64071),callback=collect_result)

#for num in range(32):
 #   pool.apply_async(MakeCycles, args=('Trs34','cycles34',1560,num,49625),callback=collect_result)

#for num in range(32):
 #   pool.apply_async(MakeCycles, args=('Trs35','cycles35',1180,num,37750),callback=collect_result)

#for num in range(16):
 #   pool.apply_async(MakeCycles, args=('Trs36','cycles36',1820,num,28984),callback=collect_result)

#for num in range(16):
 #   pool.apply_async(MakeCycles, args=('Trs37','cycles37',1410,num,22512),callback=collect_result)

#for num in range(16):
 #   pool.apply_async(MakeCycles, args=('Trs38','cycles38',1090,num,17410),callback=collect_result)

#for num in range(16):
 #   pool.apply_async(MakeCycles, args=('Trs39','cycles39',810,num,12920),callback=collect_result)

#for num in range(16):
 #   pool.apply_async(MakeCycles, args=('Trs40','cycles40',60,num,9590),callback=collect_result)

#for num in range(2):
 #   pool.apply_async(MakeCycles, args=('Trs41','cycles41',4600,num,7292),callback=collect_result)

#for num in range(16):
 #   pool.apply_async(MakeCycles, args=('Trs42','cycles42',350,num,5508),callback=collect_result)

#for num in range(16):
 #   pool.apply_async(MakeCycles, args=('Trs43','cycles43',252,num,4020),callback=collect_result)

#for num in range(16):
 #   pool.apply_async(MakeCycles, args=('Trs44','cycles44',168,num,2681),callback=collect_result)

#for num in range(10):
 #   pool.apply_async(MakeCycles, args=('Trs45','cycles45',160,num,1590),callback=collect_result)

#for num in range(10):
 #   pool.apply_async(MakeCycles, args=('Trs46','cycles46',100,num,966),callback=collect_result)

#for num in range(10):
 #   pool.apply_async(MakeCycles, args=('Trs47','cycles47',51,num,507),callback=collect_result)

#pool.close()
#pool.join()


# At this point, a shell script here combines all the cycles output files into one big file that's just called cycles.

# Then, finally, we make the magma file that contains the whole presesntation.

WriteMagmaFile('cycles','quaternions.m')

# the file describing how this was broken up into 10 pieces that could be loaded into magma without breaking the computer is called RECIPE.txt.




