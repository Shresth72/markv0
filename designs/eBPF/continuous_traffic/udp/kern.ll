; ModuleID = 'continuous_traffic/udp/kern.c'
source_filename = "continuous_traffic/udp/kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.0 = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.1 = type { [2 x i32]*, i32*, %struct.datarec*, [5 x i32]* }
%struct.datarec = type { i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@ipat_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@queue_avg_map = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !107
@xdp_stats_map = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !84
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !78
@llvm.used = appending global [5 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @ipat_map to i8*), i8* bitcast (%struct.anon.0* @queue_avg_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_redirect_map_func to i8*), i8* bitcast (%struct.anon.1* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_redirect_map_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_redirect_map" !dbg !130 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !142, metadata !DIExpression()), !dbg !205
  %7 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !206
  call void @llvm.dbg.value(metadata i64 %7, metadata !143, metadata !DIExpression()), !dbg !205
  %8 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !207
  %9 = load i32, i32* %8, align 4, !dbg !207, !tbaa !208
  %10 = zext i32 %9 to i64, !dbg !213
  %11 = inttoptr i64 %10 to i8*, !dbg !214
  call void @llvm.dbg.value(metadata i8* %11, metadata !144, metadata !DIExpression()), !dbg !205
  %12 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !215
  %13 = load i32, i32* %12, align 4, !dbg !215, !tbaa !216
  %14 = zext i32 %13 to i64, !dbg !217
  %15 = inttoptr i64 %14 to i8*, !dbg !218
  call void @llvm.dbg.value(metadata i8* %15, metadata !145, metadata !DIExpression()), !dbg !205
  %16 = bitcast i32* %3 to i8*, !dbg !219
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %16) #3, !dbg !219
  call void @llvm.dbg.value(metadata i32 2, metadata !190, metadata !DIExpression()), !dbg !205
  store i32 2, i32* %3, align 4, !dbg !220, !tbaa !221
  call void @llvm.dbg.value(metadata i64 50, metadata !191, metadata !DIExpression()), !dbg !205
  %17 = bitcast i32* %4 to i8*, !dbg !222
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %17) #3, !dbg !222
  call void @llvm.dbg.value(metadata i32 0, metadata !192, metadata !DIExpression()), !dbg !205
  store i32 0, i32* %4, align 4, !dbg !223, !tbaa !221
  %18 = getelementptr i8, i8* %15, i64 14, !dbg !224
  %19 = icmp ugt i8* %18, %11, !dbg !226
  br i1 %19, label %97, label %20, !dbg !227

20:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* %15, metadata !146, metadata !DIExpression()), !dbg !205
  call void @llvm.dbg.value(metadata i8* %18, metadata !162, metadata !DIExpression()), !dbg !205
  %21 = getelementptr i8, i8* %15, i64 34, !dbg !228
  %22 = icmp ugt i8* %21, %11, !dbg !230
  br i1 %22, label %97, label %23, !dbg !231

23:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i8* %18, metadata !162, metadata !DIExpression()), !dbg !205
  %24 = getelementptr i8, i8* %15, i64 23, !dbg !232
  %25 = load i8, i8* %24, align 1, !dbg !232, !tbaa !233
  %26 = icmp eq i8 %25, 17, !dbg !236
  br i1 %26, label %27, label %97, !dbg !237

27:                                               ; preds = %23
  %28 = load i8, i8* %18, align 4, !dbg !238
  %29 = shl i8 %28, 2, !dbg !239
  %30 = and i8 %29, 60, !dbg !239
  %31 = zext i8 %30 to i64
  %32 = getelementptr i8, i8* %18, i64 %31, !dbg !240
  call void @llvm.dbg.value(metadata i8* %32, metadata !181, metadata !DIExpression()), !dbg !205
  %33 = getelementptr inbounds i8, i8* %32, i64 8, !dbg !241
  %34 = icmp ugt i8* %33, %11, !dbg !243
  br i1 %34, label %97, label %35, !dbg !244

35:                                               ; preds = %27
  call void @llvm.dbg.value(metadata i32* %4, metadata !192, metadata !DIExpression(DW_OP_deref)), !dbg !205
  %36 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @ipat_map to i8*), i8* nonnull %17) #3, !dbg !245
  call void @llvm.dbg.value(metadata i8* %36, metadata !193, metadata !DIExpression()), !dbg !205
  %37 = bitcast i64* %5 to i8*, !dbg !246
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %37) #3, !dbg !246
  %38 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !247
  call void @llvm.dbg.value(metadata i64 %38, metadata !194, metadata !DIExpression()), !dbg !205
  store i64 %38, i64* %5, align 8, !dbg !248, !tbaa !249
  call void @llvm.dbg.value(metadata i64 0, metadata !195, metadata !DIExpression()), !dbg !205
  %39 = icmp eq i8* %36, null, !dbg !251
  br i1 %39, label %44, label %40, !dbg !253

