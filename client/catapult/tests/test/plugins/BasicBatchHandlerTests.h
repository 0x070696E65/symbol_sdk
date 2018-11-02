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

#pragma once
#include "tests/test/core/PacketPayloadTestUtils.h"
#include "tests/test/core/PacketTestUtils.h"
#include "tests/TestHarness.h"

namespace catapult { namespace test {

	/// Traits for a handler that accepts a function.
	template<typename TTraits>
	struct FunctionalHandlerTraits {
		struct HandlerContext {
		public:
			HandlerContext() : m_counter(0)
			{}

		public:
			void incrementCounter() {
				++m_counter;
			}

		public:
			void assertRejected() const {
				// Assert: when rejected, function should not be called
				EXPECT_EQ(0u, m_counter);
			}

			void assertAccepted() const {
				// Assert: when accepted, function should be called once
				EXPECT_EQ(1u, m_counter);
			}

		private:
			size_t m_counter;
		};

		static void RegisterHandler(ionet::ServerPacketHandlers& handlers, HandlerContext& context) {
			TTraits::RegisterHandler(handlers, [&context](const auto&) {
				context.incrementCounter();
				return typename TTraits::ResponseType();
			});
		}
	};

	/// A container of basic batch handler tests.
	template<typename TTraits, typename THandlerTraits = FunctionalHandlerTraits<TTraits>>
	struct BasicBatchHandlerTests {
	public:
		/// Asserts that a packet with a reported size less than a packet header is rejected.
		static void AssertTooSmallPacketIsRejected() {
			// Arrange:
			ionet::Packet packet;
			packet.Size = sizeof(ionet::PacketHeader) - 1;
			packet.Type = TTraits::Packet_Type;

			// Assert:
			AssertPacketIsRejected(packet);
		}

		/// Asserts that a packet with the wrong type is rejected.
		static void AssertPacketWithWrongTypeIsRejected() {
			// Assert: wrong packet type
			AssertPacketIsRejected(TTraits::Valid_Request_Payload_Size, ionet::PacketType::Chain_Info, false);
		}

		/// Asserts that a packet with an invalid payload size is rejected.
		static void AssertPacketWithInvalidPayloadIsRejected() {
			// Assert: payload size is not divisible by TTraits::ValidPayloadSize
			AssertPacketIsRejected(TTraits::Valid_Request_Payload_Size + TTraits::Valid_Request_Payload_Size / 2, TTraits::Packet_Type);
		}

		/// Asserts that a packet with a too small payload size is rejected.
		static void AssertPacketWithTooSmallPayloadIsRejected() {
			// Assert: payload size is too small
			AssertPacketIsRejected(TTraits::Valid_Request_Payload_Size / 2, TTraits::Packet_Type);
		}

		/// Asserts that a packet with no payload is rejected.
		static void AssertPacketWithNoPayloadIsRejected() {
			// Assert: no payload
			AssertPacketIsRejected(0, TTraits::Packet_Type);
		}

	private:
		static void AssertPacketIsRejected(const ionet::Packet& packet, bool expectedCanProcessPacketType = true) {
			// Arrange:
			ionet::ServerPacketHandlers handlers;
			typename THandlerTraits::HandlerContext handlerContext;
			THandlerTraits::RegisterHandler(handlers, handlerContext);

			// Act:
			ionet::ServerPacketHandlerContext context({}, "");
			EXPECT_EQ(expectedCanProcessPacketType, handlers.process(packet, context));

			// Assert:
			handlerContext.assertRejected();
			test::AssertNoResponse(context);
		}

	protected:
		static void AssertPacketIsRejected(uint32_t payloadSize, ionet::PacketType type, bool expectedCanProcessPacketType = true) {
			// Arrange:
			auto pPacket = test::CreateRandomPacket(payloadSize, type);

			// Assert:
			AssertPacketIsRejected(*pPacket, expectedCanProcessPacketType);
		}

		static void AssertValidPacketWithElementsIsAccepted(uint32_t numElements) {
			// Arrange:
			ionet::ServerPacketHandlers handlers;
			typename THandlerTraits::HandlerContext handlerContext;
			THandlerTraits::RegisterHandler(handlers, handlerContext);

			auto pPacket = test::CreateRandomPacket(numElements * TTraits::Valid_Request_Payload_Size, TTraits::Packet_Type);

			// Act:
			ionet::ServerPacketHandlerContext context({}, "");
			EXPECT_TRUE(handlers.process(*pPacket, context));

			// Assert:
			handlerContext.assertAccepted();
			ASSERT_TRUE(context.hasResponse());
			test::AssertPacketHeader(context, sizeof(ionet::PacketHeader), TTraits::Packet_Type);
			EXPECT_TRUE(context.response().buffers().empty());
		}
	};
}}