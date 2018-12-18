

    docker build -t localhost:5000/tf-bfarm .
    docker push localhost:5000/tf-bfarm
    docker stack deploy -c docker-compose_bbf.yml bbf

    bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package --spawn_strategy=remote --genrule_strategy=remote --strategy=Javac=remote --strategy=Closure=remote --remote_executor=localhost:8980 --jobs=16
