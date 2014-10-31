#cython: boundscheck=False
#cython: wraparound=False
#cython: cdivision=False
"""
State Space Model Smoother declarations

Author: Chad Fulton  
License: Simplified-BSD
"""

cdef int SMOOTHER_STATE           # Durbin and Koopman (2012), Chapter 4.4.2
cdef int SMOOTHER_STATE_COV       # Durbin and Koopman (2012), Chapter 4.4.3
cdef int SMOOTHER_DISTURBANCE     # Durbin and Koopman (2012), Chapter 4.5
cdef int SMOOTHER_DISTURBANCE_COV # Durbin and Koopman (2012), Chapter 4.5
cdef int SMOOTHER_ALL

# Typical imports
cimport numpy as np

from dismalpy.ssm._statespace cimport (
    sStatespace, dStatespace, cStatespace, zStatespace
)
from dismalpy.ssm._kalman_filter cimport (
    sKalmanFilter, dKalmanFilter, cKalmanFilter, zKalmanFilter
)

# Single precision
cdef class sKalmanSmoother(object):
    # Statespace object
    cdef readonly sStatespace model
    # Kalman filter
    cdef readonly sKalmanFilter kfilter

    cdef readonly int t
    cdef public int smoother_output

    cdef readonly np.float32_t [::1,:] scaled_smoothed_estimator
    cdef readonly np.float32_t [::1,:,:] scaled_smoothed_estimator_cov
    cdef readonly np.float32_t [::1,:] smoothing_error
    cdef readonly np.float32_t [::1,:] smoothed_state
    cdef readonly np.float32_t [::1,:,:] smoothed_state_cov
    cdef readonly np.float32_t [::1,:] smoothed_measurement_disturbance
    cdef readonly np.float32_t [::1,:] smoothed_state_disturbance
    cdef readonly np.float32_t [::1,:,:] smoothed_measurement_disturbance_cov
    cdef readonly np.float32_t [::1,:,:] smoothed_state_disturbance_cov

    cdef readonly np.float32_t [:] selected_design
    cdef readonly np.float32_t [:] selected_obs_cov

    cdef readonly np.float32_t [::1,:] tmpL, tmp0, tmp00, tmp000

    # Statespace
    cdef np.float32_t * _design
    cdef np.float32_t * _obs_cov
    cdef np.float32_t * _transition
    cdef np.float32_t * _selection
    cdef np.float32_t * _state_cov

    # Kalman filter
    cdef np.float32_t * _predicted_state
    cdef np.float32_t * _predicted_state_cov
    cdef np.float32_t * _kalman_gain

    cdef np.float32_t * _tmp1
    cdef np.float32_t * _tmp2
    cdef np.float32_t * _tmp3
    cdef np.float32_t * _tmp4

    # Kalman smoother
    cdef np.float32_t * _input_scaled_smoothed_estimator
    cdef np.float32_t * _input_scaled_smoothed_estimator_cov

    cdef np.float32_t * _scaled_smoothed_estimator
    cdef np.float32_t * _scaled_smoothed_estimator_cov
    cdef np.float32_t * _smoothing_error
    cdef np.float32_t * _smoothed_state
    cdef np.float32_t * _smoothed_state_cov
    cdef np.float32_t * _smoothed_measurement_disturbance
    cdef np.float32_t * _smoothed_state_disturbance
    cdef np.float32_t * _smoothed_measurement_disturbance_cov
    cdef np.float32_t * _smoothed_state_disturbance_cov

    # Temporary
    cdef np.float32_t * _tmpL
    cdef np.float32_t * _tmp0
    cdef np.float32_t * _tmp00
    cdef np.float32_t * _tmp000

    # Functions
    cdef int (*smooth_estimators)(
        sKalmanSmoother
    )
    cdef int (*smooth_state)(
        sKalmanSmoother
    )
    cdef int (*smooth_disturbances)(
        sKalmanSmoother
    )

    cdef readonly int k_endog, k_states, k_posdef, k_endog2, k_states2, k_posdef2, k_endogstates, k_statesposdef

    cpdef seek(self, unsigned int t)
    cdef void initialize_statespace_object_pointers(self) except *
    cdef void initialize_filter_object_pointers(self)
    cdef void initialize_smoother_object_pointers(self)
    cdef void initialize_function_pointers(self) except *
    cdef void select_missing(self)

