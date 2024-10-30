; ModuleID = 'continuous_burst_network/c/kern.c'
source_filename = "continuous_burst_network/c/kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.0 = type { [1 x i32]*, [6 x i8]*, [6 x i8]*, [1 x i32]* }
%struct.anon.1 = type { [14 x i32]*, i32*, i32*, [256 x i32]* }
%struct.anon.2 = type { [2 x i32]*, i32*, %struct.datarec*, [5 x i32]* }
%struct.datarec = type { i64, i64, i64 }
%struct.anon.3 = type { [2 x i32]*, i32*, %struct.telrec*, [5 x i32]* }
%struct.telrec = type { i64, i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@queue_avg_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@redirect_params = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !115
@tx_port = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !99
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !55
@xdp_stats_map = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !61
@telemetry_stats_map = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !85
@llvm.used = appending global [7 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* bitcast (%struct.anon.0* @redirect_params to i8*), i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* bitcast (%struct.anon.1* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_redirect_map_func to i8*), i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_redirect_map_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_redirect_map" !dbg !143 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !155, metadata !DIExpression()), !dbg !185
  %7 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !186
  call void @llvm.dbg.value(metadata i64 %7, metadata !156, metadata !DIExpression()), !dbg !185
  %8 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !187
  %9 = load i32, i32* %8, align 4, !dbg !187, !tbaa !188
  %10 = zext i32 %9 to i64, !dbg !193
  %11 = inttoptr i64 %10 to i8*, !dbg !194
  call void @llvm.dbg.value(metadata i8* %11, metadata !157, metadata !DIExpression()), !dbg !185
  %12 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !195
  %13 = load i32, i32* %12, align 4, !dbg !195, !tbaa !196
  %14 = zext i32 %13 to i64, !dbg !197
  %15 = inttoptr i64 %14 to i8*, !dbg !198
  call void @llvm.dbg.value(metadata i8* %15, metadata !158, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata i32 2, metadata !171, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata i64 50, metadata !172, metadata !DIExpression()), !dbg !185
  %16 = bitcast i32* %5 to i8*, !dbg !199
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %16) #3, !dbg !199
  call void @llvm.dbg.value(metadata i32 0, metadata !173, metadata !DIExpression()), !dbg !185
  store i32 0, i32* %5, align 4, !dbg !200, !tbaa !201
  call void @llvm.dbg.value(metadata i32* %5, metadata !173, metadata !DIExpression(DW_OP_deref)), !dbg !185
  %17 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %16) #3, !dbg !202
  call void @llvm.dbg.value(metadata i8* %17, metadata !174, metadata !DIExpression()), !dbg !185
  %18 = icmp eq i8* %17, null, !dbg !203
  br i1 %18, label %84, label %19, !dbg !205

19:                                               ; preds = %1
  %20 = bitcast i8* %17 to i64*, !dbg !202
  call void @llvm.dbg.value(metadata i64* %20, metadata !174, metadata !DIExpression()), !dbg !185
  %21 = bitcast i32* %3 to i8*, !dbg !206
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %21), !dbg !206
  %22 = bitcast i32* %4 to i8*, !dbg !206
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %22), !dbg !206
  call void @llvm.dbg.value(metadata i32 2, metadata !211, metadata !DIExpression()) #3, !dbg !206
  store i32 2, i32* %3, align 4, !tbaa !201
  call void @llvm.dbg.value(metadata i64 %7, metadata !212, metadata !DIExpression()) #3, !dbg !206
  call void @llvm.dbg.value(metadata i32* %3, metadata !211, metadata !DIExpression(DW_OP_deref)) #3, !dbg !206
  %23 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*), i8* nonnull %21) #3, !dbg !219
  call void @llvm.dbg.value(metadata i8* %23, metadata !213, metadata !DIExpression()) #3, !dbg !206
  %24 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* nonnull %21) #3, !dbg !220
  call void @llvm.dbg.value(metadata i8* %24, metadata !214, metadata !DIExpression()) #3, !dbg !206
  store i32 0, i32* %4, align 4, !dbg !221, !tbaa !201
  %25 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %22) #3, !dbg !222
  call void @llvm.dbg.value(metadata i8* %25, metadata !215, metadata !DIExpression()) #3, !dbg !206
  %26 = icmp ne i8* %23, null, !dbg !223
  %27 = icmp ne i8* %24, null
  %28 = and i1 %26, %27, !dbg !225
  %29 = icmp ne i8* %25, null
  %30 = and i1 %28, %29, !dbg !225
  br i1 %30, label %31, label %51, !dbg !225

