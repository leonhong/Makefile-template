######################################################################
#	makefile ģ�� (by lichuang)
#
######################################################################

###################��Ŀ·���ͳ�������#################################
DIR=$(shell pwd)
BIN_DIR=$(DIR)/bin
LIB_DIR=$(DIR)/lib
SRC_DIR=$(DIR)/src
INCLUDE_DIR=$(DIR)/include
OBJ_DIR=$(DIR)/obj
DEPS_DIR=$(DIR)/deps
#PROGRAM=$(BIN_DIR)/test
PROGRAM=$(BIN_DIR)/test

###################OBJ�ļ���·��############################################
EXTENSION=c
OBJS=$(patsubst $(SRC_DIR)/%.$(EXTENSION), $(OBJ_DIR)/%.o,$(wildcard $(SRC_DIR)/*.$(EXTENSION)))
DEPS=$(patsubst $(OBJ_DIR)/%.o, $(DEPS_DIR)/%.d, $(OBJS))

###################includeͷ�ļ�·��##################################
INCLUDE=\
		-I$(INCLUDE_DIR)
		
###################lib�ļ���·��######################################

###################����ѡ�������###################################
CC=gcc
CFLAGS=-Wall -W -g 
LDFLAGS=

###################����Ŀ��###########################################
.PHONY: all clean rebuild

all:$(OBJS) 
	@echo $(DEPS_DIR)
	$(CC) -o $(PROGRAM) $(OBJS) $(LDFLAGS) 


$(DEPS_DIR)/%.d: $(SRC_DIR)/%.$(EXTENSION)
	$(CC) -MM $(INCLUDE) $(CFLAGS) $< | sed -e 1's,^,$(OBJ_DIR)/,' > $@

sinclude $(DEPS)

$(OBJ_DIR)/%.o:$(SRC_DIR)/%.$(EXTENSION) 
	$(CC) $< -o $@ -c $(CFLAGS) $(INCLUDE) 

rebuild: clean all

clean:
	rm -rf $(OBJS) $(LIB_DIR)/lib* $(BIN_DIR)/* 

