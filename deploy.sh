docker build -t ravilkhalilov/multi-client-k8s:latest -t ravilkhalilov/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t ravilkhalilov/multi-server-k8s-pgfix:latest -t ravilkhalilov/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t ravilkhalilov/multi-worker-k8s:latest -t ravilkhalilov/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push ravilkhalilov/multi-client-k8s:latest
docker push ravilkhalilov/multi-server-k8s-pgfix:latest
docker push ravilkhalilov/multi-worker-k8s:latest

docker push ravilkhalilov/multi-client-k8s:$SHA
docker push ravilkhalilov/multi-server-k8s-pgfix:$SHA
docker push ravilkhalilov/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ravilkhalilov/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=ravilkhalilov/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=ravilkhalilov/multi-worker-k8s:$SHA