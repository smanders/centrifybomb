docker image build --network=host --build-arg USERID=$(id -u ${USER}) --build-arg USERNAME=${USER} --tag cbomb .
