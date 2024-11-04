; ModuleID = 'mmpp_k_sources/c/kern.c'
source_filename = "mmpp_k_sources/c/kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, %struct.xdp_stats*, [5 x i32]* }
%struct.xdp_stats = type { i64, i64, i64 }
%struct.anon.0 = type { [2 x i32]*, i32*, %struct.shaper_stats*, [5 x i32]* }
%struct.shaper_stats = type { i64, i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !0
@xdp_stats_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !25
@shaper_stats_map = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !50
@llvm.used = appending global [4 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.0* @shaper_stats_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_mmpp_shaper to i8*), i8* bitcast (%struct.anon* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_mmpp_shaper(%struct.xdp_md* nocapture readnone %0) #0 section "xdp" !dbg !81 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !93, metadata !DIExpression()), !dbg !97
  %4 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !98
  call void @llvm.dbg.value(metadata i64 %4, metadata !94, metadata !DIExpression()), !dbg !97
  call void @llvm.dbg.value(metadata i32 0, metadata !95, metadata !DIExpression()), !dbg !99
  %5 = bitcast i32* %3 to i8*, !dbg !100
  %6 = bitcast i32* %2 to i8*, !dbg !116
  br label %8, !dbg !128

7:                                                ; preds = %77
  ret i32 2, !dbg !129

8:                                                ; preds = %77, %1
  %9 = phi i32 [ 0, %1 ], [ %78, %77 ]
  call void @llvm.dbg.value(metadata i32 %9, metadata !95, metadata !DIExpression()), !dbg !99
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %5), !dbg !100
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !105, metadata !DIExpression()) #3, !dbg !100
  call void @llvm.dbg.value(metadata i32 %9, metadata !106, metadata !DIExpression()) #3, !dbg !100
  store i32 %9, i32* %3, align 4, !tbaa !130
  call void @llvm.dbg.value(metadata i64 %4, metadata !107, metadata !DIExpression()) #3, !dbg !100
  call void @llvm.dbg.value(metadata i32* %3, metadata !106, metadata !DIExpression(DW_OP_deref)) #3, !dbg !100
  %10 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @shaper_stats_map to i8*), i8* nonnull %5) #3, !dbg !134
  call void @llvm.dbg.value(metadata i8* %10, metadata !108, metadata !DIExpression()) #3, !dbg !100
  %11 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @xdp_stats_map to i8*), i8* nonnull %5) #3, !dbg !135
  call void @llvm.dbg.value(metadata i8* %11, metadata !109, metadata !DIExpression()) #3, !dbg !100
  %12 = icmp ne i8* %11, null, !dbg !136
  %13 = icmp ne i8* %10, null
  %14 = and i1 %13, %12, !dbg !138
  br i1 %14, label %15, label %77, !dbg !138

15:                                               ; preds = %8
  call void @llvm.dbg.value(metadata i8* %10, metadata !139, metadata !DIExpression()) #3, !dbg !145
  call void @llvm.dbg.value(metadata i64 %4, metadata !144, metadata !DIExpression()) #3, !dbg !145
  %16 = getelementptr inbounds i8, i8* %10, i64 16, !dbg !147
  %17 = bitcast i8* %16 to i64*, !dbg !147
  %18 = load i64, i64* %17, align 8, !dbg !147, !tbaa !149
  %19 = icmp ult i64 %18, 10, !dbg !152
  br i1 %19, label %20, label %21, !dbg !153

20:                                               ; preds = %15
  store i64 10, i64* %17, align 8, !dbg !154, !tbaa !149
  br label %21, !dbg !156

21:                                               ; preds = %20, %15
  %22 = phi i64 [ 10, %20 ], [ %18, %15 ]
  %23 = bitcast i8* %10 to i64*, !dbg !157
  %24 = load i64, i64* %23, align 8, !dbg !157, !tbaa !159
  %25 = sub i64 %4, %24, !dbg !160
  %26 = icmp ugt i64 %25, 7999999999, !dbg !161
  br i1 %26, label %27, label %37, !dbg !162

