; ModuleID = 'kern.c'
source_filename = "kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.0 = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.1 = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.2 = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.3 = type { [2 x i32]*, i32*, %struct.mmpp_source*, [4 x i32]* }
%struct.mmpp_source = type { i64, i64, i64, i64, i64, i64 }
%struct.anon.4 = type { [2 x i32]*, i32*, %struct.datarec*, [4 x i32]* }
%struct.datarec = type { i64, i64, i64, i64, i64, i64, i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@window_start = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@packet_count = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !91
@average_count = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !104
@queue_size = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !112
@mmpp_sources = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !74
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !41
@xdp_stats_map = dso_local global %struct.anon.4 zeroinitializer, section ".maps", align 8, !dbg !47
@llvm.used = appending global [8 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.1* @average_count to i8*), i8* bitcast (%struct.anon.3* @mmpp_sources to i8*), i8* bitcast (%struct.anon.0* @packet_count to i8*), i8* bitcast (%struct.anon.2* @queue_size to i8*), i8* bitcast (%struct.anon* @window_start to i8*), i8* bitcast (%struct.anon.4* @xdp_stats_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_traffic_shaper to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_traffic_shaper(%struct.xdp_md* nocapture readonly %0) #0 section "xdp" !dbg !130 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !142, metadata !DIExpression()), !dbg !154
  %4 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !155
  call void @llvm.dbg.value(metadata i64 %4, metadata !143, metadata !DIExpression()), !dbg !154
  call void @llvm.dbg.value(metadata i32 2, metadata !144, metadata !DIExpression()), !dbg !154
  %5 = bitcast i32* %3 to i8*, !dbg !156
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %5) #3, !dbg !156
  call void @llvm.dbg.value(metadata i32 0, metadata !145, metadata !DIExpression()), !dbg !154
  store i32 0, i32* %3, align 4, !dbg !157, !tbaa !158
  call void @llvm.dbg.value(metadata i32* %3, metadata !145, metadata !DIExpression(DW_OP_deref)), !dbg !154
  %6 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @window_start to i8*), i8* nonnull %5) #3, !dbg !162
  %7 = bitcast i8* %6 to i64*, !dbg !162
  call void @llvm.dbg.value(metadata i64* %7, metadata !146, metadata !DIExpression()), !dbg !154
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @packet_count to i8*), i8* nonnull %5) #3, !dbg !163
  %9 = bitcast i8* %8 to i64*, !dbg !163
  call void @llvm.dbg.value(metadata i64* %9, metadata !147, metadata !DIExpression()), !dbg !154
  %10 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @average_count to i8*), i8* nonnull %5) #3, !dbg !164
  %11 = bitcast i8* %10 to i64*, !dbg !164
  call void @llvm.dbg.value(metadata i64* %11, metadata !148, metadata !DIExpression()), !dbg !154
  %12 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @queue_size to i8*), i8* nonnull %5) #3, !dbg !165
  %13 = bitcast i8* %12 to i64*, !dbg !165
  call void @llvm.dbg.value(metadata i64* %13, metadata !149, metadata !DIExpression()), !dbg !154
  %14 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @mmpp_sources to i8*), i8* nonnull %5) #3, !dbg !166
  call void @llvm.dbg.value(metadata i8* %14, metadata !150, metadata !DIExpression()), !dbg !154
  %15 = icmp ne i8* %6, null, !dbg !167
  %16 = icmp ne i8* %8, null
  %17 = and i1 %15, %16, !dbg !169
  %18 = icmp ne i8* %10, null
  %19 = and i1 %17, %18, !dbg !169
  %20 = icmp ne i8* %12, null
  %21 = and i1 %19, %20, !dbg !169
  %22 = icmp ne i8* %14, null
  %23 = and i1 %21, %22, !dbg !169
  br i1 %23, label %24, label %122, !dbg !169

