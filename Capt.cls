VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Capt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Option Compare Binary


'�����_���̂悤�Ȃ��̂���������N���X
'�@���I�Ɋ֐��𐶐����A�ȍ~�̓R�[�h�̕����񂩂玫�������Ŏ擾�ł���悤�ɂ���B
'�@�܂��擾�����֐��� Delegate �I�u�W�F�N�g�ɃZ�b�g���āA�J��Ԃ����s�ł���B



'�R�[�h��������̏���

'�@[ [ [�������X�g] : �L���v�`���������X�g ] => ] �s ( �� | <result> = �߂�l�̎� | �� ) { ; �s }
'
'�@�i����ȃP�[�X�Ƃ��ĒP��s�������Ɂu>�v������ꍇ�́A�߂�l�̎��Ƃ��ĉ��߂����j
'
'�@��F
'�@�@x => x = x + 1                 ... x �� ByRef �ł���A�߂�l�� Empty
'�@�@<result> = 2                   ... ��������炸 2 ���Ԃ�
'�@�@> 2                            ... <result> = 2 �Ɠ���
'�@�@x =>> x + 1                    ...�u=>�v�Ɓu>�v�͑����ď����K�v�����邽�߁u=>>�v�ƂȂ�i�ԂɃX�y�[�X������ƍs���Ƃ��ĉ��߂���Ȃ��Ȃ�j
'�@�@x : cap => x = x + cap         ... : �̌�̓L���v�`���ϐ��i Capt.Capture() �ɓn�������ɑΉ�����j
'�@�@: cap1 =>> capt1 + 1           ... �L���v�`���ϐ��̑O�� : �͏ȗ��ł��Ȃ�
'�@�@x, y => x = x + 1; y = y + 1   ... �����̕��� ; �ŋ�؂�i������ȊO�� ; �͑S�ĉ��s�ɒu�������j
'
'�@���G�ȗ�F
'�@�@x, y, z : capt1, capt2 => y = 1; z = x + y; <result> = x + 1;


'�@�E������� '' �Ŋ���B
'�@�@�����񒆂Ɂu\'�v�Ɠ��͂����ꍇ�A�����ň�U escChar_ �ƂȂ�A�ŏI�I�ɂ́u'�v�ɓW�J�����B
'�@�@�i escChar_ = Chr(1) �����A���v���낤���H�H�j
'�@�@$'abc{def}ghi' �Ƃ���ƁAdef �͕ϐ����Ƃ��ēW�J�����B���̏ꍇ�A�u{{�v�u}}�v���u{�v�u}�v�̃G�X�P�[�v�ƂȂ�B
'
'�@�E�P��s���A���ߕ��s�����u>�v�Ŏn�܂�R�[�h�́A�l��Ԃ����Ƃ��ĉ��߂����B
'�@�@��F   Capt( "> 0 + 1" )       ... ���ߕ��́u> 0 + 1�v�ƂȂ�B
'�@�@       Capt( "x =>> x + 1" )   ...�ux �v�u=>�v�u> x + 1�v�Ɖ��߂���A���ߕ��́u> x + 1�v�ƂȂ�B
'�@�@       Capt( "x =>> x + 1;" )  ...�ux �v�u=>�v�u> x + 1�v�u�v�Ɖ��߂���A���ߕ��́u> x + 1�v����сu�v�i��s�j��
'                                       �Q�s�ƂȂ邽�߁A�G���[�ƂȂ�B
'�@�@���u>�v�K�v�Ȃ��̎������ʂƂ������������A�����͂��ʓ|�Ȃ̂ł�߂܂����c�B
'
'�@�E���s�R�[�h���܂�ł����Ȃ����A�����Łu;�v�ɒu����������B
'
'�@�E�����^�L���v�`�������ɂ͌^���w��ł��邪�A�Ăяo������ variant ���o�R���ēn����邽�߁A�����Ō^�`�F�b�N�Ɉ��������邽�߁A���p�ł��Ȃ��B
'


'�R�[�h��������������L�[�Ƃ��āA���I�ɐ������ꂽ���\�b�h�̃f���Q�[�g���Ăяo���B

'�����̃L�[�Ƃ���R�[�h�́A�f�̂܂܂Ƃ����B
'�@���[�̃g�����⏬�������A�d���X�y�[�X���������l�������A�d���o�^�����֐����擾�̌y����D�悷�邱�Ƃɂ����B
'�@�b��v�����B

'�{���W���[�����̕������r�͊�{�I�Ƀo�C�i����r
'�@�E���^�[�����L���Ƃ̔�r����������
'�@�E������R�[�h���̎����������o�C�i����r�i���I�֐��S�~�����܂邱�Ƃ������������̑��x��D��A�Ӗ��Ȃ����H�j
'
'�@�ȉ��̓񂩏��ł̂݃e�L�X�g��r�g�p
'�@�@parseCode_()               -> replace()    ... "<result>" �u��
'�@�@buildCaptureVariables_()   -> split()      ... "as" ����
'
'�@�{���W���[���Ŏg�p���Ă����r�֐���
'�@�@replace(), split(), like



'���K�\���g���ׂ����������Ȃ��c�B
'�@�Q�Ɛݒ肪�ʓ|�Ǝv���Ă�߂��񂾂��ǁc�X�N���v�e�B���O�g�����ꏏ���������Ȃ��c�B
'�@���̂����u�������Ă������c�B





'�萔��` ----

Private Const cMainCodeHolderName$ = "DynamicCode"
Private Const cTmpNameHeader$ = "ZTmp"
Private Const cTmpStdModuleName$ = "ZTmpDynamic"
Private Const cFuncNameHeader$ = "Func"
Private Const cCollNameHeader$ = "coll"
Private Const cDictNameHeader$ = "dict"
Private Const cNameForDynamicCodeSearch$ = "????#*"




'�����o�錾 ============================================================





'������R�[�h�� ��  �ւ̑Ή������B

Private delegates_ As New Dictionary








Private escChar_$ '���s�╶������u\'�v�̃G�X�P�[�v�Ɏg�p����B

Private Sub initVariable_()
    
    delegates_.CompareMode = vbBinaryCompare
    
    escChar_ = Chr(1)
    
