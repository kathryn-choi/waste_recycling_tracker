#!/bin/bash

composer card delete -c admin@recycling_tracker
composer card delete -c PeerAdmin@hlfv1
cd fabric-dev-servers

sudo ./downloadFabric.sh
sudo ./startFabric.sh
./createPeerAdminCard.sh
cd ..

cd recycling_tracker

composer network install --card PeerAdmin@hlfv1 --archiveFile recycling_tracker@0.2.7.bna

composer network start --networkName recycling_tracker --networkVersion 0.2.7 --networkAdmin admin --networkAdminEnrollSecret adminpw --card PeerAdmin@hlfv1 --file networkadmin.card



composer card import --file networkadmin.card

composer network ping --card admin@recycling_tracker

cd ..

composer-rest-server -c admin@recycling_tracker -n never -u true -w true


#composer archive create -t dir -n .
#admin@recycling_tracker