; ModuleID = 'kern.c'
source_filename = "kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [4 x i32]*, [4 x i32]*, [0 x i32]*, [1024 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.perf_trace_event = type { i64, i32, i8 }

@output_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !40
@llvm.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @output_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_lib to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_lib(%struct.xdp_md* %0) #0 section "xdp" !dbg !67 {
  %2 = alloca %struct.perf_trace_event, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !79, metadata !DIExpression()), !dbg !92
  %3 = bitcast %struct.perf_trace_event* %2 to i8*, !dbg !93
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #4, !dbg !93
  call void @llvm.dbg.declare(metadata %struct.perf_trace_event* %2, metadata !80, metadata !DIExpression()), !dbg !94
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(16) %3, i8 0, i64 16, i1 false), !dbg !94
  %4 = tail call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !95
  %5 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 0, !dbg !96
  store i64 %4, i64* %5, align 8, !dbg !97, !tbaa !98
  %6 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 2, !dbg !104
  store i8 1, i8* %6, align 4, !dbg !105, !tbaa !106
  %7 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 1, !dbg !107
  store i32 0, i32* %7, align 8, !dbg !108, !tbaa !109
  %8 = bitcast %struct.xdp_md* %0 to i8*, !dbg !110
  %9 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* %8, i8* bitcast (%struct.anon* @output_map to i8*), i64 4294967295, i8* nonnull %3, i64 16) #4, !dbg !111
  %10 = call i32 inttoptr (i64 7 to i32 ()*)() #4, !dbg !112
  %11 = and i32 %10, 1, !dbg !113
  %12 = icmp eq i32 %11, 0, !dbg !114
  br i1 %12, label %13, label %17, !dbg !115

13:                                               ; preds = %1
  store i8 2, i8* %6, align 4, !dbg !116, !tbaa !106
  %14 = call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !117
  call void @llvm.dbg.value(metadata i64 %14, metadata !88, metadata !DIExpression()), !dbg !118
  %15 = load i64, i64* %5, align 8, !dbg !119, !tbaa !98
  %16 = sub i64 %14, %15, !dbg !120
  br label %21

17:                                               ; preds = %1
  store i8 3, i8* %6, align 4, !dbg !121, !tbaa !106
  %18 = call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !122
  call void @llvm.dbg.value(metadata i64 %18, metadata !91, metadata !DIExpression()), !dbg !92
  %19 = load i64, i64* %5, align 8, !dbg !123, !tbaa !98
  %20 = sub i64 %18, %19, !dbg !124
  br label %21

