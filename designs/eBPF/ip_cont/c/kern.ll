; ModuleID = 'continuous_burst_network/c/kern.c'
source_filename = "continuous_burst_network/c/kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, %struct.datarec*, [5 x i32]* }
%struct.datarec = type { i64, i64 }
%struct.anon.0 = type { [2 x i32]*, i32*, %struct.telrec*, [5 x i32]* }
%struct.telrec = type { i64, i64 }
%struct.anon.1 = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.2 = type { [1 x i32]*, [6 x i8]*, [6 x i8]*, [1 x i32]* }
%struct.anon.3 = type { [14 x i32]*, i32*, i32*, [256 x i32]* }
%struct.anon.4 = type { [2 x i32]*, i32*, i64*, [5 x i32]* }
%struct.anon.5 = type { [2 x i32]*, i32*, i64*, [5 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@xdp_stats_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@telemetry_stats_map = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !61
@queue_avg_map = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !117
@redirect_params = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !100
@tx_port = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !84
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !55
@last_timestamp_map = dso_local global %struct.anon.4 zeroinitializer, section ".maps", align 8, !dbg !126
@request_count_map = dso_local global %struct.anon.5 zeroinitializer, section ".maps", align 8, !dbg !134
@llvm.used = appending global [9 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.4* @last_timestamp_map to i8*), i8* bitcast (%struct.anon.1* @queue_avg_map to i8*), i8* bitcast (%struct.anon.2* @redirect_params to i8*), i8* bitcast (%struct.anon.5* @request_count_map to i8*), i8* bitcast (%struct.anon.0* @telemetry_stats_map to i8*), i8* bitcast (%struct.anon.3* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_redirect_map_func to i8*), i8* bitcast (%struct.anon* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_redirect_map_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_redirect_map" !dbg !157 {
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !169, metadata !DIExpression()), !dbg !201
  %9 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !202
  call void @llvm.dbg.value(metadata i64 %9, metadata !170, metadata !DIExpression()), !dbg !201
  %10 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !203
  %11 = load i32, i32* %10, align 4, !dbg !203, !tbaa !204
  %12 = zext i32 %11 to i64, !dbg !209
  %13 = inttoptr i64 %12 to i8*, !dbg !210
  call void @llvm.dbg.value(metadata i8* %13, metadata !171, metadata !DIExpression()), !dbg !201
  %14 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !211
  %15 = load i32, i32* %14, align 4, !dbg !211, !tbaa !212
  %16 = zext i32 %15 to i64, !dbg !213
  %17 = inttoptr i64 %16 to i8*, !dbg !214
  call void @llvm.dbg.value(metadata i8* %17, metadata !172, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.value(metadata i32 2, metadata !185, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.value(metadata i64 50, metadata !186, metadata !DIExpression()), !dbg !201
  %18 = bitcast i32* %7 to i8*, !dbg !215
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %18) #3, !dbg !215
  call void @llvm.dbg.value(metadata i32 0, metadata !187, metadata !DIExpression()), !dbg !201
  store i32 0, i32* %7, align 4, !dbg !216, !tbaa !217
  call void @llvm.dbg.value(metadata i32* %7, metadata !187, metadata !DIExpression(DW_OP_deref)), !dbg !201
  %19 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @xdp_stats_map to i8*), i8* nonnull %18) #3, !dbg !218
  call void @llvm.dbg.value(metadata i8* %19, metadata !188, metadata !DIExpression()), !dbg !201
  %20 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @telemetry_stats_map to i8*), i8* nonnull %18) #3, !dbg !219
  call void @llvm.dbg.value(metadata i8* %20, metadata !189, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.value(metadata i32 0, metadata !190, metadata !DIExpression()), !dbg !201
  %21 = icmp ne i8* %19, null, !dbg !220
  %22 = icmp ne i8* %20, null
  %23 = and i1 %21, %22, !dbg !222
  br i1 %23, label %24, label %57, !dbg !222

24:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* %20, metadata !189, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.value(metadata i8* %19, metadata !188, metadata !DIExpression()), !dbg !201
  %25 = load i32, i32* %7, align 4, !dbg !223, !tbaa !217
  call void @llvm.dbg.value(metadata i32 %25, metadata !187, metadata !DIExpression()), !dbg !201
  %26 = bitcast i32* %5 to i8*, !dbg !225
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %26), !dbg !225
  call void @llvm.dbg.value(metadata i32 %25, metadata !230, metadata !DIExpression()) #3, !dbg !225
  store i32 %25, i32* %5, align 4, !tbaa !217
  call void @llvm.dbg.value(metadata i8* %19, metadata !231, metadata !DIExpression()) #3, !dbg !225
  call void @llvm.dbg.value(metadata i8* %20, metadata !232, metadata !DIExpression()) #3, !dbg !225
  call void @llvm.dbg.value(metadata i32* %5, metadata !230, metadata !DIExpression(DW_OP_deref)) #3, !dbg !225
  %27 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.4* @last_timestamp_map to i8*), i8* nonnull %26) #3, !dbg !248
  call void @llvm.dbg.value(metadata i8* %27, metadata !233, metadata !DIExpression()) #3, !dbg !225
  %28 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.5* @request_count_map to i8*), i8* nonnull %26) #3, !dbg !249
  %29 = bitcast i8* %28 to i64*, !dbg !249
  call void @llvm.dbg.value(metadata i64* %29, metadata !234, metadata !DIExpression()) #3, !dbg !225
  %30 = icmp ne i8* %27, null, !dbg !250
  %31 = icmp ne i8* %28, null
  %32 = and i1 %30, %31, !dbg !252
  br i1 %32, label %33, label %56, !dbg !252

33:                                               ; preds = %24
  call void @llvm.dbg.value(metadata i8* %20, metadata !232, metadata !DIExpression()) #3, !dbg !225
  call void @llvm.dbg.value(metadata i8* %20, metadata !189, metadata !DIExpression()), !dbg !201
  %34 = bitcast i8* %27 to i64*, !dbg !248
  call void @llvm.dbg.value(metadata i64* %34, metadata !233, metadata !DIExpression()) #3, !dbg !225
  %35 = bitcast i8* %20 to i64*, !dbg !253
  %36 = load i64, i64* %35, align 8, !dbg !253, !tbaa !254
  %37 = load i64, i64* %34, align 8, !dbg !257, !tbaa !258
  %38 = sub i64 %36, %37, !dbg !259
  call void @llvm.dbg.value(metadata i64 %38, metadata !235, metadata !DIExpression()) #3, !dbg !225
  call void @llvm.dbg.value(metadata i64 undef, metadata !236, metadata !DIExpression()) #3, !dbg !225
  %39 = icmp ult i64 %38, 1000000000, !dbg !260
  br i1 %39, label %56, label %40, !dbg !261

