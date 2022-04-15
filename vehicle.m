function varargout = vehicle(varargin)
% VEHICLE MATLAB code for vehicle.fig
%      VEHICLE, by itself, creates a new VEHICLE or raises the existing
%      singleton*.
%
%      H = VEHICLE returns the handle to a new VEHICLE or the handle to
%      the existing singleton*.
%
%      VEHICLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VEHICLE.M with the given input arguments.
%
%      VEHICLE('Property','Value',...) creates a new VEHICLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vehicle_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vehicle_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vehicle

% Last Modified by GUIDE v2.5 07-Dec-2015 08:45:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vehicle_OpeningFcn, ...
                   'gui_OutputFcn',  @vehicle_OutputFcn, ...
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


% --- Executes just before vehicle is made visible.
function vehicle_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vehicle (see VARARGIN)

% Choose default command line output for vehicle
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vehicle wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vehicle_OutputFcn(hObject, eventdata, handles) 
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

% hObject    handle to car_create (see GCBO)
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


%%%%%%%%%%%%%%%%%%%%%%%% axes x��, y�� �°� ������ ����� %%%%%%%%%%%%%%% 
hAxe = handles.axes1;
ax_xlim = get(hAxe,'XLim');
ax_xlim(2) = X_Size_Road;
set(hAxe,'XLim',ax_xlim);

ax_ylim = get(hAxe,'YLim');
ax_ylim(2) = Y_Size_Road;
set(hAxe,'YLim',ax_ylim);

%%%%%%%%%%%%%%%%%%%%%%% ���찳 ���� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rectangle('position',[0 0 X_Size_Road Y_Size_Road], 'FaceColor',[1 1 1],'EdgeColor',[1 1 1]);

mode_num = lane_to/2; % ������ �� �ִ� ���� ������

xrw = zeros(1,Num_vertical-1);
yrw = zeros(1,Num_horizontal-1);

%%%%%%%%%%%%%%%%%%%%%%% ���� ���� ���� �׸���  %%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%% ���� ���� ���� �׸���  %%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%% Sub ���� cell ���� �˰��� %%%%%%%%%%%%%%%%%%%%%%

cell_total_num = (Num_horizontal-1) * (Num_vertical-1);
cell_part_num = fix(cell_total_num * cell_part_ratio);
count = 0;

for i=1:Num_horizontal-1
    for j=1:Num_vertical-1
        
        x = ver_interval*(j-1) + xrw(1,j);
        y = hor_interval*(i-1) + yrw(1,i);
        
        cell_bool = fix(2*rand(1,1));   % ���� sub street���� ���� �� ������, �� ������
        
        if((cell_bool == 1) && ( count ~= cell_part_num ))
            %hold on;
            %plot(x, y, 'b*');
            count = count + 1;
            
            %%%%%%%%%%%%%% Sub vertical, horizontal, both ���� %%%%%%%%%%%%
           
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

%%%%%%%%%%%%%%%%%%%%%%%%%%% �߾Ӽ� �׸��� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%%%%%%%%%%%%%%%%%%%%%%%%%% ȸ�� Spot �׸��� %%%%%%%%%%%%%%%%%%%%%%%%%%%

spot = struct();
spot_count = 1;

rsu = struct();     % RSU 
cnt = 0;                        %RSU ���̴� ���Ű�
for i=1:Num_horizontal
    for j=1:Num_vertical
        
        cnt = cnt + 1;
        rsu(i, j).ID = cnt;     %RSU ���� ���̵�

        x = ver_interval*(j-1) + xrw(1,j)/2;
        y = hor_interval*(i-1) + yrw(1,i)/2;
        
        if(j == Num_vertical)
            x = ver_interval*(j-1) - xrw(1,j)/2;
        end
        
        if(i == Num_horizontal)
           y = hor_interval*(i-1) - yrw(1,i)/2; 
        end
        
        hold on;
        plot(x, y, 'r*','LineWidth',2);     % RSU ������
        
        rsu(i, j).Xpoint = x;               % RSU x,y��ǥ
        rsu(i, j).Ypoint = y;

        spot(i,j).Xpoint = x; % �ش� spot�� x��ǥ
        spot(i,j).Ypoint = y; % �ش� spot�� y��ǥ
        spot_count = spot_count + 1;   % spot ���� 1 ����

    end
end

%set(handles.num_spot,'String',spot_count); % spot ���� ��� (�������� +1 ���༭ 1�� �� ũ�� ����)

%%%%%%%%%%%%% Lane dependent �� ��, �� ������ �׷��� ���� ��(unit_car_num) ��� %%%%%%%%%%%%%
num_lane_hor = 0;
num_lane_ver = 0;

for a = 1:Num_horizontal
    aa = yrw(a)/7;
    num_lane_hor = num_lane_hor + aa;
end

for a = 1:Num_vertical
    aa = xrw(a)/7;
    num_lane_ver = num_lane_ver + aa;
end

unit_car_num = fix(Num_vehicle / (num_lane_hor + num_lane_ver));

%%%%%%%%%%%%% unit_car_num ���� ����� �迭���� %%%%%%%%%%%
if(Num_horizontal > Num_vertical)
    car_count = zeros(4,Num_horizontal);
else
    car_count = zeros(4,Num_vertical);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vehicle=struct(); % vehicle ���� ������ struct�� ����ȭ��
RV=10; % Vehicle�� �� component�� ����
% �ʱ� ������ �ʿ��� �ӽ� random number ������ ����
% zeros(1,n) : ��� ���Ұ� 0�� 1xn ����� ����
temp=zeros(1,length(RV)); 

for i=1:Num_vehicle
    
    %%%% vehicle���� ������ ID �ο�����
    vehicle(i).ID = i;
    vehicle(i).spot_in = 0;
    vehicle(i).spot_x = 0;
    vehicle(i).spot_y = 0;
    
    %%%%%% �ӵ� ���� %%%%%%
    if(i < Num_vehicle/3)
        vehicle(i). speed = 0.2;
    elseif((i>= Num_vehicle/3) && ( i < (Num_vehicle*2)/3) )
        vehicle(i). speed = 0.4;   
    else
        vehicle(i). speed = 0.8;    
    end
    
    
    %%%% �ʱ� ���� ����
    temp(1,1) = rand(); % �ʱ���⼳������ ���� -> 0.25 ���ϸ� a���� 0.25�̻� 0.5���ϴ� b ����
                        % temp(1,1) : �ʱ� ���� ������ ���� ���� ���� ����
                        % ���� : < , ���� : ^ , ������: > , �Ʒ��� : v
    %temp(1,1) = 0.2;
                     
    if temp(1,1) < 0.25
        vehicle(i).direction = '<'; % �ʱ⿡ �������� ���
    elseif temp(1,1) >=0.25 && temp(1,1) < 0.5
        vehicle(i).direction = '^'; % �ʱ⿡ �������� ���
    elseif temp(1,1) >=0.5 && temp(1,1) < 0.75
        vehicle(i).direction = '>'; % �ʱ⿡ ���������� ���
    else
        vehicle(i).direction = 'v'; % �ʱ⿡ �Ʒ������� ���
    end
    
    
    %%%% �ʱ� ��ġ ����
    if vehicle(i).direction == '<' % �ʱ������ �����̶��
        % �������� ����(����) ���ο� ����������
        % �̶�, ���� ���ο� �������� x��ǥ�� ���Ϲ���(xrw(1)~X_Road_Size - xrw(3))�μ���
        % fix: 0 �������� �ݿø� 
        temp(1,2) = fix(Num_horizontal*rand()+1);
        t = temp(1,2);
        d = yrw(t)/7;   %������ ����� �� ������ ���� ����
        random_d = fix(d*rand()+1);
        vehicle(i).Location = [ fix(xrw(1,1)+(X_Size_Road-xrw(1,3))*rand()),hor_centerLine(1,t)+(1.75)*(2*random_d - 1)];
        
        % ���� rsu1 -> rsu2 ���� �Է�
        y = 0;
        for b=1:Num_vehicle
            if vehicle(i).Location(2) < b
                y = b;
            end
        end

        x = 0;
        for a=1:Num_horizontal
            if vehicle(i).Location(1) < a
                x = a - 1;
            elseif vehicle(i).Location(1) > Num_horizontal
                x = Num_horizontal;    
            end
        end

        vehicle(i).fromRsu = rsu(x, y);
        vehicle(i).toRsu = rsu(x, y - 1);
        



