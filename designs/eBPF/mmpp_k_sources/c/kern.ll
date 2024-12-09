; ModuleID = './mmpp_k_sources/c/kern.c'
source_filename = "./mmpp_k_sources/c/kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, %struct.xdp_stats*, [5 x i32]* }
%struct.xdp_stats = type { i64, i64, i64 }
%struct.anon.0 = type { [2 x i32]*, i32*, %struct.shaper_stats*, [5 x i32]* }
%struct.shaper_stats = type { i64, i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !0
@xdp_stats_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !25
@shaper_stats_map = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !51
@llvm.used = appending global [4 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.0* @shaper_stats_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_mmpp_shaper to i8*), i8* bitcast (%struct.anon* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_mmpp_shaper(%struct.xdp_md* nocapture readnone %0) #0 section "xdp" !dbg !82 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !94, metadata !DIExpression()), !dbg !98
  %4 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !99
  call void @llvm.dbg.value(metadata i64 %4, metadata !95, metadata !DIExpression()), !dbg !98
  call void @llvm.dbg.value(metadata i32 0, metadata !96, metadata !DIExpression()), !dbg !100
  %5 = bitcast i32* %3 to i8*, !dbg !101
  %6 = bitcast i32* %2 to i8*, !dbg !117
  br label %8, !dbg !129

7:                                                ; preds = %77
  ret i32 2, !dbg !130

8:                                                ; preds = %77, %1
  %9 = phi i32 [ 0, %1 ], [ %78, %77 ]
  call void @llvm.dbg.value(metadata i32 %9, metadata !96, metadata !DIExpression()), !dbg !100
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %5), !dbg !101
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !106, metadata !DIExpression()) #3, !dbg !101
  call void @llvm.dbg.value(metadata i32 %9, metadata !107, metadata !DIExpression()) #3, !dbg !101
  store i32 %9, i32* %3, align 4, !tbaa !131
  call void @llvm.dbg.value(metadata i64 %4, metadata !108, metadata !DIExpression()) #3, !dbg !101
  call void @llvm.dbg.value(metadata i32* %3, metadata !107, metadata !DIExpression(DW_OP_deref)) #3, !dbg !101
  %10 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @shaper_stats_map to i8*), i8* nonnull %5) #3, !dbg !135
  call void @llvm.dbg.value(metadata i8* %10, metadata !109, metadata !DIExpression()) #3, !dbg !101
  %11 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @xdp_stats_map to i8*), i8* nonnull %5) #3, !dbg !136
  call void @llvm.dbg.value(metadata i8* %11, metadata !110, metadata !DIExpression()) #3, !dbg !101
  %12 = icmp ne i8* %11, null, !dbg !137
  %13 = icmp ne i8* %10, null
  %14 = and i1 %13, %12, !dbg !139
  br i1 %14, label %15, label %77, !dbg !139

15:                                               ; preds = %8
  call void @llvm.dbg.value(metadata i8* %10, metadata !140, metadata !DIExpression()) #3, !dbg !146
  call void @llvm.dbg.value(metadata i64 %4, metadata !145, metadata !DIExpression()) #3, !dbg !146
  %16 = getelementptr inbounds i8, i8* %10, i64 16, !dbg !148
  %17 = bitcast i8* %16 to i64*, !dbg !148
  %18 = load i64, i64* %17, align 8, !dbg !148, !tbaa !150
  %19 = icmp ult i64 %18, 10, !dbg !153
  br i1 %19, label %20, label %21, !dbg !154

20:                                               ; preds = %15
  store i64 10, i64* %17, align 8, !dbg !155, !tbaa !150
  br label %21, !dbg !157

21:                                               ; preds = %20, %15
  %22 = phi i64 [ 10, %20 ], [ %18, %15 ]
  %23 = bitcast i8* %10 to i64*, !dbg !158
  %24 = load i64, i64* %23, align 8, !dbg !158, !tbaa !160
  %25 = sub i64 %4, %24, !dbg !161
  %26 = icmp ugt i64 %25, 7999999999, !dbg !162
  br i1 %26, label %27, label %37, !dbg !163

