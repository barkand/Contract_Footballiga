# Contract_Footballiga:

npm i -g truffle
truffle init

npm i @openzeppelin/contracts

ganache -a 3

truffle create contract contractName
truffle create migration contractName
truffle create test contractName

truffle test
truffle compile

truffle deploy --> or migrate
truffle migrate
truffle migrate --reset --> if Networks is empty

truffle networks \*