40:                                               ; preds = %33
  %41 = udiv i64 %38, 1000000000, !dbg !262
  call void @llvm.dbg.value(metadata i64 %41, metadata !236, metadata !DIExpression()) #3, !dbg !225
  %42 = bitcast i8* %19 to i64*, !dbg !263
  %43 = load i64, i64* %42, align 8, !dbg !263, !tbaa !264
  %44 = load i64, i64* %29, align 8, !dbg !266, !tbaa !258
  %45 = sub i64 %43, %44, !dbg !267
  call void @llvm.dbg.value(metadata i64 %45, metadata !237, metadata !DIExpression()) #3, !dbg !268
  %46 = udiv i64 %45, %41, !dbg !269
  call void @llvm.dbg.value(metadata i64 %46, metadata !240, metadata !DIExpression()) #3, !dbg !268
  call void @llvm.dbg.value(metadata i32* %5, metadata !230, metadata !DIExpression(DW_OP_deref)) #3, !dbg !225
  %47 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.5* @request_count_map to i8*), i8* nonnull %26, i8* nonnull %19, i64 0) #3, !dbg !270
  %48 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.4* @last_timestamp_map to i8*), i8* nonnull %26, i8* nonnull %20, i64 0) #3, !dbg !271
  %49 = icmp ugt i64 %46, 1, !dbg !272
  br i1 %49, label %50, label %56, !dbg !273

50:                                               ; preds = %40
  call void @llvm.dbg.value(metadata i32* %5, metadata !230, metadata !DIExpression(DW_OP_deref)) #3, !dbg !225
  %51 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @queue_avg_map to i8*), i8* nonnull %26) #3, !dbg !274
  call void @llvm.dbg.value(metadata i8* %51, metadata !241, metadata !DIExpression()) #3, !dbg !275
  %52 = icmp eq i8* %51, null, !dbg !276
  br i1 %52, label %56, label %53, !dbg !277

53:                                               ; preds = %50
  %54 = bitcast i64* %6 to i8*, !dbg !278
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %54) #3, !dbg !278
  call void @llvm.dbg.value(metadata i64 3000, metadata !244, metadata !DIExpression()) #3, !dbg !279
  store i64 3000, i64* %6, align 8, !dbg !280, !tbaa !258
  call void @llvm.dbg.value(metadata i32* %5, metadata !230, metadata !DIExpression(DW_OP_deref)) #3, !dbg !225
  call void @llvm.dbg.value(metadata i64* %6, metadata !244, metadata !DIExpression(DW_OP_deref)) #3, !dbg !279
  %55 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.1* @queue_avg_map to i8*), i8* nonnull %26, i8* nonnull %54, i64 0) #3, !dbg !281
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %54) #3, !dbg !282
  br label %56

56:                                               ; preds = %24, %33, %40, %50, %53
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %26), !dbg !283
  call void @llvm.dbg.value(metadata i32 0, metadata !190, metadata !DIExpression()), !dbg !201
  br label %57, !dbg !284

57:                                               ; preds = %1, %56
  call void @llvm.dbg.value(metadata i32 0, metadata !190, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.value(metadata i64 50, metadata !186, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.value(metadata i32* %7, metadata !187, metadata !DIExpression(DW_OP_deref)), !dbg !201
  %58 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @queue_avg_map to i8*), i8* nonnull %18) #3, !dbg !285
  call void @llvm.dbg.value(metadata i8* %58, metadata !191, metadata !DIExpression()), !dbg !201
  %59 = icmp eq i8* %58, null, !dbg !286
  br i1 %59, label %82, label %60, !dbg !288

60:                                               ; preds = %57
  %61 = bitcast i8* %58 to i64*, !dbg !285
  call void @llvm.dbg.value(metadata i64* %61, metadata !191, metadata !DIExpression()), !dbg !201
  %62 = load i64, i64* %61, align 8, !dbg !289, !tbaa !258
  call void @llvm.dbg.value(metadata i64 %62, metadata !290, metadata !DIExpression()), !dbg !298
  call void @llvm.dbg.value(metadata i64 50, metadata !295, metadata !DIExpression()), !dbg !298
  %63 = mul i64 %62, 998000, !dbg !300
  call void @llvm.dbg.value(metadata i64 %63, metadata !296, metadata !DIExpression()), !dbg !298
  call void @llvm.dbg.value(metadata i64 100000, metadata !297, metadata !DIExpression()), !dbg !298
  %64 = add i64 %63, 100000, !dbg !301
  %65 = udiv i64 %64, 1000000, !dbg !302
  call void @llvm.dbg.value(metadata i64 %65, metadata !192, metadata !DIExpression()), !dbg !201
  store i64 %65, i64* %8, align 8, !dbg !303, !tbaa !258
  %66 = bitcast i64* %8 to i8*, !dbg !304
  call void @llvm.dbg.value(metadata i32* %7, metadata !187, metadata !DIExpression(DW_OP_deref)), !dbg !201
  call void @llvm.dbg.value(metadata i64* %8, metadata !192, metadata !DIExpression(DW_OP_deref)), !dbg !201
  %67 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.1* @queue_avg_map to i8*), i8* nonnull %18, i8* nonnull %66, i64 0) #3, !dbg !305
  %68 = load i64, i64* %8, align 8, !dbg !306, !tbaa !258
  call void @llvm.dbg.value(metadata i64 %68, metadata !192, metadata !DIExpression()), !dbg !201
  %69 = icmp ugt i64 %68, 1, !dbg !307
  br i1 %69, label %82, label %70, !dbg !308

70:                                               ; preds = %60
  call void @llvm.dbg.value(metadata i32 2, metadata !185, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.value(metadata i32 2, metadata !185, metadata !DIExpression()), !dbg !201
  %71 = getelementptr i8, i8* %17, i64 14, !dbg !309
  %72 = icmp ugt i8* %71, %13, !dbg !311
  br i1 %72, label %157, label %73, !dbg !312

73:                                               ; preds = %70
  %74 = inttoptr i64 %16 to %struct.ethhdr*, !dbg !313
  call void @llvm.dbg.value(metadata %struct.ethhdr* %74, metadata !173, metadata !DIExpression()), !dbg !201
  %75 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %74, i64 0, i32 1, i64 0, !dbg !314
  %76 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @redirect_params to i8*), i8* nonnull %75) #3, !dbg !315
  call void @llvm.dbg.value(metadata i8* %76, metadata !197, metadata !DIExpression()), !dbg !201
  %77 = icmp eq i8* %76, null, !dbg !316
  br i1 %77, label %82, label %78, !dbg !318

