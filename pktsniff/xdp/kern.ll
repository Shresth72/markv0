; ModuleID = 'kern.c'
source_filename = "kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [4 x i32]*, [4 x i32]*, [0 x i32]*, [1024 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.perf_trace_event = type { i64, i32, i8 }

@output_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !40
@llvm.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @output_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_lib to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_lib(%struct.xdp_md* %0) #0 section "xdp" !dbg !133 {
  %2 = alloca %struct.perf_trace_event, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !145, metadata !DIExpression()), !dbg !158
  %3 = bitcast %struct.perf_trace_event* %2 to i8*, !dbg !159
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #3, !dbg !159
  call void @llvm.dbg.declare(metadata %struct.perf_trace_event* %2, metadata !146, metadata !DIExpression()), !dbg !160
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(16) %3, i8 0, i64 16, i1 false), !dbg !160
  %4 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !161
  %5 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 0, !dbg !162
  store i64 %4, i64* %5, align 8, !dbg !163, !tbaa !164
  %6 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 2, !dbg !170
  store i8 1, i8* %6, align 4, !dbg !171, !tbaa !172
  %7 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 1, !dbg !173
  store i32 0, i32* %7, align 8, !dbg !174, !tbaa !175
  %8 = bitcast %struct.xdp_md* %0 to i8*, !dbg !176
  %9 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* %8, i8* bitcast (%struct.anon* @output_map to i8*), i64 4294967295, i8* nonnull %3, i64 16) #3, !dbg !177
  %10 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !178
  %11 = and i32 %10, 1, !dbg !179
  %12 = icmp eq i32 %11, 0, !dbg !180
  br i1 %12, label %13, label %17, !dbg !181

13:                                               ; preds = %1
  store i8 2, i8* %6, align 4, !dbg !182, !tbaa !172
  %14 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !183
  call void @llvm.dbg.value(metadata i64 %14, metadata !154, metadata !DIExpression()), !dbg !184
  %15 = load i64, i64* %5, align 8, !dbg !185, !tbaa !164
  %16 = sub i64 %14, %15, !dbg !186
  br label %21

17:                                               ; preds = %1
  store i8 3, i8* %6, align 4, !dbg !187, !tbaa !172
  %18 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !188
  call void @llvm.dbg.value(metadata i64 %18, metadata !157, metadata !DIExpression()), !dbg !158
  %19 = load i64, i64* %5, align 8, !dbg !189, !tbaa !164
  %20 = sub i64 %18, %19, !dbg !190
  br label %21

