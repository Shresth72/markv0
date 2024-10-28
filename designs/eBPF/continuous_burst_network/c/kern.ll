; ModuleID = 'continuous_burst_network/c/kern.c'
source_filename = "continuous_burst_network/c/kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.0 = type { [1 x i32]*, [6 x i8]*, [6 x i8]*, [1 x i32]* }
%struct.anon.1 = type { [14 x i32]*, i32*, i32*, [256 x i32]* }
%struct.anon.2 = type { [2 x i32]*, i32*, %struct.datarec*, [5 x i32]* }
%struct.datarec = type { i64, i64 }
%struct.anon.3 = type { [2 x i32]*, i32*, %struct.telrec*, [5 x i32]* }
%struct.telrec = type { i64, i64, i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@queue_avg_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@redirect_params = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !115
@tx_port = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !99
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !55
@xdp_stats_map = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !61
@telemetry_stats_map = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !84
@llvm.used = appending global [7 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* bitcast (%struct.anon.0* @redirect_params to i8*), i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* bitcast (%struct.anon.1* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_redirect_map_func to i8*), i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_redirect_map_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_redirect_map" !dbg !143 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !155, metadata !DIExpression()), !dbg !184
  %7 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !185
  call void @llvm.dbg.value(metadata i64 %7, metadata !156, metadata !DIExpression()), !dbg !184
  %8 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !186
  %9 = load i32, i32* %8, align 4, !dbg !186, !tbaa !187
  %10 = zext i32 %9 to i64, !dbg !192
  %11 = inttoptr i64 %10 to i8*, !dbg !193
  call void @llvm.dbg.value(metadata i8* %11, metadata !157, metadata !DIExpression()), !dbg !184
  %12 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !194
  %13 = load i32, i32* %12, align 4, !dbg !194, !tbaa !195
  %14 = zext i32 %13 to i64, !dbg !196
  %15 = inttoptr i64 %14 to i8*, !dbg !197
  call void @llvm.dbg.value(metadata i8* %15, metadata !158, metadata !DIExpression()), !dbg !184
  call void @llvm.dbg.value(metadata i32 2, metadata !171, metadata !DIExpression()), !dbg !184
  call void @llvm.dbg.value(metadata i64 50, metadata !172, metadata !DIExpression()), !dbg !184
  %16 = bitcast i32* %5 to i8*, !dbg !198
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %16) #3, !dbg !198
  call void @llvm.dbg.value(metadata i32 0, metadata !173, metadata !DIExpression()), !dbg !184
  store i32 0, i32* %5, align 4, !dbg !199, !tbaa !200
  call void @llvm.dbg.value(metadata i32* %5, metadata !173, metadata !DIExpression(DW_OP_deref)), !dbg !184
  %17 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %16) #3, !dbg !201
  call void @llvm.dbg.value(metadata i8* %17, metadata !174, metadata !DIExpression()), !dbg !184
  %18 = icmp eq i8* %17, null, !dbg !202
  br i1 %18, label %89, label %19, !dbg !204

19:                                               ; preds = %1
  %20 = bitcast i8* %17 to i64*, !dbg !201
  call void @llvm.dbg.value(metadata i64* %20, metadata !174, metadata !DIExpression()), !dbg !184
  %21 = bitcast i32* %3 to i8*, !dbg !205
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %21), !dbg !205
  %22 = bitcast i32* %4 to i8*, !dbg !205
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %22), !dbg !205
  call void @llvm.dbg.value(metadata i32 2, metadata !210, metadata !DIExpression()) #3, !dbg !205
  store i32 2, i32* %3, align 4, !tbaa !200
  call void @llvm.dbg.value(metadata i32* %3, metadata !210, metadata !DIExpression(DW_OP_deref)) #3, !dbg !205
  %23 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*), i8* nonnull %21) #3, !dbg !223
  call void @llvm.dbg.value(metadata i8* %23, metadata !211, metadata !DIExpression()) #3, !dbg !205
  %24 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* nonnull %21) #3, !dbg !224
  call void @llvm.dbg.value(metadata i8* %24, metadata !212, metadata !DIExpression()) #3, !dbg !205
  store i32 0, i32* %4, align 4, !dbg !225, !tbaa !200
  %25 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %22) #3, !dbg !226
  %26 = bitcast i8* %25 to i64*, !dbg !226
  call void @llvm.dbg.value(metadata i64* %26, metadata !213, metadata !DIExpression()) #3, !dbg !205
  %27 = icmp ne i8* %23, null, !dbg !227
  %28 = icmp ne i8* %24, null
  %29 = and i1 %27, %28, !dbg !229
  %30 = icmp ne i8* %25, null
  %31 = and i1 %29, %30, !dbg !229
  br i1 %31, label %32, label %56, !dbg !229