40:                                               ; preds = %35
  %41 = bitcast i8* %36 to i64*, !dbg !245
  call void @llvm.dbg.value(metadata i64* %41, metadata !193, metadata !DIExpression()), !dbg !205
  %42 = load i64, i64* %41, align 8, !dbg !254, !tbaa !249
  %43 = sub i64 %38, %42, !dbg !256
  call void @llvm.dbg.value(metadata i64 %43, metadata !195, metadata !DIExpression()), !dbg !205
  call void @llvm.dbg.value(metadata i32* %4, metadata !192, metadata !DIExpression(DW_OP_deref)), !dbg !205
  call void @llvm.dbg.value(metadata i64* %5, metadata !194, metadata !DIExpression(DW_OP_deref)), !dbg !205
  br label %44, !dbg !257

44:                                               ; preds = %35, %40
  %45 = phi i64 [ %43, %40 ], [ 0, %35 ], !dbg !205
  %46 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon* @ipat_map to i8*), i8* nonnull %17, i8* nonnull %37, i64 0) #3, !dbg !258
  call void @llvm.dbg.value(metadata i64 %45, metadata !195, metadata !DIExpression()), !dbg !205
  call void @llvm.dbg.value(metadata i32* %4, metadata !192, metadata !DIExpression(DW_OP_deref)), !dbg !205
  %47 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @queue_avg_map to i8*), i8* nonnull %17) #3, !dbg !259
  call void @llvm.dbg.value(metadata i8* %47, metadata !196, metadata !DIExpression()), !dbg !205
  %48 = icmp eq i8* %47, null, !dbg !260
  br i1 %48, label %49, label %50, !dbg !262

49:                                               ; preds = %44
  call void @llvm.dbg.value(metadata i32 1, metadata !190, metadata !DIExpression()), !dbg !205
  store i32 1, i32* %3, align 4, !dbg !263, !tbaa !221
  br label %95, !dbg !265

50:                                               ; preds = %44
  %51 = bitcast i8* %47 to i64*, !dbg !259
  call void @llvm.dbg.value(metadata i64* %51, metadata !196, metadata !DIExpression()), !dbg !205
  %52 = load i64, i64* %51, align 8, !dbg !266, !tbaa !249
  call void @llvm.dbg.value(metadata i64 %52, metadata !267, metadata !DIExpression()), !dbg !275
  call void @llvm.dbg.value(metadata i64 50, metadata !272, metadata !DIExpression()), !dbg !275
  %53 = mul i64 %52, 998000, !dbg !277
  call void @llvm.dbg.value(metadata i64 %53, metadata !273, metadata !DIExpression()), !dbg !275
  call void @llvm.dbg.value(metadata i64 100000, metadata !274, metadata !DIExpression()), !dbg !275
  %54 = add i64 %53, 100000, !dbg !278
  %55 = udiv i64 %54, 1000000, !dbg !279
  call void @llvm.dbg.value(metadata i64 %55, metadata !197, metadata !DIExpression()), !dbg !205
  store i64 %55, i64* %6, align 8, !dbg !280, !tbaa !249
  %56 = bitcast i64* %6 to i8*, !dbg !281
  call void @llvm.dbg.value(metadata i32* %4, metadata !192, metadata !DIExpression(DW_OP_deref)), !dbg !205
  call void @llvm.dbg.value(metadata i64* %6, metadata !197, metadata !DIExpression(DW_OP_deref)), !dbg !205
  %57 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.0* @queue_avg_map to i8*), i8* nonnull %17, i8* nonnull %56, i64 0) #3, !dbg !282
  call void @llvm.dbg.value(metadata i32* %3, metadata !190, metadata !DIExpression(DW_OP_deref)), !dbg !205
  %58 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @xdp_stats_map to i8*), i8* nonnull %16) #3, !dbg !283
  call void @llvm.dbg.value(metadata i8* %58, metadata !198, metadata !DIExpression()), !dbg !205
  %59 = icmp eq i8* %58, null, !dbg !284
  br i1 %59, label %60, label %61, !dbg !286

60:                                               ; preds = %50
  call void @llvm.dbg.value(metadata i32 1, metadata !190, metadata !DIExpression()), !dbg !205
  store i32 1, i32* %3, align 4, !dbg !287, !tbaa !221
  br label %95, !dbg !289