%         temp(1,2) = fix(Num_horizontal*rand()+1);
%         t = temp(1,2);
%         no = t;
%         d = yrw(t)/7;   %������ ����� �� ������ ���� ����
%         random_d = fix(d*rand()+1);
%         
%         if( car_count(1,t) == (unit_car_num*d));
%             while(t == no);
%                 temp(1,2) = fix(Num_horizontal*rand()+1);
%                 t = temp(1,2);
%                 d = yrw(t)/7;   % ������ ����� �� ������ ���� ����
%                 random_d = fix(d*rand()+1);
%             end        
%         end
%         
%         vehicle(i).Location = [ fix(xrw(1,1)+(X_Size_Road-xrw(1,3))*rand()),hor_centerLine(1,t)+(1.75)*(2*random_d - 1)];
%         car_count(1,t) = car_count(1,t)+1;


    
      
    elseif vehicle(i).direction == '^' % �ʱ������ �����̶��
        % �������� ���� ���ο� ����������
        temp(1,3) = fix(Num_vertical*rand()+1);
        t = temp(1,3);
        d = xrw(t)/7;
        random_d = fix(d*rand()+1);
        vehicle(i).Location = [ ver_centerLine(1,t)+(1.75)*(2*random_d - 1),fix(yrw(1,1)+(Y_Size_Road-yrw(1,3))*rand()),];
    
        % ���� rsu1 -> rsu2 ���� �Է�
        y = 0;
        for b=1:Num_vehicle
            if vehicle(i).Location(2) < b
                y = b - 1;
            elseif vehicle(i).Location(2) > Num_vehicle
                y = Num_vehicle;
            end
        end

        x = 0;
        for a=1:Num_horizontal
            if vehicle(i).Location(1) < a
                x = a - 1;
            end
        end

        vehicle(i).fromRsu = rsu(x, y);
        vehicle(i).toRsu = rsu(x  + 1, y);
        

    elseif vehicle(i).direction == '>' % �ʱ������ �������̶��
        % ���������� ���� ���ο� ����������
        temp(1,4) = fix(Num_horizontal*rand()+1);
        t = temp(1,4);
        d = yrw(t)/7;
        random_d = fix(d*rand()+1);
        vehicle(i).Location = [ fix(xrw(1,1)+(X_Size_Road-xrw(1,3))*rand()),hor_centerLine(1,t)-(1.75)*(2*random_d - 1)];
        
        
        % ���� rsu1 -> rsu2 ���� �Է�
        y = 0;
        for b=1:Num_vehicle
            if vehicle(i).Location(2) < b
                y = b - 1;
            end
        end

        x = 0;
        for a=1:Num_horizontal
            if vehicle(i).Location(1) < a
                x = a;
            end
        end

        vehicle(i).fromRsu = rsu(x, y);
        vehicle(i).toRsu = rsu(x, y + 1);


    elseif vehicle(i).direction == 'v' % �ʱ������ �Ʒ����̶��
        % �Ʒ������� ���� ���ο� ����������
        temp(1,5) = fix(Num_vertical*rand()+1);
        t = temp(1,5);
        d = xrw(t)/7;
        random_d = fix(d*rand()+1);
        vehicle(i).Location = [ ver_centerLine(1,t)-(1.75)*(2*random_d - 1),fix(yrw(1,1)+(Y_Size_Road-yrw(1,3))*rand()),];
        
        % ���� rsu1 -> rsu2 ���� �Է�
        y = 0;
        for b=1:Num_vehicle
            if vehicle(i).Location(2) < b
                y = b;
            end
        end

        x = 0;
        for a=1:Num_horizontal
            if vehicle(i).Location(1) < a
                x = a;
            end
        end

        vehicle(i).fromRsu = rsu(x, y);
        vehicle(i).toRsu = rsu(x - 1, y);


    end
    
   
   

end



global source
global destination
global distance

distance = zeros(length(Num_vehicle),length(Num_vehicle)); %�� vehicle���� �Ÿ� ����

vehicle(source).s = text(vehicle(source).Location(1)+10,vehicle(source).Location(2)+10,'source','Position',[300 300]);
vehicle(destination).d = text(vehicle(destination).Location(1)+10,vehicle(destination).Location(2)+10,'destination','Position',[300 300]);

%% %%%%%%%%%%%%%%%%%%%% ó�� ���� �׸��� %%%%%%%%%%%%%%%%%%%%%%%%
for i=1:Num_vehicle % ���� �ѹ��� �����ؼ� �ѷ��ֱ�
    vehicle(i).imageCar = line('XData',vehicle(i).Location(1), 'YData',vehicle(i).Location(2), 'Color','b', ...
        'Marker',vehicle(i).direction, 'MarkerSize',7, 'LineWidth',0.5);
    vehicle(i).t = text(vehicle(i).Location(1),vehicle(i).Location(2),int2str(i),'Position',[300 300]);
end


%%%%%%%%%%%%%%%%%%%%%%%%% AODV %%%%%%%%%%%%%%%%%%%%%%%%%
global pr
global gt
global gr
global pt
global l
global f
global b1
global b2
global d1
global d2
global rt
global htd
global nr




c = 3*10^8;
count = 0;
d1 = nthroot((pt*0.001*9*10^16)/((pr*0.001)*16*(pi^2)*(f^2)*10^12),b1);
d2 = nthroot((pt*0.001*9*10^16)/((pr*0.001)*16*(pi^2)*(f^2)*10^12),b2);
count1 = 0;
count2 = 0;
count3 = 0;
count4 = 0;
count11 = [];
count22 = [];
count33 = [];
count44 = [];
htd = (d1/c)*1000;
set(handles.edit36,'String',htd);
set(handles.text110,'String',d1);
set(handles.text111,'String',d2);
set(handles.text123,'String',source);
set(handles.text125,'String',destination);

