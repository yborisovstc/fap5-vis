testroot : Elem {
    # "Unit test of combined vertical layout"
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
                VBox : ContainerMod.DVLayout {
                    XPadding < = "SI 10"
                    YPadding < = "SI 10"
                    AlcW < = "SI 220"
                    AlcH < = "SI 330"
                    Start.Prev !~ End.Next
                    # " ===== Slot 1 ===="
                    Btn1 : FvWidgets.FButton {
                        SText < = "SS Button_1"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_1 : ContainerMod.FVLayoutSlot
                    Slot_1.SCp ~ Btn1.Cp
                    Slot_1.Next ~ Start.Prev
                    # " ==== Slot 2 ===="
                    HBox2 : ContainerMod.DHLayout {
                        XPadding < = "SI 10"
                        YPadding < = "SI 10"
                        AlcW < = "SI 220"
                        AlcH < = "SI 330"
                        Start.Prev !~ End.Next
                        Btn2_1 : FvWidgets.FButton {
                            SText < = "SS Button_2_1"
                            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                        }
                        Slot_1 : ContainerMod.FHLayoutSlot
                        Slot_1.SCp ~ Btn2_1.Cp
                        Slot_1.Next ~ Start.Prev
                        Btn2_2 : FvWidgets.FButton {
                            SText < = "SS Button_2_2"
                            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                        }
                        Slot_2 : ContainerMod.FHLayoutSlot
                        Slot_2.SCp ~ Btn2_2.Cp
                        Slot_2.Next ~ Slot_1.Prev
                        End.Next ~ Slot_2.Prev
                    }
                    Slot_2 : ContainerMod.FVLayoutSlot
                    Slot_2.SCp ~ HBox2.Cp
                    Slot_2.Next ~ Slot_1.Prev
                    # " ==== Slot 3 ===="
                    Btn3 : FvWidgets.FButton {
                        SText < = "SS Button_3"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_3 : ContainerMod.FVLayoutSlot
                    Slot_3.SCp ~ Btn3.Cp
                    Slot_3.Next ~ Slot_2.Prev
                    Slot_3.Prev ~ End.Next
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