# Double precision
cdef class dKalmanSmoother(object):
    # Statespace object
    cdef readonly dStatespace model
    # Kalman filter
    cdef readonly dKalmanFilter kfilter

    cdef readonly int t
    cdef public int smoother_output

    cdef readonly np.float64_t [::1,:] scaled_smoothed_estimator
    cdef readonly np.float64_t [::1,:,:] scaled_smoothed_estimator_cov
    cdef readonly np.float64_t [::1,:] smoothing_error
    cdef readonly np.float64_t [::1,:] smoothed_state
    cdef readonly np.float64_t [::1,:,:] smoothed_state_cov
    cdef readonly np.float64_t [::1,:] smoothed_measurement_disturbance
    cdef readonly np.float64_t [::1,:] smoothed_state_disturbance
    cdef readonly np.float64_t [::1,:,:] smoothed_measurement_disturbance_cov
    cdef readonly np.float64_t [::1,:,:] smoothed_state_disturbance_cov

    cdef readonly np.float64_t [:] selected_design
    cdef readonly np.float64_t [:] selected_obs_cov

    cdef readonly np.float64_t [::1,:] tmpL, tmp0, tmp00, tmp000

    # Statespace
    cdef np.float64_t * _design
    cdef np.float64_t * _obs_cov
    cdef np.float64_t * _transition
    cdef np.float64_t * _selection
    cdef np.float64_t * _state_cov

    # Kalman filter
    cdef np.float64_t * _predicted_state
    cdef np.float64_t * _predicted_state_cov
    cdef np.float64_t * _kalman_gain

    cdef np.float64_t * _tmp1
    cdef np.float64_t * _tmp2
    cdef np.float64_t * _tmp3
    cdef np.float64_t * _tmp4

    # Kalman smoother
    cdef np.float64_t * _input_scaled_smoothed_estimator
    cdef np.float64_t * _input_scaled_smoothed_estimator_cov

    cdef np.float64_t * _scaled_smoothed_estimator
    cdef np.float64_t * _scaled_smoothed_estimator_cov
    cdef np.float64_t * _smoothing_error
    cdef np.float64_t * _smoothed_state
    cdef np.float64_t * _smoothed_state_cov
    cdef np.float64_t * _smoothed_measurement_disturbance
    cdef np.float64_t * _smoothed_state_disturbance
    cdef np.float64_t * _smoothed_measurement_disturbance_cov
    cdef np.float64_t * _smoothed_state_disturbance_cov

    # Temporary
    cdef np.float64_t * _tmpL
    cdef np.float64_t * _tmp0
    cdef np.float64_t * _tmp00
    cdef np.float64_t * _tmp000

    # Functions
    cdef int (*smooth_estimators)(
        dKalmanSmoother
    )
    cdef int (*smooth_state)(
        dKalmanSmoother
    )
    cdef int (*smooth_disturbances)(
        dKalmanSmoother
    )

    cdef readonly int k_endog, k_states, k_posdef, k_endog2, k_states2, k_posdef2, k_endogstates, k_statesposdef

    cpdef seek(self, unsigned int t)
    cdef void initialize_statespace_object_pointers(self) except *
    cdef void initialize_filter_object_pointers(self)
    cdef void initialize_smoother_object_pointers(self)
    cdef void initialize_function_pointers(self) except *
    cdef void select_missing(self)

# Single precision complex
cdef class cKalmanSmoother(object):
    # Statespace object
    cdef readonly cStatespace model
    # Kalman filter
    cdef readonly cKalmanFilter kfilter

    cdef readonly int t
    cdef public int smoother_output

    cdef readonly np.complex64_t [::1,:] scaled_smoothed_estimator
    cdef readonly np.complex64_t [::1,:,:] scaled_smoothed_estimator_cov
    cdef readonly np.complex64_t [::1,:] smoothing_error
    cdef readonly np.complex64_t [::1,:] smoothed_state
    cdef readonly np.complex64_t [::1,:,:] smoothed_state_cov
    cdef readonly np.complex64_t [::1,:] smoothed_measurement_disturbance
    cdef readonly np.complex64_t [::1,:] smoothed_state_disturbance
    cdef readonly np.complex64_t [::1,:,:] smoothed_measurement_disturbance_cov
    cdef readonly np.complex64_t [::1,:,:] smoothed_state_disturbance_cov

    cdef readonly np.complex64_t [:] selected_design
    cdef readonly np.complex64_t [:] selected_obs_cov

    cdef readonly np.complex64_t [::1,:] tmpL, tmp0, tmp00, tmp000

    # Statespace
    cdef np.complex64_t * _design
    cdef np.complex64_t * _obs_cov
    cdef np.complex64_t * _transition
    cdef np.complex64_t * _selection
    cdef np.complex64_t * _state_cov

    # Kalman filter
    cdef np.complex64_t * _predicted_state
    cdef np.complex64_t * _predicted_state_cov
    cdef np.complex64_t * _kalman_gain

    cdef np.complex64_t * _tmp1
    cdef np.complex64_t * _tmp2
    cdef np.complex64_t * _tmp3
    cdef np.complex64_t * _tmp4

    # Kalman smoother
    cdef np.complex64_t * _input_scaled_smoothed_estimator
    cdef np.complex64_t * _input_scaled_smoothed_estimator_cov

    cdef np.complex64_t * _scaled_smoothed_estimator
    cdef np.complex64_t * _scaled_smoothed_estimator_cov
    cdef np.complex64_t * _smoothing_error
    cdef np.complex64_t * _smoothed_state
    cdef np.complex64_t * _smoothed_state_cov
    cdef np.complex64_t * _smoothed_measurement_disturbance
    cdef np.complex64_t * _smoothed_state_disturbance
    cdef np.complex64_t * _smoothed_measurement_disturbance_cov
    cdef np.complex64_t * _smoothed_state_disturbance_cov

    # Temporary
    cdef np.complex64_t * _tmpL
    cdef np.complex64_t * _tmp0
    cdef np.complex64_t * _tmp00
    cdef np.complex64_t * _tmp000

    # Functions
    cdef int (*smooth_estimators)(
        cKalmanSmoother
    )
    cdef int (*smooth_state)(
        cKalmanSmoother
    )
    cdef int (*smooth_disturbances)(
        cKalmanSmoother
    )

    cdef readonly int k_endog, k_states, k_posdef, k_endog2, k_states2, k_posdef2, k_endogstates, k_statesposdef

    cpdef seek(self, unsigned int t)
    cdef void initialize_statespace_object_pointers(self) except *
    cdef void initialize_filter_object_pointers(self)
    cdef void initialize_smoother_object_pointers(self)
    cdef void initialize_function_pointers(self) except *
    cdef void select_missing(self)