timev = repmat(struct('send',1:Num_vehicle,'reply',1:Num_vehicle,'flag',0),1,MAX_TIME);
info = zeros(Num_vehicle,Num_vehicle,Num_vehicle);
line_bool = zeros(Num_vehicle, Num_vehicle);

%%%%%%%%% RREQ ���� %%%%%%%%%%%%
first_rreq_seq_mode = 0;
rreq_mode = 1;
rrep_mode = 0;
data_mode = 0;
hop_count = 0; 
retry_mode = 0;

RREQ_Line_count = 0;
RREQ1_Line_count = 0;% ���� ����
RREP_Line_count = 0;
DATA_Line_count = 0;
a = 0
tp = 0;
fp = 0;
max1 = 0;
max2  =0;
max3 = 0;
max4 = 0;
rp1 = 1;
rp2 = 1;

RREQ = struct(); %RREQ ���� �Ӽ� ����(draw, source, destination)
RREP = struct(); %RREP ���� �Ӽ� ����
DATA = struct();

for i=1:MAX_TIME 
    for j=1:1:Num_vehicle
        timev(i).flag(j) = 0;
        timev(i).reply(j) = 0;
        timev(i).send(j) = 0;
    end
end

tic %����ð� ����
%% %%%%%%%%%%%%%% Move ���� ���� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (�ӵ�, �ʱ���⿡ ���� ���� )
%% �ð��帧�� ���� ����
global percent
percent = 0.4;
for ret = 1:nr %10�� ��õ�
    for time = 1:rt % �ð��� ���� ������Ȯ��
        if(rem(time,5) == 0)        % 5�ʸ��� ���� ����Ȯ�� ����
            percent = percent + 0.1;
            if(percent == 0.7)
                percent = 0.4;
            end
        end 
        for i=1:Num_vehicle  
        
                % �� ������ �ʱ� ���⿡ ���� ��ġ ���� (�̸� �̿��ؼ� x,y��ǥ ���� ����)
                if vehicle(i).direction == '<' % �ʱ⿡ �������� ���
                    % �����̵�
                    vehicle(i).Location(1) = vehicle(i).Location(1) - vehicle(i).speed;
                    if(vehicle(i).Location(1) < 0)
                        vehicle(i).Location(1) = X_Size_Road;
                    end
                elseif  vehicle(i).direction == '^'
                    % �����̵�
                    vehicle(i).Location(2) = vehicle(i).Location(2) + vehicle(i).speed;
                    if(vehicle(i).Location(2) > Y_Size_Road)
                        vehicle(i).Location(2) = 0;
                    end
                elseif   vehicle(i).direction == '>' 
                    % �������̵�
                    vehicle(i).Location(1) = vehicle(i).Location(1) + vehicle(i).speed;
                     if(vehicle(i).Location(1) > X_Size_Road)
                        vehicle(i).Location(1) = 0;
                    end
                elseif vehicle(i).direction == 'v'
                    % �Ʒ����̵�
                    vehicle(i).Location(2) = vehicle(i).Location(2) - vehicle(i).speed;
                    if(vehicle(i).Location(2) < 0)
                        vehicle(i).Location(2) = Y_Size_Road;
                    end
                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rotation mode ���� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

                                vehicle(i).spot_in = 1; % spot�ȿ� ������ ��Ÿ���� ����
                                vehicle(i).spot_x = spot_j;
                                vehicle(i).spot_y = spot_i;

                            end
                        end
                    end
                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %%%%%%%%%%%%%%%%%%%%%rotation mode�� ����  x,y ���� ����(���� ��ȯ)%%%%%%%%%%%%%%%%%%

                if(vehicle(i).spot_in == 1)
                    if(rotation_mode == 7)
                        if(vehicle(i).direction == 'v')
                            % ���������� ���� ���ο� ����������
                            vehicle(i).direction = '>';
                            d = yrw(1)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ xrw(1)+2 ,hor_centerLine(1,1)-(1.75)*(2*random_d - 1)];
                            
                            % rsu���� ����
                            vehicle(i).fromRsu = vehicle(i).toRsu; 
                            vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1); 
        

                        elseif(vehicle(i).direction == '<')
                            % �������� ���� ���ο� ����������
                            vehicle(i).direction = '^';
                            d = xrw(1)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,1)+(1.75)*(2*random_d - 1),yrw(1)+2];

                            % rsu���� ����
                            vehicle(i).fromRsu = vehicle(i).toRsu; 
                            vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint); 

                        else

                        end

                    elseif(rotation_mode == 9)
                        if(vehicle(i).direction == 'v')
                            % �������� ����(����) ���ο� ����������
                            vehicle(i).direction = '<';
                            d = yrw(1)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [X_Size_Road-xrw(1,Num_vertical)-2,hor_centerLine(1,1)+(1.75)*(2*random_d - 1)];
                            
                            % rsu���� ����
                            vehicle(i).fromRsu = vehicle(i).toRsu; 
                            vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint - 1); 

                        elseif(vehicle(i).direction == '>')
                            % �������� ���� ���ο� ����������
                            vehicle(i).direction = '^';
                            d = xrw(Num_vertical)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,Num_vertical)+(1.75)*(2*random_d - 1),yrw(1)+2];

                            % rsu���� ����
                            vehicle(i).fromRsu = vehicle(i).toRsu; 
                            vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint); 

                        else

                        end


                    elseif(rotation_mode == 1)
                        if(vehicle(i).direction == '<')
                            % �Ʒ������� ���� ���ο� ����������
                            vehicle(i).direction = 'v';
                            d = xrw(1)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,1)-(1.75)*(2*random_d - 1),Y_Size_Road-yrw(1,Num_horizontal)-2];
                            

                            % rsu���� ����
                            vehicle(i).fromRsu = vehicle(i).toRsu; 
                            vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint); 

                        elseif(vehicle(i).direction == '^')
                            % ���������� ���� ���ο� ����������
                            vehicle(i).direction = '>';
                            d = yrw(Num_horizontal)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ xrw(1)+2 ,hor_centerLine(1,Num_horizontal)-(1.75)*(2*random_d - 1)];

                            % rsu���� ����
                            vehicle(i).fromRsu = vehicle(i).toRsu; 
                            vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1); 

                        else

                        end

                    elseif(rotation_mode == 3)
                        if(vehicle(i).direction == '>')
                            % �Ʒ������� ���� ���ο� ����������
                            vehicle(i).direction = 'v';
                            d = xrw(Num_vertical)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [ ver_centerLine(1,Num_vertical)-(1.75)*(2*random_d - 1),Y_Size_Road-yrw(1,Num_horizontal)-2];
                            

                            % rsu���� ����
                            vehicle(i).fromRsu = vehicle(i).toRsu; 
                            vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint); 

                        elseif(vehicle(i).direction == '^')
                            % �������� ����(����) ���ο� ����������
                            vehicle(i).direction = '<';
                            d = yrw(Num_horizontal)/7;
                            random_d = fix(d*rand()+1);
                            vehicle(i).Location = [X_Size_Road-xrw(1,Num_vertical)-2,hor_centerLine(1,Num_horizontal)+(1.75)*(2*random_d - 1)];
                            

                            % rsu���� ����
                            vehicle(i).fromRsu = vehicle(i).toRsu; 
                            vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint - 1); 

                        else
                        end

                    elseif(rotation_mode == 4)
                        if(vehicle(i).direction == '^')
                            r =rand();
                            if(r<percent)
                                % ���������� ���� ���ο� ����������
                                vehicle(i).direction = '>';
                                d = yrw(vehicle(i).spot_y)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ xrw(1)+2 ,hor_centerLine(1,vehicle(i).spot_y)-(1.75)*(2*random_d - 1)];
                            
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1); 

                            else

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint); 

                            end
                        elseif(vehicle(i).direction == 'v')
                            r = rand();
                            if(r<percent)
                                % ���������� ���� ���ο� ����������
                                vehicle(i).direction = '>';
                                d = yrw(vehicle(i).spot_y)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ xrw(1)+2 ,hor_centerLine(1,vehicle(i).spot_y)-(1.75)*(2*random_d - 1)];
                                

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1);
                            
                            else

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint);

                            end

                        elseif(vehicle(i).direction == '<')
                            r = rand();
                            if(r<percent)
                                % �������� ���� ���ο� ����������
                                vehicle(i).direction = '^';
                                d = xrw(1)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,1)+(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)+yrw(vehicle(i).spot_y)/2+2];
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint);
                            
                            else
                                % �Ʒ������� ���� ���ο� ����������
                                vehicle(i).direction = 'v';
                                d = xrw(1)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,1)-(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)-yrw(vehicle(i).spot_y)/2-2];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint);
                            
                            end
                        else
                        end

                    elseif(rotation_mode == 6)
                        if(vehicle(i).direction == '^')
                            r= rand();
                            if(r<percent)
                                % �������� ����(����) ���ο� ����������
                                vehicle(i).direction = '<';
                                d = yrw(vehicle(i).spot_y)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [X_Size_Road-xrw(1,Num_vertical)-2,hor_centerLine(1,vehicle(i).spot_y)+(1.75)*(2*random_d - 1)];
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint - 1);
                            else
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint);
                            end

                        elseif(vehicle(i).direction == 'v')
                            r = rand();
                            if(r<percent)
                                % �������� ����(����) ���ο� ����������
                                vehicle(i).direction = '<';
                                d = yrw(vehicle(i).spot_y)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [X_Size_Road-xrw(1,Num_vertical)-2,hor_centerLine(1,vehicle(i).spot_y)+(1.75)*(2*random_d - 1)];
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint - 1);
                            
                            else
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint);
                            end


                        elseif(vehicle(i).direction == '>')
                            r = rand();
                            if(r<percent)
                                % �������� ���� ���ο� ����������
                                vehicle(i).direction = '^';
                                d = xrw(Num_vertical)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,Num_vertical)+(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)+yrw(vehicle(i).spot_y)/2+2];
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint);
                            
                            else
                                % �Ʒ������� ���� ���ο� ����������
                                vehicle(i).direction = 'v';
                                d = xrw(Num_vertical)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,Num_vertical)-(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)-yrw(vehicle(i).spot_y)/2-2];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint);

                            end

                        else
                        end

                    elseif(rotation_mode == 8)
                        if(vehicle(i).direction == '<')
                            r=rand();
                            if(r<percent)
                                % �������� ���� ���ο� ����������
                                vehicle(i).direction = '^';
                                d = xrw(vehicle(i).spot_x)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+(1.75)*(2*random_d - 1),yrw(1)+2];
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint);
                            
                            else
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint - 1);
                            end
                        elseif(vehicle(i).direction == '>')
                            r=rand();
                            if(r<percent)
                                % �������� ���� ���ο� ����������
                                vehicle(i).direction = '^';
                                d = xrw(vehicle(i).spot_x)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+(1.75)*(2*random_d - 1),yrw(1)+2];
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint);
                            else

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1);
                            end
                        elseif(vehicle(i).direction == 'v')
                            r = rand();
                            if(r<percent)
                                % �������� ����(����) ���ο� ����������
                                vehicle(i).direction = '<';
                                d = yrw(1)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ver_centerLine(1,vehicle(i).spot_x)-xrw(1,vehicle(i).spot_x)/2-2,hor_centerLine(1,1)+(1.75)*(2*random_d - 1)];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint - 1);

                            else
                                % ���������� ���� ���ο� ����������
                                vehicle(i).direction = '>';
                                d = yrw(1)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ver_centerLine(1,vehicle(i).spot_x)+xrw(1,vehicle(i).spot_x)/2+2,hor_centerLine(1,1)-(1.75)*(2*random_d - 1)];
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1);
                            
                            end
                        else
                        end

                    elseif(rotation_mode == 2)
                        if(vehicle(i).direction == '<')
                            r = rand();
                            if(r<percent)
                                % �Ʒ������� ���� ���ο� ����������
                                vehicle(i).direction = 'v';
                                d = xrw(vehicle(i).spot_x)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-(1.75)*(2*random_d - 1),hor_centerLine(1,Num_horizontal)-yrw(vehicle(i).spot_y)/2-2];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint);
                            
                            else

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint - 1);

                            end

                        elseif(vehicle(i).direction == '>')
                            r = rand();
                            if(r<percent)
                                % �Ʒ������� ���� ���ο� ����������
                                vehicle(i).direction = 'v';
                                d = xrw(vehicle(i).spot_x)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-(1.75)*(2*random_d - 1),hor_centerLine(1,Num_horizontal)-yrw(vehicle(i).spot_y)/2-2];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint);
                            
                            else

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1);

                            end
                        elseif(vehicle(i).direction == '^')
                            r = rand();
                            if(r<percent)
                                % �������� ����(����) ���ο� ����������
                                vehicle(i).direction = '<';
                                d = yrw(Num_horizontal)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ver_centerLine(1,vehicle(i).spot_x)-xrw(1,vehicle(i).spot_x)/2-2,hor_centerLine(1,Num_horizontal)+(1.75)*(2*random_d - 1)];
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint - 1);
                            
                            else
                                % ���������� ���� ���ο� ����������
                                vehicle(i).direction = '>';
                                d = yrw(Num_horizontal)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ver_centerLine(1,vehicle(i).spot_x)+xrw(1,vehicle(i).spot_x)/2+2,hor_centerLine(1,Num_horizontal)-(1.75)*(2*random_d - 1)];

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1);

                            end
                        else
                        end

                    else %% ���� ������
                        if(vehicle(i).direction == '<')
                            r= rand();
                            if(r<percent)
                                % �������� ���� ���ο� ����������
                                vehicle(i).direction = '^';
                                d = xrw(vehicle(i).spot_x)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)+yrw(vehicle(i).spot_y)/2+2];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint);

                            elseif((percent<=r)&&(r<0.8))
                                % �Ʒ������� ���� ���ο� ����������
                                vehicle(i).direction = 'v';
                                d = xrw(vehicle(i).spot_x)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)-yrw(vehicle(i).spot_y)/2-2];
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint);
                            
                            else

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint - 1);
                            
                            end

                        elseif(vehicle(i).direction == '>')
                            r= rand();
                            if(r<percent)
                                % �������� ���� ���ο� ����������
                                vehicle(i).direction = '^';
                                d = xrw(vehicle(i).spot_x)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)+yrw(vehicle(i).spot_y)/2+2];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint);
                            
                            elseif((percent<=r)&&(r<0.8))
                                % �Ʒ������� ���� ���ο� ����������
                                vehicle(i).direction = 'v';
                                d = xrw(vehicle(i).spot_x)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-(1.75)*(2*random_d - 1),hor_centerLine(1,vehicle(i).spot_y)-yrw(vehicle(i).spot_y)/2-2];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint);
                            
                            else

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1);
                            
                            end

                        elseif(vehicle(i).direction == '^')
                            r= rand();
                            if(r<percent)
                                % �������� ���� ���ο� ����������
                                vehicle(i).direction = '<';
                                d = yrw(vehicle(i).spot_y)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-xrw(vehicle(i).spot_x)/2-2, hor_centerLine(1,vehicle(i).spot_y)+(1.75)*(2*random_d - 1),];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint - 1);
                            
                            elseif((percent<=r)&&(r<0.8))
                                % ���������� ���� ���ο� ����������
                                vehicle(i).direction = '>';
                                d = yrw(vehicle(i).spot_y)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+xrw(vehicle(i).spot_x)/2+2, hor_centerLine(1,vehicle(i).spot_y)-(1.75)*(2*random_d - 1),];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1);
                            
                            else

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint + 1, vehicle(i).toRsu.Ypoint);

                            end
                        elseif(vehicle(i).direction == 'v')
                            r= rand();
                            if(r<percent)
                                % �������� ���� ���ο� ����������
                                vehicle(i).direction = '<';
                                d = yrw(vehicle(i).spot_y)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)-xrw(vehicle(i).spot_x)/2-2, hor_centerLine(1,vehicle(i).spot_y)+(1.75)*(2*random_d - 1),];
                                
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1);
                            
                            
                            elseif((percent<=r)&&(r<0.8))
                                % ���������� ���� ���ο� ����������
                                vehicle(i).direction = '>';
                                d = yrw(vehicle(i).spot_y)/7;
                                random_d = fix(d*rand()+1);
                                vehicle(i).Location = [ ver_centerLine(1,vehicle(i).spot_x)+xrw(vehicle(i).spot_x)/2+2, hor_centerLine(1,vehicle(i).spot_y)-(1.75)*(2*random_d - 1),];
                            
                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint, vehicle(i).toRsu.Ypoint + 1);
                            
                            else

                                % rsu���� ����
                                vehicle(i).fromRsu = vehicle(i).toRsu; 
                                vehicle(i).toRsu = rsu(vehicle(i).toRsu.Xpoint - 1, vehicle(i).toRsu.Ypoint);
                            
                            end
                        else
                        end

                    end
                    vehicle(i).spot_in = 0;
                end

                if vehicle(i).ID == source
                    set(vehicle(source).imageCar, 'XData',vehicle(source).Location(1), 'YData',vehicle(source).Location(2) , 'Color','r', ...
                        'Marker',vehicle(source).direction, 'MarkerSize',20,'LineWidth',6) % �׸���    
                    set(vehicle(source).t, 'Position', [vehicle(source).Location(1)+5 vehicle(source).Location(2)]);
                    set(vehicle(source).s, 'Position', [vehicle(source).Location(1)+5 vehicle(source).Location(2)+8]);

                elseif vehicle(i).ID == destination
                    set(vehicle(destination).imageCar, 'XData',vehicle(destination).Location(1), 'YData',vehicle(destination).Location(2) , 'Color','g', ...
                        'Marker',vehicle(destination).direction, 'MarkerSize',20,'LineWidth',6) % �׸��� 
                    set(vehicle(destination).t, 'Position', [vehicle(destination).Location(1)+5 vehicle(destination).Location(2)]);
                    set(vehicle(destination).d, 'Position', [vehicle(destination).Location(1)+5 vehicle(destination).Location(2)+8]);

                else
                     set(vehicle(i).imageCar, 'XData',vehicle(i).Location(1), 'YData',vehicle(i).Location(2) , 'Color','b', ...
                        'Marker',vehicle(i).direction, 'MarkerSize',7,'LineWidth',0.5) % �׸���
                     set(vehicle(i).t, 'Position', [vehicle(i).Location(1)+5 vehicle(i).Location(2)]);

                end

               for j=1:Num_vehicle
                     distance(i,j) = sqrt((vehicle(i).Location(1)-vehicle(j).Location(1)).^2 +(vehicle(i).Location(2)-vehicle(j).Location(2)).^2);
                end
        
        end

            %%%%%%%%%%%%%% AODV ���� %%%%%%%%%%%

            %%%%%%%%%%%%%% RREQ %%%%%%%%%%%%%%%%%%%

            if(rreq_mode == 1)
                if(time == 1)
                    set(handles.State_Message,'String','RREQ Broadcasting for searching Destination Vehicle node');
                    for i=1:Num_vehicle
                        for j=1:Num_horizontal
                            for k=1:Num_vertical
                                if ((distance(source,i)<d1) && (i~=destination))
                                    if ((abs(vehicle(source).Location(1)-vehicle(i).Location(1))<7) && (abs(vehicle(source).Location(1)-spot(j,k).Xpoint)<5) && (abs(vehicle(i).Location(1)-spot(j,k).Xpoint)<5)) || ((abs(vehicle(source).Location(2)-vehicle(i).Location(2))<7) && (abs(vehicle(source).Location(2)-spot(j,k).Ypoint)<5) && (abs(vehicle(i).Location(2)-spot(j,k).Ypoint)<5))                              
                                        line_bool(source,i) = 1;
                                        line_bool(i,source) = line_bool(source,i);  % ������ �ߺ����� �ʰ� �ϱ�����
                                        %a = plot(linspace(vehicle(source).Location(1),vehicle(i).Location(1),floor(distance(source,i))),linspace(vehicle(source).Location(2),vehicle(i).Location(2),floor(distance(source,i))),'--b');
                                        RREQ_Line_count = RREQ_Line_count+1;
                                        RREQ(RREQ_Line_count).draw = line('XData',[vehicle(source).Location(1),vehicle(i).Location(1)],'YData',[vehicle(source).Location(2),vehicle(i).Location(2)],'LineStyle','-.','LineWidth',0.5,'Color','b');
                                        RREQ(RREQ_Line_count).source = source;
                                        RREQ(RREQ_Line_count).destination = i;

                                        timev(1).send(source) = vehicle(source).ID; % time = 1�϶� RREP ������ ���� source
                                        timev(1).reply(i) = vehicle(i).ID;          % time = 1�϶� RREP �޴� ���� i
                                        info(source,i,1) = randi([1 10000]);          % info(��������, �޴���, time) , ������ �ѹ�
                                        if i==destination                           % 1 hop ���� �������� �������� ��
                                            timev(1).flag = 1;
                                            RREQ_Line_count = RREQ_Line_count+1;
                                            RREQ(RREQ_Line_count).draw = line('XData',[vehicle(source).Location(1),vehicle(i).Location(1)],'YData',[vehicle(source).Location(2),vehicle(i).Location(2)],'LineStyle','-','LineWidth',0.5,'Color','b');
                                            RREQ(RREQ_Line_count).source = source;
                                            RREQ(RREQ_Line_count).destination = i;
                                            %break;
                                        end


                                    else if ((distance(source,i)<d2) && (i~=destination))
                                            line_bool(source,i) = 1;
                                            line_bool(i,source) = line_bool(source,i);  % ������ �ߺ����� �ʰ� �ϱ�����
                                            %a = plot(linspace(vehicle(source).Location(1),vehicle(i).Location(1),floor(distance(source,i))),linspace(vehicle(source).Location(2),vehicle(i).Location(2),floor(distance(source,i))),'--b');
                                            RREQ_Line_count = RREQ_Line_count+1;
                                            RREQ(RREQ_Line_count).draw = line('XData',[vehicle(source).Location(1),vehicle(i).Location(1)],'YData',[vehicle(source).Location(2),vehicle(i).Location(2)],'LineStyle','-.','LineWidth',0.5,'Color','c');
                                            RREQ(RREQ_Line_count).source = source;
                                            RREQ(RREQ_Line_count).destination = i;

                                            timev(1).send(source) = vehicle(source).ID; % time = 1�϶� RREP ������ ���� source
                                            timev(1).reply(i) = vehicle(i).ID;          % time = 1�϶� RREP �޴� ���� i
                                            info(source,i,1) = randi([1 10000]);          % info(��������, �޴���, time) , ������ �ѹ�
                                            if i==destination                           % 1 hop ���� �������� �������� ��
                                                timev(1).flag = 1;
                                                RREQ_Line_count = RREQ_Line_count+1;
                                                RREQ(RREQ_Line_count).draw = line('XData',[vehicle(source).Location(1),vehicle(i).Location(1)],'YData',[vehicle(source).Location(2),vehicle(i).Location(2)],'LineStyle','-','LineWidth',0.5,'Color','c');
                                                RREQ(RREQ_Line_count).source = source;
                                                RREQ(RREQ_Line_count).destination = i;
                                                %break;
                                            end

                                        end
                                    end
                                end
                            end
                        end

                    end
                    pause(1);

                else
                   for i=1:Num_vehicle   
                       for p=1:Num_vehicle
                           for j=1:Num_horizontal
                               for k=1:Num_vertical
                                        if (timev(time-1).reply(i) ~= 0 )          % ���� Ÿ�ӿ� RREP�� ���� ����̰� ������ ��尡 �ƴϸ�
                                                                                                           % ������ ��忡�� �� ������ ������ ���� ����

                                            if  ( (distance(i,p)<d1) && (line_bool(i,p) ~= 1))
                                                if ((abs(vehicle(i).Location(1)-vehicle(p).Location(1))<7) && (abs(vehicle(i).Location(1)-spot(j,k).Xpoint)<5) && (abs(vehicle(p).Location(1)-spot(j,k).Xpoint)<5)) || ((abs(vehicle(i).Location(2)-vehicle(p).Location(2))<7) && (abs(vehicle(i).Location(2)-spot(j,k).Ypoint)<5) && (abs(vehicle(p).Location(2)-spot(j,k).Ypoint)<5))
                                                    RREQ_Line_count = RREQ_Line_count+1;
                                                    RREQ(RREQ_Line_count).draw = line('XData',[vehicle(i).Location(1),vehicle(p).Location(1)],'YData',[vehicle(i).Location(2),vehicle(p).Location(2)],'LineStyle','-.','LineWidth',0.5,'Color','b');
                                                    RREQ(RREQ_Line_count).source = i;
                                                    RREQ(RREQ_Line_count).destination = p;

                                                    line_bool(i,p) = 1;
                                                    line_bool(p,i) = line_bool(i,p);  % ������ �ߺ����� �ʰ� �ϱ�����
                                                    timev(time).send(i) = timev(time-1).reply(i);  % time = 2�� RREP ������ ���� i
                                                    timev(time).reply(p) = vehicle(p).ID;     % time = 2�� RREP �޴� ���� j
                                                    info(i,p,time) = randi([1 10000]);   %seq# ���, i = send, j = reply, t = time   

                                                    if timev(time).reply(p)==destination
                                                        timev(time).flag = 1;                           % flag�� 1�̸� �������� �����ߴٴ� �ǹ�
                                                        first_rreq_seq_mode = first_rreq_seq_mode+1;    % ù��° rreq�� �������� ��
                                                        RREQ_Line_count = RREQ_Line_count+1;
                                                        RREQ(RREQ_Line_count).draw = line('XData',[vehicle(i).Location(1),vehicle(p).Location(1)],'YData',[vehicle(i).Location(2),vehicle(p).Location(2)],'LineStyle','-','LineWidth',0.5,'Color','b');
                                                        RREQ(RREQ_Line_count).source = i;
                                                        RREQ(RREQ_Line_count).destination = p;

                                                        if first_rreq_seq_mode == 1
                                                            fp = time;      % find point : destination ������ ����
                                                            dfp = time;     % ������ ��Ŷ ���� ��� ����Ϸ���
                                                            tp = time +3;   %              rreq ���� ����

                                                            hop_count = time;   % ȩī��Ʈ ���� 

                                                            data = zeros(fp);   % data packet ������ ���� �� ���� �迭

                                                        end
                                                    end
                                                    if time == tp
                                                        rreq_mode = 0; % rreq_mode ����
                                                        rrep_mode = 1; % ù��° rreq���� ���ķ� 3 hop ��ٸ� ���� rrep ��� ����
                                                    end


                                             else if ((distance(i,p)<d2) && (i~=destination)) 
                                                    RREQ_Line_count = RREQ_Line_count+1;
                                                    RREQ(RREQ_Line_count).draw = line('XData',[vehicle(i).Location(1),vehicle(p).Location(1)],'YData',[vehicle(i).Location(2),vehicle(p).Location(2)],'LineStyle','-.','LineWidth',0.5,'Color','c');
                                                    RREQ(RREQ_Line_count).source = i;
                                                    RREQ(RREQ_Line_count).destination = p;

                                                    line_bool(i,p) = 1;
                                                    line_bool(p,i) = line_bool(i,p);  % ������ �ߺ����� �ʰ� �ϱ�����
                                                    timev(time).send(i) = timev(time-1).reply(i);  % time = 2�� RREP ������ ���� i
                                                    timev(time).reply(p) = vehicle(p).ID;     % time = 2�� RREP �޴� ���� j
                                                    info(i,p,time) = randi([1 10000]);   %seq# ���, i = send, j = reply, t = time   

                                                    if timev(time).reply(p)==destination
                                                        timev(time).flag = 1;                           % flag�� 1�̸� �������� �����ߴٴ� �ǹ�
                                                        first_rreq_seq_mode = first_rreq_seq_mode+1;    % ù��° rreq�� �������� ��
                                                        RREQ_Line_count = RREQ_Line_count+1;
                                                        RREQ(RREQ_Line_count).draw = line('XData',[vehicle(i).Location(1),vehicle(p).Location(1)],'YData',[vehicle(i).Location(2),vehicle(p).Location(2)],'LineStyle','-','LineWidth',0.5,'Color','c');
                                                        RREQ(RREQ_Line_count).source = i;
                                                        RREQ(RREQ_Line_count).destination = p;

                                                        if first_rreq_seq_mode == 1
                                                            fp = time;      % find point : destination ������ ����
                                                            dfp = time;     % ������ ��Ŷ ���� ��� ����Ϸ���
                                                            tp = time +3;   %              rreq ���� ����

                                                            hop_count = time;   % ȩī��Ʈ ���� 

                                                            data = zeros(fp);   % data packet ������ ���� �� ���� �迭

                                                        end
                                                    end
                                                    if time == tp
                                                        rreq_mode = 0; % rreq_mode ����
                                                        rrep_mode = 1; % ù��° rreq���� ���ķ� 3 hop ��ٸ� ���� rrep ��� ����
                                                    end

                                                 end
                                                 end
                                            end
                                        end
                               end
                           end
                       end
                   end             
                   pause(1);
                end
            end

            %%%%%%%%%%%%%%%%%%% RREP %%%%%%%%%%%%%%%%%%%%%%%
            if rrep_mode == 1

                if time == tp

                    for i=1:RREQ_Line_count     % RREP ��� ���۵Ǹ� ������ ��ε�ĳ���� ���� �����
                        set(RREQ(i).draw,'Visible','off');
                    end

                 
                    set(handles.State_Message,'String','Route path is selected');
                    for i=1:Num_vehicle
                        if info(i,destination,fp) > max1
                            max1 = info(i,destination,fp);
                            rp1 = i;
                        end
                    end
