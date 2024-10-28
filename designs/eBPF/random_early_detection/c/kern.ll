; ModuleID = 'random_early_detection/c/kern.c'
source_filename = "random_early_detection/c/kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.0 = type { [1 x i32]*, [6 x i8]*, [6 x i8]*, [1 x i32]* }
%struct.anon.1 = type { [14 x i32]*, i32*, i32*, [256 x i32]* }
%struct.anon.2 = type { [2 x i32]*, i32*, %struct.datarec*, [5 x i32]* }
%struct.datarec = type { i64, i64 }
%struct.anon.3 = type { [2 x i32]*, i32*, %struct.telrec*, [5 x i32]* }
%struct.telrec = type { i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@queue_avg_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@redirect_params = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !113
@tx_port = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !97
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !55
@xdp_stats_map = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !61
@telemetry_stats_map = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !84
@llvm.used = appending global [7 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* bitcast (%struct.anon.0* @redirect_params to i8*), i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* bitcast (%struct.anon.1* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_redirect_map_func to i8*), i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_redirect_map_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_redirect_map" !dbg !141 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !153, metadata !DIExpression()), !dbg !182
  %5 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !183
  call void @llvm.dbg.value(metadata i64 %5, metadata !154, metadata !DIExpression()), !dbg !182
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !184
  %7 = load i32, i32* %6, align 4, !dbg !184, !tbaa !185
  %8 = zext i32 %7 to i64, !dbg !190
  %9 = inttoptr i64 %8 to i8*, !dbg !191
  call void @llvm.dbg.value(metadata i8* %9, metadata !155, metadata !DIExpression()), !dbg !182
  %10 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !192
  %11 = load i32, i32* %10, align 4, !dbg !192, !tbaa !193
  %12 = zext i32 %11 to i64, !dbg !194
  %13 = inttoptr i64 %12 to i8*, !dbg !195
  call void @llvm.dbg.value(metadata i8* %13, metadata !156, metadata !DIExpression()), !dbg !182
  call void @llvm.dbg.value(metadata i32 2, metadata !169, metadata !DIExpression()), !dbg !182
  call void @llvm.dbg.value(metadata i64 50, metadata !170, metadata !DIExpression()), !dbg !182
  %14 = bitcast i32* %3 to i8*, !dbg !196
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %14) #3, !dbg !196
  call void @llvm.dbg.value(metadata i32 0, metadata !171, metadata !DIExpression()), !dbg !182
  store i32 0, i32* %3, align 4, !dbg !197, !tbaa !198
  call void @llvm.dbg.value(metadata i32* %3, metadata !171, metadata !DIExpression(DW_OP_deref)), !dbg !182
  %15 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %14) #3, !dbg !199
  call void @llvm.dbg.value(metadata i8* %15, metadata !172, metadata !DIExpression()), !dbg !182
  %16 = icmp eq i8* %15, null, !dbg !200
  br i1 %16, label %49, label %17, !dbg !202

17:                                               ; preds = %1
  %18 = bitcast i8* %15 to i64*, !dbg !199
  call void @llvm.dbg.value(metadata i64* %18, metadata !172, metadata !DIExpression()), !dbg !182
  %19 = load i64, i64* %18, align 8, !dbg !203, !tbaa !204
  call void @llvm.dbg.value(metadata i64 %19, metadata !206, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata i64 50, metadata !211, metadata !DIExpression()), !dbg !214
  %20 = mul i64 %19, 998000, !dbg !216
  call void @llvm.dbg.value(metadata i64 %20, metadata !212, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata i64 100000, metadata !213, metadata !DIExpression()), !dbg !214
  %21 = add i64 %20, 100000, !dbg !217
  %22 = udiv i64 %21, 1000000, !dbg !218
  call void @llvm.dbg.value(metadata i64 %22, metadata !173, metadata !DIExpression()), !dbg !182
  store i64 %22, i64* %4, align 8, !dbg !219, !tbaa !204
  %23 = bitcast i64* %4 to i8*, !dbg !220
  call void @llvm.dbg.value(metadata i32* %3, metadata !171, metadata !DIExpression(DW_OP_deref)), !dbg !182
  call void @llvm.dbg.value(metadata i64* %4, metadata !173, metadata !DIExpression(DW_OP_deref)), !dbg !182
  %24 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %14, i8* nonnull %23, i64 0) #3, !dbg !221
  %25 = load i64, i64* %4, align 8, !dbg !222, !tbaa !204
  call void @llvm.dbg.value(metadata i64 %25, metadata !173, metadata !DIExpression()), !dbg !182
  %26 = icmp ugt i64 %25, 4999, !dbg !223
  br i1 %26, label %49, label %27, !dbg !224