24:                                               ; preds = %1
  %25 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !170
  call void @llvm.dbg.value(metadata i64 %25, metadata !151, metadata !DIExpression()), !dbg !154
  %26 = load i64, i64* %7, align 8, !dbg !171, !tbaa !173
  %27 = sub i64 %25, %26, !dbg !175
  %28 = icmp ugt i64 %27, 999999999, !dbg !176
  br i1 %28, label %29, label %35, !dbg !177

29:                                               ; preds = %24
  store i64 %25, i64* %7, align 8, !dbg !178, !tbaa !173
  %30 = load i64, i64* %11, align 8, !dbg !180, !tbaa !173
  %31 = mul i64 %30, 999999, !dbg !181
  %32 = load i64, i64* %9, align 8, !dbg !182, !tbaa !173
  %33 = add i64 %31, %32, !dbg !183
  %34 = udiv i64 %33, 1000000, !dbg !184
  store i64 %34, i64* %11, align 8, !dbg !185, !tbaa !173
  store i64 0, i64* %9, align 8, !dbg !186, !tbaa !173
  br label %35, !dbg !187

35:                                               ; preds = %29, %24
  %36 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !188
  %37 = zext i32 %36 to i64, !dbg !188
  call void @llvm.dbg.value(metadata i64 %37, metadata !152, metadata !DIExpression()), !dbg !154
  %38 = getelementptr inbounds i8, i8* %14, i64 32, !dbg !189
  %39 = bitcast i8* %38 to i64*, !dbg !189
  %40 = load i64, i64* %39, align 8, !dbg !189, !tbaa !191
  switch i64 %40, label %53 [
    i64 1, label %41
    i64 2, label %48
  ], !dbg !193

41:                                               ; preds = %35
  %42 = getelementptr inbounds i8, i8* %14, i64 24, !dbg !194
  %43 = bitcast i8* %42 to i64*, !dbg !194
  %44 = load i64, i64* %43, align 8, !dbg !194, !tbaa !195
  %45 = icmp ugt i64 %44, %37, !dbg !196
  br i1 %45, label %55, label %46, !dbg !197

46:                                               ; preds = %41
  %47 = getelementptr inbounds i8, i8* %14, i64 8, !dbg !198
  br label %59, !dbg !198

48:                                               ; preds = %35
  %49 = getelementptr inbounds i8, i8* %14, i64 16, !dbg !199
  %50 = bitcast i8* %49 to i64*, !dbg !199
  %51 = load i64, i64* %50, align 8, !dbg !199, !tbaa !200
  %52 = icmp ugt i64 %51, %37, !dbg !201
  br i1 %52, label %55, label %53, !dbg !202

53:                                               ; preds = %35, %48
  %54 = getelementptr inbounds i8, i8* %14, i64 8, !dbg !198
  br label %61, !dbg !198

55:                                               ; preds = %41, %48
  %56 = sub nuw nsw i64 3, %40, !dbg !203
  store i64 %56, i64* %39, align 8, !dbg !205, !tbaa !191
  %57 = icmp eq i64 %56, 1, !dbg !206
  %58 = getelementptr inbounds i8, i8* %14, i64 8, !dbg !198
  br i1 %57, label %59, label %61, !dbg !198

59:                                               ; preds = %46, %55
  %60 = phi i8* [ %47, %46 ], [ %58, %55 ]
  br label %61, !dbg !198

61:                                               ; preds = %53, %55, %59
  %62 = phi i8* [ %60, %59 ], [ %58, %55 ], [ %54, %53 ]
  %63 = phi i8* [ %14, %59 ], [ %58, %55 ], [ %54, %53 ]
  %64 = bitcast i8* %63 to i64*, !dbg !154
  %65 = load i64, i64* %64, align 8, !dbg !198, !tbaa !173
  call void @llvm.dbg.value(metadata i64 %65, metadata !153, metadata !DIExpression()), !dbg !154
  %66 = load i64, i64* %9, align 8, !dbg !207, !tbaa !173
  %67 = add i64 %66, 1, !dbg !207
  store i64 %67, i64* %9, align 8, !dbg !207, !tbaa !173
  %68 = load i64, i64* %13, align 8, !dbg !208, !tbaa !173
  %69 = icmp ugt i64 %68, 300, !dbg !210
  br i1 %69, label %75, label %70, !dbg !211

