; ModuleID = './continuous_traffic/c/kern.c'
source_filename = "./continuous_traffic/c/kern.c"
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
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !154, metadata !DIExpression()), !dbg !183
  %8 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !184
  call void @llvm.dbg.value(metadata i64 %8, metadata !155, metadata !DIExpression()), !dbg !183
  %9 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !185
  %10 = load i32, i32* %9, align 4, !dbg !185, !tbaa !186
  %11 = zext i32 %10 to i64, !dbg !191
  %12 = inttoptr i64 %11 to i8*, !dbg !192
  call void @llvm.dbg.value(metadata i8* %12, metadata !156, metadata !DIExpression()), !dbg !183
  %13 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !193
  %14 = load i32, i32* %13, align 4, !dbg !193, !tbaa !194
  %15 = zext i32 %14 to i64, !dbg !195
  %16 = inttoptr i64 %15 to i8*, !dbg !196
  call void @llvm.dbg.value(metadata i8* %16, metadata !157, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.value(metadata i32 2, metadata !170, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.value(metadata i64 50, metadata !171, metadata !DIExpression()), !dbg !183
  %17 = bitcast i32* %6 to i8*, !dbg !197
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %17) #3, !dbg !197
  call void @llvm.dbg.value(metadata i32 0, metadata !172, metadata !DIExpression()), !dbg !183
  store i32 0, i32* %6, align 4, !dbg !198, !tbaa !199
  call void @llvm.dbg.value(metadata i32* %6, metadata !172, metadata !DIExpression(DW_OP_deref)), !dbg !183
  %18 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %17) #3, !dbg !200
  call void @llvm.dbg.value(metadata i8* %18, metadata !173, metadata !DIExpression()), !dbg !183
  %19 = icmp eq i8* %18, null, !dbg !201
  br i1 %19, label %83, label %20, !dbg !203

20:                                               ; preds = %1
  %21 = bitcast i8* %18 to i64*, !dbg !200
  call void @llvm.dbg.value(metadata i64* %21, metadata !173, metadata !DIExpression()), !dbg !183
  %22 = bitcast i32* %3 to i8*, !dbg !204
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %22), !dbg !204
  %23 = bitcast i32* %4 to i8*, !dbg !204
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %23), !dbg !204
  call void @llvm.dbg.value(metadata i32 2, metadata !209, metadata !DIExpression()) #3, !dbg !204
  store i32 2, i32* %3, align 4, !tbaa !199
  call void @llvm.dbg.value(metadata i32* %3, metadata !209, metadata !DIExpression(DW_OP_deref)) #3, !dbg !204
  %24 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*), i8* nonnull %22) #3, !dbg !222
  call void @llvm.dbg.value(metadata i8* %24, metadata !210, metadata !DIExpression()) #3, !dbg !204
  %25 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* nonnull %22) #3, !dbg !223
  call void @llvm.dbg.value(metadata i8* %25, metadata !211, metadata !DIExpression()) #3, !dbg !204
  store i32 0, i32* %4, align 4, !dbg !224, !tbaa !199
  %26 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %23) #3, !dbg !225
  %27 = bitcast i8* %26 to i64*, !dbg !225
  call void @llvm.dbg.value(metadata i64* %27, metadata !212, metadata !DIExpression()) #3, !dbg !204
  %28 = icmp ne i8* %24, null, !dbg !226
  %29 = icmp ne i8* %25, null
  %30 = and i1 %28, %29, !dbg !228
  %31 = icmp ne i8* %26, null
  %32 = and i1 %30, %31, !dbg !228
  br i1 %32, label %33, label %52, !dbg !228

33:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i8* %25, metadata !211, metadata !DIExpression()) #3, !dbg !204
  %34 = getelementptr inbounds i8, i8* %25, i64 8, !dbg !229
  %35 = bitcast i8* %34 to i64*, !dbg !229
  %36 = load i64, i64* %35, align 8, !dbg !229, !tbaa !230
  call void @llvm.dbg.value(metadata i64 %36, metadata !213, metadata !DIExpression()) #3, !dbg !204
  %37 = icmp eq i64 %36, 0, !dbg !233
  br i1 %37, label %52, label %38, !dbg !234

38:                                               ; preds = %33
  %39 = bitcast i8* %24 to i64*, !dbg !235
  %40 = load i64, i64* %39, align 8, !dbg !235, !tbaa !236
  %41 = mul i64 %40, 1000000000, !dbg !238
  %42 = udiv i64 %41, %36, !dbg !239
  call void @llvm.dbg.value(metadata i64 %42, metadata !214, metadata !DIExpression()) #3, !dbg !240
  %43 = load i64, i64* %27, align 8, !dbg !241, !tbaa !242
  %44 = icmp ugt i64 %42, %43, !dbg !243
  br i1 %44, label %45, label %52, !dbg !244

