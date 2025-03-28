// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract VotingSystem {
    struct Voter{
        bool hasVoted;
        uint256 vote;
    }

    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    mapping(address => Voter) public voters;
    mapping(uint256=>Candidate) public candidates;
    uint256 public candidatesCount;

    event VoteCasted(address voter, uint256 candidateId);

    function addCandidate(string memory _name) public{
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0); // 후보자 등록
    }

    function vote(uint256 _candidateId )public{
        require(!voters[msg.sender].hasVoted, "You have already voted");
        require(_candidateId > 0 && _candidateId <=candidatesCount, "Invalid candidate");

        voters[msg.sender] = Voter(true, _candidateId);
        candidates[_candidateId].voteCount++;

        emit VoteCasted(msg.sender, _candidateId);
    }

    function hasvoted(address _voter) public view returns (bool) {
        return voters[_voter].hasVoted;
    }

    event EtherReceived(address sender, uint256 amount);
    event FallbackCalled(address sender, uint256 amount, bytes data);

    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }

    address public owner;

    error NotOwner(address caller);

    constructor(){
        owner = msg.sender;
    }

    function OwnerOnlyAction() public view {
        if(msg.sender != owner) {
            revert NotOwner(msg.sender);
        }
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