27:                                               ; preds = %17
  %28 = icmp ult i64 %25, 1001, !dbg !225
  br i1 %28, label %37, label %29, !dbg !226

29:                                               ; preds = %27
  %30 = trunc i64 %25 to i32, !dbg !227
  %31 = mul nuw nsw i32 %30, 100, !dbg !227
  %32 = add nsw i32 %31, -100000, !dbg !227
  %33 = udiv i32 %32, 4000, !dbg !227
  call void @llvm.dbg.value(metadata i32 %33, metadata !174, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !228
  %34 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !229
  %35 = urem i32 %34, 100, !dbg !231
  %36 = icmp ugt i32 %33, %35, !dbg !232
  call void @llvm.dbg.value(metadata i32 undef, metadata !169, metadata !DIExpression()), !dbg !182
  br i1 %36, label %49, label %37

37:                                               ; preds = %29, %27
  call void @llvm.dbg.value(metadata i32 2, metadata !169, metadata !DIExpression()), !dbg !182
  %38 = getelementptr i8, i8* %13, i64 14, !dbg !233
  %39 = icmp ugt i8* %38, %9, !dbg !235
  br i1 %39, label %88, label %40, !dbg !236

40:                                               ; preds = %37
  %41 = inttoptr i64 %12 to %struct.ethhdr*, !dbg !237
  call void @llvm.dbg.value(metadata %struct.ethhdr* %41, metadata !157, metadata !DIExpression()), !dbg !182
  %42 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %41, i64 0, i32 1, i64 0, !dbg !238
  %43 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @redirect_params to i8*), i8* nonnull %42) #3, !dbg !239
  call void @llvm.dbg.value(metadata i8* %43, metadata !178, metadata !DIExpression()), !dbg !182
  %44 = icmp eq i8* %43, null, !dbg !240
  br i1 %44, label %49, label %45, !dbg !242

45:                                               ; preds = %40
  %46 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %41, i64 0, i32 0, i64 0, !dbg !243
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %46, i8* nonnull align 1 dereferenceable(6) %43, i64 6, i1 false), !dbg !243
  call void @llvm.dbg.value(metadata i32* %3, metadata !171, metadata !DIExpression(DW_OP_deref)), !dbg !182
  %47 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i8* nonnull %14) #3, !dbg !244
  call void @llvm.dbg.value(metadata i8* %47, metadata !180, metadata !DIExpression()), !dbg !182
  %48 = icmp eq i8* %47, null, !dbg !245
  br i1 %48, label %49, label %52, !dbg !247

49:                                               ; preds = %45, %40, %29, %1, %17
  %50 = phi i32 [ 1, %17 ], [ 1, %1 ], [ 1, %29 ], [ 2, %40 ], [ 2, %45 ]
  call void @llvm.dbg.value(metadata i32 %57, metadata !169, metadata !DIExpression()), !dbg !182
  call void @llvm.dbg.label(metadata !181), !dbg !248
  %51 = bitcast i32* %2 to i8*, !dbg !249
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %51), !dbg !249
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !254, metadata !DIExpression()) #3, !dbg !249
  call void @llvm.dbg.value(metadata i32 %57, metadata !255, metadata !DIExpression()) #3, !dbg !249
  store i32 %50, i32* %2, align 4, !tbaa !198
  call void @llvm.dbg.value(metadata i64 %5, metadata !256, metadata !DIExpression()) #3, !dbg !249
  br label %60, !dbg !260

