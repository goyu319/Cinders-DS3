// ==EMEVD==
// @docs    ds3-common.emedf.json
// @compress    DarkSouls3
// @game    DarkSouls3
// @string    N:\FDP\data\Param\event\common_func.emevd       
// @linked    [0]
// ==/EMEVD==

//---------------------------------------------
// Constructor
//---------------------------------------------
Event(0, Restart, function() {
    RegisterBonfire(14700000, 4701950, 5, 180, 0); // Bonfire
    
    //----------------------
    // Phantoms
    //----------------------
    InitializeEvent(0, 14707000, 0);

    //----------------------
    // Spell Summons
    //----------------------
    InitializeEvent(0, 14707100, 0);
    
    //-------------------------------
    // Setup Pre-Memory
    //-------------------------------
    BatchSetEventFlags(25009680, 25009689, OFF); // Announcer flags
    
    SetEventFlag(25009600, OFF);
    SetEventFlag(25009610, OFF);
    SetEventFlag(25009611, OFF);
    SetEventFlag(25009612, OFF);
    SetEventFlag(25009613, OFF);
    SetEventFlag(25009614, OFF);
    
    InitializeEvent(0, 14702000, 0);
    
    WaitFixedTimeSeconds(2.0);
    
    //-------------------------------
    // Start Memory
    //-------------------------------
    IfEventFlag(MAIN, ON, TargetEventFlagType.EventFlag, 25009600);
    SetEventFlag(25009600, OFF);
    
    // Disable bonfire
    ChangeCharacterEnableState(4700950, Disabled);
    DeactivateObject(4701950, Disabled);
    SpawnOneshotSFX(TargetEntityType.Object, 4701950, 200, 1060);
    PlaySE(10000, SoundType.v_Voice, 444444441); // Shwing
    
    WaitFixedTimeSeconds(2.0);
    
    SetEventFlag(25009680, ON); // Announcer - Survive!
    PlaySE(10000, SoundType.v_Voice, 444444440); // Thud

    InitializeEvent(0, 14700100, 0);
    InitializeEvent(0, 14700101, 0); // Fallback timers
});
    
//---------------------------------------------
// Destructor
//---------------------------------------------
Event(50, Default, function() {
    
});

