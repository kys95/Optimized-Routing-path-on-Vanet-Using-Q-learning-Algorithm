function varargout = road(varargin)
% ROAD MATLAB code for road.fig
%      ROAD, by itself, creates a new ROAD or raises the existing
%      singleton*.
%
%      H = ROAD returns the handle to a new ROAD or the handle to
%      the existing singleton*.
%
%      ROAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROAD.M with the given input arguments.
%
%      ROAD('Property','Value',...) creates a new ROAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before road_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to road_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help road

% Last Modified by GUIDE v2.5 10-Mar-2022 16:15:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @road_OpeningFcn, ...
                   'gui_OutputFcn',  @road_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before road is made visible.
function road_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to road (see VARARGIN)

% Choose default command line output for road
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes road wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = road_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global X_Size_Road
global Y_Size_Road
global Num_vertical
global Num_horizontal
global ver_interval
global hor_interval
global lane_from
global lane_to
global cell_part_ratio
global sub_ver_ratio
global sub_hor_ratio
global sub_bo_ratio
global xrw
global yrw


%%%%%%%%%%%%%%%%%%%%%%%% axes x축, y축 맞게 설정해 줘야함 %%%%%%%%%%%%%%% 
hAxe = handles.axes1;
ax_xlim = get(hAxe,'XLim');
ax_xlim(2) = X_Size_Road;
set(hAxe,'XLim',ax_xlim);

ax_ylim = get(hAxe,'YLim');
ax_ylim(2) = Y_Size_Road;
set(hAxe,'YLim',ax_ylim);

%%%%%%%%%%%%%%%%%%%%%%% 지우개 역할 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rectangle('position',[0 0 X_Size_Road Y_Size_Road], 'FaceColor',[1 1 1],'EdgeColor',[1 1 1]);

mode_num = lane_to/2; % 선택할 수 있는 차수 가짓수

xrw = zeros(1,Num_vertical-1);
yrw = zeros(1,Num_horizontal-1);