21:                                               ; preds = %17, %13
  %22 = phi i64 [ %20, %17 ], [ %16, %13 ]
  %23 = phi i64 [ %18, %17 ], [ %14, %13 ], !dbg !92
  %24 = phi i32 [ 2, %17 ], [ 1, %13 ], !dbg !92
  %25 = trunc i64 %22 to i32, !dbg !92
  store i32 %25, i32* %7, align 8, !dbg !92, !tbaa !109
  store i64 %23, i64* %5, align 8, !dbg !92, !tbaa !98
  %26 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* %8, i8* bitcast (%struct.anon* @output_map to i8*), i64 4294967295, i8* nonnull %3, i64 16) #4, !dbg !92
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #4, !dbg !125
  ret i32 %24, !dbg !125
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { argmemonly nounwind willreturn writeonly }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!63, !64, !65}
!llvm.ident = !{!66}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "output_map", scope: !2, file: !3, line: 27, type: !46, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "kern.c", directory: "/home/shrestha/btp/pktsniff/ebpf")
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
!14 = !{!15, !25, !33, !40, !0}
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
!40 = !DIGlobalVariableExpression(var: !41, expr: !DIExpression())
!41 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 79, type: !42, isLocal: false, isDefinition: true)
!42 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, size: 32, elements: !44)
!43 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!44 = !{!45}
!45 = !DISubrange(count: 4)
!46 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 21, size: 256, elements: !47)
!47 = !{!48, !52, !53, !58}
!48 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !46, file: !3, line: 23, baseType: !49, size: 64)
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!50 = !DICompositeType(tag: DW_TAG_array_type, baseType: !51, size: 128, elements: !44)
!51 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !46, file: !3, line: 24, baseType: !49, size: 64, offset: 64)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !46, file: !3, line: 25, baseType: !54, size: 64, offset: 128)
!54 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!55 = !DICompositeType(tag: DW_TAG_array_type, baseType: !51, elements: !56)
!56 = !{!57}
!57 = !DISubrange(count: 0)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !46, file: !3, line: 26, baseType: !59, size: 64, offset: 192)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = !DICompositeType(tag: DW_TAG_array_type, baseType: !51, size: 32768, elements: !61)
!61 = !{!62}
!62 = !DISubrange(count: 1024)
!63 = !{i32 7, !"Dwarf Version", i32 4}
!64 = !{i32 2, !"Debug Info Version", i32 3}
!65 = !{i32 1, !"wchar_size", i32 4}
!66 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!67 = distinct !DISubprogram(name: "xdp_lib", scope: !3, file: !3, line: 33, type: !68, scopeLine: 33, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !78)
!68 = !DISubroutineType(types: !69)
!69 = !{!51, !70}
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !72)
!72 = !{!73, !74, !75, !76, !77}
!73 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !71, file: !6, line: 3165, baseType: !39, size: 32)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !71, file: !6, line: 3166, baseType: !39, size: 32, offset: 32)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !71, file: !6, line: 3167, baseType: !39, size: 32, offset: 64)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !71, file: !6, line: 3169, baseType: !39, size: 32, offset: 96)
!77 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !71, file: !6, line: 3170, baseType: !39, size: 32, offset: 128)
!78 = !{!79, !80, !88, !91}
!79 = !DILocalVariable(name: "ctx", arg: 1, scope: !67, file: !3, line: 33, type: !70)
!80 = !DILocalVariable(name: "e", scope: !67, file: !3, line: 49, type: !81)
!81 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "perf_trace_event", file: !3, line: 10, size: 128, elements: !82)
!82 = !{!83, !84, !85}
!83 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !81, file: !3, line: 11, baseType: !22, size: 64)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time_ns", scope: !81, file: !3, line: 12, baseType: !39, size: 32, offset: 64)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !81, file: !3, line: 13, baseType: !86, size: 8, offset: 96)
!86 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !23, line: 21, baseType: !87)
!87 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!88 = !DILocalVariable(name: "ts", scope: !89, file: !3, line: 62, type: !22)
!89 = distinct !DILexicalBlock(scope: !90, file: !3, line: 59, column: 39)
!90 = distinct !DILexicalBlock(scope: !67, file: !3, line: 59, column: 7)
!91 = !DILocalVariable(name: "ts", scope: !67, file: !3, line: 71, type: !22)
!92 = !DILocation(line: 0, scope: !67)
!93 = !DILocation(line: 49, column: 3, scope: !67)
!94 = !DILocation(line: 49, column: 27, scope: !67)
!95 = !DILocation(line: 52, column: 17, scope: !67)
!96 = !DILocation(line: 52, column: 5, scope: !67)
!97 = !DILocation(line: 52, column: 15, scope: !67)
!98 = !{!99, !100, i64 0}
!99 = !{!"perf_trace_event", !100, i64 0, !103, i64 8, !101, i64 12}
!100 = !{!"long long", !101, i64 0}
!101 = !{!"omnipotent char", !102, i64 0}
!102 = !{!"Simple C/C++ TBAA"}
!103 = !{!"int", !101, i64 0}
!104 = !DILocation(line: 53, column: 5, scope: !67)
!105 = !DILocation(line: 53, column: 10, scope: !67)
!106 = !{!99, !101, i64 12}
!107 = !DILocation(line: 54, column: 5, scope: !67)
!108 = !DILocation(line: 54, column: 24, scope: !67)
!109 = !{!99, !103, i64 8}
!110 = !DILocation(line: 55, column: 25, scope: !67)
!111 = !DILocation(line: 55, column: 3, scope: !67)
!112 = !DILocation(line: 59, column: 7, scope: !90)
!113 = !DILocation(line: 59, column: 29, scope: !90)
!114 = !DILocation(line: 59, column: 33, scope: !90)
!115 = !DILocation(line: 59, column: 7, scope: !67)
!116 = !DILocation(line: 61, column: 12, scope: !89)
!117 = !DILocation(line: 62, column: 16, scope: !89)
!118 = !DILocation(line: 0, scope: !89)
!119 = !DILocation(line: 63, column: 35, scope: !89)
!120 = !DILocation(line: 63, column: 31, scope: !89)
!121 = !DILocation(line: 70, column: 10, scope: !67)
!122 = !DILocation(line: 71, column: 14, scope: !67)
!123 = !DILocation(line: 72, column: 33, scope: !67)
!124 = !DILocation(line: 72, column: 29, scope: !67)
!125 = !DILocation(line: 77, column: 1, scope: !67)