31:                                               ; preds = %19
  call void @llvm.dbg.value(metadata i8* %24, metadata !214, metadata !DIExpression()) #3, !dbg !206
  %32 = getelementptr inbounds i8, i8* %24, i64 16, !dbg !226
  %33 = bitcast i8* %32 to i64*, !dbg !226
  %34 = load i64, i64* %33, align 8, !dbg !226, !tbaa !228
  %35 = icmp eq i64 %34, 0, !dbg !231
  br i1 %35, label %41, label %36, !dbg !232

36:                                               ; preds = %31
  %37 = getelementptr inbounds i8, i8* %23, i64 16, !dbg !233
  %38 = bitcast i8* %37 to i64*, !dbg !233
  %39 = load i64, i64* %38, align 8, !dbg !233, !tbaa !234
  %40 = icmp eq i64 %39, 0, !dbg !236
  br i1 %40, label %41, label %46, !dbg !237

41:                                               ; preds = %31, %36
  store i64 %7, i64* %33, align 8, !dbg !238, !tbaa !228
  %42 = bitcast i8* %23 to i64*, !dbg !240
  %43 = load i64, i64* %42, align 8, !dbg !240, !tbaa !241
  %44 = getelementptr inbounds i8, i8* %23, i64 16, !dbg !242
  %45 = bitcast i8* %44 to i64*, !dbg !242
  store i64 %43, i64* %45, align 8, !dbg !243, !tbaa !234
  br label %51, !dbg !244

46:                                               ; preds = %36
  call void @llvm.dbg.value(metadata i64 undef, metadata !216, metadata !DIExpression()) #3, !dbg !206
  %47 = icmp eq i64 %7, %34, !dbg !245
  br i1 %47, label %51, label %48, !dbg !247

48:                                               ; preds = %46
  %49 = bitcast i8* %23 to i64*, !dbg !248
  %50 = load i64, i64* %49, align 8, !dbg !248, !tbaa !241
  call void @llvm.dbg.value(metadata i64 undef, metadata !217, metadata !DIExpression()) #3, !dbg !206
  store i64 %50, i64* %38, align 8, !dbg !249, !tbaa !234
  store i64 %7, i64* %33, align 8, !dbg !250, !tbaa !228
  br label %51

51:                                               ; preds = %19, %41, %46, %48
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %21), !dbg !251
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %22), !dbg !251
  call void @llvm.dbg.value(metadata i32 undef, metadata !175, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !185
  %52 = load i64, i64* %20, align 8, !dbg !252, !tbaa !253
  call void @llvm.dbg.value(metadata i64 %52, metadata !254, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata i64 50, metadata !259, metadata !DIExpression()), !dbg !262
  %53 = mul i64 %52, 998000, !dbg !264
  call void @llvm.dbg.value(metadata i64 %53, metadata !260, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata i64 100000, metadata !261, metadata !DIExpression()), !dbg !262
  %54 = add i64 %53, 100000, !dbg !265
  %55 = udiv i64 %54, 1000000, !dbg !266
  call void @llvm.dbg.value(metadata i64 %55, metadata !176, metadata !DIExpression()), !dbg !185
  store i64 %55, i64* %6, align 8, !dbg !267, !tbaa !253
  %56 = bitcast i64* %6 to i8*, !dbg !268
  call void @llvm.dbg.value(metadata i32* %5, metadata !173, metadata !DIExpression(DW_OP_deref)), !dbg !185
  call void @llvm.dbg.value(metadata i64* %6, metadata !176, metadata !DIExpression(DW_OP_deref)), !dbg !185
  %57 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon* @queue_avg_map to i8*), i8* nonnull %16, i8* nonnull %56, i64 0) #3, !dbg !269
  %58 = load i64, i64* %6, align 8, !dbg !270, !tbaa !253
  call void @llvm.dbg.value(metadata i64 %58, metadata !176, metadata !DIExpression()), !dbg !185
  %59 = icmp ugt i64 %58, 4999, !dbg !271
  br i1 %59, label %71, label %60, !dbg !272

