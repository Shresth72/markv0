; ModuleID = 'xdp_redirect_to_iface_kern.c'
source_filename = "xdp_redirect_to_iface_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [1 x i32]*, [6 x i8]*, [6 x i8]*, [1 x i32]* }
%struct.anon.0 = type { [14 x i32]*, i32*, i32*, [256 x i32]* }
%struct.anon.1 = type { [2 x i32]*, i32*, %struct.datarec*, [5 x i32]* }
%struct.datarec = type { i64, i64 }
%struct.anon.2 = type { [2 x i32]*, i32*, %struct.telrec*, [5 x i32]* }
%struct.telrec = type { i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@redirect_params = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@tx_port = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !85
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !42
@xdp_stats_map = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !48
@telemetry_stats_map = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !72
@llvm.used = appending global [6 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @redirect_params to i8*), i8* bitcast (%struct.anon.2* @telemetry_stats_map to i8*), i8* bitcast (%struct.anon.0* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_redirect_map_func to i8*), i8* bitcast (%struct.anon.1* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_redirect_map_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_redirect_map" !dbg !120 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !132, metadata !DIExpression()), !dbg !154
  %4 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !155
  call void @llvm.dbg.value(metadata i64 %4, metadata !133, metadata !DIExpression()), !dbg !154
  %5 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !156
  %6 = load i32, i32* %5, align 4, !dbg !156, !tbaa !157
  %7 = zext i32 %6 to i64, !dbg !162
  %8 = inttoptr i64 %7 to i8*, !dbg !163
  call void @llvm.dbg.value(metadata i8* %8, metadata !134, metadata !DIExpression()), !dbg !154
  %9 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !164
  %10 = load i32, i32* %9, align 4, !dbg !164, !tbaa !165
  %11 = zext i32 %10 to i64, !dbg !166
  %12 = inttoptr i64 %11 to i8*, !dbg !167
  call void @llvm.dbg.value(metadata i8* %12, metadata !135, metadata !DIExpression()), !dbg !154
  call void @llvm.dbg.value(metadata i32 2, metadata !148, metadata !DIExpression()), !dbg !154
  %13 = bitcast i32* %3 to i8*, !dbg !168
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %13) #3, !dbg !168
  call void @llvm.dbg.value(metadata i32 0, metadata !149, metadata !DIExpression()), !dbg !154
  store i32 0, i32* %3, align 4, !dbg !169, !tbaa !170
  %14 = getelementptr i8, i8* %12, i64 14, !dbg !171
  %15 = icmp ugt i8* %14, %8, !dbg !173
  br i1 %15, label %63, label %16, !dbg !174

16:                                               ; preds = %1
  %17 = inttoptr i64 %11 to %struct.ethhdr*, !dbg !175
  call void @llvm.dbg.value(metadata %struct.ethhdr* %17, metadata !136, metadata !DIExpression()), !dbg !154
  %18 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %17, i64 0, i32 1, i64 0, !dbg !176
  %19 = tail call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @redirect_params to i8*), i8* nonnull %18) #3, !dbg !177
  call void @llvm.dbg.value(metadata i8* %19, metadata !150, metadata !DIExpression()), !dbg !154
  %20 = icmp eq i8* %19, null, !dbg !178
  br i1 %20, label %25, label %21, !dbg !180

21:                                               ; preds = %16
  %22 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %17, i64 0, i32 0, i64 0, !dbg !181
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %22, i8* nonnull align 1 dereferenceable(6) %19, i64 6, i1 false), !dbg !181
  call void @llvm.dbg.value(metadata i32* %3, metadata !149, metadata !DIExpression(DW_OP_deref)), !dbg !154
  %23 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @tx_port to i8*), i8* nonnull %13) #3, !dbg !182
  call void @llvm.dbg.value(metadata i8* %23, metadata !152, metadata !DIExpression()), !dbg !154
  %24 = icmp eq i8* %23, null, !dbg !183
  br i1 %24, label %25, label %27, !dbg !185

25:                                               ; preds = %21, %16
  call void @llvm.dbg.value(metadata i32 %32, metadata !148, metadata !DIExpression()), !dbg !154
  call void @llvm.dbg.label(metadata !153), !dbg !186
  %26 = bitcast i32* %2 to i8*, !dbg !187
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %26), !dbg !187
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !192, metadata !DIExpression()) #3, !dbg !187
  call void @llvm.dbg.value(metadata i32 %32, metadata !193, metadata !DIExpression()) #3, !dbg !187
  store i32 2, i32* %2, align 4, !tbaa !170
  call void @llvm.dbg.value(metadata i64 %4, metadata !194, metadata !DIExpression()) #3, !dbg !187
  br label %35, !dbg !198