70:                                               ; preds = %61
  %71 = load i64, i64* %11, align 8, !dbg !212, !tbaa !173
  %72 = icmp ult i64 %65, %71, !dbg !213
  br i1 %72, label %75, label %73, !dbg !214

73:                                               ; preds = %70
  %74 = add nuw nsw i64 %68, 1, !dbg !215
  store i64 %74, i64* %13, align 8, !dbg !215, !tbaa !173
  br label %75

75:                                               ; preds = %61, %70, %73
  %76 = phi i32 [ 2, %73 ], [ 1, %70 ], [ 1, %61 ], !dbg !154
  call void @llvm.dbg.value(metadata i32 %76, metadata !144, metadata !DIExpression()), !dbg !154
  %77 = bitcast i32* %2 to i8*, !dbg !217
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %77), !dbg !217
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !222, metadata !DIExpression()) #3, !dbg !217
  call void @llvm.dbg.value(metadata i32 %76, metadata !223, metadata !DIExpression()) #3, !dbg !217
  store i32 %76, i32* %2, align 4, !tbaa !158
  call void @llvm.dbg.value(metadata i64 %4, metadata !224, metadata !DIExpression()) #3, !dbg !217
  call void @llvm.dbg.value(metadata i8* %14, metadata !225, metadata !DIExpression()) #3, !dbg !217
  call void @llvm.dbg.value(metadata i32* %2, metadata !223, metadata !DIExpression(DW_OP_deref)) #3, !dbg !217
  %78 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.4* @xdp_stats_map to i8*), i8* nonnull %77) #3, !dbg !228
  call void @llvm.dbg.value(metadata i8* %78, metadata !226, metadata !DIExpression()) #3, !dbg !217
  %79 = icmp eq i8* %78, null, !dbg !229
  br i1 %79, label %120, label %80, !dbg !231

80:                                               ; preds = %75
  %81 = bitcast i8* %78 to i64*, !dbg !232
  %82 = load i64, i64* %81, align 8, !dbg !233, !tbaa !234
  %83 = add i64 %82, 1, !dbg !233
  store i64 %83, i64* %81, align 8, !dbg !233, !tbaa !234
  %84 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !236
  %85 = load i32, i32* %84, align 4, !dbg !236, !tbaa !237
  %86 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !239
  %87 = load i32, i32* %86, align 4, !dbg !239, !tbaa !240
  %88 = sub i32 %85, %87, !dbg !241
  %89 = zext i32 %88 to i64, !dbg !242
  %90 = getelementptr inbounds i8, i8* %78, i64 8, !dbg !243
  %91 = bitcast i8* %90 to i64*, !dbg !243
  %92 = load i64, i64* %91, align 8, !dbg !244, !tbaa !245
  %93 = add i64 %92, %89, !dbg !244
  store i64 %93, i64* %91, align 8, !dbg !244, !tbaa !245
  %94 = load i64, i64* %39, align 8, !dbg !246, !tbaa !191
  %95 = icmp eq i64 %94, 1, !dbg !247
  %96 = select i1 %95, i8* %14, i8* %62, !dbg !248
  %97 = bitcast i8* %96 to i64*, !dbg !248
  %98 = load i64, i64* %97, align 8, !dbg !248, !tbaa !173
  %99 = getelementptr inbounds i8, i8* %78, i64 40, !dbg !249
  %100 = bitcast i8* %99 to i64*, !dbg !249
  store i64 %98, i64* %100, align 8, !dbg !250, !tbaa !251
  %101 = getelementptr inbounds i8, i8* %78, i64 48, !dbg !252
  %102 = bitcast i8* %101 to i64*, !dbg !252
  store i64 %94, i64* %102, align 8, !dbg !253, !tbaa !254
  %103 = getelementptr inbounds i8, i8* %78, i64 56, !dbg !255
  %104 = bitcast i8* %103 to i64*, !dbg !255
  store i64 %4, i64* %104, align 8, !dbg !256, !tbaa !257
  %105 = load i32, i32* %2, align 4, !dbg !258, !tbaa !158
  call void @llvm.dbg.value(metadata i32 %105, metadata !223, metadata !DIExpression()) #3, !dbg !217
  %106 = icmp eq i32 %105, 1, !dbg !260
  br i1 %106, label %112, label %107, !dbg !261

