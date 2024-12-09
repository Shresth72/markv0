; ModuleID = './random_early_detection_user/c/kern.c'
source_filename = "./random_early_detection_user/c/kern.c"
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
@redirect_params = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !114
@tx_port = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !98
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !55
@xdp_stats_map = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !62
@telemetry_stats_map = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !85
@llvm.used = appending global [7 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* bitcast (%struct.anon.0* @redirect_params to i8*), i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* bitcast (%struct.anon.1* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_redirect_map_func to i8*), i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_redirect_map_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_redirect_map" !dbg !142 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !154, metadata !DIExpression()), !dbg !183
  %5 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !184
  call void @llvm.dbg.value(metadata i64 %5, metadata !155, metadata !DIExpression()), !dbg !183
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !185
  %7 = load i32, i32* %6, align 4, !dbg !185, !tbaa !186
  %8 = zext i32 %7 to i64, !dbg !191
  %9 = inttoptr i64 %8 to i8*, !dbg !192
  call void @llvm.dbg.value(metadata i8* %9, metadata !156, metadata !DIExpression()), !dbg !183
  %10 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !193
  %11 = load i32, i32* %10, align 4, !dbg !193, !tbaa !194
  %12 = zext i32 %11 to i64, !dbg !195
  %13 = inttoptr i64 %12 to i8*, !dbg !196
  call void @llvm.dbg.value(metadata i8* %13, metadata !157, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.value(metadata i32 2, metadata !170, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.value(metadata i64 50, metadata !171, metadata !DIExpression()), !dbg !183
  %14 = bitcast i32* %3 to i8*, !dbg !197
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %14) #3, !dbg !197
  call void @llvm.dbg.value(metadata i32 0, metadata !172, metadata !DIExpression()), !dbg !183
  store i32 0, i32* %3, align 4, !dbg !198, !tbaa !199
  call void @llvm.dbg.value(metadata i32* %3, metadata !172, metadata !DIExpression(DW_OP_deref)), !dbg !183
  %15 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %14) #3, !dbg !200
  call void @llvm.dbg.value(metadata i8* %15, metadata !173, metadata !DIExpression()), !dbg !183
  %16 = icmp eq i8* %15, null, !dbg !201
  br i1 %16, label %49, label %17, !dbg !203

17:                                               ; preds = %1
  %18 = bitcast i8* %15 to i64*, !dbg !200
  call void @llvm.dbg.value(metadata i64* %18, metadata !173, metadata !DIExpression()), !dbg !183
  %19 = load i64, i64* %18, align 8, !dbg !204, !tbaa !205
  call void @llvm.dbg.value(metadata i64 %19, metadata !207, metadata !DIExpression()), !dbg !215
  call void @llvm.dbg.value(metadata i64 50, metadata !212, metadata !DIExpression()), !dbg !215
  %20 = mul i64 %19, 998000, !dbg !217
  call void @llvm.dbg.value(metadata i64 %20, metadata !213, metadata !DIExpression()), !dbg !215
  call void @llvm.dbg.value(metadata i64 100000, metadata !214, metadata !DIExpression()), !dbg !215
  %21 = add i64 %20, 100000, !dbg !218
  %22 = udiv i64 %21, 1000000, !dbg !219
  call void @llvm.dbg.value(metadata i64 %22, metadata !174, metadata !DIExpression()), !dbg !183
  store i64 %22, i64* %4, align 8, !dbg !220, !tbaa !205
  %23 = bitcast i64* %4 to i8*, !dbg !221
  call void @llvm.dbg.value(metadata i32* %3, metadata !172, metadata !DIExpression(DW_OP_deref)), !dbg !183
  call void @llvm.dbg.value(metadata i64* %4, metadata !174, metadata !DIExpression(DW_OP_deref)), !dbg !183
  %24 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %14, i8* nonnull %23, i64 0) #3, !dbg !222
  %25 = load i64, i64* %4, align 8, !dbg !223, !tbaa !205
  call void @llvm.dbg.value(metadata i64 %25, metadata !174, metadata !DIExpression()), !dbg !183
  %26 = icmp ugt i64 %25, 4999, !dbg !224
  br i1 %26, label %49, label %27, !dbg !225