27:                                               ; preds = %21
  %28 = bitcast i8* %23 to i32*, !dbg !182
  call void @llvm.dbg.value(metadata i32* %28, metadata !152, metadata !DIExpression()), !dbg !154
  %29 = load i32, i32* %28, align 4, !dbg !199, !tbaa !170
  %30 = zext i32 %29 to i64, !dbg !199
  %31 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.0* @tx_port to i8*), i64 %30, i64 0) #3, !dbg !200
  %32 = trunc i64 %31 to i32, !dbg !200
  call void @llvm.dbg.value(metadata i32 %32, metadata !148, metadata !DIExpression()), !dbg !154
  call void @llvm.dbg.label(metadata !153), !dbg !186
  %33 = bitcast i32* %2 to i8*, !dbg !187
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %33), !dbg !187
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !192, metadata !DIExpression()) #3, !dbg !187
  call void @llvm.dbg.value(metadata i32 %32, metadata !193, metadata !DIExpression()) #3, !dbg !187
  store i32 %32, i32* %2, align 4, !tbaa !170
  call void @llvm.dbg.value(metadata i64 %4, metadata !194, metadata !DIExpression()) #3, !dbg !187
  %34 = icmp ugt i32 %32, 4, !dbg !201
  br i1 %34, label %60, label %35, !dbg !198

35:                                               ; preds = %25, %27
  %36 = phi i8* [ %26, %25 ], [ %33, %27 ]
  call void @llvm.dbg.value(metadata i32* %2, metadata !193, metadata !DIExpression(DW_OP_deref)) #3, !dbg !187
  %37 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @xdp_stats_map to i8*), i8* nonnull %36) #3, !dbg !203
  call void @llvm.dbg.value(metadata i8* %37, metadata !195, metadata !DIExpression()) #3, !dbg !187
  %38 = icmp eq i8* %37, null, !dbg !204
  br i1 %38, label %60, label %39, !dbg !206

39:                                               ; preds = %35
  call void @llvm.dbg.value(metadata i8* %37, metadata !195, metadata !DIExpression()) #3, !dbg !187
  %40 = bitcast i8* %37 to i64*, !dbg !207
  %41 = load i64, i64* %40, align 8, !dbg !208, !tbaa !209
  %42 = add i64 %41, 1, !dbg !208
  store i64 %42, i64* %40, align 8, !dbg !208, !tbaa !209
  %43 = load i32, i32* %5, align 4, !dbg !212, !tbaa !157
  %44 = load i32, i32* %9, align 4, !dbg !213, !tbaa !165
  %45 = sub i32 %43, %44, !dbg !214
  %46 = zext i32 %45 to i64, !dbg !215
  %47 = getelementptr inbounds i8, i8* %37, i64 8, !dbg !216
  %48 = bitcast i8* %47 to i64*, !dbg !216
  %49 = load i64, i64* %48, align 8, !dbg !217, !tbaa !218
  %50 = add i64 %49, %46, !dbg !217
  store i64 %50, i64* %48, align 8, !dbg !217, !tbaa !218
  call void @llvm.dbg.value(metadata i32* %2, metadata !193, metadata !DIExpression(DW_OP_deref)) #3, !dbg !187
  %51 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @telemetry_stats_map to i8*), i8* nonnull %36) #3, !dbg !219
  call void @llvm.dbg.value(metadata i8* %51, metadata !196, metadata !DIExpression()) #3, !dbg !187
  %52 = icmp eq i8* %51, null, !dbg !220
  br i1 %52, label %60, label %53, !dbg !222

53:                                               ; preds = %39
  call void @llvm.dbg.value(metadata i8* %51, metadata !196, metadata !DIExpression()) #3, !dbg !187
  %54 = call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !223
  %55 = bitcast i8* %51 to i64*, !dbg !224
  store i64 %54, i64* %55, align 8, !dbg !225, !tbaa !226
  %56 = sub i64 %54, %4, !dbg !228
  %57 = getelementptr inbounds i8, i8* %51, i64 8, !dbg !229
  %58 = bitcast i8* %57 to i64*, !dbg !229
  store i64 %56, i64* %58, align 8, !dbg !230, !tbaa !231
  %59 = load i32, i32* %2, align 4, !dbg !232, !tbaa !170
  call void @llvm.dbg.value(metadata i32 %59, metadata !193, metadata !DIExpression()) #3, !dbg !187
  br label %60, !dbg !233