45:                                               ; preds = %38
  %46 = bitcast i32* %5 to i8*, !dbg !245
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %46) #3, !dbg !245
  call void @llvm.dbg.value(metadata i32 0, metadata !217, metadata !DIExpression()) #3, !dbg !246
  store i32 0, i32* %5, align 4, !dbg !247, !tbaa !199
  call void @llvm.dbg.value(metadata i32* %5, metadata !217, metadata !DIExpression(DW_OP_deref)) #3, !dbg !246
  %47 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %46) #3, !dbg !248
  call void @llvm.dbg.value(metadata i8* %47, metadata !220, metadata !DIExpression()) #3, !dbg !246
  %48 = icmp eq i8* %47, null, !dbg !249
  br i1 %48, label %51, label %49, !dbg !251

49:                                               ; preds = %45
  %50 = bitcast i8* %47 to i64*, !dbg !248
  call void @llvm.dbg.value(metadata i64* %50, metadata !220, metadata !DIExpression()) #3, !dbg !246
  store i64 3000, i64* %50, align 8, !dbg !252, !tbaa !242
  br label %51, !dbg !254

51:                                               ; preds = %49, %45
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %46) #3, !dbg !255
  br label %52, !dbg !256

52:                                               ; preds = %20, %33, %38, %51
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %22), !dbg !257
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %23), !dbg !257
  %53 = load i64, i64* %21, align 8, !dbg !258, !tbaa !242
  call void @llvm.dbg.value(metadata i64 %53, metadata !259, metadata !DIExpression()), !dbg !267
  call void @llvm.dbg.value(metadata i64 50, metadata !264, metadata !DIExpression()), !dbg !267
  %54 = mul i64 %53, 998000, !dbg !269
  call void @llvm.dbg.value(metadata i64 %54, metadata !265, metadata !DIExpression()), !dbg !267
  call void @llvm.dbg.value(metadata i64 100000, metadata !266, metadata !DIExpression()), !dbg !267
  %55 = add i64 %54, 100000, !dbg !270
  %56 = udiv i64 %55, 1000000, !dbg !271
  call void @llvm.dbg.value(metadata i64 %56, metadata !174, metadata !DIExpression()), !dbg !183
  store i64 %56, i64* %7, align 8, !dbg !272, !tbaa !242
  %57 = bitcast i64* %7 to i8*, !dbg !273
  call void @llvm.dbg.value(metadata i32* %6, metadata !172, metadata !DIExpression(DW_OP_deref)), !dbg !183
  call void @llvm.dbg.value(metadata i64* %7, metadata !174, metadata !DIExpression(DW_OP_deref)), !dbg !183
  %58 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %17, i8* nonnull %57, i64 0) #3, !dbg !274
  %59 = load i64, i64* %7, align 8, !dbg !275, !tbaa !242
  call void @llvm.dbg.value(metadata i64 %59, metadata !174, metadata !DIExpression()), !dbg !183
  %60 = icmp ugt i64 %59, 4999, !dbg !276
  br i1 %60, label %83, label %61, !dbg !277

61:                                               ; preds = %52
  %62 = icmp ult i64 %59, 1001, !dbg !278
  br i1 %62, label %71, label %63, !dbg !279

63:                                               ; preds = %61
  %64 = trunc i64 %59 to i32, !dbg !280
  %65 = mul nuw nsw i32 %64, 100, !dbg !280
  %66 = add nsw i32 %65, -100000, !dbg !280
  %67 = udiv i32 %66, 4000, !dbg !280
  call void @llvm.dbg.value(metadata i32 %67, metadata !175, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !281
  %68 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !282
  %69 = urem i32 %68, 100, !dbg !284
  %70 = icmp ugt i32 %67, %69, !dbg !285
  call void @llvm.dbg.value(metadata i32 undef, metadata !170, metadata !DIExpression()), !dbg !183
  br i1 %70, label %83, label %71

71:                                               ; preds = %63, %61
  call void @llvm.dbg.value(metadata i32 2, metadata !170, metadata !DIExpression()), !dbg !183
  %72 = getelementptr i8, i8* %16, i64 14, !dbg !286
  %73 = icmp ugt i8* %72, %12, !dbg !288
  br i1 %73, label %122, label %74, !dbg !289

74:                                               ; preds = %71
  %75 = inttoptr i64 %15 to %struct.ethhdr*, !dbg !290
  call void @llvm.dbg.value(metadata %struct.ethhdr* %75, metadata !158, metadata !DIExpression()), !dbg !183
  %76 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %75, i64 0, i32 1, i64 0, !dbg !291
  %77 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @redirect_params to i8*), i8* nonnull %76) #3, !dbg !292
  call void @llvm.dbg.value(metadata i8* %77, metadata !179, metadata !DIExpression()), !dbg !183
  %78 = icmp eq i8* %77, null, !dbg !293
  br i1 %78, label %83, label %79, !dbg !295