32:                                               ; preds = %19
  %33 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !230
  call void @llvm.dbg.value(metadata i64 %33, metadata !214, metadata !DIExpression()) #3, !dbg !205
  %34 = getelementptr inbounds i8, i8* %24, i64 24, !dbg !231
  %35 = bitcast i8* %34 to i64*, !dbg !231
  %36 = load i64, i64* %35, align 8, !dbg !231, !tbaa !232
  %37 = icmp eq i64 %36, 0, !dbg !235
  br i1 %37, label %51, label %38, !dbg !236

38:                                               ; preds = %32
  %39 = sub i64 %33, %36, !dbg !237
  call void @llvm.dbg.value(metadata i64 %39, metadata !215, metadata !DIExpression()) #3, !dbg !238
  call void @llvm.dbg.value(metadata i64 undef, metadata !218, metadata !DIExpression()) #3, !dbg !238
  %40 = icmp eq i64 %39, 0, !dbg !239
  br i1 %40, label %51, label %41, !dbg !240

41:                                               ; preds = %38
  %42 = bitcast i8* %23 to i64*, !dbg !241
  %43 = load i64, i64* %42, align 8, !dbg !241, !tbaa !242
  %44 = getelementptr inbounds i8, i8* %24, i64 16, !dbg !244
  %45 = bitcast i8* %44 to i64*, !dbg !244
  %46 = load i64, i64* %45, align 8, !dbg !244, !tbaa !245
  %47 = sub i64 %43, %46, !dbg !246
  call void @llvm.dbg.value(metadata i64 %47, metadata !218, metadata !DIExpression()) #3, !dbg !238
  %48 = udiv i64 %47, %39, !dbg !247
  call void @llvm.dbg.value(metadata i64 %48, metadata !219, metadata !DIExpression()) #3, !dbg !248
  %49 = icmp ugt i64 %48, 150, !dbg !249
  br i1 %49, label %50, label %51, !dbg !251

50:                                               ; preds = %41
  store i64 3000, i64* %26, align 8, !dbg !252, !tbaa !254
  br label %51, !dbg !255

51:                                               ; preds = %50, %41, %38, %32
  %52 = bitcast i8* %23 to i64*, !dbg !256
  %53 = load i64, i64* %52, align 8, !dbg !256, !tbaa !242
  %54 = getelementptr inbounds i8, i8* %24, i64 16, !dbg !257
  %55 = bitcast i8* %54 to i64*, !dbg !257
  store i64 %53, i64* %55, align 8, !dbg !258, !tbaa !245
  store i64 %33, i64* %35, align 8, !dbg !259, !tbaa !232
  br label %56, !dbg !260

56:                                               ; preds = %19, %51
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %21), !dbg !260
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %22), !dbg !260
  %57 = load i64, i64* %20, align 8, !dbg !261, !tbaa !254
  call void @llvm.dbg.value(metadata i64 %57, metadata !262, metadata !DIExpression()), !dbg !270
  call void @llvm.dbg.value(metadata i64 50, metadata !267, metadata !DIExpression()), !dbg !270
  %58 = mul i64 %57, 998000, !dbg !272
  call void @llvm.dbg.value(metadata i64 %58, metadata !268, metadata !DIExpression()), !dbg !270
  call void @llvm.dbg.value(metadata i64 100000, metadata !269, metadata !DIExpression()), !dbg !270
  %59 = add i64 %58, 100000, !dbg !273
  %60 = udiv i64 %59, 1000000, !dbg !274
  call void @llvm.dbg.value(metadata i64 %60, metadata !175, metadata !DIExpression()), !dbg !184
  store i64 %60, i64* %6, align 8, !dbg !275, !tbaa !254
  %61 = bitcast i64* %6 to i8*, !dbg !276
  call void @llvm.dbg.value(metadata i32* %5, metadata !173, metadata !DIExpression(DW_OP_deref)), !dbg !184
  call void @llvm.dbg.value(metadata i64* %6, metadata !175, metadata !DIExpression(DW_OP_deref)), !dbg !184
  %62 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %16, i8* nonnull %61, i64 0) #3, !dbg !277
  %63 = load i64, i64* %6, align 8, !dbg !278, !tbaa !254
  call void @llvm.dbg.value(metadata i64 %63, metadata !175, metadata !DIExpression()), !dbg !184
  %64 = icmp ugt i64 %63, 4999, !dbg !279
  br i1 %64, label %76, label %65, !dbg !280

65:                                               ; preds = %56
  %66 = icmp ult i64 %63, 1001, !dbg !281
  br i1 %66, label %76, label %67, !dbg !282