78:                                               ; preds = %73
  %79 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %74, i64 0, i32 0, i64 0, !dbg !319
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %79, i8* nonnull align 1 dereferenceable(6) %76, i64 6, i1 false), !dbg !319
  call void @llvm.dbg.value(metadata i32* %7, metadata !187, metadata !DIExpression(DW_OP_deref)), !dbg !201
  %80 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @tx_port to i8*), i8* nonnull %18) #3, !dbg !320
  call void @llvm.dbg.value(metadata i8* %80, metadata !199, metadata !DIExpression()), !dbg !201
  %81 = icmp eq i8* %80, null, !dbg !321
  br i1 %81, label %82, label %85, !dbg !323

82:                                               ; preds = %78, %73, %57, %60
  %83 = phi i32 [ 1, %60 ], [ 1, %57 ], [ 2, %73 ], [ 2, %78 ]
  call void @llvm.dbg.value(metadata i32 %90, metadata !185, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.label(metadata !200), !dbg !324
  %84 = bitcast i32* %4 to i8*, !dbg !325
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %84), !dbg !325
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !330, metadata !DIExpression()) #3, !dbg !325
  call void @llvm.dbg.value(metadata i32 %90, metadata !331, metadata !DIExpression()) #3, !dbg !325
  store i32 %83, i32* %4, align 4, !tbaa !217
  call void @llvm.dbg.value(metadata i64 %9, metadata !332, metadata !DIExpression()) #3, !dbg !325
  br label %93, !dbg !337

85:                                               ; preds = %78
  %86 = bitcast i8* %80 to i32*, !dbg !320
  call void @llvm.dbg.value(metadata i32* %86, metadata !199, metadata !DIExpression()), !dbg !201
  %87 = load i32, i32* %86, align 4, !dbg !338, !tbaa !217
  %88 = zext i32 %87 to i64, !dbg !338
  %89 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.3* @tx_port to i8*), i64 %88, i64 0) #3, !dbg !339
  %90 = trunc i64 %89 to i32, !dbg !339
  call void @llvm.dbg.value(metadata i32 %90, metadata !185, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.label(metadata !200), !dbg !324
  %91 = bitcast i32* %4 to i8*, !dbg !325
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %91), !dbg !325
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !330, metadata !DIExpression()) #3, !dbg !325
  call void @llvm.dbg.value(metadata i32 %90, metadata !331, metadata !DIExpression()) #3, !dbg !325
  store i32 %90, i32* %4, align 4, !tbaa !217
  call void @llvm.dbg.value(metadata i64 %9, metadata !332, metadata !DIExpression()) #3, !dbg !325
  %92 = icmp ugt i32 %90, 4, !dbg !340
  br i1 %92, label %154, label %93, !dbg !337

93:                                               ; preds = %82, %85
  %94 = phi i8* [ %84, %82 ], [ %91, %85 ]
  call void @llvm.dbg.value(metadata i32* %4, metadata !331, metadata !DIExpression(DW_OP_deref)) #3, !dbg !325
  %95 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @xdp_stats_map to i8*), i8* nonnull %94) #3, !dbg !342
  call void @llvm.dbg.value(metadata i8* %95, metadata !333, metadata !DIExpression()) #3, !dbg !325
  %96 = icmp eq i8* %95, null, !dbg !343
  br i1 %96, label %154, label %97, !dbg !345

97:                                               ; preds = %93
  %98 = bitcast i8* %95 to i64*, !dbg !346
  %99 = load i64, i64* %98, align 8, !dbg !347, !tbaa !264
  %100 = add i64 %99, 1, !dbg !347
  store i64 %100, i64* %98, align 8, !dbg !347, !tbaa !264
  %101 = load i32, i32* %10, align 4, !dbg !348, !tbaa !204
  %102 = load i32, i32* %14, align 4, !dbg !349, !tbaa !212
  %103 = sub i32 %101, %102, !dbg !350
  %104 = zext i32 %103 to i64, !dbg !351
  %105 = getelementptr inbounds i8, i8* %95, i64 8, !dbg !352
  %106 = bitcast i8* %105 to i64*, !dbg !352
  %107 = load i64, i64* %106, align 8, !dbg !353, !tbaa !354
  %108 = add i64 %107, %104, !dbg !353
  store i64 %108, i64* %106, align 8, !dbg !353, !tbaa !354
  call void @llvm.dbg.value(metadata i32* %4, metadata !331, metadata !DIExpression(DW_OP_deref)) #3, !dbg !325
  %109 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @telemetry_stats_map to i8*), i8* nonnull %94) #3, !dbg !355
  call void @llvm.dbg.value(metadata i8* %109, metadata !334, metadata !DIExpression()) #3, !dbg !325
  %110 = icmp eq i8* %109, null, !dbg !356
  br i1 %110, label %154, label %111, !dbg !358

111:                                              ; preds = %97
  %112 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !359
  %113 = bitcast i8* %109 to i64*, !dbg !360
  store i64 %112, i64* %113, align 8, !dbg !361, !tbaa !254
  %114 = sub i64 %112, %9, !dbg !362
  %115 = getelementptr inbounds i8, i8* %109, i64 8, !dbg !363
  %116 = bitcast i8* %115 to i64*, !dbg !363
  store i64 %114, i64* %116, align 8, !dbg !364, !tbaa !365
  call void @llvm.dbg.value(metadata i32* %4, metadata !331, metadata !DIExpression(DW_OP_deref)) #3, !dbg !325
  %117 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.4* @last_timestamp_map to i8*), i8* nonnull %94) #3, !dbg !366
  call void @llvm.dbg.value(metadata i8* %117, metadata !335, metadata !DIExpression()) #3, !dbg !325
  %118 = icmp eq i8* %117, null, !dbg !367
  br i1 %118, label %119, label %122, !dbg !369

119:                                              ; preds = %111
  call void @llvm.dbg.value(metadata i32* %4, metadata !331, metadata !DIExpression(DW_OP_deref)) #3, !dbg !325
  %120 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.4* @last_timestamp_map to i8*), i8* nonnull %94, i8* nonnull %109, i64 0) #3, !dbg !370
  %121 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.5* @request_count_map to i8*), i8* nonnull %94, i8* nonnull %95, i64 0) #3, !dbg !372
  br label %122, !dbg !373