27:                                               ; preds = %21
  %28 = mul i64 %22, 8000, !dbg !163
  %29 = getelementptr inbounds i8, i8* %10, i64 8, !dbg !165
  %30 = bitcast i8* %29 to i64*, !dbg !165
  %31 = load i64, i64* %30, align 8, !dbg !165, !tbaa !166
  %32 = mul i64 %31, 999992000, !dbg !167
  %33 = add i64 %32, %28, !dbg !168
  %34 = udiv i64 %33, 1000000000, !dbg !169
  store i64 %34, i64* %17, align 8, !dbg !170, !tbaa !149
  store i64 %4, i64* %23, align 8, !dbg !171, !tbaa !159
  store i64 1, i64* %30, align 8, !dbg !172, !tbaa !166
  call void @llvm.dbg.value(metadata i8* %10, metadata !173, metadata !DIExpression()) #3, !dbg !181
  call void @llvm.dbg.value(metadata i64 %4, metadata !178, metadata !DIExpression()) #3, !dbg !181
  call void @llvm.dbg.value(metadata i64 undef, metadata !179, metadata !DIExpression()) #3, !dbg !181
  %35 = icmp ult i64 %33, 10000000000, !dbg !183
  br i1 %35, label %36, label %44, !dbg !185

36:                                               ; preds = %27
  store i64 10, i64* %17, align 8, !dbg !186, !tbaa !149
  br label %44, !dbg !188

37:                                               ; preds = %21
  %38 = getelementptr inbounds i8, i8* %10, i64 8, !dbg !145
  %39 = bitcast i8* %38 to i64*, !dbg !145
  %40 = load i64, i64* %39, align 8, !dbg !172, !tbaa !166
  %41 = add i64 %40, 1, !dbg !162
  store i64 %41, i64* %39, align 8, !dbg !172, !tbaa !166
  call void @llvm.dbg.value(metadata i8* %10, metadata !173, metadata !DIExpression()) #3, !dbg !181
  call void @llvm.dbg.value(metadata i64 %4, metadata !178, metadata !DIExpression()) #3, !dbg !181
  call void @llvm.dbg.value(metadata i64 undef, metadata !179, metadata !DIExpression()) #3, !dbg !181
  %42 = icmp ugt i64 %25, 10000000, !dbg !189
  %43 = select i1 %42, i64 %25, i64 10000000, !dbg !189
  br label %44, !dbg !189

44:                                               ; preds = %37, %27, %36
  %45 = phi i64 [ %34, %27 ], [ 10, %36 ], [ %22, %37 ]
  %46 = phi i64 [ 10000000, %27 ], [ 10000000, %36 ], [ %43, %37 ]
  call void @llvm.dbg.value(metadata i64 %46, metadata !179, metadata !DIExpression()) #3, !dbg !181
  %47 = mul i64 %45, 1000000000, !dbg !190
  %48 = udiv i64 %47, %46, !dbg !191
  call void @llvm.dbg.value(metadata i64 %48, metadata !180, metadata !DIExpression()) #3, !dbg !181
  call void @llvm.dbg.value(metadata i64 %48, metadata !110, metadata !DIExpression()) #3, !dbg !100
  %49 = getelementptr inbounds i8, i8* %11, i64 16, !dbg !192
  %50 = bitcast i8* %49 to i64*, !dbg !192
  %51 = load i64, i64* %50, align 8, !dbg !192, !tbaa !193
  call void @llvm.dbg.value(metadata i64 %51, metadata !111, metadata !DIExpression()) #3, !dbg !100
  %52 = icmp ult i64 %48, %45, !dbg !195
  br i1 %52, label %57, label %53, !dbg !197

53:                                               ; preds = %44
  %54 = icmp eq i64 %51, 0, !dbg !198
  %55 = add i64 %51, -1
  %56 = select i1 %54, i64 0, i64 %55, !dbg !201
  br label %61, !dbg !201

