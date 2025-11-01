testroot : Elem {
    # "UT of Node CRP"
    + GVisComps
    + FvWidgets
    + AvrMdl2
    Comps : Elem
    Test : DesLauncher {
        # "Visualisation environment"
        Env : VisEnv
        Window : GVisComps.Window {
            Width < = "SI 1200"
            Height < = "SI 800"
            Scene : GVisComps.Scene {
                # "Visualisation scene"
                # "- Model"
                ModelMnt : Syst {
                    Model : Node {
                        Model_comp1 : Node
                        Model_comp2 : Node
                        Model_comp3 : Node
                        Model_comp4 : Node
                    }
                    CpExplb : CpSystExplorable
                }
                View : ContainerMod.DAlignment {
                    End.Next !~ Start.Prev
                    Crp : AvrMdl2.NodeCrp3 {
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
                    = "SS Model"
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
