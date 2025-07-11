testroot : Elem {
    # "DES controlled Vert/Hrz combined layout"
    + GVisComps
    + ContainerMod
    VBox : ContainerMod.DVLayout {
        CreateWdg < LogLevel = "Dbg"
        SdcInsert < LogLevel = "Dbg"
        SdcConnWdg < LogLevel = "Dbg"
        Start.Prev !~ End.Next
        YPadding < = "SI 20"
        AlcW < = "SI 220"
        AlcH < = "SI 330"
        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
        Btn1 : FvWidgets.FButton {
            SText < = "SS 'Button v1'"
            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
        }
        Slot_Btn1 : ContainerMod.FVLayoutSlot
        Slot_Btn1.SCp ~ Btn1.Cp
        Btn2 : FvWidgets.FButton {
            LogLevel = "Dbg"
            AlcY < LogLevel = "Dbg"
            SText < = "SS 'Button v2'"
            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
            Sdo : SdoCoordOwr (
                # "SDO coordinates in owner coord system"
                Level ~ : SI_1
                InpX ~ AlcX
                InpY ~ AlcY
            )
            Sdo_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "PSI"
                }
                Inp ~ Sdo
            )
        }
        Slot_Btn2 : ContainerMod.FVLayoutSlot
        Slot_Btn2.SCp ~ Btn2.Cp
        Slot_Btn2.Next ~ Slot_Btn1.Prev
        Slot_Btn1.Next ~ Start.Prev
        Slot_Btn2.Prev ~ End.Next
    }
    Test : DesLauncher {
        # "Visualisation environment"
        LogLevel = "Dbg"
        VEnv : VisEnv
        # "Window"
        Wnd : GVisComps.Window {
            Width < = "SI 1200"
            Height < = "SI 800"
            Scene : GVisComps.Scene {
                # "Visualisation scene"
                HBox : ContainerMod.DHLayout {
                    CreateWdg < LogLevel = "Dbg"
                    SdcInsert < LogLevel = "Dbg"
                    SdcConnWdg < LogLevel = "Dbg"
                    Start.Prev !~ End.Next
                    XPadding < = "SI 20"
                    AlcW < = "SI 220"
                    AlcH < = "SI 330"
                    Btn1 : FvWidgets.FButton {
                        SText < = "SS 'Button 1'"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_Btn1 : ContainerMod.FHLayoutSlot (
                        SCp ~ Btn1.Cp
                        Next ~ Start.Prev
                    )
                    VBox1 : VBox
                    Slot_VBox1 : ContainerMod.FHLayoutSlot (
                        SCp ~ VBox1.Cp
                        Next ~ Slot_Btn1.Prev
                    )
                    Btn2 : FvWidgets.FButton {
                        SText < = "SS 'Button 2'"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_Btn2 : ContainerMod.FHLayoutSlot (
                        SCp ~ Btn2.Cp
                        Next ~ Slot_VBox1.Prev
                        Prev ~ End.Next
                    )
                }
            }
        }
        # " Adding new button"
        HBox_AddWdg : ContainerMod.DcAddWdgSc (
            Enable ~ : SB_True
            Name ~ : State {
                = "SS Btn3"
            }
            Parent ~ : State {
                = "SS FvWidgets.FButton"
            }
            Pos ~ : State {
                = "SI 0"
            }
            Mut ~ : State {
                = "CHR2 '{ SText < = \\\"SS Button_3\\\";  BgColor < = \\\"TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0\\\";  FgColor < =  \\\"TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0\\\" }'"
            }
        )
        HBox_AddWdg ~ Wnd.Scene.HBox.IoAddWidg
        AddedWdg_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB false"
            }
            Inp ~ HBox_AddWdg.Added
        )
        # "We need to use trigger that keeps WdgAdded indication. This is because Add/Rm internal ops breaks the indication."
        WdgAdded_Tg : DesUtils.RSTg
        WdgAdded_Tg.InpS ~ HBox_AddWdg.Added
        # " Removing button 1"
        HBox_RmWdg : ContainerMod.DcRmWdgSc (
            Enable ~ WdgAdded_Tg.Value
            Name ~ : State {
                = "SS Btn1"
            }
        )
        HBox_RmWdg ~ Wnd.Scene.HBox.IoRmWidg
        RmWdg_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB false"
            }
            Inp ~ HBox_RmWdg.Done
        )
        WdgAdded_Tg.InpR ~ HBox_RmWdg.Done
        # " Misc env"
        EnvWidth : State
        EnvHeight : State
        Title : State
        EnvWidth ~ Wnd.Inp_W
        EnvHeight ~ Wnd.Inp_H
        Title ~ Wnd.Inp_Title
        EnvWidth < = "SI 640"
        EnvHeight < = "SI 480"
        Title < = "SS Title"
    }
}