27:                                               ; preds = %21
  %28 = mul i64 %22, 8000, !dbg !164
  %29 = getelementptr inbounds i8, i8* %10, i64 8, !dbg !166
  %30 = bitcast i8* %29 to i64*, !dbg !166
  %31 = load i64, i64* %30, align 8, !dbg !166, !tbaa !167
  %32 = mul i64 %31, 999992000, !dbg !168
  %33 = add i64 %32, %28, !dbg !169
  %34 = udiv i64 %33, 1000000000, !dbg !170
  store i64 %34, i64* %17, align 8, !dbg !171, !tbaa !150
  store i64 %4, i64* %23, align 8, !dbg !172, !tbaa !160
  store i64 1, i64* %30, align 8, !dbg !173, !tbaa !167
  call void @llvm.dbg.value(metadata i8* %10, metadata !174, metadata !DIExpression()) #3, !dbg !182
  call void @llvm.dbg.value(metadata i64 %4, metadata !179, metadata !DIExpression()) #3, !dbg !182
  call void @llvm.dbg.value(metadata i64 undef, metadata !180, metadata !DIExpression()) #3, !dbg !182
  %35 = icmp ult i64 %33, 10000000000, !dbg !184
  br i1 %35, label %36, label %44, !dbg !186

36:                                               ; preds = %27
  store i64 10, i64* %17, align 8, !dbg !187, !tbaa !150
  br label %44, !dbg !189

37:                                               ; preds = %21
  %38 = getelementptr inbounds i8, i8* %10, i64 8, !dbg !146
  %39 = bitcast i8* %38 to i64*, !dbg !146
  %40 = load i64, i64* %39, align 8, !dbg !173, !tbaa !167
  %41 = add i64 %40, 1, !dbg !163
  store i64 %41, i64* %39, align 8, !dbg !173, !tbaa !167
  call void @llvm.dbg.value(metadata i8* %10, metadata !174, metadata !DIExpression()) #3, !dbg !182
  call void @llvm.dbg.value(metadata i64 %4, metadata !179, metadata !DIExpression()) #3, !dbg !182
  call void @llvm.dbg.value(metadata i64 undef, metadata !180, metadata !DIExpression()) #3, !dbg !182
  %42 = icmp ugt i64 %25, 10000000, !dbg !190
  %43 = select i1 %42, i64 %25, i64 10000000, !dbg !190
  br label %44, !dbg !190

44:                                               ; preds = %37, %27, %36
  %45 = phi i64 [ %34, %27 ], [ 10, %36 ], [ %22, %37 ]
  %46 = phi i64 [ 10000000, %27 ], [ 10000000, %36 ], [ %43, %37 ]
  call void @llvm.dbg.value(metadata i64 %46, metadata !180, metadata !DIExpression()) #3, !dbg !182
  %47 = mul i64 %45, 1000000000, !dbg !191
  %48 = udiv i64 %47, %46, !dbg !192
  call void @llvm.dbg.value(metadata i64 %48, metadata !181, metadata !DIExpression()) #3, !dbg !182
  call void @llvm.dbg.value(metadata i64 %48, metadata !111, metadata !DIExpression()) #3, !dbg !101
  %49 = getelementptr inbounds i8, i8* %11, i64 16, !dbg !193
  %50 = bitcast i8* %49 to i64*, !dbg !193
  %51 = load i64, i64* %50, align 8, !dbg !193, !tbaa !194
  call void @llvm.dbg.value(metadata i64 %51, metadata !112, metadata !DIExpression()) #3, !dbg !101
  %52 = icmp ult i64 %48, %45, !dbg !196
  br i1 %52, label %57, label %53, !dbg !198

53:                                               ; preds = %44
  %54 = icmp eq i64 %51, 0, !dbg !199
  %55 = add i64 %51, -1
  %56 = select i1 %54, i64 0, i64 %55, !dbg !202
  br label %61, !dbg !202

