; ModuleID = 'kern.c'
source_filename = "kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [4 x i32]*, [4 x i32]*, [16 x i32]*, [1024 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.perf_trace_event = type { i64, i32, i8 }

@output_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@llvm.used = appending global [2 x i8*] [i8* bitcast (%struct.anon* @output_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_lib to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_lib(%struct.xdp_md* %0) #0 section "xdp" !dbg !63 {
  %2 = alloca %struct.perf_trace_event, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !75, metadata !DIExpression()), !dbg !88
  %3 = bitcast %struct.perf_trace_event* %2 to i8*, !dbg !89
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #3, !dbg !89
  call void @llvm.dbg.declare(metadata %struct.perf_trace_event* %2, metadata !76, metadata !DIExpression()), !dbg !90
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(16) %3, i8 0, i64 16, i1 false), !dbg !90
  %4 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !91
  %5 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 0, !dbg !92
  store i64 %4, i64* %5, align 8, !dbg !93, !tbaa !94
  %6 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 2, !dbg !100
  store i8 1, i8* %6, align 4, !dbg !101, !tbaa !102
  %7 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 1, !dbg !103
  store i32 0, i32* %7, align 8, !dbg !104, !tbaa !105
  %8 = bitcast %struct.xdp_md* %0 to i8*, !dbg !106
  %9 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* %8, i8* bitcast (%struct.anon* @output_map to i8*), i64 4294967295, i8* nonnull %3, i64 16) #3, !dbg !107
  %10 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !108
  %11 = and i32 %10, 1, !dbg !109
  %12 = icmp eq i32 %11, 0, !dbg !110
  br i1 %12, label %13, label %17, !dbg !111

13:                                               ; preds = %1
  store i8 2, i8* %6, align 4, !dbg !112, !tbaa !102
  %14 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !113
  call void @llvm.dbg.value(metadata i64 %14, metadata !84, metadata !DIExpression()), !dbg !114
  %15 = load i64, i64* %5, align 8, !dbg !115, !tbaa !94
  %16 = sub i64 %14, %15, !dbg !116
  br label %21

17:                                               ; preds = %1
  store i8 3, i8* %6, align 4, !dbg !117, !tbaa !102
  %18 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !118
  call void @llvm.dbg.value(metadata i64 %18, metadata !87, metadata !DIExpression()), !dbg !88
  %19 = load i64, i64* %5, align 8, !dbg !119, !tbaa !94
  %20 = sub i64 %18, %19, !dbg !120
  br label %21