%                     for i=1:Num_vehicle
%                         if info(i,destination,fp) > 0
%                             if (vehicle(destination).Location(1)-vehicle(i).Location(1))>=0 && (vehicle(destination).Location(2)-vehicle(i).Location(2))>0
%                                 count1 = count1 + 1;
%                                 count11 = i;
%                             elseif (vehicle(destination).Location(1)-vehicle(i).Location(1))>0 && (vehicle(destination).Location(2)-vehicle(i).Location(2))<=0
%                                 count2 = count2 + 1;
%                                 count22 = i;
%                             elseif (vehicle(destination).Location(1)-vehicle(i).Location(1))<=0 && (vehicle(destination).Location(2)-vehicle(i).Location(2))<0
%                                 count3 = count3 + 1;
%                                 count33 = i;
%                             elseif (vehicle(destination).Location(1)-vehicle(i).Location(1))<0 && (vehicle(destination).Location(2)-vehicle(i).Location(2))>=0 
%                                  count4 = count4 + 1;
%                                  count44 = i;
%                             end
%                             
%                             if count1 > max3 
%                                 
                            
                                
                               
                    data(fp) = rp1;
                    RREP_Line_count = RREP_Line_count + 1;
                    RREP(RREP_Line_count).draw = line([vehicle(destination).Location(1),vehicle(rp1).Location(1)],[vehicle(destination).Location(2),vehicle(rp1).Location(2)],'LineStyle','-','LineWidth',3.0,'Color','g');
                    RREP(RREP_Line_count).source = destination;
                    RREP(RREP_Line_count).destination = rp1;


                else
                    set(handles.State_Message,'String','RREP is transfered to Source Vehicle node');
                    fp = fp -1;
                    for i=1:Num_vehicle
                        if info(i,rp1,fp) > max2
                             max2 = info(i,rp1,fp);
                             rp2 = i;
                             if fp == 1
                                toc; %����ð� ����
                                set(handles.text131,'String',round(toc));
                                set(handles.text128,'String',hop_count);

                                RREP_Line_count = RREP_Line_count + 1; 
                                RREP(RREP_Line_count).draw = line([vehicle(rp1).Location(1),vehicle(rp2).Location(1)],[vehicle(rp1).Location(2),vehicle(rp2).Location(2)],'LineStyle','-','LineWidth',3.0,'Color','g');
                                RREP(RREP_Line_count).source = rp1;
                                RREP(RREP_Line_count).destination = rp2;

                                rrep_mode= 0;
                                data_mode = 1;
                                data_start = time+1;
                                data_end = time+dfp;
                                pause(1);
                                %break;
                             else
                                %line([vehicle(rp1).Location(1),vehicle(rp2).Location(1)],[vehicle(rp1).Location(2),vehicle(rp2).Location(2)],'LineStyle','-','LineWidth',3.0,'Color','g');
                                %pause(1);
                             end
                        end
                    end
                    data(fp) = rp2;

                    RREP_Line_count = RREP_Line_count + 1; 
                    RREP(RREP_Line_count).draw = line([vehicle(rp1).Location(1),vehicle(rp2).Location(1)],[vehicle(rp1).Location(2),vehicle(rp2).Location(2)],'LineStyle','-','LineWidth',3.0,'Color','g');
                    RREP(RREP_Line_count).source = rp1;
                    RREP(RREP_Line_count).destination = rp2;

                    max2 = 0;
                    rp1 = rp2;
                end
                pause(1);

             end               
            %%%%%%%%%%%%%

            %%%%%%%%%%%%% Data transfer %%%%%%%%%%%
            if(data_mode == 1)
                for i=0:dfp
                    if(i==0)
                        set(handles.State_Message,'String','Data packet is deliverded to Destinaion now');

                         DATA_Line_count = DATA_Line_count + 1;
                         DATA(DATA_Line_count).draw = line([vehicle(source).Location(1),vehicle(data(i+1)).Location(1)],[vehicle(source).Location(2),vehicle(data(i+1)).Location(2)],'LineStyle','-','LineWidth',3.0,'Color','r');
                         DATA(DATA_Line_count).source = source;
                         DATA(DATA_Line_count).destination = data(i+1);
                         pause(1);

                     elseif(i==dfp)
                        set(handles.State_Message,'String','Success');

                        DATA_Line_count = DATA_Line_count + 1;
                        DATA(DATA_Line_count).draw = line([vehicle(data(i)).Location(1),vehicle(destination).Location(1)],[vehicle(data(i)).Location(2),vehicle(destination).Location(2)],'LineStyle','-','LineWidth',3.0,'Color','r');
                        DATA(DATA_Line_count).source = data(i);
                        DATA(DATA_Line_count).destination = destination;
                        
                        %%%%%%%%%%%%%%%%%%% ������ %%%%%%%%%%%%%%%
                        for x=1:dfp
                            if x==1
                                texta = num2str(source);
                                set(handles.text126,'String',texta);
                            elseif x==dfp
                                plus_text = num2str(data(x));
                                final_text = num2str(destination);
                                new_text = [texta ' -> ' plus_text ' -> ' final_text];
                                set(handles.text126,'String',new_text);
                                
                            else
                                plus_text = num2str(data(x));
                                new_text = [texta ' -> ' plus_text];
                                set(handles.text126,'String',new_text);
                                texta = new_text;
                            end
                            
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                        pause(10);
                        break;

                    else
                         set(handles.State_Message,'String','Data packet is deliverded to Destinaion now');

                         DATA_Line_count = DATA_Line_count + 1;
                         DATA(DATA_Line_count).draw = line([vehicle(data(i)).Location(1),vehicle(data(i+1)).Location(1)],[vehicle(data(i)).Location(2),vehicle(data(i+1)).Location(2)],'LineStyle','-','LineWidth',3.0,'Color','r');
                         DATA(DATA_Line_count).source = data(i);
                         DATA(DATA_Line_count).destination = data(i+1);
                         pause(1);

                    end
                    %pause(1);

                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            for i=1:RREQ_Line_count     % �� ��ġ�� �°� ��ε�ĳ���� ���� ��ġ�� ���� �ٲ� // RREQ
                ss = RREQ(i).source;
                dd = RREQ(i).destination;
                set(RREQ(i).draw,'Xdata',[vehicle(ss).Location(1),vehicle(dd).Location(1)],'Ydata',[vehicle(ss).Location(2),vehicle(dd).Location(2)]);
            end

            for i=1:RREP_Line_count     % �� ��ġ�� �°� ��ε�ĳ���� ���� ��ġ�� ���� �ٲ� // RREP
                ss = RREP(i).source;
                dd = RREP(i).destination;
                set(RREP(i).draw,'Xdata',[vehicle(ss).Location(1),vehicle(dd).Location(1)],'Ydata',[vehicle(ss).Location(2),vehicle(dd).Location(2)]);
            end

            for i=1:DATA_Line_count     % �� ��ġ�� �°� ��ε�ĳ���� ���� ��ġ�� ���� �ٲ� // DATA
                ss = DATA(i).source;
                dd = DATA(i).destination;
                set(DATA(i).draw,'Xdata',[vehicle(ss).Location(1),vehicle(dd).Location(1)],'Ydata',[vehicle(ss).Location(2),vehicle(dd).Location(2)]);
            end

            pause(0.05);
    end
    msgbox('The path to the destination is not found until the given retry timer expiration','Error','error');
    for i=1:RREQ_Line_count     % RREP ��� ���۵Ǹ� ������ ��ε�ĳ���� ���� �����
            set(RREQ(i).draw,'Visible','off');
            RREQ(i).source = 0;
            RREQ(i).destination = 0;
  
    end
     RREQ_Line_count = 0;
    info = zeros(Num_vehicle,Num_vehicle,Num_vehicle);
    line_bool = zeros(Num_vehicle, Num_vehicle);
    for h=1:MAX_TIME
         for g=1:1:Num_vehicle
             timev(h).flag(g) = 0;
             timev(h).reply(g) = 0;
             timev(h).send(g) = 0;
         end
     end

    pause(2);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pr