61:                                               ; preds = %50
  call void @llvm.dbg.value(metadata i8* %58, metadata !198, metadata !DIExpression()), !dbg !205
  %62 = bitcast i8* %58 to i64*, !dbg !290
  %63 = load i64, i64* %62, align 8, !dbg !290, !tbaa !291
  %64 = load i64, i64* %5, align 8, !dbg !293, !tbaa !249
  call void @llvm.dbg.value(metadata i64 %64, metadata !194, metadata !DIExpression()), !dbg !205
  call void @llvm.dbg.value(metadata i64 undef, metadata !199, metadata !DIExpression()), !dbg !205
  call void @llvm.dbg.value(metadata i64 undef, metadata !294, metadata !DIExpression()) #3, !dbg !302
  call void @llvm.dbg.value(metadata i64 %45, metadata !299, metadata !DIExpression()) #3, !dbg !302
  %65 = bitcast i32* %2 to i8*, !dbg !304
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %65) #3, !dbg !304
  call void @llvm.dbg.value(metadata i32 0, metadata !300, metadata !DIExpression()) #3, !dbg !302
  store i32 0, i32* %2, align 4, !dbg !305, !tbaa !221
  call void @llvm.dbg.value(metadata i32* %2, metadata !300, metadata !DIExpression(DW_OP_deref)) #3, !dbg !302
  %66 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @queue_avg_map to i8*), i8* nonnull %65) #3, !dbg !306
  %67 = bitcast i8* %66 to i64*, !dbg !306
  call void @llvm.dbg.value(metadata i64* %67, metadata !301, metadata !DIExpression()) #3, !dbg !302
  %68 = icmp eq i8* %66, null, !dbg !307
  br i1 %68, label %77, label %69, !dbg !309

69:                                               ; preds = %61
  %70 = mul i64 %63, 1000000000, !dbg !310
  %71 = sub i64 %64, %7, !dbg !311
  %72 = udiv i64 %70, %71, !dbg !312
  call void @llvm.dbg.value(metadata i64 %72, metadata !294, metadata !DIExpression()) #3, !dbg !302
  call void @llvm.dbg.value(metadata i64 %72, metadata !199, metadata !DIExpression()), !dbg !205
  %73 = icmp ugt i64 %72, 200, !dbg !313
  %74 = icmp ult i64 %45, 10000
  %75 = or i1 %74, %73, !dbg !315
  br i1 %75, label %76, label %77, !dbg !315

76:                                               ; preds = %69
  store i64 3000, i64* %67, align 8, !dbg !316, !tbaa !249
  br label %77, !dbg !318

77:                                               ; preds = %61, %69, %76
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %65) #3, !dbg !319
  %78 = load i64, i64* %6, align 8, !dbg !320, !tbaa !249
  call void @llvm.dbg.value(metadata i64 %78, metadata !197, metadata !DIExpression()), !dbg !205
  %79 = icmp ugt i64 %78, 4999, !dbg !321
  br i1 %79, label %80, label %81, !dbg !322

80:                                               ; preds = %77
  call void @llvm.dbg.value(metadata i32 1, metadata !190, metadata !DIExpression()), !dbg !205
  store i32 1, i32* %3, align 4, !dbg !323, !tbaa !221
  br label %95, !dbg !325

81:                                               ; preds = %77
  %82 = icmp ult i64 %78, 1001, !dbg !326
  br i1 %82, label %83, label %84, !dbg !327

83:                                               ; preds = %81
  call void @llvm.dbg.value(metadata i32 2, metadata !190, metadata !DIExpression()), !dbg !205
  store i32 2, i32* %3, align 4, !dbg !328, !tbaa !221
  br label %95, !dbg !330

84:                                               ; preds = %81
  %85 = trunc i64 %78 to i32, !dbg !331
  %86 = mul nuw nsw i32 %85, 100, !dbg !331
  %87 = add nsw i32 %86, -100000, !dbg !331
  %88 = udiv i32 %87, 4000, !dbg !331
  call void @llvm.dbg.value(metadata i32 %88, metadata !200, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !332
  %89 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !333
  %90 = urem i32 %89, 100, !dbg !335
  %91 = icmp ugt i32 %88, %90, !dbg !336
  br i1 %91, label %94, label %92, !dbg !337

92:                                               ; preds = %84
  %93 = load i32, i32* %3, align 4, !dbg !338, !tbaa !221
  br label %95, !dbg !337

94:                                               ; preds = %84
  call void @llvm.dbg.value(metadata i32 1, metadata !190, metadata !DIExpression()), !dbg !205
  store i32 1, i32* %3, align 4, !dbg !339, !tbaa !221
  br label %95, !dbg !341

95:                                               ; preds = %92, %94, %83, %80, %60, %49
  %96 = phi i32 [ %93, %92 ], [ 1, %94 ], [ 2, %83 ], [ 1, %80 ], [ 1, %60 ], [ 1, %49 ], !dbg !338
  call void @llvm.dbg.label(metadata !204), !dbg !342
  call void @llvm.dbg.value(metadata i32 %96, metadata !190, metadata !DIExpression()), !dbg !205
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %37) #3, !dbg !343
  br label %97

