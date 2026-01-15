ContainerMod : Elem {
    # "TODO To have Start and End as specific slots with CPs"
    About = "FAP3 widget visualization system"
    + FvWidgets
    + DesUtils
    SlotCpSc : Socket2 {
        InpAlcX : CpStateInp
        InpAlcY : CpStateInp
        InpAlcW : CpStateInp
        InpAlcH : CpStateInp
        OutAlcX : CpStateOutp
        OutAlcY : CpStateOutp
        OutAlcW : CpStateOutp
        OutAlcH : CpStateOutp
        RqsW : CpStateOutp
        RqsH : CpStateOutp
        LbpUri : CpStateOutp
    }
    SlotCpS : Socket2 {
        InpAlcX : CpStateOutp
        InpAlcY : CpStateOutp
        InpAlcW : CpStateOutp
        InpAlcH : CpStateOutp
        OutAlcX : CpStateInp
        OutAlcY : CpStateInp
        OutAlcW : CpStateInp
        OutAlcH : CpStateInp
        RqsW : CpStateInp
        RqsH : CpStateInp
        LbpUri : CpStateInp
    }
    SlotCp : SlotCpS {
        Int : SlotCpSc
    }
    SlotLinNextCpS : Socket2 {
        AlcX : CpStateOutp
        AlcY : CpStateOutp
        AlcW : CpStateOutp
        AlcH : CpStateOutp
        CntRqsW : CpStateOutp
        CntRqsH : CpStateOutp
        XPadding : CpStateOutp
        YPadding : CpStateOutp
        LbpComp : CpStateOutp
    }
    SlotLinPrevCpS : Socket2 {
        AlcX : CpStateInp
        AlcY : CpStateInp
        AlcW : CpStateInp
        AlcH : CpStateInp
        CntRqsW : CpStateInp
        CntRqsH : CpStateInp
        XPadding : CpStateInp
        YPadding : CpStateInp
        LbpComp : CpStateInp
    }
    SlotLinNextCp : SlotLinPrevCpS {
        Int : SlotLinNextCpS
    }
    SlotLinPrevCp : SlotLinNextCpS {
        Int : SlotLinPrevCpS
    }
    FSlot : Des {
        SCp : SlotCp
    }
    LinStart : Syst {
        # "Lin layout slots list start"
        Prev : SlotLinPrevCp
    }
    LinEnd : Syst {
        # "Lin layout slots list end"
        Next : SlotLinNextCp
    }
    # " Linear layout slot"
    FSlotLin : FSlot {
        Prev : SlotLinPrevCp
        Next : SlotLinNextCp
        Prev.Int.XPadding ~ Next.Int.XPadding
        Prev.Int.YPadding ~ Next.Int.YPadding
        Prev.Int.LbpComp ~ LbpCompDbg : TrSvldVar (
            Inp1 ~ Next.Int.LbpComp
            Inp2 ~ SCp.Int.LbpUri
        )
    }
    FVLayoutSlot : FSlotLin {
        # " Vertical layout slot"
        Add1 : TrAddVar (
            Inp ~ Next.Int.AlcY
            Inp ~ Next.Int.YPadding
            Inp ~ Next.Int.AlcH
        )
        Max1 : TrMaxVar (
            Inp ~ Next.Int.CntRqsW
            Inp ~ SCp.Int.RqsW
        )
        Prev.Int  (
            AlcX ~ SCp.Int.OutAlcX
            AlcY ~ SCp.Int.OutAlcY
            AlcW ~ SCp.Int.OutAlcW
            AlcH ~ SCp.Int.OutAlcH
            CntRqsW ~ Max1
            CntRqsH ~ : TrAdd2Var (
                Inp ~ Next.Int.CntRqsH
                Inp2 ~ Add1
            )
        )
        SCp  (
            Int.InpAlcW ~ SCp.Int.RqsW
            Int.InpAlcH ~ SCp.Int.RqsH
            Int.InpAlcX ~ Next.Int.AlcX
            Int.InpAlcY ~ Add1
        )
    }
    FHLayoutSlot : FSlotLin {
        # " Horisontal layout slot"
        Prev.Int.AlcX ~ SCp.Int.OutAlcX
        Prev.Int.AlcY ~ SCp.Int.OutAlcY
        Prev.Int.AlcW ~ SCp.Int.OutAlcW
        Prev.Int.AlcH ~ SCp.Int.OutAlcH
        SCp.Int.InpAlcW ~ SCp.Int.RqsW
        SCp.Int.InpAlcH ~ SCp.Int.RqsH
        SCp.Int.InpAlcY ~ Next.Int.AlcY
        Add1 : TrAddVar
        SCp.Int.InpAlcX ~ Add1
        Add1.Inp ~ Next.Int.AlcX
        Add1.Inp ~ Next.Int.XPadding
        Add1.Inp ~ Next.Int.AlcW
        Max1 : TrMaxVar
        Prev.Int.CntRqsH ~ Max1
        Max1.Inp ~ Next.Int.CntRqsH
        Max1.Inp ~ SCp.Int.RqsH
    }
    AlignmentSlot : FSlotLin {
        # " Horisontal layout slot"
        Prev.Int.AlcX ~ SCp.Int.OutAlcX
        Prev.Int.AlcY ~ SCp.Int.OutAlcY
        Prev.Int.AlcW ~ SCp.Int.OutAlcW
        Prev.Int.AlcH ~ SCp.Int.OutAlcH
        SCp.Int.InpAlcW ~ SCp.Int.RqsW
        SCp.Int.InpAlcH ~ SCp.Int.RqsH
        AddX : TrAddVar
        SCp.Int.InpAlcX ~ AddX
        AddX.Inp ~ Next.Int.AlcX
        AddX.Inp ~ Next.Int.XPadding
        AddY : TrAddVar
        SCp.Int.InpAlcY ~ AddY
        AddY.Inp ~ Next.Int.AlcY
        AddY.Inp ~ Next.Int.YPadding
        AddCW : TrAddVar
        Prev.Int.CntRqsW ~ AddCW
        AddCW.Inp ~ SCp.Int.RqsW
        AddCW.Inp ~ Next.Int.XPadding
        AddCH : TrAddVar
        Prev.Int.CntRqsH ~ AddCH
        AddCH.Inp ~ SCp.Int.RqsH
        AddCH.Inp ~ Next.Int.YPadding
    }
    # " DES controlled container"
    DcAddWdgSc : Socket2 {
        Enable : CpStateOutp
        Name : CpStateOutp
        Parent : CpStateOutp
        Mut : CpStateOutp
        Pos : CpStateOutp
        Added : CpStateInp
    }
    DcAddWdgS : Socket2 {
        Enable : CpStateInp
        Name : CpStateInp
        Parent : CpStateInp
        Mut : CpStateInp
        Pos : CpStateInp
        Added : CpStateOutp
    }
    DcAddWdgCp : DcAddWdgS {
        Int : DcAddWdgSc
    }
    DcRmWdgSc : Socket2 {
        Enable : CpStateOutp
        Name : CpStateOutp
        Done : CpStateInp
    }
    DcRmWdgS : Socket2 {
        Enable : CpStateInp
        Name : CpStateInp
        Done : CpStateOutp
    }
    DcRmWdgCp : DcRmWdgS {
        Int : DcRmWdgSc
    }
    DContainer : FvWidgets.FWidgetBase {
        CntAgent : AVDContainer
        CntAgent < LogLevel = "Dbg"
        CpExplorable : CpSystExplorable
        # " Internal connections"
        CntAgent.InpFont ~ Font
        CntAgent.InpText ~ SText
        # " Padding value"
        XPadding : State {
            = "SI 1"
        }
        YPadding : State {
            = "SI 1"
        }
        IoAddWidg : DcAddWdgCp
        IoRmWidg : DcRmWdgCp
        # " Adding widget"
        CreateWdg : ASdcComp (
            Enable ~ IoAddWidg.Int.Enable
            Name ~ IoAddWidg.Int.Name
            Parent ~ IoAddWidg.Int.Parent
        )
        SdcMut : ASdcMut (
            Enable ~ CreateWdg.Outp
            Target ~ IoAddWidg.Int.Name
            Mut ~ IoAddWidg.Int.Mut
        )
        AddSlot : ASdcComp (
            Enable ~ IoAddWidg.Int.Enable
            Name ~ AdSlotName : TrApndVar (
                Inp1 ~ SlotNamePref : Const {
                    = "SS Slot_"
                }
                Inp2 ~ IoAddWidg.Int.Name
            )
            Parent ~ SlotParent : State
        )
        _ <  {
            AddSlot_Dbg : State (
                _@ <  {
                    = "SB false"
                    LogLevel = "Dbg"
                }
                Inp ~ AddSlot.Outp
            )
        }
        SdcConnWdg : ASdcConn (
            Enable ~ IoAddWidg.Int.Enable
            Enable ~ CreateWdg.Outp
            Enable ~ AddSlot.Outp
            V1 ~ : TrApndVar (
                Inp1 ~ IoAddWidg.Int.Name
                Inp2 ~ : Const {
                    = "SS .Cp"
                }
            )
            V2 ~ : TrApndVar (
                Inp1 ~ AdSlotName
                Inp2 ~ : Const {
                    = "SS .SCp"
                }
            )
        )
        _ <  {
            ConnWdg_Dbg : State (
                _@ <  {
                    = "SB false"
                    LogLevel = "Dbg"
                }
                Inp ~ SdcConnWdg.Outp
            )
        }
        # " Removing widget"
        SdcExtrSlot : ASdcExtract (
            Enable ~ IoRmWidg.Int.Enable
            Name ~ ExtrSlotName : TrApndVar (
                Inp1 ~ SlotNamePref
                Inp2 ~ IoRmWidg.Int.Name
            )
            Prev ~ : Const {
                = "SS Prev"
            }
            Next ~ : Const {
                = "SS Next"
            }
        )
        RmWdg : ASdcRm (
            Enable ~ IoRmWidg.Int.Enable
            Enable ~ SdcExtrSlot.Outp
            Name ~ IoRmWidg.Int.Name
        )
        RmSlot : ASdcRm (
            Enable ~ IoRmWidg.Int.Enable
            Enable ~ SdcExtrSlot.Outp
            Name ~ ExtrSlotName
        )
        IoRmWidg.Int.Done ~ : TrAndVar (
            Inp ~ RmWdg.Outp
            Inp ~ RmSlot.Outp
            Inp ~ SdcExtrSlot.Outp
        )
    }
    DLinearLayout : DContainer {
        Start : LinStart
        Start.Prev.Int.XPadding ~ XPadding
        Start.Prev.Int.YPadding ~ YPadding
        Start.Prev.Int.LbpComp ~ : State {
            = "URI _INV"
        }
        # "TODO AlcX ~ : SI_0 AlcY ~ : SI_0 ??"
        End : LinEnd
        Cp.Int.LbpUri ~ TLbpUri : TrApndVar (
            _@ < LogLevel = "Dbg"
            Inp1 ~ CntAgent.OutpLbpUri
            Inp2 ~ : TrSvldVar (
                Inp1 ~ End.Next.Int.LbpComp
                Inp2 ~ : State {
                    = "URI"
                }
            )
        )
        _ <  {
            # "TODO to disable"
        }
        SLbpComp_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "URI"
            }
            Inp ~ TLbpUri
        )
        Start.Prev ~ End.Next
        # "Inserting new widget to the end"
        SdcInsert : ASdcInsert2 (
            Enable ~ IoAddWidg.Int.Enable
            Enable ~ CreateWdg.Outp
            Enable ~ AddSlot.Outp
            Name ~ AdSlotName
            Pname ~ : Const {
                = "SS End"
            }
            Prev ~ : Const {
                = "SS Prev"
            }
            Next ~ : Const {
                = "SS Next"
            }
        )
        IoAddWidg.Int.Added ~ SdcInsert.Outp
    }
    DAlignment : DLinearLayout {
        RqsW.Inp ~ End.Next.Int.CntRqsW
        RqsH.Inp ~ End.Next.Int.CntRqsH
        SlotParent < = "SS AlignmentSlot"
    }
    DVLayout : DLinearLayout {
        RqsW.Inp ~ : TrAddVar (
            Inp ~ End.Next.Int.CntRqsW
            Inp ~ : TrMplVar (
                Inp ~ End.Next.Int.XPadding
                Inp ~ : State {
                    = "SI 2"
                }
            )
        )
        RqsH.Inp ~ Add2 : TrAddVar (
            Inp ~ End.Next.Int.AlcY
            Inp ~ End.Next.Int.AlcH
            Inp ~ End.Next.Int.YPadding
        )
        SlotParent < = "SS FVLayoutSlot"
    }
    DHLayout : DLinearLayout {
        RqsW.Inp ~ : TrAddVar (
            Inp ~ End.Next.Int.AlcX
            Inp ~ End.Next.Int.AlcW
            Inp ~ End.Next.Int.XPadding
        )
        RqsH.Inp ~ : TrAddVar (
            Inp ~ End.Next.Int.CntRqsH
            Inp ~ : TrMplVar (
                Inp ~ End.Next.Int.YPadding
                Inp ~ : State {
                    = "SI 2"
                }
            )
        )
        SlotParent < = "SS FHLayoutSlot"
    }
    # ">>> Column layout. Set of the colums of the widgets."
    ColumnsSlotPrevCp : SlotLinPrevCp {
        Pos : CpStateOutp
        Int < Pos : CpStateInp
    }
    ColumnsSlotNextCp : SlotLinNextCp {
        Pos : CpStateInp
        Int < Pos : CpStateOutp
    }
    ColumnsStart : Syst {
        # "Column layout columns start slot"
        Prev : ColumnsSlotPrevCp
        Prev.Int.Pos ~ : SI_1
    }
    ColumnsEnd : Syst {
        # "Column layout columns end slot"
        Next : ColumnsSlotNextCp
    }
    ColumnStart : Syst {
        # "Column layout column slots list start"
        Prev : SlotLinPrevCp {
            ItemPos : CpStateOutp
            ColumnPos : CpStateOutp
            Int <  {
                ItemPos : CpStateInp
                ColumnPos : CpStateInp
            }
        }
    }
    ColumnEnd : Syst {
        # "Column layout column slots list end"
        Next : SlotLinNextCp {
            ItemPos : CpStateInp
            ColumnPos : CpStateInp
            Int <  {
                ItemPos : CpStateOutp
                ColumnPos : CpStateOutp
            }
        }
    }
    ColumnLayoutSlot : Des {
        # "Column layout slot"
        Prev : ColumnsSlotPrevCp
        Next : ColumnsSlotNextCp
        Start : ColumnStart
        End : ColumnEnd
        Start.Prev ~ End.Next
        Start.Prev.Int.AlcX ~ Add1 : TrAdd2Var (
            Inp ~ Next.Int.AlcX
            Inp2 ~ Add1n : TrAdd2Var (
                Inp ~ Next.Int.AlcW
                Inp2 ~ Next.Int.XPadding
            )
        )
        Start.Prev.Int.AlcY ~ Next.Int.AlcY
        Start.Prev.Int.YPadding ~ Next.Int.YPadding
        Start.Prev.Int.CntRqsW ~ : SI_0
        Start.Prev.Int.CntRqsH ~ : SI_0
        # "Using isolated LbpComp chain for column slot"
        Start.Prev.Int.LbpComp ~ : Const {
            = "URI"
        }
        # "Calc container reqs as sum of elems reqs plus paddings"
        Prev.Int.CntRqsW ~ CntRqsW_Dbg : TrAdd2Var (
            Inp ~ End.Next.Int.CntRqsW
            Inp2 ~ CntRqsW_Dbg2 : TrAdd2Var (
                Inp ~ Next.Int.CntRqsW
                Inp2 ~ Next.Int.XPadding
            )
        )
        Prev.Int.CntRqsH ~ MaxCntRqsH : TrMaxVar (
            Inp ~ Next.Int.CntRqsH
            Inp ~ : TrAdd2Var (
                Inp ~ End.Next.Int.CntRqsH
                Inp2 ~ Next.Int.AlcY
            )
        )
        Prev.Int.AlcX ~ Add1
        Prev.Int.AlcY ~ Next.Int.AlcY
        # "Requisite CntRqsW is used as allocation AlcW to represent column width"
        # "This is because the column is not a widget but plays as a widget"
        # "TODO consider more strong design for such pseudo-widgets"
        Prev.Int.AlcW ~ End.Next.Int.CntRqsW
        Prev.Int.AlcH ~ End.Next.Int.CntRqsH
        Prev.Int.XPadding ~ Next.Int.XPadding
        Prev.Int.YPadding ~ Next.Int.YPadding
        # "Using isolated LbpComp chain for column slot"
        Prev.Int.LbpComp ~ LbpCompDbg : TrSvldVar (
            _@ < LogLevel = "Dbg"
            Inp1 ~ Next.Int.LbpComp
            Inp2 ~ End.Next.Int.LbpComp
        )
        SLbpCompDbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "URI"
            }
            Inp ~ End.Next.Int.LbpComp
        )
        Prev.Int.Pos ~ : TrAddVar (
            Inp ~ Next.Int.Pos
            Inp ~ : SI_1
        )
        Start.Prev.Int.ItemPos ~ : SI_0
        Start.Prev.Int.ColumnPos ~ Next.Int.Pos
        _ <  {
            Pos_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SI _INV"
                }
                Inp ~ Next.Int.Pos
            )
        }
        _ <  {
            ItemsCount_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SI _INV"
                }
                Inp ~ End.Next.Int.ItemPos
            )
        }
    }
    ColumnItemSlot : FVLayoutSlot {
        # "Column item slot"
        # "Extend chain CPs for positions io"
        Prev <  {
            ItemPos : CpStateOutp
            ColumnPos : CpStateOutp
            Int <  {
                ItemPos : CpStateInp
                ColumnPos : CpStateInp
            }
        }
        Next <  {
            ItemPos : CpStateInp
            ColumnPos : CpStateInp
            Int <  {
                ItemPos : CpStateOutp
                ColumnPos : CpStateOutp
            }
        }
        Prev.Int.ItemPos ~ : TrAddVar (
            Inp ~ Next.Int.ItemPos
            Inp ~ : SI_1
        )
        Prev.ColumnPos ~ Next.ColumnPos
    }
    ClAddColumnSSc : Socket2 {
        Enable : CpStateOutp
        Name : CpStateOutp
        # " Position: bool, false - start, true - end. Not used ATM"
        # "Pos : CpStateOutp"
        Done : CpStateInp
    }
    ClAddColumnSS : Socket2 {
        Enable : CpStateInp
        Name : CpStateInp
        # "Pos : CpStateInp"
        Done : CpStateOutp
    }
    ClAddColumnS : ClAddColumnSS {
        Int : ClAddColumnSSc
    }
    ClAddColumnSm : ClAddColumnSSc {
        Int : ClAddColumnSS
    }
    ClReposWdgSS : Socket2 {
        Enable : CpStateOutp
        Name : CpStateOutp
        # "New column pos"
        ColPos : CpStateOutp
        Done : CpStateInp
    }
    ClReposWdgSmS : Socket2 {
        Enable : CpStateInp
        Name : CpStateInp
        # "New column pos"
        ColPos : CpStateInp
        Done : CpStateOutp
    }
    ClReposWdgS : ClReposWdgSmS {
        Int : ClReposWdgSS
    }
    ClReposWdgSm : ClReposWdgSS {
        Int : ClReposWdgSmS
    }
    ColumnsLayout : DContainer {
        # ">>> Columns layout"
        # "IO"
        # "   Adding column to the left"
        IoAddColumn : ClAddColumnS
        # "   Repositioning widget"
        IoReposWdg : ClReposWdgS
        # "Constants"
        KS_Prev : Const {
            = "SS Prev"
        }
        KS_Next : Const {
            = "SS Next"
        }
        KSStart : Const {
            = "SS Start"
        }
        KSEnd : Const {
            = "SS End"
        }
        KU_Start : Const {
            = "URI Start"
        }
        KU_End : Const {
            = "URI End"
        }
        KU_Next : Const {
            = "URI Next"
        }
        KU_Prev : Const {
            = "URI Prev"
        }
        # "Paremeters"
        ColumnSlotParent : Const {
            = "SS ColumnLayoutSlot"
        }
        Start : ColumnsStart
        Start.Prev.Int.XPadding ~ XPadding
        Start.Prev.Int.YPadding ~ YPadding
        Start.Prev.Int.AlcX ~ XPadding
        Start.Prev.Int.AlcY ~ YPadding
        Start.Prev.Int.CntRqsW ~ : SI_0
        Start.Prev.Int.CntRqsH ~ YPadding
        Start.Prev.Int.AlcW ~ : SI_0
        Start.Prev.Int.AlcH ~ : SI_0
        Start.Prev.Int.LbpComp ~ : State {
            = "URI"
        }
        End : ColumnsEnd
        # "Requisites"
        RqsW.Inp ~ End.Next.Int.CntRqsW
        RqsH.Inp ~ End.Next.Int.CntRqsH
        ColumnsCount : ExtdStateOutp (
            Int ~ End.Next.Int.Pos
        )
        SlotParent < = "SS ColumnItemSlot"
        Cp.Int.LbpUri ~ TLbpUri : TrApndVar (
            Inp1 ~ CntAgent.OutpLbpUri
            Inp2 ~ : TrSvldVar (
                Inp1 ~ End.Next.Int.LbpComp
                Inp2 ~ : State {
                    = "URI"
                }
            )
        )
        _ <  {
            SLbpComp_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "URI"
                }
                Inp ~ TLbpUri
            )
        }
        Start.Prev ~ End.Next
        # "Pair of columns end"
        EndPair : SdoPair (
            _@ < LogLevel = "Dbg"
            Vp ~ : Const {
                = "SS End.Next"
            }
        )
        _ <  {
            Dbg_EndPair : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "URI _INV"
                }
                Inp ~ EndPair
            )
        }
        FirstColumn : SdoCompOwner (
            Comp ~ : SdoTcPair (
                Targ ~ KU_Start
                TargComp ~ KU_Prev
            )
        )
        _ <  {
            FirstColumn_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "URI _INV"
                }
                Inp ~ FirstColumn
            )
        }
        Cmp_Neq_1 : TrCmpVar (
            Inp ~ EndPair
            Inp2 ~ : Const {
                = "URI Start.Prev"
            }
        )
        _ <  {
            Dbg_Neq_1 : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SB _INV"
                }
                Inp ~ Cmp_Neq_1
            )
        }
        LastColumn : SdoCompOwner (
            Comp ~ EndPair
        )
        _ <  {
            Dbg_LastColumn : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "URI _INV"
                }
                Inp ~ LastColumn
            )
        }
        _ <  {
            LastColumnEnd : SdoCompComp (
                _@ < LogLevel = "Dbg"
                Comp ~ LastColumn
                CompComp ~ : State {
                    = "URI End"
                }
            )
        }
        LastColumnEnd : TrApndVar (
            Inp1 ~ LastColumn
            Inp2 ~ KU_End
        )
        _ <  {
            Dbg_LastColumnEnd : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "URI _INV"
                }
                Inp ~ LastColumnEnd
            )
        }
        ColToInsertWdg : DesUtils.ListItemByPos (
            InpPos ~ IoAddWidg.Int.Pos
            Subsys.CpExploring ~ CpExplorable
        )
        _ <  {
            ColToInsertWdgEnd : SdoCompComp (
                _@ < LogLevel = "Dbg"
                Comp ~ ColToInsertWdg.OutpNode
                CompComp ~ KU_End
            )
        }
        ColToInsertWdgEnd : TrApndVar (
            Inp1 ~ ColToInsertWdg.OutpNode
            Inp2 ~ KU_End
        )
        _ <  {
            ColToInsertWdgEnd_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "URI _INV"
                }
                Inp ~ ColToInsertWdgEnd
            )
        }
        # "Inserting new widget to the end of given column"
        SdcInsert : ASdcInsert2 (
            Enable ~ IoAddWidg.Int.Enable
            Enable ~ CreateWdg.Outp
            Enable ~ AddSlot.Outp
            # "Name ~ AddSlot.OutpName;"
            Name ~ AdSlotName
            Pname ~ : TrTostrVar (
                Inp ~ ColToInsertWdgEnd
                # "Inp ~ LastColumnEnd"
            )
            Prev ~ KS_Prev
            Next ~ KS_Next
        )
        IoAddWidg.Int.Added ~ SdcInsert.Outp
        # ">>> Adding column"
        # "  Creating column slot"
        CreateColSlot : ASdcComp (
            _@ < LogLevel = "Dbg"
            Enable ~ IoAddColumn.Int.Enable
            Name ~ IoAddColumn.Int.Name
            Parent ~ ColumnSlotParent
        )
        _ <  {
            CreateColSlot_Dbg : State (
                _@ <  {
                    = "SB false"
                    LogLevel = "Dbg"
                }
                Inp ~ CreateColSlot.Outp
            )
        }
        # "  Inserting column slot"
        SdcInsertColE : ASdcInsert2 (
            _@ < LogLevel = "Dbg"
            Enable ~ IoAddColumn.Int.Enable
            Enable ~ CreateColSlot.Outp
            # "Enable ~ IoAddColumn.Int.Pos"
            Name ~ IoAddColumn.Int.Name
            Pname ~ KSEnd
            Prev ~ KS_Prev
            Next ~ KS_Next
        )
        IoAddColumn.Int.Done ~ SdcInsertColE.Outp
        # "<<< Adding column"
        {
            # ">>> Reposition widget"
            # "   Extract"
            SdcReposExtrSlot : ASdcExtract (
                _@ < LogLevel = "Dbg"
                Enable ~ IoReposWdg.Int.Enable
                Name ~ ReposSlotName : TrApndVar (
                    Inp1 ~ SlotNamePref
                    Inp2 ~ IoReposWdg.Int.Name
                )
                Prev ~ KS_Prev
                Next ~ KS_Next
            )
            # "   Insert"
            _ <  {
                ColToReposWdg : DesUtils.ListItemByPos (
                    InpPos ~ IoReposWdg.Int.ColPos
                    InpMagLink ~ _$
                )
            }
            ColToReposWdg : TrApndVar (
                Inp1 ~ : Const {
                    = "SS Column_"
                }
                Inp2 ~ : TrTostrVar (
                    Inp ~ : TrAddVar (
                        Inp ~ IoReposWdg.Int.ColPos
                        InpN ~ : SI_1
                    )
                )
            )
            _ <  {
                ColToReposWdgEnd : SdoCompComp (
                    Comp ~ : TrToUriVar (
                        Inp ~ ColToReposWdg
                    )
                    CompComp ~ KU_End
                )
            }
            ColToReposWdgEnd : TrApndVar (
                Inp1 ~ : TrToUriVar (
                    Inp ~ ColToReposWdg
                )
                Inp2 ~ KU_End
            )
            _ <  {
                ColToReposWdgEnd_Dbg : State (
                    _@ <  {
                        = "URL _INV"
                        LogLevel = "Dbg"
                    }
                    Inp ~ ColToReposWdgEnd
                )
            }
            SdcReposInsertSlot : ASdcInsert2 (
                _@ < LogLevel = "Dbg"
                # "Enable ~ IoReposWdg.Int.Enable"
                Enable ~ SdcReposExtrSlot.Outp
                Name ~ ReposSlotName
                Pname ~ : TrTostrVar (
                    Inp ~ ColToReposWdgEnd
                )
                Prev ~ KS_Prev
                Next ~ KS_Next
            )
            IoReposWdg.Int.Done ~ SdcReposInsertSlot.Outp
            # "<<< Reposition widget"
        }
        # "<<< Columns layout"
    }
}
