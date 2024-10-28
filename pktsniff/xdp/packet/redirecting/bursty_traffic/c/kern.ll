; ModuleID = 'kern.c'
source_filename = "kern.c"
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
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !153, metadata !DIExpression()), !dbg !182
  %8 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !183
  call void @llvm.dbg.value(metadata i64 %8, metadata !154, metadata !DIExpression()), !dbg !182
  %9 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !184
  %10 = load i32, i32* %9, align 4, !dbg !184, !tbaa !185
  %11 = zext i32 %10 to i64, !dbg !190
  %12 = inttoptr i64 %11 to i8*, !dbg !191
  call void @llvm.dbg.value(metadata i8* %12, metadata !155, metadata !DIExpression()), !dbg !182
  %13 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !192
  %14 = load i32, i32* %13, align 4, !dbg !192, !tbaa !193
  %15 = zext i32 %14 to i64, !dbg !194
  %16 = inttoptr i64 %15 to i8*, !dbg !195
  call void @llvm.dbg.value(metadata i8* %16, metadata !156, metadata !DIExpression()), !dbg !182
  call void @llvm.dbg.value(metadata i32 2, metadata !169, metadata !DIExpression()), !dbg !182
  call void @llvm.dbg.value(metadata i64 50, metadata !170, metadata !DIExpression()), !dbg !182
  %17 = bitcast i32* %6 to i8*, !dbg !196
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %17) #3, !dbg !196
  call void @llvm.dbg.value(metadata i32 0, metadata !171, metadata !DIExpression()), !dbg !182
  store i32 0, i32* %6, align 4, !dbg !197, !tbaa !198
  call void @llvm.dbg.value(metadata i32* %6, metadata !171, metadata !DIExpression(DW_OP_deref)), !dbg !182
  %18 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %17) #3, !dbg !199
  call void @llvm.dbg.value(metadata i8* %18, metadata !172, metadata !DIExpression()), !dbg !182
  %19 = icmp eq i8* %18, null, !dbg !200
  br i1 %19, label %83, label %20, !dbg !202

20:                                               ; preds = %1
  %21 = bitcast i8* %18 to i64*, !dbg !199
  call void @llvm.dbg.value(metadata i64* %21, metadata !172, metadata !DIExpression()), !dbg !182
  %22 = bitcast i32* %3 to i8*, !dbg !203
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %22), !dbg !203
  %23 = bitcast i32* %4 to i8*, !dbg !203
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %23), !dbg !203
  call void @llvm.dbg.value(metadata i32 2, metadata !208, metadata !DIExpression()) #3, !dbg !203
  store i32 2, i32* %3, align 4, !tbaa !198
  call void @llvm.dbg.value(metadata i32* %3, metadata !208, metadata !DIExpression(DW_OP_deref)) #3, !dbg !203
  %24 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*), i8* nonnull %22) #3, !dbg !221
  call void @llvm.dbg.value(metadata i8* %24, metadata !209, metadata !DIExpression()) #3, !dbg !203
  %25 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* nonnull %22) #3, !dbg !222
  call void @llvm.dbg.value(metadata i8* %25, metadata !210, metadata !DIExpression()) #3, !dbg !203
  store i32 0, i32* %4, align 4, !dbg !223, !tbaa !198
  %26 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %23) #3, !dbg !224
  %27 = bitcast i8* %26 to i64*, !dbg !224
  call void @llvm.dbg.value(metadata i64* %27, metadata !211, metadata !DIExpression()) #3, !dbg !203
  %28 = icmp ne i8* %24, null, !dbg !225
  %29 = icmp ne i8* %25, null
  %30 = and i1 %28, %29, !dbg !227
  %31 = icmp ne i8* %26, null
  %32 = and i1 %30, %31, !dbg !227
  br i1 %32, label %33, label %52, !dbg !227

33:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i8* %25, metadata !210, metadata !DIExpression()) #3, !dbg !203
  %34 = getelementptr inbounds i8, i8* %25, i64 8, !dbg !228
  %35 = bitcast i8* %34 to i64*, !dbg !228
  %36 = load i64, i64* %35, align 8, !dbg !228, !tbaa !229
  call void @llvm.dbg.value(metadata i64 %36, metadata !212, metadata !DIExpression()) #3, !dbg !203
  %37 = icmp eq i64 %36, 0, !dbg !232
  br i1 %37, label %52, label %38, !dbg !233

