testroot : Elem {
    # "UT of Syst CRP"
    + GVisComps
    + FvWidgets
    + AvrMdl2
    Comps : Elem
    Test : DesLauncher {
        _@ < LogLevel = "Dbg"
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
                        Model_syst1 : Syst {
                            # "System 1"
                            SysInp1 : ExtdStateInp
                            SysInp2 : ExtdStateInp
                            SysInp3 : ExtdStateInp
                            SysOutp1 : ExtdStateOutp
                            SysOutp2 : ExtdStateOutp
                            SysOutp3 : ExtdStateOutp
                        }
                    }
                }
                View : ContainerMod.DAlignment {
                    End.Next !~ Start.Prev
                    Start.Prev.AlcX ~ : SI_0
                    Start.Prev.AlcY ~ : SI_0
                    Model_syst1 : AvrMdl2.SystCrp {
                        # "CRP under test"
                    }
                    Slot_Crp : ContainerMod.AlignmentSlot (
                        Next ~ Start.Prev
                        Prev ~ End.Next
                        SCp ~ Crp.Cp
                    )
                }
                CrpCtx : DesCtxSpl {
                    ModelMntp : ExtdSystExploring
                    DrpMagUri : ExtdStateInp
                }
                CrpCtx.ModelMntp ~ ModelMnt.CpExplb
                CrpCtx.DrpMagUri ~ : Const {
                    = "URI Model"
                }
            }
        }
        EnvWidth : State
        EnvHeight : State
        Title : State
        EnvWidth ~ Window.Inp_W
        EnvHeight ~ Window.Inp_H
        Title ~ Window.Inp_Title
        Title < = "SS Title"
    }
}
