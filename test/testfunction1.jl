

function testFunction1(testFile,ephFiles,prefetch)

    eph = CalcephEphem(ephFiles)
    if prefetch
        CalcephPrefetch(eph)
    end

    con = CalcephConstants(eph)
    AU = con[:AU]
    
    f = open(testFile);
    for ln in eachline(f)
        elts=split(ln)
        jd0=parse(Float64,elts[1])
        target=parse(Int,elts[2])
        center=parse(Int,elts[3])
        dt = jd0 - trunc(Int,jd0);
        jd0 = trunc(Int,jd0) + 2.4515450000000000000E+06
        ref = [parse(Float64, x) for x in elts[4:end]]
        val = CalcephCompute(eph,jd0,dt,target,center)

        ϵ = 1.0e-8
        if (target==15)
            ϵ = 1.0e-7
            while val[3]>2π
                val[3]-=2π
            end
            while val[3]<=0
                val[3]+=2π
            end
        end
        for i in 1:6
            @test abs(ref[i]-val[i]) < ϵ
        end
        ref = val
        ϵ = 3.0e-15
        if target ∉ [15,16]
            val = CalcephComputeUnit(eph,jd0,dt,target,center,CalcephUnitAU+CalcephUnitDay)
            for i in 1:6
                @test abs(ref[i]-val[i]) < ϵ
            end
            val = CalcephComputeUnit(eph,jd0,dt,target,center,CalcephUnitAU+CalcephUnitSec)
            for i in 1:6
                if i>3
                    val[i]*=86400
                end
                @test abs(ref[i]-val[i]) < ϵ
            end
            ϵ = 3.0e-14;
            val = CalcephComputeUnit(eph,jd0,dt,target,center,CalcephUnitKM+CalcephUnitDay)
            for i in 1:6
                @test abs(ref[i]-val[i]/AU) < ϵ
            end

            val = CalcephComputeUnit(eph,jd0,dt,target,center,CalcephUnitKM+CalcephUnitSec)
            for i in 1:6
                if i>3
                    val[i]*=86400
                end
                @test abs(ref[i]-val[i]/AU) < ϵ
            end

        end

    end
    close(f)



end