60:                                               ; preds = %51
  %61 = icmp ult i64 %58, 1001, !dbg !273
  br i1 %61, label %71, label %62, !dbg !274

62:                                               ; preds = %60
  %63 = trunc i64 %58 to i32, !dbg !275
  %64 = mul nuw nsw i32 %63, 100, !dbg !275
  %65 = add nsw i32 %64, -100000, !dbg !275
  %66 = udiv i32 %65, 4000, !dbg !275
  call void @llvm.dbg.value(metadata i32 %66, metadata !177, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !276
  %67 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !277
  %68 = urem i32 %67, 100, !dbg !279
  %69 = icmp ugt i32 %66, %68, !dbg !280
  %70 = select i1 %69, i32 1, i32 2, !dbg !281
  call void @llvm.dbg.value(metadata i32 %70, metadata !171, metadata !DIExpression()), !dbg !185
  br label %71

71:                                               ; preds = %60, %51, %62
  %72 = phi i32 [ %70, %62 ], [ 1, %51 ], [ 2, %60 ], !dbg !282
  call void @llvm.dbg.value(metadata i32 %72, metadata !171, metadata !DIExpression()), !dbg !185
  %73 = getelementptr i8, i8* %15, i64 14, !dbg !283
  %74 = icmp ugt i8* %73, %11, !dbg !285
  br i1 %74, label %123, label %75, !dbg !286

75:                                               ; preds = %71
  %76 = inttoptr i64 %14 to %struct.ethhdr*, !dbg !287
  call void @llvm.dbg.value(metadata %struct.ethhdr* %76, metadata !159, metadata !DIExpression()), !dbg !185
  %77 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %76, i64 0, i32 1, i64 0, !dbg !288
  %78 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @redirect_params to i8*), i8* nonnull %77) #3, !dbg !289
  call void @llvm.dbg.value(metadata i8* %78, metadata !181, metadata !DIExpression()), !dbg !185
  %79 = icmp eq i8* %78, null, !dbg !290
  br i1 %79, label %84, label %80, !dbg !292

80:                                               ; preds = %75
  %81 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %76, i64 0, i32 0, i64 0, !dbg !293
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %81, i8* nonnull align 1 dereferenceable(6) %78, i64 6, i1 false), !dbg !293
  call void @llvm.dbg.value(metadata i32* %5, metadata !173, metadata !DIExpression(DW_OP_deref)), !dbg !185
  %82 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i8* nonnull %16) #3, !dbg !294
  call void @llvm.dbg.value(metadata i8* %82, metadata !183, metadata !DIExpression()), !dbg !185
  %83 = icmp eq i8* %82, null, !dbg !295
  br i1 %83, label %84, label %87, !dbg !297

84:                                               ; preds = %80, %75, %1
  %85 = phi i32 [ 1, %1 ], [ %72, %75 ], [ %72, %80 ]
  call void @llvm.dbg.value(metadata i32 %92, metadata !171, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.label(metadata !184), !dbg !298
  %86 = bitcast i32* %2 to i8*, !dbg !299
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %86), !dbg !299
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !304, metadata !DIExpression()) #3, !dbg !299
  call void @llvm.dbg.value(metadata i32 %92, metadata !305, metadata !DIExpression()) #3, !dbg !299
  store i32 %85, i32* %2, align 4, !tbaa !201
  call void @llvm.dbg.value(metadata i64 %7, metadata !306, metadata !DIExpression()) #3, !dbg !299
  br label %95, !dbg !310

87:                                               ; preds = %80
  %88 = bitcast i8* %82 to i32*, !dbg !294
  call void @llvm.dbg.value(metadata i32* %88, metadata !183, metadata !DIExpression()), !dbg !185
  %89 = load i32, i32* %88, align 4, !dbg !311, !tbaa !201
  %90 = zext i32 %89 to i64, !dbg !311
  %91 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.1* @tx_port to i8*), i64 %90, i64 0) #3, !dbg !312
  %92 = trunc i64 %91 to i32, !dbg !312
  call void @llvm.dbg.value(metadata i32 %92, metadata !171, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.label(metadata !184), !dbg !298
  %93 = bitcast i32* %2 to i8*, !dbg !299
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %93), !dbg !299
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !304, metadata !DIExpression()) #3, !dbg !299
  call void @llvm.dbg.value(metadata i32 %92, metadata !305, metadata !DIExpression()) #3, !dbg !299
  store i32 %92, i32* %2, align 4, !tbaa !201
  call void @llvm.dbg.value(metadata i64 %7, metadata !306, metadata !DIExpression()) #3, !dbg !299
  %94 = icmp ugt i32 %92, 4, !dbg !313
  br i1 %94, label %120, label %95, !dbg !310