27:                                               ; preds = %17
  %28 = icmp ult i64 %25, 1001, !dbg !226
  br i1 %28, label %37, label %29, !dbg !227

29:                                               ; preds = %27
  %30 = trunc i64 %25 to i32, !dbg !228
  %31 = mul nuw nsw i32 %30, 100, !dbg !228
  %32 = add nsw i32 %31, -100000, !dbg !228
  %33 = udiv i32 %32, 4000, !dbg !228
  call void @llvm.dbg.value(metadata i32 %33, metadata !175, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !229
  %34 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !230
  %35 = urem i32 %34, 100, !dbg !232
  %36 = icmp ugt i32 %33, %35, !dbg !233
  call void @llvm.dbg.value(metadata i32 undef, metadata !170, metadata !DIExpression()), !dbg !183
  br i1 %36, label %49, label %37

37:                                               ; preds = %29, %27
  call void @llvm.dbg.value(metadata i32 2, metadata !170, metadata !DIExpression()), !dbg !183
  %38 = getelementptr i8, i8* %13, i64 14, !dbg !234
  %39 = icmp ugt i8* %38, %9, !dbg !236
  br i1 %39, label %88, label %40, !dbg !237

40:                                               ; preds = %37
  %41 = inttoptr i64 %12 to %struct.ethhdr*, !dbg !238
  call void @llvm.dbg.value(metadata %struct.ethhdr* %41, metadata !158, metadata !DIExpression()), !dbg !183
  %42 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %41, i64 0, i32 1, i64 0, !dbg !239
  %43 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @redirect_params to i8*), i8* nonnull %42) #3, !dbg !240
  call void @llvm.dbg.value(metadata i8* %43, metadata !179, metadata !DIExpression()), !dbg !183
  %44 = icmp eq i8* %43, null, !dbg !241
  br i1 %44, label %49, label %45, !dbg !243

45:                                               ; preds = %40
  %46 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %41, i64 0, i32 0, i64 0, !dbg !244
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %46, i8* nonnull align 1 dereferenceable(6) %43, i64 6, i1 false), !dbg !244
  call void @llvm.dbg.value(metadata i32* %3, metadata !172, metadata !DIExpression(DW_OP_deref)), !dbg !183
  %47 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i8* nonnull %14) #3, !dbg !245
  call void @llvm.dbg.value(metadata i8* %47, metadata !181, metadata !DIExpression()), !dbg !183
  %48 = icmp eq i8* %47, null, !dbg !246
  br i1 %48, label %49, label %52, !dbg !248

49:                                               ; preds = %45, %40, %29, %1, %17
  %50 = phi i32 [ 1, %17 ], [ 1, %1 ], [ 1, %29 ], [ 2, %40 ], [ 2, %45 ]
  call void @llvm.dbg.value(metadata i32 %57, metadata !170, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.label(metadata !182), !dbg !249
  %51 = bitcast i32* %2 to i8*, !dbg !250
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %51), !dbg !250
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !255, metadata !DIExpression()) #3, !dbg !250
  call void @llvm.dbg.value(metadata i32 %57, metadata !256, metadata !DIExpression()) #3, !dbg !250
  store i32 %50, i32* %2, align 4, !tbaa !199
  call void @llvm.dbg.value(metadata i64 %5, metadata !257, metadata !DIExpression()) #3, !dbg !250
  br label %60, !dbg !261

52:                                               ; preds = %45
  %53 = bitcast i8* %47 to i32*, !dbg !245
  call void @llvm.dbg.value(metadata i32* %53, metadata !181, metadata !DIExpression()), !dbg !183
  %54 = load i32, i32* %53, align 4, !dbg !262, !tbaa !199
  %55 = zext i32 %54 to i64, !dbg !262
  %56 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i64 %55, i64 0) #3, !dbg !263
  %57 = trunc i64 %56 to i32, !dbg !263
  call void @llvm.dbg.value(metadata i32 %57, metadata !170, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.label(metadata !182), !dbg !249
  %58 = bitcast i32* %2 to i8*, !dbg !250
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %58), !dbg !250
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !255, metadata !DIExpression()) #3, !dbg !250
  call void @llvm.dbg.value(metadata i32 %57, metadata !256, metadata !DIExpression()) #3, !dbg !250
  store i32 %57, i32* %2, align 4, !tbaa !199
  call void @llvm.dbg.value(metadata i64 %5, metadata !257, metadata !DIExpression()) #3, !dbg !250
  %59 = icmp ugt i32 %57, 4, !dbg !264
  br i1 %59, label %85, label %60, !dbg !261