%%%%%%%%%%%%%%%%%%%%%%% 수직 메인 도로 그리기  %%%%%%%%%%%%%%%%%%%%%%%%%%%
ver_interval = X_Size_Road / ( Num_vertical -1 );
for i=0:Num_vertical-2
    random = fix(mode_num*rand(1,1)+1);
    x_road_width = random*7;
    xrw(1,i+1) = x_road_width; % xrw : x_road_width
    rectangle('position',[0+ver_interval*i 0 x_road_width Y_Size_Road], 'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]); 
end

random = fix(mode_num*rand(1,1)+1);
x_road_width = random*7;
xrw(1,Num_vertical) = x_road_width;
rectangle('position',[X_Size_Road-x_road_width 0 x_road_width Y_Size_Road], 'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]); 

%%%%%%%%%%%%%%%%%%%%%%% 수평 메인 도로 그리기  %%%%%%%%%%%%%%%%%%%%%%%%%%%
hor_interval = Y_Size_Road / ( Num_horizontal -1 );
for i=0: Num_horizontal-2
    random = fix(mode_num*rand(1,1)+1);
    y_road_width = random*7;
    yrw(1,i+1) = y_road_width; % yrw : y_road_width
    rectangle('position',[0 0+hor_interval*i X_Size_Road y_road_width], 'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]); 
end

random = fix(mode_num*rand(1,1)+1);
y_road_width = random*7;
yrw(1,Num_horizontal) = y_road_width;
rectangle('position',[0 Y_Size_Road-y_road_width X_Size_Road y_road_width], 'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]); 

%%%%%%%%%%%%%%%%%%%%%% Sub 도로 cell 선택 알고리즘 %%%%%%%%%%%%%%%%%%%%%%

cell_total_num = (Num_horizontal-1) * (Num_vertical-1);
cell_part_num = fix(cell_total_num * cell_part_ratio);
count = 0;

for i=1:Num_horizontal-1
    for j=1:Num_vertical-1
        
        x = ver_interval*(j-1) + xrw(1,j);
        y = hor_interval*(i-1) + yrw(1,i);
        
        cell_bool = fix(2*rand(1,1));   % 셀이 sub street으로 선택 될 것인지, 말 것인지
        
        if((cell_bool == 1) && ( count ~= cell_part_num ))
            %hold on;
            %plot(x, y, 'b*');
            count = count + 1;
            
            %%%%%%%%%%%%%% Sub vertical, horizontal, both 결정 %%%%%%%%%%%%
           
            random_vhb = rand(1);
      
            if(random_vhb < sub_ver_ratio)
                % sub_vertical_draw();
                ver_x = (x + ver_interval*j) * 0.5;
                rectangle('position',[ver_x y 7 (hor_interval*i)-y],'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]);
              
            elseif((sub_ver_ratio < random_vhb) && (random_vhb < sub_ver_ratio + sub_hor_ratio))
                % sub_horizontal_draw();
                hor_y = (y + hor_interval*i) * 0.5;
                rectangle('position',[x hor_y (ver_interval*j)-x 7],'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]);
  
            else
                % sub_both_draw();
                ver_x = (x + ver_interval*j) * 0.5;
                rectangle('position',[ver_x y 7 (hor_interval*i)-y],'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]);
                
                hor_y = (y + hor_interval*i) * 0.5;
                rectangle('position',[x hor_y (ver_interval*j)-x 7],'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]);
              
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
        else
            %hold on;
            %plot(x, y, 'r*');
        end
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% 중앙선 그리기 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global ver_centerLine
global hor_centerLine

for i=0:Num_vertical-1
    x = (ver_interval*i)+(xrw(i+1)/2);
    if(i==Num_vertical-1)
        x = X_Size_Road - (xrw(i+1)/2);
    end
    ver_centerLine(1,i+1) = x;
    line([x,x],[yrw(1),Y_Size_Road - yrw(Num_horizontal)],'LineStyle','-.','Color','y');
end

for i=0:Num_horizontal-1
    y = (hor_interval*i)+(yrw(i+1)/2);
    if(i==Num_horizontal-1)
        y = Y_Size_Road - (yrw(i+1)/2);
    end
    hor_centerLine(1,i+1) = y;
    line([xrw(1),X_Size_Road - xrw(Num_vertical)],[y,y],'LineStyle','-.','Color','y');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


global Num_vehicle
global Vehicle_Max_speed
global Vehicle_Min_speed
global vehicle
global MAX_TIME
%%%%%%%%%%%%%%%%%%%%%%%%%% 회전 Spot 그리기 %%%%%%%%%%%%%%%%%%%%%%%%%%%

spot = struct();
spot_count = 1;

for i=1:Num_horizontal
    for j=1:Num_vertical
        
        x = ver_interval*(j-1) + xrw(1,j)/2;
        y = hor_interval*(i-1) + yrw(1,i)/2;
        
        if(j == Num_vertical)
            x = ver_interval*(j-1) - xrw(1,j)/2;
        end
        
        if(i == Num_horizontal)
           y = hor_interval*(i-1) - yrw(1,i)/2; 
        end
        
        hold on;
        plot(x, y, 'r*','LineWidth',2);
        
        spot(i,j).Xpoint = x; % 해당 spot의 x좌표
        spot(i,j).Ypoint = y; % 해당 spot의 y좌표
        spot_count = spot_count + 1;   % spot 갯수 1 증가
    end
end

vehicle=struct(); % vehicle 관련 변수들 struct로 형싱화함
RV=10; % Vehicle에 들어갈 component의 갯수
temp=zeros(1,length(RV)); % 초기 설정시 필요한 임시 random number 생성할 갯수

for i=1:Num_vehicle
    
    %%%% vehicle마다 고유의 ID 부여해줌
    vehicle(i).ID = i;
    vehicle(i).spot_in = 0;
    vehicle(i).spot_x = 0;
    vehicle(i).spot_y = 0;
    
    %%%%%% 속도 설정 %%%%%%
    if(i < Num_vehicle/3)
        vehicle(i). speed = 0.4;
    elseif((i>= Num_vehicle/3) && ( i < (Num_vehicle*2)/3) )
        vehicle(i). speed = 1.0;   
    else
        vehicle(i). speed = 1.5;    
    end
    
    
    %%%% 초기 방향 설정
    temp(1,1) = rand(); % 초기방향설정위한 난수 -> 0.25 이하면 a방향 0.25이상 0.5이하는 b 방향
                        % temp(1,1) : 초기 방향 설정을 위한 랜덤 변수 저장
                        % 왼쪽 : < , 위쪽 : ^ , 오른쪽: > , 아래쪽 : v
    %temp(1,1) = 0.2;
                     
    if temp(1,1) < 0.25
        vehicle(i).direction = '<'; % 초기에 왼쪽으로 출발
    elseif temp(1,1) >=0.25 && temp(1,1) < 0.5
        vehicle(i).direction = '^'; % 초기에 위쪽으로 출발
    elseif temp(1,1) >=0.5 && temp(1,1) < 0.75
        vehicle(i).direction = '>'; % 초기에 오른쪽으로 출발
    else
        vehicle(i).direction = 'v'; % 초기에 아래쪽으로 출발
    end
    
    
    %%%% 초기 위치 설정
    if vehicle(i).direction == '<' % 초기방향이 왼쪽이라면
        % 왼쪽으로 가는(수평) 도로에 놓여지도록
        % 이때, 수평 도로에 놓여지는 x좌표는 동일범위(xrw(1)~X_Road_Size - xrw(3))로설정
        temp(1,2) = fix(Num_horizontal*rand()+1);
        t = temp(1,2);
        d = yrw(t)/7;   %차선을 고려한 차 분포를 위한 변수
        random_d = fix(d*rand()+1);
        vehicle(i).Location = [ fix(xrw(1,1)+(X_Size_Road-xrw(1,3))*rand()),hor_centerLine(1,t)+(1.75)*(2*random_d - 1)];
        
    elseif vehicle(i).direction == '^' % 초기방향이 위쪽이라면
        % 위쪽으로 가는 도로에 놓여지도록
        temp(1,3) = fix(Num_vertical*rand()+1);
        t = temp(1,3);
        d = xrw(t)/7;
        random_d = fix(d*rand()+1);
        vehicle(i).Location = [ ver_centerLine(1,t)+(1.75)*(2*random_d - 1),fix(yrw(1,1)+(Y_Size_Road-yrw(1,3))*rand()),];
        
    elseif vehicle(i).direction == '>' % 초기방향이 오른쪽이라면
        % 오른쪽으로 가는 도로에 놓여지도록
        temp(1,4) = fix(Num_horizontal*rand()+1);
        t = temp(1,4);
        d = yrw(t)/7;
        random_d = fix(d*rand()+1);
        vehicle(i).Location = [ fix(xrw(1,1)+(X_Size_Road-xrw(1,3))*rand()),hor_centerLine(1,t)-(1.75)*(2*random_d - 1)];
        
    elseif vehicle(i).direction == 'v' % 초기방향이 아래쪽이라면
        % 아래쪽으로 가는 도로에 놓여지도록
        temp(1,5) = fix(Num_vertical*rand()+1);
        t = temp(1,5);
        d = xrw(t)/7;
        random_d = fix(d*rand()+1);
        vehicle(i).Location = [ ver_centerLine(1,t)-(1.75)*(2*random_d - 1),fix(yrw(1,1)+(Y_Size_Road-yrw(1,3))*rand()),];
 
    end     
end

global source
global destination
global distance

distance = zeros(length(Num_vehicle),length(Num_vehicle)); %각 vehicle간의 거리 측정

vehicle(source).s = text(vehicle(source).Location(1)+10,vehicle(source).Location(2)+10,'source','Position',[300 300]);
vehicle(destination).d = text(vehicle(destination).Location(1)+10,vehicle(destination).Location(2)+10,'destination','Position',[300 300]);

%% %%%%%%%%%%%%%%%%%%%% 처음 차량 그리기 %%%%%%%%%%%%%%%%%%%%%%%%
for i=1:Num_vehicle % 차량 한번에 생성해서 뿌려주기
    vehicle(i).imageCar = line('XData',vehicle(i).Location(1), 'YData',vehicle(i).Location(2), 'Color','b', ...
        'Marker',vehicle(i).direction, 'MarkerSize',7, 'LineWidth',0.5);
    vehicle(i).t = text(vehicle(i).Location(1),vehicle(i).Location(2),int2str(i),'Position',[300 300]);
end

%% %%%%%%%%%%%%%% Move 정보 시작 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (속도, 초기방향에 따른 각도 )
%% 시간흐름에 따라 진행
MAX_TIME = 1000;
for time = 1:MAX_TIME % 시간에 따른 움직임확인
        for i=1:Num_vehicle  
            % 각 차량의 초기 방향에 따른 위치 설정 (이를 이용해서 x,y좌표 증감 결정)
            if vehicle(i).direction == '<' % 초기에 왼쪽으로 출발
                % 왼쪽이동
                vehicle(i).Location(1) = vehicle(i).Location(1) - vehicle(i).speed;
                if(vehicle(i).Location(1) < 0)
                    vehicle(i).Location(1) = X_Size_Road;
                end
            elseif  vehicle(i).direction == '^'
                % 위쪽이동
                vehicle(i).Location(2) = vehicle(i).Location(2) + vehicle(i).speed;
                if(vehicle(i).Location(2) > Y_Size_Road)
                    vehicle(i).Location(2) = 0;
                end
            elseif   vehicle(i).direction == '>' 
                % 오른쪽이동
                vehicle(i).Location(1) = vehicle(i).Location(1) + vehicle(i).speed;
                 if(vehicle(i).Location(1) > X_Size_Road)
                    vehicle(i).Location(1) = 0;
                end
            elseif vehicle(i).direction == 'v'
                % 아래쪽이동
                vehicle(i).Location(2) = vehicle(i).Location(2) - vehicle(i).speed;
                if(vehicle(i).Location(2) < 0)
                    vehicle(i).Location(2) = Y_Size_Road;
                end
            end
           
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rotation mode 결정 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            for spot_i=1:Num_horizontal
                for spot_j=1:Num_vertical
                    
                    if(((spot(spot_i,spot_j).Xpoint - xrw(spot_j)/2) < vehicle(i).Location(1)) && (vehicle(i).Location(1) < (spot(spot_i,spot_j).Xpoint + xrw(spot_j)/2)))
                        if(((spot(spot_i,spot_j).Ypoint - yrw(spot_i)/2) < vehicle(i).Location(2)) && (vehicle(i).Location(2) < (spot(spot_i,spot_j).Ypoint + yrw(spot_i)/2)))  
                            
                            if((spot_i == 1)&&(spot_j == 1))
                                rotation_mode = 7;
                            elseif((spot_i == 1)&&(spot_j == Num_vertical))
                                rotation_mode = 9;
                            elseif((spot_i == Num_horizontal)&&(spot_j == 1))
                                rotation_mode = 1;
                            elseif((spot_i == Num_horizontal)&&(spot_j == Num_vertical))
                                rotation_mode = 3;
                            elseif(spot_j == 1)
                                rotation_mode = 4;
                            elseif(spot_j == Num_vertical)
                                rotation_mode = 6;
                            elseif(spot_i == 1)
                                rotation_mode = 8;
                            elseif(spot_i == Num_horizontal)
                                rotation_mode = 2;
                            else
                                rotation_mode = 5;
                            end

                            vehicle(i).spot_in = 1; % spot안에 있음을 나타내는 변수
                            vehicle(i).spot_x = spot_j;
                            vehicle(i).spot_y = spot_i;
                       
                        end
                    end
                end
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%%%rotation mode에 따른  x,y 방향 결정(방향 전환)%%%%%%%%%%%%%%%%%%
            
            if(vehicle(i).spot_in == 1)
                if(rotation_mode == 7)
                    if(vehicle(i).direction == 'v')
                        % 오른쪽으로 가는 도로에 놓여지도록
                        vehicle(i).direction = '>';
                        d = yrw(1)/7;
                        random_d = fix(d*rand()+1);
                        vehicle(i).Location = [ xrw(1)+2 ,hor_centerLine(1,1)-(1.75)*(2*random_d - 1)];
                        
                    elseif(vehicle(i).direction == '<')
                        % 위쪽으로 가는 도로에 놓여지도록
                        vehicle(i).direction = '^';
                        d = xrw(1)/7;
                        random_d = fix(d*rand()+1);
                        vehicle(i).Location = [ ver_centerLine(1,1)+(1.75)*(2*random_d - 1),yrw(1)+2];

                    else
                        
                    end
                    
                elseif(rotation_mode == 9)
                    if(vehicle(i).direction == 'v')
                        % 왼쪽으로 가는(수평) 도로에 놓여지도록
                        vehicle(i).direction = '<';
                        d = yrw(1)/7;
                        random_d = fix(d*rand()+1);
                        vehicle(i).Location = [X_Size_Road-xrw(1,Num_vertical)-2,hor_centerLine(1,1)+(1.75)*(2*random_d - 1)];
                    
                    elseif(vehicle(i).direction == '>')
                        % 위쪽으로 가는 도로에 놓여지도록
                        vehicle(i).direction = '^';
                        d = xrw(Num_vertical)/7;
                        random_d = fix(d*rand()+1);
                        vehicle(i).Location = [ ver_centerLine(1,Num_vertical)+(1.75)*(2*random_d - 1),yrw(1)+2];
                        
                    else
                        
                    end
                    
                    
                elseif(rotation_mode == 1)
                    if(vehicle(i).direction == '<')
                        % 아래쪽으로 가는 도로에 놓여지도록
                        vehicle(i).direction = 'v';
                        d = xrw(1)/7;
                        random_d = fix(d*rand()+1);
                        vehicle(i).Location = [ ver_centerLine(1,1)-(1.75)*(2*random_d - 1),Y_Size_Road-yrw(1,Num_horizontal)-2];
                        
                    elseif(vehicle(i).direction == '^')
                        % 오른쪽으로 가는 도로에 놓여지도록
                        vehicle(i).direction = '>';
                        d = yrw(Num_horizontal)/7;
                        random_d = fix(d*rand()+1);
                        vehicle(i).Location = [ xrw(1)+2 ,hor_centerLine(1,Num_horizontal)-(1.75)*(2*random_d - 1)];
                        
                    else
                        
                    end
                    
                elseif(rotation_mode == 3)
                    if(vehicle(i).direction == '>')
                        % 아래쪽으로 가는 도로에 놓여지도록
                        vehicle(i).direction = 'v';
                        d = xrw(Num_vertical)/7;
                        random_d = fix(d*rand()+1);
                        vehicle(i).Location = [ ver_centerLine(1,Num_vertical)-(1.75)*(2*random_d - 1),Y_Size_Road-yrw(1,Num_horizontal)-2];
                        
                    elseif(vehicle(i).direction == '^')
                        % 왼쪽으로 가는(수평) 도로에 놓여지도록
                        vehicle(i).direction = '<';
                        d = yrw(Num_horizontal)/7;
                        random_d = fix(d*rand()+1);
                        vehicle(i).Location = [X_Size_Road-xrw(1,Num_vertical)-2,hor_centerLine(1,Num_horizontal)+(1.75)*(2*random_d - 1)];
                        
                    else
                    end
                    
                elseif(rotation_mode == 4)
                    if(vehicle(i).direction == '^')
                        r =rand();
                        if(r<0.5)
                            % 오른쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '>';
                            d = yrw(vehicle(i).spot_y)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ xrw(1)+2 ,hor_centerLine(1,vehicle(i).spot_y)-(1.75)*(2*random_d - 1)];
                        else
                        end
                    elseif(vehicle(i).direction == 'v')
                        r = rand();
                        if(r<0.5)
                            % 오른쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '>';
                            d = yrw(vehicle(i).spot_y)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ xrw(1)+2 ,hor_centerLine(1,vehicle(i).spot_y)-(1.75)*(2*random_d - 1)];
                        else
                        end
                            
                    elseif(vehicle(i).direction == '<')
                        r = rand();
                        if(r<0.5)
                            % 위쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '^';
                            d = xrw(1)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,1)+(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)+yrw(vehicle(i).spot_y)/2+2];
                        else
                            % 아래쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = 'v';
                            d = xrw(1)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,1)-(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)-yrw(vehicle(i).spot_y)/2-2];
                        end
                    else
                    end
                        
                elseif(rotation_mode == 6)
                    if(vehicle(i).direction == '^')
                        r= rand();
                        if(r<0.5)
                            % 왼쪽으로 가는(수평) 도로에 놓여지도록
                            vehicle(i).direction = '<';
                            d = yrw(vehicle(i).spot_y)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [X_Size_Road-xrw(1,Num_vertical)-2,hor_centerLine(1,vehicle(i).spot_y)+(1.75)*(2*random_d - 1)];
                        end
                            
                    elseif(vehicle(i).direction == 'v')
                        r = rand();
                        if(r<0.5)
                            % 왼쪽으로 가는(수평) 도로에 놓여지도록
                            vehicle(i).direction = '<';
                            d = yrw(vehicle(i).spot_y)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [X_Size_Road-xrw(1,Num_vertical)-2,hor_centerLine(1,vehicle(i).spot_y)+(1.75)*(2*random_d - 1)];
                        end
                        
                            
                    elseif(vehicle(i).direction == '>')
                        r = rand();
                        if(r<0.5)
                            % 위쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '^';
                            d = xrw(Num_vertical)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,Num_vertical)+(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)+yrw(vehicle(i).spot_y)/2+2];
                        else
                            % 아래쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = 'v';
                            d = xrw(Num_vertical)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,Num_vertical)-(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)-yrw(vehicle(i).spot_y)/2-2];
                        end
                            
                    else
                    end
                    
                elseif(rotation_mode == 8)
                    if(vehicle(i).direction == '<')
                        r=rand();
                        if(r<0.5)
                            % 위쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '^';
                            d = xrw(vehicle(i).spot_x)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+(1.75)*(2*random_d - 1),yrw(1)+2];
                        end
                    elseif(vehicle(i).direction == '>')
                        r=rand();
                        if(r<0.5)
                            % 위쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '^';
                            d = xrw(vehicle(i).spot_x)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+(1.75)*(2*random_d - 1),yrw(1)+2];
                        end
                    elseif(vehicle(i).direction == 'v')
                        r = rand();
                        if(r<0.5)
                            % 왼쪽으로 가는(수평) 도로에 놓여지도록
                            vehicle(i).direction = '<';
                            d = yrw(1)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ver_centerLine(1,vehicle(i).spot_x)-xrw(1,vehicle(i).spot_x)/2-2,hor_centerLine(1,1)+(1.75)*(2*random_d - 1)];
                        else
                            % 오른쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '>';
                            d = yrw(1)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ver_centerLine(1,vehicle(i).spot_x)+xrw(1,vehicle(i).spot_x)/2+2,hor_centerLine(1,1)-(1.75)*(2*random_d - 1)];
                            
                        end
                    else
                    end
                    
                elseif(rotation_mode == 2)
                    if(vehicle(i).direction == '<')
                        r = rand();
                        if(r<0.5)
                            % 아래쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = 'v';
                            d = xrw(vehicle(i).spot_x)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-(1.75)*(2*random_d - 1),hor_centerLine(1,Num_horizontal)-yrw(vehicle(i).spot_y)/2-2];
                        end
                            
                    elseif(vehicle(i).direction == '>')
                        r = rand();
                        if(r<0.5)
                            % 아래쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = 'v';
                            d = xrw(vehicle(i).spot_x)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-(1.75)*(2*random_d - 1),hor_centerLine(1,Num_horizontal)-yrw(vehicle(i).spot_y)/2-2];
                        end
                    elseif(vehicle(i).direction == '^')
                        r = rand();
                        if(r<0.5)
                            % 왼쪽으로 가는(수평) 도로에 놓여지도록
                            vehicle(i).direction = '<';
                            d = yrw(Num_horizontal)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ver_centerLine(1,vehicle(i).spot_x)-xrw(1,vehicle(i).spot_x)/2-2,hor_centerLine(1,Num_horizontal)+(1.75)*(2*random_d - 1)];
                        else
                            % 오른쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '>';
                            d = yrw(Num_horizontal)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ver_centerLine(1,vehicle(i).spot_x)+xrw(1,vehicle(i).spot_x)/2+2,hor_centerLine(1,Num_horizontal)-(1.75)*(2*random_d - 1)];
                            
                        end
                    else
                    end
                    
                else %% 내부 교차로
                    if(vehicle(i).direction == '<')
                        r= rand();
                        if(r<0.3)
                            % 위쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '^';
                            d = xrw(vehicle(i).spot_x)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)+yrw(vehicle(i).spot_y)/2+2];
                        elseif((0.3<=r)&&(r<0.6))
                            % 아래쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = 'v';
                            d = xrw(vehicle(i).spot_x)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)-yrw(vehicle(i).spot_y)/2-2];
                        end
                            
                    elseif(vehicle(i).direction == '>')
                        r= rand();
                        if(r<0.3)
                            % 위쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '^';
                            d = xrw(vehicle(i).spot_x)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)+yrw(vehicle(i).spot_y)/2+2];
                        elseif((0.3<=r)&&(r<0.6))
                            % 아래쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = 'v';
                            d = xrw(vehicle(i).spot_x)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)-yrw(vehicle(i).spot_y)/2-2];
                        end
                    elseif(vehicle(i).direction == '^')
                        r= rand();
                        if(r<0.3)
                            % 왼쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '<';
                            d = yrw(vehicle(i).spot_y)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-xrw(vehicle(i).spot_x)/2-2, hor_centerLine(1,vehicle(i).spot_y)+(1.75)*(2*random_d - 1),];
                        elseif((0.3<=r)&&(r<0.6))
                            % 오른쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '>';
                            d = yrw(vehicle(i).spot_y)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+xrw(vehicle(i).spot_x)/2+2, hor_centerLine(1,vehicle(i).spot_y)-(1.75)*(2*random_d - 1),];
                        end
                    elseif(vehicle(i).direction == 'v')
                        r= rand();
                        if(r<0.3)
                            % 왼쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '<';
                            d = yrw(vehicle(i).spot_y)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-xrw(vehicle(i).spot_x)/2-2, hor_centerLine(1,vehicle(i).spot_y)+(1.75)*(2*random_d - 1),];
                        elseif((0.3<=r)&&(r<0.6))
                            % 오른쪽으로 가는 도로에 놓여지도록
                            vehicle(i).direction = '>';
                            d = yrw(vehicle(i).spot_y)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+xrw(vehicle(i).spot_x)/2+2, hor_centerLine(1,vehicle(i).spot_y)-(1.75)*(2*random_d - 1),];
                        end
                    else
                    end
                    
                end
                vehicle(i).spot_in = 0;
            end
                  
            if vehicle(i).ID == source
                set(vehicle(source).imageCar, 'XData',vehicle(source).Location(1), 'YData',vehicle(source).Location(2) , 'Color','r', ...
                    'Marker',vehicle(source).direction, 'MarkerSize',20,'LineWidth',6) % 그리기    
                set(vehicle(source).t, 'Position', [vehicle(source).Location(1)+5 vehicle(source).Location(2)]);
                set(vehicle(source).s, 'Position', [vehicle(source).Location(1)+5 vehicle(source).Location(2)+8]);
            
            elseif vehicle(i).ID == destination
                set(vehicle(destination).imageCar, 'XData',vehicle(destination).Location(1), 'YData',vehicle(destination).Location(2) , 'Color','g', ...
                    'Marker',vehicle(destination).direction, 'MarkerSize',20,'LineWidth',6) % 그리기 
                set(vehicle(destination).t, 'Position', [vehicle(destination).Location(1)+5 vehicle(destination).Location(2)]);
                set(vehicle(destination).d, 'Position', [vehicle(destination).Location(1)+5 vehicle(destination).Location(2)+8]);
            
            else
                 set(vehicle(i).imageCar, 'XData',vehicle(i).Location(1), 'YData',vehicle(i).Location(2) , 'Color','b', ...
                    'Marker',vehicle(i).direction, 'MarkerSize',7,'LineWidth',0.5) % 그리기
                 set(vehicle(i).t, 'Position', [vehicle(i).Location(1)+5 vehicle(i).Location(2)]);
    
            end
            
           for j=1:Num_vehicle
                 distance(i,j) = sqrt((vehicle(i).Location(1)-vehicle(j).Location(1)).^2 +(vehicle(i).Location(2)-vehicle(j).Location(2)).^2);
            end
            
        end
       
        pause(0.05);
end