38:                                               ; preds = %33
  %39 = bitcast i8* %24 to i64*, !dbg !234
  %40 = load i64, i64* %39, align 8, !dbg !234, !tbaa !235
  %41 = mul i64 %40, 1000000000, !dbg !237
  %42 = udiv i64 %41, %36, !dbg !238
  call void @llvm.dbg.value(metadata i64 %42, metadata !213, metadata !DIExpression()) #3, !dbg !239
  %43 = load i64, i64* %27, align 8, !dbg !240, !tbaa !241
  %44 = icmp ugt i64 %42, %43, !dbg !242
  br i1 %44, label %45, label %52, !dbg !243

45:                                               ; preds = %38
  %46 = bitcast i32* %5 to i8*, !dbg !244
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %46) #3, !dbg !244
  call void @llvm.dbg.value(metadata i32 0, metadata !216, metadata !DIExpression()) #3, !dbg !245
  store i32 0, i32* %5, align 4, !dbg !246, !tbaa !198
  call void @llvm.dbg.value(metadata i32* %5, metadata !216, metadata !DIExpression(DW_OP_deref)) #3, !dbg !245
  %47 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %46) #3, !dbg !247
  call void @llvm.dbg.value(metadata i8* %47, metadata !219, metadata !DIExpression()) #3, !dbg !245
  %48 = icmp eq i8* %47, null, !dbg !248
  br i1 %48, label %51, label %49, !dbg !250

49:                                               ; preds = %45
  %50 = bitcast i8* %47 to i64*, !dbg !247
  call void @llvm.dbg.value(metadata i64* %50, metadata !219, metadata !DIExpression()) #3, !dbg !245
  store i64 3000, i64* %50, align 8, !dbg !251, !tbaa !241
  br label %51, !dbg !253

51:                                               ; preds = %49, %45
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %46) #3, !dbg !254
  br label %52, !dbg !255

52:                                               ; preds = %20, %33, %38, %51
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %22), !dbg !256
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %23), !dbg !256
  %53 = load i64, i64* %21, align 8, !dbg !257, !tbaa !241
  call void @llvm.dbg.value(metadata i64 %53, metadata !258, metadata !DIExpression()), !dbg !266
  call void @llvm.dbg.value(metadata i64 50, metadata !263, metadata !DIExpression()), !dbg !266
  %54 = mul i64 %53, 998000, !dbg !268
  call void @llvm.dbg.value(metadata i64 %54, metadata !264, metadata !DIExpression()), !dbg !266
  call void @llvm.dbg.value(metadata i64 100000, metadata !265, metadata !DIExpression()), !dbg !266
  %55 = add i64 %54, 100000, !dbg !269
  %56 = udiv i64 %55, 1000000, !dbg !270
  call void @llvm.dbg.value(metadata i64 %56, metadata !173, metadata !DIExpression()), !dbg !182
  store i64 %56, i64* %7, align 8, !dbg !271, !tbaa !241
  %57 = bitcast i64* %7 to i8*, !dbg !272
  call void @llvm.dbg.value(metadata i32* %6, metadata !171, metadata !DIExpression(DW_OP_deref)), !dbg !182
  call void @llvm.dbg.value(metadata i64* %7, metadata !173, metadata !DIExpression(DW_OP_deref)), !dbg !182
  %58 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %17, i8* nonnull %57, i64 0) #3, !dbg !273
  %59 = load i64, i64* %7, align 8, !dbg !274, !tbaa !241
  call void @llvm.dbg.value(metadata i64 %59, metadata !173, metadata !DIExpression()), !dbg !182
  %60 = icmp ugt i64 %59, 4999, !dbg !275
  br i1 %60, label %83, label %61, !dbg !276

61:                                               ; preds = %52
  %62 = icmp ult i64 %59, 1001, !dbg !277
  br i1 %62, label %71, label %63, !dbg !278

63:                                               ; preds = %61
  %64 = trunc i64 %59 to i32, !dbg !279
  %65 = mul nuw nsw i32 %64, 100, !dbg !279
  %66 = add nsw i32 %65, -100000, !dbg !279
  %67 = udiv i32 %66, 4000, !dbg !279
  call void @llvm.dbg.value(metadata i32 %67, metadata !174, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !280
  %68 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !281
  %69 = urem i32 %68, 100, !dbg !283
  %70 = icmp ugt i32 %67, %69, !dbg !284
  call void @llvm.dbg.value(metadata i32 undef, metadata !169, metadata !DIExpression()), !dbg !182
  br i1 %70, label %83, label %71

71:                                               ; preds = %63, %61
  call void @llvm.dbg.value(metadata i32 2, metadata !169, metadata !DIExpression()), !dbg !182
  %72 = getelementptr i8, i8* %16, i64 14, !dbg !285
  %73 = icmp ugt i8* %72, %12, !dbg !287
  br i1 %73, label %122, label %74, !dbg !288

74:                                               ; preds = %71
  %75 = inttoptr i64 %15 to %struct.ethhdr*, !dbg !289
  call void @llvm.dbg.value(metadata %struct.ethhdr* %75, metadata !157, metadata !DIExpression()), !dbg !182
  %76 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %75, i64 0, i32 1, i64 0, !dbg !290
  %77 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @redirect_params to i8*), i8* nonnull %76) #3, !dbg !291
  call void @llvm.dbg.value(metadata i8* %77, metadata !178, metadata !DIExpression()), !dbg !182
  %78 = icmp eq i8* %77, null, !dbg !292
  br i1 %78, label %83, label %79, !dbg !294

