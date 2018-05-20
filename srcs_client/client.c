/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: imelnych <imelnych@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/05/19 14:33:30 by imelnych          #+#    #+#             */
/*   Updated: 2018/05/19 14:33:44 by imelnych         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/minitalk.h"

static int			f_print_next_line(int pid)
{
	int i;

	i = 0;
	while (i < 8)
	{
		usleep(200);
		kill(pid, SIGUSR2);
		i++;
	}
	return (1);
}

static int			f_send_signal(char **ar, int pid)
{
	unsigned char	sig;
	int				i;

	i = 0;
	while (ar[2][i])
	{
		sig = 0;
		while (sig < 8)
		{
			usleep(200);
			if (((ar[2][i] >> sig) & 1) == 1)
				kill(pid, SIGUSR1);
			else
				kill(pid, SIGUSR2);
			sig++;
		}
		i++;
	}
	f_print_next_line(pid);
	return (1);
}

int					main(int argc, char **argv)
{
	t_var	t;

	if (argc == 3)
	{
		t.chk_pid = ft_atoi(argv[1]);
		f_send_signal(argv, t.chk_pid);
	}
	else
		ft_putstr("Usage: [server PID] [string]\n");
	return (0);
}
