#This configuration item index document lists the configuration items for the following baseline:
#
#ProjectName:       Pythonic
#Description:       Pythonic (GUI) + PythonicDaemon (Backend)
#
#                   General purpose graphic programming tool.
#                   Graphical Python programming from within the browser,
#                   Python based backend running as container. 
#                   Full multi-processing and multi-threading capable.
#
#
#CreationDate:      24.12.2020
#Creator:           Stephan Avenwedde
#
#
#
#Type  CIName                           Version            License                 
#      Pythonic
#          INCLUDED PACKAGES
#           IMG     Fedora              33                 GPL                           
#           BIN     Supervisor          3.2.0              Custom license          
#           BIN     ms-python           2020.10.332292344
#
#Type    CIName                      Name               Version                   Commentary            
#
#TC      Container Image creation    Podman             2.2.1                              
#TC      1. Test System (Linux)      Podman             2.2.1                                   
#
#
###################################################################################
#    Type:                                                                        #
#       DOC     Document                                                          #
#       SC      Source Code                                                       #
#       BIN     Binary Code                                                       #
#       LIB     Library                                                           #
#       TC      Tool Chain (development/test)                                     #
###################################################################################
#
#
#
#
#
#
###################################################################################
#                                                                                 #
#                            BEGIN OF THE  DOCKERFILE                             #
#                                                                                 #
###################################################################################

FROM fedora:31
ENV TERM=dumb

RUN dnf -y install pip 
###################################
#                                 #
#           Supervisor            #
#                                 #
###################################


RUN /usr/bin/python3 -m pip install supervisor==4.2.1


	
###################################
#                                 #
#           Code-Server           #
#                                 #
###################################

COPY src/code-server/code-server-3.8.0-amd64.rpm /
COPY src/code-server/ms-python-release.vsix /
COPY src/code-server/ms-python.vscode-pylance-2020.12.2.vsix /


RUN rpm -i /code-server-3.8.0-amd64.rpm
RUN code-server --install-extension /ms-python-release.vsix
RUN code-server --install-extension /ms-python.vscode-pylance-2020.12.2.vsix 

RUN rm /code-server-3.8.0-amd64.rpm
RUN rm /ms-python-release.vsix
RUN rm /ms-python.vscode-pylance-2020.12.2.vsix

# TODO https://github.com/cdr/code-server/issues/2341
# Hier 2020.10 installieren
# code-server --install-extension ms-toolsai.jupyter-2020.12.414227025.vsix || true \
#VOLUME /var/log /home/weidmueller


###################################
#                                 #
#            Pythonic             #
#                                 #
###################################

RUN /usr/bin/python3 -m pip install eventlet==0.30.0
RUN /usr/bin/python3 -m pip install PySide2==5.12.2

COPY dist/Pythonic-1.0.tar.gz /

RUN /usr/bin/python3 -m pip install /Pythonic-1.0.tar.gz
#RUN mkdir /root/public_html
#RUN mkdir /root/public_html/config
#RUN mkdir /root/public_html/static
#RUN mkdir /root/public_html/templates
#RUN mkdir /root/public_html/config/Toolbox
#RUN mkdir /root/executables

#COPY PythonicWeb/public_html/static/BaseElement.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/del.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/horizontal.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/kill.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/new_file.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/open_file.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/PlayDefault.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/PlayGreen.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/PlayYellow.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/PlugSocket.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/PlugSocketGreen.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/PlugSocketOrange.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/run.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/save.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/save_as.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/Scheduler.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/start_debug.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/stop_exec.png /root/public_html/static/
#COPY PythonicWeb/public_html/static/StopYellow.png /root/public_html/static/

#COPY PythonicWeb/PythonicWeb.js /root/public_html/static/
#COPY PythonicWeb/PythonicWeb.wasm /root/public_html/static/
#COPY PythonicWeb/qtloader.js /root/public_html/static/
#COPY PythonicWeb/qtlogo.svg /root/public_html/static/

#COPY PythonicWeb/PythonicWeb.html /root/public_html/templates/



#COPY PythonicWeb/configio.py /root/
#COPY PythonicWeb/element_types.py /root/
#COPY PythonicWeb/execution_operator.py /root/
#COPY PythonicWeb/screen.py /root/
#COPY PythonicWeb/stdin_reader.py /root/
#COPY PythonicWeb/web_daemon.py /root/
#COPY PythonicWeb/main.py /root/




####################
# Install Elements #
####################

### Basic Elements

#RUN mkdir /root/public_html/config/Toolbox/Basic

# GenericPython
#COPY PythonicWeb/public_html/config/Toolbox/Basic/GenericPython.json /root/public_html/config/Toolbox/Basic/
#COPY PythonicWeb/public_html/config/Toolbox/Basic/GenericPython.editor /root/public_html/config/Toolbox/Basic/
#COPY PythonicWeb/executables/generic_python.py /root/executables/
# Scheduler
#COPY PythonicWeb/public_html/config/Toolbox/Basic/Scheduler.json /root/public_html/config/Toolbox/Basic/
#COPY PythonicWeb/public_html/config/Toolbox/Basic/Scheduler.editor /root/public_html/config/Toolbox/Basic/
#COPY PythonicWeb/executables/scheduler.py /root/executables/


### Connectivity Elements

#RUN mkdir /root/public_html/config/Toolbox/Connectivity

# E-Mail
#COPY PythonicWeb/public_html/config/Toolbox/Connectivity/email.json /root/public_html/config/Toolbox/Connectivity/

###################################
#                                 #
#      Configuration Files        #
#                                 #
###################################

COPY src/code-server/config.yaml /root/.config/code-server/
COPY src/supervisor/supervisord.conf /etc/


ENTRYPOINT ["/usr/local/bin/supervisord"]
WORKDIR /root