52:                                               ; preds = %45
  %53 = bitcast i8* %47 to i32*, !dbg !244
  call void @llvm.dbg.value(metadata i32* %53, metadata !180, metadata !DIExpression()), !dbg !182
  %54 = load i32, i32* %53, align 4, !dbg !261, !tbaa !198
  %55 = zext i32 %54 to i64, !dbg !261
  %56 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i64 %55, i64 0) #3, !dbg !262
  %57 = trunc i64 %56 to i32, !dbg !262
  call void @llvm.dbg.value(metadata i32 %57, metadata !169, metadata !DIExpression()), !dbg !182
  call void @llvm.dbg.label(metadata !181), !dbg !248
  %58 = bitcast i32* %2 to i8*, !dbg !249
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %58), !dbg !249
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !254, metadata !DIExpression()) #3, !dbg !249
  call void @llvm.dbg.value(metadata i32 %57, metadata !255, metadata !DIExpression()) #3, !dbg !249
  store i32 %57, i32* %2, align 4, !tbaa !198
  call void @llvm.dbg.value(metadata i64 %5, metadata !256, metadata !DIExpression()) #3, !dbg !249
  %59 = icmp ugt i32 %57, 4, !dbg !263
  br i1 %59, label %85, label %60, !dbg !260

60:                                               ; preds = %49, %52
  %61 = phi i8* [ %51, %49 ], [ %58, %52 ]
  call void @llvm.dbg.value(metadata i32* %2, metadata !255, metadata !DIExpression(DW_OP_deref)) #3, !dbg !249
  %62 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*), i8* nonnull %61) #3, !dbg !265
  call void @llvm.dbg.value(metadata i8* %62, metadata !257, metadata !DIExpression()) #3, !dbg !249
  %63 = icmp eq i8* %62, null, !dbg !266
  br i1 %63, label %85, label %64, !dbg !268

64:                                               ; preds = %60
  call void @llvm.dbg.value(metadata i8* %62, metadata !257, metadata !DIExpression()) #3, !dbg !249
  %65 = bitcast i8* %62 to i64*, !dbg !269
  %66 = load i64, i64* %65, align 8, !dbg !270, !tbaa !271
  %67 = add i64 %66, 1, !dbg !270
  store i64 %67, i64* %65, align 8, !dbg !270, !tbaa !271
  %68 = load i32, i32* %6, align 4, !dbg !273, !tbaa !185
  %69 = load i32, i32* %10, align 4, !dbg !274, !tbaa !193
  %70 = sub i32 %68, %69, !dbg !275
  %71 = zext i32 %70 to i64, !dbg !276
  %72 = getelementptr inbounds i8, i8* %62, i64 8, !dbg !277
  %73 = bitcast i8* %72 to i64*, !dbg !277
  %74 = load i64, i64* %73, align 8, !dbg !278, !tbaa !279
  %75 = add i64 %74, %71, !dbg !278
  store i64 %75, i64* %73, align 8, !dbg !278, !tbaa !279
  call void @llvm.dbg.value(metadata i32* %2, metadata !255, metadata !DIExpression(DW_OP_deref)) #3, !dbg !249
  %76 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* nonnull %61) #3, !dbg !280
  call void @llvm.dbg.value(metadata i8* %76, metadata !258, metadata !DIExpression()) #3, !dbg !249
  %77 = icmp eq i8* %76, null, !dbg !281
  br i1 %77, label %85, label %78, !dbg !283