95:                                               ; preds = %84, %87
  %96 = phi i8* [ %86, %84 ], [ %93, %87 ]
  call void @llvm.dbg.value(metadata i32* %2, metadata !305, metadata !DIExpression(DW_OP_deref)) #3, !dbg !299
  %97 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @xdp_stats_map to i8*), i8* nonnull %96) #3, !dbg !315
  call void @llvm.dbg.value(metadata i8* %97, metadata !307, metadata !DIExpression()) #3, !dbg !299
  %98 = icmp eq i8* %97, null, !dbg !316
  br i1 %98, label %120, label %99, !dbg !318

99:                                               ; preds = %95
  call void @llvm.dbg.value(metadata i8* %97, metadata !307, metadata !DIExpression()) #3, !dbg !299
  %100 = bitcast i8* %97 to i64*, !dbg !319
  %101 = load i64, i64* %100, align 8, !dbg !320, !tbaa !241
  %102 = add i64 %101, 1, !dbg !320
  store i64 %102, i64* %100, align 8, !dbg !320, !tbaa !241
  %103 = load i32, i32* %8, align 4, !dbg !321, !tbaa !188
  %104 = load i32, i32* %12, align 4, !dbg !322, !tbaa !196
  %105 = sub i32 %103, %104, !dbg !323
  %106 = zext i32 %105 to i64, !dbg !324
  %107 = getelementptr inbounds i8, i8* %97, i64 8, !dbg !325
  %108 = bitcast i8* %107 to i64*, !dbg !325
  %109 = load i64, i64* %108, align 8, !dbg !326, !tbaa !327
  %110 = add i64 %109, %106, !dbg !326
  store i64 %110, i64* %108, align 8, !dbg !326, !tbaa !327
  call void @llvm.dbg.value(metadata i32* %2, metadata !305, metadata !DIExpression(DW_OP_deref)) #3, !dbg !299
  %111 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @telemetry_stats_map to i8*), i8* nonnull %96) #3, !dbg !328
  call void @llvm.dbg.value(metadata i8* %111, metadata !308, metadata !DIExpression()) #3, !dbg !299
  %112 = icmp eq i8* %111, null, !dbg !329
  br i1 %112, label %120, label %113, !dbg !331

113:                                              ; preds = %99
  call void @llvm.dbg.value(metadata i8* %111, metadata !308, metadata !DIExpression()) #3, !dbg !299
  %114 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !332
  %115 = bitcast i8* %111 to i64*, !dbg !333
  store i64 %114, i64* %115, align 8, !dbg !334, !tbaa !335
  %116 = sub i64 %114, %7, !dbg !336
  %117 = getelementptr inbounds i8, i8* %111, i64 8, !dbg !337
  %118 = bitcast i8* %117 to i64*, !dbg !337
  store i64 %116, i64* %118, align 8, !dbg !338, !tbaa !339
  %119 = load i32, i32* %2, align 4, !dbg !340, !tbaa !201
  call void @llvm.dbg.value(metadata i32 %119, metadata !305, metadata !DIExpression()) #3, !dbg !299
  br label %120, !dbg !341

120:                                              ; preds = %87, %95, %99, %113
  %121 = phi i8* [ %93, %87 ], [ %96, %95 ], [ %96, %113 ], [ %96, %99 ]
  %122 = phi i32 [ 0, %87 ], [ 0, %95 ], [ %119, %113 ], [ 0, %99 ], !dbg !299
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %121), !dbg !342
  br label %123, !dbg !343

