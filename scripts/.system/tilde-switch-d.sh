#!/bin/bash
# Sets up tilde button for desktop mode (external monitor + keyboard connected)

hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000035},{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000064}]}'
