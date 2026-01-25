AvrMdl2 : Elem {
    # "Model visual representations. Ver.02. Based on SDC approach."
    About = "Agents visual representations"
    + FvWidgets
    + ContainerMod
    + DesUtils
    CrpBase : ContainerMod.DVLayout {
        # "CRP v.3 DES controlled, base. Head, no body"
        CntAgent <  {
            LogLevel = "Dbg"
        }
        # "CRP context"
        CrpCtx : DesCtxCsm {
            LogLevel = "Dbg"
            ModelMntp : ExtdSystExplorable
            DrpMagUri : ExtdStateOutp
        }
        SCrpCtx_Dbg_MagUri : State (
            _@ <  {
                LogLevel = "Dbg"
                = "URI"
            }
            Inp ~ CrpCtx.DrpMagUri
        )
        # "Visualization paremeters"
        VisPars : Des {
            Border : State {
                = "SB true"
            }
        }
        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.0 0.7 1.0"
        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
        # "Managed agent (node) adapter - MAG adapter"
        MagAdp : DAdp (
            _@ <  {
                LogLevel = "Dbg"
                Name : SdoName
                Parent : SdoParent
            }
            CpExploring ~ CrpCtx.ModelMntp
            InpMagUri ~ MagAdpMUri : TrApndVar (
                _@ < LogLevel = "Dbg"
                Inp1 ~ CrpCtx.DrpMagUri
                Inp2 ~ : TrToUriVar (
                    Inp ~ : SdoName
                )
            )
        )
        Name_Dbg : State (
            _@ <  {
                = "SS _INV"
                LogLevel = "Dbg"
            }
            Inp ~ MagAdp.Name
        )
        # ""
        End.Next !~ Start.Prev
        YPadding < = "SI 1"
        Header : ContainerMod.DHLayout {
            CntAgent < LogLevel = "Err"
            # "Visualization paremeters"
            VisPars : Des {
                Border : State {
                    = "SB true"
                }
            }
            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
            End.Next !~ Start.Prev
            Name : FvWidgets.FLabel {
                WdgAgent < LogLevel = "Err"
                BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.0 0.7 1.0"
                FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 1.0"
            }
            Slot_Name : ContainerMod.FHLayoutSlot (
                Next ~ Start.Prev
                SCp ~ Name.Cp
            )
            Parent : FvWidgets.FLabel {
                WdgAgent < LogLevel = "Err"
                BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.0 0.7 0.0"
                FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
            }
            Slot_Parent : ContainerMod.FHLayoutSlot (
                Next ~ Slot_Name.Prev
                Prev ~ End.Next
                SCp ~ Parent.Cp
            )
        }
        Header.Name.SText.Inp ~ MagAdp.Name
        Header.Parent.SText.Inp ~ MagAdp.Parent
        Slot_Header : ContainerMod.FVLayoutSlot (
            Next ~ Start.Prev
            SCp ~ Header.Cp
        )
    }
    NodeCrp3 : CrpBase {
        # "Node CRP v.3 DES controlled. Empty body"
        Body : FvWidgets.FLabel {
            WdgAgent < LogLevel = "Err"
            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.0 1.0 0.0"
            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
            SText < = "SS _INV"
        }
        Slot_Body : ContainerMod.FVLayoutSlot (
            Next ~ Slot_Header.Prev
            Prev ~ End.Next
            SCp ~ Body.Cp
        )
    }
    NDrpS : Socket3 {
        # "Node DRP output socket"
        InpModelUri : CpStateInp
        InpModelMntp : CpSystExploring
    }
    NDrpSc : Socket3 {
        # "Node DRP output socket"
        InpModelUri : CpStateOutp
        InpModelMntp : CpSystExplorable
    }
    _ <  {
        NodeDrp : ContainerMod.DHLayout {
            # ">>> Node detail representation"
            # "DRP context"
            DrpCtx : DesCtxCsm {
                ModelMntp : ExtdSystExploring
                DrpMagUri : ExtdStateOutp
            }
            # "Misc"
            XPadding < = "SI 10"
            YPadding < = "SI 5"
            # "Managed agent (node) adapter - MAG adapter"
            MagAdp : DAdp (
                _@ < LogLevel = "Dbg"
                _@ <  {
                    Name : SdoName
                    CompsCount : SdoCompsCount
                    CompNames : SdoCompsNames
                }
                CpExploring ~ DrpCtx.ModelMntp
                InpMagUri ~ DrpCtx.DrpMagUri
            )
            # "CRP context"
            CrpCtx : DesCtxSpl (
                _@ <  {
                    ModelMntp : ExtdSystExploring
                    DrpMagUri : ExtdStateInp
                }
                ModelMntp ~ DrpCtx.ModelMntp
                DrpMagUri ~ MagAdp.OutpMagUri
            )
            # "Comp names debugging"
            CmpNamesDbg : State (
                Inp ~ MagAdp.CompNames
                _@ < LogLevel = "Dbg"
            )
            CmpCountDbg : State (
                _@ <  {
                    = "SI -1"
                    LogLevel = "Dbg"
                }
                Inp ~ MagAdp.CompsCount
            )
            # " Add wdg controlling Cp"
            CpAddCrp : ContainerMod.DcAddWdgCp
            CpAddCrp.Int ~ IoAddWidg
            SCrpCreated_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SB false"
                }
                Inp ~ CpAddCrp.Added
            )
            CompsIdx : State (
                # "Iterator of MAG component"
                _@ <  {
                    = "SI 0"
                    LogLevel = "Dbg"
                }
                Inp ~ : TrSwitchBool (
                    LogLevel = "Dbg"
                    Sel ~ CidxAnd1 : TrAndVar (
                        Inp ~ Cmp_Gt : TrCmpVar (
                            Inp ~ : TrAddVar (
                                Inp ~ MagAdp.CompsCount
                                InpN ~ : State {
                                    = "SI 1"
                                }
                            )
                            Inp2 ~ CompsIdx
                            _@ < LogLevel = "Dbg"
                        )
                        Inp ~ CpAddCrp.Added
                        # "Second Inp connection after SdcConnCrpAdp"
                    )
                    Inp1 ~ CompsIdx
                    Inp2 ~ : TrAddVar (
                        Inp ~ CompsIdx
                        Inp ~ : State {
                            = "SI 1"
                        }
                    )
                )
            )
            CompNameDbg : State {
                = "SS _INV"
                LogLevel = "Dbg"
            }
            CompNameDbg.Inp ~ CompName : TrAtVar (
                Inp ~ MagAdp.CompNames
                Index ~ CompsIdx
            )
            # " CRP creation"
            CpAddCrp.Name ~ CompName
            CpAddCrp.Parent ~ : State {
                = "SS NodeCrp3"
            }
            CpAddCrp.Enable ~ CmpCn_Ge : TrCmpVar (
                Inp ~ MagAdp.CompsCount
                Inp2 ~ : State {
                    = "SI 1"
                }
            )
            # "<<< Node detail representation"
        }
    }
    VtStartSlot : Syst {
        # "VertDRP vertical tunnel slot. Start Comp slot."
        Prev : ContainerMod.SlotLinPrevCp {
            ItemPos : CpStateOutp
            ColumnPos : CpStateOutp
        }
    }
    VtEndSlot : Syst {
        # "VertDRP vertical tunnel slot. End Comp slot."
        Next : ContainerMod.SlotLinNextCp {
            ItemPos : CpStateInp
            ColumnPos : CpStateInp
        }
    }
    VertDrpVtSlot : Syst {
        # "VertDRP vertical tunnel slot"
        Prev : ContainerMod.SlotLinPrevCp {
            Pos : CpStateOutp
        }
        Next : ContainerMod.SlotLinNextCp {
            Pos : CpStateInp
        }
        Prev.Int.XPadding ~ Next.Int.XPadding
        Prev.Int.YPadding ~ Next.Int.YPadding
        Prev.Int.Pos ~ Next.Int.Pos
        Start : VtStartSlot
        End : VtEndSlot
        Start.Prev ~ End.Next
        Start.Prev.Int.AlcX ~ AddAlcX : TrAddVar (
            _@ < LogLevel = "Dbg"
            Inp ~ Next.Int.AlcX
            Inp ~ Next.Int.AlcW
            Inp ~ Next.Int.XPadding
        )
        Start.Prev.Int.AlcY ~ Next.Int.AlcY
        Start.Prev.Int.AlcW ~ : SI_0
        Start.Prev.Int.AlcH ~ : SI_0
        Start.Prev.Int.XPadding ~ Next.Int.XPadding
        Start.Prev.Int.YPadding ~ Next.Int.YPadding
        # "We calculate CntRqsW separately for this slot to use if as RqsW of the slot"
        Start.Prev.Int.CntRqsW ~ : SI_0
        Start.Prev.Int.CntRqsH ~ : SI_0
        Start.Prev.Int.ColumnPos ~ Next.Int.Pos
        Start.Prev.Int.ItemPos ~ : SI_0
        Start.Prev.Int.LbpComp ~ : Const {
            = "URI"
        }
        Prev.Int.AlcX ~ AddAlcX
        Prev.Int.AlcY ~ Next.Int.AlcY
        # "Slot is not widget, so we use slot AlcW pin just to conn CntRqsW of slot"
        Prev.Int.AlcW ~ End.Next.Int.CntRqsW
        Prev.Int.AlcH ~ End.Next.Int.CntRqsH
        Prev.Int.CntRqsW ~ VtCntRqsW_Dbg : TrAdd2Var (
            Inp ~ End.Next.Int.CntRqsW
            Inp2 ~ VtCntRqsW_Dbg2 : TrAdd2Var (
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
        Prev.Int.LbpComp ~ LbpCompDbg : TrSvldVar (
            _@ < LogLevel = "Dbg"
            Inp1 ~ Next.Int.LbpComp
            Inp2 ~ End.Next.Int.LbpComp
        )
    }
    VertCrpEdgeCp : Socket3Extd {
        # "VertCrp CP to Edge"
        ColumnPos : CpStateOutp
        # "TODO unused?"
        PairColumnPos : CpStateInp
        Pos : CpStateOutp
        PairPos : CpStateInp
        LeftCpAlloc : CpStateOutp
        RightCpAlloc : CpStateOutp
    }
    VertCrpEdgeCpm : Socket3Extd {
        # "VertCrp CP to Edge. Mate."
        ColumnPos : CpStateInp
        PairColumnPos : CpStateOutp
        Pos : CpStateInp
        PairPos : CpStateOutp
        LeftCpAlloc : CpStateInp
        RightCpAlloc : CpStateInp
    }
    VertCrpEdgeCpExtd : Socket3Extd {
        # "VertCrp CP to Edge"
        ColumnPos : CpStateOutp
        # "TODO unused?"
        PairColumnPos : CpStateInp
        Pos : CpStateOutp
        PairPos : CpStateInp
        LeftCpAlloc : CpStateOutp
        RightCpAlloc : CpStateOutp
    }
    VertCrp : NodeCrp3 {
        # ">>> Vertex compact representation"
        # "Extend widget CP to for positions io"
        Cp <  {
            ItemPos : CpStateInp
            ColumnPos : CpStateInp
        }
        # "Edge CRP connpoint"
        EdgeCrpCp : VertCrpEdgeCp (
            Int.ColumnPos ~ Cp.Int.ColumnPos
            Int.Pos ~ Tpl1 : TrTuple (
                Inp ~ : State {
                    = "TPL,SI:col,SI:item -1 -1"
                }
                _@ <  {
                    col : CpStateInp
                    item : CpStateInp
                }
                col ~ Cp.Int.ColumnPos
                item ~ Cp.Int.ItemPos
            )
            # "LeftCpAlloc -> "
        )
        Tpl1_Dbg : State (
            _@ <  {
                = "TPL,SI:col,SI:item -1 -1"
                LogLevel = "Dbg"
            }
            Inp ~ Tpl1
        )
        # "Vert CRP context"
        VertCrpCtx : DesCtxCsm {
            # "CRP parameters: positioning etc"
            CrpPars : ExtdStateInp
        }
        ItemPos_Dbg : State (
            _@ <  {
                = "SI _INV"
                LogLevel = "Dbg"
            }
            Inp ~ Cp.Int.ItemPos
        )
        ColumnPos_Dbg : State (
            _@ <  {
                = "SI _INV"
                LogLevel = "Dbg"
            }
            Inp ~ Cp.Int.ColumnPos
        )
        # "Most right column of the pairs"
        # "   Inputs Iterator"
        PairPosIter : DesUtils.InpItr (
            InpM ~ EdgeCrpCp.Int.PairPos
            InpDone ~ : SB_True
            PosChgDet : DesUtils.ChgDetector (
                Inp ~ EdgeCrpCp.Int.PairPos
            )
            InpReset ~ PosChgDet.Outp
        )
        PairPosIterDone_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB _INV"
            }
            Inp ~ PairPosIter.OutpDone
        )
        # "   Selected input"
        PairPosSel : TrInpSel (
            Inp ~ EdgeCrpCp.Int.PairPos
            Idx ~ PairPosIter.Outp
        )
        PairPosSel_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "TPL,SI:col,SI:item -1 -1"
            }
            Inp ~ PairPosSel
        )
        SameColPair : State (
            _@ <  {
                LogLevel = "Dbg"
                = "TPL,SI:col,SI:item -1 -1"
            }
            Inp ~ : TrSwitchBool (
                Inp1 ~ : TrSwitchBool (
                    Inp1 ~ : State {
                        = "TPL,SI:col,SI:item -1 -1"
                    }
                    Inp2 ~ SameColPair
                    Sel ~ CmpCn_Ge : TrCmpVar (
                        Inp ~ PairPosIter.Outp
                        Inp2 ~ : SI_1
                    )
                )
                Inp2 ~ PairPosSel
                Sel ~ ColPos_Eq : TrCmpVar (
                    Inp ~ : TrTupleSel (
                        Inp ~ PairPosSel
                        Comp ~ : State {
                            = "SS col"
                        }
                    )
                    Inp2 ~ Cp.Int.ColumnPos
                )
            )
        )
        # "<<< Most right column of the pairs"
        # " Connect parameters to context"
        VertCrpCtx.CrpPars ~ : TrTuple (
            _@ <  {
                name : CpStateInp
                colpos : CpStateInp
                pmrcolpos : CpStateInp
            }
            Inp ~ : State {
                = "TPL,SS:name,SI:colpos,SI:pmrcolpos _INV -2 -1"
            }
            name ~ MagAdp.Name
            colpos ~ Cp.Int.ColumnPos
            pmrcolpos ~ : TrTupleSel (
                Inp ~ SameColPair
                Comp ~ : State {
                    = "SS col"
                }
            )
        )
        # "Left connpoint allocation"
        LeftCpAlc : TrPair (
            First ~ AlcX
            Second ~ : TrAddVar (
                Inp ~ AlcY
                Inp ~ : TrDivVar (
                    Inp ~ AlcH
                    Inp2 ~ : State {
                        = "SI 2"
                    }
                )
            )
        )
        EdgeCrpCp.Int.LeftCpAlloc ~ LeftCpAlc
        # "Right connpoint allocation"
        RightCpAlc : TrPair (
            First ~ : TrAddVar (
                Inp ~ AlcX
                Inp ~ AlcW
            )
            Second ~ : TrAddVar (
                Inp ~ AlcY
                Inp ~ : TrDivVar (
                    Inp ~ AlcH
                    Inp2 ~ : State {
                        = "SI 2"
                    }
                )
            )
        )
        EdgeCrpCp.Int.RightCpAlloc ~ RightCpAlc
        # "<<< Vertex compact representation"
    }
    _$ <  {
        # ">>> Edge CRP segments"
        EhsSlCp : Socket3Extd {
            # "Edges horizontal segment slot CP. Provides Y and requires X"
            X : CpStateInp
            Y : CpStateOutp
        }
        EhsSlCpNext : EhsSlCp {
            # "Edges horizontal segment slot Next Cp. Left (ColIdx) and right (ColRIdx) col idxs"
            Hash : CpStateInp
            ColIdx : CpStateInp
            ColRIdx : CpStateOutp
        }
        EhsSlCpPrev : EhsSlCp {
            # "Edges horizontal segment slot Prev Cp."
            Hash : CpStateOutp
            ColIdx : CpStateOutp
            ColRIdx : CpStateInp
        }
        EhtsSlCp : Socket3Extd {
            # "Edges horizontal terminal segment slot terminal CP. Requires X, Y"
            X : CpStateInp
            Y : CpStateInp
        }
        EhtsSlCpNext : EhtsSlCp {
            # "Edges horizontal terminal segment slot terminal Next CP."
            Hash : CpStateInp
            ColIdx : CpStateInp
            ColRIdx : CpStateOutp
        }
        EhtsSlCpPrev : EhtsSlCp {
            # "Edges horizontal terminal segment slot terminal Prev CP."
            Hash : CpStateOutp
            ColIdx : CpStateOutp
            ColRIdx : CpStateInp
        }
        EhsSlCpm : Socket3Extd {
            # "Edges horizontal segment slot CP mate. Provides X and requires Y"
            X : CpStateOutp
            Y : CpStateInp
        }
        EhsSlCpmNext : EhsSlCpm {
            # "Edges horizontal segment slot CP mate Next."
            Hash : CpStateInp
            ColIdx : CpStateInp
            ColRIdx : CpStateOutp
        }
        EhsSlCpmPrev : EhsSlCpm {
            # "Edges horizontal segment slot CP mate Prev."
            Hash : CpStateOutp
            ColIdx : CpStateOutp
            ColRIdx : CpStateInp
        }
        EhtsSlCpm : Socket3Extd {
            # "Edges horizontal terminal segment slot terminal CP mate. Provides X, Y"
            X : CpStateOutp
            Y : CpStateOutp
        }
        EhtsSlCpmNext : EhtsSlCpm {
            # "Edges horizontal terminal segment slot terminal CP mate Next."
            Hash : CpStateInp
            ColIdx : CpStateInp
            ColRIdx : CpStateOutp
        }
        EhtsSlCpmPrev : EhtsSlCpm {
            # "Edges horizontal terminal segment slot terminal CP mate Prev."
            Hash : CpStateOutp
            ColIdx : CpStateOutp
            ColRIdx : CpStateInp
        }
        EdgeSSlotCoordCp : Socket3Extd {
            # "Edge segments slot coords CP."
            LeftX : CpStateOutp
            LeftY : CpStateOutp
            RightX : CpStateOutp
            RightY : CpStateOutp
        }
        EdgeCrpHsSlot : ContainerMod.ColumnItemSlot {
            # ">>> Edge CRP Horizontal segment slot"
            Prev.Int  (
                AlcX !~ SCp.OutAlcX
                AlcX ~ Next.Int.AlcX
                AlcY !~ SCp.Int.OutAlcY
                AlcY ~ Add1
                # "TODO Do we need to set AlcH ?"
            )
            EsPrev : EhsSlCpPrev
            EsNext : EhsSlCpNext
            EsPrev.Int.Y ~ Add1
            EsPrev.Int.Hash ~ : TrHash (
                Inp ~ EsNext.Int.Hash
                Inp ~ Next.Int.AlcY
            )
            EsPrev.Int.ColIdx ~ EsNext.Int.ColIdx
            EsNext.Int.Y ~ Add1
            EsNext.Int.ColRIdx ~ : TrSub2Var (
                Inp ~ EsPrev.Int.ColRIdx
                Inp2 ~ : SI_1
            )
            # "Monolitic EdgeCrp agent is used ATM. So we don't need real widget"
            # "representing edge CRP segment - agent just gets coords directly from slot"
            # "but we still keeps compatibility with standard design"
            # "So to handle mouse events we need to use stub instead of widget"
            WdgCp : FvWidgets.WidgetCp (
                Int.LbpUri ~ : Const {
                    = "URI"
                }
                _ <  {
                    # "TODO Doesn't work ATM. To fix"
                    RqsH ~ : Const {
                        = "SI 1"
                    }
                    RqsW ~ : TrSub2Var (
                        Inp ~ EsPrev.Int.Y
                        Inp2 ~ EsNext.Int.Y
                    )
                }
            )
            SCp ~ WdgCp
            Coords : EdgeSSlotCoordCp
            Coords.Int.LeftX ~ EsNext.Int.X
            Coords.Int.LeftY ~ Add1
            Coords.Int.RightX ~ EsPrev.Int.X
            Coords.Int.RightY ~ Add1
            # "Uses EdgeCRP context to get controlling access to DRP"
            EdgeCrpCtx : DesCtxCsm {
                DrpMntp : ExtdSystExplorable
            }
            DrpAdp : DAdp (
                _@ < LogLevel = "Dbg"
                CpExploring ~ EdgeCrpCtx.DrpMntp
                InpMagUri ~ : State {
                    = "URI _$"
                }
            )
            TnlSlotName : TrApndVar (
                _@ < LogLevel = "Dbg"
                Inp1 ~ : Const {
                    = "SS Column_"
                }
                Inp2 ~ : TrTostrVar (
                    Inp ~ EsNext.Int.ColIdx
                )
            )
            SelfUri : SdoUri
            DrpAdp <  {
                AdpTnlSlotName : ExtdStateInp
                CurColIdx : ExtdStateInp
                ReqColIdx : ExtdStateInp
                ColRIdx : ExtdStateInp
                AdpSlotUri : ExtdStateInp
                # "Constants"
                KS_Prev : Const {
                    = "SS Prev"
                }
                KS_Next : Const {
                    = "SS Next"
                }
                KS_Start : Const {
                    = "SS Start"
                }
                KS_End : Const {
                    = "SS End"
                }
                # "Slot URI relative to DRP"
                SlotUriRdrp : TrTailVar (
                    Inp ~ AdpSlotUri.Int
                    Head ~ : SdoUri
                )
                SlotUriRdrp_Dbg : State (
                    # "TODO Helps init SlotUriRdrp, to remove"
                    _@ <  {
                        LogLevel = "Dbg"
                        = "URI"
                    }
                    Inp ~ SlotUriRdrp
                )
                # "Re-insert slot to given column"
                SdcExtrHs : ASdcExtract (
                    _@ < LogLevel = "Dbg"
                    Enable ~ : TrAndVar (
                        Inp ~ Columns_Neq : TrCmpVar (
                            _@ < LogLevel = "Dbg"
                            Inp ~ CurColIdx.Int
                            Inp2 ~ ReqColIdx.Int
                        )
                        Inp ~ CurColIdxValid : TrIsValid (
                            Inp ~ CurColIdx.Int
                        )
                    )
                    Name ~ : TrTostrVar (
                        Inp ~ SlotUriRdrp
                    )
                    SdcExtrHs.Prev ~ KS_Prev
                    SdcExtrHs.Next ~ KS_Next
                )
                SdcInsertToCol : ASdcInsert2 (
                    _@ < LogLevel = "Dbg"
                    Enable ~ SdcExtrHs.Outp
                    Enable ~ : TrIsValid (
                        Inp ~ ReqColIdx.Int
                    )
                    Enable ~ : TrIsValid (
                        Inp ~ ColRIdx.Int
                    )
                    Name ~ : TrTostrVar (
                        Inp ~ SlotUriRdrp
                    )
                    Pname ~ : TrApndVar (
                        Inp1 ~ AdpTnlSlotName.Int
                        Inp2 ~ : Const {
                            = "SS .End"
                        }
                    )
                    SdcInsertToCol.Prev ~ KS_Prev
                    SdcInsertToCol.Next ~ KS_Next
                )
            }
            DrpAdp.AdpTnlSlotName ~ TnlSlotName
            DrpAdp.CurColIdx ~ Next.Int.ColumnPos
            DrpAdp.ReqColIdx ~ EsNext.Int.ColIdx
            DrpAdp.ColRIdx ~ EsPrev.Int.ColRIdx
            DrpAdp.AdpSlotUri ~ SelfUri
            # "<<< Edge CRP Horizontal segment slot"
        }
        EdgeCrpVsSlot : ContainerMod.FSlotLin {
            # ">>> Edge CRP Vertical segment slot"
            # "Extend chain CPs for positions io"
            Prev <  {
                ItemPos : CpStateOutp
                ColumnPos : CpStateOutp
            }
            Next <  {
                ItemPos : CpStateInp
                ColumnPos : CpStateInp
            }
            Prev.Int.ItemPos ~ : TrAddVar (
                Inp ~ Next.Int.ItemPos
                Inp ~ : SI_1
            )
            Prev.Int.ColumnPos ~ Next.Int.ColumnPos
            # "Uses EdgeCRP context to get controlling access to DRP"
            EdgeCrpCtx : DesCtxCsm {
                DrpMntp : ExtdSystExplorable
            }
            DrpAdp : DAdp (
                CpExploring ~ EdgeCrpCtx.DrpMntp
                InpMagUri ~ : State {
                    = "URI _$"
                }
            )
            EsPrev : EhsSlCpmPrev
            EsNext : EhsSlCpmNext
            # "Monolitic EdgeCrp agent is used ATM. So we don't need real widget"
            # "representing edge CRP segment - agent just gets coords directly from slot"
            # "but we still keeps compatibility with standard design, so use FSlotLin even w/o widget"
            # "So to handle mouse events we need to use stub instead of widget"
            # "Consider to avoid using FSlotLin"
            WdgCp : FvWidgets.WidgetCp (
                Int.LbpUri ~ : Const {
                    = "URI"
                }
                Int.RqsW ~ : Const {
                    = "SI 0"
                }
                Int.RqsH ~ : TrSub2Var (
                    Inp ~ EsPrev.Int.Y
                    Inp2 ~ EsNext.Int.Y
                )
            )
            SCp ~ WdgCp
            # "TODO Apply vertical tunnel specific padding"
            AddX : TrAddVar (
                _@ < LogLevel = "Dbg"
                Inp ~ Next.Int.AlcX
                Inp ~ Next.Int.AlcW
                Inp ~ Next.Int.XPadding
            )
            Prev.Int.AlcX ~ AddX
            Prev.Int.AlcY ~ Next.Int.AlcY
            Prev.Int.AlcH ~ Next.Int.AlcH
            Prev.Int.AlcW ~ SCp.Int.RqsW
            Prev.Int.CntRqsW ~ VtsCntRqsW : TrAddVar (
                Inp ~ Next.Int.CntRqsW
                Inp ~ SCp.Int.RqsW
                Inp ~ Next.Int.XPadding
            )
            Prev.Int.CntRqsH ~ VtsCntRqsH : TrAdd2Var (
                Inp ~ Next.Int.CntRqsH
                Inp2 ~ SCp.Int.RqsH
            )
            EsPrev.Int.X ~ AddX
            EsNext.Int.X ~ AddX
            EsNext.Int.ColRIdx ~ EsPrev.Int.ColRIdx
            EsPrev.Int.Hash ~ EsNext.Int.Hash
            EsPrev.Int.Hash ~ Next.Int.AlcX
            EsPrev.Int.ColIdx ~ : TrAddVar (
                Inp ~ EsNext.Int.ColIdx
                Inp ~ : SI_1
            )
            Coords : EdgeSSlotCoordCp
            Coords.Int.LeftX ~ AddX
            Coords.Int.LeftY ~ EsNext.Int.Y
            Coords.Int.RightX ~ AddX
            Coords.Int.RightY ~ EsPrev.Int.Y
            TnlSlotName : TrApndVar (
                _@ < LogLevel = "Dbg"
                Inp1 ~ : TrApndVar (
                    Inp1 ~ : Const {
                        = "SS Column_"
                    }
                    Inp2 ~ : TrTostrVar (
                        Inp ~ EsNext.Int.ColIdx
                    )
                )
                Inp2 ~ : Const {
                    = "SS _vt"
                }
            )
            SelfName : SdoName
            SelfUri : SdoUri
            DrpAdp <  {
                AdpTnlSlotName : ExtdStateInp
                CurColIdx : ExtdStateInp
                ReqColIdx : ExtdStateInp
                ColRIdx : ExtdStateInp
                AdpSlotName : ExtdStateInp
                AdpSlotUri : ExtdStateInp
                # "Constants"
                KS_Prev : Const {
                    = "SS Prev"
                }
                KS_Next : Const {
                    = "SS Next"
                }
                KS_Start : Const {
                    = "SS Start"
                }
                KS_End : Const {
                    = "SS End"
                }
                # "Slot URI relative to DRP"
                SlotUriRdrp : TrTailVar (
                    Inp ~ AdpSlotUri.Int
                    Head ~ : SdoUri
                )
                SlotUriRdrp_Dbg : State (
                    _@ <  {
                        LogLevel = "Dbg"
                        = "URI"
                    }
                    Inp ~ SlotUriRdrp
                )
                # "Re-insert slot to given vertical tunnel"
                SdcExtrVs : ASdcExtract (
                    _@ < LogLevel = "Dbg"
                    # "Enable extracting if req and cur column idxs arent met or req col idx is invalid"
                    Enable ~ : TrSwitchBool (
                        Inp1 ~ : SB_True
                        Inp2 ~ : TrAndVar (
                            Inp ~ Columns_Neq : TrCmpVar (
                                _@ < LogLevel = "Dbg"
                                Inp ~ CurColIdx.Int
                                Inp2 ~ ReqColIdx.Int
                            )
                            Inp ~ CurColIdxValid : TrIsValid (
                                Inp ~ CurColIdx.Int
                            )
                        )
                        Sel ~ : TrIsValid (
                            Inp ~ ReqColIdx.Int
                        )
                    )
                    _ <  {
                        # "!! To fix"
                        Name ~ SlotUriRdrp
                    }
                    Name ~ : TrTostrVar (
                        Inp ~ SlotUriRdrp
                    )
                    SdcExtrVs.Prev ~ KS_Prev
                    SdcExtrVs.Next ~ KS_Next
                )
                SdcInsertToVt : ASdcInsert2 (
                    _@ < LogLevel = "Dbg"
                    Enable ~ SdcExtrVs.Outp
                    Enable ~ : TrIsValid (
                        Inp ~ ReqColIdx.Int
                    )
                    Enable ~ : TrIsValid (
                        Inp ~ ColRIdx.Int
                    )
                    Name ~ : TrTostrVar (
                        Inp ~ SlotUriRdrp
                    )
                    Pname ~ : TrApndVar (
                        Inp1 ~ AdpTnlSlotName.Int
                        Inp2 ~ : Const {
                            = "SS .End"
                        }
                    )
                    SdcInsertToVt.Prev ~ KS_Prev
                    SdcInsertToVt.Next ~ KS_Next
                )
            }
            DrpAdp.AdpTnlSlotName ~ TnlSlotName
            DrpAdp.CurColIdx ~ : TrAdd2Var (
                # "Note that tunnel idx is (col_idx + 1) atm"
                Inp ~ Next.Int.ColumnPos
                Inp2 ~ : State {
                    = "SI -1"
                }
            )
            DrpAdp.ReqColIdx ~ EsNext.Int.ColIdx
            DrpAdp.ColRIdx ~ EsPrev.Int.ColRIdx
            DrpAdp.AdpSlotName ~ SelfName
            DrpAdp.AdpSlotUri ~ SelfUri
            # "<<< Edge CRP Vertical segment slot"
        }
        EsNextSock : Socket3Extd {
            X : CpStateInp
            Y : CpStateOutp
            Hash : CpStateInp
            ColIdx : CpStateInp
            ColRIdx : CpStateOutp
        }
        EsPrevSock : Socket3Extd {
            X : CpStateOutp
            Y : CpStateInp
            Hash : CpStateOutp
            ColIdx : CpStateOutp
            ColRIdx : CpStateInp
        }
        EdgeCrpRsSlot : Des {
            # "Edge CRP regular slot. The slot is combined from vertical and horisontal slots."
            EsNext : EsNextSock
            EsPrev : EsPrevSock
            Hs : EdgeCrpHsSlot
            Vs : EdgeCrpVsSlot
            Hs.EsNext ~ EsNext.Int
            Vs.EsNext ~ Hs.EsPrev
            EsPrev.Int ~ Vs.EsPrev
        }
        EdgeCrpHssSlot : Syst {
            # "Edge CRP Horizontal start segment slot"
            EsPrev : EhsSlCpPrev
            EsNext : EhtsSlCpNext
            EsPrev.Int.Y ~ EsNext.Int.Y
            EsPrev.Int.Hash ~ EsNext.Int.X
            EsPrev.Int.Hash ~ EsNext.Int.Y
            EsPrev.Int.ColIdx ~ EsNext.Int.ColIdx
            EsNext.Int.ColRIdx ~ : TrSub2Var (
                Inp ~ EsPrev.Int.ColRIdx
                Inp2 ~ : SI_1
            )
            Coords : EdgeSSlotCoordCp
            Coords.Int.LeftX ~ EsPrev.Int.X
            Coords.Int.LeftY ~ EsNext.Int.Y
            Coords.Int.RightX ~ EsNext.Int.X
            Coords.Int.RightY ~ EsNext.Int.Y
        }
        EdgeCrpHesSlot : Syst {
            # "Edge CRP Horizontal end segment slot"
            EsPrev : EhtsSlCpPrev
            EsNext : EhsSlCpNext
            EsNext.Int.Y ~ EsPrev.Int.Y
            EsNext.Int.ColRIdx ~ EsPrev.Int.ColRIdx
            EsPrev.Int.Hash ~ EsNext.Int.Hash
            EsPrev.Int.Hash ~ EsPrev.Int.Y
            EsPrev.Int.Hash ~ EsNext.Int.X
            EsPrev.Int.ColIdx ~ EsNext.Int.ColIdx
            Coords : EdgeSSlotCoordCp
            Coords.Int.LeftX ~ EsPrev.Int.X
            Coords.Int.LeftY ~ EsPrev.Int.Y
            Coords.Int.RightX ~ EsNext.Int.X
            Coords.Int.RightY ~ EsPrev.Int.Y
        }
        # "<<< Edge CRP segments"
    }
    EdgeCrp : FvWidgets.FWidgetBase {
        # ">>> Edge compact repesentation"
        WdgAgent : AEdgeCrp
        WdgAgent < LogLevel = "Dbg"
        EdgeCrpCtx : DesCtxCsm {
            DrpMntp : ExtdSystExplorable
        }
        DrpAdp : DAdp (
            _@ < LogLevel = "Dbg"
            _@ < CpExpbl : CpSystExplorable
            CpExploring ~ EdgeCrpCtx.DrpMntp
            InpMagUri ~ : State {
                = "URI _$"
            }
        )
        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.3 0.0 0.0"
        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
        VertCrpPCp : VertCrpEdgeCpm
        VertCrpQCp : VertCrpEdgeCpm
        VertCrpPCp.Int.PairColumnPos ~ VertCrpQCp.Int.ColumnPos
        VertCrpQCp.Int.PairColumnPos ~ VertCrpPCp.Int.ColumnPos
        VertCrpPCp.Int.PairPos ~ VertCrpQCp.Int.Pos
        VertCrpQCp.Int.PairPos ~ VertCrpPCp.Int.Pos
        PLeftCpAlc_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "PSI (SI _INV , SI _INV)"
            }
            Inp ~ VertCrpPCp.Int.LeftCpAlloc
        )
        # "Vert P"
        VertPOnLeft_Lt : TrSwitchBool (
            _@ < LogLevel = "Dbg"
            Inp1 ~ PCol_Lt : TrCmpVar (
                _@ < LogLevel = "Dbg"
                Inp ~ VertCrpPCp.Int.ColumnPos
                Inp2 ~ VertCrpQCp.Int.ColumnPos
            )
            Inp2 ~ PLeftAlc_Ge : TrCmpVar (
                Inp ~ : TrAtgVar (
                    Inp ~ VertCrpPCp.Int.LeftCpAlloc
                    Index ~ : SI_0
                )
                Inp2 ~ : SI_0
            )
            Sel ~ PQColPos_Eq : TrCmpVar (
                _@ < LogLevel = "Dbg"
                Inp ~ VertCrpPCp.Int.ColumnPos
                Inp2 ~ VertCrpQCp.Int.ColumnPos
            )
        )
        VPLeftCpNotSupp_Lt : TrCmpVar (
            # "Vert P doesn't supports left CP"
            _@ < LogLevel = "Dbg"
            Inp ~ : TrAtgVar (
                _@ < LogLevel = "Dbg"
                Inp ~ VertCrpPCp.Int.LeftCpAlloc
                Index ~ : SI_0
            )
            Inp2 ~ : SI_0
        )
        VPRightCpNotSupp_Lt : TrCmpVar (
            # "Vert P doesn't supports right CP"
            _@ < LogLevel = "Dbg"
            Inp ~ : TrAtgVar (
                Inp ~ VertCrpPCp.Int.RightCpAlloc
                Index ~ : SI_0
            )
            Inp2 ~ : SI_0
        )
        VPNonDefCp : TrSwitchBool (
            # "Vert P supports non-default CP only"
            _@ < LogLevel = "Dbg"
            Inp1 ~ VPLeftCpNotSupp_Lt
            Inp2 ~ VPRightCpNotSupp_Lt
            Sel ~ VertPOnLeft_Lt
        )
        VPNonDefCp_Dbg : State (
            _@ < LogLevel = "Dbg"
            _@ < = "SB"
            Inp ~ VPNonDefCp
        )
        # "Vert Q"
        _ <  {
            VertQOnLeft_Lt : TrCmpVar (
                _@ < LogLevel = "Dbg"
                Inp ~ VertCrpQCp.Int.ColumnPos
                Inp2 ~ VertCrpPCp.Int.ColumnPos
            )
        }
        VertQOnLeft_Lt : TrNegVar (
            Inp ~ VertPOnLeft_Lt
        )
        VQLeftCpNotSupp_Lt : TrCmpVar (
            # "Vert Q doesn't supports left CP"
            Inp ~ : TrAtgVar (
                Inp ~ VertCrpQCp.Int.LeftCpAlloc
                Index ~ : SI_0
            )
            Inp2 ~ : SI_0
        )
        VQRightCpNotSupp_Lt : TrCmpVar (
            # "Vert Q doesn't supports right CP"
            Inp ~ : TrAtgVar (
                Inp ~ VertCrpQCp.Int.RightCpAlloc
                Index ~ : SI_0
            )
            Inp2 ~ : SI_0
        )
        VQNonDefCp : TrSwitchBool (
            # "Vert Q supports non-default CP only"
            _@ < LogLevel = "Dbg"
            Inp1 ~ VQLeftCpNotSupp_Lt
            Inp2 ~ VQRightCpNotSupp_Lt
            Sel ~ VertQOnLeft_Lt
        )
        VQNonDefCp_Dbg : State (
            _@ < LogLevel = "Dbg"
            _@ < = "SB"
            Inp ~ VQNonDefCp
        )
        # "VertCrp P attachment point allocation"
        VertPApAlc : TrSwitchBool (
            Inp1 ~ : TrSwitchBool (
                Inp1 ~ VertCrpPCp.Int.LeftCpAlloc
                Inp2 ~ VertCrpPCp.Int.RightCpAlloc
                Sel ~ VPLeftCpNotSupp_Lt
            )
            Inp2 ~ : TrSwitchBool (
                Inp1 ~ VertCrpPCp.Int.RightCpAlloc
                Inp2 ~ VertCrpPCp.Int.LeftCpAlloc
                Sel ~ VPRightCpNotSupp_Lt
            )
            Sel ~ VertPOnLeft_Lt
        )
        # "VertCrp Q attachment point allocation"
        VertQApAlc : TrSwitchBool (
            Inp1 ~ : TrSwitchBool (
                Inp1 ~ VertCrpQCp.Int.LeftCpAlloc
                Inp2 ~ VertCrpQCp.Int.RightCpAlloc
                Sel ~ VQLeftCpNotSupp_Lt
            )
            Inp2 ~ : TrSwitchBool (
                Inp1 ~ VertCrpQCp.Int.RightCpAlloc
                Inp2 ~ VertCrpQCp.Int.LeftCpAlloc
                Sel ~ VQRightCpNotSupp_Lt
            )
            Sel ~ VertQOnLeft_Lt
        )
        LeftVertColPos : TrSwitchBool (
            _@ < LogLevel = "Dbg"
            Inp1 ~ VertCrpQCp.Int.ColumnPos
            Inp2 ~ VertCrpPCp.Int.ColumnPos
            Sel ~ VertPOnLeft_Lt
        )
        LeftVertColPos_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SI"
            }
            Inp ~ LeftVertColPos
        )
        RightVertColPos : TrSwitchBool (
            _@ < LogLevel = "Dbg"
            Inp1 ~ VertCrpPCp.Int.ColumnPos
            Inp2 ~ VertCrpQCp.Int.ColumnPos
            Sel ~ VertPOnLeft_Lt
        )
        _ <  {
            RightVertColPos_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SI"
                }
                Inp ~ RightVertColPos
            )
        }
        # "Left vert attachment point allocation"
        LeftVertApAlc : TrSwitchBool (
            Inp1 ~ VertQApAlc
            Inp2 ~ VertPApAlc
            Sel ~ VertPOnLeft_Lt
        )
        # "Left vert non-default CP"
        LeftVertNondefCp : TrSwitchBool (
            Inp1 ~ VQNonDefCp
            Inp2 ~ VPNonDefCp
            Sel ~ VertPOnLeft_Lt
        )
        # "Left vert allocation CP - bridge to edge terminal segment"
        LeftVertAlcCp : EhtsSlCpmPrev (
            Int.X ~ : TrAtgVar (
                Inp ~ LeftVertApAlc
                Index ~ : SI_0
            )
            Int.Y ~ : TrAtgVar (
                Inp ~ LeftVertApAlc
                Index ~ : SI_1
            )
            Int.ColIdx ~ LeftVertAlcCp_ColIdx : TrSwitchBool (
                _@ < LogLevel = "Dbg"
                Inp1 ~ LeftVertColPos
                Inp2 ~ : TrSub2Var (
                    Inp ~ LeftVertColPos
                    Inp2 ~ : SI_1
                )
                Sel ~ LeftVertNondefCp
            )
        )
        SegmentsColRIdxRes : State (
            _@ < = "SI"
            _@ < LogLevel = "Dbg"
            Inp ~ LeftVertAlcCp.Int.ColRIdx
        )
        # "Right vert attachment point allocation"
        RightVertApAlc : TrSwitchBool (
            _@ < LogLevel = "Dbg"
            Inp1 ~ VertPApAlc
            Inp2 ~ VertQApAlc
            Sel ~ VertPOnLeft_Lt
        )
        # "Right vert non-default CP"
        RightVertNondefCp : TrSwitchBool (
            Inp1 ~ VPNonDefCp
            Inp2 ~ VQNonDefCp
            Sel ~ VertPOnLeft_Lt
        )
        # "Right vert allocation CP - bridge to edge terminal segment"
        RightVertAlcCp : EhtsSlCpmNext (
            Int.X ~ : TrAtgVar (
                Inp ~ RightVertApAlc
                Index ~ : SI_0
            )
            Int.Y ~ : TrAtgVar (
                Inp ~ RightVertApAlc
                Index ~ : SI_1
            )
            Int.ColRIdx ~ RightVertAlcCp_ColRIdx : TrSwitchBool (
                _@ < LogLevel = "Dbg"
                Inp1 ~ : TrSub2Var (
                    Inp ~ RightVertColPos
                    Inp2 ~ : SI_1
                )
                Inp2 ~ RightVertColPos
                Sel ~ RightVertNondefCp
            )
        )
        # "TODO do we need state here?"
        SegmentsColIdxRes : State (
            _@ < = "SI"
            _@ < LogLevel = "Dbg"
            Inp ~ RightVertAlcCp.Int.ColIdx
        )
        SegmentsHash : State (
            _@ < = "SI"
            _@ < LogLevel = "Dbg"
            Inp ~ : TrHash (
                Inp ~ RightVertAlcCp.Int.Hash
            )
        )
        _$ <  {
            # ">>> Creation of edges segments"
            # "Edge consists of left/right terminal segments, default vert segment and regular segments"
            # "Detector of Connection to vertexes"
            VertsConnected : TrAndVar (
                _@ < LogLevel = "Dbg"
                Inp ~ Dtv_Gt : TrCmpVar (
                    Inp ~ : SdoPairsCount (
                        _@ < LogLevel = "Dbg"
                        Vp ~ : Const {
                            = "URI VertCrpPCp"
                        }
                    )
                    Inp2 ~ : SI_0
                )
                Inp ~ Dtv_Gt_2 : TrCmpVar (
                    Inp ~ : SdoPairsCount (
                        Vp ~ : Const {
                            = "URI VertCrpQCp"
                        }
                    )
                    Inp2 ~ : SI_0
                )
            )
            # "Column Positions Iterator"
            SelfName : SdoName
            DrpAdp <  {
                # ">>> Edge's VertDRP adapter"
                EdgeName : ExtdStateInp
                EdgeLeftVertColPos : ExtdStateInp
                EdgeRightVertColPos : ExtdStateInp
                EdgeSegmentsColIdxRes : ExtdStateInp
                EdgeVertsConnected : ExtdStateInp
                # "Constants"
                KS_Prev : Const {
                    = "SS Prev"
                }
                KS_Next : Const {
                    = "SS Next"
                }
                KS_Start : Const {
                    = "SS Start"
                }
                KS_End : Const {
                    = "SS End"
                }
                KS_Col_Pref : Const {
                    = "SS Column_"
                }
                KS_EsPrev : Const {
                    = "SS EsPrev"
                }
                KS_EsNext : Const {
                    = "SS EsNext"
                }
                # " "
                EdgeColIdxRsd : TrSub2Var (
                    # "Edge colum indexes residual"
                    _@ < LogLevel = "Dbg"
                    Inp ~ EdgeRightVertColPos.Int
                    Inp2 ~ EdgeSegmentsColIdxRes.Int
                )
                EdgeColIdxRsd_Dbg : State (
                    _@ <  {
                        LogLevel = "Dbg"
                        = "SI"
                    }
                    Inp ~ EdgeColIdxRsd
                )
                EdgeEtSegIdx : TrSub2Var (
                    # "Edge end terminal segment index"
                    _@ < LogLevel = "Dbg"
                    Inp ~ EdgeSegmentsColIdxRes.Int
                    Inp2 ~ EdgeLeftVertColPos.Int
                )
                EdgeEtSegIdx_Dbg : State (
                    _@ <  {
                        LogLevel = "Dbg"
                        = "SI"
                    }
                    Inp ~ EdgeEtSegIdx
                )
                EdgeColRank : TrSub2Var (
                    # "Edge colums rank: the number of colums between edges vertexes"
                    _@ < LogLevel = "Dbg"
                    Inp ~ EdgeRightVertColPos.Int
                    Inp2 ~ EdgeLeftVertColPos.Int
                )
                EdgeColRank_Dbg : State (
                    _@ <  {
                        LogLevel = "Dbg"
                        = "SI"
                    }
                    Inp ~ EdgeColRank
                )
                EdgeCR_Ge_0 : TrCmpVar (
                    _@ < LogLevel = "Dbg"
                    Inp ~ EdgeColRank
                    Inp2 ~ : SI_0
                )
                EdgeCidxRsd_Ge_0 : TrCmpVar (
                    _@ < LogLevel = "Dbg"
                    Inp ~ EdgeColIdxRsd
                    Inp2 ~ : SI_0
                )
                EdgeCidxRsd_Lt_0 : TrCmpVar (
                    _@ < LogLevel = "Dbg"
                    Inp ~ EdgeColIdxRsd
                    Inp2 ~ : Const {
                        = "SI -1"
                    }
                )
                # "Creating and connecting start terminal segment"
                CreateStSeg : ASdcComp (
                    _@ < LogLevel = "Dbg"
                    Enable ~ EdgeCR_Ge_0
                    Name ~ LtSlotName : TrApndVar (
                        Inp1 ~ EdgeName.Int
                        Inp2 ~ : Const {
                            = "SS _LtSlot"
                        }
                    )
                    Parent ~ : Const {
                        = "SS EdgeCrpHssSlot"
                    }
                )
                SdcConnStSeg : ASdcConn (
                    Enable ~ CreateStSeg.Outp
                    V1 ~ : TrApndVar (
                        Inp1 ~ EdgeName.Int
                        Inp2 ~ : Const {
                            = "SS .LeftVertAlcCp"
                        }
                    )
                    V2 ~ : TrApndVar (
                        Inp1 ~ LtSlotName
                        Inp2 ~ : Const {
                            = "SS .EsNext"
                        }
                    )
                )
                # "Creating and connecting end terminal segment slot"
                CreateEtSeg : ASdcComp (
                    Enable ~ EdgeCR_Ge_0
                    _@ < LogLevel = "Dbg"
                    Name ~ RtSlotName : TrApndVar (
                        Inp1 ~ EdgeName.Int
                        Inp2 ~ : Const {
                            = "SS _RtSlot"
                        }
                    )
                    Parent ~ : Const {
                        = "SS EdgeCrpHesSlot"
                    }
                )
                SdcConnEtSeg : ASdcConn (
                    Enable ~ CreateStSeg.Outp
                    # "V1 --> "
                    V1 ~ : TrApndVar (
                        Inp1 ~ EdgeName.Int
                        Inp2 ~ : Const {
                            = "SS .RightVertAlcCp"
                        }
                    )
                    V2 ~ : TrApndVar (
                        Inp1 ~ RtSlotName
                        Inp2 ~ : Const {
                            = "SS .EsPrev"
                        }
                    )
                )
                # "Creating default vertical segment slot. Connecting to terminal slots"
                CreateVsSeg : ASdcComp (
                    _@ < LogLevel = "Dbg"
                    Enable ~ EdgeCR_Ge_0
                    Name ~ VsSlotName : TrApndVar (
                        Inp1 ~ EdgeName.Int
                        Inp2 ~ : Const {
                            = "SS _VsSlot"
                        }
                    )
                    Parent ~ : Const {
                        = "SS EdgeCrpVsSlot"
                    }
                )
                SdcConnVsSSeg : ASdcConn (
                    Enable ~ CreateVsSeg.Outp
                    V1 ~ : TrApndVar (
                        Inp1 ~ VsSlotName
                        Inp2 ~ : Const {
                            = "SS .EsNext"
                        }
                    )
                    V2 ~ : TrApndVar (
                        Inp1 ~ LtSlotName
                        Inp2 ~ : Const {
                            = "SS .EsPrev"
                        }
                    )
                )
                VsEsPrev : TrApndVar (
                    _@ < LogLevel = "Dbg"
                    Inp1 ~ VsSlotName
                    Inp2 ~ : Const {
                        = "SS .EsPrev"
                    }
                )
                # "Edges Vertial default segment Prev CP isn't connected"
                VsEsPrevNCntd_Eq : TrCmpVar (
                    _@ < LogLevel = "Dbg"
                    Inp ~ SdoPc : SdoPairsCount (
                        _@ < LogLevel = "Dbg"
                        Vp ~ : TrToUriVar (
                            Inp ~ VsEsPrev
                        )
                    )
                    Inp2 ~ : SI_0
                )
                SdcConnVsESeg : ASdcConn (
                    _@ < LogLevel = "Dbg"
                    _ <  {
                        Enable ~ CreateVsSeg.Outp
                    }
                    Enable ~ : TrAndVar (
                        Inp ~ CreateVsSeg.Outp
                        Inp ~ VsEsPrevNCntd_Eq
                    )
                    V1 ~ VsEsPrev
                    V2 ~ : TrApndVar (
                        Inp1 ~ RtSlotName
                        Inp2 ~ : Const {
                            = "SS .EsNext"
                        }
                    )
                )
                LeftTnlSlotName : TrApndVar (
                    Inp1 ~ : TrApndVar (
                        Inp1 ~ : Const {
                            = "SS Column_"
                        }
                        Inp2 ~ : TrTostrVar (
                            Inp ~ EdgeLeftVertColPos.Int
                        )
                    )
                    Inp2 ~ : Const {
                        = "SS _vt"
                    }
                )
                RsNamePrefix : TrApndVar (
                    Inp1 ~ EdgeName.Int
                    Inp2 ~ : Const {
                        = "SS _Rs_"
                    }
                )
                # "Adding (creating and inserting to seg chain) regular segments"
                CreateRs : ASdcComp (
                    # "Creating regular slot"
                    _@ < LogLevel = "Dbg"
                    Enable ~ EdgeCidxRsd_Ge_0
                    Name ~ RsSlotName : TrApndVar (
                        Inp1 ~ RsNamePrefix
                        Inp2 ~ : TrTostrVar (
                            Inp ~ EdgeEtSegIdx
                        )
                    )
                    Parent ~ : Const {
                        = "SS EdgeCrpRsSlot"
                    }
                )
                _ <  {
                    EdgeRsColId : TrAddVar (
                        # "Edge regular slots column id"
                        Inp ~ EdgeLeftVertColPos.Int
                        Inp ~ EdgeEtSegIdx
                    )
                    EdgeRsColSlotName : TrApndVar (
                        # "Column slot name"
                        Inp1 ~ KS_Col_Pref
                        Inp2 ~ : TrTostrVar (
                            Inp ~ EdgeRsColId
                        )
                    )
                    EdgeRsTnlSlotName : TrApndVar (
                        # "Edge reg slot column vertical tunnel slot name"
                        Inp1 ~ EdgeRsColSlotName
                        Inp2 ~ : Const {
                            = "SS _vt"
                        }
                    )
                }
                SdcInsertRs : ASdcInsertN (
                    # "Insert regular slot to edge slot list"
                    _@ < LogLevel = "Dbg"
                    Enable ~ CreateRs.Outp
                    Enable ~ EdgeCidxRsd_Ge_0
                    Name ~ RsSlotName
                    Pname ~ VsSlotName
                    Prev ~ KS_EsPrev
                    Next ~ KS_EsNext
                )
                # "Extract excessive regular segments from seg chain"
                SdcExtrRs : ASdcExtract (
                    _@ < LogLevel = "Dbg"
                    Enable ~ EdgeCidxRsd_Lt_0
                    Name ~ ExtrRsSlotName : TrApndVar (
                        Inp1 ~ RsNamePrefix
                        Inp2 ~ : TrTostrVar (
                            Inp ~ ExtrRsIdx : TrSub2Var (
                                Inp ~ EdgeEtSegIdx
                                Inp2 ~ : SI_1
                            )
                        )
                    )
                    Prev ~ KS_EsPrev
                    Next ~ KS_EsNext
                )
                # "<<< Edge's VertDRP adapter"
            }
            DrpAdp.EdgeName ~ SelfName
            DrpAdp.EdgeLeftVertColPos ~ LeftVertAlcCp_ColIdx
            DrpAdp.EdgeRightVertColPos ~ RightVertAlcCp_ColRIdx
            DrpAdp.EdgeSegmentsColIdxRes ~ SegmentsColIdxRes
            DrpAdp.EdgeVertsConnected ~ VertsConnected
            # "<<< Creation of edges segments"
        }
        # "<<< Edge compact repesentation"
    }
    VertCrpSlot : ContainerMod.ColumnItemSlot {
        # "Vertex DRP column item slot"
        # "Extend widget CP to for positions io"
        SCp <  {
            ItemPos : CpStateOutp
            ColumnPos : CpStateOutp
        }
        SCp.Int.ItemPos ~ Next.Int.ItemPos
        SCp.Int.ColumnPos ~ Next.Int.ColumnPos
    }
    VertDrp : ContainerMod.ColumnsLayout {
        # " Vertex detail representation"
        # "ing"
        CreateWdg < LogLevel = "Dbg"
        SdcInsert < LogLevel = "Dbg"
        AddSlot < LogLevel = "Dbg"
        # "TODO We need to redefine SlotParent to be valid in the current context. Analyze how to avoid."
        SlotParent < = "SS VertCrpSlot"
        # "Default paddings"
        XPadding < = "SI 20"
        YPadding < = "SI 20"
        # "Most left v-tunnel, first column and first v-tunnel"
        Start.Prev !~ End.Next
        Column_0_vt : AvrMdl2.VertDrpVtSlot
        Column_0_vt.Next ~ Start.Prev
        Column_1 : ContainerMod.ColumnLayoutSlot
        Column_1.Next ~ Column_0_vt.Prev
        Column_1_vt : AvrMdl2.VertDrpVtSlot
        Column_1_vt.Next ~ Column_1.Prev
        End.Next ~ Column_1_vt.Prev
        # "DRP context"
        DrpCtx : DesCtxCsm {
            ModelMntp : ExtdSystExplorable
            DrpMagUri : ExtdStateOutp
        }
        DrpCtxMagUri_Dbg : State (
            _@ < LogLevel = "Dbg"
            Inp ~ DrpCtx.DrpMagUri
        )
        # "Managed agent (MAG) adapter"
        MagAdp : DAdp (
            _@ <  {
                Name : SdoName
                CompsCount : SdoCompsCount
                CompsNames : SdoCompsNames
                Edges : SdoEdges
            }
            _@ < LogLevel = "Dbg"
            CpExploring ~ DrpCtx.ModelMntp
            InpMagUri ~ DrpCtx.DrpMagUri
        )
        # "CRP context"
        CrpCtx : DesCtxSpl (
            _@ <  {
                ModelMntp : ExtdSystExploring
                DrpMagUri : ExtdStateInp
            }
            ModelMntp ~ DrpCtx.ModelMntp
            DrpMagUri ~ MagAdp.StMagUri
        )
        # "TODO Representing DRP itself this CpExplb will be omitted. Tofix"
        VertDrpCpExplb : CpSystExplorable
        EdgeCrpCtx : DesCtxSpl (
            _@ <  {
                DrpMntp : ExtdSystExploring
            }
            DrpMntp ~ VertDrpCpExplb
        )
        SCrpCreated_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB false"
            }
            Inp ~ IoAddWidg.Added
        )
        CrpAddedPulse : DesUtils.BChange (
            SInp ~ IoAddWidg.Added
        )
        # "Model components Iterator"
        CompsIter : DesUtils.IdxItr (
            InpCnt ~ MagAdp.CompsCount
            _ <  {
                InpDone ~ IoAddWidg.Added
            }
            InpDone ~ CrpAddedPulse.Outp
            InpReset ~ : SB_False
        )
        CompNameD : State {
            # "CompName delayed - aligned with CRP parent resolution"
            = "SS _INV"
            LogLevel = "Dbg"
        }
        CompsIter_Done_Dbg : State (
            _@ <  {
                = "SB _INV"
                LogLevel = "Dbg"
            }
            Inp ~ CompsIter.OutpDone
        )
        EdgesDbg : State (
            _@ <  {
                = "VPDU _INV"
                LogLevel = "Dbg"
            }
            Inp ~ MagAdp.Edges
        )
        # "Needs one more delay to be aligned with CRP perent resolution ver. 2"
        # "TODO to consider another solution"
        CompNameD1 : State {
            = "SS"
        }
        CompNameD1.Inp ~ CompName : TrAtVar (
            Inp ~ MagAdp.CompsNames
            Index ~ CompsIter.Outp
        )
        CompNameD.Inp ~ CompNameD1
        # "DRP source component adapter"
        CompAdp : DAdp (
            _@ <  {
                Parents : SdoParents
            }
            CpExploring ~ DrpCtx.ModelMntp
            InpMagUri ~ : TrApndVar (
                _@ < LogLevel = "Dbg"
                Inp1 ~ DrpCtx.DrpMagUri
                Inp2 ~ : TrToUriVar (
                    Inp ~ CompName
                )
            )
        )
        # "Model edges Iterator"
        EdgesIter : DesUtils.IdxItr (
            InpCnt ~ : TrSizeVar (
                Inp ~ MagAdp.Edges
            )
            InpReset ~ : SB_False
        )
        # "PrntMappingResolver2 works also. To decide what solution to use persistently"
        CrpResolver : DesUtils.PrntMappingResolver2 (
            InpMpg ~ CrpResMpg : State {
                LogLevel = "Verbose"
                = "VPDU ( PDU ( URI Vert , URI VertCrp ) , PDU ( URI Node , URI VertCrp ) )"
            }
            InpDefRes ~ CrpResDRes : Const {
                = "URI VertCrp"
            }
        )
        CrpResolver.InpParents ~ CompAdp.Parents
        CrpRes_Dbg : State (
            _@ < LogLevel = "Dbg"
            _@ < = "URI"
            Inp ~ CrpResolver.OutpRes
        )
        # "CRP creation"
        IoAddWidg.Name ~ CompNameD
        IoAddWidg.Parent ~ : TrTostrVar (
            Inp ~ CrpResolver.OutpRes
        )
        IoAddWidg.Enable ~ CmpCn_Ge : TrCmpVar (
            Inp ~ MagAdp.CompsCount
            Inp2 ~ : SI_1
        )
        # "Add widget to the first column (pos 2). Note that pos 1 corresponds to most left v-tunnel"
        IoAddWidg.Pos ~ : Const {
            = "SI 2"
        }
        # ">>> Edge CRPs creator"
        # "Creates edges and connects them to proper VertCrps"
        EdgeData : TrAtgVar (
            Inp ~ MagAdp.Edges
            Index ~ EdgesIter.Outp
        )
        EdgeData_Dbg : State (
            _@ <  {
                = "PDU _INV"
                LogLevel = "Dbg"
            }
            Inp ~ EdgeData
        )
        EdgeCrpName : TrApndVar (
            Inp1 ~ : Const {
                = "SS Edge_"
            }
            Inp2 ~ : TrTostrVar (
                Inp ~ EdgesIter.Outp
            )
        )
        CreateEdge : ASdcComp (
            _@ < LogLevel = "Dbg"
            Enable ~ CompsIter.OutpDone
            Name ~ EdgeCrpName
            Parent ~ : Const {
                = "SS EdgeCrp"
            }
        )
        ConnectEdgeP : ASdcConn (
            _@ < LogLevel = "Dbg"
            Enable ~ CreateEdge.Outp
            V1 ~ : TrApndVar (
                Inp1 ~ : TrTostrVar (
                    Inp ~ : TrAtgVar (
                        Inp ~ EdgeData
                        Index ~ : SI_0
                    )
                )
                Inp2 ~ ConnectEdgeP_V1suff : Const {
                    = "SS .EdgeCrpCp"
                }
            )
            V2 ~ : TrApndVar (
                Inp1 ~ EdgeCrpName
                Inp2 ~ : Const {
                    = "SS .VertCrpPCp"
                }
            )
        )
        ConnectEdgeQ : ASdcConn (
            _@ < LogLevel = "Dbg"
            Enable ~ CreateEdge.Outp
            V1 ~ : TrApndVar (
                Inp1 ~ : TrTostrVar (
                    Inp ~ : TrAtgVar (
                        Inp ~ EdgeData
                        Index ~ : SI_1
                    )
                )
                Inp2 ~ ConnectEdgeQ_V1suff : Const {
                    = "SS .EdgeCrpCp"
                }
            )
            V2 ~ : TrApndVar (
                Inp1 ~ EdgeCrpName
                Inp2 ~ : Const {
                    = "SS .VertCrpQCp"
                }
            )
        )
        EdgesIter.InpDone ~ : TrAndVar (
            _@ < LogLevel = "Dbg"
            Inp ~ ConnectEdgeP.Outp
            Inp ~ ConnectEdgeQ.Outp
        )
        # "<<< Edge CRPs creator"
        # "Vert CRP context"
        VertCrpCtx : DesCtxSpl {
            # "CRP parameters: positioning etc"
            CrpPars : ExtdStateOutp
        }
        {
            # ">>> Controller of CRPs ordering"
            # "CrpPars Iterator"
            CrpParsIter : DesUtils.InpItr (
                InpM ~ VertCrpCtx.CrpPars
                # "InpDone --> "
                ChgDet : DesUtils.ChgDetector (
                    Inp ~ VertCrpCtx.CrpPars
                )
                ChgDet.Cmp_Neq < LogLevel = "Dbg"
                InpReset ~ ChgDet.Outp
            )
            CrpParsIterDone_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SB _INV"
                }
                Inp ~ CrpParsIter.OutpDone
            )
            # "Selected CrpPars"
            SelectedCrpPars : TrInpSel (
                _@ < LogLevel = "Dbg"
                Inp ~ VertCrpCtx.CrpPars
                Idx ~ CrpParsIter.Outp
            )
            SelectedCrpPars_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "TPL,SS:name,SI:colpos,SI:pmrcolpos none -1 -1"
                }
                Inp ~ SelectedCrpPars
            )
            CrpColPos : TrTupleSel (
                Inp ~ SelectedCrpPars
                Comp ~ : Const {
                    = "SS colpos"
                }
            )
            CrpPmrColPos : TrTupleSel (
                Inp ~ SelectedCrpPars
                Comp ~ : Const {
                    = "SS pmrcolpos"
                }
            )
            CrpName : TrTupleSel (
                Inp ~ SelectedCrpPars
                Comp ~ : Const {
                    = "SS name"
                }
            )
            CrpName_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SS _INV"
                }
                Inp ~ CrpName
            )
            # "New column creation"
            ColumnSlotParent < = "SS ContainerMod.ColumnLayoutSlot"
            SColumnsCount : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SI"
                }
                Inp ~ ColumnsCount
            )
            SameColAsPair_Eq : TrCmpVar (
                _@ < LogLevel = "Dbg"
                Inp ~ CrpColPos
                Inp2 ~ CrpPmrColPos
            )
            SameColAsPair_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SB _INV"
                }
                Inp ~ SameColAsPair_Eq
            )
            NewColNeeded_Ge : TrCmpVar (
                _@ < LogLevel = "Dbg"
                Inp ~ CrpColPos
                Inp2 ~ LastColPos : TrAddVar (
                    Inp ~ ColumnsCount
                    InpN ~ : SI_1
                )
            )
            NewColNeeded_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SB _INV"
                }
                Inp ~ NewColNeeded_Ge
            )
            IoAddColumn (
                Enable ~ : TrAndVar (
                    Inp ~ SameColAsPair_Eq
                    Inp ~ NewColNeeded_Ge
                )
                Name ~ NewColName : TrApndVar (
                    Inp1 ~ : Const {
                        = "SS Column_"
                    }
                    Inp2 ~ : TrTostrVar (
                        # "Using delayed col count. TODO look at better solution"
                        Inp ~ SColumnsCount
                    )
                )
            )
            NewColNameDelayed : State (
                # "TODO Workaround to form correct outp. Redesign"
                _@ <  {
                    LogLevel = "Dbg"
                    = "SS"
                }
                Inp ~ NewColName
            )
            SdcCreateVtSlot : ASdcComp (
                # "Creating vtunnel slot"
                _@ < LogLevel = "Dbg"
                Enable ~ IoAddColumn.Done
                Name ~ SVtnlSlotName : TrApndVar (
                    Inp1 ~ NewColNameDelayed
                    Inp2 ~ : Const {
                        = "SS _vt"
                    }
                )
                Parent ~ : Const {
                    = "SS VertDrpVtSlot"
                }
            )
            SdcInsertVtSlot : ASdcInsert2 (
                # "Insert vtunnel slot"
                _@ < LogLevel = "Dbg"
                Enable ~ SdcCreateVtSlot.Outp
                Name ~ SVtnlSlotName
                Pname ~ KSEnd
                Prev ~ KS_Prev
                Next ~ KS_Next
            )
            # "Reposition CRP"
            IoReposWdg (
                Enable ~ SameColAsPair_Eq
                Enable ~ : TrNegVar (
                    _@ < LogLevel = "Dbg"
                    Inp ~ NewColNeeded_Ge
                )
                Name ~ CrpName
                ColPos ~ ColumnsCount
            )
            # "Completion of iteration"
            CrpParsIter.InpDone ~ ParsIter_InpDone : TrAndVar (
                _@ < LogLevel = "Dbg"
                Inp ~ : TrNegVar (
                    Inp ~ SameColAsPair_Eq
                )
                Inp ~ : TrIsValid (
                    Inp ~ CrpColPos
                )
            )
            CpReposCrpDone_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SB _INV"
                }
                Inp ~ IoReposWdg.Done
            )
            # "<<< Controller of CRPs ordering"
        }
        # "<<< VertDrp"
    }
    {
        # ">>> System representation"
        SystEdgeCpAdp : Syst {
            # "VertCrpEdgeCp extender-adapter. Series of adapters creates the chain from SystCrp EdgeCp to SystCpRP"
            # "Adapter calculates *CpAlloc - remember CpRp in panel can provide only coords relative to panel"
            # "This is one of design options of connecting edge to Syst CP RP"
            InpAlcX : ExtdStateInp
            InpAlcY : ExtdStateInp
            # "CP directed inside"
            Intr : VertCrpEdgeCpm
            # "CP directed outside"
            Extr : VertCrpEdgeCp (
                Int.ColumnPos ~ Intr.Int.ColumnPos
                Int.PairColumnPos ~ Intr.Int.PairColumnPos
                Int.Pos ~ Intr.Int.Pos
                Int.PairPos ~ Intr.Int.PairPos
                Int.LeftCpAlloc ~ : TrPair (
                    First ~ LcpAllocX : TrAdd2Var (
                        _@ < LogLevel = "Dbg"
                        Inp ~ : TrAtgVar (
                            Inp ~ Intr.Int.LeftCpAlloc
                            Index ~ : SI_0
                        )
                        Inp2 ~ InpAlcX.Int
                    )
                    Second ~ : TrAdd2Var (
                        Inp ~ : TrAtgVar (
                            Inp ~ Intr.Int.LeftCpAlloc
                            Index ~ : SI_1
                        )
                        Inp2 ~ InpAlcY.Int
                    )
                )
                Int.RightCpAlloc ~ : TrPair (
                    First ~ : TrAdd2Var (
                        Inp ~ : TrAtgVar (
                            Inp ~ Intr.Int.RightCpAlloc
                            Index ~ : SI_0
                        )
                        Inp2 ~ InpAlcX.Int
                    )
                    Second ~ : TrAdd2Var (
                        Inp ~ : TrAtgVar (
                            Inp ~ Intr.Int.RightCpAlloc
                            Index ~ : SI_1
                        )
                        Inp2 ~ InpAlcY.Int
                    )
                )
            )
        }
        SystEdgeCpAdpCreator : DAdp {
            InpMagU : ExtdStateInp
            InpEnable : ExtdStateInp
            InpCprpName : ExtdStateInp
            InpTargUri : ExtdStateInp
            # "Inside direction pair to connect, URI"
            InpIntrPair : ExtdStateInp
            Outp : ExtdStateOutp
            InpMagUri ~ InpMagU.Int
            CreateAdp : ASdcCompT (
                _@ < LogLevel = "Dbg"
                Enable ~ InpEnable.Int
                Target ~ InpTargUri.Int
                Name ~ InpCprpName.Int
                Parent ~ : Const {
                    = "SS SystEdgeCpAdp"
                }
            )
            ConnectAdp : ASdcConnT (
                _@ < LogLevel = "Dbg"
                Enable ~ CreateAdp.Outp
                Target ~ InpTargUri.Int
                V1 ~ : TrApndVar (
                    Inp1 ~ : TrToUriVar (
                        Inp ~ InpCprpName.Int
                    )
                    Inp2 ~ : Const {
                        = "URI Intr"
                    }
                )
                V2 ~ InpIntrPair.Int
            )
            ConnectAlcX : ASdcConnT (
                _@ < LogLevel = "Dbg"
                Enable ~ CreateAdp.Outp
                Target ~ InpTargUri.Int
                V1 ~ : TrApndVar (
                    Inp1 ~ : TrToUriVar (
                        Inp ~ InpCprpName.Int
                    )
                    Inp2 ~ : Const {
                        = "URI InpAlcX"
                    }
                )
                V2 ~ : Const {
                    = "URI AlcX"
                }
            )
            ConnectAlcY : ASdcConnT (
                _@ < LogLevel = "Dbg"
                Enable ~ CreateAdp.Outp
                Target ~ InpTargUri.Int
                V1 ~ : TrApndVar (
                    Inp1 ~ : TrToUriVar (
                        Inp ~ InpCprpName.Int
                    )
                    Inp2 ~ : Const {
                        = "URI InpAlcY"
                    }
                )
                V2 ~ : Const {
                    = "URI AlcY"
                }
            )
            Outp.Int ~ : TrAndVar (
                Inp ~ CreateAdp.Outp
                Inp ~ ConnectAdp.Outp
                Inp ~ ConnectAlcX.Outp
                Inp ~ ConnectAlcY.Outp
            )
        }
        CpRpsCreator : DAdp {
            # ">>> ConnPoints RPs creator"
            InpMagb : ExtdSystExploring
            InpMagu : ExtdStateInp
            # "INP: components names"
            InpCompNames : ExtdStateInp
            # "Input: Mapping parent to result"
            InpCcMpg : ExtdStateInp
            # "INP: Model link"
            InpMdlLink : ExtdSystExploring
            InpTargUri : ExtdStateInp
            # "IO : Cps container adding widget CP"
            CpAddInpRp : ContainerMod.DcAddWdgCp
            CpAddOutpRp : ContainerMod.DcAddWdgCp
            # "INP: System CRP link"
            InpCrpLink : ExtdSystExploring
            InpCrpUri : ExtdStateInp
            CpExploring ~ InpMagb.Int
            InpMagUri ~ InpMagu.Int
            CompsIter : DesUtils.VectIter (
                _@ < LogLevel = "Dbg"
                InpV ~ InpCompNames.Int
                InpReset ~ : SB_False
            )
            CompsIdxIsChanged : DesUtils.IsChanged (
                SInp ~ CompsIter.OutV
            )
            CompsIter.Sw2 < LogLevel = "Dbg"
            CompsIter.Sw1 < LogLevel = "Dbg"
            CompsIter.CidxAnd1 < LogLevel = "Dbg"
            CompNames_Dbg : State (
                _@ < LogLevel = "Dbg"
                _@ < = "VDU"
                Inp ~ InpCompNames.Int
            )
            CompsIter_Dbg : State (
                _@ < LogLevel = "Dbg"
                _@ < = "URI"
                Inp ~ CompsIter.OutV
            )
            CompAdapter : DAdp (
                _@ <  {
                    LogLevel = "Dbg"
                    Parents : SdoParents
                }
            )
            CompAdapter.CpExploring ~ InpMdlLink.Int
            CompAdapter.InpMagUri ~ CompAdapter_InpMagUri : TrApndVar (
                _@ < LogLevel = "Dbg"
                Inp1 ~ InpTargUri.Int
                Inp2 ~ CompsIter.OutV
            )
            # "Redesigned acc to ds_csd_s1"
            CpResolver : DesUtils.PrntMappingResolverD (
                InpParents ~ CompAdapter.Parents
                InpMpg ~ InpCcMpg.Int
                InpDefRes ~ : Const {
                    = "URI"
                }
                InpRset ~ CompsIdxIsChanged.Outp
            )
            IsOutput_Eq : TrCmpVar (
                _@ < LogLevel = "Dbg"
                Inp ~ CpResolver.OutpRes
                Inp2 ~ : State {
                    = "URI SysOutpRp"
                }
            )
            CprpName : TrTostrVar (
                Inp ~ CompsIter.OutV
            )
            # "Add CpRp widget"
            CpAddOutpRp  (
                Name ~ CprpName
                Parent ~ : TrTostrVar (
                    Inp ~ CpResolver.OutpRes
                )
                Enable ~ IsOutput_Eq
            )
            CpAddInpRp  (
                Name ~ CprpName
                Parent ~ : TrTostrVar (
                    Inp ~ CpResolver.OutpRes
                )
                Enable ~ EnableAddInpRp : TrNegVar (
                    Inp ~ IsOutput_Eq
                )
            )
            EcpAdpCreatorPanel : SystEdgeCpAdpCreator (
                # "Edge CP adapter in panel (Inputs, Outputs) creator "
                EcpAdpCreatorPanel.CpExploring ~ InpMagb.Int
                InpMagU ~ InpMagu.Int
                InpEnable ~ : TrOrVar (
                    Inp ~ CpAddInpRp.Added
                    Inp ~ CpAddOutpRp.Added
                )
                InpCprpName ~ PnlAdpName : TrApndVar (
                    Inp1 ~ CprpName
                    Inp2 ~ PnlAdpSuffix : Const {
                        = "SS _Pnladp"
                    }
                )
                EcpAdpCreatorPanel.InpTargUri ~ TargUri : TrSwitchBool (
                    Inp1 ~ : Const {
                        = "URI Body.Inputs"
                    }
                    Inp2 ~ : Const {
                        = "URI Body.Outputs"
                    }
                    Sel ~ IsOutput_Eq
                )
                InpIntrPair ~ : TrApndVar (
                    Inp1 ~ : TrToUriVar (
                        Inp ~ CprpName
                    )
                    Inp2 ~ : Const {
                        = "URI EdgeCrpCp "
                    }
                )
            )
            EcpAdpCreatorBody : SystEdgeCpAdpCreator (
                # "Edge CP adapter in CRP body creator "
                EcpAdpCreatorBody.CpExploring ~ InpMagb.Int
                InpMagU ~ InpMagu.Int
                InpEnable ~ EcpAdpCreatorPanel.Outp
                InpCprpName ~ BodyAdpName : TrApndVar (
                    Inp1 ~ CprpName
                    Inp2 ~ BdAdpSuffix : Const {
                        = "SS _Bdadp"
                    }
                )
                EcpAdpCreatorBody.InpTargUri ~ : Const {
                    = "URI Body"
                }
                InpIntrPair ~ : TrApndVar (
                    Inp1 ~ : TrSwitchBool (
                        Inp1 ~ : Const {
                            = "URI Inputs"
                        }
                        Inp2 ~ : Const {
                            = "URI Outputs"
                        }
                        Sel ~ IsOutput_Eq
                    )
                    Inp2 ~ : TrApndVar (
                        Inp1 ~ : TrToUriVar (
                            Inp ~ PnlAdpName
                        )
                        Inp2 ~ : Const {
                            = "URI Extr"
                        }
                    )
                )
            )
            EcpAdpCreatorCrp : SystEdgeCpAdpCreator (
                # "Edge CP adapter in CRP creator "
                EcpAdpCreatorCrp.CpExploring ~ InpMagb.Int
                InpMagU ~ InpMagu.Int
                InpEnable ~ EcpAdpCreatorBody.Outp
                InpCprpName ~ CrpAdpName : TrApndVar (
                    Inp1 ~ CprpName
                    Inp2 ~ : Const {
                        = "SS _Crpdp"
                    }
                )
                EcpAdpCreatorCrp.InpTargUri ~ : Const {
                    = "URI ''"
                }
                InpIntrPair ~ : TrApndVar (
                    Inp1 ~ : Const {
                        = "URI Body"
                    }
                    Inp2 ~ : TrApndVar (
                        Inp1 ~ : TrToUriVar (
                            Inp ~ BodyAdpName
                        )
                        Inp2 ~ : Const {
                            = "URI Extr"
                        }
                    )
                )
            )
            CreateCprpPx : ASdcComp (
                _@ < LogLevel = "Dbg"
                Enable ~ EcpAdpCreatorCrp.Outp
                Name ~ CprpName
                Parent ~ : Const {
                    = "SS CpRpPx"
                }
            )
            ConnectCprpExtd : ASdcConn (
                _@ < LogLevel = "Dbg"
                Enable ~ CreateCprpPx.Outp
                V1 ~ : TrApndVar (
                    Inp1 ~ CprpName
                    Inp2 ~ : Const {
                        = "SS .EdgeCrpCp.Int"
                    }
                )
                V2 ~ : TrApndVar (
                    Inp1 ~ CrpAdpName
                    Inp2 ~ : Const {
                        = "SS .Extr"
                    }
                )
            )
            CompsIter.InpDone ~ ConnectCprpExtd.Outp
            # "<<< ConnPoints collector"
        }
        SystCpRp : FvWidgets.FLabel {
            # ">>> System connpoint representation"
            # "TODO It duplicates many subs from VertCrp. To redesign separating common subs."
            # "Extend widget CP to for positions io"
            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.0 0.0 0.0"
            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
            CpRpName : SdoName
            SText.Inp ~ CpRpName
            # "CP RP context"
            CpRpCtx : DesCtxCsm {
                # "Parameters: positioning etc"
                # "type - type of CP RP : 0 - inp, 1 - out"
                CprpPars : ExtdStateInp
                ColPos : ExtdStateOutp
                ItemPos : ExtdStateOutp
            }
            # "Edge CRP connpoint"
            EdgeCrpCp : VertCrpEdgeCp (
                Int.ColumnPos ~ CpRpCtx.ColPos
                Int.Pos ~ Tpl1 : TrTuple (
                    Inp ~ : State {
                        = "TPL,SI:col,SI:item -1 -1"
                    }
                    _@ <  {
                        col : CpStateInp
                        item : CpStateInp
                    }
                    col ~ CpRpCtx.ColPos
                    item ~ CpRpCtx.ItemPos
                )
                # "LeftCpAlloc -> "
            )
            _ <  {
                Tpl1_Dbg : State (
                    _@ <  {
                        = "TPL,SI:col,SI:item -1 -1"
                        LogLevel = "Dbg"
                    }
                    Inp ~ Tpl1
                )
            }
            _ <  {
                ColumnPos_Dbg : State (
                    _@ <  {
                        = "SI _INV"
                        LogLevel = "Dbg"
                    }
                    Inp ~ CpRpCtx.ColPos
                )
            }
            # ">>> Most right/left column of the pairs"
            # "   Inputs Iterator"
            PairPosIter : DesUtils.InpItr (
                InpM ~ EdgeCrpCp.Int.PairPos
                InpDone ~ : SB_True
                PosChgDet : DesUtils.ChgDetector (
                    Inp ~ EdgeCrpCp.Int.PairPos
                )
                InpReset ~ PosChgDet.Outp
            )
            PairPosIterDone_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SB _INV"
                }
                Inp ~ PairPosIter.OutpDone
            )
            # "   Selected input"
            PairPosSel : TrInpSel (
                Inp ~ EdgeCrpCp.Int.PairPos
                Idx ~ PairPosIter.Outp
            )
            PairPosSel_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "TPL,SI:col,SI:item -1 -1"
                }
                Inp ~ PairPosSel
            )
            MostRightColPair : State (
                # "Exclude pair in same CRP to keep CRP positioning working"
                _@ <  {
                    LogLevel = "Dbg"
                    = "TPL,SI:col,SI:item -1 -1"
                }
                Inp ~ : TrSwitchBool (
                    Inp1 ~ MostRightColPair
                    Inp2 ~ PairPosSel
                    Sel ~ : TrAndVar (
                        Inp ~ ColPos_Ge : TrCmpVar (
                            Inp ~ PairPosSel_col : TrTupleSel (
                                Inp ~ PairPosSel
                                Comp ~ : State {
                                    = "SS col"
                                }
                            )
                            Inp2 ~ : TrTupleSel (
                                Inp ~ MostRightColPair
                                Comp ~ : State {
                                    = "SS col"
                                }
                            )
                        )
                        Inp ~ IsntSamePos : TrOrVar (
                            # "Pair isn't on the same position as current CP RP"
                            Inp ~ ColPos_Neq : TrCmpVar (
                                Inp ~ PairPosSel_col
                                Inp2 ~ CpRpCtx.ColPos
                            )
                            Inp ~ ItemPos_Neq : TrCmpVar (
                                Inp ~ PairPosSel_item : TrTupleSel (
                                    Inp ~ PairPosSel
                                    Comp ~ : Const {
                                        = "SS item"
                                    }
                                )
                                Inp2 ~ CpRpCtx.ItemPos
                            )
                        )
                    )
                )
            )
            MostLeftColPair : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "TPL,SI:col,SI:item 1000 -1"
                }
                Inp ~ : TrSwitchBool (
                    Inp1 ~ MostLeftColPair
                    Inp2 ~ PairPosSel
                    Sel ~ ColPos_Le : TrCmpVar (
                        Inp ~ : TrTupleSel (
                            Inp ~ PairPosSel
                            Comp ~ : State {
                                = "SS col"
                            }
                        )
                        Inp2 ~ : TrTupleSel (
                            Inp ~ MostLeftColPair
                            Comp ~ : State {
                                = "SS col"
                            }
                        )
                    )
                )
            )
            # "<<< Most right/left column of the pairs"
            # " Connect parameters to context"
            CpRpCtx.CprpPars ~ CprpPars_Src : TrTuple (
                _@ <  {
                    type : CpStateInp
                    name : CpStateInp
                    colpos : CpStateInp
                    pmrcolpos : CpStateInp
                    pmlcolpos : CpStateInp
                }
                Inp ~ : State {
                    = "TPL,SI:type,SS:name,SI:colpos,SI:pmrcolpos,SI:pmlcolpos 0 _INV -2 -1 1000"
                }
                name ~ CpRpName
                colpos ~ CpRpCtx.ColPos
                pmrcolpos ~ : TrTupleSel (
                    Inp ~ MostRightColPair
                    Comp ~ : State {
                        = "SS col"
                    }
                )
                pmlcolpos ~ : TrTupleSel (
                    Inp ~ MostLeftColPair
                    Comp ~ : State {
                        = "SS col"
                    }
                )
            )
            # "Left connpoint allocation"
            LeftCpAlc : TrPair (
                Second ~ CpAlcY : TrAddVar (
                    Inp ~ AlcY
                    Inp ~ : TrDivVar (
                        Inp ~ AlcH
                        Inp2 ~ : Const {
                            = "SI 2"
                        }
                    )
                )
            )
            EdgeCrpCp.Int.LeftCpAlloc ~ LeftCpAlc
            # "Right connpoint allocation"
            RightCpAlcX : TrAddVar (
                Inp ~ AlcX
                Inp ~ AlcW
            )
            RightCpAlc : TrPair (
                Second ~ CpAlcY
            )
            EdgeCrpCp.Int.RightCpAlloc ~ RightCpAlc
            # "<<< System connpoint representation"
        }
        CpRpPx : Syst {
            # "CpRp proxy. Represents CpRp directly in Crp"
            EdgeCrpCp : VertCrpEdgeCpExtd
        }
        SysInpRp : SystCpRp {
            # ">>> System input representation"
            CprpPars_Src.type ~ : SI_0
            LeftCpAlc.First ~ AlcX
            # "Negative X allocation indicates that InpRp doesn't provide RightCpAlc"
            RightCpAlc.First ~ : Const {
                = "SI -100000"
            }
            # "<<< System input representation"
        }
        SysOutpRp : SystCpRp {
            # ">>> System output representation"
            CprpPars_Src.type ~ : SI_1
            # "Negative X allocation indicates that InpRp doesn't provide LeftCpAlc"
            LeftCpAlc.First ~ : Const {
                = "SI -100000"
            }
            RightCpAlc.First ~ RightCpAlcX
            # "<<< System output representation"
        }
        SystCrpCpa : ContainerMod.DVLayout {
            # ">>> System CRP connpoints area"
            Start.Prev.Int.AlcX ~ : SI_0
            Start.Prev.Int.AlcY ~ : SI_0
            # "<<< System CRP connpoints area"
        }
        SystCrp : CrpBase {
            # ">>> System compact representation"
            # "Extend widget CP to for positions io"
            Cp <  {
                ItemPos : CpStateInp
                ColumnPos : CpStateInp
            }
            MagAdp <  {
                CompsUri : SdoCompsUri
            }
            # "CP RP context"
            CpRpCtx : DesCtxSpl {
                # "Parameters: positioning etc"
                CprpPars : ExtdStateOutp
                ColPos : ExtdStateInp
                ItemPos : ExtdStateInp
            }
            CpRpCtx  (
                ColPos ~ Cp.Int.ColumnPos
                ItemPos ~ Cp.Int.ItemPos
            )
            CprpIter : DesUtils.InpItr (
                InpM ~ CpRpCtx.CprpPars
                InpDone ~ : SB_True
                ChgDet : DesUtils.ChgDetector (
                    Inp ~ CpRpCtx.CprpPars
                )
                InpReset ~ ChgDet.Outp
            )
            CprpIterDone_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SB _INV"
                }
                Inp ~ CprpIter.OutpDone
            )
            # "   Selected input"
            CprpIterSel : TrInpSel (
                Inp ~ CpRpCtx.CprpPars
                Idx ~ CprpIter.Outp
            )
            CprpIterSel_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "TPL,SI:type,SS:name,SI:colpos,SI:pmrcolpos,SI:pmlcolpos 0 _INV -2 -1 -1"
                }
                Inp ~ CprpIterSel
            )
            InpMostRightPair : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SI -1"
                }
                Inp ~ : TrSwitchBool (
                    Inp1 ~ InpMostRightPair
                    Inp2 ~ PosFromCpRp : TrTupleSel (
                        Inp ~ CprpIterSel
                        Comp ~ : State {
                            = "SS pmrcolpos"
                        }
                    )
                    Sel ~ : TrAndVar (
                        Inp ~ ColPos_Ge : TrCmpVar (
                            Inp ~ PosFromCpRp
                            Inp2 ~ InpMostRightPair
                        )
                        Inp ~ Type_Eq : TrCmpVar (
                            Inp ~ : TrTupleSel (
                                Inp ~ CprpIterSel
                                Comp ~ : State {
                                    = "SS type"
                                }
                            )
                            Inp2 ~ : SI_0
                        )
                    )
                )
            )
            OutpMostLeftPair : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "SI 1000"
                }
                Inp ~ OutpMostLeftPair_Inp : TrSwitchBool (
                    _@ < LogLevel = "Dbg"
                    Inp1 ~ OutpMostLeftPair
                    Inp2 ~ LPosFromCpRp : TrTupleSel (
                        Inp ~ CprpIterSel
                        Comp ~ : State {
                            = "SS pmlcolpos"
                        }
                    )
                    Sel ~ : TrAndVar (
                        Inp ~ ColPos_Le : TrCmpVar (
                            Inp ~ LPosFromCpRp
                            Inp2 ~ OutpMostLeftPair
                        )
                        Inp ~ LType_Eq : TrCmpVar (
                            Inp ~ : TrTupleSel (
                                Inp ~ CprpIterSel
                                Comp ~ : Const {
                                    = "SS type"
                                }
                            )
                            Inp2 ~ : SI_1
                        )
                    )
                )
            )
            # "Vert CRP context"
            VertCrpCtx : DesCtxCsm {
                # "CRP parameters: positioning etc"
                CrpPars : ExtdStateInp
            }
            VertCrpCtx.CrpPars ~ : TrTuple (
                _@ < LogLevel = "Dbg"
                _@ <  {
                    name : CpStateInp
                    colpos : CpStateInp
                    pmrcolpos : CpStateInp
                    pmlcolpos : CpStateInp
                }
                Inp ~ : State {
                    = "TPL,SS:name,SI:colpos,SI:pmrcolpos,SI:pmrcolpos _INV -2 -1 1000"
                }
                name ~ MagAdp.Name
                colpos ~ Cp.Int.ColumnPos
                pmrcolpos ~ InpMostRightPair
                pmlcolpos ~ OutpMostLeftPair
            )
            Body : ContainerMod.DHLayout {
                CntAgent < LogLevel = "Err"
                # "Visualization paremeters"
                VisPars : Des {
                    Border : State {
                        = "SB true"
                    }
                }
                FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
                End.Next !~ Start.Prev
                Inputs : SystCrpCpa {
                    BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.0 0.0 0.0"
                    FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
                    XPadding < = "SI 1"
                    YPadding < = "SI 1"
                }
                Slot_Inputs : ContainerMod.FHLayoutSlot (
                    Next ~ Start.Prev
                    SCp ~ Inputs.Cp
                )
                Start.Prev.Int.AlcX ~ : SI_1
                Start.Prev.Int.AlcY ~ : SI_1
                Outputs : SystCrpCpa {
                    CntAgent < LogLevel = "Err"
                    BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.0 0.0 0.0"
                    FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
                    XPadding < = "SI 1"
                    YPadding < = "SI 1"
                    CreateWdg < LogLevel = "Dbg"
                    AddSlot < LogLevel = "Dbg"
                    SdcInsert < LogLevel = "Dbg"
                    SdcConnWdg < LogLevel = "Dbg"
                }
                Slot_Outputs : ContainerMod.FHLayoutSlot (
                    Next ~ Slot_Inputs.Prev
                    Prev ~ End.Next
                    SCp ~ Outputs.Cp
                )
                Inputs.CreateWdg < LogLevel = "Dbg"
                Inputs.AddSlot < LogLevel = "Dbg"
                Inputs.SdcInsert < LogLevel = "Dbg"
                Inputs.SdcConnWdg < LogLevel = "Dbg"
            }
            Slot_Body : ContainerMod.FVLayoutSlot (
                Next ~ Slot_Header.Prev
                Prev ~ End.Next
                SCp ~ Body.Cp
            )
            Controller : CpRpsCreator (
                InpCompNames ~ MagAdp.CompsUri
                InpMdlLink ~ CrpCtx.ModelMntp
                InpTargUri ~ MagAdpMUri
                InpCcMpg ~ : State {
                    = "VPDU ( PDU ( URI ExtdStateInp , URI SysInpRp ) , PDU ( URI ExtdStateOutp , URI SysOutpRp ), PDU ( URI CpStateInp , URI SysInpRp ), PDU ( URI CpStateOutp , URI SysOutpRp ) )"
                }
                CpAddOutpRp.Int ~ Body.Outputs.IoAddWidg
                CpAddInpRp.Int ~ Body.Inputs.IoAddWidg
                InpMagb ~ CpExplorable
                InpMagu ~ : Const {
                    = "URI ''"
                }
            )
            # "<<< System compact representation"
        }
        VertcCrp : SystCrp {
            # "Vertex CRP displaying connpoints"
            # "Edge CRP connpoint"
            EdgeCrpCp : VertCrpEdgeCp (
                Int.ColumnPos ~ Cp.Int.ColumnPos
                Int.Pos ~ Tpl1 : TrTuple (
                    Inp ~ : State {
                        = "TPL,SI:col,SI:item -1 -1"
                    }
                    _@ <  {
                        col : CpStateInp
                        item : CpStateInp
                    }
                    col ~ Cp.Int.ColumnPos
                    item ~ Cp.Int.ItemPos
                )
            )
            # "Right connpoint allocation"
            RightCpAlc : TrPair (
                First ~ : TrAddVar (
                    Inp ~ AlcX
                    Inp ~ AlcW
                )
                Second ~ CpaY : TrAddVar (
                    Inp ~ AlcY
                    Inp ~ : TrDivVar (
                        Inp ~ AlcH
                        Inp2 ~ : State {
                            = "SI 2"
                        }
                    )
                )
            )
            EdgeCrpCp.Int.RightCpAlloc ~ RightCpAlc
            # "Left connpoint allocation"
            LeftCpAlc : TrPair (
                # "Negative X allocation indicates that InpRp doesn't provide LeftCpAlc"
                First ~ : Const {
                    = "SI -100000"
                }
                Second ~ CpaY
            )
            EdgeCrpCp.Int.LeftCpAlloc ~ LeftCpAlc
        }
        # "<<< System representation"
        SystDrp : VertDrp {
            # ">>> System detailed representation"
            _ <  {
                # "ing"
                AddSlot < LogLevel = "Dbg"
                SdcConnWdg < LogLevel = "Dbg"
                SdcInsert < LogLevel = "Dbg"
            }
            # "Adjust CRP resolver"
            CrpResMpg < = "VPDU ( PDU ( URI Syst , URI SystCrp ) , PDU ( URI State , URI VertcCrp ) , PDU ( URI Const , URI VertcCrp ) , PDU ( URI TrBase , URI VertcCrp )  , PDU ( URI ExtdStateOutp , URI VertcCrp )  , PDU ( URI ExtdStateInp , URI VertcCrp ) ,  PDU ( URI Vert , URI VertCrp ) , PDU ( URI Vertu , URI VertCrp ) , PDU ( URI Node , URI VertCrp ) )"
            CrpResDRes < = "URI SystCrp"
            _ <  {
                # "Modify EdgeP target"
                ConnectEdgeP_V1suff < = "SS ''"
                ConnectEdgeQ_V1suff < = "SS ''"
            }
            SelectedCrpPars_Dbg < = "TPL,SS:name,SI:colpos,SI:pmrcolpos,SI:pmlcolpos  none -1 -1 1000"
            # "<<< System detailed representation"
        }
    }
    VrControllerCp : Socket3Extd {
        About = "Vis representation view CP"
        NavCtrl : Socket3 {
            About = "Navigation control"
            CmdUp : CpStateInp
            NodeSelected : CpStateInp
            MutAddWidget : ContainerMod.DcAddWdgSc
            MutRmWidget : ContainerMod.DcRmWdgSc
            DrpCreated : CpStateInp
            DrpCp : NDrpSc
        }
    }
    VrViewCp : Socket3Extd {
        About = "Vis representation controller CP"
        NavCtrl : Socket3 {
            About = "Navigation control"
            CmdUp : CpStateOutp
            NodeSelected : CpStateOutp
            MutAddWidget : ContainerMod.DcAddWdgS
            MutRmWidget : ContainerMod.DcRmWdgS
            DrpCreated : CpStateOutp
            DrpCp : NDrpS
        }
    }
    VrController : Des {
        # " Visual representation controller"
        # "CP binding to view"
        CtrlCp : VrControllerCp
        ModelMnt : AMntp {
            # "TODO FIXME Not setting EnvVar here casuses wrong navigation in modnav"
            LogLevel = "Dbg"
            EnvVar = "Model"
            CpExpbl : CpSystExplorable
        }
        CtrlCp.Int.NavCtrl.DrpCp.InpModelMntp ~ ModelMnt.CpExpbl
        # " Cursor"
        Cursor : State {
            LogLevel = "Dbg"
            = "URI"
        }
        DbgCmdUp : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB false"
            }
            Inp ~ CtrlCp.Int.NavCtrl.CmdUp
        )
        # "NodeSelected Pulse"
        Nsp : DesUtils.DPulse (
            InpD ~ CtrlCp.Int.NavCtrl.NodeSelected
            InpE ~ : Const {
                = "URI"
            }
        )
        Nsp.Delay < = "URI"
        Nsp.Delay < LogLevel = "Dbg"
        NspDbg : State {
            LogLevel = "Dbg"
            = "URI"
        }
        NspDbg.Inp ~ Nsp.Outp
        Cursor.Inp ~ Cursor_Inp : TrSwitchBool (
            _@ < LogLevel = "Dbg"
            Sel ~ CtrlCp.Int.NavCtrl.CmdUp
            Inp1 ~ Tr1Dbg : TrSwitchBool (
                _@ < LogLevel = "Dbg"
                Sel ~ : TrIsValid (
                    Inp ~ Cursor
                )
                Inp1 ~ Const_SMdlRoot : State {
                    = "URI ''"
                }
                Inp2 ~ : TrSvldVar (
                    Inp1 ~ : TrApndVar (
                        Inp1 ~ Cursor
                        Inp2 ~ Nsp.Outp
                    )
                    Inp2 ~ Cursor
                )
            )
            Inp2 ~ CursorOwner : TrHeadtnVar (
                _@ < LogLevel = "Dbg"
                Inp ~ Cursor
                Tlen ~ : SI_1
            )
        )
        # "For debugging only"
        DbgCursorOwner : State (
            _@ <  {
                LogLevel = "Dbg"
                = "URI"
            }
            Inp ~ CursorOwner
        )
        # " DRP creation"
        CpAddDrp : ContainerMod.DcAddWdgCp
        CpAddDrp.Int ~ CtrlCp.Int.NavCtrl.MutAddWidget
        CpAddDrp.Name ~ : Const {
            = "SS Drp"
        }
        CpAddDrp.Parent ~ : Const {
            = "SS AvrMdl2.SystDrp"
        }
        CpAddDrp.Mut ~ : Const {
            = "CHR2 '{ CreateWdg < LogLevel = \\\"Dbg\\\" }'"
        }
        DrpAddedPulse : DesUtils.BChange (
            SInp ~ CpAddDrp.Added
        )
        # " Model URI"
        SMdlUri : State (
            _@ <  {
                LogLevel = "Dbg"
                = "URI ''"
            }
            Inp ~ MdlUri : TrSwitchBool (
                _@ < LogLevel = "Dbg"
                Sel ~ CpAddDrp.Added
                Inp1 ~ Cursor
                Inp2 ~ SMdlUri
            )
        )
        CtrlCp.Int.NavCtrl.DrpCp.InpModelUri ~ SMdlUri
        # " VRP dirty indication"
        VrpDirty : State {
            LogLevel = "Dbg"
            = "SB false"
        }
        VrpDirty.Inp ~ VrpDirty_Inp : TrAndVar (
            _@ < LogLevel = "Dbg"
            Inp ~ U_Neq : TrCmpVar (
                Inp ~ SMdlUri
                Inp2 ~ Cursor
            )
            Inp ~ CpAddDrp.Added
            Inp ~ : TrIsValid (
                Inp ~ SMdlUri
            )
        )
        # " DRP removal on VRP dirty"
        CpRmDrp : ContainerMod.DcRmWdgCp
        CpRmDrp.Int ~ CtrlCp.Int.NavCtrl.MutRmWidget
        CpRmDrp.Name ~ : Const {
            = "SS Drp"
        }
        CpRmDrp.Enable ~ VrpDirty
        Dbg_DrpRemoved : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB _INV"
            }
            Inp ~ CpRmDrp.Done
        )
        DrpRemovedPulse : DesUtils.BChange (
            SInp ~ CpRmDrp.Done
        )
        SDrpCreated_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB false"
            }
            Inp ~ CpAddDrp.Added
        )
        DrpAddedTg : DesUtils.RSTg (
            InpS ~ DrpAddedPulse.Outp
            InpR ~ DrpRemovedPulse.Outp
        )
        CpAddDrp.Enable ~ : TrNegVar (
            Inp ~ DrpAddedTg.Outp
        )
    }
}
