if(MATLAB_FOUND)
  if(lcm_FOUND)
    add_mex(setDuration setDuration.cpp)
    target_link_libraries(setDuration drakeQPLocomotionPlan drakeMexUtil)
  endif()
endif()