79:                                               ; preds = %74
  %80 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %75, i64 0, i32 0, i64 0, !dbg !295
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %80, i8* nonnull align 1 dereferenceable(6) %77, i64 6, i1 false), !dbg !295
  call void @llvm.dbg.value(metadata i32* %6, metadata !171, metadata !DIExpression(DW_OP_deref)), !dbg !182
  %81 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i8* nonnull %17) #3, !dbg !296
  call void @llvm.dbg.value(metadata i8* %81, metadata !180, metadata !DIExpression()), !dbg !182
  %82 = icmp eq i8* %81, null, !dbg !297
  br i1 %82, label %83, label %86, !dbg !299

83:                                               ; preds = %79, %74, %63, %1, %52
  %84 = phi i32 [ 1, %52 ], [ 1, %1 ], [ 1, %63 ], [ 2, %74 ], [ 2, %79 ]
  call void @llvm.dbg.value(metadata i32 %91, metadata !169, metadata !DIExpression()), !dbg !182
  call void @llvm.dbg.label(metadata !181), !dbg !300
  %85 = bitcast i32* %2 to i8*, !dbg !301
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %85), !dbg !301
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !306, metadata !DIExpression()) #3, !dbg !301
  call void @llvm.dbg.value(metadata i32 %91, metadata !307, metadata !DIExpression()) #3, !dbg !301
  store i32 %84, i32* %2, align 4, !tbaa !198
  call void @llvm.dbg.value(metadata i64 %8, metadata !308, metadata !DIExpression()) #3, !dbg !301
  br label %94, !dbg !312

86:                                               ; preds = %79
  %87 = bitcast i8* %81 to i32*, !dbg !296
  call void @llvm.dbg.value(metadata i32* %87, metadata !180, metadata !DIExpression()), !dbg !182
  %88 = load i32, i32* %87, align 4, !dbg !313, !tbaa !198
  %89 = zext i32 %88 to i64, !dbg !313
  %90 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i64 %89, i64 0) #3, !dbg !314
  %91 = trunc i64 %90 to i32, !dbg !314
  call void @llvm.dbg.value(metadata i32 %91, metadata !169, metadata !DIExpression()), !dbg !182
  call void @llvm.dbg.label(metadata !181), !dbg !300
  %92 = bitcast i32* %2 to i8*, !dbg !301
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %92), !dbg !301
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !306, metadata !DIExpression()) #3, !dbg !301
  call void @llvm.dbg.value(metadata i32 %91, metadata !307, metadata !DIExpression()) #3, !dbg !301
  store i32 %91, i32* %2, align 4, !tbaa !198
  call void @llvm.dbg.value(metadata i64 %8, metadata !308, metadata !DIExpression()) #3, !dbg !301
  %93 = icmp ugt i32 %91, 4, !dbg !315
  br i1 %93, label %119, label %94, !dbg !312

94:                                               ; preds = %83, %86
  %95 = phi i8* [ %85, %83 ], [ %92, %86 ]
  call void @llvm.dbg.value(metadata i32* %2, metadata !307, metadata !DIExpression(DW_OP_deref)) #3, !dbg !301
  %96 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*), i8* nonnull %95) #3, !dbg !317
  call void @llvm.dbg.value(metadata i8* %96, metadata !309, metadata !DIExpression()) #3, !dbg !301
  %97 = icmp eq i8* %96, null, !dbg !318
  br i1 %97, label %119, label %98, !dbg !320