79:                                               ; preds = %74
  %80 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %75, i64 0, i32 0, i64 0, !dbg !296
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %80, i8* nonnull align 1 dereferenceable(6) %77, i64 6, i1 false), !dbg !296
  call void @llvm.dbg.value(metadata i32* %6, metadata !172, metadata !DIExpression(DW_OP_deref)), !dbg !183
  %81 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i8* nonnull %17) #3, !dbg !297
  call void @llvm.dbg.value(metadata i8* %81, metadata !181, metadata !DIExpression()), !dbg !183
  %82 = icmp eq i8* %81, null, !dbg !298
  br i1 %82, label %83, label %86, !dbg !300

83:                                               ; preds = %79, %74, %63, %1, %52
  %84 = phi i32 [ 1, %52 ], [ 1, %1 ], [ 1, %63 ], [ 2, %74 ], [ 2, %79 ]
  call void @llvm.dbg.value(metadata i32 %91, metadata !170, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.label(metadata !182), !dbg !301
  %85 = bitcast i32* %2 to i8*, !dbg !302
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %85), !dbg !302
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !307, metadata !DIExpression()) #3, !dbg !302
  call void @llvm.dbg.value(metadata i32 %91, metadata !308, metadata !DIExpression()) #3, !dbg !302
  store i32 %84, i32* %2, align 4, !tbaa !199
  call void @llvm.dbg.value(metadata i64 %8, metadata !309, metadata !DIExpression()) #3, !dbg !302
  br label %94, !dbg !313

86:                                               ; preds = %79
  %87 = bitcast i8* %81 to i32*, !dbg !297
  call void @llvm.dbg.value(metadata i32* %87, metadata !181, metadata !DIExpression()), !dbg !183
  %88 = load i32, i32* %87, align 4, !dbg !314, !tbaa !199
  %89 = zext i32 %88 to i64, !dbg !314
  %90 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i64 %89, i64 0) #3, !dbg !315
  %91 = trunc i64 %90 to i32, !dbg !315
  call void @llvm.dbg.value(metadata i32 %91, metadata !170, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.label(metadata !182), !dbg !301
  %92 = bitcast i32* %2 to i8*, !dbg !302
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %92), !dbg !302
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !307, metadata !DIExpression()) #3, !dbg !302
  call void @llvm.dbg.value(metadata i32 %91, metadata !308, metadata !DIExpression()) #3, !dbg !302
  store i32 %91, i32* %2, align 4, !tbaa !199
  call void @llvm.dbg.value(metadata i64 %8, metadata !309, metadata !DIExpression()) #3, !dbg !302
  %93 = icmp ugt i32 %91, 4, !dbg !316
  br i1 %93, label %119, label %94, !dbg !313

94:                                               ; preds = %83, %86
  %95 = phi i8* [ %85, %83 ], [ %92, %86 ]
  call void @llvm.dbg.value(metadata i32* %2, metadata !308, metadata !DIExpression(DW_OP_deref)) #3, !dbg !302
  %96 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*), i8* nonnull %95) #3, !dbg !318
  call void @llvm.dbg.value(metadata i8* %96, metadata !310, metadata !DIExpression()) #3, !dbg !302
  %97 = icmp eq i8* %96, null, !dbg !319
  br i1 %97, label %119, label %98, !dbg !321