60:                                               ; preds = %49, %52
  %61 = phi i8* [ %51, %49 ], [ %58, %52 ]
  call void @llvm.dbg.value(metadata i32* %2, metadata !256, metadata !DIExpression(DW_OP_deref)) #3, !dbg !250
  %62 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*), i8* nonnull %61) #3, !dbg !266
  call void @llvm.dbg.value(metadata i8* %62, metadata !258, metadata !DIExpression()) #3, !dbg !250
  %63 = icmp eq i8* %62, null, !dbg !267
  br i1 %63, label %85, label %64, !dbg !269

64:                                               ; preds = %60
  call void @llvm.dbg.value(metadata i8* %62, metadata !258, metadata !DIExpression()) #3, !dbg !250
  %65 = bitcast i8* %62 to i64*, !dbg !270
  %66 = load i64, i64* %65, align 8, !dbg !271, !tbaa !272
  %67 = add i64 %66, 1, !dbg !271
  store i64 %67, i64* %65, align 8, !dbg !271, !tbaa !272
  %68 = load i32, i32* %6, align 4, !dbg !274, !tbaa !186
  %69 = load i32, i32* %10, align 4, !dbg !275, !tbaa !194
  %70 = sub i32 %68, %69, !dbg !276
  %71 = zext i32 %70 to i64, !dbg !277
  %72 = getelementptr inbounds i8, i8* %62, i64 8, !dbg !278
  %73 = bitcast i8* %72 to i64*, !dbg !278
  %74 = load i64, i64* %73, align 8, !dbg !279, !tbaa !280
  %75 = add i64 %74, %71, !dbg !279
  store i64 %75, i64* %73, align 8, !dbg !279, !tbaa !280
  call void @llvm.dbg.value(metadata i32* %2, metadata !256, metadata !DIExpression(DW_OP_deref)) #3, !dbg !250
  %76 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* nonnull %61) #3, !dbg !281
  call void @llvm.dbg.value(metadata i8* %76, metadata !259, metadata !DIExpression()) #3, !dbg !250
  %77 = icmp eq i8* %76, null, !dbg !282
  br i1 %77, label %85, label %78, !dbg !284

78:                                               ; preds = %64
  call void @llvm.dbg.value(metadata i8* %76, metadata !259, metadata !DIExpression()) #3, !dbg !250
  %79 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !285
  %80 = bitcast i8* %76 to i64*, !dbg !286
  store i64 %79, i64* %80, align 8, !dbg !287, !tbaa !288
  %81 = sub i64 %79, %5, !dbg !290
  %82 = getelementptr inbounds i8, i8* %76, i64 8, !dbg !291
  %83 = bitcast i8* %82 to i64*, !dbg !291
  store i64 %81, i64* %83, align 8, !dbg !292, !tbaa !293
  %84 = load i32, i32* %2, align 4, !dbg !294, !tbaa !199
  call void @llvm.dbg.value(metadata i32 %84, metadata !256, metadata !DIExpression()) #3, !dbg !250
  br label %85, !dbg !295

85:                                               ; preds = %52, %60, %64, %78
  %86 = phi i8* [ %58, %52 ], [ %61, %60 ], [ %61, %78 ], [ %61, %64 ]
  %87 = phi i32 [ 0, %52 ], [ 0, %60 ], [ %84, %78 ], [ 0, %64 ], !dbg !250
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %86), !dbg !296
  br label %88, !dbg !297

