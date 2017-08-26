clear all
vrep=remApi('remoteApi');
vrep.simxFinish(-1);
 clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
 euler = get_param('ex1/Display2','RuntimeObject');
 XY= get_param('ex1/Scope4','RuntimeObject');
 Z= get_param('ex1/Scope2','RuntimeObject');
if (clientID>-1)
        disp('Connected to remote API server');
        % Add code here
        [returnCode,box]=vrep.simxGetObjectHandle(clientID,'SPIR',vrep.simx_opmode_blocking);
       
%         [returnCode]=vrep.simxSetJointTargetVelocity(clientID,LeftMotor,0.4,vrep.simx_opmode_blocking);
        [returnCode]=vrep.simxSetObjectPosition(clientID,box,-1,[0, 0, 1],vrep.simx_opmode_oneshot_wait);
        while(1)
             v=euler.InputPort(1).Data;
             pXY=XY.InputPort(1).Data;
             pZ=Z.InputPort(1).Data;
         	[returnCode]=vrep.simxSetObjectOrientation(clientID,box,-1,[v(2) v(1) -v(3)]*pi/180,vrep.simx_opmode_blocking);
%             [returnCode]=vrep.simxSetObjectOrientation(clientID,box,-1,[0*pi/180,0*pi/180,45*pi/180],vrep.simx_opmode_blocking);
             [returnCode]=vrep.simxSetObjectPosition(clientID,box,-1,[-pXY(1) pXY(2) (-pZ(1)+1)],vrep.simx_opmode_blocking);
            pause(0.05);
%        
        end
%         
%         [returnCode]=vrep.simxSetObjectPosition(clientID,box,-1,[0 0 0],vrep.simx_opmode_blocking);
        
        vrep.simxFinish(-1);
end

vrep.delete();