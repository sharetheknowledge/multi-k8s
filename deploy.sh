docker build -t danieldockerid2021/multi-client:latest -t danieldockerid2021/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danieldockerid2021/multi-server:latest -t danieldockerid2021/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t danieldockerid2021/multi-worker:latest -t danieldockerid2021/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push danieldockerid2021/multi-client:latest
docker push danieldockerid2021/multi-server:latest
docker push danieldockerid2021/multi-worker:latest

docker push danieldockerid2021/multi-client:$SHA
docker push danieldockerid2021/multi-server:$SHA
docker push danieldockerid2021/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=danieldockerid2021/multi-server:$SHA
kubectl set image deployments/client-deployment client=danieldockerid2021/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=danieldockerid2021/multi-worker:$SHA