78:                                               ; preds = %64
  call void @llvm.dbg.value(metadata i8* %76, metadata !258, metadata !DIExpression()) #3, !dbg !249
  %79 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !284
  %80 = bitcast i8* %76 to i64*, !dbg !285
  store i64 %79, i64* %80, align 8, !dbg !286, !tbaa !287
  %81 = sub i64 %79, %5, !dbg !289
  %82 = getelementptr inbounds i8, i8* %76, i64 8, !dbg !290
  %83 = bitcast i8* %82 to i64*, !dbg !290
  store i64 %81, i64* %83, align 8, !dbg !291, !tbaa !292
  %84 = load i32, i32* %2, align 4, !dbg !293, !tbaa !198
  call void @llvm.dbg.value(metadata i32 %84, metadata !255, metadata !DIExpression()) #3, !dbg !249
  br label %85, !dbg !294

85:                                               ; preds = %52, %60, %64, %78
  %86 = phi i8* [ %58, %52 ], [ %61, %60 ], [ %61, %78 ], [ %61, %64 ]
  %87 = phi i32 [ 0, %52 ], [ 0, %60 ], [ %84, %78 ], [ 0, %64 ], !dbg !249
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %86), !dbg !295
  br label %88, !dbg !296

88:                                               ; preds = %37, %85
  %89 = phi i32 [ %87, %85 ], [ 1, %37 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %14) #3, !dbg !297
  ret i32 %89, !dbg !297
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!137, !138, !139}
!llvm.ident = !{!140}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "queue_avg_map", scope: !2, file: !3, line: 65, type: !130, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !17, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "random_early_detection/c/kern.c", directory: "/home/shrestha/btp/designs/eBPF")
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
!14 = !{!15, !16}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!16 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!17 = !{!18, !28, !36, !42, !49, !55, !61, !84, !97, !113, !0}
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !20, line: 114, type: !21, isLocal: true, isDefinition: true)
!20 = !DIFile(filename: "/usr/local/include/bpf/bpf_helper_defs.h", directory: "")
!21 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !22)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DISubroutineType(types: !24)
!24 = !{!25}
!25 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !26, line: 31, baseType: !27)
!26 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!27 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!28 = !DIGlobalVariableExpression(var: !29, expr: !DIExpression())
!29 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !20, line: 56, type: !30, isLocal: true, isDefinition: true)
!30 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !31)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!32 = !DISubroutineType(types: !33)
!33 = !{!15, !15, !34}
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!35 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!36 = !DIGlobalVariableExpression(var: !37, expr: !DIExpression())
!37 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !20, line: 78, type: !38, isLocal: true, isDefinition: true)
!38 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !39)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!40 = !DISubroutineType(types: !41)
!41 = !{!16, !15, !34, !34, !25}
!42 = !DIGlobalVariableExpression(var: !43, expr: !DIExpression())
!43 = distinct !DIGlobalVariable(name: "bpf_get_prandom_u32", scope: !2, file: !20, line: 193, type: !44, isLocal: true, isDefinition: true)
!44 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !45)
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !46, size: 64)
!46 = !DISubroutineType(types: !47)
!47 = !{!48}
!48 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !26, line: 27, baseType: !7)
!49 = !DIGlobalVariableExpression(var: !50, expr: !DIExpression())
!50 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !20, line: 1325, type: !51, isLocal: true, isDefinition: true)
!51 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !52)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DISubroutineType(types: !54)
!54 = !{!16, !15, !25, !25}
!55 = !DIGlobalVariableExpression(var: !56, expr: !DIExpression())
!56 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 163, type: !57, isLocal: false, isDefinition: true)
!57 = !DICompositeType(tag: DW_TAG_array_type, baseType: !58, size: 32, elements: !59)
!58 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!59 = !{!60}
!60 = !DISubrange(count: 4)
!61 = !DIGlobalVariableExpression(var: !62, expr: !DIExpression())
!62 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 37, type: !63, isLocal: false, isDefinition: true)
!63 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 32, size: 256, elements: !64)
!64 = !{!65, !71, !73, !79}
!65 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !63, file: !3, line: 33, baseType: !66, size: 64)
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!67 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 64, elements: !69)
!68 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!69 = !{!70}
!70 = !DISubrange(count: 2)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !63, file: !3, line: 34, baseType: !72, size: 64, offset: 64)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !63, file: !3, line: 35, baseType: !74, size: 64, offset: 128)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !3, line: 10, size: 128, elements: !76)
!76 = !{!77, !78}
!77 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !75, file: !3, line: 11, baseType: !25, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !75, file: !3, line: 12, baseType: !25, size: 64, offset: 64)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !63, file: !3, line: 36, baseType: !80, size: 64, offset: 192)
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 160, elements: !82)
!82 = !{!83}
!83 = !DISubrange(count: 5)
!84 = !DIGlobalVariableExpression(var: !85, expr: !DIExpression())
!85 = distinct !DIGlobalVariable(name: "telemetry_stats_map", scope: !2, file: !3, line: 44, type: !86, isLocal: false, isDefinition: true)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 39, size: 256, elements: !87)
!87 = !{!88, !89, !90, !96}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !86, file: !3, line: 40, baseType: !66, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !86, file: !3, line: 41, baseType: !72, size: 64, offset: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !86, file: !3, line: 42, baseType: !91, size: 64, offset: 128)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!92 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "telrec", file: !3, line: 15, size: 128, elements: !93)
!93 = !{!94, !95}
!94 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !92, file: !3, line: 16, baseType: !25, size: 64)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time", scope: !92, file: !3, line: 17, baseType: !25, size: 64, offset: 64)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !86, file: !3, line: 43, baseType: !80, size: 64, offset: 192)
!97 = !DIGlobalVariableExpression(var: !98, expr: !DIExpression())
!98 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !3, line: 51, type: !99, isLocal: false, isDefinition: true)
!99 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 46, size: 256, elements: !100)
!100 = !{!101, !106, !107, !108}
!101 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !99, file: !3, line: 47, baseType: !102, size: 64)
!102 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !103, size: 64)
!103 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 448, elements: !104)
!104 = !{!105}
!105 = !DISubrange(count: 14)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !99, file: !3, line: 48, baseType: !72, size: 64, offset: 64)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !99, file: !3, line: 49, baseType: !72, size: 64, offset: 128)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !99, file: !3, line: 50, baseType: !109, size: 64, offset: 192)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !110, size: 64)
!110 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 8192, elements: !111)
!111 = !{!112}
!112 = !DISubrange(count: 256)
!113 = !DIGlobalVariableExpression(var: !114, expr: !DIExpression())
!114 = distinct !DIGlobalVariable(name: "redirect_params", scope: !2, file: !3, line: 58, type: !115, isLocal: false, isDefinition: true)
!115 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 53, size: 256, elements: !116)
!116 = !{!117, !122, !128, !129}
!117 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !115, file: !3, line: 54, baseType: !118, size: 64)
!118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !119, size: 64)
!119 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 32, elements: !120)
!120 = !{!121}
!121 = !DISubrange(count: 1)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !115, file: !3, line: 55, baseType: !123, size: 64, offset: 64)
!123 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !124, size: 64)
!124 = !DICompositeType(tag: DW_TAG_array_type, baseType: !125, size: 48, elements: !126)
!125 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!126 = !{!127}
!127 = !DISubrange(count: 6)
!128 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !115, file: !3, line: 56, baseType: !123, size: 64, offset: 128)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !115, file: !3, line: 57, baseType: !118, size: 64, offset: 192)
!130 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 60, size: 256, elements: !131)
!131 = !{!132, !133, !134, !136}
!132 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !130, file: !3, line: 61, baseType: !66, size: 64)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !130, file: !3, line: 62, baseType: !72, size: 64, offset: 64)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !130, file: !3, line: 63, baseType: !135, size: 64, offset: 128)
!135 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !130, file: !3, line: 64, baseType: !118, size: 64, offset: 192)
!137 = !{i32 7, !"Dwarf Version", i32 4}
!138 = !{i32 2, !"Debug Info Version", i32 3}
!139 = !{i32 1, !"wchar_size", i32 4}
!140 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!141 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !3, file: !3, line: 103, type: !142, scopeLine: 103, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !152)
!142 = !DISubroutineType(types: !143)
!143 = !{!68, !144}
!144 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !145, size: 64)
!145 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !146)
!146 = !{!147, !148, !149, !150, !151}
!147 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !145, file: !6, line: 3165, baseType: !48, size: 32)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !145, file: !6, line: 3166, baseType: !48, size: 32, offset: 32)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !145, file: !6, line: 3167, baseType: !48, size: 32, offset: 64)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !145, file: !6, line: 3169, baseType: !48, size: 32, offset: 96)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !145, file: !6, line: 3170, baseType: !48, size: 32, offset: 128)
!152 = !{!153, !154, !155, !156, !157, !169, !170, !171, !172, !173, !174, !178, !180, !181}
!153 = !DILocalVariable(name: "ctx", arg: 1, scope: !141, file: !3, line: 103, type: !144)
!154 = !DILocalVariable(name: "start", scope: !141, file: !3, line: 104, type: !25)
!155 = !DILocalVariable(name: "data_end", scope: !141, file: !3, line: 106, type: !15)
!156 = !DILocalVariable(name: "data", scope: !141, file: !3, line: 107, type: !15)
!157 = !DILocalVariable(name: "eth", scope: !141, file: !3, line: 109, type: !158)
!158 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !159, size: 64)
!159 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !160, line: 163, size: 112, elements: !161)
!160 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!161 = !{!162, !163, !164}
!162 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !159, file: !160, line: 164, baseType: !124, size: 48)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !159, file: !160, line: 165, baseType: !124, size: 48, offset: 48)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !159, file: !160, line: 166, baseType: !165, size: 16, offset: 96)
!165 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !166, line: 25, baseType: !167)
!166 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!167 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !26, line: 24, baseType: !168)
!168 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!169 = !DILocalVariable(name: "action", scope: !141, file: !3, line: 110, type: !48)
!170 = !DILocalVariable(name: "queue_len", scope: !141, file: !3, line: 111, type: !25)
!171 = !DILocalVariable(name: "key", scope: !141, file: !3, line: 112, type: !48)
!172 = !DILocalVariable(name: "prev_avg", scope: !141, file: !3, line: 114, type: !135)
!173 = !DILocalVariable(name: "new_avg", scope: !141, file: !3, line: 120, type: !25)
!174 = !DILocalVariable(name: "drop_prob", scope: !175, file: !3, line: 130, type: !25)
!175 = distinct !DILexicalBlock(scope: !176, file: !3, line: 128, column: 10)
!176 = distinct !DILexicalBlock(scope: !177, file: !3, line: 126, column: 14)
!177 = distinct !DILexicalBlock(scope: !141, file: !3, line: 123, column: 7)
!178 = !DILocalVariable(name: "dst", scope: !141, file: !3, line: 146, type: !179)
!179 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 64)
!180 = !DILocalVariable(name: "iface_index", scope: !141, file: !3, line: 153, type: !72)
!181 = !DILabel(scope: !141, name: "out", file: !3, line: 159)
!182 = !DILocation(line: 0, scope: !141)
!183 = !DILocation(line: 104, column: 17, scope: !141)
!184 = !DILocation(line: 106, column: 39, scope: !141)
!185 = !{!186, !187, i64 4}
!186 = !{!"xdp_md", !187, i64 0, !187, i64 4, !187, i64 8, !187, i64 12, !187, i64 16}
!187 = !{!"int", !188, i64 0}
!188 = !{!"omnipotent char", !189, i64 0}
!189 = !{!"Simple C/C++ TBAA"}
!190 = !DILocation(line: 106, column: 28, scope: !141)
!191 = !DILocation(line: 106, column: 20, scope: !141)
!192 = !DILocation(line: 107, column: 35, scope: !141)
!193 = !{!186, !187, i64 0}
!194 = !DILocation(line: 107, column: 24, scope: !141)
!195 = !DILocation(line: 107, column: 16, scope: !141)
!196 = !DILocation(line: 112, column: 3, scope: !141)
!197 = !DILocation(line: 112, column: 9, scope: !141)
!198 = !{!187, !187, i64 0}
!199 = !DILocation(line: 114, column: 21, scope: !141)
!200 = !DILocation(line: 115, column: 8, scope: !201)
!201 = distinct !DILexicalBlock(scope: !141, file: !3, line: 115, column: 7)
!202 = !DILocation(line: 115, column: 7, scope: !141)
!203 = !DILocation(line: 120, column: 43, scope: !141)
!204 = !{!205, !205, i64 0}
!205 = !{!"long long", !188, i64 0}
!206 = !DILocalVariable(name: "prev_avg", arg: 1, scope: !207, file: !3, line: 69, type: !25)
!207 = distinct !DISubprogram(name: "calculate_avg_queue_len", scope: !3, file: !3, line: 69, type: !208, scopeLine: 70, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !210)
!208 = !DISubroutineType(types: !209)
!209 = !{!25, !25, !25}
!210 = !{!206, !211, !212, !213}
!211 = !DILocalVariable(name: "curr_queue_len", arg: 2, scope: !207, file: !3, line: 70, type: !25)
!212 = !DILocalVariable(name: "weighted_prev_avg", scope: !207, file: !3, line: 73, type: !25)
!213 = !DILocalVariable(name: "weighted_curr_len", scope: !207, file: !3, line: 74, type: !25)
!214 = !DILocation(line: 0, scope: !207, inlinedAt: !215)
!215 = distinct !DILocation(line: 120, column: 19, scope: !141)
!216 = !DILocation(line: 73, column: 55, scope: !207, inlinedAt: !215)
!217 = !DILocation(line: 75, column: 29, scope: !207, inlinedAt: !215)
!218 = !DILocation(line: 75, column: 50, scope: !207, inlinedAt: !215)
!219 = !DILocation(line: 120, column: 9, scope: !141)
!220 = !DILocation(line: 121, column: 45, scope: !141)
!221 = !DILocation(line: 121, column: 3, scope: !141)
!222 = !DILocation(line: 123, column: 7, scope: !177)
!223 = !DILocation(line: 123, column: 15, scope: !177)
!224 = !DILocation(line: 123, column: 7, scope: !141)
!225 = !DILocation(line: 126, column: 22, scope: !176)
!226 = !DILocation(line: 126, column: 14, scope: !177)
!227 = !DILocation(line: 130, column: 66, scope: !175)
!228 = !DILocation(line: 0, scope: !175)
!229 = !DILocation(line: 134, column: 9, scope: !230)
!230 = distinct !DILexicalBlock(scope: !175, file: !3, line: 134, column: 9)
!231 = !DILocation(line: 134, column: 31, scope: !230)
!232 = !DILocation(line: 134, column: 37, scope: !230)
!233 = !DILocation(line: 141, column: 12, scope: !234)
!234 = distinct !DILexicalBlock(scope: !141, file: !3, line: 141, column: 7)
!235 = !DILocation(line: 141, column: 36, scope: !234)
!236 = !DILocation(line: 141, column: 7, scope: !141)
!237 = !DILocation(line: 144, column: 9, scope: !141)
!238 = !DILocation(line: 146, column: 62, scope: !141)
!239 = !DILocation(line: 146, column: 24, scope: !141)
!240 = !DILocation(line: 147, column: 8, scope: !241)
!241 = distinct !DILexicalBlock(scope: !141, file: !3, line: 147, column: 7)
!242 = !DILocation(line: 147, column: 7, scope: !141)
!243 = !DILocation(line: 151, column: 3, scope: !141)
!244 = !DILocation(line: 153, column: 24, scope: !141)
!245 = !DILocation(line: 154, column: 8, scope: !246)
!246 = distinct !DILexicalBlock(scope: !141, file: !3, line: 154, column: 7)
!247 = !DILocation(line: 154, column: 7, scope: !141)
!248 = !DILocation(line: 159, column: 1, scope: !141)
!249 = !DILocation(line: 0, scope: !250, inlinedAt: !259)
!250 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 78, type: !251, scopeLine: 80, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !253)
!251 = !DISubroutineType(types: !252)
!252 = !{!48, !144, !48, !25}
!253 = !{!254, !255, !256, !257, !258}
!254 = !DILocalVariable(name: "ctx", arg: 1, scope: !250, file: !3, line: 78, type: !144)
!255 = !DILocalVariable(name: "action", arg: 2, scope: !250, file: !3, line: 79, type: !48)
!256 = !DILocalVariable(name: "start", arg: 3, scope: !250, file: !3, line: 80, type: !25)
!257 = !DILocalVariable(name: "rec", scope: !250, file: !3, line: 84, type: !74)
!258 = !DILocalVariable(name: "telemetry", scope: !250, file: !3, line: 92, type: !91)
!259 = distinct !DILocation(line: 160, column: 10, scope: !141)
!260 = !DILocation(line: 81, column: 7, scope: !250, inlinedAt: !259)
!261 = !DILocation(line: 157, column: 39, scope: !141)
!262 = !DILocation(line: 157, column: 12, scope: !141)
!263 = !DILocation(line: 81, column: 14, scope: !264, inlinedAt: !259)
!264 = distinct !DILexicalBlock(scope: !250, file: !3, line: 81, column: 7)
!265 = !DILocation(line: 84, column: 25, scope: !250, inlinedAt: !259)
!266 = !DILocation(line: 85, column: 8, scope: !267, inlinedAt: !259)
!267 = distinct !DILexicalBlock(scope: !250, file: !3, line: 85, column: 7)
!268 = !DILocation(line: 85, column: 7, scope: !250, inlinedAt: !259)
!269 = !DILocation(line: 89, column: 8, scope: !250, inlinedAt: !259)
!270 = !DILocation(line: 89, column: 18, scope: !250, inlinedAt: !259)
!271 = !{!272, !205, i64 0}
!272 = !{!"datarec", !205, i64 0, !205, i64 8}
!273 = !DILocation(line: 90, column: 26, scope: !250, inlinedAt: !259)
!274 = !DILocation(line: 90, column: 42, scope: !250, inlinedAt: !259)
!275 = !DILocation(line: 90, column: 35, scope: !250, inlinedAt: !259)
!276 = !DILocation(line: 90, column: 20, scope: !250, inlinedAt: !259)
!277 = !DILocation(line: 90, column: 8, scope: !250, inlinedAt: !259)
!278 = !DILocation(line: 90, column: 17, scope: !250, inlinedAt: !259)
!279 = !{!272, !205, i64 8}
!280 = !DILocation(line: 92, column: 30, scope: !250, inlinedAt: !259)
!281 = !DILocation(line: 93, column: 8, scope: !282, inlinedAt: !259)
!282 = distinct !DILexicalBlock(scope: !250, file: !3, line: 93, column: 7)
!283 = !DILocation(line: 93, column: 7, scope: !250, inlinedAt: !259)
!284 = !DILocation(line: 96, column: 26, scope: !250, inlinedAt: !259)
!285 = !DILocation(line: 96, column: 14, scope: !250, inlinedAt: !259)
!286 = !DILocation(line: 96, column: 24, scope: !250, inlinedAt: !259)
!287 = !{!288, !205, i64 0}
!288 = !{!"telrec", !205, i64 0, !205, i64 8}
!289 = !DILocation(line: 97, column: 53, scope: !250, inlinedAt: !259)
!290 = !DILocation(line: 97, column: 14, scope: !250, inlinedAt: !259)
!291 = !DILocation(line: 97, column: 30, scope: !250, inlinedAt: !259)
!292 = !{!288, !205, i64 8}
!293 = !DILocation(line: 99, column: 10, scope: !250, inlinedAt: !259)
!294 = !DILocation(line: 99, column: 3, scope: !250, inlinedAt: !259)
!295 = !DILocation(line: 100, column: 1, scope: !250, inlinedAt: !259)
!296 = !DILocation(line: 160, column: 3, scope: !141)
!297 = !DILocation(line: 161, column: 1, scope: !141)
