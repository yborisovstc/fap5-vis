testroot : Elem {
    # "Unit test of Label agent"
    + GVisComps
    + FvWidgets
    Launcher : DesLauncher {
        LogLevel = "Dbg"
        Test : Des {
            # "Visualisation environment"
            VEnv : VisEnv
            # "Window"
            Wnd : GVisComps.Window {
                Width < = "SI 1200"
                Height < = "SI 800"
                Scene : GVisComps.Scene {
                    # "Visualisation scene"
                    Wdg1 : FvWidgets.FButton {
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                        SText < = "SS Button_1"
                        Border < = "SI 1"
                        AlcX < = "SI 200"
                        AlcY < = "SI 100"
                    }
                }
            }
            EnvWidth : State
            EnvHeight : State
            Title : State
            EnvWidth ~ Wnd.Inp_W
            EnvHeight ~ Wnd.Inp_H
            Title ~ Wnd.Inp_Title
            EnvWidth < = "SI 640"
            EnvHeight < = "SI 480"
            Title < = "SS Title"
            # " Increasing size of widget"
            WdgWidth : State {
                LogLevel = "Dbg"
                = "SI 80"
            }
            WdgHeight : State {
                LogLevel = "Dbg"
                = "SI 60"
            }
            IncrData : Const {
                = "SI 1"
            }
            WdgWidth.Inp ~ : TrSwitchBool (
                Sel ~ Cpm_Lt : TrCmpVar (
                    Inp ~ WdgWidth
                    Inp2 ~ : Const {
                        = "SI 200"
                    }
                )
                Inp1 ~ WdgWidth
                Inp2 ~ IncrW : TrAddVar (
                    Inp ~ IncrData
                    Inp ~ WdgWidth
                )
            )
            WdgHeight.Inp ~ : TrSwitchBool (
                Sel ~ Cpm2_Lt : TrCmpVar (
                    Inp ~ WdgHeight
                    Inp2 ~ : Const {
                        = "SI 200"
                    }
                )
                Inp1 ~ WdgHeight
                Inp2 ~ IncrH : TrAddVar (
                    Inp ~ IncrData
                    Inp ~ WdgHeight
                )
            )
            WdgWidth ~ Wnd.Scene.Wdg1.Cp.InpAlcW
            WdgHeight ~ Wnd.Scene.Wdg1.Cp.InpAlcH
            SLbpUri_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "URI"
                }
                Inp ~ Wnd.Scene.Wdg1.Cp.LbpUri
            )
        }
    }
}
