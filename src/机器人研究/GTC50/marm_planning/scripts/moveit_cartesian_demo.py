#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy, sys
import moveit_commander
from moveit_commander import MoveGroupCommander
from copy import deepcopy

from moveit_msgs.msg import RobotTrajectory
from trajectory_msgs.msg import JointTrajectoryPoint
from geometry_msgs.msg import PoseStamped, Pose
from tf.transformations import euler_from_quaternion, quaternion_from_euler

class MoveItCartesianDemo:
    def __init__(self):
        # 初始化move_group的API
        moveit_commander.roscpp_initialize(sys.argv)

        # 初始化ROS节点
        rospy.init_node('moveit_cartesian_demo', anonymous=True)
        
        # 是否需要使用笛卡尔空间的运动规划
        cartesian = rospy.get_param('~cartesian', True)
                        
        # 初始化需要使用move group控制的机械臂中的arm group
        arm = MoveGroupCommander('arm')
        
        # 当运动规划失败后，允许重新规划
        arm.allow_replanning(True)
        
        # 设置目标位置所使用的参考坐标系
        reference_frame = 'base_link'
        arm.set_pose_reference_frame(reference_frame)
                
        # 设置位置(单位：米)和姿态（单位：弧度）的允许误差
        arm.set_goal_position_tolerance(0.01)
        arm.set_goal_orientation_tolerance(0.05)
        
        # 获取终端link的名称
        end_effector_link = arm.get_end_effector_link()
                                        
        # 控制机械臂运动到之前设置的“home1”姿态
        arm.set_named_target('home1')
        arm.go()
        rospy.sleep(2)
        
        # 设置机械臂工作空间中的目标位姿，位置使用x、y、z坐标描述，
        # 姿态使用四元数描述，基于base_link坐标系
        target_pose = PoseStamped()
        target_pose.header.frame_id = reference_frame
        target_pose.header.stamp = rospy.Time.now()     
        target_pose.pose.position.x = -0.0001196
        target_pose.pose.position.y = 4.30819
        target_pose.pose.position.z = -1.93433
        target_pose.pose.orientation.x = 0.0103935
        target_pose.pose.orientation.y = 0.999944
        target_pose.pose.orientation.z = -0.00176004
        target_pose.pose.orientation.w = 3.7749e-06
        # target_pose.pose.position.x = 0.191995
        # target_pose.pose.position.y = 0.213868
        # target_pose.pose.position.z = 0.520436
        # target_pose.pose.orientation.x = 0.911822
        # target_pose.pose.orientation.y = -0.0269758
        # target_pose.pose.orientation.z = 0.285694
        # target_pose.pose.orientation.w = -0.293653
        
        # 设置机器臂当前的状态作为运动初始状态
        arm.set_start_state_to_current_state()
        # 设置机械臂终端运动的目标位姿
        arm.set_pose_target(target_pose, end_effector_link)
        
        # 规划运动路径
        traj = arm.plan()
        
        # 按照规划的运动路径控制机械臂运动
        arm.execute(traj)
        rospy.sleep(5)
        
        
        # 获取当前位姿数据最为机械臂运动的起始位姿
        start_pose = arm.get_current_pose(end_effector_link).pose
                
        # 初始化路点列表
        waypoints = []
                
        # 将初始位姿加入路点列表
        if cartesian:
            waypoints.append(start_pose)
            
        # 设置第二个路点数据，并加入路点列表
        # 第二个路点需要向后运动0.2米，向右运动0.2米
        wpose = deepcopy(start_pose)
        #wpose.position.x -= 0.2
        wpose.position.z += 2

        if cartesian:
            waypoints.append(deepcopy(wpose))
        else:
            arm.set_pose_target(wpose)
            arm.go()
            rospy.sleep(1)
         
        # 设置第三个路点数据，并加入路点列表
        wpose.position.z += 2.1

        if cartesian:
            waypoints.append(deepcopy(wpose))
        else:
            arm.set_pose_target(wpose)
            arm.go()
            rospy.sleep(1)
        
        # # 设置第四个路点数据，回到初始位置，并加入路点列表
        # if cartesian:
            # waypoints.append(deepcopy(start_pose))
        # else:
            # arm.set_pose_target(start_pose)
            # arm.go()
            # rospy.sleep(1)
            
        if cartesian:
            fraction = 0.0   #路径规划覆盖率
            maxtries = 100   #最大尝试规划次数
            attempts = 0     #已经尝试规划次数
            
            # 设置机器臂当前的状态作为运动初始状态
            arm.set_start_state_to_current_state()
     
            # 尝试规划一条笛卡尔空间下的路径，依次通过所有路点
            while fraction < 1.0 and attempts < maxtries:
                (plan, fraction) = arm.compute_cartesian_path (
                                        waypoints,   # waypoint poses，路点列表
                                        0.01,        # eef_step，终端步进值
                                        0.0,         # jump_threshold，跳跃阈值
                                        False)        # avoid_collisions，避障规划
                
                # 尝试次数累加
                attempts += 1
                
                # 打印运动规划进程
                if attempts % 10 == 0:
                    rospy.loginfo("Still trying after " + str(attempts) + " attempts...")
                         
            # 如果路径规划成功（覆盖率100%）,则开始控制机械臂运动
            if fraction == 1.0:
                rospy.loginfo("Path computed successfully. Moving the arm.")
                arm.execute(plan)
                rospy.loginfo("Path execution complete.")
            # 如果路径规划失败，则打印失败信息
            else:
                rospy.loginfo("Path planning failed with only " + str(fraction) + " success after " + str(maxtries) + " attempts.")  

        # 控制机械臂回到初始化位置
        arm.set_named_target('home1')
        arm.go()
        rospy.sleep(2)
        
        # 关闭并退出moveit
        moveit_commander.roscpp_shutdown()
        moveit_commander.os._exit(0)

if __name__ == "__main__":
    try:
        MoveItCartesianDemo()
    except rospy.ROSInterruptException:
        pass