67:                                               ; preds = %65
  %68 = trunc i64 %63 to i32, !dbg !283
  %69 = mul nuw nsw i32 %68, 100, !dbg !283
  %70 = add nsw i32 %69, -100000, !dbg !283
  %71 = udiv i32 %70, 4000, !dbg !283
  call void @llvm.dbg.value(metadata i32 %71, metadata !176, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !284
  %72 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !285
  %73 = urem i32 %72, 100, !dbg !287
  %74 = icmp ugt i32 %71, %73, !dbg !288
  %75 = select i1 %74, i32 1, i32 2, !dbg !289
  call void @llvm.dbg.value(metadata i32 %75, metadata !171, metadata !DIExpression()), !dbg !184
  br label %76

76:                                               ; preds = %65, %56, %67
  %77 = phi i32 [ %75, %67 ], [ 1, %56 ], [ 2, %65 ], !dbg !290
  call void @llvm.dbg.value(metadata i32 %77, metadata !171, metadata !DIExpression()), !dbg !184
  %78 = getelementptr i8, i8* %15, i64 14, !dbg !291
  %79 = icmp ugt i8* %78, %11, !dbg !293
  br i1 %79, label %128, label %80, !dbg !294

80:                                               ; preds = %76
  %81 = inttoptr i64 %14 to %struct.ethhdr*, !dbg !295
  call void @llvm.dbg.value(metadata %struct.ethhdr* %81, metadata !159, metadata !DIExpression()), !dbg !184
  %82 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %81, i64 0, i32 1, i64 0, !dbg !296
  %83 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @redirect_params to i8*), i8* nonnull %82) #3, !dbg !297
  call void @llvm.dbg.value(metadata i8* %83, metadata !180, metadata !DIExpression()), !dbg !184
  %84 = icmp eq i8* %83, null, !dbg !298
  br i1 %84, label %89, label %85, !dbg !300

85:                                               ; preds = %80
  %86 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %81, i64 0, i32 0, i64 0, !dbg !301
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %86, i8* nonnull align 1 dereferenceable(6) %83, i64 6, i1 false), !dbg !301
  call void @llvm.dbg.value(metadata i32* %5, metadata !173, metadata !DIExpression(DW_OP_deref)), !dbg !184
  %87 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i8* nonnull %16) #3, !dbg !302
  call void @llvm.dbg.value(metadata i8* %87, metadata !182, metadata !DIExpression()), !dbg !184
  %88 = icmp eq i8* %87, null, !dbg !303
  br i1 %88, label %89, label %92, !dbg !305

89:                                               ; preds = %85, %80, %1
  %90 = phi i32 [ 1, %1 ], [ %77, %80 ], [ %77, %85 ]
  call void @llvm.dbg.value(metadata i32 %97, metadata !171, metadata !DIExpression()), !dbg !184
  call void @llvm.dbg.label(metadata !183), !dbg !306
  %91 = bitcast i32* %2 to i8*, !dbg !307
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %91), !dbg !307
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !312, metadata !DIExpression()) #3, !dbg !307
  call void @llvm.dbg.value(metadata i32 %97, metadata !313, metadata !DIExpression()) #3, !dbg !307
  store i32 %90, i32* %2, align 4, !tbaa !200
  call void @llvm.dbg.value(metadata i64 %7, metadata !314, metadata !DIExpression()) #3, !dbg !307
  br label %100, !dbg !318

92:                                               ; preds = %85
  %93 = bitcast i8* %87 to i32*, !dbg !302
  call void @llvm.dbg.value(metadata i32* %93, metadata !182, metadata !DIExpression()), !dbg !184
  %94 = load i32, i32* %93, align 4, !dbg !319, !tbaa !200
  %95 = zext i32 %94 to i64, !dbg !319
  %96 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i64 %95, i64 0) #3, !dbg !320
  %97 = trunc i64 %96 to i32, !dbg !320
  call void @llvm.dbg.value(metadata i32 %97, metadata !171, metadata !DIExpression()), !dbg !184
  call void @llvm.dbg.label(metadata !183), !dbg !306
  %98 = bitcast i32* %2 to i8*, !dbg !307
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %98), !dbg !307
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !312, metadata !DIExpression()) #3, !dbg !307
  call void @llvm.dbg.value(metadata i32 %97, metadata !313, metadata !DIExpression()) #3, !dbg !307
  store i32 %97, i32* %2, align 4, !tbaa !200
  call void @llvm.dbg.value(metadata i64 %7, metadata !314, metadata !DIExpression()) #3, !dbg !307
  %99 = icmp ugt i32 %97, 4, !dbg !321
  br i1 %99, label %125, label %100, !dbg !318

100:                                              ; preds = %89, %92
  %101 = phi i8* [ %91, %89 ], [ %98, %92 ]
  call void @llvm.dbg.value(metadata i32* %2, metadata !313, metadata !DIExpression(DW_OP_deref)) #3, !dbg !307
  %102 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*), i8* nonnull %101) #3, !dbg !323
  call void @llvm.dbg.value(metadata i8* %102, metadata !315, metadata !DIExpression()) #3, !dbg !307
  %103 = icmp eq i8* %102, null, !dbg !324
  br i1 %103, label %125, label %104, !dbg !326

