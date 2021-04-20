# This script illustrates the Runge-Kutta RK-4
# time discretization method used in WRF 
# See Skamarock et al. (2019, NCAR/TN-556+STR) for further details
# 
# It solves the initial value problem specified as follows:
#    dy/dt = f(t,y), y(t0) = y0
# 
# Note that the function "f" below can be changed
# Here, we use the RK2 example from Wikipedia at
# https://en.wikipedia.org/wiki/Runge-Kutta_methods 
#
# And apply it to RK4, where the initial value problem 
# is as follows:
#    dy/dt = tan(y) + 1, y0 = 1, t in [1, 1.1]
#    step-size h = 0.025
#
# Developed by: Michel Mesquita, PhD
#               M2Lab.org
##################################################################
import math

# Input
h = 0.025 # step size
y0 = 1 
t0 = 1
n = 4  # number of steps 1, 2, ... n

# Function f(t,y)
def f(t,y):
    return math.tan(y)+1

# Runge-Kutta RK-4
def rk4(t0,y0,n,h): 
    print('n\tt\ty\tyn')
    print('--------------------------------')
    for i in range(n):
        k1 = h * (f(t0, y0))
        k2 = h * (f((t0+h/2), (y0+k1/2)))
        k3 = h * (f((t0+h/2), (y0+k2/2)))
        k4 = h * (f((t0+h), (y0+k3)))
        k = (k1+2*k2+2*k3+k4)/6
        yn = y0 + k
        print('%.0f\t%.4f\t%.4f\t%.4f'% (i+1,t0,y0,yn) )
        y0 = yn
        t0 = t0+h
    

# Running RK4
rk4(t0,y0,n,h)
