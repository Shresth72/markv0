; ModuleID = 'kern.c'
source_filename = "kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, %struct.source_state*, [4 x i32]* }
%struct.source_state = type { i64, i64, i64, i64, i64, i64 }
%struct.anon.0 = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !0
@source_states = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !15
@queue_length_map = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !46
@llvm.used = appending global [4 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.0* @queue_length_map to i8*), i8* bitcast (%struct.anon* @source_states to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_redirect_map_func to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_redirect_map_func(%struct.xdp_md* nocapture readnone %0) #0 section "xdp_redirect_map" !dbg !81 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !93, metadata !DIExpression()), !dbg !94
  %7 = bitcast i32* %6 to i8*, !dbg !95
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %7), !dbg !95
  call void @llvm.dbg.value(metadata i32 0, metadata !100, metadata !DIExpression()) #3, !dbg !95
  store i32 0, i32* %6, align 4, !tbaa !109
  %8 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !113
  call void @llvm.dbg.value(metadata i64 %8, metadata !101, metadata !DIExpression()) #3, !dbg !95
  call void @llvm.dbg.value(metadata i32* %6, metadata !100, metadata !DIExpression(DW_OP_deref)) #3, !dbg !95
  %9 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @source_states to i8*), i8* nonnull %7) #3, !dbg !114
  call void @llvm.dbg.value(metadata i8* %9, metadata !102, metadata !DIExpression()) #3, !dbg !95
  %10 = icmp eq i8* %9, null, !dbg !115
  br i1 %10, label %33, label %11, !dbg !116

11:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* %9, metadata !102, metadata !DIExpression()) #3, !dbg !95
  %12 = getelementptr inbounds i8, i8* %9, i64 40, !dbg !117
  %13 = bitcast i8* %12 to i64*, !dbg !117
  %14 = load i64, i64* %13, align 8, !dbg !117, !tbaa !118
  %15 = sub i64 %8, %14, !dbg !121
  call void @llvm.dbg.value(metadata i64 %15, metadata !103, metadata !DIExpression()) #3, !dbg !122
  call void @llvm.dbg.value(metadata i64 undef, metadata !106, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !122
  call void @llvm.dbg.value(metadata i64 undef, metadata !107, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !122
  %16 = bitcast i8* %9 to i64*, !dbg !123
  %17 = load i64, i64* %16, align 8, !dbg !123, !tbaa !125
  %18 = icmp eq i64 %17, 0, !dbg !126
  br i1 %18, label %26, label %19, !dbg !127

19:                                               ; preds = %11
  %20 = getelementptr inbounds i8, i8* %9, i64 24, !dbg !128
  %21 = bitcast i8* %20 to i64*, !dbg !128
  %22 = load i64, i64* %21, align 8, !dbg !128, !tbaa !129
  call void @llvm.dbg.value(metadata i64 %22, metadata !106, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !122
  %23 = mul i64 %22, 1000000000, !dbg !130
  call void @llvm.dbg.value(metadata i64 %23, metadata !106, metadata !DIExpression()) #3, !dbg !122
  %24 = icmp ugt i64 %15, %23, !dbg !131
  br i1 %24, label %25, label %33, !dbg !132

25:                                               ; preds = %19
  store i64 0, i64* %16, align 8, !dbg !133, !tbaa !125
  store i64 %8, i64* %13, align 8, !dbg !135, !tbaa !118
  br label %33, !dbg !136

26:                                               ; preds = %11
  %27 = getelementptr inbounds i8, i8* %9, i64 32, !dbg !137
  %28 = bitcast i8* %27 to i64*, !dbg !137
  %29 = load i64, i64* %28, align 8, !dbg !137, !tbaa !138
  call void @llvm.dbg.value(metadata i64 %29, metadata !107, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !122
  %30 = mul i64 %29, 1000000000, !dbg !139
  call void @llvm.dbg.value(metadata i64 %30, metadata !107, metadata !DIExpression()) #3, !dbg !122
  %31 = icmp ugt i64 %15, %30
  br i1 %31, label %32, label %33, !dbg !140

32:                                               ; preds = %26
  store i64 1, i64* %16, align 8, !dbg !142, !tbaa !125
  store i64 %8, i64* %13, align 8, !dbg !144, !tbaa !118
  br label %33, !dbg !145

33:                                               ; preds = %1, %19, %25, %26, %32
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %7), !dbg !146
  %34 = bitcast i32* %5 to i8*, !dbg !147
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %34), !dbg !147
  call void @llvm.dbg.value(metadata i32 1, metadata !100, metadata !DIExpression()) #3, !dbg !147
  store i32 1, i32* %5, align 4, !tbaa !109
  %35 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !149
  call void @llvm.dbg.value(metadata i64 %35, metadata !101, metadata !DIExpression()) #3, !dbg !147
  call void @llvm.dbg.value(metadata i32* %5, metadata !100, metadata !DIExpression(DW_OP_deref)) #3, !dbg !147
  %36 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @source_states to i8*), i8* nonnull %34) #3, !dbg !150
  call void @llvm.dbg.value(metadata i8* %36, metadata !102, metadata !DIExpression()) #3, !dbg !147
  %37 = icmp eq i8* %36, null, !dbg !151
  br i1 %37, label %60, label %38, !dbg !152

