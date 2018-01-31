"""
  `Sorted` should be the first argument to renorm
   when the values to be re-normalized are given
   in order of nonincreasing absolute magnitude.
   The value with the largest exponent is the most
   significant value and appears as the first one;
   the value with the smallest exponent (more negative)
   is the least significant value and appears after
   any other __nonzero__ contributors the the 
   extended precision significand.
"""
struct Sorted end




function renorm(a::T, b::T) where T<:Real
     return two_sum(a, b)
end

function renorm(::Type{Sorted}, a::T, b::T) where T<:Real
     return fast_two_sum(a, b)
end

function renorm(a::T, b::T, c::T) where T<:Real  
    t₁, t₂ = two_sum(b, c)
    t₃, t₁ = two_sum(a, t₁)
    t₁, t₂ = fast_two_sum(t₁,t₂)
  
    return t₁, t₂, t₃
end

function renorm(::Type{Sorted}, a::T, b::T, c::T) where T<:Real
    t₁, t₂ = fast_two_sum(b, c)
    t₃, t₁ = fast_two_sum(a, t₁)
    t₁, t₂ = fast_two_sum(t₁,t₂)
  
    return t₁, t₂, t₃
end
