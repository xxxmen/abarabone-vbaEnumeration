VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Grouping"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit




' win API ---------

Private Declare PtrSafe Function VariantCopy Lib "oleaut32" (dst_, src_) As Long

'--------------------





' Grouping �C���X�^���X�����o ============================================================




Public Key          As Variant

Private elements_   As New Collection







Public Property Get Elements() As Collection
Attribute Elements.VB_UserMemId = 0
    
    Set Elements = elements_
    
End Property


Public Function NewEnum() As IEnumVARIANT
Attribute NewEnum.VB_UserMemId = -4
    
    If elements_ Is Nothing Then Exit Function
    
    Set NewEnum = elements_.[_NewEnum]
    
End Function








'��C���X�^���X�֐� ==============================================


' Grouping �ɒ��ڊ֌W�Ȃ��֐����������Ă����̂͂悭�Ȃ������c
'�@�ł��ǂ��ɒu�����c
'���\���������ɂȂ��Ă��ĂĂ��񂪂炪���Ă����c



'�����I�u�W�F�N�g�֌W ------------------------------------------------




' Collection/Dictionary �𓽖��I�u�W�F�N�g�Ƃ��Ĉ�����B
'�@���v�f�̃L�[���� "ay"�A�l�� Enumerable.AnonymousIdentify�i�I�u�W�F�N�g�Q�ƒl�j�Ƃ���B

' .net �� Dictionary �� key �œ����^�́A
'�@�E�Q�ƃA�h���X�ł͂Ȃ������̒l���L�[�ɂȂ�B
'�@�E�����̓����^���L�[�ɂȂ�B�ʏ�̃I�u�W�F�N�g�͓����ɂ����Ă��Q�ƃA�h���X���L�[�ɂȂ���悤�B



'�����I�u�W�F�N�g�����ʂ��邽�߂ɁA�����I�u�W�F�N�g�̐擪�Ɏ������� ay ���ʎq�B

Public Property Get AnonymousIdentify() As Collection
    
    Static anonymousIdentify_ As New Collection
    
    Set AnonymousIdentify = anonymousIdentify_
    
End Property



'�I�u�W�F�N�g���L�[�Ƃ���p�r�Ȃǂ̂��߂ɁA�����I�u�W�F�N�g�Ȃ�V���A���C�Y�i�����񉻁j���ĕԂ��A�����łȂ���΂��̂܂ܕԂ��B

Public Function ToAyKey(key_) As Variant
    
    Dim stringKey_$:    stringKey_ = SeriarizeIfAnonymous(key_)
    
    Select Case True
        
        Case stringKey_ <> "":  ToAyKey = stringKey_
        
        Case IsObject(key_):    Set ToAyKey = key_
        
        Case Else:              ToAyKey = key_
        
    End Select
    
End Function



'�����I�u�W�F�N�g�̗v�f�𕶎���ɕϊ����Č�������B�I�u�W�F�N�g�́u�^��:�A�h���X�v�Ƃ��ĕ����񉻂���B
'�@�����I�u�W�F�N�g�ȊO���n���ꂽ�ꍇ�͋󕶎���Ԃ��B

Public Function SeriarizeIfAnonymous(value_) As String
    
    
    If Not isAnonymousObject_(value_) Then Exit Function
    
    
    Dim arr_() As String
    ReDim arr_(value_.Count - 1 - 1) '�����^���ʃL�[ "ay" �̕���������
    
    Dim element_, i&
    For Each element_ In items_(value_)
        
        If Not isIdentify_(element_) Then
            
            Dim seriarized_$:   seriarized_ = SeriarizeIfAnonymous(element_)
            
            If seriarized_ <> "" Then element_ = seriarized_
            
            If IsObject(element_) _
                Then arr_(i) = TypeName(element_) & ":" & CStr(ObjPtr(element_)) _
                Else arr_(i) = CStr(element_)
            
            i = i + 1
            
        End If
        
    Next
    
    SeriarizeIfAnonymous = "{ '" & Join(arr_, "', '") & "' }"
    
End Function





' value_ �������I�u�W�F�N�g�Ȃ�^��Ԃ��B����ȊO�̂��ׂĂȂ�U��Ԃ��B

Private Function isAnonymousObject_(value_) As Boolean
    
    On Error Resume Next
    
    isAnonymousObject_ = (value_("ay") Is AnonymousIdentify) '�L�["ay"�� ay ���ʎq���i�[����Ă���Γ����I�u�W�F�N�g�Ƃ���B
    
End Function



' element_ �� ay ���ʎq�Ȃ�^��Ԃ��B

Private Function isIdentify_(element_) As Boolean
    
    On Error Resume Next
    
    isIdentify_ = (element_ Is AnonymousIdentify)
    
End Function



' For Each �񋓂̂��߂ɁAsource_ �������Ȃ� .Items ���A����ȊO�Ȃ� source_ �����̂܂ܕԂ��B

Private Function items_(source_) As Variant
    
    If TypeOf source_ Is Dictionary Then
        
        Dim d_ As Dictionary:   Set d_ = source_
        
        items_ = d_.Items
        
        Exit Function
        
    End If
    
    Set items_ = source_
    
End Function



' --------------------------------------------------------------------------------