// ----------------------------------------
// Wave System
// ----------------------------------------
Event(14700100, Default, function() {
    // Add enemy modifiers
    SkipIfEventFlag(1, OFF, TargetEventFlagType.EventFlag, 25009610);
    SetSpEffect(4705761, 260200100);
    
    SkipIfEventFlag(1, OFF, TargetEventFlagType.EventFlag, 25009611);
    SetSpEffect(4705761, 260200101);
    
    SkipIfEventFlag(1, OFF, TargetEventFlagType.EventFlag, 25009612);
    SetSpEffect(4705761, 260200102);
    
    SkipIfEventFlag(1, OFF, TargetEventFlagType.EventFlag, 25009613);
    SetSpEffect(4705761, 260200103);
    
    SkipIfEventFlag(1, OFF, TargetEventFlagType.EventFlag, 25009614);
    SetSpEffect(4705761, 260200104);
    
    //-----------------------------
    // Round 1 
    //-----------------------------
    SetEventFlag(25009681, ON); // Announcer - Round 1
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    WaitFixedTimeSeconds(5.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    // Set 1
    InitializeCommonEvent(20087100, 4700180);
    InitializeCommonEvent(20087100, 4700181);
    InitializeCommonEvent(20087100, 4700182);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700183);
    InitializeCommonEvent(20087100, 4700184);
    InitializeCommonEvent(20087100, 4700185);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700186);
    InitializeCommonEvent(20087100, 4700187);
    InitializeCommonEvent(20087100, 4700188);
    InitializeCommonEvent(20087100, 4700189);
    
    // Wait for Set 1 to die
    IfCharacterDeadalive(AND_01, 4700180, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_01, 4700181, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_01, 4700182, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_01, 4700183, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_01, 4700184, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_01, 4700185, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_01, 4700186, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_01, 4700187, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_01, 4700188, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_01, 4700189, DeathState.Dead, ComparisonType.Equal, 1);
    IfConditionGroup(OR_01, PASS, AND_01);
    IfEventFlag(OR_01, ON, TargetEventFlagType.EventFlag, 25009690); // End sub-wave
    IfConditionGroup(MAIN, PASS, OR_01);
    
    WaitFixedTimeSeconds(2.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    // Set 2
    InitializeCommonEvent(20087100, 4700190);
    InitializeCommonEvent(20087100, 4700191);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700192);
    InitializeCommonEvent(20087100, 4700193);
    InitializeCommonEvent(20087100, 4700194);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700195);
    InitializeCommonEvent(20087100, 4700196);
    InitializeCommonEvent(20087100, 4700197);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700198);
    InitializeCommonEvent(20087100, 4700199);

    // Wait for Set 2 to die
    IfCharacterDeadalive(AND_02, 4700190, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_02, 4700191, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_02, 4700192, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_02, 4700193, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_02, 4700194, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_02, 4700195, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_02, 4700196, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_02, 4700197, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_02, 4700198, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_02, 4700199, DeathState.Dead, ComparisonType.Equal, 1);
    IfConditionGroup(OR_02, PASS, AND_02);
    IfEventFlag(OR_02, ON, TargetEventFlagType.EventFlag, 25009690); // End sub-wave
    IfConditionGroup(MAIN, PASS, OR_02);
    
    WaitFixedTimeSeconds(5.0);
    
    //-----------------------------
    // Round 2
    //-----------------------------
    SetEventFlag(25009682, ON); // Announcer - Round 2
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    WaitFixedTimeSeconds(5.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    // Set 1
    InitializeCommonEvent(20087100, 4700120);
    InitializeCommonEvent(20087100, 4700121);
    InitializeCommonEvent(20087100, 4700122);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700123);
    InitializeCommonEvent(20087100, 4700124);
    InitializeCommonEvent(20087100, 4700125);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700126);
    InitializeCommonEvent(20087100, 4700127);
    InitializeCommonEvent(20087100, 4700128);
    InitializeCommonEvent(20087100, 4700129);
    
    // Wait for Set 1 to die
    IfCharacterDeadalive(AND_03, 4700120, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_03, 4700121, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_03, 4700122, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_03, 4700123, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_03, 4700124, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_03, 4700125, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_03, 4700126, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_03, 4700127, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_03, 4700128, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_03, 4700129, DeathState.Dead, ComparisonType.Equal, 1);
    IfConditionGroup(OR_03, PASS, AND_03);
    IfEventFlag(OR_03, ON, TargetEventFlagType.EventFlag, 25009690); // End sub-wave
    IfConditionGroup(MAIN, PASS, OR_03);

    WaitFixedTimeSeconds(2.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    // Set 2
    InitializeCommonEvent(20087100, 4700130);
    InitializeCommonEvent(20087100, 4700131);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700132);
    InitializeCommonEvent(20087100, 4700133);
    InitializeCommonEvent(20087100, 4700134);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700135);
    InitializeCommonEvent(20087100, 4700136);
    InitializeCommonEvent(20087100, 4700137);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700138);
    InitializeCommonEvent(20087100, 4700139);

    // Wait for Set 2 to die
    IfCharacterDeadalive(AND_04, 4700130, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_04, 4700131, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_04, 4700132, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_04, 4700133, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_04, 4700134, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_04, 4700135, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_04, 4700136, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_04, 4700137, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_04, 4700138, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_04, 4700139, DeathState.Dead, ComparisonType.Equal, 1);
    IfConditionGroup(OR_04, PASS, AND_04);
    IfEventFlag(OR_04, ON, TargetEventFlagType.EventFlag, 25009690); // End sub-wave
    IfConditionGroup(MAIN, PASS, OR_04);
    
    WaitFixedTimeSeconds(5.0);
    
    //-----------------------------
    // Round 3
    //-----------------------------
    SetEventFlag(25009683, ON); // Announcer - Round 3
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    WaitFixedTimeSeconds(5.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    // Set 1
    InitializeCommonEvent(20087100, 4700160);
    InitializeCommonEvent(20087100, 4700161);
    InitializeCommonEvent(20087100, 4700162);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700163);
    InitializeCommonEvent(20087100, 4700164);
    InitializeCommonEvent(20087100, 4700165);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700166);
    InitializeCommonEvent(20087100, 4700167);
    InitializeCommonEvent(20087100, 4700168);
    InitializeCommonEvent(20087100, 4700169);
    
    // Wait for Set 1 to die
    IfCharacterDeadalive(AND_05, 4700160, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_05, 4700161, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_05, 4700162, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_05, 4700163, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_05, 4700164, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_05, 4700165, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_05, 4700166, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_05, 4700167, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_05, 4700168, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_05, 4700169, DeathState.Dead, ComparisonType.Equal, 1);
    IfConditionGroup(OR_05, PASS, AND_05);
    IfEventFlag(OR_05, ON, TargetEventFlagType.EventFlag, 25009690); // End sub-wave
    IfConditionGroup(MAIN, PASS, OR_05);

    WaitFixedTimeSeconds(2.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    // Set 2
    InitializeCommonEvent(20087100, 4700170);
    InitializeCommonEvent(20087100, 4700171);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700172);
    InitializeCommonEvent(20087100, 4700173);
    InitializeCommonEvent(20087100, 4700174);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700175);
    InitializeCommonEvent(20087100, 4700176);
    InitializeCommonEvent(20087100, 4700177);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700178);
    InitializeCommonEvent(20087100, 4700179);

    // Wait for Set 2 to die
    IfCharacterDeadalive(AND_06, 4700170, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_06, 4700171, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_06, 4700172, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_06, 4700173, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_06, 4700174, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_06, 4700175, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_06, 4700176, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_06, 4700177, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_06, 4700178, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_06, 4700179, DeathState.Dead, ComparisonType.Equal, 1);
    IfConditionGroup(OR_06, PASS, AND_06);
    IfEventFlag(OR_06, ON, TargetEventFlagType.EventFlag, 25009690); // End sub-wave
    IfConditionGroup(MAIN, PASS, OR_06);
    
    WaitFixedTimeSeconds(5.0);
    
    //-----------------------------
    // Round 4
    //-----------------------------
    SetEventFlag(25009684, ON); // Announcer - Round 4
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    WaitFixedTimeSeconds(5.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    // Set 1
    InitializeCommonEvent(20087100, 4700100);
    InitializeCommonEvent(20087100, 4700101);
    InitializeCommonEvent(20087100, 4700102);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700103);
    InitializeCommonEvent(20087100, 4700104);
    InitializeCommonEvent(20087100, 4700105);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700106);
    InitializeCommonEvent(20087100, 4700107);
    InitializeCommonEvent(20087100, 4700108);
    InitializeCommonEvent(20087100, 4700109);
    
    // Wait for Set 1 to die
    IfCharacterDeadalive(AND_07, 4700100, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_07, 4700101, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_07, 4700102, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_07, 4700103, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_07, 4700104, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_07, 4700105, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_07, 4700106, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_07, 4700107, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_07, 4700108, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_07, 4700109, DeathState.Dead, ComparisonType.Equal, 1);
    IfConditionGroup(OR_07, PASS, AND_07);
    IfEventFlag(OR_07, ON, TargetEventFlagType.EventFlag, 25009690); // End sub-wave
    IfConditionGroup(MAIN, PASS, OR_07);
    
    WaitFixedTimeSeconds(2.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    // Set 2
    InitializeCommonEvent(20087100, 4700110);
    InitializeCommonEvent(20087100, 4700111);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700112);
    InitializeCommonEvent(20087100, 4700113);
    InitializeCommonEvent(20087100, 4700114);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700115);
    InitializeCommonEvent(20087100, 4700116);
    InitializeCommonEvent(20087100, 4700117);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700118);
    InitializeCommonEvent(20087100, 4700119);

    // Wait for Set 2 to die
    IfCharacterDeadalive(AND_08, 4700110, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_08, 4700111, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_08, 4700112, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_08, 4700113, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_08, 4700114, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_08, 4700115, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_08, 4700116, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_08, 4700117, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_08, 4700118, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_08, 4700119, DeathState.Dead, ComparisonType.Equal, 1);
    IfConditionGroup(OR_08, PASS, AND_08);
    IfEventFlag(OR_08, ON, TargetEventFlagType.EventFlag, 25009690); // End sub-wave
    IfConditionGroup(MAIN, PASS, OR_08);
    
    WaitFixedTimeSeconds(5.0);
    
    //-----------------------------
    // Round 5
    //-----------------------------
    SetEventFlag(25009685, ON); // Announcer - Round 5
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    WaitFixedTimeSeconds(5.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    // Set 1
    InitializeCommonEvent(20087100, 4700140);
    InitializeCommonEvent(20087100, 4700141);
    InitializeCommonEvent(20087100, 4700142);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700143);
    InitializeCommonEvent(20087100, 4700144);
    InitializeCommonEvent(20087100, 4700145);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700146);
    InitializeCommonEvent(20087100, 4700147);
    InitializeCommonEvent(20087100, 4700148);
    InitializeCommonEvent(20087100, 4700149);
    
    // Wait for Set 1 to die
    IfCharacterDeadalive(AND_09, 4700140, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_09, 4700141, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_09, 4700142, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_09, 4700143, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_09, 4700144, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_09, 4700145, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_09, 4700146, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_09, 4700147, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_09, 4700148, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_09, 4700149, DeathState.Dead, ComparisonType.Equal, 1);
    IfConditionGroup(OR_09, PASS, AND_09);
    IfEventFlag(OR_09, ON, TargetEventFlagType.EventFlag, 25009690); // End sub-wave
    IfConditionGroup(MAIN, PASS, OR_09);

    WaitFixedTimeSeconds(2.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    // Set 2
    InitializeCommonEvent(20087100, 4700150);
    InitializeCommonEvent(20087100, 4700151);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700152);
    InitializeCommonEvent(20087100, 4700153);
    InitializeCommonEvent(20087100, 4700154);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700155);
    InitializeCommonEvent(20087100, 4700156);
    InitializeCommonEvent(20087100, 4700157);
    
    WaitFixedTimeSeconds(8.0);
    PlaySE(10000, SoundType.v_Voice, 444444442); // Thud Shwing
    
    InitializeCommonEvent(20087100, 4700158);
    InitializeCommonEvent(20087100, 4700159);

    // Wait for Set 2 to die
    IfCharacterDeadalive(AND_10, 4700150, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_10, 4700151, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_10, 470012, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_10, 47001543, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_10, 4700154, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_10, 4700155, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_10, 4700156, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_10, 4700157, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_10, 4700158, DeathState.Dead, ComparisonType.Equal, 1);
    IfCharacterDeadalive(AND_10, 4700159, DeathState.Dead, ComparisonType.Equal, 1);
    IfConditionGroup(OR_10, PASS, AND_10);
    IfEventFlag(OR_10, ON, TargetEventFlagType.EventFlag, 25009690); // End sub-wave
    IfConditionGroup(MAIN, PASS, OR_10);
    
    WaitFixedTimeSeconds(5.0);
    
    //-----------------------------
    // Complete
    //-----------------------------
    SetEventFlag(25009686, ON); // Announcer - Cycle Complete
    PlaySE(10000, SoundType.v_Voice, 444444441); // Shwing
    
    // Rewards
    SkipIfEventFlag(1, OFF, TargetEventFlagType.EventFlag, 25009610);
    AwardItemLot(110000);
    
    SkipIfEventFlag(1, OFF, TargetEventFlagType.EventFlag, 25009611);
    AwardItemLot(110010);
    
    SkipIfEventFlag(1, OFF, TargetEventFlagType.EventFlag, 25009612);
    AwardItemLot(110020);
    
    SkipIfEventFlag(1, OFF, TargetEventFlagType.EventFlag, 25009613);
    AwardItemLot(110030);
    
    SkipIfEventFlag(1, OFF, TargetEventFlagType.EventFlag, 25009614);
    AwardItemLot(110040);
    
    // Restart
    WaitFixedTimeSeconds(10.0);
    
    WarpPlayer(47, 0, 4700970);
});