21:                                               ; preds = %17, %13
  %22 = phi i64 [ %16, %13 ], [ %20, %17 ]
  %23 = phi i64 [ %14, %13 ], [ %18, %17 ], !dbg !158
  %24 = phi i32 [ 1, %13 ], [ 2, %17 ], !dbg !158
  %25 = trunc i64 %22 to i32, !dbg !158
  store i32 %25, i32* %7, align 8, !dbg !158, !tbaa !175
  store i64 %23, i64* %5, align 8, !dbg !158, !tbaa !164
  %26 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* %8, i8* bitcast (%struct.anon* @output_map to i8*), i64 4294967295, i8* nonnull %3, i64 16) #3, !dbg !158
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #3, !dbg !191
  ret i32 %24, !dbg !191
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
!llvm.module.flags = !{!129, !130, !131}
!llvm.ident = !{!132}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "output_map", scope: !2, file: !3, line: 29, type: !113, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "kern.c", directory: "/home/shrestha/btp/pktsniff/xdp")
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
!14 = !{!15, !25, !33, !40, !0, !46, !111}
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
!41 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 81, type: !42, isLocal: false, isDefinition: true)
!42 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, size: 32, elements: !44)
!43 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!44 = !{!45}
!45 = !DISubrange(count: 4)
!46 = !DIGlobalVariableExpression(var: !47, expr: !DIExpression())
!47 = distinct !DIGlobalVariable(name: "stdin", scope: !2, file: !48, line: 137, type: !49, isLocal: false, isDefinition: false)
!48 = !DIFile(filename: "/usr/include/stdio.h", directory: "")
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!50 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !51, line: 7, baseType: !52)
!51 = !DIFile(filename: "/usr/include/bits/types/FILE.h", directory: "")
!52 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !53, line: 49, size: 1728, elements: !54)
!53 = !DIFile(filename: "/usr/include/bits/types/struct_FILE.h", directory: "")
!54 = !{!55, !57, !59, !60, !61, !62, !63, !64, !65, !66, !67, !68, !69, !72, !74, !75, !76, !79, !81, !83, !87, !90, !94, !97, !100, !101, !102, !106, !107}
!55 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !52, file: !53, line: 51, baseType: !56, size: 32)
!56 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !52, file: !53, line: 54, baseType: !58, size: 64, offset: 64)
!58 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !43, size: 64)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !52, file: !53, line: 55, baseType: !58, size: 64, offset: 128)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !52, file: !53, line: 56, baseType: !58, size: 64, offset: 192)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !52, file: !53, line: 57, baseType: !58, size: 64, offset: 256)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !52, file: !53, line: 58, baseType: !58, size: 64, offset: 320)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !52, file: !53, line: 59, baseType: !58, size: 64, offset: 384)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !52, file: !53, line: 60, baseType: !58, size: 64, offset: 448)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !52, file: !53, line: 61, baseType: !58, size: 64, offset: 512)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !52, file: !53, line: 64, baseType: !58, size: 64, offset: 576)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !52, file: !53, line: 65, baseType: !58, size: 64, offset: 640)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !52, file: !53, line: 66, baseType: !58, size: 64, offset: 704)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !52, file: !53, line: 68, baseType: !70, size: 64, offset: 768)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !53, line: 36, flags: DIFlagFwdDecl)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !52, file: !53, line: 70, baseType: !73, size: 64, offset: 832)
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !52, file: !53, line: 72, baseType: !56, size: 32, offset: 896)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !52, file: !53, line: 73, baseType: !56, size: 32, offset: 928)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !52, file: !53, line: 74, baseType: !77, size: 64, offset: 960)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !78, line: 152, baseType: !31)
!78 = !DIFile(filename: "/usr/include/bits/types.h", directory: "")
!79 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !52, file: !53, line: 77, baseType: !80, size: 16, offset: 1024)
!80 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !52, file: !53, line: 78, baseType: !82, size: 8, offset: 1040)
!82 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !52, file: !53, line: 79, baseType: !84, size: 8, offset: 1048)
!84 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, size: 8, elements: !85)
!85 = !{!86}
!86 = !DISubrange(count: 1)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !52, file: !53, line: 81, baseType: !88, size: 64, offset: 1088)
!88 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !89, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !53, line: 43, baseType: null)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !52, file: !53, line: 89, baseType: !91, size: 64, offset: 1152)
!91 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !78, line: 153, baseType: !92)
!92 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !78, line: 47, baseType: !93)
!93 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !52, file: !53, line: 91, baseType: !95, size: 64, offset: 1216)
!95 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !96, size: 64)
!96 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !53, line: 37, flags: DIFlagFwdDecl)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !52, file: !53, line: 92, baseType: !98, size: 64, offset: 1280)
!98 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!99 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !53, line: 38, flags: DIFlagFwdDecl)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !52, file: !53, line: 93, baseType: !73, size: 64, offset: 1344)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !52, file: !53, line: 94, baseType: !32, size: 64, offset: 1408)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !52, file: !53, line: 95, baseType: !103, size: 64, offset: 1472)
!103 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !104, line: 46, baseType: !105)
!104 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!105 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !52, file: !53, line: 96, baseType: !56, size: 32, offset: 1536)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !52, file: !53, line: 98, baseType: !108, size: 160, offset: 1568)
!108 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, size: 160, elements: !109)
!109 = !{!110}
!110 = !DISubrange(count: 20)
!111 = !DIGlobalVariableExpression(var: !112, expr: !DIExpression())
!112 = distinct !DIGlobalVariable(name: "stdout", scope: !2, file: !48, line: 138, type: !49, isLocal: false, isDefinition: false)
!113 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 23, size: 256, elements: !114)
!114 = !{!115, !118, !119, !124}
!115 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !113, file: !3, line: 25, baseType: !116, size: 64)
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!117 = !DICompositeType(tag: DW_TAG_array_type, baseType: !56, size: 128, elements: !44)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !113, file: !3, line: 26, baseType: !116, size: 64, offset: 64)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !113, file: !3, line: 27, baseType: !120, size: 64, offset: 128)
!120 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !121, size: 64)
!121 = !DICompositeType(tag: DW_TAG_array_type, baseType: !56, elements: !122)
!122 = !{!123}
!123 = !DISubrange(count: 0)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !113, file: !3, line: 28, baseType: !125, size: 64, offset: 192)
!125 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !126, size: 64)
!126 = !DICompositeType(tag: DW_TAG_array_type, baseType: !56, size: 32768, elements: !127)
!127 = !{!128}
!128 = !DISubrange(count: 1024)
!129 = !{i32 7, !"Dwarf Version", i32 4}
!130 = !{i32 2, !"Debug Info Version", i32 3}
!131 = !{i32 1, !"wchar_size", i32 4}
!132 = !{!"clang version 10.0.0-4ubuntu1 "}
!133 = distinct !DISubprogram(name: "xdp_lib", scope: !3, file: !3, line: 35, type: !134, scopeLine: 35, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !144)
!134 = !DISubroutineType(types: !135)
!135 = !{!56, !136}
!136 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !137, size: 64)
!137 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !138)
!138 = !{!139, !140, !141, !142, !143}
!139 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !137, file: !6, line: 3165, baseType: !39, size: 32)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !137, file: !6, line: 3166, baseType: !39, size: 32, offset: 32)
!141 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !137, file: !6, line: 3167, baseType: !39, size: 32, offset: 64)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !137, file: !6, line: 3169, baseType: !39, size: 32, offset: 96)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !137, file: !6, line: 3170, baseType: !39, size: 32, offset: 128)
!144 = !{!145, !146, !154, !157}
!145 = !DILocalVariable(name: "ctx", arg: 1, scope: !133, file: !3, line: 35, type: !136)
!146 = !DILocalVariable(name: "e", scope: !133, file: !3, line: 51, type: !147)
!147 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "perf_trace_event", file: !3, line: 12, size: 128, elements: !148)
!148 = !{!149, !150, !151}
!149 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !147, file: !3, line: 13, baseType: !22, size: 64)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time_ns", scope: !147, file: !3, line: 14, baseType: !39, size: 32, offset: 64)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !147, file: !3, line: 15, baseType: !152, size: 8, offset: 96)
!152 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !23, line: 21, baseType: !153)
!153 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!154 = !DILocalVariable(name: "ts", scope: !155, file: !3, line: 64, type: !22)
!155 = distinct !DILexicalBlock(scope: !156, file: !3, line: 61, column: 39)
!156 = distinct !DILexicalBlock(scope: !133, file: !3, line: 61, column: 7)
!157 = !DILocalVariable(name: "ts", scope: !133, file: !3, line: 73, type: !22)
!158 = !DILocation(line: 0, scope: !133)
!159 = !DILocation(line: 51, column: 3, scope: !133)
!160 = !DILocation(line: 51, column: 27, scope: !133)
!161 = !DILocation(line: 54, column: 17, scope: !133)
!162 = !DILocation(line: 54, column: 5, scope: !133)
!163 = !DILocation(line: 54, column: 15, scope: !133)
!164 = !{!165, !166, i64 0}
!165 = !{!"perf_trace_event", !166, i64 0, !169, i64 8, !167, i64 12}
!166 = !{!"long long", !167, i64 0}
!167 = !{!"omnipotent char", !168, i64 0}
!168 = !{!"Simple C/C++ TBAA"}
!169 = !{!"int", !167, i64 0}
!170 = !DILocation(line: 55, column: 5, scope: !133)
!171 = !DILocation(line: 55, column: 10, scope: !133)
!172 = !{!165, !167, i64 12}
!173 = !DILocation(line: 56, column: 5, scope: !133)
!174 = !DILocation(line: 56, column: 24, scope: !133)
!175 = !{!165, !169, i64 8}
!176 = !DILocation(line: 57, column: 25, scope: !133)
!177 = !DILocation(line: 57, column: 3, scope: !133)
!178 = !DILocation(line: 61, column: 7, scope: !156)
!179 = !DILocation(line: 61, column: 29, scope: !156)
!180 = !DILocation(line: 61, column: 33, scope: !156)
!181 = !DILocation(line: 61, column: 7, scope: !133)
!182 = !DILocation(line: 63, column: 12, scope: !155)
!183 = !DILocation(line: 64, column: 16, scope: !155)
!184 = !DILocation(line: 0, scope: !155)
!185 = !DILocation(line: 65, column: 35, scope: !155)
!186 = !DILocation(line: 65, column: 31, scope: !155)
!187 = !DILocation(line: 72, column: 10, scope: !133)
!188 = !DILocation(line: 73, column: 14, scope: !133)
!189 = !DILocation(line: 74, column: 33, scope: !133)
!190 = !DILocation(line: 74, column: 29, scope: !133)
!191 = !DILocation(line: 79, column: 1, scope: !133)