98:                                               ; preds = %94
  call void @llvm.dbg.value(metadata i8* %96, metadata !310, metadata !DIExpression()) #3, !dbg !302
  %99 = bitcast i8* %96 to i64*, !dbg !322
  %100 = load i64, i64* %99, align 8, !dbg !323, !tbaa !236
  %101 = add i64 %100, 1, !dbg !323
  store i64 %101, i64* %99, align 8, !dbg !323, !tbaa !236
  %102 = load i32, i32* %9, align 4, !dbg !324, !tbaa !186
  %103 = load i32, i32* %13, align 4, !dbg !325, !tbaa !194
  %104 = sub i32 %102, %103, !dbg !326
  %105 = zext i32 %104 to i64, !dbg !327
  %106 = getelementptr inbounds i8, i8* %96, i64 8, !dbg !328
  %107 = bitcast i8* %106 to i64*, !dbg !328
  %108 = load i64, i64* %107, align 8, !dbg !329, !tbaa !330
  %109 = add i64 %108, %105, !dbg !329
  store i64 %109, i64* %107, align 8, !dbg !329, !tbaa !330
  call void @llvm.dbg.value(metadata i32* %2, metadata !308, metadata !DIExpression(DW_OP_deref)) #3, !dbg !302
  %110 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* nonnull %95) #3, !dbg !331
  call void @llvm.dbg.value(metadata i8* %110, metadata !311, metadata !DIExpression()) #3, !dbg !302
  %111 = icmp eq i8* %110, null, !dbg !332
  br i1 %111, label %119, label %112, !dbg !334

112:                                              ; preds = %98
  call void @llvm.dbg.value(metadata i8* %110, metadata !311, metadata !DIExpression()) #3, !dbg !302
  %113 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !335
  %114 = bitcast i8* %110 to i64*, !dbg !336
  store i64 %113, i64* %114, align 8, !dbg !337, !tbaa !338
  %115 = sub i64 %113, %8, !dbg !339
  %116 = getelementptr inbounds i8, i8* %110, i64 8, !dbg !340
  %117 = bitcast i8* %116 to i64*, !dbg !340
  store i64 %115, i64* %117, align 8, !dbg !341, !tbaa !230
  %118 = load i32, i32* %2, align 4, !dbg !342, !tbaa !199
  call void @llvm.dbg.value(metadata i32 %118, metadata !308, metadata !DIExpression()) #3, !dbg !302
  br label %119, !dbg !343

119:                                              ; preds = %86, %94, %98, %112
  %120 = phi i8* [ %92, %86 ], [ %95, %94 ], [ %95, %112 ], [ %95, %98 ]
  %121 = phi i32 [ 0, %86 ], [ 0, %94 ], [ %118, %112 ], [ 0, %98 ], !dbg !302
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %120), !dbg !344
  br label %122, !dbg !345

