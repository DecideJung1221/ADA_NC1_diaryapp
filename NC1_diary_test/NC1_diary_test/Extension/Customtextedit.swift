////
////  Customtextedit.swift
////  NC1_diary_test
////
////  Created by 정혜정 on 4/12/24.
////
//
//import Foundation
//
//struct CustomTextEditorView: View {
//        
//    // MARK: -Properties
//    // MARK: Stored Properties
//    let const = Constant.TextEditorConst.self
//
//    let style: GSTextEditorStyle
//    let text: Binding<String>
//    let font: Font
//    let lineSpace: CGFloat
//
//    // MARK: Initializer에서 계산을 통해 결정되는 프로퍼티
//    let maxLineCount: CGFloat
//    let uiFont: UIFont
//    let maxHeight: CGFloat
//    
//    @State private var currentTextEditorHeight: CGFloat = 0
//    @State private var maxTextWidth: CGFloat = 0
//    
//    
//    // MARK: -Initializer
//    /// 파라미터 font = .body, lineSpace = 2 기본값 지정
//    init (
//        style: GSTextEditorStyle,
//        text: Binding<String>,
//        font: Font = .body,
//        lineSpace: CGFloat = 2,
//    ) {
//        self.style = style
//        self.text = text
//        self.font = font
//        self.lineSpace = lineSpace
//
//        self.maxLineCount = const.TEXTEDITOR_MAX_LINE_COUNT.asFloat
//        self.uiFont = UIFont.fontToUIFont(from: font)
//        self.maxHeight = (maxLineCount * (uiFont.lineHeight + lineSpace)) + const.TEXTEDITOR_FRAME_HEIGHT_FREESPACE
//    }
//}