38:                                               ; preds = %33
  call void @llvm.dbg.value(metadata i8* %36, metadata !102, metadata !DIExpression()) #3, !dbg !147
  %39 = getelementptr inbounds i8, i8* %36, i64 40, !dbg !153
  %40 = bitcast i8* %39 to i64*, !dbg !153
  %41 = load i64, i64* %40, align 8, !dbg !153, !tbaa !118
  %42 = sub i64 %35, %41, !dbg !154
  call void @llvm.dbg.value(metadata i64 %42, metadata !103, metadata !DIExpression()) #3, !dbg !155
  call void @llvm.dbg.value(metadata i64 undef, metadata !106, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !155
  call void @llvm.dbg.value(metadata i64 undef, metadata !107, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !155
  %43 = bitcast i8* %36 to i64*, !dbg !156
  %44 = load i64, i64* %43, align 8, !dbg !156, !tbaa !125
  %45 = icmp eq i64 %44, 0, !dbg !157
  br i1 %45, label %53, label %46, !dbg !158

46:                                               ; preds = %38
  %47 = getelementptr inbounds i8, i8* %36, i64 24, !dbg !159
  %48 = bitcast i8* %47 to i64*, !dbg !159
  %49 = load i64, i64* %48, align 8, !dbg !159, !tbaa !129
  call void @llvm.dbg.value(metadata i64 %49, metadata !106, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !155
  %50 = mul i64 %49, 1000000000, !dbg !160
  call void @llvm.dbg.value(metadata i64 %50, metadata !106, metadata !DIExpression()) #3, !dbg !155
  %51 = icmp ugt i64 %42, %50, !dbg !161
  br i1 %51, label %52, label %60, !dbg !162

52:                                               ; preds = %46
  store i64 0, i64* %43, align 8, !dbg !163, !tbaa !125
  store i64 %35, i64* %40, align 8, !dbg !164, !tbaa !118
  br label %60, !dbg !165

53:                                               ; preds = %38
  %54 = getelementptr inbounds i8, i8* %36, i64 32, !dbg !166
  %55 = bitcast i8* %54 to i64*, !dbg !166
  %56 = load i64, i64* %55, align 8, !dbg !166, !tbaa !138
  call void @llvm.dbg.value(metadata i64 %56, metadata !107, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !155
  %57 = mul i64 %56, 1000000000, !dbg !167
  call void @llvm.dbg.value(metadata i64 %57, metadata !107, metadata !DIExpression()) #3, !dbg !155
  %58 = icmp ugt i64 %42, %57
  br i1 %58, label %59, label %60, !dbg !168

59:                                               ; preds = %53
  store i64 1, i64* %43, align 8, !dbg !169, !tbaa !125
  store i64 %35, i64* %40, align 8, !dbg !170, !tbaa !118
  br label %60, !dbg !171

60:                                               ; preds = %33, %46, %52, %53, %59
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %34), !dbg !172
  %61 = bitcast i32* %4 to i8*, !dbg !173
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %61), !dbg !173
  call void @llvm.dbg.value(metadata i32 2, metadata !100, metadata !DIExpression()) #3, !dbg !173
  store i32 2, i32* %4, align 4, !tbaa !109
  %62 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !175
  call void @llvm.dbg.value(metadata i64 %62, metadata !101, metadata !DIExpression()) #3, !dbg !173
  call void @llvm.dbg.value(metadata i32* %4, metadata !100, metadata !DIExpression(DW_OP_deref)) #3, !dbg !173
  %63 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @source_states to i8*), i8* nonnull %61) #3, !dbg !176
  call void @llvm.dbg.value(metadata i8* %63, metadata !102, metadata !DIExpression()) #3, !dbg !173
  %64 = icmp eq i8* %63, null, !dbg !177
  br i1 %64, label %87, label %65, !dbg !178