107:                                              ; preds = %80
  %108 = getelementptr inbounds i8, i8* %78, i64 16, !dbg !262
  %109 = bitcast i8* %108 to i64*, !dbg !262
  %110 = load i64, i64* %109, align 8, !dbg !264, !tbaa !265
  %111 = add i64 %110, 1, !dbg !264
  store i64 %111, i64* %109, align 8, !dbg !264, !tbaa !265
  br label %112

112:                                              ; preds = %80, %107
  %113 = phi i64 [ 24, %107 ], [ 32, %80 ]
  %114 = phi i64 [ %89, %107 ], [ 1, %80 ]
  %115 = phi i32 [ %105, %107 ], [ 1, %80 ]
  %116 = getelementptr inbounds i8, i8* %78, i64 %113, !dbg !266
  %117 = bitcast i8* %116 to i64*, !dbg !266
  %118 = load i64, i64* %117, align 8, !dbg !266, !tbaa !173
  %119 = add i64 %118, %114, !dbg !266
  store i64 %119, i64* %117, align 8, !dbg !266, !tbaa !173
  br label %120, !dbg !267

120:                                              ; preds = %112, %75
  %121 = phi i32 [ 0, %75 ], [ %115, %112 ], !dbg !217
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %77), !dbg !267
  br label %122

