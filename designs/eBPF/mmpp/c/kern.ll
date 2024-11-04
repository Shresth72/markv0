; ModuleID = 'mmpp/c/kern.c'
source_filename = "mmpp/c/kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, %struct.packet_stats*, [1 x i32]* }
%struct.packet_stats = type { i64, i64, i64 }
%struct.anon.0 = type { [2 x i32]*, i32*, %struct.shaper_stats*, [1 x i32]* }
%struct.shaper_stats = type { i64, i64, i64, i64 }
%struct.anon.1 = type { [2 x i32]*, i32*, i32*, [1 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@xdp_stats_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@shaper_stats_map = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !40
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !34
@current_state = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !66
@llvm.used = appending global [5 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.1* @current_state to i8*), i8* bitcast (%struct.anon.0* @shaper_stats_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_mmpp_shaper to i8*), i8* bitcast (%struct.anon* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_mmpp_shaper(%struct.xdp_md* nocapture readnone %0) #0 section "xdp" !dbg !90 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !102, metadata !DIExpression()), !dbg !111
  %4 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !112
  call void @llvm.dbg.value(metadata i64 %4, metadata !103, metadata !DIExpression()), !dbg !111
  %5 = bitcast i32* %3 to i8*, !dbg !113
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %5) #3, !dbg !113
  call void @llvm.dbg.value(metadata i32 0, metadata !104, metadata !DIExpression()), !dbg !111
  store i32 0, i32* %3, align 4, !dbg !114, !tbaa !115
  call void @llvm.dbg.value(metadata i32 2, metadata !105, metadata !DIExpression()), !dbg !111
  call void @llvm.dbg.value(metadata i32* %3, metadata !104, metadata !DIExpression(DW_OP_deref)), !dbg !111
  %6 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @xdp_stats_map to i8*), i8* nonnull %5) #3, !dbg !119
  call void @llvm.dbg.value(metadata i8* %6, metadata !106, metadata !DIExpression()), !dbg !111
  %7 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @shaper_stats_map to i8*), i8* nonnull %5) #3, !dbg !120
  call void @llvm.dbg.value(metadata i8* %7, metadata !107, metadata !DIExpression()), !dbg !111
  call void @llvm.dbg.value(metadata i64 0, metadata !108, metadata !DIExpression()), !dbg !111
  call void @llvm.dbg.value(metadata i64 0, metadata !109, metadata !DIExpression()), !dbg !111
  %8 = icmp ne i8* %6, null, !dbg !121
  %9 = icmp ne i8* %7, null
  %10 = and i1 %8, %9, !dbg !123
  br i1 %10, label %11, label %59, !dbg !123

11:                                               ; preds = %1
  %12 = bitcast i8* %7 to i64*, !dbg !124
  %13 = load i64, i64* %12, align 8, !dbg !124, !tbaa !126
  %14 = sub i64 %4, %13, !dbg !129
  %15 = icmp ugt i64 %14, 999999999, !dbg !130
  br i1 %15, label %24, label %16, !dbg !131

16:                                               ; preds = %11
  %17 = getelementptr inbounds i8, i8* %7, i64 16, !dbg !111
  %18 = bitcast i8* %17 to i64*, !dbg !111
  %19 = load i64, i64* %18, align 8, !dbg !132, !tbaa !133
  %20 = getelementptr inbounds i8, i8* %7, i64 24, !dbg !111
  %21 = bitcast i8* %20 to i64*, !dbg !111
  %22 = load i64, i64* %21, align 8, !dbg !134, !tbaa !135
  %23 = add i64 %19, 1, !dbg !131
  br label %36, !dbg !131

24:                                               ; preds = %11
  %25 = getelementptr inbounds i8, i8* %7, i64 24, !dbg !136
  %26 = bitcast i8* %25 to i64*, !dbg !136
  %27 = load i64, i64* %26, align 8, !dbg !136, !tbaa !135
  %28 = mul i64 %27, 8000, !dbg !138
  %29 = udiv i64 %28, 10000, !dbg !139
  %30 = getelementptr inbounds i8, i8* %7, i64 16, !dbg !140
  %31 = bitcast i8* %30 to i64*, !dbg !140
  %32 = load i64, i64* %31, align 8, !dbg !140, !tbaa !133
  %33 = mul i64 %32, 2000, !dbg !141
  %34 = udiv i64 %33, 10000, !dbg !142
  %35 = add nuw nsw i64 %34, %29, !dbg !143
  store i64 %35, i64* %26, align 8, !dbg !144, !tbaa !135
  store i64 %4, i64* %12, align 8, !dbg !145, !tbaa !126
  store i64 0, i64* %31, align 8, !dbg !146, !tbaa !133
  br label %36, !dbg !147