65:                                               ; preds = %60
  call void @llvm.dbg.value(metadata i8* %63, metadata !102, metadata !DIExpression()) #3, !dbg !173
  %66 = getelementptr inbounds i8, i8* %63, i64 40, !dbg !179
  %67 = bitcast i8* %66 to i64*, !dbg !179
  %68 = load i64, i64* %67, align 8, !dbg !179, !tbaa !118
  %69 = sub i64 %62, %68, !dbg !180
  call void @llvm.dbg.value(metadata i64 %69, metadata !103, metadata !DIExpression()) #3, !dbg !181
  call void @llvm.dbg.value(metadata i64 undef, metadata !106, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !181
  call void @llvm.dbg.value(metadata i64 undef, metadata !107, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !181
  %70 = bitcast i8* %63 to i64*, !dbg !182
  %71 = load i64, i64* %70, align 8, !dbg !182, !tbaa !125
  %72 = icmp eq i64 %71, 0, !dbg !183
  br i1 %72, label %80, label %73, !dbg !184

73:                                               ; preds = %65
  %74 = getelementptr inbounds i8, i8* %63, i64 24, !dbg !185
  %75 = bitcast i8* %74 to i64*, !dbg !185
  %76 = load i64, i64* %75, align 8, !dbg !185, !tbaa !129
  call void @llvm.dbg.value(metadata i64 %76, metadata !106, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !181
  %77 = mul i64 %76, 1000000000, !dbg !186
  call void @llvm.dbg.value(metadata i64 %77, metadata !106, metadata !DIExpression()) #3, !dbg !181
  %78 = icmp ugt i64 %69, %77, !dbg !187
  br i1 %78, label %79, label %87, !dbg !188

79:                                               ; preds = %73
  store i64 0, i64* %70, align 8, !dbg !189, !tbaa !125
  store i64 %62, i64* %67, align 8, !dbg !190, !tbaa !118
  br label %87, !dbg !191

80:                                               ; preds = %65
  %81 = getelementptr inbounds i8, i8* %63, i64 32, !dbg !192
  %82 = bitcast i8* %81 to i64*, !dbg !192
  %83 = load i64, i64* %82, align 8, !dbg !192, !tbaa !138
  call void @llvm.dbg.value(metadata i64 %83, metadata !107, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !181
  %84 = mul i64 %83, 1000000000, !dbg !193
  call void @llvm.dbg.value(metadata i64 %84, metadata !107, metadata !DIExpression()) #3, !dbg !181
  %85 = icmp ugt i64 %69, %84
  br i1 %85, label %86, label %87, !dbg !194

86:                                               ; preds = %80
  store i64 1, i64* %70, align 8, !dbg !195, !tbaa !125
  store i64 %62, i64* %67, align 8, !dbg !196, !tbaa !118
  br label %87, !dbg !197

87:                                               ; preds = %60, %73, %79, %80, %86
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %61), !dbg !198
  %88 = bitcast i32* %3 to i8*, !dbg !199
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %88), !dbg !199
  call void @llvm.dbg.value(metadata i32 3, metadata !100, metadata !DIExpression()) #3, !dbg !199
  store i32 3, i32* %3, align 4, !tbaa !109
  %89 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !201
  call void @llvm.dbg.value(metadata i64 %89, metadata !101, metadata !DIExpression()) #3, !dbg !199
  call void @llvm.dbg.value(metadata i32* %3, metadata !100, metadata !DIExpression(DW_OP_deref)) #3, !dbg !199
  %90 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @source_states to i8*), i8* nonnull %88) #3, !dbg !202
  call void @llvm.dbg.value(metadata i8* %90, metadata !102, metadata !DIExpression()) #3, !dbg !199
  %91 = icmp eq i8* %90, null, !dbg !203
  br i1 %91, label %114, label %92, !dbg !204