global gt
global gr
global pt
global l
global f
global b1
global b2
global source
global destination

d1 = nthroot(pt/(pr*16*(pi^2)*f^2),b1);
d2 = nthroot(pt/(pr*16*(pi^2)*f^2),b2);

set(handles.text110,'String',d1);
set(handles.text111,'String',d2);
set(handles.text123,'String',source);
set(handles.text125,'String',destination);

global X_Size_Road
global Y_Size_Road
global Num_vertical
global Num_horizontal

global ver_interval
global hor_interval

global xrw
global yrw
global ver_centerLine
global hor_centerLine
global Num_vehicle
global Vehicle_Max_speed
global Vehicle_Min_speed
global vehicle
global MAX_TIME
global distance

timev = repmat(struct('send',1:Num_vehicle,'reply',1:Num_vehicle,'flag',0),1,Num_vehicle);
info = zeros(Num_vehicle,Num_vehicle,Num_vehicle);
line_bool = zeros(Num_vehicle, Num_vehicle);
xx = 1;

for i=1:Num_vehicle  
    for j=1:1:Num_vehicle
        timev(i).send(j) = 0;
        timev(i).send(j) = 0;
    end
end








function source_Callback(hObject, eventdata, handles)
% hObject    handle to source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of source as text
%        str2double(get(hObject,'String')) returns contents of source as a double