# Double precision complex
cdef class zKalmanSmoother(object):
    # Statespace object
    cdef readonly zStatespace model
    # Kalman filter
    cdef readonly zKalmanFilter kfilter

    cdef readonly int t
    cdef public int smoother_output

    cdef readonly np.complex128_t [::1,:] scaled_smoothed_estimator
    cdef readonly np.complex128_t [::1,:,:] scaled_smoothed_estimator_cov
    cdef readonly np.complex128_t [::1,:] smoothing_error
    cdef readonly np.complex128_t [::1,:] smoothed_state
    cdef readonly np.complex128_t [::1,:,:] smoothed_state_cov
    cdef readonly np.complex128_t [::1,:] smoothed_measurement_disturbance
    cdef readonly np.complex128_t [::1,:] smoothed_state_disturbance
    cdef readonly np.complex128_t [::1,:,:] smoothed_measurement_disturbance_cov
    cdef readonly np.complex128_t [::1,:,:] smoothed_state_disturbance_cov

    cdef readonly np.complex128_t [:] selected_design
    cdef readonly np.complex128_t [:] selected_obs_cov

    cdef readonly np.complex128_t [::1,:] tmpL, tmp0, tmp00, tmp000

    # Statespace
    cdef np.complex128_t * _design
    cdef np.complex128_t * _obs_cov
    cdef np.complex128_t * _transition
    cdef np.complex128_t * _selection
    cdef np.complex128_t * _state_cov

    # Kalman filter
    cdef np.complex128_t * _predicted_state
    cdef np.complex128_t * _predicted_state_cov
    cdef np.complex128_t * _kalman_gain

    cdef np.complex128_t * _tmp1
    cdef np.complex128_t * _tmp2
    cdef np.complex128_t * _tmp3
    cdef np.complex128_t * _tmp4

    # Kalman smoother
    cdef np.complex128_t * _input_scaled_smoothed_estimator
    cdef np.complex128_t * _input_scaled_smoothed_estimator_cov

    cdef np.complex128_t * _scaled_smoothed_estimator
    cdef np.complex128_t * _scaled_smoothed_estimator_cov
    cdef np.complex128_t * _smoothing_error
    cdef np.complex128_t * _smoothed_state
    cdef np.complex128_t * _smoothed_state_cov
    cdef np.complex128_t * _smoothed_measurement_disturbance
    cdef np.complex128_t * _smoothed_state_disturbance
    cdef np.complex128_t * _smoothed_measurement_disturbance_cov
    cdef np.complex128_t * _smoothed_state_disturbance_cov

    # Temporary
    cdef np.complex128_t * _tmpL
    cdef np.complex128_t * _tmp0
    cdef np.complex128_t * _tmp00
    cdef np.complex128_t * _tmp000

    # Functions
    cdef int (*smooth_estimators)(
        zKalmanSmoother
    )
    cdef int (*smooth_state)(
        zKalmanSmoother
    )
    cdef int (*smooth_disturbances)(
        zKalmanSmoother
    )

    cdef readonly int k_endog, k_states, k_posdef, k_endog2, k_states2, k_posdef2, k_endogstates, k_statesposdef

    cpdef seek(self, unsigned int t)
    cdef void initialize_statespace_object_pointers(self) except *
    cdef void initialize_filter_object_pointers(self)
    cdef void initialize_smoother_object_pointers(self)
    cdef void initialize_function_pointers(self) except *
    cdef void select_missing(self)