End Sub







'������R�[�h���̃L���v�`�� ===========================================================


'�R�[�h��������ƃL���v�`���p�����[�^����荞�ށB�f�t�H���g���\�b�h�B

Public Function Capture(code_$, ParamArray captureParams_()) As IFunc
Attribute Capture.VB_UserMemId = 0
    
    If code_ = "" Then Exit Function '�����n����Ȃ��ꍇ�� Nothing ��Ԃ��B���G���[�����ɂ��ׂ����H
    
    
    
    '�f���Q�[�g���쐬����^�쐬�ς݂��擾����B
    
    Set Capture = getFunc_(CStr(code_))
    
    
    
    '�L���v�`������������΁A�^���N���[�W���f���Q�[�g�ɂ��ĕԂ��B
    
    If IsMissing(captureParams_) Then Exit Function
    
    Dim d_ As Delegate
    Set d_ = Capture
    Set d_ = d_.Clone.SetMethod(object_:=d_.Target.Instantiate)
    
    d_.Target.Captures = captureParams_
    
    Set Capture = d_
    
    
End Function


'�󂯎�����R�[�h�������񂩂�A���s���ׂ��֐��I�u�W�F�N�g��Ԃ��B
'�@�����ς݂Ȃ炻���Ԃ����A�������Ȃ�u�a�`�R�[�h�𓮓I��������B

Private Function getFunc_(code_$) As Delegate
    
    
    On Error Resume Next
    
    Set getFunc_ = delegates_(code_)
    
    On Error GoTo 0
    
    
    If getFunc_ Is Nothing Then
        
        '���������͓��I�������A�����ɓo�^����B
        
        Set getFunc_ = createFunc_(code_)
        
        Set delegates_(code_) = getFunc_
        
    End If
    
End Function







'���I�R�[�h�̐��� ==============================================================


'������R�[�h������u�a�`�N���X�R�[�h�𓮓I��������B
'�@�߂�l�͊֐��I�u�W�F�N�g�B
'�@���������R�[�h�ɂ̓R�����g�Ƃ��āA������R�[�h�����c���Ă����i�����ςݎ����\�z���̃K�C�h�ƂȂ�j�B
'�@�������͐V�K�N���X�i cTempCodeClassName + n �j�Ƃ��Đ�������ACodeClean() ���� cMainCodeHolderName �ւ܂Ƃ߂���B
'�@�@���{���Ȃ�A�V�K�������ɂ͓��I�R�[�h�z���_�ɒ��ڒǉ��������̂����A
'�@�@�@��x�ł��N���X���C���X�^���X�������Ɠ��I�R�[�h���������f����Ȃ��Ȃ邽�߁A�������͌ʂɐ�������������Ȃ��B
'�@�@�@�W�����W���[���Ȃ瑦���f�����̂����A���W���[����������������Ƒ��̊֐��A�h���X���ς���Ă��܂����߁A�ʃ��W���[���͕K�v�B

Private Function createFunc_(code_$) As Delegate
    
    
    Dim funcName_$:     funcName_ = makeUniqueName_(cFuncNameHeader)                '�֐����̐���
    
    Dim comment_$:      comment_ = "'" & Replace(code_, vbCrLf, escChar_) & "'"  '���́u'�v�͋󗓏����h�~�p
    
    
    '�R�[�h����������p�[�X���Ău�a�`�R�[�h�ɂ���B
    
    Dim funcString_$:   funcString_ = parseCode_(funcName_, code_, comment_)
    
    
    
    '���I�֐���V�K�N���X���W���[���ɏ����o���A���̃N���X�C���X�^���X���擾����B
    
    Dim newClassName_$: newClassName_ = makeUniqueRndModuleName_(cTmpNameHeader)
    
    
    Dim newModule_ As CodeModule
    Set newModule_ = getCodeModule_(newClassName_, vbext_ct_ClassModule)
    
    newModule_.AddFromString makeDynamicCodeHead_(newClassName_)
    
    newModule_.AddFromString vbCrLf & funcString_
    
    
    Dim obj_ As Object
    Set obj_ = instantiate_(newClassName_, cTmpStdModuleName)
    
    Set createFunc_ = Delegate.CNew(obj_, funcName_)
    
End Function






'�֐���������\�z ------------------------------------------------------


'�n���ꂽ�R�[�h�𐮌`���ă��W���[���֊i�[�ł���֐��ɂ���B
 
