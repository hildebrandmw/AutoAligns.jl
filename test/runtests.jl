using AutoAligns
using Base.Test

import AutoAligns: align, get_alignment

## test alignment building blocks
@test align(left, "foo", 8) == "foo     "
@test align(right, "foo", 8) == "     foo"
@test align(center, "foo", 8) == "   foo  "

## test default alignment determination
@test get_alignment(left, 0) == left
@test get_alignment(right, 0) == right
@test get_alignment(center, 0) == center
@test_throws MethodError get_alignment(119, 0)
let v = [left, right, center]
    @test get_alignment(v, 1) == left
    @test get_alignment(v, 2) == right
    @test get_alignment(v, 3) == center
    @test get_alignment(v, 4) == center # default
end
let d = Dict(1 => left, 2 => right, 3 => center, :default => center)
    @test get_alignment(d, 1) == left
    @test get_alignment(d, 2) == right
    @test get_alignment(d, 3) == center
    @test get_alignment(d, 4) == center # default
end

## example 1
let s = """
1   2     3
foo bar baz
 5   55 555
"""
    aa = AutoAlign(alignment = Dict(:default => left, 5 => right))
    println(aa, 1, " ", 2, " ", 3)
    println(aa, "foo", " ", "bar", " ", "baz")
    aa.alignment = center
    println(aa, 5, " ", 55, " ", 555)
    @test string(aa) == s
end

# ## example 2 (ragged, no final newline, default from Dict)
# let s = """
#      1 2   3
# ragged
# 0      44 55"""
#     aa = AutoAlign(default = Dict(:default => right, 2 => left))
#     println(aa, 1, left, " ", 2, " ", 3)
#     println(aa, "ragged")
#     println(aa, left, 0, 44, 55)
#     @test string(aa) == s
# end
