function varargout = F_123190077_ResponsiSCPK(varargin)
% F_123190077_RESPONSISCPK MATLAB code for F_123190077_ResponsiSCPK.fig
%      F_123190077_RESPONSISCPK, by itself, creates a new F_123190077_RESPONSISCPK or raises the existing
%      singleton*.
%
%      H = F_123190077_RESPONSISCPK returns the handle to a new F_123190077_RESPONSISCPK or the handle to
%      the existing singleton*.
%
%      F_123190077_RESPONSISCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in F_123190077_RESPONSISCPK.M with the given input arguments.
%
%      F_123190077_RESPONSISCPK('Property','Value',...) creates a new F_123190077_RESPONSISCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before F_123190077_ResponsiSCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to F_123190077_ResponsiSCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help F_123190077_ResponsiSCPK

% Last Modified by GUIDE v2.5 25-Jun-2021 23:27:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @F_123190077_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @F_123190077_ResponsiSCPK_OutputFcn, ...
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


% --- Executes just before F_123190077_ResponsiSCPK is made visible.
function F_123190077_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to F_123190077_ResponsiSCPK (see VARARGIN)

% Choose default command line output for F_123190077_ResponsiSCPK
handles.output = hObject;
opts = detectImportOptions('DATARUMAH.xlsx');
opts.SelectedVariableNames = [3,4,5,6,7,8];
data = readmatrix('DATARUMAH.xlsx',opts);
set(handles.tbl_rumah,'data',data);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes F_123190077_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = F_123190077_ResponsiSCPK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_proses.
function btn_proses_Callback(hObject, eventdata, handles)
% hObject    handle to btn_proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Menentukan Nilai Bobot pada Kriteria
w = [0.3, 0.2, 0.23, 0.1, 0.07, 0.1];
k = [0,1,1,1,1,1];
raw = xlsread('DATARUMAH.xlsx','C2:H21');

[m,n]=size (raw); 
R=zeros (m,n); 

for j=1:n
    if k(j)==1
        R(:,j)=raw(:,j)./max(raw(:,j));
    else
        R(:,j)=min(raw(:,j))./raw(:,j);
    end
end

for i=1:m
    V(i)= sum(w.*R(i,:));
end

rank = sort(V,'descend');

for i=1:20
    hasil(i) = rank(i);
end

%mendeteksi dataset DATARUMAH
opts2 = detectImportOptions('DATARUMAH.xlsx'); 
%Memilih kolom nama rumah
opts2.SelectedVariableNames = [2]; 
nama = readmatrix('DATARUMAH.xlsx',opts2);
rumah = nama(1:20);

for i=1:20
 for j=1:m
   if(hasil(i) == V(j))
    sorting(i) = rumah(j);
    break
   end
 end
end

sorting = sorting';

set(handles.tbl_rekomen, 'data', sorting);
