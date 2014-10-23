// Example 1: ARIMA model
use http://www.stata-press.com/data/r12/wpi1, clear
arima wpi, arima(1,1,1)
arima wpi, arima(1,1,1) diffuse

// Example 2: ARIMA model with additive seasonal effects
arima D.ln_wpi, ar(1) ma(1 4)

// Example 3: Multiplicative SARIMA model
use http://www.stata-press.com/data/r12/air2, clear
generate lnair = ln(air)
arima lnair, arima(0,1,1) sarima(0,1,1,12) noconstant

// Example 4: ARMAX model
use http://www.stata-press.com/data/r12/friedman2, clear
arima consump m2 if tin(, 1981q4), ar(1) ma(1)

// Predict - Example 1: Predict, dynamic forecasts
use http://www.stata-press.com/data/r12/friedman2, clear
keep if time<=tq(1981q4)arima consump m2 if tin(, 1978q1), ar(1) ma(1)
predict chat, y
predict chatdy, dynamic(tq(1978q1)) y
// Predict - Example 1, part 2: Forecasts
// Note: in the previous example, because `consump`
// was still non-missing for the "out-of-sample" component, it simply
// amounts to in-sample prediction with fixed parameter (that happen
// to have been defined by MLE on a subset of the observations)
// Here make those observations missing so that we get true forecasts.
use http://www.stata-press.com/data/r12/friedman2, clear
keep if time<=tq(1981q4) & time>=tq(1959q1)
arima consump m2 if tin(, 1978q1), ar(1) ma(1)
replace consump = . if time>tq(1978q1)
predict chat, y
predict chatdy, dynamic(tq(1978q1)) y