57:                                               ; preds = %44
  %58 = icmp ult i64 %51, 300, !dbg !202
  %59 = zext i1 %58 to i64, !dbg !205
  %60 = add i64 %51, %59, !dbg !205
  br label %61, !dbg !205

61:                                               ; preds = %57, %53
  %62 = phi i64 [ %56, %53 ], [ %60, %57 ], !dbg !100
  call void @llvm.dbg.value(metadata i64 %62, metadata !111, metadata !DIExpression()) #3, !dbg !100
  store i64 %62, i64* %50, align 8, !dbg !206, !tbaa !193
  %63 = getelementptr inbounds i8, i8* %11, i64 8, !dbg !207
  %64 = bitcast i8* %63 to i64*, !dbg !207
  store i64 %48, i64* %64, align 8, !dbg !208, !tbaa !209
  call void @llvm.dbg.value(metadata i32 undef, metadata !112, metadata !DIExpression()) #3, !dbg !100
  %65 = load i32, i32* %3, align 4, !dbg !210, !tbaa !130
  call void @llvm.dbg.value(metadata i32 %65, metadata !106, metadata !DIExpression()) #3, !dbg !100
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %6) #3, !dbg !116
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !121, metadata !DIExpression()) #3, !dbg !116
  call void @llvm.dbg.value(metadata i32 undef, metadata !122, metadata !DIExpression()) #3, !dbg !116
  call void @llvm.dbg.value(metadata i32 %65, metadata !123, metadata !DIExpression()) #3, !dbg !116
  store i32 %65, i32* %2, align 4, !tbaa !130
  call void @llvm.dbg.value(metadata i64 %48, metadata !124, metadata !DIExpression()) #3, !dbg !116
  call void @llvm.dbg.value(metadata i64 %62, metadata !125, metadata !DIExpression()) #3, !dbg !116
  call void @llvm.dbg.value(metadata i32* %2, metadata !123, metadata !DIExpression(DW_OP_deref)) #3, !dbg !116
  %66 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @xdp_stats_map to i8*), i8* nonnull %6) #3, !dbg !211
  call void @llvm.dbg.value(metadata i8* %66, metadata !126, metadata !DIExpression()) #3, !dbg !116
  %67 = icmp eq i8* %66, null, !dbg !212
  br i1 %67, label %76, label %68, !dbg !214

68:                                               ; preds = %61
  call void @llvm.dbg.value(metadata i8* %66, metadata !126, metadata !DIExpression()) #3, !dbg !116
  %69 = bitcast i8* %66 to i64*, !dbg !215
  %70 = load i64, i64* %69, align 8, !dbg !217, !tbaa !218
  %71 = add i64 %70, 1, !dbg !217
  store i64 %71, i64* %69, align 8, !dbg !217, !tbaa !218
  %72 = getelementptr inbounds i8, i8* %66, i64 8, !dbg !219
  %73 = bitcast i8* %72 to i64*, !dbg !219
  store i64 %48, i64* %73, align 8, !dbg !220, !tbaa !209
  %74 = getelementptr inbounds i8, i8* %66, i64 16, !dbg !221
  %75 = bitcast i8* %74 to i64*, !dbg !221
  store i64 %62, i64* %75, align 8, !dbg !222, !tbaa !193
  br label %76, !dbg !223

76:                                               ; preds = %68, %61
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %6) #3, !dbg !224
  br label %77, !dbg !225