// ----------------------------------------
// Fallback Timer
// ----------------------------------------
Event(14700101, Default, function() {
    SetEventFlag(25009690, OFF);
    
    WaitFixedTimeSeconds(120);
    
    SetEventFlag(25009690, ON);
    WaitFixedTimeFrames(1.0);
    
    EndUnconditionally(EventEndType.Restart);
});

// ----------------------------------------
// Setup Enemies
// ----------------------------------------
Event(14702000, Restart, function() {
    ChangeCharacterEnableState(4700900, Disabled);
    SetCharacterAnimationState(4700900, Disabled);
    SetCharacterAIState(4700900, Disabled);

    ChangeCharacterEnableState(4705761, Disabled);
    SetCharacterAnimationState(4705761, Disabled);
    SetCharacterAIState(4705761, Disabled);
    
    InitializeCommonEvent(20081010, 4705761, 250001020, 25000400); // Curse of Pride - 10%
    InitializeCommonEvent(20081010, 4705761, 250001021, 25000401); // Curse of Pride - 20%
    InitializeCommonEvent(20081010, 4705761, 250001022, 25000402); // Curse of Pride - 30%
    InitializeCommonEvent(20081010, 4705761, 250001023, 25000403); // Curse of Pride - 40%
    InitializeCommonEvent(20081010, 4705761, 250001024, 25000404); // Curse of Pride - 50%
    InitializeCommonEvent(20081010, 4705761, 250001025, 25000405); // Curse of Pride - 60%
    InitializeCommonEvent(20081010, 4705761, 250001026, 25000406); // Curse of Pride - 70%
    InitializeCommonEvent(20081010, 4705761, 250001027, 25000407); // Curse of Pride - 80%
    InitializeCommonEvent(20081010, 4705761, 250001028, 25000408); // Curse of Pride - 90%
    InitializeCommonEvent(20081010, 4705761, 250001029, 25000409); // Curse of Pride - 100%

    InitializeCommonEvent(20081010, 4705761, 250001120, 25000410); // Curse of Fortitude - 5%
    InitializeCommonEvent(20081010, 4705761, 250001121, 25000411); // Curse of Fortitude - 10%
    InitializeCommonEvent(20081010, 4705761, 250001122, 25000412); // Curse of Fortitude - 15%
    InitializeCommonEvent(20081010, 4705761, 250001123, 25000413); // Curse of Fortitude - 20%
    InitializeCommonEvent(20081010, 4705761, 250001124, 25000414); // Curse of Fortitude - 25%
    InitializeCommonEvent(20081010, 4705761, 250001125, 25000415); // Curse of Fortitude - 30%
    InitializeCommonEvent(20081010, 4705761, 250001126, 25000416); // Curse of Fortitude - 35%
    InitializeCommonEvent(20081010, 4705761, 250001127, 25000417); // Curse of Fortitude - 40%
    InitializeCommonEvent(20081010, 4705761, 250001128, 25000418); // Curse of Fortitude - 45%
    InitializeCommonEvent(20081010, 4705761, 250001129, 25000419); // Curse of Fortitude - 50%
    
    InitializeCommonEvent(20081010, 4705761, 250001320, 25000420); // Curse of Vitality - 10
    InitializeCommonEvent(20081010, 4705761, 250001321, 25000421); // Curse of Vitality - 20
    InitializeCommonEvent(20081010, 4705761, 250001322, 25000422); // Curse of Vitality - 30
    InitializeCommonEvent(20081010, 4705761, 250001323, 25000423); // Curse of Vitality - 40
    InitializeCommonEvent(20081010, 4705761, 250001324, 25000424); // Curse of Vitality - 50
    InitializeCommonEvent(20081010, 4705761, 250001325, 25000425); // Curse of Vitality - 60
    InitializeCommonEvent(20081010, 4705761, 250001326, 25000426); // Curse of Vitality - 70
    InitializeCommonEvent(20081010, 4705761, 250001327, 25000427); // Curse of Vitality - 80
    InitializeCommonEvent(20081010, 4705761, 250001328, 25000428); // Curse of Vitality - 90
    InitializeCommonEvent(20081010, 4705761, 250001329, 25000429); // Curse of Vitality - 100
    
    InitializeCommonEvent(20081010, 4705761, 250001420, 25000430); // Curse of Wrath - 10
    InitializeCommonEvent(20081010, 4705761, 250001421, 25000431); // Curse of Wrath - 20
    InitializeCommonEvent(20081010, 4705761, 250001422, 25000432); // Curse of Wrath - 30
    InitializeCommonEvent(20081010, 4705761, 250001423, 25000433); // Curse of Wrath - 40
    InitializeCommonEvent(20081010, 4705761, 250001424, 25000434); // Curse of Wrath - 50
    InitializeCommonEvent(20081010, 4705761, 250001425, 25000435); // Curse of Wrath - 60
    InitializeCommonEvent(20081010, 4705761, 250001426, 25000436); // Curse of Wrath - 70
    InitializeCommonEvent(20081010, 4705761, 250001427, 25000437); // Curse of Wrath - 80
    InitializeCommonEvent(20081010, 4705761, 250001428, 25000438); // Curse of Wrath - 90
    InitializeCommonEvent(20081010, 4705761, 250001429, 25000439); // Curse of Wrath - 100
    
    InitializeCommonEvent(20081000, 4705750, 25000440);             // Curse of Attraction
    InitializeCommonEvent(20081010, 4705761, 250001920, 25000480);  // Curse of Frailty
    InitializeCommonEvent(20081010, 4705770, 250002220, 25000510);  // Curse of Valor
    
    // Company of Champions
    InitializeCommonEvent(20081020, 4705760, 160101502, 160101503); // I
    InitializeCommonEvent(20081020, 4705760, 160101512, 160101513); // II
    InitializeCommonEvent(20081020, 4705760, 160101522, 160101523); // III
    InitializeCommonEvent(20081020, 4705760, 160101532, 160101533); // IV
    InitializeCommonEvent(20081020, 4705760, 160101542, 160101543); // V
});

