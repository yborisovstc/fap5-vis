testroot : Elem {
    # "Unit test of horizontal layout container"
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
                    Padding < = "SI 20"
                    AlcW < = "SI 220"
                    AlcH < = "SI 330"
                    Start.Prev !~ End.Next
                    Btn1 : FvWidgets.FButton {
                        SText < = "SS Button_1"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_1 : ContainerMod.FHLayoutSlot
                    Slot_1.SCp ~ Btn1.Cp
                    Btn2 : FvWidgets.FButton {
                        SText < = "SS Button_2"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_2 : ContainerMod.FHLayoutSlot
                    Slot_2.SCp ~ Btn2.Cp
                    Slot_2.Next ~ Slot_1.Prev
                    Slot_1.Next ~ Start.Prev
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