123:                                              ; preds = %71, %120
  %124 = phi i32 [ %122, %120 ], [ 1, %71 ], !dbg !185
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %16) #3, !dbg !344
  ret i32 %124, !dbg !344
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
!17 = !{!18, !28, !36, !42, !49, !55, !61, !85, !99, !115, !0}
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
!56 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 195, type: !57, isLocal: false, isDefinition: true)
!57 = !DICompositeType(tag: DW_TAG_array_type, baseType: !58, size: 32, elements: !59)
!58 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!59 = !{!60}
!60 = !DISubrange(count: 4)
!61 = !DIGlobalVariableExpression(var: !62, expr: !DIExpression())
!62 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 41, type: !63, isLocal: false, isDefinition: true)
!63 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 36, size: 256, elements: !64)
!64 = !{!65, !71, !73, !80}
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
!75 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !3, line: 24, size: 192, elements: !76)
!76 = !{!77, !78, !79}
!77 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !75, file: !3, line: 25, baseType: !25, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !75, file: !3, line: 26, baseType: !25, size: 64, offset: 64)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "last_rxpackets", scope: !75, file: !3, line: 27, baseType: !25, size: 64, offset: 128)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !63, file: !3, line: 40, baseType: !81, size: 64, offset: 192)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!82 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 160, elements: !83)
!83 = !{!84}
!84 = !DISubrange(count: 5)
!85 = !DIGlobalVariableExpression(var: !86, expr: !DIExpression())
!86 = distinct !DIGlobalVariable(name: "telemetry_stats_map", scope: !2, file: !3, line: 48, type: !87, isLocal: false, isDefinition: true)
!87 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 43, size: 256, elements: !88)
!88 = !{!89, !90, !91, !98}
!89 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !87, file: !3, line: 44, baseType: !66, size: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !87, file: !3, line: 45, baseType: !72, size: 64, offset: 64)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !87, file: !3, line: 46, baseType: !92, size: 64, offset: 128)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !93, size: 64)
!93 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "telrec", file: !3, line: 30, size: 192, elements: !94)
!94 = !{!95, !96, !97}
!95 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !93, file: !3, line: 31, baseType: !25, size: 64)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time", scope: !93, file: !3, line: 32, baseType: !25, size: 64, offset: 64)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "last_timestamp", scope: !93, file: !3, line: 33, baseType: !25, size: 64, offset: 128)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !87, file: !3, line: 47, baseType: !81, size: 64, offset: 192)
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
!143 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !3, file: !3, line: 138, type: !144, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !154)
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
!154 = !{!155, !156, !157, !158, !159, !171, !172, !173, !174, !175, !176, !177, !181, !183, !184}
!155 = !DILocalVariable(name: "ctx", arg: 1, scope: !143, file: !3, line: 138, type: !146)
!156 = !DILocalVariable(name: "start", scope: !143, file: !3, line: 139, type: !25)
!157 = !DILocalVariable(name: "data_end", scope: !143, file: !3, line: 140, type: !15)
!158 = !DILocalVariable(name: "data", scope: !143, file: !3, line: 141, type: !15)
!159 = !DILocalVariable(name: "eth", scope: !143, file: !3, line: 143, type: !160)
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
!171 = !DILocalVariable(name: "action", scope: !143, file: !3, line: 144, type: !48)
!172 = !DILocalVariable(name: "queue_len", scope: !143, file: !3, line: 145, type: !25)
!173 = !DILocalVariable(name: "key", scope: !143, file: !3, line: 146, type: !48)
!174 = !DILocalVariable(name: "prev_avg", scope: !143, file: !3, line: 148, type: !137)
!175 = !DILocalVariable(name: "is_burst", scope: !143, file: !3, line: 154, type: !25)
!176 = !DILocalVariable(name: "new_avg", scope: !143, file: !3, line: 158, type: !25)
!177 = !DILocalVariable(name: "drop_prob", scope: !178, file: !3, line: 166, type: !25)
!178 = distinct !DILexicalBlock(scope: !179, file: !3, line: 165, column: 10)
!179 = distinct !DILexicalBlock(scope: !180, file: !3, line: 163, column: 14)
!180 = distinct !DILexicalBlock(scope: !143, file: !3, line: 161, column: 7)
!181 = !DILocalVariable(name: "dst", scope: !143, file: !3, line: 179, type: !182)
!182 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !127, size: 64)
!183 = !DILocalVariable(name: "iface_index", scope: !143, file: !3, line: 185, type: !72)
!184 = !DILabel(scope: !143, name: "out", file: !3, line: 191)
!185 = !DILocation(line: 0, scope: !143)
!186 = !DILocation(line: 139, column: 17, scope: !143)
!187 = !DILocation(line: 140, column: 39, scope: !143)
!188 = !{!189, !190, i64 4}
!189 = !{!"xdp_md", !190, i64 0, !190, i64 4, !190, i64 8, !190, i64 12, !190, i64 16}
!190 = !{!"int", !191, i64 0}
!191 = !{!"omnipotent char", !192, i64 0}
!192 = !{!"Simple C/C++ TBAA"}
!193 = !DILocation(line: 140, column: 28, scope: !143)
!194 = !DILocation(line: 140, column: 20, scope: !143)
!195 = !DILocation(line: 141, column: 35, scope: !143)
!196 = !{!189, !190, i64 0}
!197 = !DILocation(line: 141, column: 24, scope: !143)
!198 = !DILocation(line: 141, column: 16, scope: !143)
!199 = !DILocation(line: 146, column: 3, scope: !143)
!200 = !DILocation(line: 146, column: 9, scope: !143)
!201 = !{!190, !190, i64 0}
!202 = !DILocation(line: 148, column: 21, scope: !143)
!203 = !DILocation(line: 149, column: 8, scope: !204)
!204 = distinct !DILexicalBlock(scope: !143, file: !3, line: 149, column: 7)
!205 = !DILocation(line: 149, column: 7, scope: !143)
!206 = !DILocation(line: 0, scope: !207, inlinedAt: !218)
!207 = distinct !DISubprogram(name: "handle_burst_detection", scope: !3, file: !3, line: 81, type: !208, scopeLine: 82, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !210)
!208 = !DISubroutineType(types: !209)
!209 = !{!68, !48, !25}
!210 = !{!211, !212, !213, !214, !215, !216, !217}
!211 = !DILocalVariable(name: "action", arg: 1, scope: !207, file: !3, line: 81, type: !48)
!212 = !DILocalVariable(name: "current_time", arg: 2, scope: !207, file: !3, line: 82, type: !25)
!213 = !DILocalVariable(name: "stats", scope: !207, file: !3, line: 83, type: !74)
!214 = !DILocalVariable(name: "telemetry", scope: !207, file: !3, line: 84, type: !92)
!215 = !DILocalVariable(name: "queue_len", scope: !207, file: !3, line: 85, type: !137)
!216 = !DILocalVariable(name: "elapsed_time", scope: !207, file: !3, line: 96, type: !25)
!217 = !DILocalVariable(name: "rps", scope: !207, file: !3, line: 101, type: !25)
!218 = distinct !DILocation(line: 154, column: 20, scope: !143)
!219 = !DILocation(line: 83, column: 27, scope: !207, inlinedAt: !218)
!220 = !DILocation(line: 84, column: 30, scope: !207, inlinedAt: !218)
!221 = !DILocation(line: 85, column: 59, scope: !207, inlinedAt: !218)
!222 = !DILocation(line: 85, column: 22, scope: !207, inlinedAt: !218)
!223 = !DILocation(line: 87, column: 8, scope: !224, inlinedAt: !218)
!224 = distinct !DILexicalBlock(scope: !207, file: !3, line: 87, column: 7)
!225 = !DILocation(line: 87, column: 14, scope: !224, inlinedAt: !218)
!226 = !DILocation(line: 90, column: 18, scope: !227, inlinedAt: !218)
!227 = distinct !DILexicalBlock(scope: !207, file: !3, line: 90, column: 7)
!228 = !{!229, !230, i64 16}
!229 = !{!"telrec", !230, i64 0, !230, i64 8, !230, i64 16}
!230 = !{!"long long", !191, i64 0}
!231 = !DILocation(line: 90, column: 33, scope: !227, inlinedAt: !218)
!232 = !DILocation(line: 90, column: 38, scope: !227, inlinedAt: !218)
!233 = !DILocation(line: 90, column: 48, scope: !227, inlinedAt: !218)
!234 = !{!235, !230, i64 16}
!235 = !{!"datarec", !230, i64 0, !230, i64 8, !230, i64 16}
!236 = !DILocation(line: 90, column: 63, scope: !227, inlinedAt: !218)
!237 = !DILocation(line: 90, column: 7, scope: !207, inlinedAt: !218)
!238 = !DILocation(line: 91, column: 31, scope: !239, inlinedAt: !218)
!239 = distinct !DILexicalBlock(scope: !227, file: !3, line: 90, column: 69)
!240 = !DILocation(line: 92, column: 36, scope: !239, inlinedAt: !218)
!241 = !{!235, !230, i64 0}
!242 = !DILocation(line: 92, column: 12, scope: !239, inlinedAt: !218)
!243 = !DILocation(line: 92, column: 27, scope: !239, inlinedAt: !218)
!244 = !DILocation(line: 93, column: 5, scope: !239, inlinedAt: !218)
!245 = !DILocation(line: 98, column: 20, scope: !246, inlinedAt: !218)
!246 = distinct !DILexicalBlock(scope: !207, file: !3, line: 98, column: 7)
!247 = !DILocation(line: 98, column: 7, scope: !207, inlinedAt: !218)
!248 = !DILocation(line: 101, column: 23, scope: !207, inlinedAt: !218)
!249 = !DILocation(line: 103, column: 25, scope: !207, inlinedAt: !218)
!250 = !DILocation(line: 104, column: 29, scope: !207, inlinedAt: !218)
!251 = !DILocation(line: 110, column: 1, scope: !207, inlinedAt: !218)
!252 = !DILocation(line: 158, column: 43, scope: !143)
!253 = !{!230, !230, i64 0}
!254 = !DILocalVariable(name: "prev_avg", arg: 1, scope: !255, file: !3, line: 71, type: !25)
!255 = distinct !DISubprogram(name: "calculate_avg_queue_len", scope: !3, file: !3, line: 71, type: !256, scopeLine: 72, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !258)
!256 = !DISubroutineType(types: !257)
!257 = !{!25, !25, !25}
!258 = !{!254, !259, !260, !261}
!259 = !DILocalVariable(name: "curr_queue_len", arg: 2, scope: !255, file: !3, line: 72, type: !25)
!260 = !DILocalVariable(name: "weighted_prev_avg", scope: !255, file: !3, line: 73, type: !25)
!261 = !DILocalVariable(name: "weighted_curr_len", scope: !255, file: !3, line: 74, type: !25)
!262 = !DILocation(line: 0, scope: !255, inlinedAt: !263)
!263 = distinct !DILocation(line: 158, column: 19, scope: !143)
!264 = !DILocation(line: 73, column: 55, scope: !255, inlinedAt: !263)
!265 = !DILocation(line: 75, column: 29, scope: !255, inlinedAt: !263)
!266 = !DILocation(line: 75, column: 50, scope: !255, inlinedAt: !263)
!267 = !DILocation(line: 158, column: 9, scope: !143)
!268 = !DILocation(line: 159, column: 45, scope: !143)
!269 = !DILocation(line: 159, column: 3, scope: !143)
!270 = !DILocation(line: 161, column: 7, scope: !180)
!271 = !DILocation(line: 161, column: 15, scope: !180)
!272 = !DILocation(line: 161, column: 7, scope: !143)
!273 = !DILocation(line: 163, column: 22, scope: !179)
!274 = !DILocation(line: 163, column: 14, scope: !180)
!275 = !DILocation(line: 166, column: 66, scope: !178)
!276 = !DILocation(line: 0, scope: !178)
!277 = !DILocation(line: 169, column: 9, scope: !278)
!278 = distinct !DILexicalBlock(scope: !178, file: !3, line: 169, column: 9)
!279 = !DILocation(line: 169, column: 31, scope: !278)
!280 = !DILocation(line: 169, column: 37, scope: !278)
!281 = !DILocation(line: 169, column: 9, scope: !178)
!282 = !DILocation(line: 0, scope: !180)
!283 = !DILocation(line: 174, column: 12, scope: !284)
!284 = distinct !DILexicalBlock(scope: !143, file: !3, line: 174, column: 7)
!285 = !DILocation(line: 174, column: 36, scope: !284)
!286 = !DILocation(line: 174, column: 7, scope: !143)
!287 = !DILocation(line: 177, column: 9, scope: !143)
!288 = !DILocation(line: 179, column: 62, scope: !143)
!289 = !DILocation(line: 179, column: 24, scope: !143)
!290 = !DILocation(line: 180, column: 8, scope: !291)
!291 = distinct !DILexicalBlock(scope: !143, file: !3, line: 180, column: 7)
!292 = !DILocation(line: 180, column: 7, scope: !143)
!293 = !DILocation(line: 183, column: 3, scope: !143)
!294 = !DILocation(line: 185, column: 24, scope: !143)
!295 = !DILocation(line: 186, column: 8, scope: !296)
!296 = distinct !DILexicalBlock(scope: !143, file: !3, line: 186, column: 7)
!297 = !DILocation(line: 186, column: 7, scope: !143)
!298 = !DILocation(line: 191, column: 1, scope: !143)
!299 = !DILocation(line: 0, scope: !300, inlinedAt: !309)
!300 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 112, type: !301, scopeLine: 114, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !303)
!301 = !DISubroutineType(types: !302)
!302 = !{!48, !146, !48, !25}
!303 = !{!304, !305, !306, !307, !308}
!304 = !DILocalVariable(name: "ctx", arg: 1, scope: !300, file: !3, line: 112, type: !146)
!305 = !DILocalVariable(name: "action", arg: 2, scope: !300, file: !3, line: 113, type: !48)
!306 = !DILocalVariable(name: "start", arg: 3, scope: !300, file: !3, line: 114, type: !25)
!307 = !DILocalVariable(name: "rec", scope: !300, file: !3, line: 118, type: !74)
!308 = !DILocalVariable(name: "telemetry", scope: !300, file: !3, line: 126, type: !92)
!309 = distinct !DILocation(line: 192, column: 10, scope: !143)
!310 = !DILocation(line: 115, column: 7, scope: !300, inlinedAt: !309)
!311 = !DILocation(line: 189, column: 39, scope: !143)
!312 = !DILocation(line: 189, column: 12, scope: !143)
!313 = !DILocation(line: 115, column: 14, scope: !314, inlinedAt: !309)
!314 = distinct !DILexicalBlock(scope: !300, file: !3, line: 115, column: 7)
!315 = !DILocation(line: 118, column: 25, scope: !300, inlinedAt: !309)
!316 = !DILocation(line: 119, column: 8, scope: !317, inlinedAt: !309)
!317 = distinct !DILexicalBlock(scope: !300, file: !3, line: 119, column: 7)
!318 = !DILocation(line: 119, column: 7, scope: !300, inlinedAt: !309)
!319 = !DILocation(line: 123, column: 8, scope: !300, inlinedAt: !309)
!320 = !DILocation(line: 123, column: 18, scope: !300, inlinedAt: !309)
!321 = !DILocation(line: 124, column: 26, scope: !300, inlinedAt: !309)
!322 = !DILocation(line: 124, column: 42, scope: !300, inlinedAt: !309)
!323 = !DILocation(line: 124, column: 35, scope: !300, inlinedAt: !309)
!324 = !DILocation(line: 124, column: 20, scope: !300, inlinedAt: !309)
!325 = !DILocation(line: 124, column: 8, scope: !300, inlinedAt: !309)
!326 = !DILocation(line: 124, column: 17, scope: !300, inlinedAt: !309)
!327 = !{!235, !230, i64 8}
!328 = !DILocation(line: 126, column: 30, scope: !300, inlinedAt: !309)
!329 = !DILocation(line: 127, column: 8, scope: !330, inlinedAt: !309)
!330 = distinct !DILexicalBlock(scope: !300, file: !3, line: 127, column: 7)
!331 = !DILocation(line: 127, column: 7, scope: !300, inlinedAt: !309)
!332 = !DILocation(line: 130, column: 26, scope: !300, inlinedAt: !309)
!333 = !DILocation(line: 130, column: 14, scope: !300, inlinedAt: !309)
!334 = !DILocation(line: 130, column: 24, scope: !300, inlinedAt: !309)
!335 = !{!229, !230, i64 0}
!336 = !DILocation(line: 131, column: 53, scope: !300, inlinedAt: !309)
!337 = !DILocation(line: 131, column: 14, scope: !300, inlinedAt: !309)
!338 = !DILocation(line: 131, column: 30, scope: !300, inlinedAt: !309)
!339 = !{!229, !230, i64 8}
!340 = !DILocation(line: 133, column: 10, scope: !300, inlinedAt: !309)
!341 = !DILocation(line: 133, column: 3, scope: !300, inlinedAt: !309)
!342 = !DILocation(line: 134, column: 1, scope: !300, inlinedAt: !309)
!343 = !DILocation(line: 192, column: 3, scope: !143)
!344 = !DILocation(line: 193, column: 1, scope: !143)