// ----------------------------------------
// Phantoms
// ----------------------------------------
Event(14707000, Default, function() {
    
});

// ----------------------------------------
// Spell Summons
// ----------------------------------------
Event(14707100, Default, function() {
    // Skeleton
    InitializeCommonEvent(20080000, 4700750); // Setup
    InitializeCommonEvent(20080001, 4700750); // Bonfire Rest
    InitializeCommonEvent(20080002, 4700750); // Tools
    InitializeCommonEvent(20080003, 4700750); // Effects
    InitializeCommonEvent(20080004, 4700750, 160760000, 160760216, 47, 0); // Summoning
    
    // Hollow
    InitializeCommonEvent(20080000, 4700751); // Setup
    InitializeCommonEvent(20080001, 4700751); // Bonfire Rest
    InitializeCommonEvent(20080002, 4700751); // Tools
    InitializeCommonEvent(20080003, 4700751); // Effects
    InitializeCommonEvent(20080004, 4700751, 160760001, 160760216, 47, 0); // Summoning
    
    // Hound
    InitializeCommonEvent(20080000, 4700752); // Setup
    InitializeCommonEvent(20080001, 4700752); // Bonfire Rest
    InitializeCommonEvent(20080002, 4700752); // Tools
    InitializeCommonEvent(20080003, 4700752); // Effects
    InitializeCommonEvent(20080004, 4700752, 160760002, 160760216, 47, 0); // Summoning
    
    // Carthus Warrior
    InitializeCommonEvent(20080000, 4700753); // Setup
    InitializeCommonEvent(20080001, 4700753); // Bonfire Rest
    InitializeCommonEvent(20080002, 4700753); // Tools
    InitializeCommonEvent(20080003, 4700753); // Effects
    InitializeCommonEvent(20080004, 4700753, 160760003, 160760216, 47, 0); // Summoning
    
    // Lothric Knight
    InitializeCommonEvent(20080000, 4700754); // Setup
    InitializeCommonEvent(20080001, 4700754); // Bonfire Rest
    InitializeCommonEvent(20080002, 4700754); // Tools
    InitializeCommonEvent(20080003, 4700754); // Effects
    InitializeCommonEvent(20080004, 4700754, 160760004, 160760216, 47, 0); // Summoning
    
    // Lycanthrope
    InitializeCommonEvent(20080000, 4700755); // Setup
    InitializeCommonEvent(20080001, 4700755); // Bonfire Rest
    InitializeCommonEvent(20080002, 4700755); // Tools
    InitializeCommonEvent(20080003, 4700755); // Effects
    InitializeCommonEvent(20080004, 4700755, 160760005, 160760216, 47, 0); // Summoning
    
    // Black Knight
    InitializeCommonEvent(20080000, 4700756); // Setup
    InitializeCommonEvent(20080001, 4700756); // Bonfire Rest
    InitializeCommonEvent(20080002, 4700756); // Tools
    InitializeCommonEvent(20080003, 4700756); // Effects
    InitializeCommonEvent(20080004, 4700756, 160760006, 160760216, 47, 0); // Summoning
    
    // Abyss Watcher
    InitializeCommonEvent(20080000, 4700757); // Setup
    InitializeCommonEvent(20080001, 4700757); // Bonfire Rest
    InitializeCommonEvent(20080002, 4700757); // Tools
    InitializeCommonEvent(20080003, 4700757); // Effects
    InitializeCommonEvent(20080004, 4700757, 160760007, 160760216, 47, 0); // Summoning
    
    // Stone Gargoyle
    InitializeCommonEvent(20080000, 4700758); // Setup
    InitializeCommonEvent(20080001, 4700758); // Bonfire Rest
    InitializeCommonEvent(20080002, 4700758); // Tools
    InitializeCommonEvent(20080003, 4700758); // Effects
    InitializeCommonEvent(20080004, 4700758, 160760008, 160760216, 47, 0); // Summoning
});
    
    