122:                                              ; preds = %1, %120
  %123 = phi i32 [ %121, %120 ], [ 0, %1 ], !dbg !154
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %5) #3, !dbg !268
  ret i32 %123, !dbg !268
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!126, !127, !128}
!llvm.ident = !{!129}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "window_start", scope: !2, file: !3, line: 52, type: !120, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "kern.c", directory: "/home/shrestha/btp/pktsniff/xdp/packet/redirecting/self_similar_analysis/c")
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
!14 = !{!15, !25, !34, !41, !47, !74, !0, !91, !104, !112}
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
!35 = distinct !DIGlobalVariable(name: "bpf_get_prandom_u32", scope: !2, file: !17, line: 193, type: !36, isLocal: true, isDefinition: true)
!36 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !37)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = !DISubroutineType(types: !39)
!39 = !{!40}
!40 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !23, line: 27, baseType: !7)
!41 = !DIGlobalVariableExpression(var: !42, expr: !DIExpression())
!42 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 151, type: !43, isLocal: false, isDefinition: true)
!43 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 32, elements: !45)
!44 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!45 = !{!46}
!46 = !DISubrange(count: 4)
!47 = !DIGlobalVariableExpression(var: !48, expr: !DIExpression())
!48 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 38, type: !49, isLocal: false, isDefinition: true)
!49 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 33, size: 256, elements: !50)
!50 = !{!51, !57, !59, !71}
!51 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !49, file: !3, line: 34, baseType: !52, size: 64)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DICompositeType(tag: DW_TAG_array_type, baseType: !54, size: 64, elements: !55)
!54 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!55 = !{!56}
!56 = !DISubrange(count: 2)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !49, file: !3, line: 35, baseType: !58, size: 64, offset: 64)
!58 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !49, file: !3, line: 36, baseType: !60, size: 64, offset: 128)
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !61, size: 64)
!61 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !3, line: 22, size: 512, elements: !62)
!62 = !{!63, !64, !65, !66, !67, !68, !69, !70}
!63 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !61, file: !3, line: 23, baseType: !22, size: 64)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !61, file: !3, line: 24, baseType: !22, size: 64, offset: 64)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "tx_packets", scope: !61, file: !3, line: 25, baseType: !22, size: 64, offset: 128)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "tx_bytes", scope: !61, file: !3, line: 26, baseType: !22, size: 64, offset: 192)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "dropped_packets", scope: !61, file: !3, line: 27, baseType: !22, size: 64, offset: 256)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "lambda", scope: !61, file: !3, line: 28, baseType: !22, size: 64, offset: 320)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "current_state", scope: !61, file: !3, line: 29, baseType: !22, size: 64, offset: 384)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "last_update", scope: !61, file: !3, line: 30, baseType: !22, size: 64, offset: 448)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !49, file: !3, line: 37, baseType: !72, size: 64, offset: 192)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !73, size: 64)
!73 = !DICompositeType(tag: DW_TAG_array_type, baseType: !54, size: 128, elements: !45)
!74 = !DIGlobalVariableExpression(var: !75, expr: !DIExpression())
!75 = distinct !DIGlobalVariable(name: "mmpp_sources", scope: !2, file: !3, line: 45, type: !76, isLocal: false, isDefinition: true)
!76 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 40, size: 256, elements: !77)
!77 = !{!78, !79, !80, !90}
!78 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !76, file: !3, line: 41, baseType: !52, size: 64)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !76, file: !3, line: 42, baseType: !58, size: 64, offset: 64)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !76, file: !3, line: 43, baseType: !81, size: 64, offset: 128)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!82 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "mmpp_source", file: !3, line: 13, size: 384, elements: !83)
!83 = !{!84, !85, !86, !87, !88, !89}
!84 = !DIDerivedType(tag: DW_TAG_member, name: "lambda1", scope: !82, file: !3, line: 14, baseType: !22, size: 64)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "lambda2", scope: !82, file: !3, line: 15, baseType: !22, size: 64, offset: 64)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "c1", scope: !82, file: !3, line: 16, baseType: !22, size: 64, offset: 128)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "c2", scope: !82, file: !3, line: 17, baseType: !22, size: 64, offset: 192)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "current_state", scope: !82, file: !3, line: 18, baseType: !22, size: 64, offset: 256)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "last_transition", scope: !82, file: !3, line: 19, baseType: !22, size: 64, offset: 320)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !76, file: !3, line: 44, baseType: !72, size: 64, offset: 192)
!91 = !DIGlobalVariableExpression(var: !92, expr: !DIExpression())
!92 = distinct !DIGlobalVariable(name: "packet_count", scope: !2, file: !3, line: 59, type: !93, isLocal: false, isDefinition: true)
!93 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 54, size: 256, elements: !94)
!94 = !{!95, !96, !97, !99}
!95 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !93, file: !3, line: 55, baseType: !52, size: 64)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !93, file: !3, line: 56, baseType: !58, size: 64, offset: 64)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !93, file: !3, line: 57, baseType: !98, size: 64, offset: 128)
!98 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !93, file: !3, line: 58, baseType: !100, size: 64, offset: 192)
!100 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !101, size: 64)
!101 = !DICompositeType(tag: DW_TAG_array_type, baseType: !54, size: 32, elements: !102)
!102 = !{!103}
!103 = !DISubrange(count: 1)
!104 = !DIGlobalVariableExpression(var: !105, expr: !DIExpression())
!105 = distinct !DIGlobalVariable(name: "average_count", scope: !2, file: !3, line: 66, type: !106, isLocal: false, isDefinition: true)
!106 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 61, size: 256, elements: !107)
!107 = !{!108, !109, !110, !111}
!108 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !106, file: !3, line: 62, baseType: !52, size: 64)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !106, file: !3, line: 63, baseType: !58, size: 64, offset: 64)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !106, file: !3, line: 64, baseType: !98, size: 64, offset: 128)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !106, file: !3, line: 65, baseType: !100, size: 64, offset: 192)
!112 = !DIGlobalVariableExpression(var: !113, expr: !DIExpression())
!113 = distinct !DIGlobalVariable(name: "queue_size", scope: !2, file: !3, line: 73, type: !114, isLocal: false, isDefinition: true)
!114 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 68, size: 256, elements: !115)
!115 = !{!116, !117, !118, !119}
!116 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !114, file: !3, line: 69, baseType: !52, size: 64)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !114, file: !3, line: 70, baseType: !58, size: 64, offset: 64)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !114, file: !3, line: 71, baseType: !98, size: 64, offset: 128)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !114, file: !3, line: 72, baseType: !100, size: 64, offset: 192)
!120 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 47, size: 256, elements: !121)
!121 = !{!122, !123, !124, !125}
!122 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !120, file: !3, line: 48, baseType: !52, size: 64)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !120, file: !3, line: 49, baseType: !58, size: 64, offset: 64)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !120, file: !3, line: 50, baseType: !98, size: 64, offset: 128)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !120, file: !3, line: 51, baseType: !100, size: 64, offset: 192)
!126 = !{i32 7, !"Dwarf Version", i32 4}
!127 = !{i32 2, !"Debug Info Version", i32 3}
!128 = !{i32 1, !"wchar_size", i32 4}
!129 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!130 = distinct !DISubprogram(name: "xdp_traffic_shaper", scope: !3, file: !3, line: 105, type: !131, scopeLine: 105, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !141)
!131 = !DISubroutineType(types: !132)
!132 = !{!54, !133}
!133 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !134, size: 64)
!134 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !135)
!135 = !{!136, !137, !138, !139, !140}
!136 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !134, file: !6, line: 3165, baseType: !40, size: 32)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !134, file: !6, line: 3166, baseType: !40, size: 32, offset: 32)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !134, file: !6, line: 3167, baseType: !40, size: 32, offset: 64)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !134, file: !6, line: 3169, baseType: !40, size: 32, offset: 96)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !134, file: !6, line: 3170, baseType: !40, size: 32, offset: 128)
!141 = !{!142, !143, !144, !145, !146, !147, !148, !149, !150, !151, !152, !153}
!142 = !DILocalVariable(name: "ctx", arg: 1, scope: !130, file: !3, line: 105, type: !133)
!143 = !DILocalVariable(name: "start", scope: !130, file: !3, line: 106, type: !22)
!144 = !DILocalVariable(name: "action", scope: !130, file: !3, line: 107, type: !40)
!145 = !DILocalVariable(name: "key", scope: !130, file: !3, line: 108, type: !40)
!146 = !DILocalVariable(name: "window_start_ptr", scope: !130, file: !3, line: 111, type: !98)
!147 = !DILocalVariable(name: "packet_count_ptr", scope: !130, file: !3, line: 112, type: !98)
!148 = !DILocalVariable(name: "average_count_ptr", scope: !130, file: !3, line: 113, type: !98)
!149 = !DILocalVariable(name: "queue_size_ptr", scope: !130, file: !3, line: 114, type: !98)
!150 = !DILocalVariable(name: "source", scope: !130, file: !3, line: 115, type: !81)
!151 = !DILocalVariable(name: "now", scope: !130, file: !3, line: 122, type: !22)
!152 = !DILocalVariable(name: "transition_prob", scope: !130, file: !3, line: 132, type: !22)
!153 = !DILocalVariable(name: "lambda", scope: !130, file: !3, line: 139, type: !22)
!154 = !DILocation(line: 0, scope: !130)
!155 = !DILocation(line: 106, column: 17, scope: !130)
!156 = !DILocation(line: 108, column: 3, scope: !130)
!157 = !DILocation(line: 108, column: 9, scope: !130)
!158 = !{!159, !159, i64 0}
!159 = !{!"int", !160, i64 0}
!160 = !{!"omnipotent char", !161, i64 0}
!161 = !{!"Simple C/C++ TBAA"}
!162 = !DILocation(line: 111, column: 29, scope: !130)
!163 = !DILocation(line: 112, column: 29, scope: !130)
!164 = !DILocation(line: 113, column: 30, scope: !130)
!165 = !DILocation(line: 114, column: 27, scope: !130)
!166 = !DILocation(line: 115, column: 32, scope: !130)
!167 = !DILocation(line: 117, column: 8, scope: !168)
!168 = distinct !DILexicalBlock(scope: !130, file: !3, line: 117, column: 7)
!169 = !DILocation(line: 117, column: 25, scope: !168)
!170 = !DILocation(line: 122, column: 15, scope: !130)
!171 = !DILocation(line: 123, column: 13, scope: !172)
!172 = distinct !DILexicalBlock(scope: !130, file: !3, line: 123, column: 7)
!173 = !{!174, !174, i64 0}
!174 = !{!"long long", !160, i64 0}
!175 = !DILocation(line: 123, column: 11, scope: !172)
!176 = !DILocation(line: 123, column: 31, scope: !172)
!177 = !DILocation(line: 123, column: 7, scope: !130)
!178 = !DILocation(line: 124, column: 23, scope: !179)
!179 = distinct !DILexicalBlock(scope: !172, file: !3, line: 123, column: 47)
!180 = !DILocation(line: 126, column: 10, scope: !179)
!181 = !DILocation(line: 126, column: 29, scope: !179)
!182 = !DILocation(line: 126, column: 52, scope: !179)
!183 = !DILocation(line: 126, column: 50, scope: !179)
!184 = !DILocation(line: 126, column: 71, scope: !179)
!185 = !DILocation(line: 125, column: 24, scope: !179)
!186 = !DILocation(line: 128, column: 23, scope: !179)
!187 = !DILocation(line: 129, column: 3, scope: !179)
!188 = !DILocation(line: 132, column: 27, scope: !130)
!189 = !DILocation(line: 133, column: 16, scope: !190)
!190 = distinct !DILexicalBlock(scope: !130, file: !3, line: 133, column: 7)
!191 = !{!192, !174, i64 32}
!192 = !{!"mmpp_source", !174, i64 0, !174, i64 8, !174, i64 16, !174, i64 24, !174, i64 32, !174, i64 40}
!193 = !DILocation(line: 133, column: 35, scope: !190)
!194 = !DILocation(line: 133, column: 64, scope: !190)
!195 = !{!192, !174, i64 24}
!196 = !DILocation(line: 133, column: 54, scope: !190)
!197 = !DILocation(line: 133, column: 68, scope: !190)
!198 = !DILocation(line: 139, column: 18, scope: !130)
!199 = !DILocation(line: 134, column: 64, scope: !190)
!200 = !{!192, !174, i64 16}
!201 = !DILocation(line: 134, column: 54, scope: !190)
!202 = !DILocation(line: 133, column: 7, scope: !130)
!203 = !DILocation(line: 135, column: 31, scope: !204)
!204 = distinct !DILexicalBlock(scope: !190, file: !3, line: 134, column: 69)
!205 = !DILocation(line: 135, column: 27, scope: !204)
!206 = !DILocation(line: 139, column: 40, scope: !130)
!207 = !DILocation(line: 141, column: 22, scope: !130)
!208 = !DILocation(line: 142, column: 7, scope: !209)
!209 = distinct !DILexicalBlock(scope: !130, file: !3, line: 142, column: 7)
!210 = !DILocation(line: 142, column: 23, scope: !209)
!211 = !DILocation(line: 142, column: 40, scope: !209)
!212 = !DILocation(line: 142, column: 52, scope: !209)
!213 = !DILocation(line: 142, column: 50, scope: !209)
!214 = !DILocation(line: 142, column: 7, scope: !130)
!215 = !DILocation(line: 145, column: 22, scope: !216)
!216 = distinct !DILexicalBlock(scope: !209, file: !3, line: 144, column: 10)
!217 = !DILocation(line: 0, scope: !218, inlinedAt: !227)
!218 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 78, type: !219, scopeLine: 79, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !221)
!219 = !DISubroutineType(types: !220)
!220 = !{!40, !133, !40, !22, !81}
!221 = !{!222, !223, !224, !225, !226}
!222 = !DILocalVariable(name: "ctx", arg: 1, scope: !218, file: !3, line: 79, type: !133)
!223 = !DILocalVariable(name: "action", arg: 2, scope: !218, file: !3, line: 79, type: !40)
!224 = !DILocalVariable(name: "start", arg: 3, scope: !218, file: !3, line: 79, type: !22)
!225 = !DILocalVariable(name: "source", arg: 4, scope: !218, file: !3, line: 79, type: !81)
!226 = !DILocalVariable(name: "rec", scope: !218, file: !3, line: 83, type: !60)
!227 = distinct !DILocation(line: 148, column: 10, scope: !130)
!228 = !DILocation(line: 83, column: 25, scope: !218, inlinedAt: !227)
!229 = !DILocation(line: 84, column: 8, scope: !230, inlinedAt: !227)
!230 = distinct !DILexicalBlock(scope: !218, file: !3, line: 84, column: 7)
!231 = !DILocation(line: 84, column: 7, scope: !218, inlinedAt: !227)
!232 = !DILocation(line: 87, column: 8, scope: !218, inlinedAt: !227)
!233 = !DILocation(line: 87, column: 18, scope: !218, inlinedAt: !227)
!234 = !{!235, !174, i64 0}
!235 = !{!"datarec", !174, i64 0, !174, i64 8, !174, i64 16, !174, i64 24, !174, i64 32, !174, i64 40, !174, i64 48, !174, i64 56}
!236 = !DILocation(line: 88, column: 26, scope: !218, inlinedAt: !227)
!237 = !{!238, !159, i64 4}
!238 = !{!"xdp_md", !159, i64 0, !159, i64 4, !159, i64 8, !159, i64 12, !159, i64 16}
!239 = !DILocation(line: 88, column: 42, scope: !218, inlinedAt: !227)
!240 = !{!238, !159, i64 0}
!241 = !DILocation(line: 88, column: 35, scope: !218, inlinedAt: !227)
!242 = !DILocation(line: 88, column: 20, scope: !218, inlinedAt: !227)
!243 = !DILocation(line: 88, column: 8, scope: !218, inlinedAt: !227)
!244 = !DILocation(line: 88, column: 17, scope: !218, inlinedAt: !227)
!245 = !{!235, !174, i64 8}
!246 = !DILocation(line: 90, column: 16, scope: !218, inlinedAt: !227)
!247 = !DILocation(line: 90, column: 30, scope: !218, inlinedAt: !227)
!248 = !DILocation(line: 90, column: 7, scope: !218, inlinedAt: !227)
!249 = !DILocation(line: 89, column: 8, scope: !218, inlinedAt: !227)
!250 = !DILocation(line: 89, column: 15, scope: !218, inlinedAt: !227)
!251 = !{!235, !174, i64 40}
!252 = !DILocation(line: 91, column: 8, scope: !218, inlinedAt: !227)
!253 = !DILocation(line: 91, column: 22, scope: !218, inlinedAt: !227)
!254 = !{!235, !174, i64 48}
!255 = !DILocation(line: 92, column: 8, scope: !218, inlinedAt: !227)
!256 = !DILocation(line: 92, column: 20, scope: !218, inlinedAt: !227)
!257 = !{!235, !174, i64 56}
!258 = !DILocation(line: 94, column: 7, scope: !259, inlinedAt: !227)
!259 = distinct !DILexicalBlock(scope: !218, file: !3, line: 94, column: 7)
!260 = !DILocation(line: 94, column: 14, scope: !259, inlinedAt: !227)
!261 = !DILocation(line: 94, column: 7, scope: !218, inlinedAt: !227)
!262 = !DILocation(line: 97, column: 10, scope: !263, inlinedAt: !227)
!263 = distinct !DILexicalBlock(scope: !259, file: !3, line: 96, column: 10)
!264 = !DILocation(line: 97, column: 20, scope: !263, inlinedAt: !227)
!265 = !{!235, !174, i64 16}
!266 = !DILocation(line: 0, scope: !259, inlinedAt: !227)
!267 = !DILocation(line: 102, column: 1, scope: !218, inlinedAt: !227)
!268 = !DILocation(line: 149, column: 1, scope: !130)
