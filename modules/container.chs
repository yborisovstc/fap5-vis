ContainerMod : Elem {
    # "TODO To have Start and End as specific slots with CPs"
    About = "FAP3 widget visualization system"
    + FvWidgets
    + DesUtils
    SlotCp : Socket {
        InpAlcX : CpStateInpPin
        InpAlcY : CpStateInpPin
        InpAlcW : CpStateInpPin
        InpAlcH : CpStateInpPin
        OutAlcX : CpStateOutpPin
        OutAlcY : CpStateOutpPin
        OutAlcW : CpStateOutpPin
        OutAlcH : CpStateOutpPin
        RqsW : CpStateOutpPin
        RqsH : CpStateOutpPin
        LbpUri : CpStateOutpPin
    }
    SlotLinNextCp : Socket {
        AlcX : CpStateOutpPin
        AlcY : CpStateOutpPin
        AlcW : CpStateOutpPin
        AlcH : CpStateOutpPin
        CntRqsW : CpStateOutpPin
        CntRqsH : CpStateOutpPin
        XPadding : CpStateOutpPin
        YPadding : CpStateOutpPin
        LbpComp : CpStateOutpPin
    }
    SlotLinPrevCp : Socket {
        AlcX : CpStateInpPin
        AlcY : CpStateInpPin
        AlcW : CpStateInpPin
        AlcH : CpStateInpPin
        CntRqsW : CpStateInpPin
        CntRqsH : CpStateInpPin
        XPadding : CpStateInpPin
        YPadding : CpStateInpPin
        LbpComp : CpStateInpPin
    }
    FSlot : Syst {
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
        Prev.XPadding ~ Next.XPadding
        Prev.YPadding ~ Next.YPadding
        Prev.LbpComp ~ LbpCompDbg : TrSvldVar (
            Inp1 ~ Next.LbpComp
            Inp2 ~ SCp.LbpUri
        )
    }
    FVLayoutSlot : FSlotLin {
        # " Vertical layout slot"
        Add1 : TrAddVar (
            Inp ~ Next.AlcY
            Inp ~ Next.YPadding
            Inp ~ Next.AlcH
        )
        Max1 : TrMaxVar (
            Inp ~ Next.CntRqsW
            Inp ~ SCp.RqsW
        )
        Prev  (
            AlcX ~ SCp.OutAlcX
            AlcY ~ SCp.OutAlcY
            AlcW ~ SCp.OutAlcW
            AlcH ~ SCp.OutAlcH
            CntRqsW ~ Max1
            CntRqsH ~ : TrAdd2Var (
                Inp ~ Next.CntRqsH
                Inp2 ~ Add1
            )
        )
        SCp  (
            InpAlcW ~ SCp.RqsW
            InpAlcH ~ SCp.RqsH
            InpAlcX ~ Next.AlcX
            InpAlcY ~ Add1
        )
    }
    FHLayoutSlot : FSlotLin {
        # " Horisontal layout slot"
        Prev.AlcX ~ SCp.OutAlcX
        Prev.AlcY ~ SCp.OutAlcY
        Prev.AlcW ~ SCp.OutAlcW
        Prev.AlcH ~ SCp.OutAlcH
        SCp.InpAlcW ~ SCp.RqsW
        SCp.InpAlcH ~ SCp.RqsH
        SCp.InpAlcY ~ Next.AlcY
        Add1 : TrAddVar
        SCp.InpAlcX ~ Add1
        Add1.Inp ~ Next.AlcX
        Add1.Inp ~ Next.XPadding
        Add1.Inp ~ Next.AlcW
        Max1 : TrMaxVar
        Prev.CntRqsH ~ Max1
        Max1.Inp ~ Next.CntRqsH
        Max1.Inp ~ SCp.RqsH
    }
    AlignmentSlot : FSlotLin {
        # " Horisontal layout slot"
        Prev.AlcX ~ SCp.OutAlcX
        Prev.AlcY ~ SCp.OutAlcY
        Prev.AlcW ~ SCp.OutAlcW
        Prev.AlcH ~ SCp.OutAlcH
        SCp.InpAlcW ~ SCp.RqsW
        SCp.InpAlcH ~ SCp.RqsH
        AddX : TrAddVar
        SCp.InpAlcX ~ AddX
        AddX.Inp ~ Next.AlcX
        AddX.Inp ~ Next.XPadding
        AddY : TrAddVar
        SCp.InpAlcY ~ AddY
        AddY.Inp ~ Next.AlcY
        AddY.Inp ~ Next.YPadding
        AddCW : TrAddVar
        Prev.CntRqsW ~ AddCW
        AddCW.Inp ~ SCp.RqsW
        AddCW.Inp ~ Next.XPadding
        AddCH : TrAddVar
        Prev.CntRqsH ~ AddCH
        AddCH.Inp ~ SCp.RqsH
        AddCH.Inp ~ Next.YPadding
    }
    # " DES controlled container"
    DcAddWdgS : Socket {
        Enable : CpStateOutpPin
        Name : CpStateOutpPin
        Parent : CpStateOutpPin
        Mut : CpStateOutpPin
        Pos : CpStateOutpPin
        Added : CpStateInpPin
        # "TODO not used, remove"
        AddedName : CpStateInpPin
    }
    DcAddWdgSc : Socket {
        Enable : CpStateInpPin
        Name : CpStateInpPin
        Parent : CpStateInpPin
        Mut : CpStateInpPin
        Pos : CpStateInpPin
        Added : CpStateOutpPin
        AddedName : CpStateOutpPin
    }
    DcRmWdgS : Socket {
        Enable : CpStateOutpPin
        Name : CpStateOutpPin
        Done : CpStateInpPin
    }
    DcRmWdgSc : Socket {
        Enable : CpStateInpPin
        Name : CpStateInpPin
        Done : CpStateOutpPin
    }
    DContainer : FvWidgets.FWidgetBase {
        CntAgent : AVDContainer
        CntAgent < LogLevel = "Dbg"
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
        IoAddWidg : DcAddWdgS
        IoRmWidg : DcRmWdgS
        # " Adding widget"
        CreateWdg : ASdcComp (
            Enable ~ IoAddWidg.Enable
            Name ~ IoAddWidg.Name
            Parent ~ IoAddWidg.Parent
        )
        SdcMut : ASdcMut (
            Enable ~ CreateWdg.Outp
            Target ~ IoAddWidg.Name
            Mut ~ IoAddWidg.Mut
        )
        AddSlot : ASdcComp (
            Enable ~ IoAddWidg.Enable
            Name ~ AdSlotName : TrApndVar (
                Inp1 ~ SlotNamePref : Const {
                    = "SS Slot_"
                }
                Inp2 ~ IoAddWidg.Name
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
            Enable ~ IoAddWidg.Enable
            Enable ~ CreateWdg.Outp
            Enable ~ AddSlot.Outp
            V1 ~ : TrApndVar (
                Inp1 ~ IoAddWidg.Name
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
            Enable ~ IoRmWidg.Enable
            Name ~ ExtrSlotName : TrApndVar (
                Inp1 ~ SlotNamePref
                Inp2 ~ IoRmWidg.Name
            )
            Prev ~ : Const {
                = "SS Prev"
            }
            Next ~ : Const {
                = "SS Next"
            }
        )
        RmWdg : ASdcRm (
            Enable ~ IoRmWidg.Enable
            Enable ~ SdcExtrSlot.Outp
            Name ~ IoRmWidg.Name
        )
        RmSlot : ASdcRm (
            Enable ~ IoRmWidg.Enable
            Enable ~ SdcExtrSlot.Outp
            Name ~ ExtrSlotName
        )
        IoRmWidg.Done ~ : TrAndVar (
            Inp ~ RmWdg.Outp
            Inp ~ RmSlot.Outp
            Inp ~ SdcExtrSlot.Outp
        )
    }
    DLinearLayout : DContainer {
        Start : LinStart
        Start.Prev.XPadding ~ XPadding
        Start.Prev.YPadding ~ YPadding
        Start.Prev.LbpComp ~ : State {
            = "URI _INV"
        }
        # "TODO AlcX ~ : SI_0 AlcY ~ : SI_0 ??"
        End : LinEnd
        Cp.LbpUri ~ TLbpUri : TrApndVar (
            Inp1 ~ CntAgent.OutpLbpUri
            Inp2 ~ : TrSvldVar (
                Inp1 ~ End.Next.LbpComp
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
        # "Inserting new widget to the end"
        SdcInsert : ASdcInsert2 (
            Enable ~ IoAddWidg.Enable
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
        IoAddWidg.Added ~ SdcInsert.Outp
    }
    DAlignment : DLinearLayout {
        RqsW.Inp ~ End.Next.CntRqsW
        RqsH.Inp ~ End.Next.CntRqsH
        SlotParent < = "SS AlignmentSlot"
    }
    DVLayout : DLinearLayout {
        RqsW.Inp ~ : TrAddVar (
            Inp ~ End.Next.CntRqsW
            Inp ~ : TrMplVar (
                Inp ~ End.Next.XPadding
                Inp ~ : State {
                    = "SI 2"
                }
            )
        )
        RqsH.Inp ~ Add2 : TrAddVar (
            Inp ~ End.Next.AlcY
            Inp ~ End.Next.AlcH
            Inp ~ End.Next.YPadding
        )
        SlotParent < = "SS FVLayoutSlot"
    }
    DHLayout : DLinearLayout {
        RqsW.Inp ~ : TrAddVar (
            Inp ~ End.Next.AlcX
            Inp ~ End.Next.AlcW
            Inp ~ End.Next.XPadding
        )
        RqsH.Inp ~ : TrAddVar (
            Inp ~ End.Next.CntRqsH
            Inp ~ : TrMplVar (
                Inp ~ End.Next.YPadding
                Inp ~ : State {
                    = "SI 2"
                }
            )
        )
        SlotParent < = "SS FHLayoutSlot"
    }
    # ">>> Column layout. Set of the colums of the widgets."
    ColumnsSlotPrevCp : SlotLinPrevCp {
        Pos : CpStateInpPin
    }
    ColumnsSlotNextCp : SlotLinNextCp {
        Pos : CpStateOutpPin
    }
    ColumnsStart : Syst {
        # "Column layout columns start slot"
        Prev : ColumnsSlotPrevCp
        Prev.Pos ~ : SI_1
    }
    ColumnsEnd : Syst {
        # "Column layout columns end slot"
        Next : ColumnsSlotNextCp
    }
    ColumnStart : Syst {
        # "Column layout column slots list start"
        Prev : SlotLinPrevCp {
            ItemPos : CpStateInpPin
            ColumnPos : CpStateInpPin
        }
    }
    ColumnEnd : Syst {
        # "Column layout column slots list end"
        Next : SlotLinNextCp {
            ItemPos : CpStateOutpPin
            ColumnPos : CpStateOutpPin
        }
    }
    ColumnLayoutSlot : Des {
        # "Column layout slot"
        Prev : ColumnsSlotPrevCp
        Next : ColumnsSlotNextCp
        Start : ColumnStart
        End : ColumnEnd
        Start.Prev ~ End.Next
        Start.Prev.AlcX ~ Add1 : TrAdd2Var (
            Inp ~ Next.AlcX
            Inp2 ~ Add1n : TrAdd2Var (
                Inp ~ Next.AlcW
                Inp2 ~ Next.XPadding
            )
        )
        Start.Prev.AlcY ~ Next.AlcY
        Start.Prev.YPadding ~ Next.YPadding
        Start.Prev.CntRqsW ~ : SI_0
        Start.Prev.CntRqsH ~ : SI_0
        # "Using isolated LbpComp chain for column slot"
        Start.Prev.LbpComp ~ : Const {
            = "URI"
        }
        # "Calc container reqs as sum of elems reqs plus paddings"
        Prev.CntRqsW ~ CntRqsW_Dbg : TrAdd2Var (
            Inp ~ End.Next.CntRqsW
            Inp2 ~ CntRqsW_Dbg2 : TrAdd2Var (
                Inp ~ Next.CntRqsW
                Inp2 ~ Next.XPadding
            )
        )
        Prev.CntRqsH ~ MaxCntRqsH : TrMaxVar (
            Inp ~ Next.CntRqsH
            Inp ~ : TrAdd2Var (
                Inp ~ End.Next.CntRqsH
                Inp2 ~ Next.AlcY
            )
        )
        Prev.AlcX ~ Add1
        Prev.AlcY ~ Next.AlcY
        # "Requisite CntRqsW is used as allocation AlcW to represent column width"
        # "This is because the column is not a widget but plays as a widget"
        # "TODO consider more strong design for such pseudo-widgets"
        Prev.AlcW ~ End.Next.CntRqsW
        Prev.AlcH ~ End.Next.CntRqsH
        Prev.XPadding ~ Next.XPadding
        Prev.YPadding ~ Next.YPadding
        # "Using isolated LbpComp chain for column slot"
        Prev.LbpComp ~ LbpCompDbg : TrSvldVar (
            _@ < LogLevel = "Dbg"
            Inp1 ~ Next.LbpComp
            Inp2 ~ End.Next.LbpComp
        )
        SLbpCompDbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "URI"
            }
            Inp ~ End.Next.LbpComp
        )
        Prev.Pos ~ : TrAddVar (
            Inp ~ Next.Pos
            Inp ~ : SI_1
        )
        Start.Prev.ItemPos ~ : SI_0
        Start.Prev.ColumnPos ~ Next.Pos
        _ <  {
            Pos_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SI _INV"
                }
                Inp ~ Next.Pos
            )
        }
        _ <  {
            ItemsCount_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SI _INV"
                }
                Inp ~ End.Next.ItemPos
            )
        }
    }
    ColumnItemSlot : FVLayoutSlot {
        # "Column item slot"
        # "Extend chain CPs for positions io"
        Prev <  {
            ItemPos : CpStateInpPin
            ColumnPos : CpStateInpPin
        }
        Next <  {
            ItemPos : CpStateOutpPin
            ColumnPos : CpStateOutpPin
        }
        Prev.ItemPos ~ : TrAddVar (
            Inp ~ Next.ItemPos
            Inp ~ : SI_1
        )
        Prev.ColumnPos ~ Next.ColumnPos
    }
    ClAddColumnS : Socket {
        Enable : CpStateOutpPin
        Name : CpStateOutpPin
        # " Position: bool, false - start, true - end. Not used ATM"
        # "Pos : CpStateOutp"
        Done : CpStateInpPin
    }
    ClAddColumnSm : Socket {
        Enable : CpStateInpPin
        Name : CpStateInpPin
        # "Pos : CpStateInp"
        Done : CpStateOutpPin
    }
    ClReposWdgS : Socket {
        Enable : CpStateOutpPin
        Name : CpStateOutpPin
        # "New column pos"
        ColPos : CpStateOutpPin
        Done : CpStateInpPin
    }
    ClReposWdgSm : Socket {
        Enable : CpStateInpPin
        Name : CpStateInpPin
        # "New column pos"
        ColPos : CpStateInpPin
        Done : CpStateOutpPin
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
        Start.Prev.XPadding ~ XPadding
        Start.Prev.YPadding ~ YPadding
        Start.Prev.AlcX ~ XPadding
        Start.Prev.AlcY ~ YPadding
        Start.Prev.CntRqsW ~ : SI_0
        Start.Prev.CntRqsH ~ YPadding
        Start.Prev.AlcW ~ : SI_0
        Start.Prev.AlcH ~ : SI_0
        Start.Prev.LbpComp ~ : State {
            = "URI"
        }
        End : ColumnsEnd
        # "Requisites"
        RqsW.Inp ~ End.Next.CntRqsW
        RqsH.Inp ~ End.Next.CntRqsH
        ColumnsCount : ExtdStateOutp (
            Int ~ End.Next.Pos
        )
        SlotParent < = "SS ColumnItemSlot"
        Cp.LbpUri ~ TLbpUri : TrApndVar (
            Inp1 ~ CntAgent.OutpLbpUri
            Inp2 ~ : TrSvldVar (
                Inp1 ~ End.Next.LbpComp
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
            InpPos ~ IoAddWidg.Pos
            InpMagLink ~ _$
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
            Enable ~ IoAddWidg.Enable
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
        IoAddWidg.Added ~ SdcInsert.Outp
        # ">>> Adding column"
        # "  Creating column slot"
        CreateColSlot : ASdcComp (
            _@ < LogLevel = "Dbg"
            Enable ~ IoAddColumn.Enable
            Name ~ IoAddColumn.Name
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
            Enable ~ IoAddColumn.Enable
            Enable ~ CreateColSlot.Outp
            # "Enable ~ IoAddColumn.Pos"
            Name ~ IoAddColumn.Name
            Pname ~ KSEnd
            Prev ~ KS_Prev
            Next ~ KS_Next
        )
        IoAddColumn.Done ~ SdcInsertColE.Outp
        # "<<< Adding column"
        {
            # ">>> Reposition widget"
            # "   Extract"
            SdcReposExtrSlot : ASdcExtract (
                _@ < LogLevel = "Dbg"
                Enable ~ IoReposWdg.Enable
                Name ~ ReposSlotName : TrApndVar (
                    Inp1 ~ SlotNamePref
                    Inp2 ~ IoReposWdg.Name
                )
                Prev ~ KS_Prev
                Next ~ KS_Next
            )
            # "   Insert"
            _ <  {
                ColToReposWdg : DesUtils.ListItemByPos (
                    InpPos ~ IoReposWdg.ColPos
                    InpMagLink ~ _$
                )
            }
            ColToReposWdg : TrApndVar (
                Inp1 ~ : Const {
                    = "SS Column_"
                }
                Inp2 ~ : TrTostrVar (
                    Inp ~ : TrAddVar (
                        Inp ~ IoReposWdg.ColPos
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
                # "Enable ~ IoReposWdg.Enable"
                Enable ~ SdcReposExtrSlot.Outp
                Name ~ ReposSlotName
                Pname ~ : TrTostrVar (
                    Inp ~ ColToReposWdgEnd
                )
                Prev ~ KS_Prev
                Next ~ KS_Next
            )
            IoReposWdg.Done ~ SdcReposInsertSlot.Outp
            # "<<< Reposition widget"
        }
        # "<<< Columns layout"
    }
}