122:                                              ; preds = %71, %119
  %123 = phi i32 [ %121, %119 ], [ 1, %71 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %17) #3, !dbg !346
  ret i32 %123, !dbg !346
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
!1 = distinct !DIGlobalVariable(name: "queue_avg_map", scope: !2, file: !57, line: 65, type: !131, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !17, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "continuous_traffic/c/kern.c", directory: "/home/shrestha/btp/designs/eBPF")
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
!56 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !57, line: 191, type: !58, isLocal: false, isDefinition: true)
!57 = !DIFile(filename: "./continuous_traffic/c/kern.c", directory: "/home/shrestha/btp/designs/eBPF")
!58 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 32, elements: !60)
!59 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!60 = !{!61}
!61 = !DISubrange(count: 4)
!62 = !DIGlobalVariableExpression(var: !63, expr: !DIExpression())
!63 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !57, line: 37, type: !64, isLocal: false, isDefinition: true)
!64 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !57, line: 32, size: 256, elements: !65)
!65 = !{!66, !72, !74, !80}
!66 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !64, file: !57, line: 33, baseType: !67, size: 64)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !68, size: 64)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 64, elements: !70)
!69 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!70 = !{!71}
!71 = !DISubrange(count: 2)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !64, file: !57, line: 34, baseType: !73, size: 64, offset: 64)
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !64, file: !57, line: 35, baseType: !75, size: 64, offset: 128)
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !76, size: 64)
!76 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !57, line: 22, size: 128, elements: !77)
!77 = !{!78, !79}
!78 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !76, file: !57, line: 23, baseType: !25, size: 64)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !76, file: !57, line: 24, baseType: !25, size: 64, offset: 64)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !64, file: !57, line: 36, baseType: !81, size: 64, offset: 192)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!82 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 160, elements: !83)
!83 = !{!84}
!84 = !DISubrange(count: 5)
!85 = !DIGlobalVariableExpression(var: !86, expr: !DIExpression())
!86 = distinct !DIGlobalVariable(name: "telemetry_stats_map", scope: !2, file: !57, line: 44, type: !87, isLocal: false, isDefinition: true)
!87 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !57, line: 39, size: 256, elements: !88)
!88 = !{!89, !90, !91, !97}
!89 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !87, file: !57, line: 40, baseType: !67, size: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !87, file: !57, line: 41, baseType: !73, size: 64, offset: 64)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !87, file: !57, line: 42, baseType: !92, size: 64, offset: 128)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !93, size: 64)
!93 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "telrec", file: !57, line: 27, size: 128, elements: !94)
!94 = !{!95, !96}
!95 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !93, file: !57, line: 28, baseType: !25, size: 64)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time", scope: !93, file: !57, line: 29, baseType: !25, size: 64, offset: 64)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !87, file: !57, line: 43, baseType: !81, size: 64, offset: 192)
!98 = !DIGlobalVariableExpression(var: !99, expr: !DIExpression())
!99 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !57, line: 51, type: !100, isLocal: false, isDefinition: true)
!100 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !57, line: 46, size: 256, elements: !101)
!101 = !{!102, !107, !108, !109}
!102 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !100, file: !57, line: 47, baseType: !103, size: 64)
!103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!104 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 448, elements: !105)
!105 = !{!106}
!106 = !DISubrange(count: 14)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !100, file: !57, line: 48, baseType: !73, size: 64, offset: 64)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !100, file: !57, line: 49, baseType: !73, size: 64, offset: 128)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !100, file: !57, line: 50, baseType: !110, size: 64, offset: 192)
!110 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !111, size: 64)
!111 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 8192, elements: !112)
!112 = !{!113}
!113 = !DISubrange(count: 256)
!114 = !DIGlobalVariableExpression(var: !115, expr: !DIExpression())
!115 = distinct !DIGlobalVariable(name: "redirect_params", scope: !2, file: !57, line: 58, type: !116, isLocal: false, isDefinition: true)
!116 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !57, line: 53, size: 256, elements: !117)
!117 = !{!118, !123, !129, !130}
!118 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !116, file: !57, line: 54, baseType: !119, size: 64)
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!120 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 32, elements: !121)
!121 = !{!122}
!122 = !DISubrange(count: 1)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !116, file: !57, line: 55, baseType: !124, size: 64, offset: 64)
!124 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 64)
!125 = !DICompositeType(tag: DW_TAG_array_type, baseType: !126, size: 48, elements: !127)
!126 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!127 = !{!128}
!128 = !DISubrange(count: 6)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !116, file: !57, line: 56, baseType: !124, size: 64, offset: 128)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !116, file: !57, line: 57, baseType: !119, size: 64, offset: 192)
!131 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !57, line: 60, size: 256, elements: !132)
!132 = !{!133, !134, !135, !137}
!133 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !131, file: !57, line: 61, baseType: !67, size: 64)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !131, file: !57, line: 62, baseType: !73, size: 64, offset: 64)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !131, file: !57, line: 63, baseType: !136, size: 64, offset: 128)
!136 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !131, file: !57, line: 64, baseType: !119, size: 64, offset: 192)
!138 = !{i32 7, !"Dwarf Version", i32 4}
!139 = !{i32 2, !"Debug Info Version", i32 3}
!140 = !{i32 1, !"wchar_size", i32 4}
!141 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!142 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !57, file: !57, line: 129, type: !143, scopeLine: 129, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !153)
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
!154 = !DILocalVariable(name: "ctx", arg: 1, scope: !142, file: !57, line: 129, type: !145)
!155 = !DILocalVariable(name: "start", scope: !142, file: !57, line: 130, type: !25)
!156 = !DILocalVariable(name: "data_end", scope: !142, file: !57, line: 132, type: !15)
!157 = !DILocalVariable(name: "data", scope: !142, file: !57, line: 133, type: !15)
!158 = !DILocalVariable(name: "eth", scope: !142, file: !57, line: 135, type: !159)
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
!170 = !DILocalVariable(name: "action", scope: !142, file: !57, line: 136, type: !48)
!171 = !DILocalVariable(name: "queue_len", scope: !142, file: !57, line: 137, type: !25)
!172 = !DILocalVariable(name: "key", scope: !142, file: !57, line: 138, type: !48)
!173 = !DILocalVariable(name: "prev_avg", scope: !142, file: !57, line: 140, type: !136)
!174 = !DILocalVariable(name: "new_avg", scope: !142, file: !57, line: 148, type: !25)
!175 = !DILocalVariable(name: "drop_prob", scope: !176, file: !57, line: 158, type: !25)
!176 = distinct !DILexicalBlock(scope: !177, file: !57, line: 156, column: 10)
!177 = distinct !DILexicalBlock(scope: !178, file: !57, line: 154, column: 14)
!178 = distinct !DILexicalBlock(scope: !142, file: !57, line: 151, column: 7)
!179 = !DILocalVariable(name: "dst", scope: !142, file: !57, line: 174, type: !180)
!180 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !126, size: 64)
!181 = !DILocalVariable(name: "iface_index", scope: !142, file: !57, line: 181, type: !73)
!182 = !DILabel(scope: !142, name: "out", file: !57, line: 187)
!183 = !DILocation(line: 0, scope: !142)
!184 = !DILocation(line: 130, column: 17, scope: !142)
!185 = !DILocation(line: 132, column: 39, scope: !142)
!186 = !{!187, !188, i64 4}
!187 = !{!"xdp_md", !188, i64 0, !188, i64 4, !188, i64 8, !188, i64 12, !188, i64 16}
!188 = !{!"int", !189, i64 0}
!189 = !{!"omnipotent char", !190, i64 0}
!190 = !{!"Simple C/C++ TBAA"}
!191 = !DILocation(line: 132, column: 28, scope: !142)
!192 = !DILocation(line: 132, column: 20, scope: !142)
!193 = !DILocation(line: 133, column: 35, scope: !142)
!194 = !{!187, !188, i64 0}
!195 = !DILocation(line: 133, column: 24, scope: !142)
!196 = !DILocation(line: 133, column: 16, scope: !142)
!197 = !DILocation(line: 138, column: 3, scope: !142)
!198 = !DILocation(line: 138, column: 9, scope: !142)
!199 = !{!188, !188, i64 0}
!200 = !DILocation(line: 140, column: 21, scope: !142)
!201 = !DILocation(line: 141, column: 8, scope: !202)
!202 = distinct !DILexicalBlock(scope: !142, file: !57, line: 141, column: 7)
!203 = !DILocation(line: 141, column: 7, scope: !142)
!204 = !DILocation(line: 0, scope: !205, inlinedAt: !221)
!205 = distinct !DISubprogram(name: "handle_burst_detection", scope: !57, file: !57, line: 76, type: !206, scopeLine: 76, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !208)
!206 = !DISubroutineType(types: !207)
!207 = !{null, !48}
!208 = !{!209, !210, !211, !212, !213, !214, !217, !220}
!209 = !DILocalVariable(name: "action", arg: 1, scope: !205, file: !57, line: 76, type: !48)
!210 = !DILocalVariable(name: "stats", scope: !205, file: !57, line: 77, type: !75)
!211 = !DILocalVariable(name: "telemetry", scope: !205, file: !57, line: 78, type: !92)
!212 = !DILocalVariable(name: "initial_queue_len", scope: !205, file: !57, line: 79, type: !136)
!213 = !DILocalVariable(name: "delta_time", scope: !205, file: !57, line: 84, type: !25)
!214 = !DILocalVariable(name: "rps", scope: !215, file: !57, line: 88, type: !25)
!215 = distinct !DILexicalBlock(scope: !216, file: !57, line: 87, column: 23)
!216 = distinct !DILexicalBlock(scope: !205, file: !57, line: 87, column: 7)
!217 = !DILocalVariable(name: "key", scope: !218, file: !57, line: 95, type: !48)
!218 = distinct !DILexicalBlock(scope: !219, file: !57, line: 93, column: 35)
!219 = distinct !DILexicalBlock(scope: !215, file: !57, line: 93, column: 9)
!220 = !DILocalVariable(name: "queue_len", scope: !218, file: !57, line: 96, type: !136)
!221 = distinct !DILocation(line: 146, column: 3, scope: !142)
!222 = !DILocation(line: 77, column: 27, scope: !205, inlinedAt: !221)
!223 = !DILocation(line: 78, column: 30, scope: !205, inlinedAt: !221)
!224 = !DILocation(line: 79, column: 67, scope: !205, inlinedAt: !221)
!225 = !DILocation(line: 79, column: 30, scope: !205, inlinedAt: !221)
!226 = !DILocation(line: 81, column: 8, scope: !227, inlinedAt: !221)
!227 = distinct !DILexicalBlock(scope: !205, file: !57, line: 81, column: 7)
!228 = !DILocation(line: 81, column: 14, scope: !227, inlinedAt: !221)
!229 = !DILocation(line: 84, column: 33, scope: !205, inlinedAt: !221)
!230 = !{!231, !232, i64 8}
!231 = !{!"telrec", !232, i64 0, !232, i64 8}
!232 = !{!"long long", !189, i64 0}
!233 = !DILocation(line: 87, column: 18, scope: !216, inlinedAt: !221)
!234 = !DILocation(line: 87, column: 7, scope: !205, inlinedAt: !221)
!235 = !DILocation(line: 88, column: 24, scope: !215, inlinedAt: !221)
!236 = !{!237, !232, i64 0}
!237 = !{!"datarec", !232, i64 0, !232, i64 8}
!238 = !DILocation(line: 88, column: 35, scope: !215, inlinedAt: !221)
!239 = !DILocation(line: 88, column: 48, scope: !215, inlinedAt: !221)
!240 = !DILocation(line: 0, scope: !215, inlinedAt: !221)
!241 = !DILocation(line: 93, column: 15, scope: !219, inlinedAt: !221)
!242 = !{!232, !232, i64 0}
!243 = !DILocation(line: 93, column: 13, scope: !219, inlinedAt: !221)
!244 = !DILocation(line: 93, column: 9, scope: !215, inlinedAt: !221)
!245 = !DILocation(line: 95, column: 7, scope: !218, inlinedAt: !221)
!246 = !DILocation(line: 0, scope: !218, inlinedAt: !221)
!247 = !DILocation(line: 95, column: 13, scope: !218, inlinedAt: !221)
!248 = !DILocation(line: 96, column: 26, scope: !218, inlinedAt: !221)
!249 = !DILocation(line: 97, column: 11, scope: !250, inlinedAt: !221)
!250 = distinct !DILexicalBlock(scope: !218, file: !57, line: 97, column: 11)
!251 = !DILocation(line: 97, column: 11, scope: !218, inlinedAt: !221)
!252 = !DILocation(line: 98, column: 20, scope: !253, inlinedAt: !221)
!253 = distinct !DILexicalBlock(scope: !250, file: !57, line: 97, column: 22)
!254 = !DILocation(line: 99, column: 7, scope: !253, inlinedAt: !221)
!255 = !DILocation(line: 100, column: 5, scope: !219, inlinedAt: !221)
!256 = !DILocation(line: 100, column: 5, scope: !218, inlinedAt: !221)
!257 = !DILocation(line: 102, column: 1, scope: !205, inlinedAt: !221)
!258 = !DILocation(line: 148, column: 43, scope: !142)
!259 = !DILocalVariable(name: "prev_avg", arg: 1, scope: !260, file: !57, line: 67, type: !25)
!260 = distinct !DISubprogram(name: "calculate_avg_queue_len", scope: !57, file: !57, line: 67, type: !261, scopeLine: 68, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !263)
!261 = !DISubroutineType(types: !262)
!262 = !{!25, !25, !25}
!263 = !{!259, !264, !265, !266}
!264 = !DILocalVariable(name: "curr_queue_len", arg: 2, scope: !260, file: !57, line: 68, type: !25)
!265 = !DILocalVariable(name: "weighted_prev_avg", scope: !260, file: !57, line: 71, type: !25)
!266 = !DILocalVariable(name: "weighted_curr_len", scope: !260, file: !57, line: 72, type: !25)
!267 = !DILocation(line: 0, scope: !260, inlinedAt: !268)
!268 = distinct !DILocation(line: 148, column: 19, scope: !142)
!269 = !DILocation(line: 71, column: 55, scope: !260, inlinedAt: !268)
!270 = !DILocation(line: 73, column: 29, scope: !260, inlinedAt: !268)
!271 = !DILocation(line: 73, column: 50, scope: !260, inlinedAt: !268)
!272 = !DILocation(line: 148, column: 9, scope: !142)
!273 = !DILocation(line: 149, column: 45, scope: !142)
!274 = !DILocation(line: 149, column: 3, scope: !142)
!275 = !DILocation(line: 151, column: 7, scope: !178)
!276 = !DILocation(line: 151, column: 15, scope: !178)
!277 = !DILocation(line: 151, column: 7, scope: !142)
!278 = !DILocation(line: 154, column: 22, scope: !177)
!279 = !DILocation(line: 154, column: 14, scope: !178)
!280 = !DILocation(line: 158, column: 66, scope: !176)
!281 = !DILocation(line: 0, scope: !176)
!282 = !DILocation(line: 162, column: 9, scope: !283)
!283 = distinct !DILexicalBlock(scope: !176, file: !57, line: 162, column: 9)
!284 = !DILocation(line: 162, column: 31, scope: !283)
!285 = !DILocation(line: 162, column: 37, scope: !283)
!286 = !DILocation(line: 169, column: 12, scope: !287)
!287 = distinct !DILexicalBlock(scope: !142, file: !57, line: 169, column: 7)
!288 = !DILocation(line: 169, column: 36, scope: !287)
!289 = !DILocation(line: 169, column: 7, scope: !142)
!290 = !DILocation(line: 172, column: 9, scope: !142)
!291 = !DILocation(line: 174, column: 62, scope: !142)
!292 = !DILocation(line: 174, column: 24, scope: !142)
!293 = !DILocation(line: 175, column: 8, scope: !294)
!294 = distinct !DILexicalBlock(scope: !142, file: !57, line: 175, column: 7)
!295 = !DILocation(line: 175, column: 7, scope: !142)
!296 = !DILocation(line: 179, column: 3, scope: !142)
!297 = !DILocation(line: 181, column: 24, scope: !142)
!298 = !DILocation(line: 182, column: 8, scope: !299)
!299 = distinct !DILexicalBlock(scope: !142, file: !57, line: 182, column: 7)
!300 = !DILocation(line: 182, column: 7, scope: !142)
!301 = !DILocation(line: 187, column: 1, scope: !142)
!302 = !DILocation(line: 0, scope: !303, inlinedAt: !312)
!303 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !57, file: !57, line: 104, type: !304, scopeLine: 106, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !306)
!304 = !DISubroutineType(types: !305)
!305 = !{!48, !145, !48, !25}
!306 = !{!307, !308, !309, !310, !311}
!307 = !DILocalVariable(name: "ctx", arg: 1, scope: !303, file: !57, line: 104, type: !145)
!308 = !DILocalVariable(name: "action", arg: 2, scope: !303, file: !57, line: 105, type: !48)
!309 = !DILocalVariable(name: "start", arg: 3, scope: !303, file: !57, line: 106, type: !25)
!310 = !DILocalVariable(name: "rec", scope: !303, file: !57, line: 110, type: !75)
!311 = !DILocalVariable(name: "telemetry", scope: !303, file: !57, line: 118, type: !92)
!312 = distinct !DILocation(line: 188, column: 10, scope: !142)
!313 = !DILocation(line: 107, column: 7, scope: !303, inlinedAt: !312)
!314 = !DILocation(line: 185, column: 39, scope: !142)
!315 = !DILocation(line: 185, column: 12, scope: !142)
!316 = !DILocation(line: 107, column: 14, scope: !317, inlinedAt: !312)
!317 = distinct !DILexicalBlock(scope: !303, file: !57, line: 107, column: 7)
!318 = !DILocation(line: 110, column: 25, scope: !303, inlinedAt: !312)
!319 = !DILocation(line: 111, column: 8, scope: !320, inlinedAt: !312)
!320 = distinct !DILexicalBlock(scope: !303, file: !57, line: 111, column: 7)
!321 = !DILocation(line: 111, column: 7, scope: !303, inlinedAt: !312)
!322 = !DILocation(line: 115, column: 8, scope: !303, inlinedAt: !312)
!323 = !DILocation(line: 115, column: 18, scope: !303, inlinedAt: !312)
!324 = !DILocation(line: 116, column: 26, scope: !303, inlinedAt: !312)
!325 = !DILocation(line: 116, column: 42, scope: !303, inlinedAt: !312)
!326 = !DILocation(line: 116, column: 35, scope: !303, inlinedAt: !312)
!327 = !DILocation(line: 116, column: 20, scope: !303, inlinedAt: !312)
!328 = !DILocation(line: 116, column: 8, scope: !303, inlinedAt: !312)
!329 = !DILocation(line: 116, column: 17, scope: !303, inlinedAt: !312)
!330 = !{!237, !232, i64 8}
!331 = !DILocation(line: 118, column: 30, scope: !303, inlinedAt: !312)
!332 = !DILocation(line: 119, column: 8, scope: !333, inlinedAt: !312)
!333 = distinct !DILexicalBlock(scope: !303, file: !57, line: 119, column: 7)
!334 = !DILocation(line: 119, column: 7, scope: !303, inlinedAt: !312)
!335 = !DILocation(line: 122, column: 26, scope: !303, inlinedAt: !312)
!336 = !DILocation(line: 122, column: 14, scope: !303, inlinedAt: !312)
!337 = !DILocation(line: 122, column: 24, scope: !303, inlinedAt: !312)
!338 = !{!231, !232, i64 0}
!339 = !DILocation(line: 123, column: 53, scope: !303, inlinedAt: !312)
!340 = !DILocation(line: 123, column: 14, scope: !303, inlinedAt: !312)
!341 = !DILocation(line: 123, column: 30, scope: !303, inlinedAt: !312)
!342 = !DILocation(line: 125, column: 10, scope: !303, inlinedAt: !312)
!343 = !DILocation(line: 125, column: 3, scope: !303, inlinedAt: !312)
!344 = !DILocation(line: 126, column: 1, scope: !303, inlinedAt: !312)
!345 = !DILocation(line: 188, column: 3, scope: !142)
!346 = !DILocation(line: 189, column: 1, scope: !142)