122:                                              ; preds = %119, %111
  %123 = load i32, i32* %4, align 4, !dbg !374, !tbaa !217
  call void @llvm.dbg.value(metadata i32 %123, metadata !331, metadata !DIExpression()) #3, !dbg !325
  %124 = bitcast i32* %2 to i8*, !dbg !375
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %124) #3, !dbg !375
  call void @llvm.dbg.value(metadata i32 %123, metadata !230, metadata !DIExpression()) #3, !dbg !375
  store i32 %123, i32* %2, align 4, !tbaa !217
  call void @llvm.dbg.value(metadata i8* %95, metadata !231, metadata !DIExpression()) #3, !dbg !375
  call void @llvm.dbg.value(metadata i8* %109, metadata !232, metadata !DIExpression()) #3, !dbg !375
  call void @llvm.dbg.value(metadata i32* %2, metadata !230, metadata !DIExpression(DW_OP_deref)) #3, !dbg !375
  %125 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.4* @last_timestamp_map to i8*), i8* nonnull %124) #3, !dbg !377
  call void @llvm.dbg.value(metadata i8* %125, metadata !233, metadata !DIExpression()) #3, !dbg !375
  %126 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.5* @request_count_map to i8*), i8* nonnull %124) #3, !dbg !378
  %127 = bitcast i8* %126 to i64*, !dbg !378
  call void @llvm.dbg.value(metadata i64* %127, metadata !234, metadata !DIExpression()) #3, !dbg !375
  %128 = icmp ne i8* %125, null, !dbg !379
  %129 = icmp ne i8* %126, null
  %130 = and i1 %128, %129, !dbg !380
  br i1 %130, label %131, label %152, !dbg !380

131:                                              ; preds = %122
  %132 = bitcast i8* %125 to i64*, !dbg !377
  call void @llvm.dbg.value(metadata i64* %132, metadata !233, metadata !DIExpression()) #3, !dbg !375
  %133 = load i64, i64* %113, align 8, !dbg !381, !tbaa !254
  %134 = load i64, i64* %132, align 8, !dbg !382, !tbaa !258
  %135 = sub i64 %133, %134, !dbg !383
  call void @llvm.dbg.value(metadata i64 %135, metadata !235, metadata !DIExpression()) #3, !dbg !375
  call void @llvm.dbg.value(metadata i64 undef, metadata !236, metadata !DIExpression()) #3, !dbg !375
  %136 = icmp ult i64 %135, 1000000000, !dbg !384
  br i1 %136, label %152, label %137, !dbg !385

137:                                              ; preds = %131
  %138 = udiv i64 %135, 1000000000, !dbg !386
  call void @llvm.dbg.value(metadata i64 %138, metadata !236, metadata !DIExpression()) #3, !dbg !375
  %139 = load i64, i64* %98, align 8, !dbg !387, !tbaa !264
  %140 = load i64, i64* %127, align 8, !dbg !388, !tbaa !258
  %141 = sub i64 %139, %140, !dbg !389
  call void @llvm.dbg.value(metadata i64 %141, metadata !237, metadata !DIExpression()) #3, !dbg !390
  %142 = udiv i64 %141, %138, !dbg !391
  call void @llvm.dbg.value(metadata i64 %142, metadata !240, metadata !DIExpression()) #3, !dbg !390
  call void @llvm.dbg.value(metadata i32* %2, metadata !230, metadata !DIExpression(DW_OP_deref)) #3, !dbg !375
  %143 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.5* @request_count_map to i8*), i8* nonnull %124, i8* nonnull %95, i64 0) #3, !dbg !392
  %144 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.4* @last_timestamp_map to i8*), i8* nonnull %124, i8* nonnull %109, i64 0) #3, !dbg !393
  %145 = icmp ugt i64 %142, 1, !dbg !394
  br i1 %145, label %146, label %152, !dbg !395

146:                                              ; preds = %137
  call void @llvm.dbg.value(metadata i32* %2, metadata !230, metadata !DIExpression(DW_OP_deref)) #3, !dbg !375
  %147 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @queue_avg_map to i8*), i8* nonnull %124) #3, !dbg !396
  call void @llvm.dbg.value(metadata i8* %147, metadata !241, metadata !DIExpression()) #3, !dbg !397
  %148 = icmp eq i8* %147, null, !dbg !398
  br i1 %148, label %152, label %149, !dbg !399

149:                                              ; preds = %146
  %150 = bitcast i64* %3 to i8*, !dbg !400
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %150) #3, !dbg !400
  call void @llvm.dbg.value(metadata i64 3000, metadata !244, metadata !DIExpression()) #3, !dbg !401
  store i64 3000, i64* %3, align 8, !dbg !402, !tbaa !258
  call void @llvm.dbg.value(metadata i32* %2, metadata !230, metadata !DIExpression(DW_OP_deref)) #3, !dbg !375
  call void @llvm.dbg.value(metadata i64* %3, metadata !244, metadata !DIExpression(DW_OP_deref)) #3, !dbg !401
  %151 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.1* @queue_avg_map to i8*), i8* nonnull %124, i8* nonnull %150, i64 0) #3, !dbg !403
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %150) #3, !dbg !404
  br label %152

152:                                              ; preds = %149, %146, %137, %131, %122
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %124) #3, !dbg !405
  %153 = load i32, i32* %4, align 4, !dbg !406, !tbaa !217
  call void @llvm.dbg.value(metadata i32 %153, metadata !331, metadata !DIExpression()) #3, !dbg !325
  br label %154

154:                                              ; preds = %85, %93, %97, %152
  %155 = phi i8* [ %91, %85 ], [ %94, %93 ], [ %94, %152 ], [ %94, %97 ]
  %156 = phi i32 [ 0, %85 ], [ 0, %93 ], [ %153, %152 ], [ 0, %97 ], !dbg !325
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %155), !dbg !407
  br label %157, !dbg !408