88:                                               ; preds = %37, %85
  %89 = phi i32 [ %87, %85 ], [ 1, %37 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %14) #3, !dbg !298
  ret i32 %89, !dbg !298
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
!llvm.module.flags = !{!138, !139, !140}
!llvm.ident = !{!141}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "queue_avg_map", scope: !2, file: !57, line: 63, type: !131, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !17, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "random_early_detection_user/c/kern.c", directory: "/home/shrestha/btp/designs/eBPF")
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
!17 = !{!18, !28, !36, !42, !49, !55, !62, !85, !98, !114, !0}
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
!56 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !57, line: 161, type: !58, isLocal: false, isDefinition: true)
!57 = !DIFile(filename: "./random_early_detection_user/c/kern.c", directory: "/home/shrestha/btp/designs/eBPF")
!58 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 32, elements: !60)
!59 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!60 = !{!61}
!61 = !DISubrange(count: 4)
!62 = !DIGlobalVariableExpression(var: !63, expr: !DIExpression())
!63 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !57, line: 35, type: !64, isLocal: false, isDefinition: true)
!64 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !57, line: 30, size: 256, elements: !65)
!65 = !{!66, !72, !74, !80}
!66 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !64, file: !57, line: 31, baseType: !67, size: 64)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !68, size: 64)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 64, elements: !70)
!69 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!70 = !{!71}
!71 = !DISubrange(count: 2)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !64, file: !57, line: 32, baseType: !73, size: 64, offset: 64)
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !64, file: !57, line: 33, baseType: !75, size: 64, offset: 128)
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !76, size: 64)
!76 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !57, line: 8, size: 128, elements: !77)
!77 = !{!78, !79}
!78 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !76, file: !57, line: 9, baseType: !25, size: 64)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !76, file: !57, line: 10, baseType: !25, size: 64, offset: 64)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !64, file: !57, line: 34, baseType: !81, size: 64, offset: 192)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!82 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 160, elements: !83)
!83 = !{!84}
!84 = !DISubrange(count: 5)
!85 = !DIGlobalVariableExpression(var: !86, expr: !DIExpression())
!86 = distinct !DIGlobalVariable(name: "telemetry_stats_map", scope: !2, file: !57, line: 42, type: !87, isLocal: false, isDefinition: true)
!87 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !57, line: 37, size: 256, elements: !88)
!88 = !{!89, !90, !91, !97}
!89 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !87, file: !57, line: 38, baseType: !67, size: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !87, file: !57, line: 39, baseType: !73, size: 64, offset: 64)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !87, file: !57, line: 40, baseType: !92, size: 64, offset: 128)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !93, size: 64)
!93 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "telrec", file: !57, line: 13, size: 128, elements: !94)
!94 = !{!95, !96}
!95 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !93, file: !57, line: 14, baseType: !25, size: 64)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time", scope: !93, file: !57, line: 15, baseType: !25, size: 64, offset: 64)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !87, file: !57, line: 41, baseType: !81, size: 64, offset: 192)
!98 = !DIGlobalVariableExpression(var: !99, expr: !DIExpression())
!99 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !57, line: 49, type: !100, isLocal: false, isDefinition: true)
!100 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !57, line: 44, size: 256, elements: !101)
!101 = !{!102, !107, !108, !109}
!102 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !100, file: !57, line: 45, baseType: !103, size: 64)
!103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!104 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 448, elements: !105)
!105 = !{!106}
!106 = !DISubrange(count: 14)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !100, file: !57, line: 46, baseType: !73, size: 64, offset: 64)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !100, file: !57, line: 47, baseType: !73, size: 64, offset: 128)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !100, file: !57, line: 48, baseType: !110, size: 64, offset: 192)
!110 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !111, size: 64)
!111 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 8192, elements: !112)
!112 = !{!113}
!113 = !DISubrange(count: 256)
!114 = !DIGlobalVariableExpression(var: !115, expr: !DIExpression())
!115 = distinct !DIGlobalVariable(name: "redirect_params", scope: !2, file: !57, line: 56, type: !116, isLocal: false, isDefinition: true)
!116 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !57, line: 51, size: 256, elements: !117)
!117 = !{!118, !123, !129, !130}
!118 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !116, file: !57, line: 52, baseType: !119, size: 64)
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!120 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 32, elements: !121)
!121 = !{!122}
!122 = !DISubrange(count: 1)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !116, file: !57, line: 53, baseType: !124, size: 64, offset: 64)
!124 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 64)
!125 = !DICompositeType(tag: DW_TAG_array_type, baseType: !126, size: 48, elements: !127)
!126 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!127 = !{!128}
!128 = !DISubrange(count: 6)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !116, file: !57, line: 54, baseType: !124, size: 64, offset: 128)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !116, file: !57, line: 55, baseType: !119, size: 64, offset: 192)
!131 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !57, line: 58, size: 256, elements: !132)
!132 = !{!133, !134, !135, !137}
!133 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !131, file: !57, line: 59, baseType: !67, size: 64)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !131, file: !57, line: 60, baseType: !73, size: 64, offset: 64)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !131, file: !57, line: 61, baseType: !136, size: 64, offset: 128)
!136 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !131, file: !57, line: 62, baseType: !119, size: 64, offset: 192)
!138 = !{i32 7, !"Dwarf Version", i32 4}
!139 = !{i32 2, !"Debug Info Version", i32 3}
!140 = !{i32 1, !"wchar_size", i32 4}
!141 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!142 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !57, file: !57, line: 101, type: !143, scopeLine: 101, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !153)
!143 = !DISubroutineType(types: !144)
!144 = !{!69, !145}
!145 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !146, size: 64)
!146 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !147)
!147 = !{!148, !149, !150, !151, !152}
!148 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !146, file: !6, line: 3165, baseType: !48, size: 32)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !146, file: !6, line: 3166, baseType: !48, size: 32, offset: 32)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !146, file: !6, line: 3167, baseType: !48, size: 32, offset: 64)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !146, file: !6, line: 3169, baseType: !48, size: 32, offset: 96)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !146, file: !6, line: 3170, baseType: !48, size: 32, offset: 128)
!153 = !{!154, !155, !156, !157, !158, !170, !171, !172, !173, !174, !175, !179, !181, !182}
!154 = !DILocalVariable(name: "ctx", arg: 1, scope: !142, file: !57, line: 101, type: !145)
!155 = !DILocalVariable(name: "start", scope: !142, file: !57, line: 102, type: !25)
!156 = !DILocalVariable(name: "data_end", scope: !142, file: !57, line: 104, type: !15)
!157 = !DILocalVariable(name: "data", scope: !142, file: !57, line: 105, type: !15)
!158 = !DILocalVariable(name: "eth", scope: !142, file: !57, line: 107, type: !159)
!159 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !160, size: 64)
!160 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !161, line: 163, size: 112, elements: !162)
!161 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!162 = !{!163, !164, !165}
!163 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !160, file: !161, line: 164, baseType: !125, size: 48)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !160, file: !161, line: 165, baseType: !125, size: 48, offset: 48)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !160, file: !161, line: 166, baseType: !166, size: 16, offset: 96)
!166 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !167, line: 25, baseType: !168)
!167 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!168 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !26, line: 24, baseType: !169)
!169 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!170 = !DILocalVariable(name: "action", scope: !142, file: !57, line: 108, type: !48)
!171 = !DILocalVariable(name: "queue_len", scope: !142, file: !57, line: 109, type: !25)
!172 = !DILocalVariable(name: "key", scope: !142, file: !57, line: 110, type: !48)
!173 = !DILocalVariable(name: "prev_avg", scope: !142, file: !57, line: 112, type: !136)
!174 = !DILocalVariable(name: "new_avg", scope: !142, file: !57, line: 118, type: !25)
!175 = !DILocalVariable(name: "drop_prob", scope: !176, file: !57, line: 128, type: !25)
!176 = distinct !DILexicalBlock(scope: !177, file: !57, line: 126, column: 10)
!177 = distinct !DILexicalBlock(scope: !178, file: !57, line: 124, column: 14)
!178 = distinct !DILexicalBlock(scope: !142, file: !57, line: 121, column: 7)
!179 = !DILocalVariable(name: "dst", scope: !142, file: !57, line: 144, type: !180)
!180 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !126, size: 64)
!181 = !DILocalVariable(name: "iface_index", scope: !142, file: !57, line: 151, type: !73)
!182 = !DILabel(scope: !142, name: "out", file: !57, line: 157)
!183 = !DILocation(line: 0, scope: !142)
!184 = !DILocation(line: 102, column: 17, scope: !142)
!185 = !DILocation(line: 104, column: 39, scope: !142)
!186 = !{!187, !188, i64 4}
!187 = !{!"xdp_md", !188, i64 0, !188, i64 4, !188, i64 8, !188, i64 12, !188, i64 16}
!188 = !{!"int", !189, i64 0}
!189 = !{!"omnipotent char", !190, i64 0}
!190 = !{!"Simple C/C++ TBAA"}
!191 = !DILocation(line: 104, column: 28, scope: !142)
!192 = !DILocation(line: 104, column: 20, scope: !142)
!193 = !DILocation(line: 105, column: 35, scope: !142)
!194 = !{!187, !188, i64 0}
!195 = !DILocation(line: 105, column: 24, scope: !142)
!196 = !DILocation(line: 105, column: 16, scope: !142)
!197 = !DILocation(line: 110, column: 3, scope: !142)
!198 = !DILocation(line: 110, column: 9, scope: !142)
!199 = !{!188, !188, i64 0}
!200 = !DILocation(line: 112, column: 21, scope: !142)
!201 = !DILocation(line: 113, column: 8, scope: !202)
!202 = distinct !DILexicalBlock(scope: !142, file: !57, line: 113, column: 7)
!203 = !DILocation(line: 113, column: 7, scope: !142)
!204 = !DILocation(line: 118, column: 43, scope: !142)
!205 = !{!206, !206, i64 0}
!206 = !{!"long long", !189, i64 0}
!207 = !DILocalVariable(name: "prev_avg", arg: 1, scope: !208, file: !57, line: 67, type: !25)
!208 = distinct !DISubprogram(name: "calculate_avg_queue_len", scope: !57, file: !57, line: 67, type: !209, scopeLine: 68, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !211)
!209 = !DISubroutineType(types: !210)
!210 = !{!25, !25, !25}
!211 = !{!207, !212, !213, !214}
!212 = !DILocalVariable(name: "curr_queue_len", arg: 2, scope: !208, file: !57, line: 68, type: !25)
!213 = !DILocalVariable(name: "weighted_prev_avg", scope: !208, file: !57, line: 71, type: !25)
!214 = !DILocalVariable(name: "weighted_curr_len", scope: !208, file: !57, line: 72, type: !25)
!215 = !DILocation(line: 0, scope: !208, inlinedAt: !216)
!216 = distinct !DILocation(line: 118, column: 19, scope: !142)
!217 = !DILocation(line: 71, column: 55, scope: !208, inlinedAt: !216)
!218 = !DILocation(line: 73, column: 29, scope: !208, inlinedAt: !216)
!219 = !DILocation(line: 73, column: 50, scope: !208, inlinedAt: !216)
!220 = !DILocation(line: 118, column: 9, scope: !142)
!221 = !DILocation(line: 119, column: 45, scope: !142)
!222 = !DILocation(line: 119, column: 3, scope: !142)
!223 = !DILocation(line: 121, column: 7, scope: !178)
!224 = !DILocation(line: 121, column: 15, scope: !178)
!225 = !DILocation(line: 121, column: 7, scope: !142)
!226 = !DILocation(line: 124, column: 22, scope: !177)
!227 = !DILocation(line: 124, column: 14, scope: !178)
!228 = !DILocation(line: 128, column: 66, scope: !176)
!229 = !DILocation(line: 0, scope: !176)
!230 = !DILocation(line: 132, column: 9, scope: !231)
!231 = distinct !DILexicalBlock(scope: !176, file: !57, line: 132, column: 9)
!232 = !DILocation(line: 132, column: 31, scope: !231)
!233 = !DILocation(line: 132, column: 37, scope: !231)
!234 = !DILocation(line: 139, column: 12, scope: !235)
!235 = distinct !DILexicalBlock(scope: !142, file: !57, line: 139, column: 7)
!236 = !DILocation(line: 139, column: 36, scope: !235)
!237 = !DILocation(line: 139, column: 7, scope: !142)
!238 = !DILocation(line: 142, column: 9, scope: !142)
!239 = !DILocation(line: 144, column: 62, scope: !142)
!240 = !DILocation(line: 144, column: 24, scope: !142)
!241 = !DILocation(line: 145, column: 8, scope: !242)
!242 = distinct !DILexicalBlock(scope: !142, file: !57, line: 145, column: 7)
!243 = !DILocation(line: 145, column: 7, scope: !142)
!244 = !DILocation(line: 149, column: 3, scope: !142)
!245 = !DILocation(line: 151, column: 24, scope: !142)
!246 = !DILocation(line: 152, column: 8, scope: !247)
!247 = distinct !DILexicalBlock(scope: !142, file: !57, line: 152, column: 7)
!248 = !DILocation(line: 152, column: 7, scope: !142)
!249 = !DILocation(line: 157, column: 1, scope: !142)
!250 = !DILocation(line: 0, scope: !251, inlinedAt: !260)
!251 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !57, file: !57, line: 76, type: !252, scopeLine: 78, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !254)
!252 = !DISubroutineType(types: !253)
!253 = !{!48, !145, !48, !25}
!254 = !{!255, !256, !257, !258, !259}
!255 = !DILocalVariable(name: "ctx", arg: 1, scope: !251, file: !57, line: 76, type: !145)
!256 = !DILocalVariable(name: "action", arg: 2, scope: !251, file: !57, line: 77, type: !48)
!257 = !DILocalVariable(name: "start", arg: 3, scope: !251, file: !57, line: 78, type: !25)
!258 = !DILocalVariable(name: "rec", scope: !251, file: !57, line: 82, type: !75)
!259 = !DILocalVariable(name: "telemetry", scope: !251, file: !57, line: 90, type: !92)
!260 = distinct !DILocation(line: 158, column: 10, scope: !142)
!261 = !DILocation(line: 79, column: 7, scope: !251, inlinedAt: !260)
!262 = !DILocation(line: 155, column: 39, scope: !142)
!263 = !DILocation(line: 155, column: 12, scope: !142)
!264 = !DILocation(line: 79, column: 14, scope: !265, inlinedAt: !260)
!265 = distinct !DILexicalBlock(scope: !251, file: !57, line: 79, column: 7)
!266 = !DILocation(line: 82, column: 25, scope: !251, inlinedAt: !260)
!267 = !DILocation(line: 83, column: 8, scope: !268, inlinedAt: !260)
!268 = distinct !DILexicalBlock(scope: !251, file: !57, line: 83, column: 7)
!269 = !DILocation(line: 83, column: 7, scope: !251, inlinedAt: !260)
!270 = !DILocation(line: 87, column: 8, scope: !251, inlinedAt: !260)
!271 = !DILocation(line: 87, column: 18, scope: !251, inlinedAt: !260)
!272 = !{!273, !206, i64 0}
!273 = !{!"datarec", !206, i64 0, !206, i64 8}
!274 = !DILocation(line: 88, column: 26, scope: !251, inlinedAt: !260)
!275 = !DILocation(line: 88, column: 42, scope: !251, inlinedAt: !260)
!276 = !DILocation(line: 88, column: 35, scope: !251, inlinedAt: !260)
!277 = !DILocation(line: 88, column: 20, scope: !251, inlinedAt: !260)
!278 = !DILocation(line: 88, column: 8, scope: !251, inlinedAt: !260)
!279 = !DILocation(line: 88, column: 17, scope: !251, inlinedAt: !260)
!280 = !{!273, !206, i64 8}
!281 = !DILocation(line: 90, column: 30, scope: !251, inlinedAt: !260)
!282 = !DILocation(line: 91, column: 8, scope: !283, inlinedAt: !260)
!283 = distinct !DILexicalBlock(scope: !251, file: !57, line: 91, column: 7)
!284 = !DILocation(line: 91, column: 7, scope: !251, inlinedAt: !260)
!285 = !DILocation(line: 94, column: 26, scope: !251, inlinedAt: !260)
!286 = !DILocation(line: 94, column: 14, scope: !251, inlinedAt: !260)
!287 = !DILocation(line: 94, column: 24, scope: !251, inlinedAt: !260)
!288 = !{!289, !206, i64 0}
!289 = !{!"telrec", !206, i64 0, !206, i64 8}
!290 = !DILocation(line: 95, column: 53, scope: !251, inlinedAt: !260)
!291 = !DILocation(line: 95, column: 14, scope: !251, inlinedAt: !260)
!292 = !DILocation(line: 95, column: 30, scope: !251, inlinedAt: !260)
!293 = !{!289, !206, i64 8}
!294 = !DILocation(line: 97, column: 10, scope: !251, inlinedAt: !260)
!295 = !DILocation(line: 97, column: 3, scope: !251, inlinedAt: !260)
!296 = !DILocation(line: 98, column: 1, scope: !251, inlinedAt: !260)
!297 = !DILocation(line: 158, column: 3, scope: !142)
!298 = !DILocation(line: 159, column: 1, scope: !142)
