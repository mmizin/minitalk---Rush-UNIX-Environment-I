/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: imelnych <imelnych@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/05/19 12:28:15 by imelnych          #+#    #+#             */
/*   Updated: 2018/05/19 14:34:39 by imelnych         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/minitalk.h"

static void		f_output(int i)
{
	static unsigned char	sig;
	static	int				count;
	int						tmp;

	tmp = 0;
	i == SIGUSR1 ? tmp = 1 : 0;
	sig = sig + (tmp << count);
	count++;
	if (count > 7)
	{
		write(1, &sig, 1);
		sig == 0 ? write(1, "\n", 1) : 0;
		sig = 0;
		count = 0;
	}
}

int				main(int argc, char **argv)
{
	t_var	t;

	(void)argv;
	if (argc != 1)
	{
		ft_printf("Too few arguments to call."
			"Just execute the binary 😤🤬 🤯\n");
	}
	t.pid = getpid();
	ft_printf("PID : %d\n", t.pid);
	usleep(300);
	signal(SIGUSR1, f_output);
	signal(SIGUSR2, f_output);
	while (1)
	{
		pause();
	}
	return (0);
}