157:                                              ; preds = %70, %154
  %158 = phi i32 [ %156, %154 ], [ 1, %70 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %18) #3, !dbg !409
  ret i32 %158, !dbg !409
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
!llvm.module.flags = !{!153, !154, !155}
!llvm.ident = !{!156}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 40, type: !142, isLocal: false, isDefinition: true)
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
!17 = !{!18, !28, !36, !42, !49, !55, !0, !61, !84, !100, !117, !126, !134}
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
!56 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 252, type: !57, isLocal: false, isDefinition: true)
!57 = !DICompositeType(tag: DW_TAG_array_type, baseType: !58, size: 32, elements: !59)
!58 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!59 = !{!60}
!60 = !DISubrange(count: 4)
!61 = !DIGlobalVariableExpression(var: !62, expr: !DIExpression())
!62 = distinct !DIGlobalVariable(name: "telemetry_stats_map", scope: !2, file: !3, line: 47, type: !63, isLocal: false, isDefinition: true)
!63 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 42, size: 256, elements: !64)
!64 = !{!65, !71, !73, !79}
!65 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !63, file: !3, line: 43, baseType: !66, size: 64)
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!67 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 64, elements: !69)
!68 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!69 = !{!70}
!70 = !DISubrange(count: 2)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !63, file: !3, line: 44, baseType: !72, size: 64, offset: 64)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !63, file: !3, line: 45, baseType: !74, size: 64, offset: 128)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "telrec", file: !3, line: 29, size: 128, elements: !76)
!76 = !{!77, !78}
!77 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !75, file: !3, line: 30, baseType: !25, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time", scope: !75, file: !3, line: 31, baseType: !25, size: 64, offset: 64)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !63, file: !3, line: 46, baseType: !80, size: 64, offset: 192)
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 160, elements: !82)
!82 = !{!83}
!83 = !DISubrange(count: 5)
!84 = !DIGlobalVariableExpression(var: !85, expr: !DIExpression())
!85 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !3, line: 54, type: !86, isLocal: false, isDefinition: true)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 49, size: 256, elements: !87)
!87 = !{!88, !93, !94, !95}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !86, file: !3, line: 50, baseType: !89, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!90 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 448, elements: !91)
!91 = !{!92}
!92 = !DISubrange(count: 14)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !86, file: !3, line: 51, baseType: !72, size: 64, offset: 64)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !86, file: !3, line: 52, baseType: !72, size: 64, offset: 128)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !86, file: !3, line: 53, baseType: !96, size: 64, offset: 192)
!96 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 64)
!97 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 8192, elements: !98)
!98 = !{!99}
!99 = !DISubrange(count: 256)
!100 = !DIGlobalVariableExpression(var: !101, expr: !DIExpression())
!101 = distinct !DIGlobalVariable(name: "redirect_params", scope: !2, file: !3, line: 61, type: !102, isLocal: false, isDefinition: true)
!102 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 56, size: 256, elements: !103)
!103 = !{!104, !109, !115, !116}
!104 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !102, file: !3, line: 57, baseType: !105, size: 64)
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !106, size: 64)
!106 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 32, elements: !107)
!107 = !{!108}
!108 = !DISubrange(count: 1)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !102, file: !3, line: 58, baseType: !110, size: 64, offset: 64)
!110 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !111, size: 64)
!111 = !DICompositeType(tag: DW_TAG_array_type, baseType: !112, size: 48, elements: !113)
!112 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!113 = !{!114}
!114 = !DISubrange(count: 6)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !102, file: !3, line: 59, baseType: !110, size: 64, offset: 128)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !102, file: !3, line: 60, baseType: !105, size: 64, offset: 192)
!117 = !DIGlobalVariableExpression(var: !118, expr: !DIExpression())
!118 = distinct !DIGlobalVariable(name: "queue_avg_map", scope: !2, file: !3, line: 68, type: !119, isLocal: false, isDefinition: true)
!119 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 63, size: 256, elements: !120)
!120 = !{!121, !122, !123, !125}
!121 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !119, file: !3, line: 64, baseType: !66, size: 64)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !119, file: !3, line: 65, baseType: !72, size: 64, offset: 64)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !119, file: !3, line: 66, baseType: !124, size: 64, offset: 128)
!124 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !119, file: !3, line: 67, baseType: !105, size: 64, offset: 192)
!126 = !DIGlobalVariableExpression(var: !127, expr: !DIExpression())
!127 = distinct !DIGlobalVariable(name: "last_timestamp_map", scope: !2, file: !3, line: 75, type: !128, isLocal: false, isDefinition: true)
!128 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 70, size: 256, elements: !129)
!129 = !{!130, !131, !132, !133}
!130 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !128, file: !3, line: 71, baseType: !66, size: 64)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !128, file: !3, line: 72, baseType: !72, size: 64, offset: 64)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !128, file: !3, line: 73, baseType: !124, size: 64, offset: 128)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !128, file: !3, line: 74, baseType: !80, size: 64, offset: 192)
!134 = !DIGlobalVariableExpression(var: !135, expr: !DIExpression())
!135 = distinct !DIGlobalVariable(name: "request_count_map", scope: !2, file: !3, line: 82, type: !136, isLocal: false, isDefinition: true)
!136 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 77, size: 256, elements: !137)
!137 = !{!138, !139, !140, !141}
!138 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !136, file: !3, line: 78, baseType: !66, size: 64)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !136, file: !3, line: 79, baseType: !72, size: 64, offset: 64)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !136, file: !3, line: 80, baseType: !124, size: 64, offset: 128)
!141 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !136, file: !3, line: 81, baseType: !80, size: 64, offset: 192)
!142 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 35, size: 256, elements: !143)
!143 = !{!144, !145, !146, !152}
!144 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !142, file: !3, line: 36, baseType: !66, size: 64)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !142, file: !3, line: 37, baseType: !72, size: 64, offset: 64)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !142, file: !3, line: 38, baseType: !147, size: 64, offset: 128)
!147 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !148, size: 64)
!148 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !3, line: 24, size: 128, elements: !149)
!149 = !{!150, !151}
!150 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !148, file: !3, line: 25, baseType: !25, size: 64)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !148, file: !3, line: 26, baseType: !25, size: 64, offset: 64)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !142, file: !3, line: 39, baseType: !80, size: 64, offset: 192)
!153 = !{i32 7, !"Dwarf Version", i32 4}
!154 = !{i32 2, !"Debug Info Version", i32 3}
!155 = !{i32 1, !"wchar_size", i32 4}
!156 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!157 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !3, file: !3, line: 171, type: !158, scopeLine: 171, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !168)
!158 = !DISubroutineType(types: !159)
!159 = !{!68, !160}
!160 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !161, size: 64)
!161 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !162)
!162 = !{!163, !164, !165, !166, !167}
!163 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !161, file: !6, line: 3165, baseType: !48, size: 32)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !161, file: !6, line: 3166, baseType: !48, size: 32, offset: 32)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !161, file: !6, line: 3167, baseType: !48, size: 32, offset: 64)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !161, file: !6, line: 3169, baseType: !48, size: 32, offset: 96)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !161, file: !6, line: 3170, baseType: !48, size: 32, offset: 128)
!168 = !{!169, !170, !171, !172, !173, !185, !186, !187, !188, !189, !190, !191, !192, !193, !197, !199, !200}
!169 = !DILocalVariable(name: "ctx", arg: 1, scope: !157, file: !3, line: 171, type: !160)
!170 = !DILocalVariable(name: "start", scope: !157, file: !3, line: 172, type: !25)
!171 = !DILocalVariable(name: "data_end", scope: !157, file: !3, line: 173, type: !15)
!172 = !DILocalVariable(name: "data", scope: !157, file: !3, line: 174, type: !15)
!173 = !DILocalVariable(name: "eth", scope: !157, file: !3, line: 176, type: !174)
!174 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !175, size: 64)
!175 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !176, line: 163, size: 112, elements: !177)
!176 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!177 = !{!178, !179, !180}
!178 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !175, file: !176, line: 164, baseType: !111, size: 48)
!179 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !175, file: !176, line: 165, baseType: !111, size: 48, offset: 48)
!180 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !175, file: !176, line: 166, baseType: !181, size: 16, offset: 96)
!181 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !182, line: 25, baseType: !183)
!182 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!183 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !26, line: 24, baseType: !184)
!184 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!185 = !DILocalVariable(name: "action", scope: !157, file: !3, line: 177, type: !48)
!186 = !DILocalVariable(name: "queue_len", scope: !157, file: !3, line: 178, type: !25)
!187 = !DILocalVariable(name: "key", scope: !157, file: !3, line: 180, type: !48)
!188 = !DILocalVariable(name: "rec", scope: !157, file: !3, line: 183, type: !147)
!189 = !DILocalVariable(name: "telemetry", scope: !157, file: !3, line: 184, type: !74)
!190 = !DILocalVariable(name: "is_burst", scope: !157, file: !3, line: 185, type: !68)
!191 = !DILocalVariable(name: "prev_avg", scope: !157, file: !3, line: 197, type: !124)
!192 = !DILocalVariable(name: "new_avg", scope: !157, file: !3, line: 204, type: !25)
!193 = !DILocalVariable(name: "drop_prob", scope: !194, file: !3, line: 214, type: !25)
!194 = distinct !DILexicalBlock(scope: !195, file: !3, line: 213, column: 10)
!195 = distinct !DILexicalBlock(scope: !196, file: !3, line: 211, column: 14)
!196 = distinct !DILexicalBlock(scope: !157, file: !3, line: 208, column: 7)
!197 = !DILocalVariable(name: "dst", scope: !157, file: !3, line: 234, type: !198)
!198 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 64)
!199 = !DILocalVariable(name: "iface_index", scope: !157, file: !3, line: 242, type: !72)
!200 = !DILabel(scope: !157, name: "out", file: !3, line: 248)
!201 = !DILocation(line: 0, scope: !157)
!202 = !DILocation(line: 172, column: 17, scope: !157)
!203 = !DILocation(line: 173, column: 39, scope: !157)
!204 = !{!205, !206, i64 4}
!205 = !{!"xdp_md", !206, i64 0, !206, i64 4, !206, i64 8, !206, i64 12, !206, i64 16}
!206 = !{!"int", !207, i64 0}
!207 = !{!"omnipotent char", !208, i64 0}
!208 = !{!"Simple C/C++ TBAA"}
!209 = !DILocation(line: 173, column: 28, scope: !157)
!210 = !DILocation(line: 173, column: 20, scope: !157)
!211 = !DILocation(line: 174, column: 35, scope: !157)
!212 = !{!205, !206, i64 0}
!213 = !DILocation(line: 174, column: 24, scope: !157)
!214 = !DILocation(line: 174, column: 16, scope: !157)
!215 = !DILocation(line: 180, column: 3, scope: !157)
!216 = !DILocation(line: 180, column: 9, scope: !157)
!217 = !{!206, !206, i64 0}
!218 = !DILocation(line: 183, column: 25, scope: !157)
!219 = !DILocation(line: 184, column: 30, scope: !157)
!220 = !DILocation(line: 187, column: 7, scope: !221)
!221 = distinct !DILexicalBlock(scope: !157, file: !3, line: 187, column: 7)
!222 = !DILocation(line: 187, column: 11, scope: !221)
!223 = !DILocation(line: 188, column: 39, scope: !224)
!224 = distinct !DILexicalBlock(scope: !221, file: !3, line: 187, column: 25)
!225 = !DILocation(line: 0, scope: !226, inlinedAt: !247)
!226 = distinct !DISubprogram(name: "handle_burst_detection", scope: !3, file: !3, line: 92, type: !227, scopeLine: 94, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !229)
!227 = !DISubroutineType(types: !228)
!228 = !{!68, !48, !147, !74}
!229 = !{!230, !231, !232, !233, !234, !235, !236, !237, !240, !241, !244}
!230 = !DILocalVariable(name: "key", arg: 1, scope: !226, file: !3, line: 92, type: !48)
!231 = !DILocalVariable(name: "stats", arg: 2, scope: !226, file: !3, line: 93, type: !147)
!232 = !DILocalVariable(name: "telemetry", arg: 3, scope: !226, file: !3, line: 94, type: !74)
!233 = !DILocalVariable(name: "last_timestamp", scope: !226, file: !3, line: 95, type: !124)
!234 = !DILocalVariable(name: "request_count", scope: !226, file: !3, line: 96, type: !124)
!235 = !DILocalVariable(name: "time_diff", scope: !226, file: !3, line: 103, type: !25)
!236 = !DILocalVariable(name: "time_diff_sec", scope: !226, file: !3, line: 106, type: !25)
!237 = !DILocalVariable(name: "packet_diff", scope: !238, file: !3, line: 110, type: !25)
!238 = distinct !DILexicalBlock(scope: !239, file: !3, line: 108, column: 27)
!239 = distinct !DILexicalBlock(scope: !226, file: !3, line: 108, column: 7)
!240 = !DILocalVariable(name: "current_rps", scope: !238, file: !3, line: 111, type: !25)
!241 = !DILocalVariable(name: "avg_queue", scope: !242, file: !3, line: 121, type: !124)
!242 = distinct !DILexicalBlock(scope: !243, file: !3, line: 120, column: 41)
!243 = distinct !DILexicalBlock(scope: !238, file: !3, line: 120, column: 9)
!244 = !DILocalVariable(name: "new_avg", scope: !245, file: !3, line: 123, type: !25)
!245 = distinct !DILexicalBlock(scope: !246, file: !3, line: 122, column: 22)
!246 = distinct !DILexicalBlock(scope: !242, file: !3, line: 122, column: 11)
!247 = distinct !DILocation(line: 188, column: 16, scope: !224)
!248 = !DILocation(line: 95, column: 27, scope: !226, inlinedAt: !247)
!249 = !DILocation(line: 96, column: 26, scope: !226, inlinedAt: !247)
!250 = !DILocation(line: 98, column: 8, scope: !251, inlinedAt: !247)
!251 = distinct !DILexicalBlock(scope: !226, file: !3, line: 98, column: 7)
!252 = !DILocation(line: 98, column: 23, scope: !251, inlinedAt: !247)
!253 = !DILocation(line: 103, column: 32, scope: !226, inlinedAt: !247)
!254 = !{!255, !256, i64 0}
!255 = !{!"telrec", !256, i64 0, !256, i64 8}
!256 = !{!"long long", !207, i64 0}
!257 = !DILocation(line: 103, column: 44, scope: !226, inlinedAt: !247)
!258 = !{!256, !256, i64 0}
!259 = !DILocation(line: 103, column: 42, scope: !226, inlinedAt: !247)
!260 = !DILocation(line: 108, column: 21, scope: !239, inlinedAt: !247)
!261 = !DILocation(line: 108, column: 7, scope: !226, inlinedAt: !247)
!262 = !DILocation(line: 106, column: 35, scope: !226, inlinedAt: !247)
!263 = !DILocation(line: 110, column: 32, scope: !238, inlinedAt: !247)
!264 = !{!265, !256, i64 0}
!265 = !{!"datarec", !256, i64 0, !256, i64 8}
!266 = !DILocation(line: 110, column: 45, scope: !238, inlinedAt: !247)
!267 = !DILocation(line: 110, column: 43, scope: !238, inlinedAt: !247)
!268 = !DILocation(line: 0, scope: !238, inlinedAt: !247)
!269 = !DILocation(line: 111, column: 37, scope: !238, inlinedAt: !247)
!270 = !DILocation(line: 114, column: 5, scope: !238, inlinedAt: !247)
!271 = !DILocation(line: 116, column: 5, scope: !238, inlinedAt: !247)
!272 = !DILocation(line: 120, column: 21, scope: !243, inlinedAt: !247)
!273 = !DILocation(line: 120, column: 9, scope: !238, inlinedAt: !247)
!274 = !DILocation(line: 121, column: 26, scope: !242, inlinedAt: !247)
!275 = !DILocation(line: 0, scope: !242, inlinedAt: !247)
!276 = !DILocation(line: 122, column: 11, scope: !246, inlinedAt: !247)
!277 = !DILocation(line: 122, column: 11, scope: !242, inlinedAt: !247)
!278 = !DILocation(line: 123, column: 9, scope: !245, inlinedAt: !247)
!279 = !DILocation(line: 0, scope: !245, inlinedAt: !247)
!280 = !DILocation(line: 123, column: 15, scope: !245, inlinedAt: !247)
!281 = !DILocation(line: 124, column: 9, scope: !245, inlinedAt: !247)
!282 = !DILocation(line: 126, column: 7, scope: !246, inlinedAt: !247)
!283 = !DILocation(line: 131, column: 1, scope: !226, inlinedAt: !247)
!284 = !DILocation(line: 189, column: 3, scope: !224)
!285 = !DILocation(line: 197, column: 21, scope: !157)
!286 = !DILocation(line: 198, column: 8, scope: !287)
!287 = distinct !DILexicalBlock(scope: !157, file: !3, line: 198, column: 7)
!288 = !DILocation(line: 198, column: 7, scope: !157)
!289 = !DILocation(line: 204, column: 43, scope: !157)
!290 = !DILocalVariable(name: "prev_avg", arg: 1, scope: !291, file: !3, line: 85, type: !25)
!291 = distinct !DISubprogram(name: "calculate_avg_queue_len", scope: !3, file: !3, line: 85, type: !292, scopeLine: 86, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !294)
!292 = !DISubroutineType(types: !293)
!293 = !{!25, !25, !25}
!294 = !{!290, !295, !296, !297}
!295 = !DILocalVariable(name: "curr_queue_len", arg: 2, scope: !291, file: !3, line: 86, type: !25)
!296 = !DILocalVariable(name: "weighted_prev_avg", scope: !291, file: !3, line: 87, type: !25)
!297 = !DILocalVariable(name: "weighted_curr_len", scope: !291, file: !3, line: 88, type: !25)
!298 = !DILocation(line: 0, scope: !291, inlinedAt: !299)
!299 = distinct !DILocation(line: 204, column: 19, scope: !157)
!300 = !DILocation(line: 87, column: 55, scope: !291, inlinedAt: !299)
!301 = !DILocation(line: 89, column: 29, scope: !291, inlinedAt: !299)
!302 = !DILocation(line: 89, column: 50, scope: !291, inlinedAt: !299)
!303 = !DILocation(line: 204, column: 9, scope: !157)
!304 = !DILocation(line: 205, column: 45, scope: !157)
!305 = !DILocation(line: 205, column: 3, scope: !157)
!306 = !DILocation(line: 208, column: 7, scope: !196)
!307 = !DILocation(line: 208, column: 15, scope: !196)
!308 = !DILocation(line: 208, column: 33, scope: !196)
!309 = !DILocation(line: 228, column: 12, scope: !310)
!310 = distinct !DILexicalBlock(scope: !157, file: !3, line: 228, column: 7)
!311 = !DILocation(line: 228, column: 36, scope: !310)
!312 = !DILocation(line: 228, column: 7, scope: !157)
!313 = !DILocation(line: 231, column: 9, scope: !157)
!314 = !DILocation(line: 234, column: 62, scope: !157)
!315 = !DILocation(line: 234, column: 24, scope: !157)
!316 = !DILocation(line: 235, column: 8, scope: !317)
!317 = distinct !DILexicalBlock(scope: !157, file: !3, line: 235, column: 7)
!318 = !DILocation(line: 235, column: 7, scope: !157)
!319 = !DILocation(line: 239, column: 3, scope: !157)
!320 = !DILocation(line: 242, column: 24, scope: !157)
!321 = !DILocation(line: 243, column: 8, scope: !322)
!322 = distinct !DILexicalBlock(scope: !157, file: !3, line: 243, column: 7)
!323 = !DILocation(line: 243, column: 7, scope: !157)
!324 = !DILocation(line: 248, column: 1, scope: !157)
!325 = !DILocation(line: 0, scope: !326, inlinedAt: !336)
!326 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 133, type: !327, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !329)
!327 = !DISubroutineType(types: !328)
!328 = !{!48, !160, !48, !25}
!329 = !{!330, !331, !332, !333, !334, !335}
!330 = !DILocalVariable(name: "ctx", arg: 1, scope: !326, file: !3, line: 133, type: !160)
!331 = !DILocalVariable(name: "action", arg: 2, scope: !326, file: !3, line: 134, type: !48)
!332 = !DILocalVariable(name: "start", arg: 3, scope: !326, file: !3, line: 135, type: !25)
!333 = !DILocalVariable(name: "rec", scope: !326, file: !3, line: 140, type: !147)
!334 = !DILocalVariable(name: "telemetry", scope: !326, file: !3, line: 148, type: !74)
!335 = !DILocalVariable(name: "last_timestamp", scope: !326, file: !3, line: 156, type: !124)
!336 = distinct !DILocation(line: 249, column: 10, scope: !157)
!337 = !DILocation(line: 136, column: 7, scope: !326, inlinedAt: !336)
!338 = !DILocation(line: 246, column: 39, scope: !157)
!339 = !DILocation(line: 246, column: 12, scope: !157)
!340 = !DILocation(line: 136, column: 14, scope: !341, inlinedAt: !336)
!341 = distinct !DILexicalBlock(scope: !326, file: !3, line: 136, column: 7)
!342 = !DILocation(line: 140, column: 25, scope: !326, inlinedAt: !336)
!343 = !DILocation(line: 141, column: 8, scope: !344, inlinedAt: !336)
!344 = distinct !DILexicalBlock(scope: !326, file: !3, line: 141, column: 7)
!345 = !DILocation(line: 141, column: 7, scope: !326, inlinedAt: !336)
!346 = !DILocation(line: 144, column: 8, scope: !326, inlinedAt: !336)
!347 = !DILocation(line: 144, column: 18, scope: !326, inlinedAt: !336)
!348 = !DILocation(line: 145, column: 26, scope: !326, inlinedAt: !336)
!349 = !DILocation(line: 145, column: 42, scope: !326, inlinedAt: !336)
!350 = !DILocation(line: 145, column: 35, scope: !326, inlinedAt: !336)
!351 = !DILocation(line: 145, column: 20, scope: !326, inlinedAt: !336)
!352 = !DILocation(line: 145, column: 8, scope: !326, inlinedAt: !336)
!353 = !DILocation(line: 145, column: 17, scope: !326, inlinedAt: !336)
!354 = !{!265, !256, i64 8}
!355 = !DILocation(line: 148, column: 30, scope: !326, inlinedAt: !336)
!356 = !DILocation(line: 149, column: 8, scope: !357, inlinedAt: !336)
!357 = distinct !DILexicalBlock(scope: !326, file: !3, line: 149, column: 7)
!358 = !DILocation(line: 149, column: 7, scope: !326, inlinedAt: !336)
!359 = !DILocation(line: 152, column: 26, scope: !326, inlinedAt: !336)
!360 = !DILocation(line: 152, column: 14, scope: !326, inlinedAt: !336)
!361 = !DILocation(line: 152, column: 24, scope: !326, inlinedAt: !336)
!362 = !DILocation(line: 153, column: 53, scope: !326, inlinedAt: !336)
!363 = !DILocation(line: 153, column: 14, scope: !326, inlinedAt: !336)
!364 = !DILocation(line: 153, column: 30, scope: !326, inlinedAt: !336)
!365 = !{!255, !256, i64 8}
!366 = !DILocation(line: 156, column: 27, scope: !326, inlinedAt: !336)
!367 = !DILocation(line: 157, column: 8, scope: !368, inlinedAt: !336)
!368 = distinct !DILexicalBlock(scope: !326, file: !3, line: 157, column: 7)
!369 = !DILocation(line: 157, column: 7, scope: !326, inlinedAt: !336)
!370 = !DILocation(line: 158, column: 5, scope: !371, inlinedAt: !336)
!371 = distinct !DILexicalBlock(scope: !368, file: !3, line: 157, column: 24)
!372 = !DILocation(line: 160, column: 5, scope: !371, inlinedAt: !336)
!373 = !DILocation(line: 161, column: 3, scope: !371, inlinedAt: !336)
!374 = !DILocation(line: 164, column: 26, scope: !326, inlinedAt: !336)
!375 = !DILocation(line: 0, scope: !226, inlinedAt: !376)
!376 = distinct !DILocation(line: 164, column: 3, scope: !326, inlinedAt: !336)
!377 = !DILocation(line: 95, column: 27, scope: !226, inlinedAt: !376)
!378 = !DILocation(line: 96, column: 26, scope: !226, inlinedAt: !376)
!379 = !DILocation(line: 98, column: 8, scope: !251, inlinedAt: !376)
!380 = !DILocation(line: 98, column: 23, scope: !251, inlinedAt: !376)
!381 = !DILocation(line: 103, column: 32, scope: !226, inlinedAt: !376)
!382 = !DILocation(line: 103, column: 44, scope: !226, inlinedAt: !376)
!383 = !DILocation(line: 103, column: 42, scope: !226, inlinedAt: !376)
!384 = !DILocation(line: 108, column: 21, scope: !239, inlinedAt: !376)
!385 = !DILocation(line: 108, column: 7, scope: !226, inlinedAt: !376)
!386 = !DILocation(line: 106, column: 35, scope: !226, inlinedAt: !376)
!387 = !DILocation(line: 110, column: 32, scope: !238, inlinedAt: !376)
!388 = !DILocation(line: 110, column: 45, scope: !238, inlinedAt: !376)
!389 = !DILocation(line: 110, column: 43, scope: !238, inlinedAt: !376)
!390 = !DILocation(line: 0, scope: !238, inlinedAt: !376)
!391 = !DILocation(line: 111, column: 37, scope: !238, inlinedAt: !376)
!392 = !DILocation(line: 114, column: 5, scope: !238, inlinedAt: !376)
!393 = !DILocation(line: 116, column: 5, scope: !238, inlinedAt: !376)
!394 = !DILocation(line: 120, column: 21, scope: !243, inlinedAt: !376)
!395 = !DILocation(line: 120, column: 9, scope: !238, inlinedAt: !376)
!396 = !DILocation(line: 121, column: 26, scope: !242, inlinedAt: !376)
!397 = !DILocation(line: 0, scope: !242, inlinedAt: !376)
!398 = !DILocation(line: 122, column: 11, scope: !246, inlinedAt: !376)
!399 = !DILocation(line: 122, column: 11, scope: !242, inlinedAt: !376)
!400 = !DILocation(line: 123, column: 9, scope: !245, inlinedAt: !376)
!401 = !DILocation(line: 0, scope: !245, inlinedAt: !376)
!402 = !DILocation(line: 123, column: 15, scope: !245, inlinedAt: !376)
!403 = !DILocation(line: 124, column: 9, scope: !245, inlinedAt: !376)
!404 = !DILocation(line: 126, column: 7, scope: !246, inlinedAt: !376)
!405 = !DILocation(line: 131, column: 1, scope: !226, inlinedAt: !376)
!406 = !DILocation(line: 166, column: 10, scope: !326, inlinedAt: !336)
!407 = !DILocation(line: 167, column: 1, scope: !326, inlinedAt: !336)
!408 = !DILocation(line: 249, column: 3, scope: !157)
!409 = !DILocation(line: 250, column: 1, scope: !157)