77:                                               ; preds = %8, %76
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %5), !dbg !225
  %78 = add nuw nsw i32 %9, 1, !dbg !226
  call void @llvm.dbg.value(metadata i32 %78, metadata !95, metadata !DIExpression()), !dbg !99
  %79 = icmp eq i32 %78, 5, !dbg !227
  br i1 %79, label %7, label %8, !dbg !128, !llvm.loop !228
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
!llvm.module.flags = !{!77, !78, !79}
!llvm.ident = !{!80}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 146, type: !73, isLocal: false, isDefinition: true)
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
!14 = !{!15, !0, !25, !50, !64}
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
!26 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 38, type: !27, isLocal: false, isDefinition: true)
!27 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 33, size: 256, elements: !28)
!28 = !{!29, !35, !38, !45}
!29 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !27, file: !3, line: 34, baseType: !30, size: 64)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!31 = !DICompositeType(tag: DW_TAG_array_type, baseType: !32, size: 64, elements: !33)
!32 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!33 = !{!34}
!34 = !DISubrange(count: 2)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !27, file: !3, line: 35, baseType: !36, size: 64, offset: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !23, line: 27, baseType: !7)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !27, file: !3, line: 36, baseType: !39, size: 64, offset: 128)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!40 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_stats", file: !3, line: 21, size: 192, elements: !41)
!41 = !{!42, !43, !44}
!42 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !40, file: !3, line: 22, baseType: !22, size: 64)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "service_rate", scope: !40, file: !3, line: 23, baseType: !22, size: 64, offset: 64)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "queue_size", scope: !40, file: !3, line: 24, baseType: !22, size: 64, offset: 128)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !27, file: !3, line: 37, baseType: !46, size: 64, offset: 192)
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64)
!47 = !DICompositeType(tag: DW_TAG_array_type, baseType: !32, size: 160, elements: !48)
!48 = !{!49}
!49 = !DISubrange(count: 5)
!50 = !DIGlobalVariableExpression(var: !51, expr: !DIExpression())
!51 = distinct !DIGlobalVariable(name: "shaper_stats_map", scope: !2, file: !3, line: 45, type: !52, isLocal: false, isDefinition: true)
!52 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 40, size: 256, elements: !53)
!53 = !{!54, !55, !56, !63}
!54 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !52, file: !3, line: 41, baseType: !30, size: 64)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !52, file: !3, line: 42, baseType: !36, size: 64, offset: 64)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !52, file: !3, line: 43, baseType: !57, size: 64, offset: 128)
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !58, size: 64)
!58 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "shaper_stats", file: !3, line: 27, size: 192, elements: !59)
!59 = !{!60, !61, !62}
!60 = !DIDerivedType(tag: DW_TAG_member, name: "window_start", scope: !58, file: !3, line: 28, baseType: !22, size: 64)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "n_arrivals", scope: !58, file: !3, line: 29, baseType: !22, size: 64, offset: 64)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "n_average", scope: !58, file: !3, line: 30, baseType: !22, size: 64, offset: 128)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !52, file: !3, line: 44, baseType: !46, size: 64, offset: 192)
!64 = !DIGlobalVariableExpression(var: !65, expr: !DIExpression())
!65 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !17, line: 56, type: !66, isLocal: true, isDefinition: true)
!66 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !67)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !68, size: 64)
!68 = !DISubroutineType(types: !69)
!69 = !{!70, !70, !71}
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!73 = !DICompositeType(tag: DW_TAG_array_type, baseType: !74, size: 32, elements: !75)
!74 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!75 = !{!76}
!76 = !DISubrange(count: 4)
!77 = !{i32 7, !"Dwarf Version", i32 4}
!78 = !{i32 2, !"Debug Info Version", i32 3}
!79 = !{i32 1, !"wchar_size", i32 4}
!80 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!81 = distinct !DISubprogram(name: "xdp_mmpp_shaper", scope: !3, file: !3, line: 136, type: !82, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !92)
!82 = !DISubroutineType(types: !83)
!83 = !{!32, !84}
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !86)
!86 = !{!87, !88, !89, !90, !91}
!87 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !85, file: !6, line: 3165, baseType: !37, size: 32)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !85, file: !6, line: 3166, baseType: !37, size: 32, offset: 32)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !85, file: !6, line: 3167, baseType: !37, size: 32, offset: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !85, file: !6, line: 3169, baseType: !37, size: 32, offset: 96)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !85, file: !6, line: 3170, baseType: !37, size: 32, offset: 128)
!92 = !{!93, !94, !95}
!93 = !DILocalVariable(name: "ctx", arg: 1, scope: !81, file: !3, line: 136, type: !84)
!94 = !DILocalVariable(name: "now", scope: !81, file: !3, line: 137, type: !22)
!95 = !DILocalVariable(name: "src_index", scope: !96, file: !3, line: 139, type: !37)
!96 = distinct !DILexicalBlock(scope: !81, file: !3, line: 139, column: 3)
!97 = !DILocation(line: 0, scope: !81)
!98 = !DILocation(line: 137, column: 15, scope: !81)
!99 = !DILocation(line: 0, scope: !96)
!100 = !DILocation(line: 0, scope: !101, inlinedAt: !113)
!101 = distinct !DISubprogram(name: "handle_packet", scope: !3, file: !3, line: 95, type: !102, scopeLine: 96, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !104)
!102 = !DISubroutineType(types: !103)
!103 = !{null, !84, !37, !22}
!104 = !{!105, !106, !107, !108, !109, !110, !111, !112}
!105 = !DILocalVariable(name: "ctx", arg: 1, scope: !101, file: !3, line: 95, type: !84)
!106 = !DILocalVariable(name: "src_index", arg: 2, scope: !101, file: !3, line: 95, type: !37)
!107 = !DILocalVariable(name: "now", arg: 3, scope: !101, file: !3, line: 96, type: !22)
!108 = !DILocalVariable(name: "shaper_stats_ptr", scope: !101, file: !3, line: 97, type: !57)
!109 = !DILocalVariable(name: "xdp_stats_ptr", scope: !101, file: !3, line: 99, type: !39)
!110 = !DILocalVariable(name: "service_rate", scope: !101, file: !3, line: 108, type: !22)
!111 = !DILocalVariable(name: "queue_size", scope: !101, file: !3, line: 109, type: !22)
!112 = !DILocalVariable(name: "action", scope: !101, file: !3, line: 128, type: !37)
!113 = distinct !DILocation(line: 140, column: 5, scope: !114)
!114 = distinct !DILexicalBlock(scope: !115, file: !3, line: 139, column: 67)
!115 = distinct !DILexicalBlock(scope: !96, file: !3, line: 139, column: 3)
!116 = !DILocation(line: 0, scope: !117, inlinedAt: !127)
!117 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 48, type: !118, scopeLine: 49, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !120)
!118 = !DISubroutineType(types: !119)
!119 = !{null, !84, !37, !37, !22, !22}
!120 = !{!121, !122, !123, !124, !125, !126}
!121 = !DILocalVariable(name: "ctx", arg: 1, scope: !117, file: !3, line: 48, type: !84)
!122 = !DILocalVariable(name: "action", arg: 2, scope: !117, file: !3, line: 48, type: !37)
!123 = !DILocalVariable(name: "src_index", arg: 3, scope: !117, file: !3, line: 48, type: !37)
!124 = !DILocalVariable(name: "service_rate", arg: 4, scope: !117, file: !3, line: 49, type: !22)
!125 = !DILocalVariable(name: "queue_size", arg: 5, scope: !117, file: !3, line: 49, type: !22)
!126 = !DILocalVariable(name: "xdp_stats_ptr", scope: !117, file: !3, line: 50, type: !39)
!127 = distinct !DILocation(line: 132, column: 3, scope: !101, inlinedAt: !113)
!128 = !DILocation(line: 139, column: 3, scope: !96)
!129 = !DILocation(line: 143, column: 3, scope: !81)
!130 = !{!131, !131, i64 0}
!131 = !{!"int", !132, i64 0}
!132 = !{!"omnipotent char", !133, i64 0}
!133 = !{!"Simple C/C++ TBAA"}
!134 = !DILocation(line: 98, column: 7, scope: !101, inlinedAt: !113)
!135 = !DILocation(line: 100, column: 7, scope: !101, inlinedAt: !113)
!136 = !DILocation(line: 102, column: 8, scope: !137, inlinedAt: !113)
!137 = distinct !DILexicalBlock(scope: !101, file: !3, line: 102, column: 7)
!138 = !DILocation(line: 102, column: 22, scope: !137, inlinedAt: !113)
!139 = !DILocalVariable(name: "shaper_stats_ptr", arg: 1, scope: !140, file: !3, line: 78, type: !57)
!140 = distinct !DISubprogram(name: "update_shaper_stats", scope: !3, file: !3, line: 78, type: !141, scopeLine: 78, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !143)
!141 = !DISubroutineType(types: !142)
!142 = !{null, !57, !22}
!143 = !{!139, !144}
!144 = !DILocalVariable(name: "now", arg: 2, scope: !140, file: !3, line: 78, type: !22)
!145 = !DILocation(line: 0, scope: !140, inlinedAt: !146)
!146 = distinct !DILocation(line: 106, column: 3, scope: !101, inlinedAt: !113)
!147 = !DILocation(line: 79, column: 25, scope: !148, inlinedAt: !146)
!148 = distinct !DILexicalBlock(scope: !140, file: !3, line: 79, column: 7)
!149 = !{!150, !151, i64 16}
!150 = !{!"shaper_stats", !151, i64 0, !151, i64 8, !151, i64 16}
!151 = !{!"long long", !132, i64 0}
!152 = !DILocation(line: 79, column: 35, scope: !148, inlinedAt: !146)
!153 = !DILocation(line: 79, column: 7, scope: !140, inlinedAt: !146)
!154 = !DILocation(line: 80, column: 33, scope: !155, inlinedAt: !146)
!155 = distinct !DILexicalBlock(scope: !148, file: !3, line: 79, column: 50)
!156 = !DILocation(line: 81, column: 3, scope: !155, inlinedAt: !146)
!157 = !DILocation(line: 83, column: 31, scope: !158, inlinedAt: !146)
!158 = distinct !DILexicalBlock(scope: !140, file: !3, line: 83, column: 7)
!159 = !{!150, !151, i64 0}
!160 = !DILocation(line: 83, column: 11, scope: !158, inlinedAt: !146)
!161 = !DILocation(line: 83, column: 44, scope: !158, inlinedAt: !146)
!162 = !DILocation(line: 83, column: 7, scope: !140, inlinedAt: !146)
!163 = !DILocation(line: 85, column: 16, scope: !164, inlinedAt: !146)
!164 = distinct !DILexicalBlock(scope: !158, file: !3, line: 83, column: 60)
!165 = !DILocation(line: 86, column: 46, scope: !164, inlinedAt: !146)
!166 = !{!150, !151, i64 8}
!167 = !DILocation(line: 86, column: 26, scope: !164, inlinedAt: !146)
!168 = !DILocation(line: 85, column: 46, scope: !164, inlinedAt: !146)
!169 = !DILocation(line: 86, column: 58, scope: !164, inlinedAt: !146)
!170 = !DILocation(line: 84, column: 33, scope: !164, inlinedAt: !146)
!171 = !DILocation(line: 88, column: 36, scope: !164, inlinedAt: !146)
!172 = !DILocation(line: 92, column: 31, scope: !140, inlinedAt: !146)
!173 = !DILocalVariable(name: "shaper_stats_ptr", arg: 1, scope: !174, file: !3, line: 61, type: !57)
!174 = distinct !DISubprogram(name: "calculate_service_rate", scope: !3, file: !3, line: 61, type: !175, scopeLine: 61, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !177)
!175 = !DISubroutineType(types: !176)
!176 = !{!22, !57, !22}
!177 = !{!173, !178, !179, !180}
!178 = !DILocalVariable(name: "now", arg: 2, scope: !174, file: !3, line: 61, type: !22)
!179 = !DILocalVariable(name: "time_diff", scope: !174, file: !3, line: 62, type: !22)
!180 = !DILocalVariable(name: "service_rate", scope: !174, file: !3, line: 73, type: !22)
!181 = !DILocation(line: 0, scope: !174, inlinedAt: !182)
!182 = distinct !DILocation(line: 108, column: 24, scope: !101, inlinedAt: !113)
!183 = !DILocation(line: 68, column: 35, scope: !184, inlinedAt: !182)
!184 = distinct !DILexicalBlock(scope: !174, file: !3, line: 68, column: 7)
!185 = !DILocation(line: 68, column: 7, scope: !174, inlinedAt: !182)
!186 = !DILocation(line: 69, column: 33, scope: !187, inlinedAt: !182)
!187 = distinct !DILexicalBlock(scope: !184, file: !3, line: 68, column: 50)
!188 = !DILocation(line: 70, column: 3, scope: !187, inlinedAt: !182)
!189 = !DILocation(line: 64, column: 7, scope: !174, inlinedAt: !182)
!190 = !DILocation(line: 73, column: 53, scope: !174, inlinedAt: !182)
!191 = !DILocation(line: 73, column: 62, scope: !174, inlinedAt: !182)
!192 = !DILocation(line: 109, column: 37, scope: !101, inlinedAt: !113)
!193 = !{!194, !151, i64 16}
!194 = !{!"xdp_stats", !151, i64 0, !151, i64 8, !151, i64 16}
!195 = !DILocation(line: 111, column: 20, scope: !196, inlinedAt: !113)
!196 = distinct !DILexicalBlock(scope: !101, file: !3, line: 111, column: 7)
!197 = !DILocation(line: 111, column: 7, scope: !101, inlinedAt: !113)
!198 = !DILocation(line: 113, column: 20, scope: !199, inlinedAt: !113)
!199 = distinct !DILexicalBlock(scope: !200, file: !3, line: 113, column: 9)
!200 = distinct !DILexicalBlock(scope: !196, file: !3, line: 111, column: 52)
!201 = !DILocation(line: 113, column: 9, scope: !200, inlinedAt: !113)
!202 = !DILocation(line: 119, column: 20, scope: !203, inlinedAt: !113)
!203 = distinct !DILexicalBlock(scope: !204, file: !3, line: 119, column: 9)
!204 = distinct !DILexicalBlock(scope: !196, file: !3, line: 116, column: 10)
!205 = !DILocation(line: 119, column: 9, scope: !204, inlinedAt: !113)
!206 = !DILocation(line: 124, column: 29, scope: !101, inlinedAt: !113)
!207 = !DILocation(line: 125, column: 18, scope: !101, inlinedAt: !113)
!208 = !DILocation(line: 125, column: 31, scope: !101, inlinedAt: !113)
!209 = !{!194, !151, i64 8}
!210 = !DILocation(line: 132, column: 40, scope: !101, inlinedAt: !113)
!211 = !DILocation(line: 51, column: 7, scope: !117, inlinedAt: !127)
!212 = !DILocation(line: 53, column: 7, scope: !213, inlinedAt: !127)
!213 = distinct !DILexicalBlock(scope: !117, file: !3, line: 53, column: 7)
!214 = !DILocation(line: 53, column: 7, scope: !117, inlinedAt: !127)
!215 = !DILocation(line: 54, column: 20, scope: !216, inlinedAt: !127)
!216 = distinct !DILexicalBlock(scope: !213, file: !3, line: 53, column: 22)
!217 = !DILocation(line: 54, column: 30, scope: !216, inlinedAt: !127)
!218 = !{!194, !151, i64 0}
!219 = !DILocation(line: 55, column: 20, scope: !216, inlinedAt: !127)
!220 = !DILocation(line: 55, column: 33, scope: !216, inlinedAt: !127)
!221 = !DILocation(line: 56, column: 20, scope: !216, inlinedAt: !127)
!222 = !DILocation(line: 56, column: 31, scope: !216, inlinedAt: !127)
!223 = !DILocation(line: 57, column: 3, scope: !216, inlinedAt: !127)
!224 = !DILocation(line: 58, column: 1, scope: !117, inlinedAt: !127)
!225 = !DILocation(line: 133, column: 1, scope: !101, inlinedAt: !113)
!226 = !DILocation(line: 139, column: 63, scope: !115)
!227 = !DILocation(line: 139, column: 39, scope: !115)
!228 = distinct !{!228, !128, !229}
!229 = !DILocation(line: 141, column: 3, scope: !96)
