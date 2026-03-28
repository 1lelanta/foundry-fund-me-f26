// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "../../src/interfaces/AggregatorV3Interface.sol";

contract MockV3Aggregator is AggregatorV3Interface {
	uint8 public override decimals;
	string public override description;
	uint256 public override version;

	int256 public latestAnswer;
	uint80 public latestRound;
	mapping(uint80 => int256) public answers;
	mapping(uint80 => uint256) public timestamps;
	mapping(uint80 => uint256) public startedAts;

	constructor(uint8 _decimals, int256 _initialAnswer) {
		decimals = _decimals;
		description = "MockV3Aggregator";
		version = 0;
		_updateAnswer(_initialAnswer);
	}

	function updateAnswer(int256 _answer) external {
		_updateAnswer(_answer);
	}

	function _updateAnswer(int256 _answer) internal {
		latestRound++;
		latestAnswer = _answer;

		answers[latestRound] = _answer;
		timestamps[latestRound] = block.timestamp;
		startedAts[latestRound] = block.timestamp;
	}

	function getRoundData(
		uint80 _roundId
	)
		external
		view
		override
		returns (
			uint80 roundId,
			int256 answer,
			uint256 startedAt,
			uint256 updatedAt,
			uint80 answeredInRound
		)
	{
		return (
			_roundId,
			answers[_roundId],
			startedAts[_roundId],
			timestamps[_roundId],
			_roundId
		);
	}

	function latestRoundData()
		external
		view
		override
		returns (
			uint80 roundId,
			int256 answer,
			uint256 startedAt,
			uint256 updatedAt,
			uint80 answeredInRound
		)
	{
		return (
			latestRound,
			answers[latestRound],
			startedAts[latestRound],
			timestamps[latestRound],
			latestRound
		);
	}
}