57:                                               ; preds = %44
  %58 = icmp ult i64 %51, 300, !dbg !203
  %59 = zext i1 %58 to i64, !dbg !206
  %60 = add i64 %51, %59, !dbg !206
  br label %61, !dbg !206

61:                                               ; preds = %57, %53
  %62 = phi i64 [ %56, %53 ], [ %60, %57 ], !dbg !101
  call void @llvm.dbg.value(metadata i64 %62, metadata !112, metadata !DIExpression()) #3, !dbg !101
  store i64 %62, i64* %50, align 8, !dbg !207, !tbaa !194
  %63 = getelementptr inbounds i8, i8* %11, i64 8, !dbg !208
  %64 = bitcast i8* %63 to i64*, !dbg !208
  store i64 %48, i64* %64, align 8, !dbg !209, !tbaa !210
  call void @llvm.dbg.value(metadata i32 undef, metadata !113, metadata !DIExpression()) #3, !dbg !101
  %65 = load i32, i32* %3, align 4, !dbg !211, !tbaa !131
  call void @llvm.dbg.value(metadata i32 %65, metadata !107, metadata !DIExpression()) #3, !dbg !101
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %6) #3, !dbg !117
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !122, metadata !DIExpression()) #3, !dbg !117
  call void @llvm.dbg.value(metadata i32 undef, metadata !123, metadata !DIExpression()) #3, !dbg !117
  call void @llvm.dbg.value(metadata i32 %65, metadata !124, metadata !DIExpression()) #3, !dbg !117
  store i32 %65, i32* %2, align 4, !tbaa !131
  call void @llvm.dbg.value(metadata i64 %48, metadata !125, metadata !DIExpression()) #3, !dbg !117
  call void @llvm.dbg.value(metadata i64 %62, metadata !126, metadata !DIExpression()) #3, !dbg !117
  call void @llvm.dbg.value(metadata i32* %2, metadata !124, metadata !DIExpression(DW_OP_deref)) #3, !dbg !117
  %66 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @xdp_stats_map to i8*), i8* nonnull %6) #3, !dbg !212
  call void @llvm.dbg.value(metadata i8* %66, metadata !127, metadata !DIExpression()) #3, !dbg !117
  %67 = icmp eq i8* %66, null, !dbg !213
  br i1 %67, label %76, label %68, !dbg !215

68:                                               ; preds = %61
  call void @llvm.dbg.value(metadata i8* %66, metadata !127, metadata !DIExpression()) #3, !dbg !117
  %69 = bitcast i8* %66 to i64*, !dbg !216
  %70 = load i64, i64* %69, align 8, !dbg !218, !tbaa !219
  %71 = add i64 %70, 1, !dbg !218
  store i64 %71, i64* %69, align 8, !dbg !218, !tbaa !219
  %72 = getelementptr inbounds i8, i8* %66, i64 8, !dbg !220
  %73 = bitcast i8* %72 to i64*, !dbg !220
  store i64 %48, i64* %73, align 8, !dbg !221, !tbaa !210
  %74 = getelementptr inbounds i8, i8* %66, i64 16, !dbg !222
  %75 = bitcast i8* %74 to i64*, !dbg !222
  store i64 %62, i64* %75, align 8, !dbg !223, !tbaa !194
  br label %76, !dbg !224

76:                                               ; preds = %68, %61
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %6) #3, !dbg !225
  br label %77, !dbg !226

