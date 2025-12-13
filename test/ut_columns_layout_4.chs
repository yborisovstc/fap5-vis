testroot : Elem {
    # "Unit test of column layout as the widget of container"
    # "Dynamic addition of column layout widget"
    + GVisComps
    + ContainerMod
    ColumnsView : ContainerMod.ColumnsLayout {
        Start.Prev !~ End.Next
        _ <  {
            XPadding < = "SI 20"
            YPadding < = "SI 20"
            AlcW < = "SI 220"
            AlcH < = "SI 330"
        }
        AlcX < LogLevel = "Dbg"
        AlcY < LogLevel = "Dbg"
        AlcW < LogLevel = "Dbg"
        RqsW < LogLevel = "Dbg"
        Column1 : ContainerMod.ColumnLayoutSlot {
            Start.Prev !~ End.Next
        }
        Btn1 : FvWidgets.FButton {
            AlcX < LogLevel = "Dbg"
            AlcY < LogLevel = "Dbg"
            AlcW < LogLevel = "Dbg"
            SText < = "SS 'Column1 Button 1, Hello'"
            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
        }
        Slot_Btn1 : ContainerMod.ColumnItemSlot
        Slot_Btn1.SCp ~ Btn1.Cp
        Btn2 : FvWidgets.FButton {
            AlcX < LogLevel = "Dbg"
            AlcY < LogLevel = "Dbg"
            AlcW < LogLevel = "Dbg"
            SText < = "SS 'Column1 Button 2'"
            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
        }
        Slot_Btn2 : ContainerMod.ColumnItemSlot
        Slot_Btn2.SCp ~ Btn2.Cp
        Slot_Btn2.Next ~ Slot_Btn1.Prev
        Slot_Btn1.Next ~ Column1.Start.Prev
        Slot_Btn2.Prev ~ Column1.End.Next
        Column1.Next ~ Start.Prev
        Column2 : ContainerMod.ColumnLayoutSlot {
            Start.Prev !~ End.Next
        }
        Btn3 : FvWidgets.FButton {
            AlcX < LogLevel = "Dbg"
            AlcY < LogLevel = "Dbg"
            AlcW < LogLevel = "Dbg"
            SText < = "SS 'Column2 Button 1'"
            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
        }
        Slot_Btn3 : ContainerMod.ColumnItemSlot
        Slot_Btn3.SCp ~ Btn3.Cp
        Btn4 : FvWidgets.FButton {
            AlcX < LogLevel = "Dbg"
            AlcY < LogLevel = "Dbg"
            AlcW < LogLevel = "Dbg"
            SText < = "SS 'Column2 Button 2'"
            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
        }
        Slot_Btn4 : ContainerMod.ColumnItemSlot
        Slot_Btn4.SCp ~ Btn4.Cp
        Slot_Btn4.Next ~ Slot_Btn3.Prev
        Slot_Btn3.Next ~ Column2.Start.Prev
        Slot_Btn4.Prev ~ Column2.End.Next
        Column2.Next ~ Column1.Prev
        End.Next ~ Column2.Prev
    }
    Test : DesLauncher {
        # "Visualisation environment"
        VEnv : VisEnv
        # "Window"
        Wnd : GVisComps.Window {
            Init = "Yes"
            Width < = "SI 1200"
            Height < = "SI 800"
            Scene : GVisComps.Scene {
                # "Visualisation scene"
                HBox : ContainerMod.DHLayout {
                    Start.Prev !~ End.Next
                    XPadding < = "SI 20"
                    AlcW < = "SI 1200"
                    AlcH < = "SI 330"
                    ColView1 : ColumnsView {
                        XPadding < = "SI 25"
                        YPadding < = "SI 5"
                    }
                    Slot_ColView1 : ContainerMod.FHLayoutSlot (
                        SCp ~ ColView1.Cp
                        Next ~ Start.Prev
                    )
                    ColView2 : ColumnsView {
                        XPadding < = "SI 5"
                        YPadding < = "SI 5"
                    }
                    Slot_ColView2 : ContainerMod.FHLayoutSlot (
                        SCp ~ ColView2.Cp
                        Next ~ Slot_ColView1.Prev
                        Prev ~ End.Next
                    )
                }
            }
        }
        # " Adding new column layout widget"
        MyColView : ColumnsView {
            # "New column view"
            LogLevel = "Dbg"
            AlcX < LogLevel = "Dbg"
            AlcY < LogLevel = "Dbg"
            AlcW < LogLevel = "Dbg"
            AlcH < LogLevel = "Dbg"
        }
        HBox_AddWdg : ContainerMod.DcAddWdgCp
        HBox_AddWdg.Int ~ Wnd.Scene.HBox.IoAddWidg
        HBox_AddWdg.Enable ~ : Const {
            = "SB true"
        }
        HBox_AddWdg.Name ~ : Const {
            = "SS ColView3"
        }
        HBox_AddWdg.Parent ~ : Const {
            = "SS MyColView"
        }
        AddedWdg_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB false"
            }
            Inp ~ HBox_AddWdg.Added
        )
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