60:                                               ; preds = %27, %35, %39, %53
  %61 = phi i8* [ %33, %27 ], [ %36, %35 ], [ %36, %53 ], [ %36, %39 ]
  %62 = phi i32 [ 0, %27 ], [ 0, %35 ], [ %59, %53 ], [ 0, %39 ], !dbg !187
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %61), !dbg !234
  br label %63

63:                                               ; preds = %1, %60
  %64 = phi i32 [ %62, %60 ], [ 1, %1 ], !dbg !154
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %13) #3, !dbg !235
  ret i32 %64, !dbg !235
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!116, !117, !118}
!llvm.ident = !{!119}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "redirect_params", scope: !2, file: !3, line: 50, type: !101, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !17, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_redirect_to_iface_kern.c", directory: "/home/shrestha/btp/pktsniff/xdp/packet/redirecting")
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
!17 = !{!18, !28, !36, !42, !48, !72, !85, !0}
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
!37 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !20, line: 1325, type: !38, isLocal: true, isDefinition: true)
!38 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !39)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!40 = !DISubroutineType(types: !41)
!41 = !{!16, !15, !25, !25}
!42 = !DIGlobalVariableExpression(var: !43, expr: !DIExpression())
!43 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 110, type: !44, isLocal: false, isDefinition: true)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 32, elements: !46)
!45 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!46 = !{!47}
!47 = !DISubrange(count: 4)
!48 = !DIGlobalVariableExpression(var: !49, expr: !DIExpression())
!49 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 29, type: !50, isLocal: false, isDefinition: true)
!50 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 24, size: 256, elements: !51)
!51 = !{!52, !58, !61, !67}
!52 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !50, file: !3, line: 25, baseType: !53, size: 64)
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64)
!54 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 64, elements: !56)
!55 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!56 = !{!57}
!57 = !DISubrange(count: 2)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !50, file: !3, line: 26, baseType: !59, size: 64, offset: 64)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !26, line: 27, baseType: !7)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !50, file: !3, line: 27, baseType: !62, size: 64, offset: 128)
!62 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !63, size: 64)
!63 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !3, line: 10, size: 128, elements: !64)
!64 = !{!65, !66}
!65 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !63, file: !3, line: 11, baseType: !25, size: 64)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !63, file: !3, line: 12, baseType: !25, size: 64, offset: 64)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !50, file: !3, line: 28, baseType: !68, size: 64, offset: 192)
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 160, elements: !70)
!70 = !{!71}
!71 = !DISubrange(count: 5)
!72 = !DIGlobalVariableExpression(var: !73, expr: !DIExpression())
!73 = distinct !DIGlobalVariable(name: "telemetry_stats_map", scope: !2, file: !3, line: 36, type: !74, isLocal: false, isDefinition: true)
!74 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 31, size: 256, elements: !75)
!75 = !{!76, !77, !78, !84}
!76 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !74, file: !3, line: 32, baseType: !53, size: 64)
!77 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !74, file: !3, line: 33, baseType: !59, size: 64, offset: 64)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !74, file: !3, line: 34, baseType: !79, size: 64, offset: 128)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "telrec", file: !3, line: 15, size: 128, elements: !81)
!81 = !{!82, !83}
!82 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !80, file: !3, line: 16, baseType: !25, size: 64)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time", scope: !80, file: !3, line: 17, baseType: !25, size: 64, offset: 64)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !74, file: !3, line: 35, baseType: !68, size: 64, offset: 192)
!85 = !DIGlobalVariableExpression(var: !86, expr: !DIExpression())
!86 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !3, line: 43, type: !87, isLocal: false, isDefinition: true)
!87 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 38, size: 256, elements: !88)
!88 = !{!89, !94, !95, !96}
!89 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !87, file: !3, line: 39, baseType: !90, size: 64)
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !91, size: 64)
!91 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 448, elements: !92)
!92 = !{!93}
!93 = !DISubrange(count: 14)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !87, file: !3, line: 40, baseType: !59, size: 64, offset: 64)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !87, file: !3, line: 41, baseType: !59, size: 64, offset: 128)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !87, file: !3, line: 42, baseType: !97, size: 64, offset: 192)
!97 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !98, size: 64)
!98 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 8192, elements: !99)
!99 = !{!100}
!100 = !DISubrange(count: 256)
!101 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 45, size: 256, elements: !102)
!102 = !{!103, !108, !114, !115}
!103 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !101, file: !3, line: 46, baseType: !104, size: 64)
!104 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !105, size: 64)
!105 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 32, elements: !106)
!106 = !{!107}
!107 = !DISubrange(count: 1)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !101, file: !3, line: 47, baseType: !109, size: 64, offset: 64)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !110, size: 64)
!110 = !DICompositeType(tag: DW_TAG_array_type, baseType: !111, size: 48, elements: !112)
!111 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!112 = !{!113}
!113 = !DISubrange(count: 6)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !101, file: !3, line: 48, baseType: !109, size: 64, offset: 128)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !101, file: !3, line: 49, baseType: !104, size: 64, offset: 192)
!116 = !{i32 7, !"Dwarf Version", i32 4}
!117 = !{i32 2, !"Debug Info Version", i32 3}
!118 = !{i32 1, !"wchar_size", i32 4}
!119 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!120 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !3, file: !3, line: 77, type: !121, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !131)
!121 = !DISubroutineType(types: !122)
!122 = !{!55, !123}
!123 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !124, size: 64)
!124 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !125)
!125 = !{!126, !127, !128, !129, !130}
!126 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !124, file: !6, line: 3165, baseType: !60, size: 32)
!127 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !124, file: !6, line: 3166, baseType: !60, size: 32, offset: 32)
!128 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !124, file: !6, line: 3167, baseType: !60, size: 32, offset: 64)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !124, file: !6, line: 3169, baseType: !60, size: 32, offset: 96)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !124, file: !6, line: 3170, baseType: !60, size: 32, offset: 128)
!131 = !{!132, !133, !134, !135, !136, !148, !149, !150, !152, !153}
!132 = !DILocalVariable(name: "ctx", arg: 1, scope: !120, file: !3, line: 77, type: !123)
!133 = !DILocalVariable(name: "start", scope: !120, file: !3, line: 78, type: !25)
!134 = !DILocalVariable(name: "data_end", scope: !120, file: !3, line: 80, type: !15)
!135 = !DILocalVariable(name: "data", scope: !120, file: !3, line: 81, type: !15)
!136 = !DILocalVariable(name: "eth", scope: !120, file: !3, line: 83, type: !137)
!137 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !138, size: 64)
!138 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !139, line: 163, size: 112, elements: !140)
!139 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!140 = !{!141, !142, !143}
!141 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !138, file: !139, line: 164, baseType: !110, size: 48)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !138, file: !139, line: 165, baseType: !110, size: 48, offset: 48)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !138, file: !139, line: 166, baseType: !144, size: 16, offset: 96)
!144 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !145, line: 25, baseType: !146)
!145 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!146 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !26, line: 24, baseType: !147)
!147 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!148 = !DILocalVariable(name: "action", scope: !120, file: !3, line: 84, type: !60)
!149 = !DILocalVariable(name: "key", scope: !120, file: !3, line: 85, type: !60)
!150 = !DILocalVariable(name: "dst", scope: !120, file: !3, line: 93, type: !151)
!151 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !111, size: 64)
!152 = !DILocalVariable(name: "iface_index", scope: !120, file: !3, line: 100, type: !59)
!153 = !DILabel(scope: !120, name: "out", file: !3, line: 106)
!154 = !DILocation(line: 0, scope: !120)
!155 = !DILocation(line: 78, column: 17, scope: !120)
!156 = !DILocation(line: 80, column: 39, scope: !120)
!157 = !{!158, !159, i64 4}
!158 = !{!"xdp_md", !159, i64 0, !159, i64 4, !159, i64 8, !159, i64 12, !159, i64 16}
!159 = !{!"int", !160, i64 0}
!160 = !{!"omnipotent char", !161, i64 0}
!161 = !{!"Simple C/C++ TBAA"}
!162 = !DILocation(line: 80, column: 28, scope: !120)
!163 = !DILocation(line: 80, column: 20, scope: !120)
!164 = !DILocation(line: 81, column: 35, scope: !120)
!165 = !{!158, !159, i64 0}
!166 = !DILocation(line: 81, column: 24, scope: !120)
!167 = !DILocation(line: 81, column: 16, scope: !120)
!168 = !DILocation(line: 85, column: 3, scope: !120)
!169 = !DILocation(line: 85, column: 9, scope: !120)
!170 = !{!159, !159, i64 0}
!171 = !DILocation(line: 88, column: 12, scope: !172)
!172 = distinct !DILexicalBlock(scope: !120, file: !3, line: 88, column: 7)
!173 = !DILocation(line: 88, column: 36, scope: !172)
!174 = !DILocation(line: 88, column: 7, scope: !120)
!175 = !DILocation(line: 91, column: 9, scope: !120)
!176 = !DILocation(line: 93, column: 62, scope: !120)
!177 = !DILocation(line: 93, column: 24, scope: !120)
!178 = !DILocation(line: 94, column: 8, scope: !179)
!179 = distinct !DILexicalBlock(scope: !120, file: !3, line: 94, column: 7)
!180 = !DILocation(line: 94, column: 7, scope: !120)
!181 = !DILocation(line: 98, column: 3, scope: !120)
!182 = !DILocation(line: 100, column: 24, scope: !120)
!183 = !DILocation(line: 101, column: 8, scope: !184)
!184 = distinct !DILexicalBlock(scope: !120, file: !3, line: 101, column: 7)
!185 = !DILocation(line: 101, column: 7, scope: !120)
!186 = !DILocation(line: 106, column: 1, scope: !120)
!187 = !DILocation(line: 0, scope: !188, inlinedAt: !197)
!188 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 52, type: !189, scopeLine: 54, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !191)
!189 = !DISubroutineType(types: !190)
!190 = !{!60, !123, !60, !25}
!191 = !{!192, !193, !194, !195, !196}
!192 = !DILocalVariable(name: "ctx", arg: 1, scope: !188, file: !3, line: 52, type: !123)
!193 = !DILocalVariable(name: "action", arg: 2, scope: !188, file: !3, line: 53, type: !60)
!194 = !DILocalVariable(name: "start", arg: 3, scope: !188, file: !3, line: 54, type: !25)
!195 = !DILocalVariable(name: "rec", scope: !188, file: !3, line: 58, type: !62)
!196 = !DILocalVariable(name: "telemetry", scope: !188, file: !3, line: 66, type: !79)
!197 = distinct !DILocation(line: 107, column: 10, scope: !120)
!198 = !DILocation(line: 55, column: 7, scope: !188, inlinedAt: !197)
!199 = !DILocation(line: 104, column: 39, scope: !120)
!200 = !DILocation(line: 104, column: 12, scope: !120)
!201 = !DILocation(line: 55, column: 14, scope: !202, inlinedAt: !197)
!202 = distinct !DILexicalBlock(scope: !188, file: !3, line: 55, column: 7)
!203 = !DILocation(line: 58, column: 25, scope: !188, inlinedAt: !197)
!204 = !DILocation(line: 59, column: 8, scope: !205, inlinedAt: !197)
!205 = distinct !DILexicalBlock(scope: !188, file: !3, line: 59, column: 7)
!206 = !DILocation(line: 59, column: 7, scope: !188, inlinedAt: !197)
!207 = !DILocation(line: 63, column: 8, scope: !188, inlinedAt: !197)
!208 = !DILocation(line: 63, column: 18, scope: !188, inlinedAt: !197)
!209 = !{!210, !211, i64 0}
!210 = !{!"datarec", !211, i64 0, !211, i64 8}
!211 = !{!"long long", !160, i64 0}
!212 = !DILocation(line: 64, column: 26, scope: !188, inlinedAt: !197)
!213 = !DILocation(line: 64, column: 42, scope: !188, inlinedAt: !197)
!214 = !DILocation(line: 64, column: 35, scope: !188, inlinedAt: !197)
!215 = !DILocation(line: 64, column: 20, scope: !188, inlinedAt: !197)
!216 = !DILocation(line: 64, column: 8, scope: !188, inlinedAt: !197)
!217 = !DILocation(line: 64, column: 17, scope: !188, inlinedAt: !197)
!218 = !{!210, !211, i64 8}
!219 = !DILocation(line: 66, column: 30, scope: !188, inlinedAt: !197)
!220 = !DILocation(line: 67, column: 8, scope: !221, inlinedAt: !197)
!221 = distinct !DILexicalBlock(scope: !188, file: !3, line: 67, column: 7)
!222 = !DILocation(line: 67, column: 7, scope: !188, inlinedAt: !197)
!223 = !DILocation(line: 70, column: 26, scope: !188, inlinedAt: !197)
!224 = !DILocation(line: 70, column: 14, scope: !188, inlinedAt: !197)
!225 = !DILocation(line: 70, column: 24, scope: !188, inlinedAt: !197)
!226 = !{!227, !211, i64 0}
!227 = !{!"telrec", !211, i64 0, !211, i64 8}
!228 = !DILocation(line: 71, column: 53, scope: !188, inlinedAt: !197)
!229 = !DILocation(line: 71, column: 14, scope: !188, inlinedAt: !197)
!230 = !DILocation(line: 71, column: 30, scope: !188, inlinedAt: !197)
!231 = !{!227, !211, i64 8}
!232 = !DILocation(line: 73, column: 10, scope: !188, inlinedAt: !197)
!233 = !DILocation(line: 73, column: 3, scope: !188, inlinedAt: !197)
!234 = !DILocation(line: 74, column: 1, scope: !188, inlinedAt: !197)
!235 = !DILocation(line: 108, column: 1, scope: !120)
