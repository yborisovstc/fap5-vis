testroot : Elem {
    # "UT of Vertex DRP"
    + GVisComps
    + FvWidgets
    + AvrMdl2
    Comps : Elem
    Test : DesLauncher {
        LogLevel = "Dbg"
        # "Visualisation environment"
        Env : VisEnv
        Window : GVisComps.Window {
            Width < = "SI 1200"
            Height < = "SI 800"
            Scene : GVisComps.Scene {
                # "Visualisation scene"
                # "- Model"
                ModelMnt : Syst {
                    CpExplb : CpSystExplorable
                    Model : Syst {
                        Model_vert1 : Vert
                        Model_vert2 : Vert
                        Model_vert3 : Vert
                        Model_vert4 : Vert
                        Model_vert5 : Vert
                        Model_vert6 : Vert
                        Model_vert7 : Vert
                        Model_vert1 ~ Model_vert2
                        Model_vert1 ~ Model_vert4
                        Model_vert2 ~ Model_vert4
                        Model_vert3 ~ Model_vert5
                        Model_vert7 ~ Model_vert1
                    }
                }
                MdlUri : State {
                    = "URI Model"
                }
                # "DRP context"
                DrpCtx : DesCtxSpl (
                    _@ <  {
                        ModelMntp : ExtdSystExploring
                        DrpMagUri : ExtdStateInp
                    }
                    ModelMntp ~ ModelMnt.CpExplb
                    DrpMagUri ~ MdlUri
                )
                # "DRP"
                Drp : AvrMdl2.VertDrp {
                    # "Initial column"
                    XPadding < = "SI 20"
                    YPadding < = "SI 20"
                    AlcW < = "SI 220"
                    AlcH < = "SI 330"
                }
                Drp.MagAdp.CompsCount < LogLevel = "Dbg"
                Drp.CmpCn_Ge < LogLevel = "Dbg"
                Drp.MagAdp.StMagUri < LogLevel = "Dbg"
            }
        }
        EnvWidth : State
        EnvHeight : State
        Title : State
        EnvWidth ~ Window.Inp_W
        EnvHeight ~ Window.Inp_H
        Title ~ Window.Inp_Title
        EnvWidth < = "SI 640"
        EnvHeight < = "SI 480"
        Title < = "SS Title"
    }
}