92:                                               ; preds = %87
  call void @llvm.dbg.value(metadata i8* %90, metadata !102, metadata !DIExpression()) #3, !dbg !199
  %93 = getelementptr inbounds i8, i8* %90, i64 40, !dbg !205
  %94 = bitcast i8* %93 to i64*, !dbg !205
  %95 = load i64, i64* %94, align 8, !dbg !205, !tbaa !118
  %96 = sub i64 %89, %95, !dbg !206
  call void @llvm.dbg.value(metadata i64 %96, metadata !103, metadata !DIExpression()) #3, !dbg !207
  call void @llvm.dbg.value(metadata i64 undef, metadata !106, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !207
  call void @llvm.dbg.value(metadata i64 undef, metadata !107, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !207
  %97 = bitcast i8* %90 to i64*, !dbg !208
  %98 = load i64, i64* %97, align 8, !dbg !208, !tbaa !125
  %99 = icmp eq i64 %98, 0, !dbg !209
  br i1 %99, label %107, label %100, !dbg !210

100:                                              ; preds = %92
  %101 = getelementptr inbounds i8, i8* %90, i64 24, !dbg !211
  %102 = bitcast i8* %101 to i64*, !dbg !211
  %103 = load i64, i64* %102, align 8, !dbg !211, !tbaa !129
  call void @llvm.dbg.value(metadata i64 %103, metadata !106, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !207
  %104 = mul i64 %103, 1000000000, !dbg !212
  call void @llvm.dbg.value(metadata i64 %104, metadata !106, metadata !DIExpression()) #3, !dbg !207
  %105 = icmp ugt i64 %96, %104, !dbg !213
  br i1 %105, label %106, label %114, !dbg !214

106:                                              ; preds = %100
  store i64 0, i64* %97, align 8, !dbg !215, !tbaa !125
  store i64 %89, i64* %94, align 8, !dbg !216, !tbaa !118
  br label %114, !dbg !217

107:                                              ; preds = %92
  %108 = getelementptr inbounds i8, i8* %90, i64 32, !dbg !218
  %109 = bitcast i8* %108 to i64*, !dbg !218
  %110 = load i64, i64* %109, align 8, !dbg !218, !tbaa !138
  call void @llvm.dbg.value(metadata i64 %110, metadata !107, metadata !DIExpression(DW_OP_constu, 1000000000, DW_OP_mul, DW_OP_stack_value)) #3, !dbg !207
  %111 = mul i64 %110, 1000000000, !dbg !219
  call void @llvm.dbg.value(metadata i64 %111, metadata !107, metadata !DIExpression()) #3, !dbg !207
  %112 = icmp ugt i64 %96, %111
  br i1 %112, label %113, label %114, !dbg !220

113:                                              ; preds = %107
  store i64 1, i64* %97, align 8, !dbg !221, !tbaa !125
  store i64 %89, i64* %94, align 8, !dbg !222, !tbaa !118
  br label %114, !dbg !223

114:                                              ; preds = %87, %100, %106, %107, %113
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %88), !dbg !224
  %115 = bitcast i32* %2 to i8*, !dbg !225
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %115), !dbg !225
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !228, metadata !DIExpression()) #3, !dbg !225
  store i32 0, i32* %2, align 4, !dbg !231, !tbaa !109
  %116 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @queue_length_map to i8*), i8* nonnull %115) #3, !dbg !232
  %117 = bitcast i8* %116 to i64*, !dbg !232
  call void @llvm.dbg.value(metadata i64* %117, metadata !229, metadata !DIExpression()) #3, !dbg !225
  %118 = icmp eq i8* %116, null, !dbg !233
  br i1 %118, label %124, label %119, !dbg !235

119:                                              ; preds = %114
  %120 = load i64, i64* %117, align 8, !dbg !236, !tbaa !238
  %121 = icmp ult i64 %120, 1000, !dbg !239
  br i1 %121, label %122, label %124, !dbg !240

122:                                              ; preds = %119
  %123 = add nuw nsw i64 %120, 1, !dbg !241
  store i64 %123, i64* %117, align 8, !dbg !241, !tbaa !238
  br label %124, !dbg !243