36:                                               ; preds = %16, %24
  %37 = phi i64* [ %18, %16 ], [ %31, %24 ], !dbg !148
  %38 = phi i64 [ %13, %16 ], [ %4, %24 ], !dbg !149
  %39 = phi i64 [ %22, %16 ], [ %35, %24 ], !dbg !134
  %40 = phi i64 [ %23, %16 ], [ 1, %24 ]
  store i64 %40, i64* %37, align 8, !dbg !132, !tbaa !133
  %41 = mul i64 %39, 10000, !dbg !150
  %42 = add i64 %4, 1, !dbg !151
  %43 = sub i64 %42, %38, !dbg !152
  %44 = udiv i64 %41, %43, !dbg !153
  call void @llvm.dbg.value(metadata i64 %44, metadata !108, metadata !DIExpression()), !dbg !111
  %45 = getelementptr inbounds i8, i8* %6, i64 16, !dbg !154
  %46 = bitcast i8* %45 to i64*, !dbg !154
  %47 = load i64, i64* %46, align 8, !dbg !154, !tbaa !155
  call void @llvm.dbg.value(metadata i64 %47, metadata !109, metadata !DIExpression()), !dbg !111
  %48 = icmp ugt i64 %44, %39, !dbg !157
  br i1 %48, label %49, label %55, !dbg !159

49:                                               ; preds = %36
  %50 = icmp ugt i64 %47, 4999, !dbg !160
  %51 = select i1 %50, i32 1, i32 2, !dbg !163
  %52 = xor i1 %50, true, !dbg !163
  %53 = zext i1 %52 to i64, !dbg !163
  %54 = add i64 %47, %53, !dbg !163
  br label %59, !dbg !163

55:                                               ; preds = %36
  %56 = icmp eq i64 %47, 0, !dbg !164
  %57 = add i64 %47, -1
  %58 = select i1 %56, i64 0, i64 %57, !dbg !166
  br label %59, !dbg !166

59:                                               ; preds = %49, %55, %1
  %60 = phi i32 [ 0, %1 ], [ 2, %55 ], [ %51, %49 ], !dbg !111
  %61 = phi i64 [ 0, %1 ], [ %44, %55 ], [ %44, %49 ], !dbg !111
  %62 = phi i64 [ 0, %1 ], [ %58, %55 ], [ %54, %49 ], !dbg !111
  call void @llvm.dbg.value(metadata i64 %62, metadata !109, metadata !DIExpression()), !dbg !111
  call void @llvm.dbg.value(metadata i64 %61, metadata !108, metadata !DIExpression()), !dbg !111
  call void @llvm.dbg.value(metadata i32 %60, metadata !105, metadata !DIExpression()), !dbg !111
  call void @llvm.dbg.label(metadata !110), !dbg !167
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !168, metadata !DIExpression()) #3, !dbg !178
  call void @llvm.dbg.value(metadata i32 %60, metadata !173, metadata !DIExpression()) #3, !dbg !178
  call void @llvm.dbg.value(metadata i64 %61, metadata !174, metadata !DIExpression()) #3, !dbg !178
  call void @llvm.dbg.value(metadata i64 %62, metadata !175, metadata !DIExpression()) #3, !dbg !178
  %63 = bitcast i32* %2 to i8*, !dbg !180
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %63) #3, !dbg !180
  call void @llvm.dbg.value(metadata i32 0, metadata !176, metadata !DIExpression()) #3, !dbg !178
  store i32 0, i32* %2, align 4, !dbg !181, !tbaa !115
  call void @llvm.dbg.value(metadata i32* %2, metadata !176, metadata !DIExpression(DW_OP_deref)) #3, !dbg !178
  %64 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @xdp_stats_map to i8*), i8* nonnull %63) #3, !dbg !182
  call void @llvm.dbg.value(metadata i8* %64, metadata !177, metadata !DIExpression()) #3, !dbg !178
  %65 = icmp eq i8* %64, null, !dbg !183
  br i1 %65, label %74, label %66, !dbg !185

