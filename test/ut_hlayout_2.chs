testroot : Elem {
    # "Unit test of combined horizontal layout"
    + GVisComps
    + ContainerMod
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
                    XPadding < = "SI 40"
                    YPadding < = "SI 40"
                    AlcW < = "SI 220"
                    AlcH < = "SI 330"
                    Start.Prev !~ End.Next
                    # " ==== Slot 1 ===="
                    VBox2 : ContainerMod.DVLayout {
                        XPadding < = "SI 10"
                        YPadding < = "SI 10"
                        AlcW < = "SI 220"
                        AlcH < = "SI 330"
                        Start.Prev !~ End.Next
                        Btn2_1 : FvWidgets.FButton {
                            WdgAgent < LogLevel = "Dbg"
                            SText < = "SS Button_2_1"
                            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                        }
                        Slot_1 : ContainerMod.FVLayoutSlot
                        Slot_1.SCp ~ Btn2_1.Cp
                        Slot_1.Next ~ Start.Prev
                        Btn2_2 : FvWidgets.FButton {
                            WdgAgent < LogLevel = "Dbg"
                            SText < = "SS Button_2_2"
                            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                        }
                        Slot_2 : ContainerMod.FVLayoutSlot
                        Slot_2.SCp ~ Btn2_2.Cp
                        Slot_2.Next ~ Slot_1.Prev
                        End.Next ~ Slot_2.Prev
                    }
                    Slot_1 : ContainerMod.FHLayoutSlot
                    Slot_1.SCp ~ VBox2.Cp
                    Slot_1.Next ~ Start.Prev
                    # " ==== Slot 2 ===="
                    Btn3 : FvWidgets.FButton {
                        WdgAgent < LogLevel = "Dbg"
                        SText < = "SS Button_3"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_2 : ContainerMod.FHLayoutSlot
                    Slot_2.SCp ~ Btn3.Cp
                    Slot_2.Next ~ Slot_1.Prev
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
    }
}