104:                                              ; preds = %100
  call void @llvm.dbg.value(metadata i8* %102, metadata !315, metadata !DIExpression()) #3, !dbg !307
  %105 = bitcast i8* %102 to i64*, !dbg !327
  %106 = load i64, i64* %105, align 8, !dbg !328, !tbaa !242
  %107 = add i64 %106, 1, !dbg !328
  store i64 %107, i64* %105, align 8, !dbg !328, !tbaa !242
  %108 = load i32, i32* %8, align 4, !dbg !329, !tbaa !187
  %109 = load i32, i32* %12, align 4, !dbg !330, !tbaa !195
  %110 = sub i32 %108, %109, !dbg !331
  %111 = zext i32 %110 to i64, !dbg !332
  %112 = getelementptr inbounds i8, i8* %102, i64 8, !dbg !333
  %113 = bitcast i8* %112 to i64*, !dbg !333
  %114 = load i64, i64* %113, align 8, !dbg !334, !tbaa !335
  %115 = add i64 %114, %111, !dbg !334
  store i64 %115, i64* %113, align 8, !dbg !334, !tbaa !335
  call void @llvm.dbg.value(metadata i32* %2, metadata !313, metadata !DIExpression(DW_OP_deref)) #3, !dbg !307
  %116 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* nonnull %101) #3, !dbg !336
  call void @llvm.dbg.value(metadata i8* %116, metadata !316, metadata !DIExpression()) #3, !dbg !307
  %117 = icmp eq i8* %116, null, !dbg !337
  br i1 %117, label %125, label %118, !dbg !339

118:                                              ; preds = %104
  call void @llvm.dbg.value(metadata i8* %116, metadata !316, metadata !DIExpression()) #3, !dbg !307
  %119 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !340
  %120 = bitcast i8* %116 to i64*, !dbg !341
  store i64 %119, i64* %120, align 8, !dbg !342, !tbaa !343
  %121 = sub i64 %119, %7, !dbg !344
  %122 = getelementptr inbounds i8, i8* %116, i64 8, !dbg !345
  %123 = bitcast i8* %122 to i64*, !dbg !345
  store i64 %121, i64* %123, align 8, !dbg !346, !tbaa !347
  %124 = load i32, i32* %2, align 4, !dbg !348, !tbaa !200
  call void @llvm.dbg.value(metadata i32 %124, metadata !313, metadata !DIExpression()) #3, !dbg !307
  br label %125, !dbg !349

125:                                              ; preds = %92, %100, %104, %118
  %126 = phi i8* [ %98, %92 ], [ %101, %100 ], [ %101, %118 ], [ %101, %104 ]
  %127 = phi i32 [ 0, %92 ], [ 0, %100 ], [ %124, %118 ], [ 0, %104 ], !dbg !307
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %126), !dbg !350
  br label %128, !dbg !351