21:                                               ; preds = %17, %13
  %22 = phi i64 [ %16, %13 ], [ %20, %17 ]
  %23 = phi i64 [ %14, %13 ], [ %18, %17 ], !dbg !88
  %24 = phi i32 [ 1, %13 ], [ 2, %17 ], !dbg !88
  %25 = trunc i64 %22 to i32, !dbg !88
  store i32 %25, i32* %7, align 8, !dbg !88, !tbaa !105
  store i64 %23, i64* %5, align 8, !dbg !88, !tbaa !94
  %26 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* %8, i8* bitcast (%struct.anon* @output_map to i8*), i64 4294967295, i8* nonnull %3, i64 16) #3, !dbg !88
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #3, !dbg !121
  ret i32 %24, !dbg !121
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!59, !60, !61}
!llvm.ident = !{!62}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "output_map", scope: !2, file: !3, line: 26, type: !40, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "kern.c", directory: "/home/shrestha/btp/pktgen/xdp")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 3153, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !{!15, !25, !33, !0}
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !17, line: 114, type: !18, isLocal: true, isDefinition: true)
!17 = !DIFile(filename: "/usr/local/include/bpf/bpf_helper_defs.h", directory: "")
!18 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !19)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DISubroutineType(types: !21)
!21 = !{!22}
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !23, line: 31, baseType: !24)
!23 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!24 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!25 = !DIGlobalVariableExpression(var: !26, expr: !DIExpression())
!26 = distinct !DIGlobalVariable(name: "bpf_perf_event_output", scope: !2, file: !17, line: 698, type: !27, isLocal: true, isDefinition: true)
!27 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !28)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = !DISubroutineType(types: !30)
!30 = !{!31, !32, !32, !22, !32, !22}
!31 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!33 = !DIGlobalVariableExpression(var: !34, expr: !DIExpression())
!34 = distinct !DIGlobalVariable(name: "bpf_get_prandom_u32", scope: !2, file: !17, line: 193, type: !35, isLocal: true, isDefinition: true)
!35 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !36)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DISubroutineType(types: !38)
!38 = !{!39}
!39 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !23, line: 27, baseType: !7)
!40 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 20, size: 256, elements: !41)
!41 = !{!42, !48, !49, !54}
!42 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !40, file: !3, line: 22, baseType: !43, size: 64)
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 128, elements: !46)
!45 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!46 = !{!47}
!47 = !DISubrange(count: 4)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !40, file: !3, line: 23, baseType: !43, size: 64, offset: 64)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !40, file: !3, line: 24, baseType: !50, size: 64, offset: 128)
!50 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !51, size: 64)
!51 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 512, elements: !52)
!52 = !{!53}
!53 = !DISubrange(count: 16)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !40, file: !3, line: 25, baseType: !55, size: 64, offset: 192)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !56, size: 64)
!56 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 32768, elements: !57)
!57 = !{!58}
!58 = !DISubrange(count: 1024)
!59 = !{i32 7, !"Dwarf Version", i32 4}
!60 = !{i32 2, !"Debug Info Version", i32 3}
!61 = !{i32 1, !"wchar_size", i32 4}
!62 = !{!"clang version 10.0.0-4ubuntu1 "}
!63 = distinct !DISubprogram(name: "xdp_lib", scope: !3, file: !3, line: 32, type: !64, scopeLine: 32, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !74)
!64 = !DISubroutineType(types: !65)
!65 = !{!45, !66}
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!67 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !68)
!68 = !{!69, !70, !71, !72, !73}
!69 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !67, file: !6, line: 3165, baseType: !39, size: 32)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !67, file: !6, line: 3166, baseType: !39, size: 32, offset: 32)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !67, file: !6, line: 3167, baseType: !39, size: 32, offset: 64)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !67, file: !6, line: 3169, baseType: !39, size: 32, offset: 96)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !67, file: !6, line: 3170, baseType: !39, size: 32, offset: 128)
!74 = !{!75, !76, !84, !87}
!75 = !DILocalVariable(name: "ctx", arg: 1, scope: !63, file: !3, line: 32, type: !66)
!76 = !DILocalVariable(name: "e", scope: !63, file: !3, line: 48, type: !77)
!77 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "perf_trace_event", file: !3, line: 9, size: 128, elements: !78)
!78 = !{!79, !80, !81}
!79 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !77, file: !3, line: 10, baseType: !22, size: 64)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time_ns", scope: !77, file: !3, line: 11, baseType: !39, size: 32, offset: 64)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !77, file: !3, line: 12, baseType: !82, size: 8, offset: 96)
!82 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !23, line: 21, baseType: !83)
!83 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!84 = !DILocalVariable(name: "ts", scope: !85, file: !3, line: 61, type: !22)
!85 = distinct !DILexicalBlock(scope: !86, file: !3, line: 58, column: 39)
!86 = distinct !DILexicalBlock(scope: !63, file: !3, line: 58, column: 7)
!87 = !DILocalVariable(name: "ts", scope: !63, file: !3, line: 70, type: !22)
!88 = !DILocation(line: 0, scope: !63)
!89 = !DILocation(line: 48, column: 3, scope: !63)
!90 = !DILocation(line: 48, column: 27, scope: !63)
!91 = !DILocation(line: 51, column: 17, scope: !63)
!92 = !DILocation(line: 51, column: 5, scope: !63)
!93 = !DILocation(line: 51, column: 15, scope: !63)
!94 = !{!95, !96, i64 0}
!95 = !{!"perf_trace_event", !96, i64 0, !99, i64 8, !97, i64 12}
!96 = !{!"long long", !97, i64 0}
!97 = !{!"omnipotent char", !98, i64 0}
!98 = !{!"Simple C/C++ TBAA"}
!99 = !{!"int", !97, i64 0}
!100 = !DILocation(line: 52, column: 5, scope: !63)
!101 = !DILocation(line: 52, column: 10, scope: !63)
!102 = !{!95, !97, i64 12}
!103 = !DILocation(line: 53, column: 5, scope: !63)
!104 = !DILocation(line: 53, column: 24, scope: !63)
!105 = !{!95, !99, i64 8}
!106 = !DILocation(line: 54, column: 25, scope: !63)
!107 = !DILocation(line: 54, column: 3, scope: !63)
!108 = !DILocation(line: 58, column: 7, scope: !86)
!109 = !DILocation(line: 58, column: 29, scope: !86)
!110 = !DILocation(line: 58, column: 33, scope: !86)
!111 = !DILocation(line: 58, column: 7, scope: !63)
!112 = !DILocation(line: 60, column: 12, scope: !85)
!113 = !DILocation(line: 61, column: 16, scope: !85)
!114 = !DILocation(line: 0, scope: !85)
!115 = !DILocation(line: 62, column: 35, scope: !85)
!116 = !DILocation(line: 62, column: 31, scope: !85)
!117 = !DILocation(line: 69, column: 10, scope: !63)
!118 = !DILocation(line: 70, column: 14, scope: !63)
!119 = !DILocation(line: 71, column: 33, scope: !63)
!120 = !DILocation(line: 71, column: 29, scope: !63)
!121 = !DILocation(line: 76, column: 1, scope: !63)