77:                                               ; preds = %8, %76
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %5), !dbg !226
  %78 = add nuw nsw i32 %9, 1, !dbg !227
  call void @llvm.dbg.value(metadata i32 %78, metadata !96, metadata !DIExpression()), !dbg !100
  %79 = icmp eq i32 %78, 5, !dbg !228
  br i1 %79, label %7, label %8, !dbg !129, !llvm.loop !229
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!78, !79, !80}
!llvm.ident = !{!81}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !27, line: 146, type: !74, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "mmpp_k_sources/c/kern.c", directory: "/home/shrestha/btp/designs/eBPF")
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
!14 = !{!15, !0, !25, !51, !65}
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
!26 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !27, line: 38, type: !28, isLocal: false, isDefinition: true)
!27 = !DIFile(filename: "./mmpp_k_sources/c/kern.c", directory: "/home/shrestha/btp/designs/eBPF")
!28 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !27, line: 33, size: 256, elements: !29)
!29 = !{!30, !36, !39, !46}
!30 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !28, file: !27, line: 34, baseType: !31, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!32 = !DICompositeType(tag: DW_TAG_array_type, baseType: !33, size: 64, elements: !34)
!33 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!34 = !{!35}
!35 = !DISubrange(count: 2)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !28, file: !27, line: 35, baseType: !37, size: 64, offset: 64)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !23, line: 27, baseType: !7)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !28, file: !27, line: 36, baseType: !40, size: 64, offset: 128)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!41 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_stats", file: !27, line: 21, size: 192, elements: !42)
!42 = !{!43, !44, !45}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !41, file: !27, line: 22, baseType: !22, size: 64)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "service_rate", scope: !41, file: !27, line: 23, baseType: !22, size: 64, offset: 64)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "queue_size", scope: !41, file: !27, line: 24, baseType: !22, size: 64, offset: 128)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !28, file: !27, line: 37, baseType: !47, size: 64, offset: 192)
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = !DICompositeType(tag: DW_TAG_array_type, baseType: !33, size: 160, elements: !49)
!49 = !{!50}
!50 = !DISubrange(count: 5)
!51 = !DIGlobalVariableExpression(var: !52, expr: !DIExpression())
!52 = distinct !DIGlobalVariable(name: "shaper_stats_map", scope: !2, file: !27, line: 45, type: !53, isLocal: false, isDefinition: true)
!53 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !27, line: 40, size: 256, elements: !54)
!54 = !{!55, !56, !57, !64}
!55 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !53, file: !27, line: 41, baseType: !31, size: 64)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !53, file: !27, line: 42, baseType: !37, size: 64, offset: 64)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !53, file: !27, line: 43, baseType: !58, size: 64, offset: 128)
!58 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !59, size: 64)
!59 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "shaper_stats", file: !27, line: 27, size: 192, elements: !60)
!60 = !{!61, !62, !63}
!61 = !DIDerivedType(tag: DW_TAG_member, name: "window_start", scope: !59, file: !27, line: 28, baseType: !22, size: 64)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "n_arrivals", scope: !59, file: !27, line: 29, baseType: !22, size: 64, offset: 64)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "n_average", scope: !59, file: !27, line: 30, baseType: !22, size: 64, offset: 128)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !53, file: !27, line: 44, baseType: !47, size: 64, offset: 192)
!65 = !DIGlobalVariableExpression(var: !66, expr: !DIExpression())
!66 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !17, line: 56, type: !67, isLocal: true, isDefinition: true)
!67 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !68)
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DISubroutineType(types: !70)
!70 = !{!71, !71, !72}
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !73, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!74 = !DICompositeType(tag: DW_TAG_array_type, baseType: !75, size: 32, elements: !76)
!75 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!76 = !{!77}
!77 = !DISubrange(count: 4)
!78 = !{i32 7, !"Dwarf Version", i32 4}
!79 = !{i32 2, !"Debug Info Version", i32 3}
!80 = !{i32 1, !"wchar_size", i32 4}
!81 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!82 = distinct !DISubprogram(name: "xdp_mmpp_shaper", scope: !27, file: !27, line: 136, type: !83, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !93)
!83 = !DISubroutineType(types: !84)
!84 = !{!33, !85}
!85 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !86, size: 64)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !87)
!87 = !{!88, !89, !90, !91, !92}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !86, file: !6, line: 3165, baseType: !38, size: 32)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !86, file: !6, line: 3166, baseType: !38, size: 32, offset: 32)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !86, file: !6, line: 3167, baseType: !38, size: 32, offset: 64)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !86, file: !6, line: 3169, baseType: !38, size: 32, offset: 96)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !86, file: !6, line: 3170, baseType: !38, size: 32, offset: 128)
!93 = !{!94, !95, !96}
!94 = !DILocalVariable(name: "ctx", arg: 1, scope: !82, file: !27, line: 136, type: !85)
!95 = !DILocalVariable(name: "now", scope: !82, file: !27, line: 137, type: !22)
!96 = !DILocalVariable(name: "src_index", scope: !97, file: !27, line: 139, type: !38)
!97 = distinct !DILexicalBlock(scope: !82, file: !27, line: 139, column: 3)
!98 = !DILocation(line: 0, scope: !82)
!99 = !DILocation(line: 137, column: 15, scope: !82)
!100 = !DILocation(line: 0, scope: !97)
!101 = !DILocation(line: 0, scope: !102, inlinedAt: !114)
!102 = distinct !DISubprogram(name: "handle_packet", scope: !27, file: !27, line: 95, type: !103, scopeLine: 96, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !105)
!103 = !DISubroutineType(types: !104)
!104 = !{null, !85, !38, !22}
!105 = !{!106, !107, !108, !109, !110, !111, !112, !113}
!106 = !DILocalVariable(name: "ctx", arg: 1, scope: !102, file: !27, line: 95, type: !85)
!107 = !DILocalVariable(name: "src_index", arg: 2, scope: !102, file: !27, line: 95, type: !38)
!108 = !DILocalVariable(name: "now", arg: 3, scope: !102, file: !27, line: 96, type: !22)
!109 = !DILocalVariable(name: "shaper_stats_ptr", scope: !102, file: !27, line: 97, type: !58)
!110 = !DILocalVariable(name: "xdp_stats_ptr", scope: !102, file: !27, line: 99, type: !40)
!111 = !DILocalVariable(name: "service_rate", scope: !102, file: !27, line: 108, type: !22)
!112 = !DILocalVariable(name: "queue_size", scope: !102, file: !27, line: 109, type: !22)
!113 = !DILocalVariable(name: "action", scope: !102, file: !27, line: 128, type: !38)
!114 = distinct !DILocation(line: 140, column: 5, scope: !115)
!115 = distinct !DILexicalBlock(scope: !116, file: !27, line: 139, column: 67)
!116 = distinct !DILexicalBlock(scope: !97, file: !27, line: 139, column: 3)
!117 = !DILocation(line: 0, scope: !118, inlinedAt: !128)
!118 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !27, file: !27, line: 48, type: !119, scopeLine: 49, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !121)
!119 = !DISubroutineType(types: !120)
!120 = !{null, !85, !38, !38, !22, !22}
!121 = !{!122, !123, !124, !125, !126, !127}
!122 = !DILocalVariable(name: "ctx", arg: 1, scope: !118, file: !27, line: 48, type: !85)
!123 = !DILocalVariable(name: "action", arg: 2, scope: !118, file: !27, line: 48, type: !38)
!124 = !DILocalVariable(name: "src_index", arg: 3, scope: !118, file: !27, line: 48, type: !38)
!125 = !DILocalVariable(name: "service_rate", arg: 4, scope: !118, file: !27, line: 49, type: !22)
!126 = !DILocalVariable(name: "queue_size", arg: 5, scope: !118, file: !27, line: 49, type: !22)
!127 = !DILocalVariable(name: "xdp_stats_ptr", scope: !118, file: !27, line: 50, type: !40)
!128 = distinct !DILocation(line: 132, column: 3, scope: !102, inlinedAt: !114)
!129 = !DILocation(line: 139, column: 3, scope: !97)
!130 = !DILocation(line: 143, column: 3, scope: !82)
!131 = !{!132, !132, i64 0}
!132 = !{!"int", !133, i64 0}
!133 = !{!"omnipotent char", !134, i64 0}
!134 = !{!"Simple C/C++ TBAA"}
!135 = !DILocation(line: 98, column: 7, scope: !102, inlinedAt: !114)
!136 = !DILocation(line: 100, column: 7, scope: !102, inlinedAt: !114)
!137 = !DILocation(line: 102, column: 8, scope: !138, inlinedAt: !114)
!138 = distinct !DILexicalBlock(scope: !102, file: !27, line: 102, column: 7)
!139 = !DILocation(line: 102, column: 22, scope: !138, inlinedAt: !114)
!140 = !DILocalVariable(name: "shaper_stats_ptr", arg: 1, scope: !141, file: !27, line: 78, type: !58)
!141 = distinct !DISubprogram(name: "update_shaper_stats", scope: !27, file: !27, line: 78, type: !142, scopeLine: 78, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !144)
!142 = !DISubroutineType(types: !143)
!143 = !{null, !58, !22}
!144 = !{!140, !145}
!145 = !DILocalVariable(name: "now", arg: 2, scope: !141, file: !27, line: 78, type: !22)
!146 = !DILocation(line: 0, scope: !141, inlinedAt: !147)
!147 = distinct !DILocation(line: 106, column: 3, scope: !102, inlinedAt: !114)
!148 = !DILocation(line: 79, column: 25, scope: !149, inlinedAt: !147)
!149 = distinct !DILexicalBlock(scope: !141, file: !27, line: 79, column: 7)
!150 = !{!151, !152, i64 16}
!151 = !{!"shaper_stats", !152, i64 0, !152, i64 8, !152, i64 16}
!152 = !{!"long long", !133, i64 0}
!153 = !DILocation(line: 79, column: 35, scope: !149, inlinedAt: !147)
!154 = !DILocation(line: 79, column: 7, scope: !141, inlinedAt: !147)
!155 = !DILocation(line: 80, column: 33, scope: !156, inlinedAt: !147)
!156 = distinct !DILexicalBlock(scope: !149, file: !27, line: 79, column: 50)
!157 = !DILocation(line: 81, column: 3, scope: !156, inlinedAt: !147)
!158 = !DILocation(line: 83, column: 31, scope: !159, inlinedAt: !147)
!159 = distinct !DILexicalBlock(scope: !141, file: !27, line: 83, column: 7)
!160 = !{!151, !152, i64 0}
!161 = !DILocation(line: 83, column: 11, scope: !159, inlinedAt: !147)
!162 = !DILocation(line: 83, column: 44, scope: !159, inlinedAt: !147)
!163 = !DILocation(line: 83, column: 7, scope: !141, inlinedAt: !147)
!164 = !DILocation(line: 85, column: 16, scope: !165, inlinedAt: !147)
!165 = distinct !DILexicalBlock(scope: !159, file: !27, line: 83, column: 60)
!166 = !DILocation(line: 86, column: 46, scope: !165, inlinedAt: !147)
!167 = !{!151, !152, i64 8}
!168 = !DILocation(line: 86, column: 26, scope: !165, inlinedAt: !147)
!169 = !DILocation(line: 85, column: 46, scope: !165, inlinedAt: !147)
!170 = !DILocation(line: 86, column: 58, scope: !165, inlinedAt: !147)
!171 = !DILocation(line: 84, column: 33, scope: !165, inlinedAt: !147)
!172 = !DILocation(line: 88, column: 36, scope: !165, inlinedAt: !147)
!173 = !DILocation(line: 92, column: 31, scope: !141, inlinedAt: !147)
!174 = !DILocalVariable(name: "shaper_stats_ptr", arg: 1, scope: !175, file: !27, line: 61, type: !58)
!175 = distinct !DISubprogram(name: "calculate_service_rate", scope: !27, file: !27, line: 61, type: !176, scopeLine: 61, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !178)
!176 = !DISubroutineType(types: !177)
!177 = !{!22, !58, !22}
!178 = !{!174, !179, !180, !181}
!179 = !DILocalVariable(name: "now", arg: 2, scope: !175, file: !27, line: 61, type: !22)
!180 = !DILocalVariable(name: "time_diff", scope: !175, file: !27, line: 62, type: !22)
!181 = !DILocalVariable(name: "service_rate", scope: !175, file: !27, line: 73, type: !22)
!182 = !DILocation(line: 0, scope: !175, inlinedAt: !183)
!183 = distinct !DILocation(line: 108, column: 24, scope: !102, inlinedAt: !114)
!184 = !DILocation(line: 68, column: 35, scope: !185, inlinedAt: !183)
!185 = distinct !DILexicalBlock(scope: !175, file: !27, line: 68, column: 7)
!186 = !DILocation(line: 68, column: 7, scope: !175, inlinedAt: !183)
!187 = !DILocation(line: 69, column: 33, scope: !188, inlinedAt: !183)
!188 = distinct !DILexicalBlock(scope: !185, file: !27, line: 68, column: 50)
!189 = !DILocation(line: 70, column: 3, scope: !188, inlinedAt: !183)
!190 = !DILocation(line: 64, column: 7, scope: !175, inlinedAt: !183)
!191 = !DILocation(line: 73, column: 53, scope: !175, inlinedAt: !183)
!192 = !DILocation(line: 73, column: 62, scope: !175, inlinedAt: !183)
!193 = !DILocation(line: 109, column: 37, scope: !102, inlinedAt: !114)
!194 = !{!195, !152, i64 16}
!195 = !{!"xdp_stats", !152, i64 0, !152, i64 8, !152, i64 16}
!196 = !DILocation(line: 111, column: 20, scope: !197, inlinedAt: !114)
!197 = distinct !DILexicalBlock(scope: !102, file: !27, line: 111, column: 7)
!198 = !DILocation(line: 111, column: 7, scope: !102, inlinedAt: !114)
!199 = !DILocation(line: 113, column: 20, scope: !200, inlinedAt: !114)
!200 = distinct !DILexicalBlock(scope: !201, file: !27, line: 113, column: 9)
!201 = distinct !DILexicalBlock(scope: !197, file: !27, line: 111, column: 52)
!202 = !DILocation(line: 113, column: 9, scope: !201, inlinedAt: !114)
!203 = !DILocation(line: 119, column: 20, scope: !204, inlinedAt: !114)
!204 = distinct !DILexicalBlock(scope: !205, file: !27, line: 119, column: 9)
!205 = distinct !DILexicalBlock(scope: !197, file: !27, line: 116, column: 10)
!206 = !DILocation(line: 119, column: 9, scope: !205, inlinedAt: !114)
!207 = !DILocation(line: 124, column: 29, scope: !102, inlinedAt: !114)
!208 = !DILocation(line: 125, column: 18, scope: !102, inlinedAt: !114)
!209 = !DILocation(line: 125, column: 31, scope: !102, inlinedAt: !114)
!210 = !{!195, !152, i64 8}
!211 = !DILocation(line: 132, column: 40, scope: !102, inlinedAt: !114)
!212 = !DILocation(line: 51, column: 7, scope: !118, inlinedAt: !128)
!213 = !DILocation(line: 53, column: 7, scope: !214, inlinedAt: !128)
!214 = distinct !DILexicalBlock(scope: !118, file: !27, line: 53, column: 7)
!215 = !DILocation(line: 53, column: 7, scope: !118, inlinedAt: !128)
!216 = !DILocation(line: 54, column: 20, scope: !217, inlinedAt: !128)
!217 = distinct !DILexicalBlock(scope: !214, file: !27, line: 53, column: 22)
!218 = !DILocation(line: 54, column: 30, scope: !217, inlinedAt: !128)
!219 = !{!195, !152, i64 0}
!220 = !DILocation(line: 55, column: 20, scope: !217, inlinedAt: !128)
!221 = !DILocation(line: 55, column: 33, scope: !217, inlinedAt: !128)
!222 = !DILocation(line: 56, column: 20, scope: !217, inlinedAt: !128)
!223 = !DILocation(line: 56, column: 31, scope: !217, inlinedAt: !128)
!224 = !DILocation(line: 57, column: 3, scope: !217, inlinedAt: !128)
!225 = !DILocation(line: 58, column: 1, scope: !118, inlinedAt: !128)
!226 = !DILocation(line: 133, column: 1, scope: !102, inlinedAt: !114)
!227 = !DILocation(line: 139, column: 63, scope: !116)
!228 = !DILocation(line: 139, column: 39, scope: !116)
!229 = distinct !{!229, !129, !230}
!230 = !DILocation(line: 141, column: 3, scope: !97)