98:                                               ; preds = %94
  call void @llvm.dbg.value(metadata i8* %96, metadata !309, metadata !DIExpression()) #3, !dbg !301
  %99 = bitcast i8* %96 to i64*, !dbg !321
  %100 = load i64, i64* %99, align 8, !dbg !322, !tbaa !235
  %101 = add i64 %100, 1, !dbg !322
  store i64 %101, i64* %99, align 8, !dbg !322, !tbaa !235
  %102 = load i32, i32* %9, align 4, !dbg !323, !tbaa !185
  %103 = load i32, i32* %13, align 4, !dbg !324, !tbaa !193
  %104 = sub i32 %102, %103, !dbg !325
  %105 = zext i32 %104 to i64, !dbg !326
  %106 = getelementptr inbounds i8, i8* %96, i64 8, !dbg !327
  %107 = bitcast i8* %106 to i64*, !dbg !327
  %108 = load i64, i64* %107, align 8, !dbg !328, !tbaa !329
  %109 = add i64 %108, %105, !dbg !328
  store i64 %109, i64* %107, align 8, !dbg !328, !tbaa !329
  call void @llvm.dbg.value(metadata i32* %2, metadata !307, metadata !DIExpression(DW_OP_deref)) #3, !dbg !301
  %110 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* nonnull %95) #3, !dbg !330
  call void @llvm.dbg.value(metadata i8* %110, metadata !310, metadata !DIExpression()) #3, !dbg !301
  %111 = icmp eq i8* %110, null, !dbg !331
  br i1 %111, label %119, label %112, !dbg !333

112:                                              ; preds = %98
  call void @llvm.dbg.value(metadata i8* %110, metadata !310, metadata !DIExpression()) #3, !dbg !301
  %113 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !334
  %114 = bitcast i8* %110 to i64*, !dbg !335
  store i64 %113, i64* %114, align 8, !dbg !336, !tbaa !337
  %115 = sub i64 %113, %8, !dbg !338
  %116 = getelementptr inbounds i8, i8* %110, i64 8, !dbg !339
  %117 = bitcast i8* %116 to i64*, !dbg !339
  store i64 %115, i64* %117, align 8, !dbg !340, !tbaa !229
  %118 = load i32, i32* %2, align 4, !dbg !341, !tbaa !198
  call void @llvm.dbg.value(metadata i32 %118, metadata !307, metadata !DIExpression()) #3, !dbg !301
  br label %119, !dbg !342

119:                                              ; preds = %86, %94, %98, %112
  %120 = phi i8* [ %92, %86 ], [ %95, %94 ], [ %95, %112 ], [ %95, %98 ]
  %121 = phi i32 [ 0, %86 ], [ 0, %94 ], [ %118, %112 ], [ 0, %98 ], !dbg !301
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %120), !dbg !343
  br label %122, !dbg !344

