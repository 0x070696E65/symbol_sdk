/**
*** Copyright (c) 2016-present,
*** Jaguar0625, gimre, BloodyRookie, Tech Bureau, Corp. All rights reserved.
***
*** This file is part of Catapult.
***
*** Catapult is free software: you can redistribute it and/or modify
*** it under the terms of the GNU Lesser General Public License as published by
*** the Free Software Foundation, either version 3 of the License, or
*** (at your option) any later version.
***
*** Catapult is distributed in the hope that it will be useful,
*** but WITHOUT ANY WARRANTY; without even the implied warranty of
*** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*** GNU Lesser General Public License for more details.
***
*** You should have received a copy of the GNU Lesser General Public License
*** along with Catapult. If not, see <http://www.gnu.org/licenses/>.
**/

#include "Validators.h"
#include "catapult/cache_core/AccountStateCache.h"

namespace catapult { namespace validators {

	using Notification = model::ImportanceBlockNotification;

	namespace {
		bool AreEqual(const Notification& notification, const cache::HighValueAccountStatistics& statistics) {
			return notification.VotingEligibleAccountsCount == statistics.VotingEligibleAccountsCount
					&& notification.HarvestingEligibleAccountsCount == statistics.HarvestingEligibleAccountsCount
					&& notification.TotalVotingBalance == statistics.TotalVotingBalance;
		}
	}

	DEFINE_STATEFUL_VALIDATOR(ImportanceBlock, [](const Notification& notification, const ValidatorContext& context) {
		// ImportanceBlockNotification is raised after BlockNotification, so this validator is checking the state
		// *after* the processing of the current block and all transactions
		auto statistics = context.Cache.sub<cache::AccountStateCache>().highValueAccountStatistics();
		return AreEqual(notification, statistics) ? ValidationResult::Success : Failure_Core_Importance_Block_Mismatch;
	})
}}
