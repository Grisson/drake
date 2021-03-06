if(lcm_FOUND)
  add_executable(runPendulumDynamics runDynamics.cpp)
  target_link_libraries(runPendulumDynamics drakeRBM drakeLCMSystem threads)
  add_test(NAME runPendulumDynamics COMMAND runPendulumDynamics --non-realtime)

  add_executable(runPendulumEnergyShaping runEnergyShaping.cpp)
  target_link_libraries(runPendulumEnergyShaping drakeRBM drakeLCMSystem threads)
  # add_test(NAME runPendulumEnergyShaping COMMAND runPendulumEnergyShaping --non-realtime)  # FIXME: disabled for now since it's not a good test, since it will always timeout

  add_executable(runPendulumLQR runLQR.cpp)
  target_link_libraries(runPendulumLQR drakeRBM drakeLCMSystem)
  add_test(NAME runPendulumLQR COMMAND runPendulumLQR --non-realtime)

#  write_procman(Pendulum.pmd
#    GROUP "Simulate"
#      NAME "dynamics (cpp)" COMMAND "bash -c 'cd ${CMAKE_CURRENT_SOURCE_DIR} && ${CMAKE_BINARY_DIR}/bin/runPendulumDynamics'"
#    ENDGROUP
#    GROUP "LCM Controllers"
#      NAME "energy shaping (cpp)" COMMAND "${CMAKE_BINARY_DIR}/bin/runPendulumEnergyShaping"
#    ENDGROUP
#    GROUP "Controllers+Simulation In One"
#      NAME "LQR (cpp)" COMMAND "bash -c 'cd ${CMAKE_CURRENT_SOURCE_DIR} && ${CMAKE_BINARY_DIR}/bin/runPendulumLQR'"
#    ENDGROUP
#    NAME "viewer" COMMAND "${CMAKE_INSTALL_PREFIX}/bin/drake-visualizer")
endif()

add_subdirectory(test)

add_matlab_test(NAME examples/Pendulum/PendulumEnergyShaping.run COMMAND PendulumEnergyShaping.run)
add_matlab_test(NAME examples/Pendulum/globalStability COMMAND globalStability REQUIRES mosek spotless)
add_matlab_test(NAME examples/Pendulum/runDLQR COMMAND runDLQR)
add_matlab_test(NAME examples/Pendulum/runLQR COMMAND runLQR)
add_matlab_test(NAME examples/Pendulum/runLQRtest COMMAND runLQRtest)
add_matlab_test(NAME examples/Pendulum/runPassive COMMAND runPassive)
add_matlab_test(NAME examples/Pendulum/runPassiveURDF COMMAND runPassiveURDF)
add_matlab_test(NAME examples/Pendulum/runSwingUp COMMAND runSwingUp)
add_matlab_test(NAME examples/Pendulum/runTrigLQR COMMAND runTrigLQR)
add_matlab_test(NAME examples/Pendulum/PendulumEnergyControl.run COMMAND PendulumEnergyControl.run)

if(LONG_RUNNING_TESTS)
  # add_matlab_test(NAME examples/Pendulum/runTrajectorySwingUpAndBalance COMMAND runTrajectorySwingUpAndBalance PROPERTIES TIMEOUT 1500)  # FIXME: see #2305
  add_matlab_test(NAME examples/Pendulum/runValueIteration COMMAND runValueIteration PROPERTIES TIMEOUT 1500)
endif()
