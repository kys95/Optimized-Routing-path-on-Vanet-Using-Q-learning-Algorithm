  function varargout = minjeong(varargin)
% MINJEONG MATLAB code for minjeong.fig
%      MINJEONG, by itself, creates a new MINJEONG or raises the existing
%      singleton*.
%
%      H = MINJEONG returns the handle to a new MINJEONG or the handle to
%      the existing singleton*.
%
%      MINJEONG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MINJEONG.M with the given input arguments.
% 
%      MINJEONG('Property','Value',...) creates a new MINJEONG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before minjeong_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to minjeong_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help minjeong

% Last Modified by GUIDE v2.5 18-Nov-2015 13:53:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @minjeong_OpeningFcn, ...
                   'gui_OutputFcn',  @minjeong_OutputFcn, ...
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


% --- Executes just before minjeong is made visible.
function minjeong_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to minjeong (see VARARGIN)

% Choose default command line output for minjeong
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes minjeong wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = minjeong_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Map x,y size %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Size_X_Callback(hObject, eventdata, handles)
% hObject    handle to Size_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Size_X as text
%        str2double(get(hObject,'String')) returns contents of Size_X as a double

global X_Size_Road
X_Size_Road = get(handles.Size_X,'String');
X_Size_Road = str2double(X_Size_Road);


% --- Executes during object creation, after setting all properties.
function Size_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Size_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Size_Y_Callback(hObject, eventdata, handles)
% hObject    handle to Size_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Size_Y as text
%        str2double(get(hObject,'String')) returns contents of Size_Y as a double

global Y_Size_Road
Y_Size_Road = get(handles.Size_Y,'String');
Y_Size_Road = str2double(Y_Size_Road);

% --- Executes during object creation, after setting all properties.
function Size_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Size_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Main street, Number of Vertical, Horizontal road %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 function num_ver_Callback(hObject, eventdata, handles)
% hObject    handle to num_ver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_ver as text
%        str2double(get(hObject,'String')) returns contents of num_ver as a double

global X_Size_Road
global Num_vertical
global ver_interval
global ver_lane

Num_vertical = get(handles.num_ver,'String');
Num_vertical = str2double(Num_vertical);

ver_interval = X_Size_Road / ( Num_vertical -1 );
ver_lane = ver_interval / (2*7);


% --- Executes during object creation, after setting all properties.
function num_ver_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_ver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function num_hor_Callback(hObject, eventdata, handles)
% hObject    handle to num_hor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_hor as text
%        str2double(get(hObject,'String')) returns contents of num_hor as a double

global Y_Size_Road
global Num_horizontal
global hor_interval
global ver_lane
global hor_lane

Num_horizontal = get(handles.num_hor,'String');
Num_horizontal = str2double(Num_horizontal);

%%%%%%%%%%%%%%%%%%%%%%% 차선 범위 결정 %%%%%%%%%%%%%%%%%%%%%%%%%%%

hor_interval = Y_Size_Road / ( Num_horizontal -1 );
hor_lane = hor_interval / (2*7);

if(ver_lane > hor_lane)
    ver_lane = fix(ver_lane);
    if(ver_lane > 14)
        set(handles.to,'String',14);
    elseif(mod(ver_lane,2) == 1)
        set(handles.to,'String',ver_lane - 1);
    else
        set(handles.to,'String',ver_lane);
    end
else
    hor_lane = fix(hor_lane);
    if(hor_lane > 14)
        set(handles.to,'String',14);
    elseif(mod(hor_lane,2) == 1)
        set(handles.to,'String',hor_lane - 1);
    else
        set(handles.to,'String',hor_lane);
    end
end


% --- Executes during object creation, after setting all properties.
function num_hor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_hor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lane_range_to_Callback(hObject, eventdata, handles)
% hObject    handle to lane_range_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lane_range_to as text
%        str2double(get(hObject,'String')) returns contents of lane_range_to as a double

global lane_to

lane_to = get(handles.lane_range_to,'String');
lane_to = str2double(lane_to);


% --- Executes during object creation, after setting all properties.
function lane_range_to_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lane_range_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cell_partition_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to cell_partition_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell_partition_ratio as text
%        str2double(get(hObject,'String')) returns contents of cell_partition_ratio as a double

global cell_part_ratio

cell_part_ratio = get(handles.cell_partition_ratio,'String');
cell_part_ratio = str2double(cell_part_ratio);


% --- Executes during object creation, after setting all properties.
function cell_partition_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell_partition_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sub_vertical_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to sub_vertical_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sub_vertical_ratio as text
%        str2double(get(hObject,'String')) returns contents of sub_vertical_ratio as a double

global sub_ver_ratio

sub_ver_ratio = get(handles.sub_vertical_ratio,'String');
sub_ver_ratio = str2double(sub_ver_ratio);


% --- Executes during object creation, after setting all properties.
function sub_vertical_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sub_vertical_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sub_horizontal_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to sub_horizontal_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sub_horizontal_ratio as text
%        str2double(get(hObject,'String')) returns contents of sub_horizontal_ratio as a double

global sub_hor_ratio

sub_hor_ratio = get(handles.sub_horizontal_ratio,'String');
sub_hor_ratio = str2double(sub_hor_ratio);


% --- Executes during object creation, after setting all properties.
function sub_horizontal_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sub_horizontal_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sub_both_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to sub_both_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sub_both_ratio as text
%        str2double(get(hObject,'String')) returns contents of sub_both_ratio as a double

global sub_bo_ratio

sub_bo_ratio = get(handles.sub_both_ratio,'String');
sub_bo_ratio = str2double(sub_bo_ratio);


% --- Executes during object creation, after setting all properties.
function sub_both_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sub_both_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in create.
function create_Callback(hObject, eventdata, handles)
% hObject    handle to create (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

run road

function Num_vehicle_Callback(hObject, eventdata, handles)
% hObject    handle to Num_vehicle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Num_vehicle as text
%        str2double(get(hObject,'String')) returns contents of Num_vehicle as a double

global Num_vehicle
Num_vehicle = get(handles.Num_vehicle,'String');
Num_vehicle = str2double(Num_vehicle);


% --- Executes during object creation, after setting all properties.
function Num_vehicle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Num_vehicle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vehicle_Max_speed_Callback(hObject, eventdata, handles)

global Vehicle_Max_speed
Vehicle_Max_speed = get(handles.vehicle_Max_speed,'String');
Vehicle_Max_speed = str2double(Vehicle_Max_speed);


% --- Executes during object creation, after setting all properties.
function vehicle_Max_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vehicle_Max_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vehicle_Min_speed_Callback(hObject, eventdata, handles)

global Vehicle_Min_speed
Vehicle_Min_speed = get(handles.Vehicle_Min_speed,'String');
Vehicle_Min_speed = str2double(Vehicle_Min_speed);

% --- Executes during object creation, after setting all properties.
function Vehicle_Min_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vehicle_Min_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%Car Topology%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in car_create.
function car_create_Callback(hObject, eventdata, handles)
run vehicle        

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