97:                                               ; preds = %27, %20, %23, %1, %95
  %98 = phi i32 [ %96, %95 ], [ 1, %1 ], [ 2, %23 ], [ 2, %20 ], [ 1, %27 ], !dbg !205
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %17) #3, !dbg !343
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %16) #3, !dbg !343
  ret i32 %98, !dbg !343
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #2

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
!1 = distinct !DIGlobalVariable(name: "ipat_map", scope: !2, file: !3, line: 64, type: !120, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !43, globals: !46, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "continuous_traffic/udp/kern.c", directory: "/home/shrestha/btp/designs/eBPF")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 3153, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !15, line: 28, baseType: !7, size: 32, elements: !16)
!15 = !DIFile(filename: "/usr/include/linux/in.h", directory: "")
!16 = !{!17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42}
!17 = !DIEnumerator(name: "IPPROTO_IP", value: 0, isUnsigned: true)
!18 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1, isUnsigned: true)
!19 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2, isUnsigned: true)
!20 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4, isUnsigned: true)
!21 = !DIEnumerator(name: "IPPROTO_TCP", value: 6, isUnsigned: true)
!22 = !DIEnumerator(name: "IPPROTO_EGP", value: 8, isUnsigned: true)
!23 = !DIEnumerator(name: "IPPROTO_PUP", value: 12, isUnsigned: true)
!24 = !DIEnumerator(name: "IPPROTO_UDP", value: 17, isUnsigned: true)
!25 = !DIEnumerator(name: "IPPROTO_IDP", value: 22, isUnsigned: true)
!26 = !DIEnumerator(name: "IPPROTO_TP", value: 29, isUnsigned: true)
!27 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33, isUnsigned: true)
!28 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41, isUnsigned: true)
!29 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46, isUnsigned: true)
!30 = !DIEnumerator(name: "IPPROTO_GRE", value: 47, isUnsigned: true)
!31 = !DIEnumerator(name: "IPPROTO_ESP", value: 50, isUnsigned: true)
!32 = !DIEnumerator(name: "IPPROTO_AH", value: 51, isUnsigned: true)
!33 = !DIEnumerator(name: "IPPROTO_MTP", value: 92, isUnsigned: true)
!34 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94, isUnsigned: true)
!35 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98, isUnsigned: true)
!36 = !DIEnumerator(name: "IPPROTO_PIM", value: 103, isUnsigned: true)
!37 = !DIEnumerator(name: "IPPROTO_COMP", value: 108, isUnsigned: true)
!38 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132, isUnsigned: true)
!39 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136, isUnsigned: true)
!40 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137, isUnsigned: true)
!41 = !DIEnumerator(name: "IPPROTO_RAW", value: 255, isUnsigned: true)
!42 = !DIEnumerator(name: "IPPROTO_MAX", value: 256, isUnsigned: true)
!43 = !{!44, !45}
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!45 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!46 = !{!47, !57, !65, !71, !78, !84, !107, !0}
!47 = !DIGlobalVariableExpression(var: !48, expr: !DIExpression())
!48 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !49, line: 114, type: !50, isLocal: true, isDefinition: true)
!49 = !DIFile(filename: "/usr/local/include/bpf/bpf_helper_defs.h", directory: "")
!50 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !51)
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!52 = !DISubroutineType(types: !53)
!53 = !{!54}
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !55, line: 31, baseType: !56)
!55 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!56 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!57 = !DIGlobalVariableExpression(var: !58, expr: !DIExpression())
!58 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !49, line: 56, type: !59, isLocal: true, isDefinition: true)
!59 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !60)
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !61, size: 64)
!61 = !DISubroutineType(types: !62)
!62 = !{!44, !44, !63}
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!65 = !DIGlobalVariableExpression(var: !66, expr: !DIExpression())
!66 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !49, line: 78, type: !67, isLocal: true, isDefinition: true)
!67 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !68)
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DISubroutineType(types: !70)
!70 = !{!45, !44, !63, !63, !54}
!71 = !DIGlobalVariableExpression(var: !72, expr: !DIExpression())
!72 = distinct !DIGlobalVariable(name: "bpf_get_prandom_u32", scope: !2, file: !49, line: 193, type: !73, isLocal: true, isDefinition: true)
!73 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !74)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DISubroutineType(types: !76)
!76 = !{!77}
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !55, line: 27, baseType: !7)
!78 = !DIGlobalVariableExpression(var: !79, expr: !DIExpression())
!79 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 164, type: !80, isLocal: false, isDefinition: true)
!80 = !DICompositeType(tag: DW_TAG_array_type, baseType: !81, size: 32, elements: !82)
!81 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!82 = !{!83}
!83 = !DISubrange(count: 4)
!84 = !DIGlobalVariableExpression(var: !85, expr: !DIExpression())
!85 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 50, type: !86, isLocal: false, isDefinition: true)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 45, size: 256, elements: !87)
!87 = !{!88, !94, !96, !102}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !86, file: !3, line: 46, baseType: !89, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!90 = !DICompositeType(tag: DW_TAG_array_type, baseType: !91, size: 64, elements: !92)
!91 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!92 = !{!93}
!93 = !DISubrange(count: 2)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !86, file: !3, line: 47, baseType: !95, size: 64, offset: 64)
!95 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !77, size: 64)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !86, file: !3, line: 48, baseType: !97, size: 64, offset: 128)
!97 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !98, size: 64)
!98 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !3, line: 35, size: 128, elements: !99)
!99 = !{!100, !101}
!100 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !98, file: !3, line: 36, baseType: !54, size: 64)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !98, file: !3, line: 37, baseType: !54, size: 64, offset: 64)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !86, file: !3, line: 49, baseType: !103, size: 64, offset: 192)
!103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!104 = !DICompositeType(tag: DW_TAG_array_type, baseType: !91, size: 160, elements: !105)
!105 = !{!106}
!106 = !DISubrange(count: 5)
!107 = !DIGlobalVariableExpression(var: !108, expr: !DIExpression())
!108 = distinct !DIGlobalVariable(name: "queue_avg_map", scope: !2, file: !3, line: 57, type: !109, isLocal: false, isDefinition: true)
!109 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 52, size: 256, elements: !110)
!110 = !{!111, !112, !113, !115}
!111 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !109, file: !3, line: 53, baseType: !89, size: 64)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !109, file: !3, line: 54, baseType: !95, size: 64, offset: 64)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !109, file: !3, line: 55, baseType: !114, size: 64, offset: 128)
!114 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !109, file: !3, line: 56, baseType: !116, size: 64, offset: 192)
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!117 = !DICompositeType(tag: DW_TAG_array_type, baseType: !91, size: 32, elements: !118)
!118 = !{!119}
!119 = !DISubrange(count: 1)
!120 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 59, size: 256, elements: !121)
!121 = !{!122, !123, !124, !125}
!122 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !120, file: !3, line: 60, baseType: !89, size: 64)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !120, file: !3, line: 61, baseType: !95, size: 64, offset: 64)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !120, file: !3, line: 62, baseType: !114, size: 64, offset: 128)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !120, file: !3, line: 63, baseType: !116, size: 64, offset: 192)
!126 = !{i32 7, !"Dwarf Version", i32 4}
!127 = !{i32 2, !"Debug Info Version", i32 3}
!128 = !{i32 1, !"wchar_size", i32 4}
!129 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!130 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !3, file: !3, line: 86, type: !131, scopeLine: 86, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !141)
!131 = !DISubroutineType(types: !132)
!132 = !{!91, !133}
!133 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !134, size: 64)
!134 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !135)
!135 = !{!136, !137, !138, !139, !140}
!136 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !134, file: !6, line: 3165, baseType: !77, size: 32)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !134, file: !6, line: 3166, baseType: !77, size: 32, offset: 32)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !134, file: !6, line: 3167, baseType: !77, size: 32, offset: 64)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !134, file: !6, line: 3169, baseType: !77, size: 32, offset: 96)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !134, file: !6, line: 3170, baseType: !77, size: 32, offset: 128)
!141 = !{!142, !143, !144, !145, !146, !162, !181, !190, !191, !192, !193, !194, !195, !196, !197, !198, !199, !200, !204}
!142 = !DILocalVariable(name: "ctx", arg: 1, scope: !130, file: !3, line: 86, type: !133)
!143 = !DILocalVariable(name: "start", scope: !130, file: !3, line: 87, type: !54)
!144 = !DILocalVariable(name: "data_end", scope: !130, file: !3, line: 89, type: !44)
!145 = !DILocalVariable(name: "data", scope: !130, file: !3, line: 90, type: !44)
!146 = !DILocalVariable(name: "eth", scope: !130, file: !3, line: 92, type: !147)
!147 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !148, size: 64)
!148 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !149, line: 163, size: 112, elements: !150)
!149 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!150 = !{!151, !156, !157}
!151 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !148, file: !149, line: 164, baseType: !152, size: 48)
!152 = !DICompositeType(tag: DW_TAG_array_type, baseType: !153, size: 48, elements: !154)
!153 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!154 = !{!155}
!155 = !DISubrange(count: 6)
!156 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !148, file: !149, line: 165, baseType: !152, size: 48, offset: 48)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !148, file: !149, line: 166, baseType: !158, size: 16, offset: 96)
!158 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !159, line: 25, baseType: !160)
!159 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!160 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !55, line: 24, baseType: !161)
!161 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!162 = !DILocalVariable(name: "ip", scope: !130, file: !3, line: 93, type: !163)
!163 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !164, size: 64)
!164 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !165, line: 86, size: 160, elements: !166)
!165 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!166 = !{!167, !169, !170, !171, !172, !173, !174, !175, !176, !178, !180}
!167 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !164, file: !165, line: 88, baseType: !168, size: 4, flags: DIFlagBitField, extraData: i64 0)
!168 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !55, line: 21, baseType: !153)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !164, file: !165, line: 89, baseType: !168, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !164, file: !165, line: 96, baseType: !168, size: 8, offset: 8)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !164, file: !165, line: 97, baseType: !158, size: 16, offset: 16)
!172 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !164, file: !165, line: 98, baseType: !158, size: 16, offset: 32)
!173 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !164, file: !165, line: 99, baseType: !158, size: 16, offset: 48)
!174 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !164, file: !165, line: 100, baseType: !168, size: 8, offset: 64)
!175 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !164, file: !165, line: 101, baseType: !168, size: 8, offset: 72)
!176 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !164, file: !165, line: 102, baseType: !177, size: 16, offset: 80)
!177 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !159, line: 31, baseType: !160)
!178 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !164, file: !165, line: 103, baseType: !179, size: 32, offset: 96)
!179 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !159, line: 27, baseType: !77)
!180 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !164, file: !165, line: 104, baseType: !179, size: 32, offset: 128)
!181 = !DILocalVariable(name: "udp", scope: !130, file: !3, line: 94, type: !182)
!182 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !183, size: 64)
!183 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "udphdr", file: !184, line: 23, size: 64, elements: !185)
!184 = !DIFile(filename: "/usr/include/linux/udp.h", directory: "")
!185 = !{!186, !187, !188, !189}
!186 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !183, file: !184, line: 24, baseType: !158, size: 16)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !183, file: !184, line: 25, baseType: !158, size: 16, offset: 16)
!188 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !183, file: !184, line: 26, baseType: !158, size: 16, offset: 32)
!189 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !183, file: !184, line: 27, baseType: !177, size: 16, offset: 48)
!190 = !DILocalVariable(name: "action", scope: !130, file: !3, line: 96, type: !77)
!191 = !DILocalVariable(name: "queue_len", scope: !130, file: !3, line: 97, type: !54)
!192 = !DILocalVariable(name: "key", scope: !130, file: !3, line: 98, type: !77)
!193 = !DILocalVariable(name: "last_timestamp", scope: !130, file: !3, line: 116, type: !114)
!194 = !DILocalVariable(name: "current_time", scope: !130, file: !3, line: 117, type: !54)
!195 = !DILocalVariable(name: "ipat", scope: !130, file: !3, line: 118, type: !54)
!196 = !DILocalVariable(name: "prev_avg", scope: !130, file: !3, line: 128, type: !114)
!197 = !DILocalVariable(name: "new_avg", scope: !130, file: !3, line: 134, type: !54)
!198 = !DILocalVariable(name: "stats", scope: !130, file: !3, line: 138, type: !97)
!199 = !DILocalVariable(name: "rps", scope: !130, file: !3, line: 143, type: !54)
!200 = !DILocalVariable(name: "drop_prob", scope: !201, file: !3, line: 152, type: !54)
!201 = distinct !DILexicalBlock(scope: !202, file: !3, line: 151, column: 10)
!202 = distinct !DILexicalBlock(scope: !203, file: !3, line: 149, column: 14)
!203 = distinct !DILexicalBlock(scope: !130, file: !3, line: 146, column: 7)
!204 = !DILabel(scope: !130, name: "out", file: !3, line: 160)
!205 = !DILocation(line: 0, scope: !130)
!206 = !DILocation(line: 87, column: 17, scope: !130)
!207 = !DILocation(line: 89, column: 39, scope: !130)
!208 = !{!209, !210, i64 4}
!209 = !{!"xdp_md", !210, i64 0, !210, i64 4, !210, i64 8, !210, i64 12, !210, i64 16}
!210 = !{!"int", !211, i64 0}
!211 = !{!"omnipotent char", !212, i64 0}
!212 = !{!"Simple C/C++ TBAA"}
!213 = !DILocation(line: 89, column: 28, scope: !130)
!214 = !DILocation(line: 89, column: 20, scope: !130)
!215 = !DILocation(line: 90, column: 35, scope: !130)
!216 = !{!209, !210, i64 0}
!217 = !DILocation(line: 90, column: 24, scope: !130)
!218 = !DILocation(line: 90, column: 16, scope: !130)
!219 = !DILocation(line: 96, column: 3, scope: !130)
!220 = !DILocation(line: 96, column: 9, scope: !130)
!221 = !{!210, !210, i64 0}
!222 = !DILocation(line: 98, column: 3, scope: !130)
!223 = !DILocation(line: 98, column: 9, scope: !130)
!224 = !DILocation(line: 101, column: 12, scope: !225)
!225 = distinct !DILexicalBlock(scope: !130, file: !3, line: 101, column: 7)
!226 = !DILocation(line: 101, column: 36, scope: !225)
!227 = !DILocation(line: 101, column: 7, scope: !130)
!228 = !DILocation(line: 107, column: 19, scope: !229)
!229 = distinct !DILexicalBlock(scope: !130, file: !3, line: 107, column: 7)
!230 = !DILocation(line: 107, column: 24, scope: !229)
!231 = !DILocation(line: 107, column: 35, scope: !229)
!232 = !DILocation(line: 107, column: 42, scope: !229)
!233 = !{!234, !211, i64 9}
!234 = !{!"iphdr", !211, i64 0, !211, i64 0, !211, i64 1, !235, i64 2, !235, i64 4, !235, i64 6, !211, i64 8, !211, i64 9, !235, i64 10, !210, i64 12, !210, i64 16}
!235 = !{!"short", !211, i64 0}
!236 = !DILocation(line: 107, column: 51, scope: !229)
!237 = !DILocation(line: 107, column: 7, scope: !130)
!238 = !DILocation(line: 111, column: 27, scope: !130)
!239 = !DILocation(line: 111, column: 31, scope: !130)
!240 = !DILocation(line: 111, column: 20, scope: !130)
!241 = !DILocation(line: 112, column: 20, scope: !242)
!242 = distinct !DILexicalBlock(scope: !130, file: !3, line: 112, column: 7)
!243 = !DILocation(line: 112, column: 25, scope: !242)
!244 = !DILocation(line: 112, column: 7, scope: !130)
!245 = !DILocation(line: 116, column: 27, scope: !130)
!246 = !DILocation(line: 117, column: 3, scope: !130)
!247 = !DILocation(line: 117, column: 24, scope: !130)
!248 = !DILocation(line: 117, column: 9, scope: !130)
!249 = !{!250, !250, i64 0}
!250 = !{!"long long", !211, i64 0}
!251 = !DILocation(line: 120, column: 7, scope: !252)
!252 = distinct !DILexicalBlock(scope: !130, file: !3, line: 120, column: 7)
!253 = !DILocation(line: 120, column: 7, scope: !130)
!254 = !DILocation(line: 121, column: 27, scope: !255)
!255 = distinct !DILexicalBlock(scope: !252, file: !3, line: 120, column: 23)
!256 = !DILocation(line: 121, column: 25, scope: !255)
!257 = !DILocation(line: 123, column: 3, scope: !255)
!258 = !DILocation(line: 0, scope: !252)
!259 = !DILocation(line: 128, column: 21, scope: !130)
!260 = !DILocation(line: 129, column: 8, scope: !261)
!261 = distinct !DILexicalBlock(scope: !130, file: !3, line: 129, column: 7)
!262 = !DILocation(line: 129, column: 7, scope: !130)
!263 = !DILocation(line: 130, column: 12, scope: !264)
!264 = distinct !DILexicalBlock(scope: !261, file: !3, line: 129, column: 18)
!265 = !DILocation(line: 131, column: 5, scope: !264)
!266 = !DILocation(line: 134, column: 43, scope: !130)
!267 = !DILocalVariable(name: "prev_avg", arg: 1, scope: !268, file: !3, line: 66, type: !54)
!268 = distinct !DISubprogram(name: "calculate_avg_queue_len", scope: !3, file: !3, line: 66, type: !269, scopeLine: 67, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !271)
!269 = !DISubroutineType(types: !270)
!270 = !{!54, !54, !54}
!271 = !{!267, !272, !273, !274}
!272 = !DILocalVariable(name: "curr_queue_len", arg: 2, scope: !268, file: !3, line: 67, type: !54)
!273 = !DILocalVariable(name: "weighted_prev_avg", scope: !268, file: !3, line: 68, type: !54)
!274 = !DILocalVariable(name: "weighted_curr_len", scope: !268, file: !3, line: 69, type: !54)
!275 = !DILocation(line: 0, scope: !268, inlinedAt: !276)
!276 = distinct !DILocation(line: 134, column: 19, scope: !130)
!277 = !DILocation(line: 68, column: 55, scope: !268, inlinedAt: !276)
!278 = !DILocation(line: 70, column: 29, scope: !268, inlinedAt: !276)
!279 = !DILocation(line: 70, column: 50, scope: !268, inlinedAt: !276)
!280 = !DILocation(line: 134, column: 9, scope: !130)
!281 = !DILocation(line: 135, column: 45, scope: !130)
!282 = !DILocation(line: 135, column: 3, scope: !130)
!283 = !DILocation(line: 138, column: 27, scope: !130)
!284 = !DILocation(line: 139, column: 8, scope: !285)
!285 = distinct !DILexicalBlock(scope: !130, file: !3, line: 139, column: 7)
!286 = !DILocation(line: 139, column: 7, scope: !130)
!287 = !DILocation(line: 140, column: 12, scope: !288)
!288 = distinct !DILexicalBlock(scope: !285, file: !3, line: 139, column: 15)
!289 = !DILocation(line: 141, column: 5, scope: !288)
!290 = !DILocation(line: 143, column: 22, scope: !130)
!291 = !{!292, !250, i64 0}
!292 = !{!"datarec", !250, i64 0, !250, i64 8}
!293 = !DILocation(line: 143, column: 49, scope: !130)
!294 = !DILocalVariable(name: "rps", arg: 1, scope: !295, file: !3, line: 73, type: !54)
!295 = distinct !DISubprogram(name: "handle_burst_detection", scope: !3, file: !3, line: 73, type: !296, scopeLine: 73, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !298)
!296 = !DISubroutineType(types: !297)
!297 = !{null, !54, !54}
!298 = !{!294, !299, !300, !301}
!299 = !DILocalVariable(name: "ipat", arg: 2, scope: !295, file: !3, line: 73, type: !54)
!300 = !DILocalVariable(name: "key", scope: !295, file: !3, line: 74, type: !77)
!301 = !DILocalVariable(name: "queue_len", scope: !295, file: !3, line: 75, type: !114)
!302 = !DILocation(line: 0, scope: !295, inlinedAt: !303)
!303 = distinct !DILocation(line: 144, column: 3, scope: !130)
!304 = !DILocation(line: 74, column: 3, scope: !295, inlinedAt: !303)
!305 = !DILocation(line: 74, column: 9, scope: !295, inlinedAt: !303)
!306 = !DILocation(line: 75, column: 22, scope: !295, inlinedAt: !303)
!307 = !DILocation(line: 76, column: 8, scope: !308, inlinedAt: !303)
!308 = distinct !DILexicalBlock(scope: !295, file: !3, line: 76, column: 7)
!309 = !DILocation(line: 76, column: 7, scope: !295, inlinedAt: !303)
!310 = !DILocation(line: 143, column: 33, scope: !130)
!311 = !DILocation(line: 143, column: 62, scope: !130)
!312 = !DILocation(line: 143, column: 46, scope: !130)
!313 = !DILocation(line: 80, column: 11, scope: !314, inlinedAt: !303)
!314 = distinct !DILexicalBlock(scope: !295, file: !3, line: 80, column: 7)
!315 = !DILocation(line: 80, column: 17, scope: !314, inlinedAt: !303)
!316 = !DILocation(line: 81, column: 16, scope: !317, inlinedAt: !303)
!317 = distinct !DILexicalBlock(scope: !314, file: !3, line: 80, column: 34)
!318 = !DILocation(line: 82, column: 3, scope: !317, inlinedAt: !303)
!319 = !DILocation(line: 83, column: 1, scope: !295, inlinedAt: !303)
!320 = !DILocation(line: 146, column: 7, scope: !203)
!321 = !DILocation(line: 146, column: 15, scope: !203)
!322 = !DILocation(line: 146, column: 7, scope: !130)
!323 = !DILocation(line: 147, column: 12, scope: !324)
!324 = distinct !DILexicalBlock(scope: !203, file: !3, line: 146, column: 34)
!325 = !DILocation(line: 148, column: 5, scope: !324)
!326 = !DILocation(line: 149, column: 22, scope: !202)
!327 = !DILocation(line: 149, column: 14, scope: !203)
!328 = !DILocation(line: 150, column: 12, scope: !329)
!329 = distinct !DILexicalBlock(scope: !202, file: !3, line: 149, column: 41)
!330 = !DILocation(line: 151, column: 3, scope: !329)
!331 = !DILocation(line: 152, column: 66, scope: !201)
!332 = !DILocation(line: 0, scope: !201)
!333 = !DILocation(line: 154, column: 9, scope: !334)
!334 = distinct !DILexicalBlock(scope: !201, file: !3, line: 154, column: 9)
!335 = !DILocation(line: 154, column: 31, scope: !334)
!336 = !DILocation(line: 154, column: 37, scope: !334)
!337 = !DILocation(line: 154, column: 9, scope: !201)
!338 = !DILocation(line: 161, column: 10, scope: !130)
!339 = !DILocation(line: 155, column: 14, scope: !340)
!340 = distinct !DILexicalBlock(scope: !334, file: !3, line: 154, column: 50)
!341 = !DILocation(line: 156, column: 7, scope: !340)
!342 = !DILocation(line: 160, column: 1, scope: !130)
!343 = !DILocation(line: 162, column: 1, scope: !130)
