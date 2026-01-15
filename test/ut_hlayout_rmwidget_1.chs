testroot : Elem {
    # "Unit test of Container removing widget"
    + GVisComps
    + ContainerMod
    Test : DesLauncher {
        # "Visualisation environment"
        LogLevel = "Dbg"
        VEnv : VisEnv
        Window : GVisComps.Window {
            Width < = "SI 1200"
            Height < = "SI 800"
            Scene : GVisComps.Scene {
                HBox : ContainerMod.DHLayout {
                    XPadding < = "SI 20"
                    YPadding < = "SI 20"
                    AlcW < = "SI 220"
                    AlcH < = "SI 330"
                    Start.Prev !~ End.Next
                    Btn1 : FvWidgets.FButton {
                        SText < = "SS Button_1"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_Btn1 : ContainerMod.FHLayoutSlot
                    Slot_Btn1.SCp ~ Btn1.Cp
                    Btn2 : FvWidgets.FButton {
                        SText < = "SS Button_2"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_2 : ContainerMod.FHLayoutSlot
                    Slot_2.SCp ~ Btn2.Cp
                    Slot_2.Next ~ Slot_Btn1.Prev
                    Slot_Btn1.Next ~ Start.Prev
                    Slot_2.Prev ~ End.Next
                }
            }
        }
        EnvWidth : State {
            = "SI 640"
        }
        EnvHeight : State {
            = "SI 480"
        }
        Title : State {
            = "SS Title"
        }
        EnvWidth ~ Wnd.Inp_W
        EnvHeight ~ Wnd.Inp_H
        Title ~ Wnd.Inp_Title
        # "Mutation to remove Bnt2"
        Timeout : State {
            LogLevel = "Dbg"
            = "SI 0"
        }
        Timeout.Inp ~ : TrAddVar (
            Inp ~ Timeout
            Inp ~ : TrSwitchBool (
                Sel ~ Cmp_Eq_2 : TrCmpVar (
                    Inp ~ Timeout
                    Inp2 ~ : State {
                        = "SI 22"
                    }
                )
                Inp1 ~ : State {
                    = "SI 1"
                }
                Inp2 ~ : State {
                    = "SI 0"
                }
            )
        )
        Window.Scene.HBox.IoRmWidg.Name ~ : Const {
            = "SS Btn1"
        }
        Window.Scene.HBox.IoRmWidg.Enable ~ : TrSwitchBool (
            Sel ~ Cmp_Eq : TrCmpVar (
                Inp ~ Timeout
                Inp2 ~ : State {
                    = "SI 20"
                }
            )
            Inp1 ~ : State {
                = "SB false"
            }
            Inp2 ~ : State {
                = "SB true"
            }
        )
        RmWdg_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB false"
            }
            Inp ~ HBox_RmWdg.Done
        )
        Window.Scene.HBox.SdcExtrSlot < LogLevel = "Dbg"
    }
}
