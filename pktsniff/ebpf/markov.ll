; ModuleID = 'markov.c'
source_filename = "markov.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [4 x i32]*, [4 x i32]*, [4 x i32]*, [1024 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.perf_trace_event = type { i64, i32, i8, i8, i16, i16 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@output_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !43
@llvm.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @output_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_lib to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_lib(%struct.xdp_md* %0) #0 section "xdp" !dbg !66 {
  %2 = alloca %struct.perf_trace_event, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !78, metadata !DIExpression()), !dbg !162
  %3 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !163
  %4 = load i32, i32* %3, align 4, !dbg !163, !tbaa !164
  %5 = zext i32 %4 to i64, !dbg !169
  %6 = inttoptr i64 %5 to i8*, !dbg !170
  call void @llvm.dbg.value(metadata i8* %6, metadata !79, metadata !DIExpression()), !dbg !162
  %7 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !171
  %8 = load i32, i32* %7, align 4, !dbg !171, !tbaa !172
  %9 = zext i32 %8 to i64, !dbg !173
  %10 = inttoptr i64 %9 to %struct.ethhdr*, !dbg !174
  call void @llvm.dbg.value(metadata %struct.ethhdr* %10, metadata !80, metadata !DIExpression()), !dbg !162
  call void @llvm.dbg.value(metadata %struct.ethhdr* %10, metadata !81, metadata !DIExpression()), !dbg !162
  %11 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %10, i64 1, i32 0, i64 0, !dbg !175
  %12 = icmp ugt i8* %11, %6, !dbg !177
  br i1 %12, label %80, label %13, !dbg !178

13:                                               ; preds = %1
  %14 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %10, i64 0, i32 2, !dbg !179
  %15 = load i16, i16* %14, align 1, !dbg !179, !tbaa !181
  %16 = icmp eq i16 %15, 8, !dbg !184
  br i1 %16, label %17, label %80, !dbg !185

17:                                               ; preds = %13
  call void @llvm.dbg.value(metadata i8* %11, metadata !95, metadata !DIExpression()), !dbg !162
  %18 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %10, i64 1, i32 0, i64 20, !dbg !186
  %19 = icmp ugt i8* %18, %6, !dbg !188
  br i1 %19, label %80, label %20, !dbg !189

20:                                               ; preds = %17
  call void @llvm.dbg.value(metadata i8* %11, metadata !95, metadata !DIExpression()), !dbg !162
  %21 = bitcast %struct.perf_trace_event* %2 to i8*, !dbg !190
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %21) #3, !dbg !190
  call void @llvm.dbg.declare(metadata %struct.perf_trace_event* %2, metadata !114, metadata !DIExpression()), !dbg !191
  %22 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 1, !dbg !191
  %23 = bitcast i32* %22 to i8*, !dbg !191
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(24) %23, i8 0, i64 16, i1 false), !dbg !191
  %24 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !192
  %25 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 0, !dbg !193
  store i64 %24, i64* %25, align 8, !dbg !194, !tbaa !195
  %26 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 2, !dbg !198
  store i8 1, i8* %26, align 4, !dbg !199, !tbaa !200
  %27 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %10, i64 1, i32 0, i64 9, !dbg !201
  %28 = load i8, i8* %27, align 1, !dbg !201, !tbaa !202
  %29 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 3, !dbg !204
  store i8 %28, i8* %29, align 1, !dbg !205, !tbaa !206
  switch i8 %28, label %54 [
    i8 6, label %30
    i8 17, label %42
  ], !dbg !207

30:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i8* %18, metadata !123, metadata !DIExpression()), !dbg !208
  %31 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %10, i64 1, i32 0, i64 40, !dbg !209
  %32 = icmp ugt i8* %31, %6, !dbg !211
  br i1 %32, label %78, label %33, !dbg !212

33:                                               ; preds = %30
  %34 = bitcast i8* %18 to i16*, !dbg !213
  %35 = load i16, i16* %34, align 4, !dbg !213, !tbaa !214
  %36 = tail call i16 @llvm.bswap.i16(i16 %35)
  %37 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 4, !dbg !216
  store i16 %36, i16* %37, align 2, !dbg !217, !tbaa !218
  %38 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %10, i64 1, i32 0, i64 22, !dbg !219
  %39 = bitcast i8* %38 to i16*, !dbg !219
  %40 = load i16, i16* %39, align 2, !dbg !219, !tbaa !220
  %41 = tail call i16 @llvm.bswap.i16(i16 %40), !dbg !219
  br label %56

42:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i8* %18, metadata !147, metadata !DIExpression()), !dbg !221
  %43 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %10, i64 1, i32 0, i64 28, !dbg !222
  %44 = icmp ugt i8* %43, %6, !dbg !224
  br i1 %44, label %78, label %45, !dbg !225

45:                                               ; preds = %42
  %46 = bitcast i8* %18 to i16*, !dbg !226
  %47 = load i16, i16* %46, align 2, !dbg !226, !tbaa !227
  %48 = tail call i16 @llvm.bswap.i16(i16 %47)
  %49 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 4, !dbg !229
  store i16 %48, i16* %49, align 2, !dbg !230, !tbaa !218
  %50 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %10, i64 1, i32 0, i64 22, !dbg !231
  %51 = bitcast i8* %50 to i16*, !dbg !231
  %52 = load i16, i16* %51, align 2, !dbg !231, !tbaa !232
  %53 = tail call i16 @llvm.bswap.i16(i16 %52), !dbg !231
  br label %56

54:                                               ; preds = %20
  %55 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 4, !dbg !233
  store i16 0, i16* %55, align 2, !dbg !235, !tbaa !218
  br label %56

56:                                               ; preds = %45, %33, %54
  %57 = phi i16 [ %53, %45 ], [ %41, %33 ], [ 0, %54 ]
  %58 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 5, !dbg !236
  store i16 %57, i16* %58, align 8, !dbg !236, !tbaa !237
  %59 = bitcast %struct.xdp_md* %0 to i8*, !dbg !238
  %60 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* %59, i8* bitcast (%struct.anon* @output_map to i8*), i64 4294967295, i8* nonnull %21, i64 24) #3, !dbg !239
  %61 = call i32 inttoptr (i64 7 to i32 ()*)() #3, !dbg !240
  %62 = and i32 %61, 1, !dbg !241
  %63 = icmp eq i32 %62, 0, !dbg !242
  br i1 %63, label %64, label %71, !dbg !243

64:                                               ; preds = %56
  store i8 2, i8* %26, align 4, !dbg !244, !tbaa !200
  %65 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !245
  call void @llvm.dbg.value(metadata i64 %65, metadata !158, metadata !DIExpression()), !dbg !246
  %66 = load i64, i64* %25, align 8, !dbg !247, !tbaa !195
  %67 = sub i64 %65, %66, !dbg !248
  %68 = trunc i64 %67 to i32, !dbg !249
  %69 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 1, !dbg !250
  store i32 %68, i32* %69, align 8, !dbg !251, !tbaa !252
  store i64 %65, i64* %25, align 8, !dbg !253, !tbaa !195
  %70 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* %59, i8* bitcast (%struct.anon* @output_map to i8*), i64 4294967295, i8* nonnull %21, i64 24) #3, !dbg !254
  br label %78

71:                                               ; preds = %56
  store i8 3, i8* %26, align 4, !dbg !255, !tbaa !200
  %72 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !256
  call void @llvm.dbg.value(metadata i64 %72, metadata !161, metadata !DIExpression()), !dbg !162
  %73 = load i64, i64* %25, align 8, !dbg !257, !tbaa !195
  %74 = sub i64 %72, %73, !dbg !258
  %75 = trunc i64 %74 to i32, !dbg !259
  %76 = getelementptr inbounds %struct.perf_trace_event, %struct.perf_trace_event* %2, i64 0, i32 1, !dbg !260
  store i32 %75, i32* %76, align 8, !dbg !261, !tbaa !252
  store i64 %72, i64* %25, align 8, !dbg !262, !tbaa !195
  %77 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* %59, i8* bitcast (%struct.anon* @output_map to i8*), i64 4294967295, i8* nonnull %21, i64 24) #3, !dbg !263
  br label %78

78:                                               ; preds = %42, %30, %71, %64
  %79 = phi i32 [ 1, %64 ], [ 2, %71 ], [ 2, %30 ], [ 2, %42 ], !dbg !162
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %21) #3, !dbg !264
  br label %80