global source
source = get(handles.source,'String');
source = str2double(source);


% --- Executes during object creation, after setting all properties.
function source_CreateFcn(hObject, eventdata, handles)
% hObject    handle to source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function destination_Callback(hObject, eventdata, handles)
% hObject    handle to destination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of destination as text
%        str2double(get(hObject,'String')) returns contents of destination as a double

global destination
destination = get(handles.destination,'String');
destination = str2double(destination);


% --- Executes during object creation, after setting all properties.
function destination_CreateFcn(hObject, eventdata, handles)
% hObject    handle to destination (see GCBO)



% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit36_Callback(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit36 as text
%        str2double(get(hObject,'String')) returns contents of edit36 as a double
global htd
htd = get(handles.edit36,'String');
htd = str2double(htd);

% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit37_Callback(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit37 as text
%        str2double(get(hObject,'String')) returns contents of edit37 as a double
global rt
rt = get(handles.edit37,'String');
rt = str2double(rt);

% --- Executes during object creation, after setting all properties.
function edit37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double
global pr
pr = get(handles.edit28,'String');
pr = str2double(pr);

% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double
global gt
gt = get(handles.edit29,'String');
gt = str2double(gt);

% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit30 as text
%        str2double(get(hObject,'String')) returns contents of edit30 as a double
global gr
gr = get(handles.edit30,'String');
gr = str2double(gr);

% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit31 as text
%        str2double(get(hObject,'String')) returns contents of edit31 as a double
global pt
pt = get(handles.edit31,'String');
pt = str2double(pt);

% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double
global l
l = get(handles.edit32,'String');
l = str2double(l);

% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double
global f
f = get(handles.edit33,'String');
f = str2double(f);

% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit34 as text
%        str2double(get(hObject,'String')) returns contents of edit34 as a double
global b1
b1 = get(handles.edit34,'String');
b1 = str2double(b1);

% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit35_Callback(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit35 as text
%        str2double(get(hObject,'String')) returns contents of edit35 as a double

global b2
b2 = get(handles.edit35,'String');
b2 = str2double(b2);

% --- Executes during object creation, after setting all properties.
function edit35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit38 as text
%        str2double(get(hObject,'String')) returns contents of edit38 as a double
global nr
nr = get(handles.edit38,'String');
nr = str2double(nr);


% --- Executes during object creation, after setting all properties.
function edit38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