66:                                               ; preds = %59
  call void @llvm.dbg.value(metadata i8* %64, metadata !177, metadata !DIExpression()) #3, !dbg !178
  %67 = bitcast i8* %64 to i64*, !dbg !186
  %68 = load i64, i64* %67, align 8, !dbg !188, !tbaa !189
  %69 = add i64 %68, 1, !dbg !188
  store i64 %69, i64* %67, align 8, !dbg !188, !tbaa !189
  %70 = getelementptr inbounds i8, i8* %64, i64 8, !dbg !190
  %71 = bitcast i8* %70 to i64*, !dbg !190
  store i64 %61, i64* %71, align 8, !dbg !191, !tbaa !192
  %72 = getelementptr inbounds i8, i8* %64, i64 16, !dbg !193
  %73 = bitcast i8* %72 to i64*, !dbg !193
  store i64 %62, i64* %73, align 8, !dbg !194, !tbaa !155
  br label %74, !dbg !195

74:                                               ; preds = %59, %66
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %63) #3, !dbg !196
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %5) #3, !dbg !197
  ret i32 %60, !dbg !198
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!86, !87, !88}
!llvm.ident = !{!89}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 39, type: !74, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "mmpp/c/kern.c", directory: "/home/shrestha/btp/designs/eBPF")
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
!14 = !{!15, !25, !34, !0, !40, !66}
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
!26 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !17, line: 56, type: !27, isLocal: true, isDefinition: true)
!27 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !28)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = !DISubroutineType(types: !30)
!30 = !{!31, !31, !32}
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!34 = !DIGlobalVariableExpression(var: !35, expr: !DIExpression())
!35 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 123, type: !36, isLocal: false, isDefinition: true)
!36 = !DICompositeType(tag: DW_TAG_array_type, baseType: !37, size: 32, elements: !38)
!37 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!38 = !{!39}
!39 = !DISubrange(count: 4)
!40 = !DIGlobalVariableExpression(var: !41, expr: !DIExpression())
!41 = distinct !DIGlobalVariable(name: "shaper_stats_map", scope: !2, file: !3, line: 46, type: !42, isLocal: false, isDefinition: true)
!42 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 41, size: 256, elements: !43)
!43 = !{!44, !50, !53, !61}
!44 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !42, file: !3, line: 42, baseType: !45, size: 64)
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !46, size: 64)
!46 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 64, elements: !48)
!47 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!48 = !{!49}
!49 = !DISubrange(count: 2)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !42, file: !3, line: 43, baseType: !51, size: 64, offset: 64)
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!52 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !23, line: 27, baseType: !7)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !42, file: !3, line: 44, baseType: !54, size: 64, offset: 128)
!54 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!55 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "shaper_stats", file: !3, line: 25, size: 256, elements: !56)
!56 = !{!57, !58, !59, !60}
!57 = !DIDerivedType(tag: DW_TAG_member, name: "window_start", scope: !55, file: !3, line: 26, baseType: !22, size: 64)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "n_shaper", scope: !55, file: !3, line: 27, baseType: !22, size: 64, offset: 64)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "n_arrivals", scope: !55, file: !3, line: 28, baseType: !22, size: 64, offset: 128)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "n_average", scope: !55, file: !3, line: 29, baseType: !22, size: 64, offset: 192)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !42, file: !3, line: 45, baseType: !62, size: 64, offset: 192)
!62 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !63, size: 64)
!63 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 32, elements: !64)
!64 = !{!65}
!65 = !DISubrange(count: 1)
!66 = !DIGlobalVariableExpression(var: !67, expr: !DIExpression())
!67 = distinct !DIGlobalVariable(name: "current_state", scope: !2, file: !3, line: 53, type: !68, isLocal: false, isDefinition: true)
!68 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 48, size: 256, elements: !69)
!69 = !{!70, !71, !72, !73}
!70 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !68, file: !3, line: 49, baseType: !45, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !68, file: !3, line: 50, baseType: !51, size: 64, offset: 64)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !68, file: !3, line: 51, baseType: !51, size: 64, offset: 128)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !68, file: !3, line: 52, baseType: !62, size: 64, offset: 192)
!74 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 34, size: 256, elements: !75)
!75 = !{!76, !77, !78, !85}
!76 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !74, file: !3, line: 35, baseType: !45, size: 64)
!77 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !74, file: !3, line: 36, baseType: !51, size: 64, offset: 64)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !74, file: !3, line: 37, baseType: !79, size: 64, offset: 128)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "packet_stats", file: !3, line: 19, size: 192, elements: !81)
!81 = !{!82, !83, !84}
!82 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !80, file: !3, line: 20, baseType: !22, size: 64)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "service_rate", scope: !80, file: !3, line: 21, baseType: !22, size: 64, offset: 64)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "queue_size", scope: !80, file: !3, line: 22, baseType: !22, size: 64, offset: 128)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !74, file: !3, line: 38, baseType: !62, size: 64, offset: 192)
!86 = !{i32 7, !"Dwarf Version", i32 4}
!87 = !{i32 2, !"Debug Info Version", i32 3}
!88 = !{i32 1, !"wchar_size", i32 4}
!89 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!90 = distinct !DISubprogram(name: "xdp_mmpp_shaper", scope: !3, file: !3, line: 73, type: !91, scopeLine: 73, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !101)
!91 = !DISubroutineType(types: !92)
!92 = !{!47, !93}
!93 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !94, size: 64)
!94 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !95)
!95 = !{!96, !97, !98, !99, !100}
!96 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !94, file: !6, line: 3165, baseType: !52, size: 32)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !94, file: !6, line: 3166, baseType: !52, size: 32, offset: 32)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !94, file: !6, line: 3167, baseType: !52, size: 32, offset: 64)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !94, file: !6, line: 3169, baseType: !52, size: 32, offset: 96)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !94, file: !6, line: 3170, baseType: !52, size: 32, offset: 128)
!101 = !{!102, !103, !104, !105, !106, !107, !108, !109, !110}
!102 = !DILocalVariable(name: "ctx", arg: 1, scope: !90, file: !3, line: 73, type: !93)
!103 = !DILocalVariable(name: "now", scope: !90, file: !3, line: 74, type: !22)
!104 = !DILocalVariable(name: "key", scope: !90, file: !3, line: 75, type: !52)
!105 = !DILocalVariable(name: "action", scope: !90, file: !3, line: 76, type: !52)
!106 = !DILocalVariable(name: "xdp_stats_ptr", scope: !90, file: !3, line: 78, type: !79)
!107 = !DILocalVariable(name: "shaper_stats_ptr", scope: !90, file: !3, line: 80, type: !54)
!108 = !DILocalVariable(name: "service_rate", scope: !90, file: !3, line: 84, type: !22)
!109 = !DILocalVariable(name: "queue_size", scope: !90, file: !3, line: 85, type: !22)
!110 = !DILabel(scope: !90, name: "out", file: !3, line: 119)
!111 = !DILocation(line: 0, scope: !90)
!112 = !DILocation(line: 74, column: 15, scope: !90)
!113 = !DILocation(line: 75, column: 3, scope: !90)
!114 = !DILocation(line: 75, column: 9, scope: !90)
!115 = !{!116, !116, i64 0}
!116 = !{!"int", !117, i64 0}
!117 = !{!"omnipotent char", !118, i64 0}
!118 = !{!"Simple C/C++ TBAA"}
!119 = !DILocation(line: 79, column: 7, scope: !90)
!120 = !DILocation(line: 81, column: 7, scope: !90)
!121 = !DILocation(line: 87, column: 8, scope: !122)
!122 = distinct !DILexicalBlock(scope: !90, file: !3, line: 87, column: 7)
!123 = !DILocation(line: 87, column: 22, scope: !122)
!124 = !DILocation(line: 92, column: 31, scope: !125)
!125 = distinct !DILexicalBlock(scope: !90, file: !3, line: 92, column: 7)
!126 = !{!127, !128, i64 0}
!127 = !{!"shaper_stats", !128, i64 0, !128, i64 8, !128, i64 16, !128, i64 24}
!128 = !{!"long long", !117, i64 0}
!129 = !DILocation(line: 92, column: 11, scope: !125)
!130 = !DILocation(line: 92, column: 44, scope: !125)
!131 = !DILocation(line: 92, column: 7, scope: !90)
!132 = !DILocation(line: 101, column: 31, scope: !90)
!133 = !{!127, !128, i64 16}
!134 = !DILocation(line: 105, column: 26, scope: !90)
!135 = !{!127, !128, i64 24}
!136 = !DILocation(line: 95, column: 36, scope: !137)
!137 = distinct !DILexicalBlock(scope: !125, file: !3, line: 92, column: 60)
!138 = !DILocation(line: 95, column: 16, scope: !137)
!139 = !DILocation(line: 95, column: 46, scope: !137)
!140 = !DILocation(line: 96, column: 46, scope: !137)
!141 = !DILocation(line: 96, column: 26, scope: !137)
!142 = !DILocation(line: 96, column: 57, scope: !137)
!143 = !DILocation(line: 95, column: 55, scope: !137)
!144 = !DILocation(line: 94, column: 33, scope: !137)
!145 = !DILocation(line: 97, column: 36, scope: !137)
!146 = !DILocation(line: 98, column: 34, scope: !137)
!147 = !DILocation(line: 99, column: 3, scope: !137)
!148 = !DILocation(line: 101, column: 21, scope: !90)
!149 = !DILocation(line: 106, column: 32, scope: !90)
!150 = !DILocation(line: 105, column: 36, scope: !90)
!151 = !DILocation(line: 106, column: 12, scope: !90)
!152 = !DILocation(line: 106, column: 45, scope: !90)
!153 = !DILocation(line: 105, column: 45, scope: !90)
!154 = !DILocation(line: 107, column: 31, scope: !90)
!155 = !{!156, !128, i64 16}
!156 = !{!"packet_stats", !128, i64 0, !128, i64 8, !128, i64 16}
!157 = !DILocation(line: 109, column: 20, scope: !158)
!158 = distinct !DILexicalBlock(scope: !90, file: !3, line: 109, column: 7)
!159 = !DILocation(line: 109, column: 7, scope: !90)
!160 = !DILocation(line: 110, column: 20, scope: !161)
!161 = distinct !DILexicalBlock(scope: !162, file: !3, line: 110, column: 9)
!162 = distinct !DILexicalBlock(scope: !158, file: !3, line: 109, column: 51)
!163 = !DILocation(line: 110, column: 9, scope: !162)
!164 = !DILocation(line: 115, column: 25, scope: !165)
!165 = distinct !DILexicalBlock(scope: !158, file: !3, line: 115, column: 14)
!166 = !DILocation(line: 115, column: 14, scope: !158)
!167 = !DILocation(line: 119, column: 1, scope: !90)
!168 = !DILocalVariable(name: "ctx", arg: 1, scope: !169, file: !3, line: 55, type: !93)
!169 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 55, type: !170, scopeLine: 58, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !172)
!170 = !DISubroutineType(types: !171)
!171 = !{!52, !93, !52, !22, !22}
!172 = !{!168, !173, !174, !175, !176, !177}
!173 = !DILocalVariable(name: "action", arg: 2, scope: !169, file: !3, line: 56, type: !52)
!174 = !DILocalVariable(name: "service_rate", arg: 3, scope: !169, file: !3, line: 57, type: !22)
!175 = !DILocalVariable(name: "queue_size", arg: 4, scope: !169, file: !3, line: 58, type: !22)
!176 = !DILocalVariable(name: "key", scope: !169, file: !3, line: 59, type: !52)
!177 = !DILocalVariable(name: "xdp_stats_ptr", scope: !169, file: !3, line: 60, type: !79)
!178 = !DILocation(line: 0, scope: !169, inlinedAt: !179)
!179 = distinct !DILocation(line: 120, column: 10, scope: !90)
!180 = !DILocation(line: 59, column: 3, scope: !169, inlinedAt: !179)
!181 = !DILocation(line: 59, column: 9, scope: !169, inlinedAt: !179)
!182 = !DILocation(line: 61, column: 7, scope: !169, inlinedAt: !179)
!183 = !DILocation(line: 63, column: 7, scope: !184, inlinedAt: !179)
!184 = distinct !DILexicalBlock(scope: !169, file: !3, line: 63, column: 7)
!185 = !DILocation(line: 63, column: 7, scope: !169, inlinedAt: !179)
!186 = !DILocation(line: 64, column: 20, scope: !187, inlinedAt: !179)
!187 = distinct !DILexicalBlock(scope: !184, file: !3, line: 63, column: 22)
!188 = !DILocation(line: 64, column: 30, scope: !187, inlinedAt: !179)
!189 = !{!156, !128, i64 0}
!190 = !DILocation(line: 65, column: 20, scope: !187, inlinedAt: !179)
!191 = !DILocation(line: 65, column: 33, scope: !187, inlinedAt: !179)
!192 = !{!156, !128, i64 8}
!193 = !DILocation(line: 66, column: 20, scope: !187, inlinedAt: !179)
!194 = !DILocation(line: 66, column: 31, scope: !187, inlinedAt: !179)
!195 = !DILocation(line: 67, column: 3, scope: !187, inlinedAt: !179)
!196 = !DILocation(line: 70, column: 1, scope: !169, inlinedAt: !179)
!197 = !DILocation(line: 121, column: 1, scope: !90)
!198 = !DILocation(line: 120, column: 3, scope: !90)