80:                                               ; preds = %78, %17, %13, %1
  %81 = phi i32 [ 2, %1 ], [ 2, %13 ], [ %79, %78 ], [ 2, %17 ], !dbg !162
  ret i32 %81, !dbg !264
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!62, !63, !64}
!llvm.ident = !{!65}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "output_map", scope: !2, file: !3, line: 30, type: !49, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "markov.c", directory: "/home/shrestha/btp/pktsniff/ebpf")
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
!14 = !{!15, !16, !17}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!16 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !18, line: 24, baseType: !19)
!18 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!19 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!20 = !{!21, !30, !36, !43, !0}
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !23, line: 114, type: !24, isLocal: true, isDefinition: true)
!23 = !DIFile(filename: "/usr/local/include/bpf/bpf_helper_defs.h", directory: "")
!24 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !25)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64)
!26 = !DISubroutineType(types: !27)
!27 = !{!28}
!28 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !18, line: 31, baseType: !29)
!29 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!30 = !DIGlobalVariableExpression(var: !31, expr: !DIExpression())
!31 = distinct !DIGlobalVariable(name: "bpf_perf_event_output", scope: !2, file: !23, line: 698, type: !32, isLocal: true, isDefinition: true)
!32 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !33)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DISubroutineType(types: !35)
!35 = !{!16, !15, !15, !28, !15, !28}
!36 = !DIGlobalVariableExpression(var: !37, expr: !DIExpression())
!37 = distinct !DIGlobalVariable(name: "bpf_get_prandom_u32", scope: !2, file: !23, line: 193, type: !38, isLocal: true, isDefinition: true)
!38 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !39)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!40 = !DISubroutineType(types: !41)
!41 = !{!42}
!42 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !18, line: 27, baseType: !7)
!43 = !DIGlobalVariableExpression(var: !44, expr: !DIExpression())
!44 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 90, type: !45, isLocal: false, isDefinition: true)
!45 = !DICompositeType(tag: DW_TAG_array_type, baseType: !46, size: 32, elements: !47)
!46 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!47 = !{!48}
!48 = !DISubrange(count: 4)
!49 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 25, size: 256, elements: !50)
!50 = !{!51, !55, !56, !57}
!51 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !49, file: !3, line: 26, baseType: !52, size: 64)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DICompositeType(tag: DW_TAG_array_type, baseType: !54, size: 128, elements: !47)
!54 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !49, file: !3, line: 27, baseType: !52, size: 64, offset: 64)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !49, file: !3, line: 28, baseType: !52, size: 64, offset: 128)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !49, file: !3, line: 29, baseType: !58, size: 64, offset: 192)
!58 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !59, size: 64)
!59 = !DICompositeType(tag: DW_TAG_array_type, baseType: !54, size: 32768, elements: !60)
!60 = !{!61}
!61 = !DISubrange(count: 1024)
!62 = !{i32 7, !"Dwarf Version", i32 4}
!63 = !{i32 2, !"Debug Info Version", i32 3}
!64 = !{i32 1, !"wchar_size", i32 4}
!65 = !{!"clang version 10.0.0-4ubuntu1 "}
!66 = distinct !DISubprogram(name: "xdp_lib", scope: !3, file: !3, line: 33, type: !67, scopeLine: 33, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !77)
!67 = !DISubroutineType(types: !68)
!68 = !{!54, !69}
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !71)
!71 = !{!72, !73, !74, !75, !76}
!72 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !70, file: !6, line: 3165, baseType: !42, size: 32)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !70, file: !6, line: 3166, baseType: !42, size: 32, offset: 32)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !70, file: !6, line: 3167, baseType: !42, size: 32, offset: 64)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !70, file: !6, line: 3169, baseType: !42, size: 32, offset: 96)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !70, file: !6, line: 3170, baseType: !42, size: 32, offset: 128)
!77 = !{!78, !79, !80, !81, !95, !114, !123, !147, !158, !161}
!78 = !DILocalVariable(name: "ctx", arg: 1, scope: !66, file: !3, line: 33, type: !69)
!79 = !DILocalVariable(name: "data_end", scope: !66, file: !3, line: 34, type: !15)
!80 = !DILocalVariable(name: "data", scope: !66, file: !3, line: 35, type: !15)
!81 = !DILocalVariable(name: "eth", scope: !66, file: !3, line: 36, type: !82)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !84, line: 163, size: 112, elements: !85)
!84 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!85 = !{!86, !91, !92}
!86 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !83, file: !84, line: 164, baseType: !87, size: 48)
!87 = !DICompositeType(tag: DW_TAG_array_type, baseType: !88, size: 48, elements: !89)
!88 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!89 = !{!90}
!90 = !DISubrange(count: 6)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !83, file: !84, line: 165, baseType: !87, size: 48, offset: 48)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !83, file: !84, line: 166, baseType: !93, size: 16, offset: 96)
!93 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !94, line: 25, baseType: !17)
!94 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!95 = !DILocalVariable(name: "ip", scope: !66, file: !3, line: 44, type: !96)
!96 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 64)
!97 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !98, line: 86, size: 160, elements: !99)
!98 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!99 = !{!100, !102, !103, !104, !105, !106, !107, !108, !109, !111, !113}
!100 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !97, file: !98, line: 88, baseType: !101, size: 4, flags: DIFlagBitField, extraData: i64 0)
!101 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !18, line: 21, baseType: !88)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !97, file: !98, line: 89, baseType: !101, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !97, file: !98, line: 96, baseType: !101, size: 8, offset: 8)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !97, file: !98, line: 97, baseType: !93, size: 16, offset: 16)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !97, file: !98, line: 98, baseType: !93, size: 16, offset: 32)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !97, file: !98, line: 99, baseType: !93, size: 16, offset: 48)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !97, file: !98, line: 100, baseType: !101, size: 8, offset: 64)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !97, file: !98, line: 101, baseType: !101, size: 8, offset: 72)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !97, file: !98, line: 102, baseType: !110, size: 16, offset: 80)
!110 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !94, line: 31, baseType: !17)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !97, file: !98, line: 103, baseType: !112, size: 32, offset: 96)
!112 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !94, line: 27, baseType: !42)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !97, file: !98, line: 104, baseType: !112, size: 32, offset: 128)
!114 = !DILocalVariable(name: "e", scope: !66, file: !3, line: 48, type: !115)
!115 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "perf_trace_event", file: !3, line: 10, size: 192, elements: !116)
!116 = !{!117, !118, !119, !120, !121, !122}
!117 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !115, file: !3, line: 11, baseType: !28, size: 64)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time_ns", scope: !115, file: !3, line: 12, baseType: !42, size: 32, offset: 64)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !115, file: !3, line: 13, baseType: !101, size: 8, offset: 96)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !115, file: !3, line: 14, baseType: !101, size: 8, offset: 104)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !115, file: !3, line: 15, baseType: !17, size: 16, offset: 112)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !115, file: !3, line: 16, baseType: !17, size: 16, offset: 128)
!123 = !DILocalVariable(name: "tcp", scope: !124, file: !3, line: 54, type: !126)
!124 = distinct !DILexicalBlock(scope: !125, file: !3, line: 53, column: 36)
!125 = distinct !DILexicalBlock(scope: !66, file: !3, line: 53, column: 7)
!126 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !127, size: 64)
!127 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !128, line: 25, size: 160, elements: !129)
!128 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "")
!129 = !{!130, !131, !132, !133, !134, !135, !136, !137, !138, !139, !140, !141, !142, !143, !144, !145, !146}
!130 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !127, file: !128, line: 26, baseType: !93, size: 16)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !127, file: !128, line: 27, baseType: !93, size: 16, offset: 16)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !127, file: !128, line: 28, baseType: !112, size: 32, offset: 32)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !127, file: !128, line: 29, baseType: !112, size: 32, offset: 64)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !127, file: !128, line: 31, baseType: !17, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !127, file: !128, line: 32, baseType: !17, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !127, file: !128, line: 33, baseType: !17, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !127, file: !128, line: 34, baseType: !17, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !127, file: !128, line: 35, baseType: !17, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !127, file: !128, line: 36, baseType: !17, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !127, file: !128, line: 37, baseType: !17, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!141 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !127, file: !128, line: 38, baseType: !17, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !127, file: !128, line: 39, baseType: !17, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !127, file: !128, line: 40, baseType: !17, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !127, file: !128, line: 55, baseType: !93, size: 16, offset: 112)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !127, file: !128, line: 56, baseType: !110, size: 16, offset: 128)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !127, file: !128, line: 57, baseType: !93, size: 16, offset: 144)
!147 = !DILocalVariable(name: "udp", scope: !148, file: !3, line: 60, type: !150)
!148 = distinct !DILexicalBlock(scope: !149, file: !3, line: 59, column: 43)
!149 = distinct !DILexicalBlock(scope: !125, file: !3, line: 59, column: 14)
!150 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !151, size: 64)
!151 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "udphdr", file: !152, line: 23, size: 64, elements: !153)
!152 = !DIFile(filename: "/usr/include/linux/udp.h", directory: "")
!153 = !{!154, !155, !156, !157}
!154 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !151, file: !152, line: 24, baseType: !93, size: 16)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !151, file: !152, line: 25, baseType: !93, size: 16, offset: 16)
!156 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !151, file: !152, line: 26, baseType: !93, size: 16, offset: 32)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !151, file: !152, line: 27, baseType: !110, size: 16, offset: 48)
!158 = !DILocalVariable(name: "ts", scope: !159, file: !3, line: 74, type: !28)
!159 = distinct !DILexicalBlock(scope: !160, file: !3, line: 72, column: 39)
!160 = distinct !DILexicalBlock(scope: !66, file: !3, line: 72, column: 7)
!161 = !DILocalVariable(name: "ts", scope: !66, file: !3, line: 82, type: !28)
!162 = !DILocation(line: 0, scope: !66)
!163 = !DILocation(line: 34, column: 39, scope: !66)
!164 = !{!165, !166, i64 4}
!165 = !{!"xdp_md", !166, i64 0, !166, i64 4, !166, i64 8, !166, i64 12, !166, i64 16}
!166 = !{!"int", !167, i64 0}
!167 = !{!"omnipotent char", !168, i64 0}
!168 = !{!"Simple C/C++ TBAA"}
!169 = !DILocation(line: 34, column: 28, scope: !66)
!170 = !DILocation(line: 34, column: 20, scope: !66)
!171 = !DILocation(line: 35, column: 35, scope: !66)
!172 = !{!165, !166, i64 0}
!173 = !DILocation(line: 35, column: 24, scope: !66)
!174 = !DILocation(line: 36, column: 24, scope: !66)
!175 = !DILocation(line: 38, column: 7, scope: !176)
!176 = distinct !DILexicalBlock(scope: !66, file: !3, line: 38, column: 7)
!177 = !DILocation(line: 38, column: 25, scope: !176)
!178 = !DILocation(line: 38, column: 7, scope: !66)
!179 = !DILocation(line: 41, column: 12, scope: !180)
!180 = distinct !DILexicalBlock(scope: !66, file: !3, line: 41, column: 7)
!181 = !{!182, !183, i64 12}
!182 = !{!"ethhdr", !167, i64 0, !167, i64 6, !183, i64 12}
!183 = !{!"short", !167, i64 0}
!184 = !DILocation(line: 41, column: 20, scope: !180)
!185 = !DILocation(line: 41, column: 7, scope: !66)
!186 = !DILocation(line: 45, column: 19, scope: !187)
!187 = distinct !DILexicalBlock(scope: !66, file: !3, line: 45, column: 7)
!188 = !DILocation(line: 45, column: 24, scope: !187)
!189 = !DILocation(line: 45, column: 7, scope: !66)
!190 = !DILocation(line: 48, column: 3, scope: !66)
!191 = !DILocation(line: 48, column: 27, scope: !66)
!192 = !DILocation(line: 49, column: 17, scope: !66)
!193 = !DILocation(line: 49, column: 5, scope: !66)
!194 = !DILocation(line: 49, column: 15, scope: !66)
!195 = !{!196, !197, i64 0}
!196 = !{!"perf_trace_event", !197, i64 0, !166, i64 8, !167, i64 12, !167, i64 13, !183, i64 14, !183, i64 16}
!197 = !{!"long long", !167, i64 0}
!198 = !DILocation(line: 50, column: 5, scope: !66)
!199 = !DILocation(line: 50, column: 10, scope: !66)
!200 = !{!196, !167, i64 12}
!201 = !DILocation(line: 51, column: 20, scope: !66)
!202 = !{!203, !167, i64 9}
!203 = !{!"iphdr", !167, i64 0, !167, i64 0, !167, i64 1, !183, i64 2, !183, i64 4, !183, i64 6, !167, i64 8, !167, i64 9, !183, i64 10, !166, i64 12, !166, i64 16}
!204 = !DILocation(line: 51, column: 5, scope: !66)
!205 = !DILocation(line: 51, column: 14, scope: !66)
!206 = !{!196, !167, i64 13}
!207 = !DILocation(line: 53, column: 7, scope: !66)
!208 = !DILocation(line: 0, scope: !124)
!209 = !DILocation(line: 55, column: 22, scope: !210)
!210 = distinct !DILexicalBlock(scope: !124, file: !3, line: 55, column: 9)
!211 = !DILocation(line: 55, column: 27, scope: !210)
!212 = !DILocation(line: 55, column: 9, scope: !124)
!213 = !DILocation(line: 57, column: 18, scope: !124)
!214 = !{!215, !183, i64 0}
!215 = !{!"tcphdr", !183, i64 0, !183, i64 2, !166, i64 4, !166, i64 8, !183, i64 12, !183, i64 12, !183, i64 13, !183, i64 13, !183, i64 13, !183, i64 13, !183, i64 13, !183, i64 13, !183, i64 13, !183, i64 13, !183, i64 14, !183, i64 16, !183, i64 18}
!216 = !DILocation(line: 57, column: 7, scope: !124)
!217 = !DILocation(line: 57, column: 16, scope: !124)
!218 = !{!196, !183, i64 14}
!219 = !DILocation(line: 58, column: 18, scope: !124)
!220 = !{!215, !183, i64 2}
!221 = !DILocation(line: 0, scope: !148)
!222 = !DILocation(line: 61, column: 22, scope: !223)
!223 = distinct !DILexicalBlock(scope: !148, file: !3, line: 61, column: 9)
!224 = !DILocation(line: 61, column: 27, scope: !223)
!225 = !DILocation(line: 61, column: 9, scope: !148)
!226 = !DILocation(line: 63, column: 18, scope: !148)
!227 = !{!228, !183, i64 0}
!228 = !{!"udphdr", !183, i64 0, !183, i64 2, !183, i64 4, !183, i64 6}
!229 = !DILocation(line: 63, column: 7, scope: !148)
!230 = !DILocation(line: 63, column: 16, scope: !148)
!231 = !DILocation(line: 64, column: 18, scope: !148)
!232 = !{!228, !183, i64 2}
!233 = !DILocation(line: 66, column: 7, scope: !234)
!234 = distinct !DILexicalBlock(scope: !149, file: !3, line: 65, column: 10)
!235 = !DILocation(line: 66, column: 16, scope: !234)
!236 = !DILocation(line: 0, scope: !125)
!237 = !{!196, !183, i64 16}
!238 = !DILocation(line: 70, column: 25, scope: !66)
!239 = !DILocation(line: 70, column: 3, scope: !66)
!240 = !DILocation(line: 72, column: 7, scope: !160)
!241 = !DILocation(line: 72, column: 29, scope: !160)
!242 = !DILocation(line: 72, column: 33, scope: !160)
!243 = !DILocation(line: 72, column: 7, scope: !66)
!244 = !DILocation(line: 73, column: 12, scope: !159)
!245 = !DILocation(line: 74, column: 16, scope: !159)
!246 = !DILocation(line: 0, scope: !159)
!247 = !DILocation(line: 75, column: 35, scope: !159)
!248 = !DILocation(line: 75, column: 31, scope: !159)
!249 = !DILocation(line: 75, column: 28, scope: !159)
!250 = !DILocation(line: 75, column: 7, scope: !159)
!251 = !DILocation(line: 75, column: 26, scope: !159)
!252 = !{!196, !166, i64 8}
!253 = !DILocation(line: 76, column: 17, scope: !159)
!254 = !DILocation(line: 77, column: 5, scope: !159)
!255 = !DILocation(line: 81, column: 10, scope: !66)
!256 = !DILocation(line: 82, column: 14, scope: !66)
!257 = !DILocation(line: 83, column: 33, scope: !66)
!258 = !DILocation(line: 83, column: 29, scope: !66)
!259 = !DILocation(line: 83, column: 26, scope: !66)
!260 = !DILocation(line: 83, column: 5, scope: !66)
!261 = !DILocation(line: 83, column: 24, scope: !66)
!262 = !DILocation(line: 84, column: 15, scope: !66)
!263 = !DILocation(line: 85, column: 3, scope: !66)
!264 = !DILocation(line: 88, column: 1, scope: !66)
