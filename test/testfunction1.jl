

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
        val0 = val[:]
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
        ref = val0
        ϵ = 3.0e-15
        if target ∉ [15,16,17]
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

            ϵ = 3.0e-15
            val = CalcephComputeOrder(eph,jd0,dt,target,center,CalcephUnitDay+CalcephUnitAU,3)
            @test length(val)==12
            for i in 1:6
                @test abs(ref[i]-val[i]) < ϵ
            end

            ref = val
            val = CalcephComputeOrder(eph,jd0,dt,target,center,CalcephUnitDay+CalcephUnitAU,2)
            @test length(val)==9
            for i in 1:9
                @test abs(ref[i]-val[i]) < ϵ
            end
            val = CalcephComputeOrder(eph,jd0,dt,target,center,CalcephUnitDay+CalcephUnitAU,1)
            @test length(val)==6
            for i in 1:6
                @test abs(ref[i]-val[i]) < ϵ
            end
            val = CalcephComputeOrder(eph,jd0,dt,target,center,CalcephUnitDay+CalcephUnitAU,0)
            @test length(val)==3
            for i in 1:3
                @test abs(ref[i]-val[i]) < ϵ
            end

            ϵ = 3.0e-14
            val = CalcephComputeOrder(eph,jd0,dt,target,center,CalcephUnitSec+CalcephUnitKM,3)
            @test length(val)==12
            for i in 1:12
                if i>3
                    val[i]*=86400
                end
                if i>6
                    val[i]*=86400
                end
                if i>9
                    val[i]*=86400
                end
                @test abs(ref[i]-val[i]/AU) < ϵ
            end



        elseif target == 15
            val = CalcephComputeUnit(eph,jd0,dt,target,center,CalcephUnitRad+CalcephUnitDay)
            for i in 1:6
                @test abs(ref[i]-val[i]) < ϵ
            end
            val = CalcephComputeUnit(eph,jd0,dt,target,center,CalcephUnitRad+CalcephUnitSec)
            for i in 1:6
                if i>3
                    val[i]*=86400
                end
                @test abs(ref[i]-val[i]) < ϵ
            end
        elseif target ∈ [16,17]
            val = CalcephComputeUnit(eph,jd0,dt,target,center,CalcephUnitSec)
            for i in 1:6
                @test abs(ref[i]-val[i]) < ϵ
            end
            val = CalcephComputeUnit(eph,jd0,dt,target,center,CalcephUnitDay)
            for i in 1:6
                if i<=3
                    val[i]*=86400
                end
                @test abs(ref[i]-val[i]) < ϵ
            end
        end

    end
    close(f)



end
