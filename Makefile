all:
	mkdir -p /home/caymard/data/wordpress
	mkdir -p /home/caymard/data/mariadb

	docker compose -f ./srcs/docker-compose.yml build --no-cache
	docker compose -f ./srcs/docker-compose.yml up -d

clean:
	docker compose -f srcs/docker-compose.yml down

fclean: clean
	docker builder prune -a
	docker system prune --volumes --force
	rm -rf /home/caymard/data

re: fclean all

.PHONY: all clean fclean re