122:                                              ; preds = %71, %119
  %123 = phi i32 [ %121, %119 ], [ 1, %71 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %17) #3, !dbg !345
  ret i32 %123, !dbg !345
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
!1 = distinct !DIGlobalVariable(name: "queue_avg_map", scope: !2, file: !3, line: 67, type: !130, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !17, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "kern.c", directory: "/home/shrestha/btp/pktsniff/xdp/packet/redirecting/bursty_traffic/c")
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
!56 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 193, type: !57, isLocal: false, isDefinition: true)
!57 = !DICompositeType(tag: DW_TAG_array_type, baseType: !58, size: 32, elements: !59)
!58 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!59 = !{!60}
!60 = !DISubrange(count: 4)
!61 = !DIGlobalVariableExpression(var: !62, expr: !DIExpression())
!62 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 39, type: !63, isLocal: false, isDefinition: true)
!63 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 34, size: 256, elements: !64)
!64 = !{!65, !71, !73, !79}
!65 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !63, file: !3, line: 35, baseType: !66, size: 64)
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!67 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 64, elements: !69)
!68 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!69 = !{!70}
!70 = !DISubrange(count: 2)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !63, file: !3, line: 36, baseType: !72, size: 64, offset: 64)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !63, file: !3, line: 37, baseType: !74, size: 64, offset: 128)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !3, line: 24, size: 128, elements: !76)
!76 = !{!77, !78}
!77 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !75, file: !3, line: 25, baseType: !25, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !75, file: !3, line: 26, baseType: !25, size: 64, offset: 64)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !63, file: !3, line: 38, baseType: !80, size: 64, offset: 192)
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 160, elements: !82)
!82 = !{!83}
!83 = !DISubrange(count: 5)
!84 = !DIGlobalVariableExpression(var: !85, expr: !DIExpression())
!85 = distinct !DIGlobalVariable(name: "telemetry_stats_map", scope: !2, file: !3, line: 46, type: !86, isLocal: false, isDefinition: true)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 41, size: 256, elements: !87)
!87 = !{!88, !89, !90, !96}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !86, file: !3, line: 42, baseType: !66, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !86, file: !3, line: 43, baseType: !72, size: 64, offset: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !86, file: !3, line: 44, baseType: !91, size: 64, offset: 128)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!92 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "telrec", file: !3, line: 29, size: 128, elements: !93)
!93 = !{!94, !95}
!94 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !92, file: !3, line: 30, baseType: !25, size: 64)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time", scope: !92, file: !3, line: 31, baseType: !25, size: 64, offset: 64)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !86, file: !3, line: 45, baseType: !80, size: 64, offset: 192)
!97 = !DIGlobalVariableExpression(var: !98, expr: !DIExpression())
!98 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !3, line: 53, type: !99, isLocal: false, isDefinition: true)
!99 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 48, size: 256, elements: !100)
!100 = !{!101, !106, !107, !108}
!101 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !99, file: !3, line: 49, baseType: !102, size: 64)
!102 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !103, size: 64)
!103 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 448, elements: !104)
!104 = !{!105}
!105 = !DISubrange(count: 14)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !99, file: !3, line: 50, baseType: !72, size: 64, offset: 64)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !99, file: !3, line: 51, baseType: !72, size: 64, offset: 128)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !99, file: !3, line: 52, baseType: !109, size: 64, offset: 192)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !110, size: 64)
!110 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 8192, elements: !111)
!111 = !{!112}
!112 = !DISubrange(count: 256)
!113 = !DIGlobalVariableExpression(var: !114, expr: !DIExpression())
!114 = distinct !DIGlobalVariable(name: "redirect_params", scope: !2, file: !3, line: 60, type: !115, isLocal: false, isDefinition: true)
!115 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 55, size: 256, elements: !116)
!116 = !{!117, !122, !128, !129}
!117 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !115, file: !3, line: 56, baseType: !118, size: 64)
!118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !119, size: 64)
!119 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 32, elements: !120)
!120 = !{!121}
!121 = !DISubrange(count: 1)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !115, file: !3, line: 57, baseType: !123, size: 64, offset: 64)
!123 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !124, size: 64)
!124 = !DICompositeType(tag: DW_TAG_array_type, baseType: !125, size: 48, elements: !126)
!125 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!126 = !{!127}
!127 = !DISubrange(count: 6)
!128 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !115, file: !3, line: 58, baseType: !123, size: 64, offset: 128)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !115, file: !3, line: 59, baseType: !118, size: 64, offset: 192)
!130 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 62, size: 256, elements: !131)
!131 = !{!132, !133, !134, !136}
!132 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !130, file: !3, line: 63, baseType: !66, size: 64)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !130, file: !3, line: 64, baseType: !72, size: 64, offset: 64)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !130, file: !3, line: 65, baseType: !135, size: 64, offset: 128)
!135 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !130, file: !3, line: 66, baseType: !118, size: 64, offset: 192)
!137 = !{i32 7, !"Dwarf Version", i32 4}
!138 = !{i32 2, !"Debug Info Version", i32 3}
!139 = !{i32 1, !"wchar_size", i32 4}
!140 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!141 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !3, file: !3, line: 131, type: !142, scopeLine: 131, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !152)
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
!153 = !DILocalVariable(name: "ctx", arg: 1, scope: !141, file: !3, line: 131, type: !144)
!154 = !DILocalVariable(name: "start", scope: !141, file: !3, line: 132, type: !25)
!155 = !DILocalVariable(name: "data_end", scope: !141, file: !3, line: 134, type: !15)
!156 = !DILocalVariable(name: "data", scope: !141, file: !3, line: 135, type: !15)
!157 = !DILocalVariable(name: "eth", scope: !141, file: !3, line: 137, type: !158)
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
!169 = !DILocalVariable(name: "action", scope: !141, file: !3, line: 138, type: !48)
!170 = !DILocalVariable(name: "queue_len", scope: !141, file: !3, line: 139, type: !25)
!171 = !DILocalVariable(name: "key", scope: !141, file: !3, line: 140, type: !48)
!172 = !DILocalVariable(name: "prev_avg", scope: !141, file: !3, line: 142, type: !135)
!173 = !DILocalVariable(name: "new_avg", scope: !141, file: !3, line: 150, type: !25)
!174 = !DILocalVariable(name: "drop_prob", scope: !175, file: !3, line: 160, type: !25)
!175 = distinct !DILexicalBlock(scope: !176, file: !3, line: 158, column: 10)
!176 = distinct !DILexicalBlock(scope: !177, file: !3, line: 156, column: 14)
!177 = distinct !DILexicalBlock(scope: !141, file: !3, line: 153, column: 7)
!178 = !DILocalVariable(name: "dst", scope: !141, file: !3, line: 176, type: !179)
!179 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 64)
!180 = !DILocalVariable(name: "iface_index", scope: !141, file: !3, line: 183, type: !72)
!181 = !DILabel(scope: !141, name: "out", file: !3, line: 189)
!182 = !DILocation(line: 0, scope: !141)
!183 = !DILocation(line: 132, column: 17, scope: !141)
!184 = !DILocation(line: 134, column: 39, scope: !141)
!185 = !{!186, !187, i64 4}
!186 = !{!"xdp_md", !187, i64 0, !187, i64 4, !187, i64 8, !187, i64 12, !187, i64 16}
!187 = !{!"int", !188, i64 0}
!188 = !{!"omnipotent char", !189, i64 0}
!189 = !{!"Simple C/C++ TBAA"}
!190 = !DILocation(line: 134, column: 28, scope: !141)
!191 = !DILocation(line: 134, column: 20, scope: !141)
!192 = !DILocation(line: 135, column: 35, scope: !141)
!193 = !{!186, !187, i64 0}
!194 = !DILocation(line: 135, column: 24, scope: !141)
!195 = !DILocation(line: 135, column: 16, scope: !141)
!196 = !DILocation(line: 140, column: 3, scope: !141)
!197 = !DILocation(line: 140, column: 9, scope: !141)
!198 = !{!187, !187, i64 0}
!199 = !DILocation(line: 142, column: 21, scope: !141)
!200 = !DILocation(line: 143, column: 8, scope: !201)
!201 = distinct !DILexicalBlock(scope: !141, file: !3, line: 143, column: 7)
!202 = !DILocation(line: 143, column: 7, scope: !141)
!203 = !DILocation(line: 0, scope: !204, inlinedAt: !220)
!204 = distinct !DISubprogram(name: "handle_burst_detection", scope: !3, file: !3, line: 78, type: !205, scopeLine: 78, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !207)
!205 = !DISubroutineType(types: !206)
!206 = !{null, !48}
!207 = !{!208, !209, !210, !211, !212, !213, !216, !219}
!208 = !DILocalVariable(name: "action", arg: 1, scope: !204, file: !3, line: 78, type: !48)
!209 = !DILocalVariable(name: "stats", scope: !204, file: !3, line: 79, type: !74)
!210 = !DILocalVariable(name: "telemetry", scope: !204, file: !3, line: 80, type: !91)
!211 = !DILocalVariable(name: "initial_queue_len", scope: !204, file: !3, line: 81, type: !135)
!212 = !DILocalVariable(name: "delta_time", scope: !204, file: !3, line: 86, type: !25)
!213 = !DILocalVariable(name: "rps", scope: !214, file: !3, line: 90, type: !25)
!214 = distinct !DILexicalBlock(scope: !215, file: !3, line: 89, column: 23)
!215 = distinct !DILexicalBlock(scope: !204, file: !3, line: 89, column: 7)
!216 = !DILocalVariable(name: "key", scope: !217, file: !3, line: 97, type: !48)
!217 = distinct !DILexicalBlock(scope: !218, file: !3, line: 95, column: 35)
!218 = distinct !DILexicalBlock(scope: !214, file: !3, line: 95, column: 9)
!219 = !DILocalVariable(name: "queue_len", scope: !217, file: !3, line: 98, type: !135)
!220 = distinct !DILocation(line: 148, column: 3, scope: !141)
!221 = !DILocation(line: 79, column: 27, scope: !204, inlinedAt: !220)
!222 = !DILocation(line: 80, column: 30, scope: !204, inlinedAt: !220)
!223 = !DILocation(line: 81, column: 67, scope: !204, inlinedAt: !220)
!224 = !DILocation(line: 81, column: 30, scope: !204, inlinedAt: !220)
!225 = !DILocation(line: 83, column: 8, scope: !226, inlinedAt: !220)
!226 = distinct !DILexicalBlock(scope: !204, file: !3, line: 83, column: 7)
!227 = !DILocation(line: 83, column: 14, scope: !226, inlinedAt: !220)
!228 = !DILocation(line: 86, column: 33, scope: !204, inlinedAt: !220)
!229 = !{!230, !231, i64 8}
!230 = !{!"telrec", !231, i64 0, !231, i64 8}
!231 = !{!"long long", !188, i64 0}
!232 = !DILocation(line: 89, column: 18, scope: !215, inlinedAt: !220)
!233 = !DILocation(line: 89, column: 7, scope: !204, inlinedAt: !220)
!234 = !DILocation(line: 90, column: 24, scope: !214, inlinedAt: !220)
!235 = !{!236, !231, i64 0}
!236 = !{!"datarec", !231, i64 0, !231, i64 8}
!237 = !DILocation(line: 90, column: 35, scope: !214, inlinedAt: !220)
!238 = !DILocation(line: 90, column: 48, scope: !214, inlinedAt: !220)
!239 = !DILocation(line: 0, scope: !214, inlinedAt: !220)
!240 = !DILocation(line: 95, column: 15, scope: !218, inlinedAt: !220)
!241 = !{!231, !231, i64 0}
!242 = !DILocation(line: 95, column: 13, scope: !218, inlinedAt: !220)
!243 = !DILocation(line: 95, column: 9, scope: !214, inlinedAt: !220)
!244 = !DILocation(line: 97, column: 7, scope: !217, inlinedAt: !220)
!245 = !DILocation(line: 0, scope: !217, inlinedAt: !220)
!246 = !DILocation(line: 97, column: 13, scope: !217, inlinedAt: !220)
!247 = !DILocation(line: 98, column: 26, scope: !217, inlinedAt: !220)
!248 = !DILocation(line: 99, column: 11, scope: !249, inlinedAt: !220)
!249 = distinct !DILexicalBlock(scope: !217, file: !3, line: 99, column: 11)
!250 = !DILocation(line: 99, column: 11, scope: !217, inlinedAt: !220)
!251 = !DILocation(line: 100, column: 20, scope: !252, inlinedAt: !220)
!252 = distinct !DILexicalBlock(scope: !249, file: !3, line: 99, column: 22)
!253 = !DILocation(line: 101, column: 7, scope: !252, inlinedAt: !220)
!254 = !DILocation(line: 102, column: 5, scope: !218, inlinedAt: !220)
!255 = !DILocation(line: 102, column: 5, scope: !217, inlinedAt: !220)
!256 = !DILocation(line: 104, column: 1, scope: !204, inlinedAt: !220)
!257 = !DILocation(line: 150, column: 43, scope: !141)
!258 = !DILocalVariable(name: "prev_avg", arg: 1, scope: !259, file: !3, line: 69, type: !25)
!259 = distinct !DISubprogram(name: "calculate_avg_queue_len", scope: !3, file: !3, line: 69, type: !260, scopeLine: 70, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !262)
!260 = !DISubroutineType(types: !261)
!261 = !{!25, !25, !25}
!262 = !{!258, !263, !264, !265}
!263 = !DILocalVariable(name: "curr_queue_len", arg: 2, scope: !259, file: !3, line: 70, type: !25)
!264 = !DILocalVariable(name: "weighted_prev_avg", scope: !259, file: !3, line: 73, type: !25)
!265 = !DILocalVariable(name: "weighted_curr_len", scope: !259, file: !3, line: 74, type: !25)
!266 = !DILocation(line: 0, scope: !259, inlinedAt: !267)
!267 = distinct !DILocation(line: 150, column: 19, scope: !141)
!268 = !DILocation(line: 73, column: 55, scope: !259, inlinedAt: !267)
!269 = !DILocation(line: 75, column: 29, scope: !259, inlinedAt: !267)
!270 = !DILocation(line: 75, column: 50, scope: !259, inlinedAt: !267)
!271 = !DILocation(line: 150, column: 9, scope: !141)
!272 = !DILocation(line: 151, column: 45, scope: !141)
!273 = !DILocation(line: 151, column: 3, scope: !141)
!274 = !DILocation(line: 153, column: 7, scope: !177)
!275 = !DILocation(line: 153, column: 15, scope: !177)
!276 = !DILocation(line: 153, column: 7, scope: !141)
!277 = !DILocation(line: 156, column: 22, scope: !176)
!278 = !DILocation(line: 156, column: 14, scope: !177)
!279 = !DILocation(line: 160, column: 66, scope: !175)
!280 = !DILocation(line: 0, scope: !175)
!281 = !DILocation(line: 164, column: 9, scope: !282)
!282 = distinct !DILexicalBlock(scope: !175, file: !3, line: 164, column: 9)
!283 = !DILocation(line: 164, column: 31, scope: !282)
!284 = !DILocation(line: 164, column: 37, scope: !282)
!285 = !DILocation(line: 171, column: 12, scope: !286)
!286 = distinct !DILexicalBlock(scope: !141, file: !3, line: 171, column: 7)
!287 = !DILocation(line: 171, column: 36, scope: !286)
!288 = !DILocation(line: 171, column: 7, scope: !141)
!289 = !DILocation(line: 174, column: 9, scope: !141)
!290 = !DILocation(line: 176, column: 62, scope: !141)
!291 = !DILocation(line: 176, column: 24, scope: !141)
!292 = !DILocation(line: 177, column: 8, scope: !293)
!293 = distinct !DILexicalBlock(scope: !141, file: !3, line: 177, column: 7)
!294 = !DILocation(line: 177, column: 7, scope: !141)
!295 = !DILocation(line: 181, column: 3, scope: !141)
!296 = !DILocation(line: 183, column: 24, scope: !141)
!297 = !DILocation(line: 184, column: 8, scope: !298)
!298 = distinct !DILexicalBlock(scope: !141, file: !3, line: 184, column: 7)
!299 = !DILocation(line: 184, column: 7, scope: !141)
!300 = !DILocation(line: 189, column: 1, scope: !141)
!301 = !DILocation(line: 0, scope: !302, inlinedAt: !311)
!302 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 106, type: !303, scopeLine: 108, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !305)
!303 = !DISubroutineType(types: !304)
!304 = !{!48, !144, !48, !25}
!305 = !{!306, !307, !308, !309, !310}
!306 = !DILocalVariable(name: "ctx", arg: 1, scope: !302, file: !3, line: 106, type: !144)
!307 = !DILocalVariable(name: "action", arg: 2, scope: !302, file: !3, line: 107, type: !48)
!308 = !DILocalVariable(name: "start", arg: 3, scope: !302, file: !3, line: 108, type: !25)
!309 = !DILocalVariable(name: "rec", scope: !302, file: !3, line: 112, type: !74)
!310 = !DILocalVariable(name: "telemetry", scope: !302, file: !3, line: 120, type: !91)
!311 = distinct !DILocation(line: 190, column: 10, scope: !141)
!312 = !DILocation(line: 109, column: 7, scope: !302, inlinedAt: !311)
!313 = !DILocation(line: 187, column: 39, scope: !141)
!314 = !DILocation(line: 187, column: 12, scope: !141)
!315 = !DILocation(line: 109, column: 14, scope: !316, inlinedAt: !311)
!316 = distinct !DILexicalBlock(scope: !302, file: !3, line: 109, column: 7)
!317 = !DILocation(line: 112, column: 25, scope: !302, inlinedAt: !311)
!318 = !DILocation(line: 113, column: 8, scope: !319, inlinedAt: !311)
!319 = distinct !DILexicalBlock(scope: !302, file: !3, line: 113, column: 7)
!320 = !DILocation(line: 113, column: 7, scope: !302, inlinedAt: !311)
!321 = !DILocation(line: 117, column: 8, scope: !302, inlinedAt: !311)
!322 = !DILocation(line: 117, column: 18, scope: !302, inlinedAt: !311)
!323 = !DILocation(line: 118, column: 26, scope: !302, inlinedAt: !311)
!324 = !DILocation(line: 118, column: 42, scope: !302, inlinedAt: !311)
!325 = !DILocation(line: 118, column: 35, scope: !302, inlinedAt: !311)
!326 = !DILocation(line: 118, column: 20, scope: !302, inlinedAt: !311)
!327 = !DILocation(line: 118, column: 8, scope: !302, inlinedAt: !311)
!328 = !DILocation(line: 118, column: 17, scope: !302, inlinedAt: !311)
!329 = !{!236, !231, i64 8}
!330 = !DILocation(line: 120, column: 30, scope: !302, inlinedAt: !311)
!331 = !DILocation(line: 121, column: 8, scope: !332, inlinedAt: !311)
!332 = distinct !DILexicalBlock(scope: !302, file: !3, line: 121, column: 7)
!333 = !DILocation(line: 121, column: 7, scope: !302, inlinedAt: !311)
!334 = !DILocation(line: 124, column: 26, scope: !302, inlinedAt: !311)
!335 = !DILocation(line: 124, column: 14, scope: !302, inlinedAt: !311)
!336 = !DILocation(line: 124, column: 24, scope: !302, inlinedAt: !311)
!337 = !{!230, !231, i64 0}
!338 = !DILocation(line: 125, column: 53, scope: !302, inlinedAt: !311)
!339 = !DILocation(line: 125, column: 14, scope: !302, inlinedAt: !311)
!340 = !DILocation(line: 125, column: 30, scope: !302, inlinedAt: !311)
!341 = !DILocation(line: 127, column: 10, scope: !302, inlinedAt: !311)
!342 = !DILocation(line: 127, column: 3, scope: !302, inlinedAt: !311)
!343 = !DILocation(line: 128, column: 1, scope: !302, inlinedAt: !311)
!344 = !DILocation(line: 190, column: 3, scope: !141)
!345 = !DILocation(line: 191, column: 1, scope: !141)