Private Function parseCode_(funcName_$, code_$, comment_$) As String
    
    If Trim$(code_) = "" Then Exit Function
    
    
    
    Dim pureCode_$:     pureCode_ = code_
    
    
    Dim additionalFuncs_    As New Collection   '�ǉ������T�u�֐��𕶎���Ƃ��ēo�^����B
    
    Dim strInStrs_          As New Collection   '�u�������������v�ۑ��p�B
    
    
    
    
    '�ꎞ�I�Ɂu�������������v��ޔ�����B
    
    pureCode_ = Replace(pureCode_, "\'", escChar_)           '�u\'�v�̓G�X�P�[�v����
    
    pureCode_ = escapeStrInStr_(pureCode_, "'", strInStrs_)     ' '' �Ŋ���ꂽ���̂�ޔ�������
    
    
    
    
    '�����I�u�W�F�N�g���̓��ߍ\�����p�[�X����B
    
    pureCode_ = scanSugarSyntaxes_(pureCode_, additionalFuncs_)
    
    
    
    
    Dim args_$, capts_$, lineBlock_$
    
    
    '�R�[�h������𕪉����A�������X�g�E�L���v�`�����X�g�E���u���b�N�𐶐�����B
    
    dividFuncBlocks_ pureCode_, _
 _
        out_args_:=args_, out_capts_:=capts_, out_lineBlock_:=lineBlock_
    
    
    '�֐���������\�z����B
    
    parseCode_ = buildFuncString_(funcName_, args_, capts_, lineBlock_, comment_)
    
    
    
    
    
    '�u�������������v�����ɖ߂��B
    
    parseCode_ = unescapeStrInStr_(parseCode_, """", strInStrs_)    '�ޔ����ꂽ���̂� "" �Ŋ����ĕ�������
    
    parseCode_ = Replace(parseCode_, escChar_, "'")              '�u\'�v�G�X�P�[�v���u'�v�ɒ���
    
    
    
    
    '�ǉ��̊֐���t������B
    
    If additionalFuncs_.Count = 0 Then Exit Function
    
    parseCode_ = parseCode_ & vbCrLf & vbCrLf & joinCollection_(additionalFuncs_, vbCrLf & vbCrLf)
    
    
End Function





'�R�[�h������𕪉����A�������X�g�E�L���v�`�����X�g�E���u���b�N�𐶐�����B

Private Function dividFuncBlocks_(pureCode_$, ByRef out_args_$, ByRef out_capts_$, ByRef out_lineBlock_$)
    
    
    '�����u���b�N�ƕ��u���b�N�ɕ�������B�ȗ�����Ă���� "" �ƂȂ�B
    
    Dim blocks_$():         blocks_ = Split(pureCode_, "=>")
    
    Dim paramBlock_$:       If UBound(blocks_) > 0 Then paramBlock_ = blocks_(0)    '�����^�L���v�`�����X�g���ȗ��i�u=>�v���Əȗ����܂ށj�����ꍇ�� ""
    
    Dim lineBlock_$:        lineBlock_ = blocks_(UBound(blocks_))                   '�ȗ�����邱�Ƃ͂Ȃ��i�R�[�h�S�̂� "" �ƂȂ邪�A���̏ꍇ�͊֐��쐬����Ȃ��j
    
    
    
    '�����u���b�N���A�������X�g�ƃL���v�`�����X�g�ɕ�������B�ȗ�����Ă���� "" �ƂȂ�B
    
    Dim paramBlocks_$():    paramBlocks_ = Split(LTrim(paramBlock_), ":")           '�����u���b�N�� "" �̏ꍇ�́Aubound() �� -1 �ɂȂ�ۂ��c�B
    
    Dim args_$:             If UBound(paramBlocks_) > -1 Then args_ = paramBlocks_(0)
    
    Dim capts_$:            If UBound(paramBlocks_) > 0 Then capts_ = paramBlocks_(1)
    
    
    
    '�u>�v�Ŏn�܂�P��s�̏ꍇ�A���̍s�����Ƒ����A�߂�l�Ƃ��ĕԂ��悤�ɂ���B
    
    If InStr(1, lineBlock_, ";") = 0 Then
        
        If lineBlock_ Like ">*" Then
            
            lineBlock_ = "VariantCopy <result>, " & Mid$(lineBlock_, 2)
            
        End If
        
    End If
    
    
    
    '�߂�
    
    out_args_ = args_
    
    out_capts_ = capts_
    
    out_lineBlock_ = lineBlock_
    
End Function




' - - - - -


'�֐���������\�z����B

Private Function buildFuncString_(funcName_$, args_$, capts_$, lineBlock_$, comment_$) As String
    
    
    Dim captVarString_$:    captVarString_ = buildCaptureVariables_(capts_)
    
    Dim linesString_$:      linesString_ = buildCodeLines_(lineBlock_, funcName_)
    
    
    buildFuncString_ = _
 _
        "public function {funcName}( {a,b,c} ) as variant" & vbCrLf & _
 _
            comment_ & vbCrLf & _
 _
            formatCodeLine_(captVarString_) & _
 _
            formatCodeLine_(linesString_) & _
 _
        "end function"
    
    
    buildFuncString_ = Replace(buildFuncString_, "{funcName}", funcName_, 1, 1)
    buildFuncString_ = Replace(buildFuncString_, "{a,b,c}", args_, 1, 1)
    
End Function




'�L���v�`���ϐ��̐錾���𐮌`�\�z����B
'�@�i�ꉞ�^���w��ł���悤�ɂ͂��Ă��邪�A�������X�g���^���Ή��Ȃ̂ŉB���@�\�Ƃ������ƂŁc�j

Private Function buildCaptureVariables_(captureString_$) As String
    
    Dim captVariables_$():  captVariables_ = Split(captureString_, ",")
    
    
    Dim i&
    For i = 0 To UBound(captVariables_)
        
        
        Dim varName_$:  varName_ = Split(captVariables_(i), "as", , vbTextCompare)(0)
        
        
        captVariables_(i) = _
 _
            "dim " & captVariables_(i) & ":" & _
 _
            "VariantCopy " & varName_ & ", captures(" & i & ")"
        
        
    Next
    
    
    buildCaptureVariables_ = Join(captVariables_, vbCrLf & vbTab)
    
End Function




'�R�[�h�{�̂𐮌`�\�z����B

Private Function buildCodeLines_(lineBlock_$, funcName_$) As String
    
    buildCodeLines_ = lineBlock_
    
    buildCodeLines_ = Replace(buildCodeLines_, "<result>", funcName_, , , vbTextCompare)    '�߂�l�̏���
    
    buildCodeLines_ = Replace(buildCodeLines_, ";", vbCrLf)                                 '�u;�v�͑S�ĉ��s��
    
    buildCodeLines_ = Replace(buildCodeLines_, vbCrLf, vbCrLf & vbTab)                      '�ȈՂȂ���C���f���g��t��
    
End Function




'�P�s��\��������ɃC���f���g�i�^�u�j�Ɖ��s��t������B�󕶎��ɂ͕t�����Ȃ��B

Private Function formatCodeLine_(codeLine_$) As String
    
    If codeLine_ = "" Then Exit Function
    
    formatCodeLine_ = vbTab & codeLine_ & vbCrLf
    
End Function



'------------------------------------------------------

















'�ėp =======================================================



'���W���[������֘A -----------------------------------



'�u�a�`�̃R�[�h���W���[�����擾����B
'�@���݂��Ȃ��ꍇ�� cmType_ �Ŏw�肳�ꂽ���W���[�����쐬���ĕԂ��B

Private Function getCodeModule_(cmName_$, cmType_ As vbext_ComponentType) As CodeModule
    
    On Error Resume Next
    
    
    Dim cmp_ As VBComponent
    Set cmp_ = ThisWorkbook.VBProject.VBComponents(cmName_)
    
    If cmp_ Is Nothing Then
        
        '������Ȃ���΍쐬���ĕԂ��B
        
        Set getCodeModule_ = ThisWorkbook.VBProject.VBComponents.Add(cmType_).CodeModule
        
        getCodeModule_.Parent.Name = cmName_
        
        Exit Function
        
    End If
    
    
    If cmp_.Type <> cmType_ Then Exit Function  '�擾�������W���[���̃^�C�v���قȂ�ꍇ�� Nothing ���Ԃ�
    
    Set getCodeModule_ = cmp_.CodeModule
    
End Function




'�Y������R�[�h���W���[����S�ĕԂ��B���O�ɂ̓��C���h�J�[�h���g�p�ł���B�P���Ȃ��Ă���̃R���N�V�������Ԃ�B

Private Function getCodeModules_(nameWild_$, cmType_ As vbext_ComponentType) As Collection
    
    Dim targets_ As New Collection
    
    Dim vbc_ As VBComponent
    For Each vbc_ In ThisWorkbook.VBProject.VBComponents
        
        If vbc_.Type = vbext_ct_ClassModule Then
            
            If vbc_.Name Like nameWild_ Then _
 _
                targets_.Add vbc_.CodeModule
                
        End If
        
    Next
    
    Set getCodeModules_ = targets_
    
End Function




'���W���[�����̊֐��������X�g�A�b�v����B

Private Function getFuncNames_(cm_ As CodeModule, Optional funcNameHeaderWild_$, Optional iLineStart_&) As Collection
    
    Dim funcNames_ As New Collection
    
    
    Dim iStart_&:   iStart_ = IIf(iLineStart_ = 0, cm_.CountOfDeclarationLines, iLineStart_)
    
    
    Dim i&
    For i = iStart_ To cm_.CountOfLines '��s������
        
        
        Dim funcName_$:     funcName_ = cm_.ProcOfLine(i, vbext_pk_Proc)
        
        
        If funcName_ Like funcNameHeaderWild_ Then
            
            
            funcNames_.Add funcName_
            
            
            i = i + cm_.ProcCountLines(funcName_, vbext_pk_Proc) - 1
            
        End If
        
    Next
    
    
    Set getFuncNames_ = funcNames_
    
End Function







'�V�K�N���X���W���[���ɃR�[�h��ǉ�����B
'�@CodeModule.AddFromString() �̓���ɂ��A�錾�Z�N�V�����̂�����ɑ}�������B
'�@������ isOverWrite_ ���^�̏ꍇ�́A�S�e�L�X�g���㏑�������B

Private Function addCodeToNewModule_(codeHolderName_$, codeString_$, Optional isOverWrite_ As Boolean) As CodeModule
    
    Dim newCm_ As CodeModule
    
    Set newCm_ = ThisWorkbook.VBProject.VBComponents.Add(vbext_ct_ClassModule).CodeModule
    
    
    newCm_.Name = codeHolderName_
    
    
    If Not isOverWrite_ Then
        
        newCm_.AddFromString vbCrLf & codeString_
        
    Else
        
        newCm_.DeleteLines 1, newCm_.CountOfLines
        
        newCm_.InsertLines 1, codeString_
        
    End If
    
    
    Set addCodeToNewModule_ = newCm_
    
End Function


'------------------------------------------------------




'�������������̈ꎞ�u�� ------------------------------


'������̒��� delim_ �Ŋ���ꂽ�u�������������v���u""�v�iescapeDelim_�~�Q�j�ɒu�������A�R���N�V�����ɑޔ�����B
'�@delim_ �� split() �������̊�������u�������������v�ɂ�����B
'�@strInStrs_ �R���N�V�����ɁA���́u�������������v��ۑ����ĕԂ��B

Private Function escapeStrInStr_(code_$, delim_$, strInStrs_ As Collection, Optional escapeDelim_$ = """") As String
    
    Dim seps_$(): seps_ = Split(code_, delim_)
    
    Dim i&
    For i = 1 To UBound(seps_) Step 2
        
        strInStrs_.Add seps_(i)
        
        seps_(i) = ""
        
    Next
    
    escapeStrInStr_ = Join(seps_, escapeDelim_)
    
End Function




'�������������𕜌�����B
'�@�܂��A$'' ������̕ϐ��W�J���s���B

Private Function unescapeStrInStr_(code_$, delim_$, strInStrs_ As Collection, Optional escapeDelim_$ = """") As String
    
    Dim seps_$(): seps_ = Split(code_, escapeDelim_)
    
    Dim i&, sis_ '$
    For Each sis_ In strInStrs_
        
        seps_(i + 1) = replaceVariable_(delim_, CStr(sis_), ref_prevSection_:=seps_(i))
        
        i = i + 2
        
    Next
    
    unescapeStrInStr_ = Join(seps_, delim_)
    
End Function




' $'abc{x}def' ���� {x} ��ϐ��ɓW�J����B
'�@�u{�v�u}�v�́u{{�v�u}}�v�ŃG�X�P�[�v�����B

'��F   $"abc{var_}efg"     -> "abc" & var_ & "efg"
'�@�@    "dsef{esefe}sef"   -> "dsef{esefe}sef"     ���u$�v���Ȃ����ߓW�J����Ȃ�
'�@�@   $"sec:{@3}"         -> "sec:" & @3          ���u�a�`�̕��@�I�ɕs���ł����̂܂ܓW�J�����
'�@�� ��� delim_ �́u"�v�Ƃ����B

Private Function replaceVariable_(delim_$, str_$, ByRef ref_prevSection_$) As String
    
    replaceVariable_ = str_
    
    If Not ref_prevSection_ Like "*$" Then Exit Function
    
    
    ref_prevSection_ = Mid$(ref_prevSection_, 1, Len(ref_prevSection_) - 1) '�O�ߖ����� $ ���Ȃ�
    
    
    replaceVariable_ = Replace(replaceVariable_, "{{", escChar_)
    
    replaceVariable_ = Replace(replaceVariable_, "{", delim_ & " & ")
    
    replaceVariable_ = Replace(replaceVariable_, escChar_, "{")
    
    
    replaceVariable_ = Replace(replaceVariable_, "}}", escChar_)
    
    replaceVariable_ = Replace(replaceVariable_, "}", " & " & delim_)
    
    replaceVariable_ = Replace(replaceVariable_, escChar_, "}")
    
    
    replaceVariable_ = Replace(replaceVariable_, " & " & delim_ & delim_, "")
    
    replaceVariable_ = Replace(replaceVariable_, delim_ & delim_ & " & ", "")
    
End Function



' ----------------------------------------------------











'���̑� ------------------------------------------------




'���O�Ŏw�肳�ꂽ�V�K�N���X���C���X�^���X������B�֐��̓��I�������g�p���Ă���B

Private Function instantiate_(className_$, stdModuleName_$) As Object
    
    '�N���X�C���X�^���X���R�[�h�𓮓I�ɐ����i���ɓ��I�N���X�����̕��@�Ȃ��̂��c�H�j
    
    Dim tmpCm_ As CodeModule
    
    Set tmpCm_ = getCodeModule_(stdModuleName_, vbext_ct_StdModule)
    
    Dim funcString_$:   funcString_ = "public function New_{className}() as {className}: set New_{className} = new {className}: end function"
    
    tmpCm_.AddFromString Replace(funcString_, "{className}", className_)
    
    
    '�R�[�h�N���X���C���X�^���X������B
    
    Set instantiate_ = Application.Run(stdModuleName_ & ".New_" & className_)
    
End Function







'�g�p����Ă��Ȃ��A�����_���ȃ��W���[�����𐶐�����B

Private Function makeUniqueRndModuleName_(namePrefix_$) As String
    
    On Error Resume Next
    
    
    Dim n_&
    
    Do
        
        n_ = Int(65536 * Rnd) '�����_�����͂��܂肱�����Ȃ��ł���
        
    Loop Until ThisWorkbook.VBProject.VBComponents(namePrefix_ & n_) Is Nothing
    
    
    makeUniqueRndModuleName_ = namePrefix_ & n_
    
End Function






'�ϐ����^�֐����p�ɁA��ӂɂȂ�悤�Ȗ��O�𐶐�����B

Private Function makeUniqueName_(prefix_$) As String
    
    Static nameSeed_&
    
    
    makeUniqueName_ = prefix_ & Replace(CDec(Now), ".", "x", , 1) & "x" & nameSeed_
    
    '{prefix_}{���t}x{����}x{nameSeed_}�ƂȂ�BCDec()���Ă�͎̂w���`����������邽�߁B
    
    
    nameSeed_ = nameSeed_ + 1
    
End Function








'������R���N�V������ Join() ����B

Private Function joinCollection_(c_ As Collection, delim_$) As String
    
    If c_.Count = 0 Then Exit Function
    
    Dim arr_()
    ReDim arr_(c_.Count - 1)
    
    Dim i&, value_
    For Each value_ In c_
        
        arr_(i) = value_
        
        i = i + 1
        
    Next
    
    joinCollection_ = Join(arr_, delim_)
    
End Function






Private Sub swap_(ByRef ref_a_, ByRef ref_b_)
    
    Dim tmp_: tmp_ = ref_a_
    ref_a_ = ref_b_
    ref_b_ = tmp_
    
End Sub



' ----------------------------------------------------










'���I�R�[�h�z���_�[�֘A =============================================================================



'���I�R�[�h�֘A�̐������s���B

Private Sub cleanDynamicCode_()
    
    cleanTmpStdModule_
    
    cleanTmpClass_
    
    scanDynamicCodes_
    
End Sub





'���C���R�[�h�z���_�[����f���Q�[�g�����֓o�^���� --------------------------------------



'�����ςݓ��I�֐��𑖍����Ď����ɓo�^����B
'�@�L�[�Ƃ���R�[�h������́A�֐����̐擪�P�s�ڈȍ~�ɃR�����g�Ƃ��đ}������Ă���B
'�@���s���G�X�P�[�v����Ă���̂ŁAvbCrLf �ɖ߂��K�v������B

Private Sub scanDynamicCodes_()
    
    
    '���I�R�[�h�z���_�̃C���X�^���X�𐶐�����B
    
    Dim mainCodeHolder_ As Object
    Set mainCodeHolder_ = New DynamicCode 'instantiate_(cMainCodeHolderName)
    
    
    '���I�R�[�h�z���_���X�L�������A���I���\�b�h�� delegates_ �ɓo�^���Ă����B
    
    Dim cm_ As CodeModule
    Set cm_ = getCodeModule_(cMainCodeHolderName, vbext_ct_ClassModule)
    
    Dim funcName_ '$
    For Each funcName_ In getFuncNames_(cm_, cFuncNameHeader & "*")
        
        
        registDelegates_ _
 _
            keys_:=commentsToKeyCodes_(cm_, CStr(funcName_)), _
 _
            action_:=Delegate.CNew(mainCodeHolder_, funcName_)
        
        
    Next
    
    
End Sub



Private Sub registDelegates_(keys_ As Collection, action_ As Delegate)
    
    Dim key_ '$
    For Each key_ In keys_
        
        Set delegates_(key_) = action_
        
    Next
    
End Sub



Private Function commentsToKeyCodes_(codeModule_ As CodeModule, funcName_$) As Collection
    
    Dim iFunc_&:    iFunc_ = codeModule_.ProcBodyLine(funcName_, vbext_pk_Proc) '�֐��̂���s
    
    
    Dim keys_ As New Collection
    
    Dim i&: i = iFunc_ + 1
    Do
        
        Dim line_$:     line_ = codeModule_.Lines(i, 1)
        
        If Not line_ Like "'*" Then Exit Do
        
        
        Dim enclosed_$: enclosed_ = Mid(line_, 2, Len(line_) - 2)       '���T�C�h�́u'�v�𔲂�
         
        Dim key_$:      key_ = Replace(enclosed_, escChar_, vbCrLf)  '���s�G�X�P�[�v��߂�
        
        keys_.Add key_
        
        
        i = i + 1
        
    Loop
    
    
    Set commentsToKeyCodes_ = keys_
    
End Function



'-----------------------------------------







'���I�R�[�h�̐������s�� --------------------------


'�ʂɈꎞ�쐬�����֐���`�N���X�̓��e���A�z���_�[�N���X�Ɉړ�����B�ʃN���X�͍폜����B

'�R�����g�Ƃ��ăR�[�h��������L�q���Ă��邪�A
'�@�E��̃R�[�h������͈�s�Ɏ��߂���B���s�� escapeCh_ �ɃG�X�P�[�v����Ă���B
'�@�E�����s����ꍇ������B�i�������e�̊֐����A�X�y�[�X�̐��ȂǂŃR�[�h������̕\�����ς�����肷�邽�߁j
'�@�E�K���z���C�g�X�y�[�X�̒P��X�y�[�X�������{������\�R�[�h���P���B���������

Private Sub cleanTmpClass_() 'Optional tmpModules_ As Collection)
    
    
    '���C���R�[�h�z���_�[���擾�i�Ȃ���΍쐬�j
    
    Dim cmDst_ As CodeModule
    Set cmDst_ = getCodeModule_(cMainCodeHolderName, vbext_ct_ClassModule)
    
    If Not cmDst_.find("Captures", 1, 1, -1, -1) Then
        
        cmDst_.AddFromString makeDynamicCodeHead_(cMainCodeHolderName)
        
    End If
    
    
    '�ʃR�[�h���W���[�����
    
    Dim cmSrc_ As CodeModule
    For Each cmSrc_ In getCodeModules_(cTmpNameHeader & "*", vbext_ct_ClassModule) '�֐����擪���w�肵�Č�������
        
        
        '�ʃR�[�h���W���[���i���j����z���_�[�N���X�i��j�ցA���I�������ꂽ���\�b�h���R�s�[
        
        Dim funcName_ '$
        For Each funcName_ In getFuncNames_(cmSrc_, cNameForDynamicCodeSearch)
            
            cmDst_.AddFromString cmSrc_.Lines( _
 _
                cmSrc_.ProcStartLine(CStr(funcName_), vbext_pk_Proc), _
 _
                cmSrc_.ProcCountLines(CStr(funcName_), vbext_pk_Proc) _
            )
            
        Next
        
        
        '�ʃR�[�h���W���[���i���j���폜
        
        ThisWorkbook.VBProject.VBComponents.Remove cmSrc_.Parent
        
        
    Next
    
    
End Sub


'------------------------------------------------------








'���I�R�[�h�̐錾��������쐬����B

Private Function makeDynamicCodeHead_(className_$) As String
    
    makeDynamicCodeHead_ = _
 _
        "private declare PtrSafe function VariantCopy Lib ""oleaut32"" ( dst_, src_ ) as long" & vbCrLf & _
 _
        "public Captures as variant" & vbCrLf & _
 _
        vbCrLf & _
 _
        "public function Instantiate() as object: set Instantiate = new {class}: end function" & vbCrLf
    
    
    makeDynamicCodeHead_ = Replace(makeDynamicCodeHead_, "{class}", className_, 1, 1)
    
End Function





'�ꎞ�W�����W���[�����폜����B

Private Sub cleanTmpStdModule_()
    
    On Error Resume Next
    
    ThisWorkbook.VBProject.VBComponents.Remove _
 _
        ThisWorkbook.VBProject.VBComponents(cTmpStdModuleName)
    
End Sub

















Public Sub teste(t_$)
    
    Dim c_ As New Collection
    
    Debug.Print scanSugarSyntaxes_(t_, c_)
    
    Enumerable(c_).ToAryAsEnumerable.ForEach "x => debug.print x"
    
End Sub







'���ߍ\���̃p�[�X =======================================



'���ߍ\�����p�[�X����B

Private Function scanSugarSyntaxes_(srcTxt_$, additionalFuncs_ As Collection) As String
    
    If srcTxt_ = "" Then Exit Function
    
    scanSugarSyntaxes_ = srcTxt_
    
    
    '�u���b�N�^�O���E�ƃu���b�N�̍��E���E�E�̕��𑀍쏈������f���Q�[�g��o�^����B
    
    Dim manipurations_ As New Collection
    
    manipurations_.Add "over root" '.add before:=1 ���g�p���邽�߂Ƀ_�~�[�����Ƃ�
    
    
    '�u���b�N�\����o�^���ꂽ�����Ńp�[�X����B
    
    man_push_ manipurations_, tagL_:="(", tagR_:=")", manipuration_:=Delegate.CNew(Me, "syntaxParse_EscapeClosing_")
    
    scanSugarSyntaxes_ = scanSyntax_Block_(scanSugarSyntaxes_, manipurations_, results_:=additionalFuncs_)
    
    man_push_ manipurations_, tagL_:="[", tagR_:="]", manipuration_:=Delegate.CNew(Me, "syntaxParse_AnonymousCollectionFunc_")
    man_push_ manipurations_, tagL_:="{", tagR_:="}", manipuration_:=Delegate.CNew(Me, "syntaxParse_AnonymousDictionaryFunc_")
    
    scanSugarSyntaxes_ = scanSyntax_Block_(scanSugarSyntaxes_, manipurations_, results_:=additionalFuncs_)
    
    
    ' @ �Ƃ��đޔ������J���}�����ɖ߂��B���邵���ȁc�B
    
    scanSugarSyntaxes_ = Replace(scanSugarSyntaxes_, "@", ",")
    
End Function






'�u���b�N�\���ł���܂ꂽ�������p�[�X����A���S���Y���B
'�@�p�[�X�����֐��� manipuration_ �� Delegate �Ƃ��ēn����B

Private Function scanSyntax_Block_(srcTxt_$, manipurations_ As Collection, results_ As Collection) As String
    
    If srcTxt_ = "" Then Exit Function
    
    scanSyntax_Block_ = srcTxt_
    
    Do While manipurations_.Count > 1
        
        scanSyntax_Block_ = scanSyntax_Block_inner_(scanSyntax_Block_, 1, manipurations_, results_)
        
        man_pop_ manipurations_
    Loop
    
End Function



Private Function scanSyntax_Block_inner_(srcTxt_$, ipos_&, manipurations_ As Collection, results_ As Collection) As String
    
    If srcTxt_ = "" Then Exit Function
    
    
    Dim tagL_$, tagR_$, manipuration_ As IFunc
    
    man_peek_ manipurations_, out_tagL_:=tagL_, out_tagR_:=tagR_, out_manipuration_:=manipuration_
    
    
    
    scanSyntax_Block_inner_ = srcTxt_
    
    
    
    
    '�I�u�W�F�N�g���͂��^�O�����o���A�ċA�I�ɃI�u�W�F�N�g�����֐����ƒu�����Ă����B
    
    Dim iL_&:   iL_ = InStr(ipos_, scanSyntax_Block_inner_, tagL_)
    
    If iL_ = 0 Then Exit Function
    
    
    scanSyntax_Block_inner_ = scanSyntax_Block_inner_(scanSyntax_Block_inner_, iL_ + 1, manipurations_, results_)
    
    
    Dim iR_&:   iR_ = InStr(iL_ + 1, scanSyntax_Block_inner_, tagR_)
    
    If iR_ = 0 Then Exit Function
    
    
    
    
    '�u���b�N�𕪊�����
    
    Dim txtL_$: txtL_ = Left$(scanSyntax_Block_inner_, iL_ - 1)
    
    Dim txtM_$: txtM_ = Mid$(scanSyntax_Block_inner_, iL_ + 1, iR_ - (iL_ + 1))
    
    Dim txtR_$: txtR_ = Mid$(scanSyntax_Block_inner_, iR_ + 1)
    
    
    
    
    '�u���b�N�����̃e�L�X�g�ɑ΂��A���쏈���֐��X�^�b�N�ɑ��݂��� manipuration_ ����������B�����ƃV���v���ɂł��Ȃ����ˁc�B
    
    man_pop_ manipurations_
    
    If manipurations_.Count > 1 Then txtM_ = scanSyntax_Block_inner_(txtM_, 1, manipurations_, results_)
    
    man_push_ manipurations_, tagL_, tagR_, manipuration_
    
    
    
    '�u���b�N�̍��E���E�E�̕��𑀍쏈�����A���ʂƂ��ĕԂ��B
    
    scanSyntax_Block_inner_ = manipuration_.xExec04(txtL_, txtM_, txtR_, results_)
    
    
End Function



'���쏈���֐��X�^�b�N -----------------------

Private Sub man_peek_(manipurations_ As Collection, ByRef out_tagL_$, ByRef out_tagR_$, ByRef out_manipuration_ As IFunc)
    
    out_tagL_ = manipurations_(1)
    out_tagR_ = manipurations_(2)
    Set out_manipuration_ = manipurations_(3)
    
End Sub

Private Sub man_pop_(manipurations_ As Collection)
    
    manipurations_.Remove 1
    manipurations_.Remove 1
    manipurations_.Remove 1
    
End Sub

Private Sub man_push_(manipurations_ As Collection, tagL_$, tagR_$, manipuration_ As IFunc)
    
    manipurations_.Add manipuration_, before:=1
    manipurations_.Add tagR_, before:=1
    manipurations_.Add tagL_, before:=1
    
End Sub

'--------------------------------------------




'���ʂ̃p�[�X ---------------------------------------------------------

Public Function syntaxParse_EscapeClosing_(txtL_, txtM_, txtR_, results_) As Variant
    
'    syntaxParse_EscapeClosing_ = txtL_ & "(" & txtM_ & ")" & txtR_
    syntaxParse_EscapeClosing_ = txtL_ & "(" & Replace(txtM_, ",", "@") & ")" & txtR_
    
End Function

'----------------------------------------------------------------------



'�����I�u�W�F�N�g�̃p�[�X ---------------------------------------------

'�����I�u�W�F�N�g���p�[�X����B
'�@Collection �� Dictionary �𐶐�����\�������݂���B
'�@�����ŁA�I�u�W�F�N�g�𐶐�����֐��𓮓I�ɐ�������d�g�݁B
'�@[ x = 1, y = "str" ] �Ȃǂ��ACollection �����֐����ɒu�������B
'�@{ x = 1, y = "str" } �Ȃǂ��ADictionary �����֐����ɒu�������B
'�@{ x, y } �� { x = x, y = y } �Ɠ����B
'�@�l�X�g�\�B�����������Ă��Ȃ��ꍇ�͖���`�Ȃ̂Œ��Ӂi��T�̏ꍇ�͂܂������p�[�X����Ȃ��Ǝv���j�B
'�@�ϐ����̃`�F�b�N�Ȃǂ����Ă��Ȃ��̂ŁA�������Œ��ӂ��Ďg�p����B

' objType_
'�@1 : collection   [ , ]
'�@2 : dictionary   { , }
'�@�� Array() ���l�����邪�A����͂��̂܂܏����Ă��炦�΂���

'�����I�u�W�F�N�g�́A�L�[�u"ay"�v�^�o�����[�u Enumerable.AnonymousIdentify �ւ̎Q�Ɓv�̃����o�������A�ʏ�� Collection/Dictionary �Ƌ�ʂ���B

'�^�O�����^�p�����[�^��؂蕶���́A�u�a�`�\���Ŏg�p����Ȃ������łȂ���΂Ȃ�Ȃ��B
'�@���G�Ȍ����͂��Ă��Ȃ����߁B�����ňӖ����l���铙�͂��Ă��Ȃ��B


Public Function syntaxParse_AnonymousCollectionFunc_(txtL_, txtM_, txtR_, additionalFuncs_) As Variant
    
    
    '�֐����������_���ɐ�������B
    
    Dim funcName_$: funcName_ = makeUniqueName_(cCollNameHeader)
    
    
    '�����I�u�W�F�N�g�����֐���������\�z
    
    Dim funcs_ As Collection
    Set funcs_ = additionalFuncs_
    
    funcs_.Add makeInstantiateFunctionString_ _
 _
        (ref_funcName_:=funcName_, propertyList_:=CStr(txtM_), typeName_:="Collection", separator_:=",", needSwap_:=True)
    
    
    '�֐����ɒu����̃R�[�h������
    
    syntaxParse_AnonymousCollectionFunc_ = txtL_ & funcName_ & txtR_
    
End Function

Public Function syntaxParse_AnonymousDictionaryFunc_(txtL_, txtM_, txtR_, additionalFuncs_) As Variant
    
    
    '�֐����������_���ɐ�������B
    
    Dim funcName_$: funcName_ = makeUniqueName_(cDictNameHeader)
    
    
    '�����I�u�W�F�N�g�����֐���������\�z
    
    Dim funcs_ As Collection
    Set funcs_ = additionalFuncs_
    
    funcs_.Add makeInstantiateFunctionString_ _
 _
        (ref_funcName_:=funcName_, propertyList_:=CStr(txtM_), typeName_:="Dictionary", separator_:=",", needSwap_:=False)
    
    
    '�֐����ɒu����̃R�[�h������
    
    syntaxParse_AnonymousDictionaryFunc_ = txtL_ & funcName_ & txtR_
    
End Function


'�����I�u�W�F�N�g�����֐��𕶎���ō쐬����B

Private Function makeInstantiateFunctionString_(ByRef ref_funcName_$, propertyList_$, typeName_$, separator_$, needSwap_ As Boolean) As String
    
    Dim props_$(): props_ = Split("ay=grouping.anonymousidentify" & separator_ & propertyList_, separator_)
    
    
    Dim lines_  As New Collection   '�֐����̕�
    Dim params_ As New Collection   '�������X�g
    Dim values_ As New Collection   '�l���X�g
    
    Dim prop_ '$
    For Each prop_ In props_
        
        prop_ = Trim$(prop_)
        
        If prop_ <> "" Then
            
            Dim nameAndValue_$(): nameAndValue_ = Split(prop_, "=", 2)
            
            Dim key_$:      key_ = Trim(nameAndValue_(0))
            Dim value_$:    value_ = nameAndValue_(UBound(nameAndValue_))
            
            
            params_.Add key_
            values_.Add value_
            
            
            Dim p0_$, p1_$
            
            p0_ = """" & key_ & """"
            p1_ = key_
            
            If needSwap_ Then swap_ p0_, p1_
            
            lines_.Add ref_funcName_ & ".Add " & p0_ & "," & p1_
            
        End If
        
    Next
    
    
    Dim funcNameWithParams_$
    funcNameWithParams_ = ref_funcName_ & "(" & joinCollection_(params_, ",") & ")" ' dict000x000x0( x, y ) �̂悤�Ȉ������X�g�t���̖��O�ɂ���
    
    Dim funcNameWithValues_$
    funcNameWithValues_ = ref_funcName_ & "(" & joinCollection_(values_, "@") & ")" ' dict000x000x0( 1, x + 2 ) �̂悤�ȑ�����X�g�t���̖��O�ɂ���
    
    
    
    Dim strFunc_$: strFunc_ = _
 _
        "private function {funcName(a,b,c)} as {type}:" & _
 _
            "set {funcName} = new {type}:" & _
 _
            "{line:line:line}:" & _
 _
        "end function"
    
    strFunc_ = Replace(strFunc_, "{funcName(a,b,c)}", funcNameWithParams_, 1, 1)
    strFunc_ = Replace(strFunc_, "{funcName}", ref_funcName_, 1, 1)
    strFunc_ = Replace(strFunc_, "{type}", typeName_, 1, 2)
    strFunc_ = Replace(strFunc_, "{line:line:line}", joinCollection_(lines_, ":"), 1, 1)
    
    
    
    ref_funcName_ = funcNameWithValues_
    
    makeInstantiateFunctionString_ = strFunc_
    
End Function


'---------------------------------------------








' a ? b : c �\���̃p�[�X ---------------------

Private Function scanShortBranch_(srcTxt_$, factoryFuncs_ As Collection) As String
    
    scanShortBranch_ = srcTxt_
    
    
    
    
    
End Function

'---------------------------------------------
'
'
'Private Sub syntaxShortIfBranchFunc__CallFuncer03(txtL_, txtM_, txtR_, this_ As IFuncer, result_)
'
'    Dim factoryFuncs_ As Collection:    Set factoryFuncs_ = this_.Object(2)
'
'
'    txtL_ = Left(txtL_, Len(txtL_))
'    txtR_ = Right(txtR_, Len(txtR_))
'
'
'    Dim ref_funcName_$: ref_funcName_ = makeUniqueName_("if")                   '�֐����������_���ɐ�������B
'
'    factoryFuncs_.Add makeShortIfFunctionString_(ref_funcName_, CStr(txtM_))    '�����I�u�W�F�N�g�����֐��̕�����
'
'    result_ = txtL_ & ref_funcName_ & txtR_                                     '�֐����ɒu����̃R�[�h������
'
'End Sub
'
'Private Function makeShortIfFunctionString_(ByRef ref_funcName_$, propertyList_$) As String
'
'
'    Dim lines_ As New Collection    '�֐����̕�
'    Dim params_ As New Collection   '�������X�g
'    Dim values_ As New Collection   '�l���X�g
'
'
'    params_.Add "a"
'    values_.Add "b"
'
'
'    Dim funcNameWithParams_$:   funcNameWithParams_ = ref_funcName_ & "(" & joinCollection_(params_, ",") & ")" ' ay000x000x0( x, y ) �̂悤�Ȉ������X�g�t���̖��O�ɂ���
'
'    Dim funcNameWithValues_$:   funcNameWithValues_ = ref_funcName_ & "(" & joinCollection_(values_, ",") & ")" ' ay000x000x0( 1, x + 2 ) �̂悤�ȑ�����X�g�t���̖��O�ɂ���
'
'
'    makeShortIfFunctionString_ = _
' _
'        "private function " & funcNameWithParams_ & "�F" & _
' _
'            "if a then b else c" & "�F" & _
' _
'        "end function"
'
'
'    ref_funcName_ = funcNameWithValues_
'
'
'End Function
'
'











'�������E�I���� =====================================================


Private Sub Class_Initialize()
    
    initVariable_
    
    cleanDynamicCode_
    
End Sub

Private Sub Class_Terminate()
    
    cleanDynamicCode_
    
End Sub




