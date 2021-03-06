#include "drake/systems/plants/RigidBodyFrame.h"

#include "drake/util/drakeGeometryUtil.h"

RigidBodyFrame::RigidBodyFrame(const std::string& _name, RigidBody* _body,
                               const Eigen::Vector3d& xyz,
                               const Eigen::Vector3d& rpy)
    : name(_name), body(_body) {
  transform_to_body.matrix() << rpy2rotmat(rpy), xyz, 0, 0, 0, 1;
}