128:                                              ; preds = %76, %125
  %129 = phi i32 [ %127, %125 ], [ 1, %76 ], !dbg !184
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %16) #3, !dbg !352
  ret i32 %129, !dbg !352
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
!llvm.module.flags = !{!139, !140, !141}
!llvm.ident = !{!142}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "queue_avg_map", scope: !2, file: !3, line: 69, type: !132, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !17, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "continuous_burst_network/c/kern.c", directory: "/home/shrestha/btp/designs/eBPF")
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
!17 = !{!18, !28, !36, !42, !49, !55, !61, !84, !99, !115, !0}
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
!56 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 198, type: !57, isLocal: false, isDefinition: true)
!57 = !DICompositeType(tag: DW_TAG_array_type, baseType: !58, size: 32, elements: !59)
!58 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!59 = !{!60}
!60 = !DISubrange(count: 4)
!61 = !DIGlobalVariableExpression(var: !62, expr: !DIExpression())
!62 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 41, type: !63, isLocal: false, isDefinition: true)
!63 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 36, size: 256, elements: !64)
!64 = !{!65, !71, !73, !79}
!65 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !63, file: !3, line: 37, baseType: !66, size: 64)
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!67 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 64, elements: !69)
!68 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!69 = !{!70}
!70 = !DISubrange(count: 2)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !63, file: !3, line: 38, baseType: !72, size: 64, offset: 64)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !63, file: !3, line: 39, baseType: !74, size: 64, offset: 128)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !3, line: 24, size: 128, elements: !76)
!76 = !{!77, !78}
!77 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !75, file: !3, line: 25, baseType: !25, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !75, file: !3, line: 26, baseType: !25, size: 64, offset: 64)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !63, file: !3, line: 40, baseType: !80, size: 64, offset: 192)
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 160, elements: !82)
!82 = !{!83}
!83 = !DISubrange(count: 5)
!84 = !DIGlobalVariableExpression(var: !85, expr: !DIExpression())
!85 = distinct !DIGlobalVariable(name: "telemetry_stats_map", scope: !2, file: !3, line: 48, type: !86, isLocal: false, isDefinition: true)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 43, size: 256, elements: !87)
!87 = !{!88, !89, !90, !98}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !86, file: !3, line: 44, baseType: !66, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !86, file: !3, line: 45, baseType: !72, size: 64, offset: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !86, file: !3, line: 46, baseType: !91, size: 64, offset: 128)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!92 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "telrec", file: !3, line: 29, size: 256, elements: !93)
!93 = !{!94, !95, !96, !97}
!94 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !92, file: !3, line: 30, baseType: !25, size: 64)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time", scope: !92, file: !3, line: 31, baseType: !25, size: 64, offset: 64)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "last_rx_packets", scope: !92, file: !3, line: 32, baseType: !25, size: 64, offset: 128)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "last_timestamp", scope: !92, file: !3, line: 33, baseType: !25, size: 64, offset: 192)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !86, file: !3, line: 47, baseType: !80, size: 64, offset: 192)
!99 = !DIGlobalVariableExpression(var: !100, expr: !DIExpression())
!100 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !3, line: 55, type: !101, isLocal: false, isDefinition: true)
!101 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 50, size: 256, elements: !102)
!102 = !{!103, !108, !109, !110}
!103 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !101, file: !3, line: 51, baseType: !104, size: 64)
!104 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !105, size: 64)
!105 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 448, elements: !106)
!106 = !{!107}
!107 = !DISubrange(count: 14)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !101, file: !3, line: 52, baseType: !72, size: 64, offset: 64)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !101, file: !3, line: 53, baseType: !72, size: 64, offset: 128)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !101, file: !3, line: 54, baseType: !111, size: 64, offset: 192)
!111 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 64)
!112 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 8192, elements: !113)
!113 = !{!114}
!114 = !DISubrange(count: 256)
!115 = !DIGlobalVariableExpression(var: !116, expr: !DIExpression())
!116 = distinct !DIGlobalVariable(name: "redirect_params", scope: !2, file: !3, line: 62, type: !117, isLocal: false, isDefinition: true)
!117 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 57, size: 256, elements: !118)
!118 = !{!119, !124, !130, !131}
!119 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !117, file: !3, line: 58, baseType: !120, size: 64)
!120 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !121, size: 64)
!121 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 32, elements: !122)
!122 = !{!123}
!123 = !DISubrange(count: 1)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !117, file: !3, line: 59, baseType: !125, size: 64, offset: 64)
!125 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !126, size: 64)
!126 = !DICompositeType(tag: DW_TAG_array_type, baseType: !127, size: 48, elements: !128)
!127 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!128 = !{!129}
!129 = !DISubrange(count: 6)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !117, file: !3, line: 60, baseType: !125, size: 64, offset: 128)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !117, file: !3, line: 61, baseType: !120, size: 64, offset: 192)
!132 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 64, size: 256, elements: !133)
!133 = !{!134, !135, !136, !138}
!134 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !132, file: !3, line: 65, baseType: !66, size: 64)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !132, file: !3, line: 66, baseType: !72, size: 64, offset: 64)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !132, file: !3, line: 67, baseType: !137, size: 64, offset: 128)
!137 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !132, file: !3, line: 68, baseType: !120, size: 64, offset: 192)
!139 = !{i32 7, !"Dwarf Version", i32 4}
!140 = !{i32 2, !"Debug Info Version", i32 3}
!141 = !{i32 1, !"wchar_size", i32 4}
!142 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!143 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !3, file: !3, line: 137, type: !144, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !154)
!144 = !DISubroutineType(types: !145)
!145 = !{!68, !146}
!146 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !147, size: 64)
!147 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !148)
!148 = !{!149, !150, !151, !152, !153}
!149 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !147, file: !6, line: 3165, baseType: !48, size: 32)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !147, file: !6, line: 3166, baseType: !48, size: 32, offset: 32)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !147, file: !6, line: 3167, baseType: !48, size: 32, offset: 64)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !147, file: !6, line: 3169, baseType: !48, size: 32, offset: 96)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !147, file: !6, line: 3170, baseType: !48, size: 32, offset: 128)
!154 = !{!155, !156, !157, !158, !159, !171, !172, !173, !174, !175, !176, !180, !182, !183}
!155 = !DILocalVariable(name: "ctx", arg: 1, scope: !143, file: !3, line: 137, type: !146)
!156 = !DILocalVariable(name: "start", scope: !143, file: !3, line: 138, type: !25)
!157 = !DILocalVariable(name: "data_end", scope: !143, file: !3, line: 139, type: !15)
!158 = !DILocalVariable(name: "data", scope: !143, file: !3, line: 140, type: !15)
!159 = !DILocalVariable(name: "eth", scope: !143, file: !3, line: 142, type: !160)
!160 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !161, size: 64)
!161 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !162, line: 163, size: 112, elements: !163)
!162 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!163 = !{!164, !165, !166}
!164 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !161, file: !162, line: 164, baseType: !126, size: 48)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !161, file: !162, line: 165, baseType: !126, size: 48, offset: 48)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !161, file: !162, line: 166, baseType: !167, size: 16, offset: 96)
!167 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !168, line: 25, baseType: !169)
!168 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!169 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !26, line: 24, baseType: !170)
!170 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!171 = !DILocalVariable(name: "action", scope: !143, file: !3, line: 143, type: !48)
!172 = !DILocalVariable(name: "queue_len", scope: !143, file: !3, line: 144, type: !25)
!173 = !DILocalVariable(name: "key", scope: !143, file: !3, line: 145, type: !48)
!174 = !DILocalVariable(name: "prev_avg", scope: !143, file: !3, line: 148, type: !137)
!175 = !DILocalVariable(name: "new_avg", scope: !143, file: !3, line: 158, type: !25)
!176 = !DILocalVariable(name: "drop_prob", scope: !177, file: !3, line: 167, type: !25)
!177 = distinct !DILexicalBlock(scope: !178, file: !3, line: 166, column: 10)
!178 = distinct !DILexicalBlock(scope: !179, file: !3, line: 164, column: 14)
!179 = distinct !DILexicalBlock(scope: !143, file: !3, line: 162, column: 7)
!180 = !DILocalVariable(name: "dst", scope: !143, file: !3, line: 181, type: !181)
!181 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !127, size: 64)
!182 = !DILocalVariable(name: "iface_index", scope: !143, file: !3, line: 188, type: !72)
!183 = !DILabel(scope: !143, name: "out", file: !3, line: 194)
!184 = !DILocation(line: 0, scope: !143)
!185 = !DILocation(line: 138, column: 17, scope: !143)
!186 = !DILocation(line: 139, column: 39, scope: !143)
!187 = !{!188, !189, i64 4}
!188 = !{!"xdp_md", !189, i64 0, !189, i64 4, !189, i64 8, !189, i64 12, !189, i64 16}
!189 = !{!"int", !190, i64 0}
!190 = !{!"omnipotent char", !191, i64 0}
!191 = !{!"Simple C/C++ TBAA"}
!192 = !DILocation(line: 139, column: 28, scope: !143)
!193 = !DILocation(line: 139, column: 20, scope: !143)
!194 = !DILocation(line: 140, column: 35, scope: !143)
!195 = !{!188, !189, i64 0}
!196 = !DILocation(line: 140, column: 24, scope: !143)
!197 = !DILocation(line: 140, column: 16, scope: !143)
!198 = !DILocation(line: 145, column: 3, scope: !143)
!199 = !DILocation(line: 145, column: 9, scope: !143)
!200 = !{!189, !189, i64 0}
!201 = !DILocation(line: 148, column: 21, scope: !143)
!202 = !DILocation(line: 149, column: 8, scope: !203)
!203 = distinct !DILexicalBlock(scope: !143, file: !3, line: 149, column: 7)
!204 = !DILocation(line: 149, column: 7, scope: !143)
!205 = !DILocation(line: 0, scope: !206, inlinedAt: !222)
!206 = distinct !DISubprogram(name: "handle_burst_detection", scope: !3, file: !3, line: 80, type: !207, scopeLine: 80, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !209)
!207 = !DISubroutineType(types: !208)
!208 = !{null, !48}
!209 = !{!210, !211, !212, !213, !214, !215, !218, !219}
!210 = !DILocalVariable(name: "action", arg: 1, scope: !206, file: !3, line: 80, type: !48)
!211 = !DILocalVariable(name: "stats", scope: !206, file: !3, line: 81, type: !74)
!212 = !DILocalVariable(name: "telemetry", scope: !206, file: !3, line: 82, type: !91)
!213 = !DILocalVariable(name: "queue_len", scope: !206, file: !3, line: 83, type: !137)
!214 = !DILocalVariable(name: "current_time", scope: !206, file: !3, line: 89, type: !25)
!215 = !DILocalVariable(name: "time_diff", scope: !216, file: !3, line: 91, type: !25)
!216 = distinct !DILexicalBlock(scope: !217, file: !3, line: 90, column: 38)
!217 = distinct !DILexicalBlock(scope: !206, file: !3, line: 90, column: 7)
!218 = !DILocalVariable(name: "packet_diff", scope: !216, file: !3, line: 92, type: !25)
!219 = !DILocalVariable(name: "rps", scope: !220, file: !3, line: 96, type: !25)
!220 = distinct !DILexicalBlock(scope: !221, file: !3, line: 95, column: 24)
!221 = distinct !DILexicalBlock(scope: !216, file: !3, line: 95, column: 9)
!222 = distinct !DILocation(line: 155, column: 3, scope: !143)
!223 = !DILocation(line: 81, column: 27, scope: !206, inlinedAt: !222)
!224 = !DILocation(line: 82, column: 30, scope: !206, inlinedAt: !222)
!225 = !DILocation(line: 83, column: 59, scope: !206, inlinedAt: !222)
!226 = !DILocation(line: 83, column: 22, scope: !206, inlinedAt: !222)
!227 = !DILocation(line: 85, column: 8, scope: !228, inlinedAt: !222)
!228 = distinct !DILexicalBlock(scope: !206, file: !3, line: 85, column: 7)
!229 = !DILocation(line: 85, column: 14, scope: !228, inlinedAt: !222)
!230 = !DILocation(line: 89, column: 24, scope: !206, inlinedAt: !222)
!231 = !DILocation(line: 90, column: 18, scope: !217, inlinedAt: !222)
!232 = !{!233, !234, i64 24}
!233 = !{!"telrec", !234, i64 0, !234, i64 8, !234, i64 16, !234, i64 24}
!234 = !{!"long long", !190, i64 0}
!235 = !DILocation(line: 90, column: 33, scope: !217, inlinedAt: !222)
!236 = !DILocation(line: 90, column: 7, scope: !206, inlinedAt: !222)
!237 = !DILocation(line: 91, column: 36, scope: !216, inlinedAt: !222)
!238 = !DILocation(line: 0, scope: !216, inlinedAt: !222)
!239 = !DILocation(line: 95, column: 19, scope: !221, inlinedAt: !222)
!240 = !DILocation(line: 95, column: 9, scope: !216, inlinedAt: !222)
!241 = !DILocation(line: 92, column: 32, scope: !216, inlinedAt: !222)
!242 = !{!243, !234, i64 0}
!243 = !{!"datarec", !234, i64 0, !234, i64 8}
!244 = !DILocation(line: 92, column: 56, scope: !216, inlinedAt: !222)
!245 = !{!233, !234, i64 16}
!246 = !DILocation(line: 92, column: 43, scope: !216, inlinedAt: !222)
!247 = !DILocation(line: 96, column: 31, scope: !220, inlinedAt: !222)
!248 = !DILocation(line: 0, scope: !220, inlinedAt: !222)
!249 = !DILocation(line: 99, column: 15, scope: !250, inlinedAt: !222)
!250 = distinct !DILexicalBlock(scope: !220, file: !3, line: 99, column: 11)
!251 = !DILocation(line: 99, column: 11, scope: !220, inlinedAt: !222)
!252 = !DILocation(line: 100, column: 20, scope: !253, inlinedAt: !222)
!253 = distinct !DILexicalBlock(scope: !250, file: !3, line: 99, column: 35)
!254 = !{!234, !234, i64 0}
!255 = !DILocation(line: 101, column: 7, scope: !253, inlinedAt: !222)
!256 = !DILocation(line: 106, column: 39, scope: !206, inlinedAt: !222)
!257 = !DILocation(line: 106, column: 14, scope: !206, inlinedAt: !222)
!258 = !DILocation(line: 106, column: 30, scope: !206, inlinedAt: !222)
!259 = !DILocation(line: 107, column: 29, scope: !206, inlinedAt: !222)
!260 = !DILocation(line: 108, column: 1, scope: !206, inlinedAt: !222)
!261 = !DILocation(line: 158, column: 43, scope: !143)
!262 = !DILocalVariable(name: "prev_avg", arg: 1, scope: !263, file: !3, line: 72, type: !25)
!263 = distinct !DISubprogram(name: "calculate_avg_queue_len", scope: !3, file: !3, line: 72, type: !264, scopeLine: 73, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !266)
!264 = !DISubroutineType(types: !265)
!265 = !{!25, !25, !25}
!266 = !{!262, !267, !268, !269}
!267 = !DILocalVariable(name: "curr_queue_len", arg: 2, scope: !263, file: !3, line: 73, type: !25)
!268 = !DILocalVariable(name: "weighted_prev_avg", scope: !263, file: !3, line: 74, type: !25)
!269 = !DILocalVariable(name: "weighted_curr_len", scope: !263, file: !3, line: 75, type: !25)
!270 = !DILocation(line: 0, scope: !263, inlinedAt: !271)
!271 = distinct !DILocation(line: 158, column: 19, scope: !143)
!272 = !DILocation(line: 74, column: 55, scope: !263, inlinedAt: !271)
!273 = !DILocation(line: 76, column: 29, scope: !263, inlinedAt: !271)
!274 = !DILocation(line: 76, column: 50, scope: !263, inlinedAt: !271)
!275 = !DILocation(line: 158, column: 9, scope: !143)
!276 = !DILocation(line: 159, column: 45, scope: !143)
!277 = !DILocation(line: 159, column: 3, scope: !143)
!278 = !DILocation(line: 162, column: 7, scope: !179)
!279 = !DILocation(line: 162, column: 15, scope: !179)
!280 = !DILocation(line: 162, column: 7, scope: !143)
!281 = !DILocation(line: 164, column: 22, scope: !178)
!282 = !DILocation(line: 164, column: 14, scope: !179)
!283 = !DILocation(line: 167, column: 66, scope: !177)
!284 = !DILocation(line: 0, scope: !177)
!285 = !DILocation(line: 169, column: 9, scope: !286)
!286 = distinct !DILexicalBlock(scope: !177, file: !3, line: 169, column: 9)
!287 = !DILocation(line: 169, column: 31, scope: !286)
!288 = !DILocation(line: 169, column: 37, scope: !286)
!289 = !DILocation(line: 169, column: 9, scope: !177)
!290 = !DILocation(line: 0, scope: !179)
!291 = !DILocation(line: 175, column: 12, scope: !292)
!292 = distinct !DILexicalBlock(scope: !143, file: !3, line: 175, column: 7)
!293 = !DILocation(line: 175, column: 36, scope: !292)
!294 = !DILocation(line: 175, column: 7, scope: !143)
!295 = !DILocation(line: 178, column: 9, scope: !143)
!296 = !DILocation(line: 181, column: 62, scope: !143)
!297 = !DILocation(line: 181, column: 24, scope: !143)
!298 = !DILocation(line: 182, column: 8, scope: !299)
!299 = distinct !DILexicalBlock(scope: !143, file: !3, line: 182, column: 7)
!300 = !DILocation(line: 182, column: 7, scope: !143)
!301 = !DILocation(line: 185, column: 3, scope: !143)
!302 = !DILocation(line: 188, column: 24, scope: !143)
!303 = !DILocation(line: 189, column: 8, scope: !304)
!304 = distinct !DILexicalBlock(scope: !143, file: !3, line: 189, column: 7)
!305 = !DILocation(line: 189, column: 7, scope: !143)
!306 = !DILocation(line: 194, column: 1, scope: !143)
!307 = !DILocation(line: 0, scope: !308, inlinedAt: !317)
!308 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 111, type: !309, scopeLine: 113, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !311)
!309 = !DISubroutineType(types: !310)
!310 = !{!48, !146, !48, !25}
!311 = !{!312, !313, !314, !315, !316}
!312 = !DILocalVariable(name: "ctx", arg: 1, scope: !308, file: !3, line: 111, type: !146)
!313 = !DILocalVariable(name: "action", arg: 2, scope: !308, file: !3, line: 112, type: !48)
!314 = !DILocalVariable(name: "start", arg: 3, scope: !308, file: !3, line: 113, type: !25)
!315 = !DILocalVariable(name: "rec", scope: !308, file: !3, line: 117, type: !74)
!316 = !DILocalVariable(name: "telemetry", scope: !308, file: !3, line: 125, type: !91)
!317 = distinct !DILocation(line: 195, column: 10, scope: !143)
!318 = !DILocation(line: 114, column: 7, scope: !308, inlinedAt: !317)
!319 = !DILocation(line: 192, column: 39, scope: !143)
!320 = !DILocation(line: 192, column: 12, scope: !143)
!321 = !DILocation(line: 114, column: 14, scope: !322, inlinedAt: !317)
!322 = distinct !DILexicalBlock(scope: !308, file: !3, line: 114, column: 7)
!323 = !DILocation(line: 117, column: 25, scope: !308, inlinedAt: !317)
!324 = !DILocation(line: 118, column: 8, scope: !325, inlinedAt: !317)
!325 = distinct !DILexicalBlock(scope: !308, file: !3, line: 118, column: 7)
!326 = !DILocation(line: 118, column: 7, scope: !308, inlinedAt: !317)
!327 = !DILocation(line: 122, column: 8, scope: !308, inlinedAt: !317)
!328 = !DILocation(line: 122, column: 18, scope: !308, inlinedAt: !317)
!329 = !DILocation(line: 123, column: 26, scope: !308, inlinedAt: !317)
!330 = !DILocation(line: 123, column: 42, scope: !308, inlinedAt: !317)
!331 = !DILocation(line: 123, column: 35, scope: !308, inlinedAt: !317)
!332 = !DILocation(line: 123, column: 20, scope: !308, inlinedAt: !317)
!333 = !DILocation(line: 123, column: 8, scope: !308, inlinedAt: !317)
!334 = !DILocation(line: 123, column: 17, scope: !308, inlinedAt: !317)
!335 = !{!243, !234, i64 8}
!336 = !DILocation(line: 125, column: 30, scope: !308, inlinedAt: !317)
!337 = !DILocation(line: 126, column: 8, scope: !338, inlinedAt: !317)
!338 = distinct !DILexicalBlock(scope: !308, file: !3, line: 126, column: 7)
!339 = !DILocation(line: 126, column: 7, scope: !308, inlinedAt: !317)
!340 = !DILocation(line: 129, column: 26, scope: !308, inlinedAt: !317)
!341 = !DILocation(line: 129, column: 14, scope: !308, inlinedAt: !317)
!342 = !DILocation(line: 129, column: 24, scope: !308, inlinedAt: !317)
!343 = !{!233, !234, i64 0}
!344 = !DILocation(line: 130, column: 53, scope: !308, inlinedAt: !317)
!345 = !DILocation(line: 130, column: 14, scope: !308, inlinedAt: !317)
!346 = !DILocation(line: 130, column: 30, scope: !308, inlinedAt: !317)
!347 = !{!233, !234, i64 8}
!348 = !DILocation(line: 132, column: 10, scope: !308, inlinedAt: !317)
!349 = !DILocation(line: 132, column: 3, scope: !308, inlinedAt: !317)
!350 = !DILocation(line: 133, column: 1, scope: !308, inlinedAt: !317)
!351 = !DILocation(line: 195, column: 3, scope: !143)
!352 = !DILocation(line: 196, column: 1, scope: !143)
