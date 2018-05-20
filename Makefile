# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: imelnych <imelnych@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/02/07 21:48:14 by vgladush          #+#    #+#              #
#    Updated: 2018/05/19 14:34:03 by imelnych         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SERVER	=	server
CLIENT	=	client

GC_FLGS	=	gcc -Wall -Wextra -Werror

SRC_SER	=	./srcs_server/
SRC_CLN	=	./srcs_client/
INC_DIR	=	./includes/ $(LB_PATH)/includes/
OBJ_SRV	=	./obj_server/
OBJ_CLN	=	./obj_client/
LB_PATH	=	./libft/
LB_LINK	=	-L ./libft -lft

SR_SRCS	=	server.c

CL_SRCS	=	client.c

SR_OBJS	=	$(SR_SRCS:.c=.o)
CL_OBJS	=	$(CL_SRCS:.c=.o)

OBJS_SR	=	$(addprefix $(OBJ_SRV), $(SR_OBJS))
OBJS_CL	=	$(addprefix $(OBJ_CLN), $(CL_OBJS))
INC 	=	$(addprefix -I, $(INC_DIR))

RED		=	'\x1B[0;31m'
GRN		=	'\x1B[0;32m'
LRD		=	'\x1B[1;31m'

all: create $(SERVER) $(CLIENT)

create:
	@make -C $(LB_PATH)
	@mkdir -p $(OBJ_SRV)
	@mkdir -p $(OBJ_CLN)

$(SERVER): $(OBJS_SR)
	@gcc -o $(SERVER) $(OBJS_SR) $(LB_LINK)
	@echo $(GRN)$(SERVER) "ready"

$(CLIENT): $(OBJS_CL)
	@gcc -o $(CLIENT) $(OBJS_CL) $(LB_LINK)
	@echo $(GRN)$(CLIENT) "ready"

$(OBJ_SRV)%.o: $(SRC_SER)%.c
	@$(GC_FLGS) $(INC) -o $@ -c $<

$(OBJ_CLN)%.o: $(SRC_CLN)%.c
	@$(GC_FLGS) $(INC) -o $@ -c $<

clean:
	@make -C $(LB_PATH) clean
	@rm -rf $(OBJ_SRV)
	@rm -rf $(OBJ_CLN)
	@echo $(LRD)"objects" $(SERVER) "&" $(CLIENT) "deleted"

fclean:
	@make -C $(LB_PATH) fclean
	@rm -rf $(OBJ_SRV)
	@rm -rf $(OBJ_CLN)
	@echo $(LRD)"objects" $(SERVER) "&" $(CLIENT) "deleted"
	@rm -f $(SERVER)
	@rm -f $(CLIENT)
	@echo $(RED)$(SERVER) "&" $(CLIENT) "deleted"

re: fclean all