124:                                              ; preds = %114, %119, %122
  %125 = phi i32 [ 2, %122 ], [ 1, %114 ], [ 1, %119 ], !dbg !225
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %115), !dbg !244
  ret i32 %125, !dbg !245
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
!1 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 86, type: !75, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "kern.c", directory: "/home/shrestha/btp/pktsniff/xdp/packet/redirecting/self_similar_traf/c")
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
!14 = !{!0, !15, !46, !59, !66}
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "source_states", scope: !2, file: !3, line: 25, type: !17, isLocal: false, isDefinition: true)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 20, size: 256, elements: !18)
!18 = !{!19, !25, !29, !41}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !17, file: !3, line: 21, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 64, elements: !23)
!22 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!23 = !{!24}
!24 = !DISubrange(count: 2)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !17, file: !3, line: 22, baseType: !26, size: 64, offset: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !28, line: 27, baseType: !7)
!28 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!29 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !17, file: !3, line: 23, baseType: !30, size: 64, offset: 128)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!31 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "source_state", file: !3, line: 11, size: 384, elements: !32)
!32 = !{!33, !36, !37, !38, !39, !40}
!33 = !DIDerivedType(tag: DW_TAG_member, name: "active", scope: !31, file: !3, line: 12, baseType: !34, size: 64)
!34 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !28, line: 31, baseType: !35)
!35 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "intensity1", scope: !31, file: !3, line: 13, baseType: !34, size: 64, offset: 64)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "intensity2", scope: !31, file: !3, line: 14, baseType: !34, size: 64, offset: 128)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "transition_rate1", scope: !31, file: !3, line: 15, baseType: !34, size: 64, offset: 192)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "transition_rate2", scope: !31, file: !3, line: 16, baseType: !34, size: 64, offset: 256)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "last_transition", scope: !31, file: !3, line: 17, baseType: !34, size: 64, offset: 320)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !17, file: !3, line: 24, baseType: !42, size: 64, offset: 192)
!42 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !43, size: 64)
!43 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 128, elements: !44)
!44 = !{!45}
!45 = !DISubrange(count: 4)
!46 = !DIGlobalVariableExpression(var: !47, expr: !DIExpression())
!47 = distinct !DIGlobalVariable(name: "queue_length_map", scope: !2, file: !3, line: 32, type: !48, isLocal: false, isDefinition: true)
!48 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 27, size: 256, elements: !49)
!49 = !{!50, !51, !52, !54}
!50 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !48, file: !3, line: 28, baseType: !20, size: 64)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !48, file: !3, line: 29, baseType: !26, size: 64, offset: 64)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !48, file: !3, line: 30, baseType: !53, size: 64, offset: 128)
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !48, file: !3, line: 31, baseType: !55, size: 64, offset: 192)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !56, size: 64)
!56 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 32, elements: !57)
!57 = !{!58}
!58 = !DISubrange(count: 1)
!59 = !DIGlobalVariableExpression(var: !60, expr: !DIExpression())
!60 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !61, line: 114, type: !62, isLocal: true, isDefinition: true)
!61 = !DIFile(filename: "/usr/local/include/bpf/bpf_helper_defs.h", directory: "")
!62 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !63)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = !DISubroutineType(types: !65)
!65 = !{!34}
!66 = !DIGlobalVariableExpression(var: !67, expr: !DIExpression())
!67 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !61, line: 56, type: !68, isLocal: true, isDefinition: true)
!68 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !69)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = !DISubroutineType(types: !71)
!71 = !{!72, !72, !73}
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !74, size: 64)
!74 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!75 = !DICompositeType(tag: DW_TAG_array_type, baseType: !76, size: 32, elements: !44)
!76 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!77 = !{i32 7, !"Dwarf Version", i32 4}
!78 = !{i32 2, !"Debug Info Version", i32 3}
!79 = !{i32 1, !"wchar_size", i32 4}
!80 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!81 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !3, file: !3, line: 76, type: !82, scopeLine: 76, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !92)
!82 = !DISubroutineType(types: !83)
!83 = !{!22, !84}
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !86)
!86 = !{!87, !88, !89, !90, !91}
!87 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !85, file: !6, line: 3165, baseType: !27, size: 32)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !85, file: !6, line: 3166, baseType: !27, size: 32, offset: 32)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !85, file: !6, line: 3167, baseType: !27, size: 32, offset: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !85, file: !6, line: 3169, baseType: !27, size: 32, offset: 96)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !85, file: !6, line: 3170, baseType: !27, size: 32, offset: 128)
!92 = !{!93}
!93 = !DILocalVariable(name: "ctx", arg: 1, scope: !81, file: !3, line: 76, type: !84)
!94 = !DILocation(line: 0, scope: !81)
!95 = !DILocation(line: 0, scope: !96, inlinedAt: !108)
!96 = distinct !DISubprogram(name: "update_source_state", scope: !3, file: !3, line: 34, type: !97, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !99)
!97 = !DISubroutineType(types: !98)
!98 = !{null, !27}
!99 = !{!100, !101, !102, !103, !106, !107}
!100 = !DILocalVariable(name: "i", arg: 1, scope: !96, file: !3, line: 34, type: !27)
!101 = !DILocalVariable(name: "now", scope: !96, file: !3, line: 35, type: !34)
!102 = !DILocalVariable(name: "state", scope: !96, file: !3, line: 36, type: !30)
!103 = !DILocalVariable(name: "time_elapsed", scope: !104, file: !3, line: 39, type: !34)
!104 = distinct !DILexicalBlock(scope: !105, file: !3, line: 38, column: 14)
!105 = distinct !DILexicalBlock(scope: !96, file: !3, line: 38, column: 7)
!106 = !DILocalVariable(name: "rate1_ns", scope: !104, file: !3, line: 42, type: !34)
!107 = !DILocalVariable(name: "rate2_ns", scope: !104, file: !3, line: 43, type: !34)
!108 = distinct !DILocation(line: 78, column: 3, scope: !81)
!109 = !{!110, !110, i64 0}
!110 = !{!"int", !111, i64 0}
!111 = !{!"omnipotent char", !112, i64 0}
!112 = !{!"Simple C/C++ TBAA"}
!113 = !DILocation(line: 35, column: 15, scope: !96, inlinedAt: !108)
!114 = !DILocation(line: 36, column: 32, scope: !96, inlinedAt: !108)
!115 = !DILocation(line: 38, column: 7, scope: !105, inlinedAt: !108)
!116 = !DILocation(line: 38, column: 7, scope: !96, inlinedAt: !108)
!117 = !DILocation(line: 39, column: 39, scope: !104, inlinedAt: !108)
!118 = !{!119, !120, i64 40}
!119 = !{!"source_state", !120, i64 0, !120, i64 8, !120, i64 16, !120, i64 24, !120, i64 32, !120, i64 40}
!120 = !{!"long long", !111, i64 0}
!121 = !DILocation(line: 39, column: 30, scope: !104, inlinedAt: !108)
!122 = !DILocation(line: 0, scope: !104, inlinedAt: !108)
!123 = !DILocation(line: 46, column: 16, scope: !124, inlinedAt: !108)
!124 = distinct !DILexicalBlock(scope: !104, file: !3, line: 46, column: 9)
!125 = !{!119, !120, i64 0}
!126 = !DILocation(line: 46, column: 9, scope: !124, inlinedAt: !108)
!127 = !DILocation(line: 46, column: 23, scope: !124, inlinedAt: !108)
!128 = !DILocation(line: 42, column: 29, scope: !104, inlinedAt: !108)
!129 = !{!119, !120, i64 24}
!130 = !DILocation(line: 42, column: 46, scope: !104, inlinedAt: !108)
!131 = !DILocation(line: 46, column: 39, scope: !124, inlinedAt: !108)
!132 = !DILocation(line: 46, column: 9, scope: !104, inlinedAt: !108)
!133 = !DILocation(line: 47, column: 21, scope: !134, inlinedAt: !108)
!134 = distinct !DILexicalBlock(scope: !124, file: !3, line: 46, column: 51)
!135 = !DILocation(line: 48, column: 30, scope: !134, inlinedAt: !108)
!136 = !DILocation(line: 49, column: 5, scope: !134, inlinedAt: !108)
!137 = !DILocation(line: 43, column: 29, scope: !104, inlinedAt: !108)
!138 = !{!119, !120, i64 32}
!139 = !DILocation(line: 43, column: 46, scope: !104, inlinedAt: !108)
!140 = !DILocation(line: 51, column: 29, scope: !141, inlinedAt: !108)
!141 = distinct !DILexicalBlock(scope: !124, file: !3, line: 51, column: 14)
!142 = !DILocation(line: 52, column: 21, scope: !143, inlinedAt: !108)
!143 = distinct !DILexicalBlock(scope: !141, file: !3, line: 51, column: 57)
!144 = !DILocation(line: 53, column: 30, scope: !143, inlinedAt: !108)
!145 = !DILocation(line: 54, column: 5, scope: !143, inlinedAt: !108)
!146 = !DILocation(line: 56, column: 1, scope: !96, inlinedAt: !108)
!147 = !DILocation(line: 0, scope: !96, inlinedAt: !148)
!148 = distinct !DILocation(line: 79, column: 3, scope: !81)
!149 = !DILocation(line: 35, column: 15, scope: !96, inlinedAt: !148)
!150 = !DILocation(line: 36, column: 32, scope: !96, inlinedAt: !148)
!151 = !DILocation(line: 38, column: 7, scope: !105, inlinedAt: !148)
!152 = !DILocation(line: 38, column: 7, scope: !96, inlinedAt: !148)
!153 = !DILocation(line: 39, column: 39, scope: !104, inlinedAt: !148)
!154 = !DILocation(line: 39, column: 30, scope: !104, inlinedAt: !148)
!155 = !DILocation(line: 0, scope: !104, inlinedAt: !148)
!156 = !DILocation(line: 46, column: 16, scope: !124, inlinedAt: !148)
!157 = !DILocation(line: 46, column: 9, scope: !124, inlinedAt: !148)
!158 = !DILocation(line: 46, column: 23, scope: !124, inlinedAt: !148)
!159 = !DILocation(line: 42, column: 29, scope: !104, inlinedAt: !148)
!160 = !DILocation(line: 42, column: 46, scope: !104, inlinedAt: !148)
!161 = !DILocation(line: 46, column: 39, scope: !124, inlinedAt: !148)
!162 = !DILocation(line: 46, column: 9, scope: !104, inlinedAt: !148)
!163 = !DILocation(line: 47, column: 21, scope: !134, inlinedAt: !148)
!164 = !DILocation(line: 48, column: 30, scope: !134, inlinedAt: !148)
!165 = !DILocation(line: 49, column: 5, scope: !134, inlinedAt: !148)
!166 = !DILocation(line: 43, column: 29, scope: !104, inlinedAt: !148)
!167 = !DILocation(line: 43, column: 46, scope: !104, inlinedAt: !148)
!168 = !DILocation(line: 51, column: 29, scope: !141, inlinedAt: !148)
!169 = !DILocation(line: 52, column: 21, scope: !143, inlinedAt: !148)
!170 = !DILocation(line: 53, column: 30, scope: !143, inlinedAt: !148)
!171 = !DILocation(line: 54, column: 5, scope: !143, inlinedAt: !148)
!172 = !DILocation(line: 56, column: 1, scope: !96, inlinedAt: !148)
!173 = !DILocation(line: 0, scope: !96, inlinedAt: !174)
!174 = distinct !DILocation(line: 80, column: 3, scope: !81)
!175 = !DILocation(line: 35, column: 15, scope: !96, inlinedAt: !174)
!176 = !DILocation(line: 36, column: 32, scope: !96, inlinedAt: !174)
!177 = !DILocation(line: 38, column: 7, scope: !105, inlinedAt: !174)
!178 = !DILocation(line: 38, column: 7, scope: !96, inlinedAt: !174)
!179 = !DILocation(line: 39, column: 39, scope: !104, inlinedAt: !174)
!180 = !DILocation(line: 39, column: 30, scope: !104, inlinedAt: !174)
!181 = !DILocation(line: 0, scope: !104, inlinedAt: !174)
!182 = !DILocation(line: 46, column: 16, scope: !124, inlinedAt: !174)
!183 = !DILocation(line: 46, column: 9, scope: !124, inlinedAt: !174)
!184 = !DILocation(line: 46, column: 23, scope: !124, inlinedAt: !174)
!185 = !DILocation(line: 42, column: 29, scope: !104, inlinedAt: !174)
!186 = !DILocation(line: 42, column: 46, scope: !104, inlinedAt: !174)
!187 = !DILocation(line: 46, column: 39, scope: !124, inlinedAt: !174)
!188 = !DILocation(line: 46, column: 9, scope: !104, inlinedAt: !174)
!189 = !DILocation(line: 47, column: 21, scope: !134, inlinedAt: !174)
!190 = !DILocation(line: 48, column: 30, scope: !134, inlinedAt: !174)
!191 = !DILocation(line: 49, column: 5, scope: !134, inlinedAt: !174)
!192 = !DILocation(line: 43, column: 29, scope: !104, inlinedAt: !174)
!193 = !DILocation(line: 43, column: 46, scope: !104, inlinedAt: !174)
!194 = !DILocation(line: 51, column: 29, scope: !141, inlinedAt: !174)
!195 = !DILocation(line: 52, column: 21, scope: !143, inlinedAt: !174)
!196 = !DILocation(line: 53, column: 30, scope: !143, inlinedAt: !174)
!197 = !DILocation(line: 54, column: 5, scope: !143, inlinedAt: !174)
!198 = !DILocation(line: 56, column: 1, scope: !96, inlinedAt: !174)
!199 = !DILocation(line: 0, scope: !96, inlinedAt: !200)
!200 = distinct !DILocation(line: 81, column: 3, scope: !81)
!201 = !DILocation(line: 35, column: 15, scope: !96, inlinedAt: !200)
!202 = !DILocation(line: 36, column: 32, scope: !96, inlinedAt: !200)
!203 = !DILocation(line: 38, column: 7, scope: !105, inlinedAt: !200)
!204 = !DILocation(line: 38, column: 7, scope: !96, inlinedAt: !200)
!205 = !DILocation(line: 39, column: 39, scope: !104, inlinedAt: !200)
!206 = !DILocation(line: 39, column: 30, scope: !104, inlinedAt: !200)
!207 = !DILocation(line: 0, scope: !104, inlinedAt: !200)
!208 = !DILocation(line: 46, column: 16, scope: !124, inlinedAt: !200)
!209 = !DILocation(line: 46, column: 9, scope: !124, inlinedAt: !200)
!210 = !DILocation(line: 46, column: 23, scope: !124, inlinedAt: !200)
!211 = !DILocation(line: 42, column: 29, scope: !104, inlinedAt: !200)
!212 = !DILocation(line: 42, column: 46, scope: !104, inlinedAt: !200)
!213 = !DILocation(line: 46, column: 39, scope: !124, inlinedAt: !200)
!214 = !DILocation(line: 46, column: 9, scope: !104, inlinedAt: !200)
!215 = !DILocation(line: 47, column: 21, scope: !134, inlinedAt: !200)
!216 = !DILocation(line: 48, column: 30, scope: !134, inlinedAt: !200)
!217 = !DILocation(line: 49, column: 5, scope: !134, inlinedAt: !200)
!218 = !DILocation(line: 43, column: 29, scope: !104, inlinedAt: !200)
!219 = !DILocation(line: 43, column: 46, scope: !104, inlinedAt: !200)
!220 = !DILocation(line: 51, column: 29, scope: !141, inlinedAt: !200)
!221 = !DILocation(line: 52, column: 21, scope: !143, inlinedAt: !200)
!222 = !DILocation(line: 53, column: 30, scope: !143, inlinedAt: !200)
!223 = !DILocation(line: 54, column: 5, scope: !143, inlinedAt: !200)
!224 = !DILocation(line: 56, column: 1, scope: !96, inlinedAt: !200)
!225 = !DILocation(line: 0, scope: !226, inlinedAt: !230)
!226 = distinct !DISubprogram(name: "handle_packet", scope: !3, file: !3, line: 58, type: !82, scopeLine: 58, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !227)
!227 = !{!228, !229}
!228 = !DILocalVariable(name: "ctx", arg: 1, scope: !226, file: !3, line: 58, type: !84)
!229 = !DILocalVariable(name: "queue_length", scope: !226, file: !3, line: 59, type: !53)
!230 = distinct !DILocation(line: 83, column: 10, scope: !81)
!231 = !DILocation(line: 59, column: 65, scope: !226, inlinedAt: !230)
!232 = !DILocation(line: 59, column: 25, scope: !226, inlinedAt: !230)
!233 = !DILocation(line: 60, column: 8, scope: !234, inlinedAt: !230)
!234 = distinct !DILexicalBlock(scope: !226, file: !3, line: 60, column: 7)
!235 = !DILocation(line: 60, column: 7, scope: !226, inlinedAt: !230)
!236 = !DILocation(line: 65, column: 7, scope: !237, inlinedAt: !230)
!237 = distinct !DILexicalBlock(scope: !226, file: !3, line: 65, column: 7)
!238 = !{!120, !120, i64 0}
!239 = !DILocation(line: 65, column: 21, scope: !237, inlinedAt: !230)
!240 = !DILocation(line: 65, column: 7, scope: !226, inlinedAt: !230)
!241 = !DILocation(line: 67, column: 19, scope: !242, inlinedAt: !230)
!242 = distinct !DILexicalBlock(scope: !237, file: !3, line: 65, column: 41)
!243 = !DILocation(line: 68, column: 5, scope: !242, inlinedAt: !230)
!244 = !DILocation(line: 73, column: 1, scope: !226, inlinedAt: !230)
!245 = !DILocation(line: 83, column: 3, scope: !81)
