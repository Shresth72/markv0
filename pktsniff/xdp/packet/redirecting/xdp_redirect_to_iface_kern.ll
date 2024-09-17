; ModuleID = 'xdp_redirect_to_iface_kern.c'
source_filename = "xdp_redirect_to_iface_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [1 x i32]*, [6 x i8]*, [6 x i8]*, [1 x i32]* }
%struct.anon.0 = type { [14 x i32]*, i32*, i32*, [256 x i32]* }
%struct.anon.1 = type { [2 x i32]*, i32*, %struct.datarec*, [5 x i32]* }
%struct.datarec = type { i64, i64 }
%struct.anon.2 = type { [4 x i32]*, [0 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.event_data = type { i64, i32, i64 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@redirect_params = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@tx_port = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !72
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !42
@xdp_stats_map = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !48
@events = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !88
@llvm.used = appending global [6 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.2* @events to i8*), i8* bitcast (%struct.anon* @redirect_params to i8*), i8* bitcast (%struct.anon.0* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_redirect_map_func to i8*), i8* bitcast (%struct.anon.1* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_redirect_map_func(%struct.xdp_md* %0) #0 section "xdp_redirect_map" !dbg !125 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.event_data, align 8
  %4 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !137, metadata !DIExpression()), !dbg !159
  %5 = tail call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !160
  call void @llvm.dbg.value(metadata i64 %5, metadata !138, metadata !DIExpression()), !dbg !159
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !161
  %7 = load i32, i32* %6, align 4, !dbg !161, !tbaa !162
  %8 = zext i32 %7 to i64, !dbg !167
  %9 = inttoptr i64 %8 to i8*, !dbg !168
  call void @llvm.dbg.value(metadata i8* %9, metadata !139, metadata !DIExpression()), !dbg !159
  %10 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !169
  %11 = load i32, i32* %10, align 4, !dbg !169, !tbaa !170
  %12 = zext i32 %11 to i64, !dbg !171
  %13 = inttoptr i64 %12 to i8*, !dbg !172
  call void @llvm.dbg.value(metadata i8* %13, metadata !140, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata i32 2, metadata !153, metadata !DIExpression()), !dbg !159
  %14 = bitcast i32* %4 to i8*, !dbg !173
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %14) #4, !dbg !173
  call void @llvm.dbg.value(metadata i32 0, metadata !154, metadata !DIExpression()), !dbg !159
  store i32 0, i32* %4, align 4, !dbg !174, !tbaa !175
  %15 = getelementptr i8, i8* %13, i64 14, !dbg !176
  %16 = icmp ugt i8* %15, %9, !dbg !178
  br i1 %16, label %65, label %17, !dbg !179

17:                                               ; preds = %1
  %18 = inttoptr i64 %12 to %struct.ethhdr*, !dbg !180
  call void @llvm.dbg.value(metadata %struct.ethhdr* %18, metadata !141, metadata !DIExpression()), !dbg !159
  %19 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %18, i64 0, i32 1, i64 0, !dbg !181
  %20 = tail call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @redirect_params to i8*), i8* nonnull %19) #4, !dbg !182
  call void @llvm.dbg.value(metadata i8* %20, metadata !155, metadata !DIExpression()), !dbg !159
  %21 = icmp eq i8* %20, null, !dbg !183
  br i1 %21, label %26, label %22, !dbg !185

22:                                               ; preds = %17
  %23 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %18, i64 0, i32 0, i64 0, !dbg !186
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %23, i8* nonnull align 1 dereferenceable(6) %20, i64 6, i1 false), !dbg !186
  call void @llvm.dbg.value(metadata i32* %4, metadata !154, metadata !DIExpression(DW_OP_deref)), !dbg !159
  %24 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @tx_port to i8*), i8* nonnull %14) #4, !dbg !187
  call void @llvm.dbg.value(metadata i8* %24, metadata !157, metadata !DIExpression()), !dbg !159
  %25 = icmp eq i8* %24, null, !dbg !188
  br i1 %25, label %26, label %28, !dbg !190

26:                                               ; preds = %22, %17
  call void @llvm.dbg.value(metadata i32 %33, metadata !153, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.label(metadata !158), !dbg !191
  %27 = bitcast i32* %2 to i8*, !dbg !192
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %27), !dbg !192
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !197, metadata !DIExpression()) #4, !dbg !192
  call void @llvm.dbg.value(metadata i32 %33, metadata !198, metadata !DIExpression()) #4, !dbg !192
  store i32 2, i32* %2, align 4, !tbaa !175
  call void @llvm.dbg.value(metadata i64 %5, metadata !199, metadata !DIExpression()) #4, !dbg !192
  br label %36, !dbg !208

28:                                               ; preds = %22
  %29 = bitcast i8* %24 to i32*, !dbg !187
  call void @llvm.dbg.value(metadata i32* %29, metadata !157, metadata !DIExpression()), !dbg !159
  %30 = load i32, i32* %29, align 4, !dbg !209, !tbaa !175
  %31 = zext i32 %30 to i64, !dbg !209
  %32 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.0* @tx_port to i8*), i64 %31, i64 0) #4, !dbg !210
  %33 = trunc i64 %32 to i32, !dbg !210
  call void @llvm.dbg.value(metadata i32 %33, metadata !153, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.label(metadata !158), !dbg !191
  %34 = bitcast i32* %2 to i8*, !dbg !192
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %34), !dbg !192
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !197, metadata !DIExpression()) #4, !dbg !192
  call void @llvm.dbg.value(metadata i32 %33, metadata !198, metadata !DIExpression()) #4, !dbg !192
  store i32 %33, i32* %2, align 4, !tbaa !175
  call void @llvm.dbg.value(metadata i64 %5, metadata !199, metadata !DIExpression()) #4, !dbg !192
  %35 = icmp ugt i32 %33, 4, !dbg !211
  br i1 %35, label %62, label %36, !dbg !208

36:                                               ; preds = %26, %28
  %37 = phi i8* [ %27, %26 ], [ %34, %28 ]
  call void @llvm.dbg.value(metadata i32* %2, metadata !198, metadata !DIExpression(DW_OP_deref)) #4, !dbg !192
  %38 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @xdp_stats_map to i8*), i8* nonnull %37) #4, !dbg !213
  call void @llvm.dbg.value(metadata i8* %38, metadata !200, metadata !DIExpression()) #4, !dbg !192
  %39 = icmp eq i8* %38, null, !dbg !214
  br i1 %39, label %62, label %40, !dbg !216

40:                                               ; preds = %36
  call void @llvm.dbg.value(metadata i8* %38, metadata !200, metadata !DIExpression()) #4, !dbg !192
  %41 = bitcast i8* %38 to i64*, !dbg !217
  %42 = load i64, i64* %41, align 8, !dbg !218, !tbaa !219
  %43 = add i64 %42, 1, !dbg !218
  store i64 %43, i64* %41, align 8, !dbg !218, !tbaa !219
  %44 = load i32, i32* %6, align 4, !dbg !222, !tbaa !162
  %45 = load i32, i32* %10, align 4, !dbg !223, !tbaa !170
  %46 = sub i32 %44, %45, !dbg !224
  %47 = zext i32 %46 to i64, !dbg !225
  %48 = getelementptr inbounds i8, i8* %38, i64 8, !dbg !226
  %49 = bitcast i8* %48 to i64*, !dbg !226
  %50 = load i64, i64* %49, align 8, !dbg !227, !tbaa !228
  %51 = add i64 %50, %47, !dbg !227
  store i64 %51, i64* %49, align 8, !dbg !227, !tbaa !228
  %52 = bitcast %struct.event_data* %3 to i8*, !dbg !229
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %52) #4, !dbg !229
  call void @llvm.dbg.declare(metadata %struct.event_data* %3, metadata !201, metadata !DIExpression()) #4, !dbg !230
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(24) %52, i8 0, i64 16, i1 false) #4, !dbg !230
  %53 = call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !231
  %54 = getelementptr inbounds %struct.event_data, %struct.event_data* %3, i64 0, i32 0, !dbg !232
  store i64 %53, i64* %54, align 8, !dbg !233, !tbaa !234
  %55 = sub i64 %53, %5, !dbg !236
  %56 = getelementptr inbounds %struct.event_data, %struct.event_data* %3, i64 0, i32 2, !dbg !237
  store i64 %55, i64* %56, align 8, !dbg !238, !tbaa !239
  %57 = load i32, i32* %2, align 4, !dbg !240, !tbaa !175
  call void @llvm.dbg.value(metadata i32 %57, metadata !198, metadata !DIExpression()) #4, !dbg !192
  %58 = getelementptr inbounds %struct.event_data, %struct.event_data* %3, i64 0, i32 1, !dbg !241
  store i32 %57, i32* %58, align 8, !dbg !242, !tbaa !243
  %59 = bitcast %struct.xdp_md* %0 to i8*, !dbg !244
  %60 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* %59, i8* bitcast (%struct.anon.2* @events to i8*), i64 4294967295, i8* nonnull %52, i64 24) #4, !dbg !245
  %61 = load i32, i32* %2, align 4, !dbg !246, !tbaa !175
  call void @llvm.dbg.value(metadata i32 %61, metadata !198, metadata !DIExpression()) #4, !dbg !192
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %52) #4, !dbg !247
  br label %62

62:                                               ; preds = %28, %36, %40
  %63 = phi i8* [ %34, %28 ], [ %37, %40 ], [ %37, %36 ]
  %64 = phi i32 [ 0, %28 ], [ %61, %40 ], [ 0, %36 ], !dbg !192
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %63), !dbg !247
  br label %65

65:                                               ; preds = %1, %62
  %66 = phi i32 [ %64, %62 ], [ 1, %1 ], !dbg !159
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %14) #4, !dbg !248
  ret i32 %66, !dbg !248
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { argmemonly nounwind willreturn writeonly }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!121, !122, !123}
!llvm.ident = !{!124}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "redirect_params", scope: !2, file: !3, line: 45, type: !106, isLocal: false, isDefinition: true)
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
!17 = !{!18, !28, !36, !42, !48, !72, !0, !88, !100}
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
!43 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 113, type: !44, isLocal: false, isDefinition: true)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 32, elements: !46)
!45 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!46 = !{!47}
!47 = !DISubrange(count: 4)
!48 = !DIGlobalVariableExpression(var: !49, expr: !DIExpression())
!49 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 31, type: !50, isLocal: false, isDefinition: true)
!50 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 26, size: 256, elements: !51)
!51 = !{!52, !58, !61, !67}
!52 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !50, file: !3, line: 27, baseType: !53, size: 64)
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64)
!54 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 64, elements: !56)
!55 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!56 = !{!57}
!57 = !DISubrange(count: 2)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !50, file: !3, line: 28, baseType: !59, size: 64, offset: 64)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !26, line: 27, baseType: !7)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !50, file: !3, line: 29, baseType: !62, size: 64, offset: 128)
!62 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !63, size: 64)
!63 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !3, line: 11, size: 128, elements: !64)
!64 = !{!65, !66}
!65 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !63, file: !3, line: 12, baseType: !25, size: 64)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !63, file: !3, line: 13, baseType: !25, size: 64, offset: 64)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !50, file: !3, line: 30, baseType: !68, size: 64, offset: 192)
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 160, elements: !70)
!70 = !{!71}
!71 = !DISubrange(count: 5)
!72 = !DIGlobalVariableExpression(var: !73, expr: !DIExpression())
!73 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !3, line: 38, type: !74, isLocal: false, isDefinition: true)
!74 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 33, size: 256, elements: !75)
!75 = !{!76, !81, !82, !83}
!76 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !74, file: !3, line: 34, baseType: !77, size: 64)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 448, elements: !79)
!79 = !{!80}
!80 = !DISubrange(count: 14)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !74, file: !3, line: 35, baseType: !59, size: 64, offset: 64)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !74, file: !3, line: 36, baseType: !59, size: 64, offset: 128)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !74, file: !3, line: 37, baseType: !84, size: 64, offset: 192)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 8192, elements: !86)
!86 = !{!87}
!87 = !DISubrange(count: 256)
!88 = !DIGlobalVariableExpression(var: !89, expr: !DIExpression())
!89 = distinct !DIGlobalVariable(name: "events", scope: !2, file: !3, line: 51, type: !90, isLocal: false, isDefinition: true)
!90 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 48, size: 128, elements: !91)
!91 = !{!92, !95}
!92 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !90, file: !3, line: 49, baseType: !93, size: 64)
!93 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !94, size: 64)
!94 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 128, elements: !46)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !90, file: !3, line: 50, baseType: !96, size: 64, offset: 64)
!96 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 64)
!97 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, elements: !98)
!98 = !{!99}
!99 = !DISubrange(count: 0)
!100 = !DIGlobalVariableExpression(var: !101, expr: !DIExpression())
!101 = distinct !DIGlobalVariable(name: "bpf_perf_event_output", scope: !2, file: !20, line: 698, type: !102, isLocal: true, isDefinition: true)
!102 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !103)
!103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!104 = !DISubroutineType(types: !105)
!105 = !{!16, !15, !15, !25, !15, !25}
!106 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 40, size: 256, elements: !107)
!107 = !{!108, !113, !119, !120}
!108 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !106, file: !3, line: 41, baseType: !109, size: 64)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !110, size: 64)
!110 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 32, elements: !111)
!111 = !{!112}
!112 = !DISubrange(count: 1)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !106, file: !3, line: 42, baseType: !114, size: 64, offset: 64)
!114 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !115, size: 64)
!115 = !DICompositeType(tag: DW_TAG_array_type, baseType: !116, size: 48, elements: !117)
!116 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!117 = !{!118}
!118 = !DISubrange(count: 6)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !106, file: !3, line: 43, baseType: !114, size: 64, offset: 128)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !106, file: !3, line: 44, baseType: !109, size: 64, offset: 192)
!121 = !{i32 7, !"Dwarf Version", i32 4}
!122 = !{i32 2, !"Debug Info Version", i32 3}
!123 = !{i32 1, !"wchar_size", i32 4}
!124 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!125 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !3, file: !3, line: 80, type: !126, scopeLine: 80, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !136)
!126 = !DISubroutineType(types: !127)
!127 = !{!55, !128}
!128 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 64)
!129 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !130)
!130 = !{!131, !132, !133, !134, !135}
!131 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !129, file: !6, line: 3165, baseType: !60, size: 32)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !129, file: !6, line: 3166, baseType: !60, size: 32, offset: 32)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !129, file: !6, line: 3167, baseType: !60, size: 32, offset: 64)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !129, file: !6, line: 3169, baseType: !60, size: 32, offset: 96)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !129, file: !6, line: 3170, baseType: !60, size: 32, offset: 128)
!136 = !{!137, !138, !139, !140, !141, !153, !154, !155, !157, !158}
!137 = !DILocalVariable(name: "ctx", arg: 1, scope: !125, file: !3, line: 80, type: !128)
!138 = !DILocalVariable(name: "start", scope: !125, file: !3, line: 81, type: !25)
!139 = !DILocalVariable(name: "data_end", scope: !125, file: !3, line: 83, type: !15)
!140 = !DILocalVariable(name: "data", scope: !125, file: !3, line: 84, type: !15)
!141 = !DILocalVariable(name: "eth", scope: !125, file: !3, line: 86, type: !142)
!142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !143, size: 64)
!143 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !144, line: 163, size: 112, elements: !145)
!144 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!145 = !{!146, !147, !148}
!146 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !143, file: !144, line: 164, baseType: !115, size: 48)
!147 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !143, file: !144, line: 165, baseType: !115, size: 48, offset: 48)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !143, file: !144, line: 166, baseType: !149, size: 16, offset: 96)
!149 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !150, line: 25, baseType: !151)
!150 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!151 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !26, line: 24, baseType: !152)
!152 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!153 = !DILocalVariable(name: "action", scope: !125, file: !3, line: 87, type: !60)
!154 = !DILocalVariable(name: "key", scope: !125, file: !3, line: 88, type: !60)
!155 = !DILocalVariable(name: "dst", scope: !125, file: !3, line: 96, type: !156)
!156 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !116, size: 64)
!157 = !DILocalVariable(name: "iface_index", scope: !125, file: !3, line: 103, type: !59)
!158 = !DILabel(scope: !125, name: "out", file: !3, line: 109)
!159 = !DILocation(line: 0, scope: !125)
!160 = !DILocation(line: 81, column: 17, scope: !125)
!161 = !DILocation(line: 83, column: 39, scope: !125)
!162 = !{!163, !164, i64 4}
!163 = !{!"xdp_md", !164, i64 0, !164, i64 4, !164, i64 8, !164, i64 12, !164, i64 16}
!164 = !{!"int", !165, i64 0}
!165 = !{!"omnipotent char", !166, i64 0}
!166 = !{!"Simple C/C++ TBAA"}
!167 = !DILocation(line: 83, column: 28, scope: !125)
!168 = !DILocation(line: 83, column: 20, scope: !125)
!169 = !DILocation(line: 84, column: 35, scope: !125)
!170 = !{!163, !164, i64 0}
!171 = !DILocation(line: 84, column: 24, scope: !125)
!172 = !DILocation(line: 84, column: 16, scope: !125)
!173 = !DILocation(line: 88, column: 3, scope: !125)
!174 = !DILocation(line: 88, column: 9, scope: !125)
!175 = !{!164, !164, i64 0}
!176 = !DILocation(line: 91, column: 12, scope: !177)
!177 = distinct !DILexicalBlock(scope: !125, file: !3, line: 91, column: 7)
!178 = !DILocation(line: 91, column: 36, scope: !177)
!179 = !DILocation(line: 91, column: 7, scope: !125)
!180 = !DILocation(line: 94, column: 9, scope: !125)
!181 = !DILocation(line: 96, column: 62, scope: !125)
!182 = !DILocation(line: 96, column: 24, scope: !125)
!183 = !DILocation(line: 97, column: 8, scope: !184)
!184 = distinct !DILexicalBlock(scope: !125, file: !3, line: 97, column: 7)
!185 = !DILocation(line: 97, column: 7, scope: !125)
!186 = !DILocation(line: 101, column: 3, scope: !125)
!187 = !DILocation(line: 103, column: 24, scope: !125)
!188 = !DILocation(line: 104, column: 8, scope: !189)
!189 = distinct !DILexicalBlock(scope: !125, file: !3, line: 104, column: 7)
!190 = !DILocation(line: 104, column: 7, scope: !125)
!191 = !DILocation(line: 109, column: 1, scope: !125)
!192 = !DILocation(line: 0, scope: !193, inlinedAt: !207)
!193 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 53, type: !194, scopeLine: 55, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !196)
!194 = !DISubroutineType(types: !195)
!195 = !{!60, !128, !60, !25}
!196 = !{!197, !198, !199, !200, !201}
!197 = !DILocalVariable(name: "ctx", arg: 1, scope: !193, file: !3, line: 53, type: !128)
!198 = !DILocalVariable(name: "action", arg: 2, scope: !193, file: !3, line: 54, type: !60)
!199 = !DILocalVariable(name: "start", arg: 3, scope: !193, file: !3, line: 55, type: !25)
!200 = !DILocalVariable(name: "rec", scope: !193, file: !3, line: 59, type: !62)
!201 = !DILocalVariable(name: "event", scope: !193, file: !3, line: 68, type: !202)
!202 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "event_data", file: !3, line: 16, size: 192, elements: !203)
!203 = !{!204, !205, !206}
!204 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !202, file: !3, line: 17, baseType: !25, size: 64)
!205 = !DIDerivedType(tag: DW_TAG_member, name: "action", scope: !202, file: !3, line: 18, baseType: !60, size: 32, offset: 64)
!206 = !DIDerivedType(tag: DW_TAG_member, name: "processing_time", scope: !202, file: !3, line: 19, baseType: !25, size: 64, offset: 128)
!207 = distinct !DILocation(line: 110, column: 10, scope: !125)
!208 = !DILocation(line: 56, column: 7, scope: !193, inlinedAt: !207)
!209 = !DILocation(line: 107, column: 39, scope: !125)
!210 = !DILocation(line: 107, column: 12, scope: !125)
!211 = !DILocation(line: 56, column: 14, scope: !212, inlinedAt: !207)
!212 = distinct !DILexicalBlock(scope: !193, file: !3, line: 56, column: 7)
!213 = !DILocation(line: 59, column: 25, scope: !193, inlinedAt: !207)
!214 = !DILocation(line: 60, column: 8, scope: !215, inlinedAt: !207)
!215 = distinct !DILexicalBlock(scope: !193, file: !3, line: 60, column: 7)
!216 = !DILocation(line: 60, column: 7, scope: !193, inlinedAt: !207)
!217 = !DILocation(line: 64, column: 8, scope: !193, inlinedAt: !207)
!218 = !DILocation(line: 64, column: 18, scope: !193, inlinedAt: !207)
!219 = !{!220, !221, i64 0}
!220 = !{!"datarec", !221, i64 0, !221, i64 8}
!221 = !{!"long long", !165, i64 0}
!222 = !DILocation(line: 65, column: 26, scope: !193, inlinedAt: !207)
!223 = !DILocation(line: 65, column: 42, scope: !193, inlinedAt: !207)
!224 = !DILocation(line: 65, column: 35, scope: !193, inlinedAt: !207)
!225 = !DILocation(line: 65, column: 20, scope: !193, inlinedAt: !207)
!226 = !DILocation(line: 65, column: 8, scope: !193, inlinedAt: !207)
!227 = !DILocation(line: 65, column: 17, scope: !193, inlinedAt: !207)
!228 = !{!220, !221, i64 8}
!229 = !DILocation(line: 68, column: 3, scope: !193, inlinedAt: !207)
!230 = !DILocation(line: 68, column: 21, scope: !193, inlinedAt: !207)
!231 = !DILocation(line: 69, column: 21, scope: !193, inlinedAt: !207)
!232 = !DILocation(line: 69, column: 9, scope: !193, inlinedAt: !207)
!233 = !DILocation(line: 69, column: 19, scope: !193, inlinedAt: !207)
!234 = !{!235, !221, i64 0}
!235 = !{!"event_data", !221, i64 0, !164, i64 8, !221, i64 16}
!236 = !DILocation(line: 70, column: 43, scope: !193, inlinedAt: !207)
!237 = !DILocation(line: 70, column: 9, scope: !193, inlinedAt: !207)
!238 = !DILocation(line: 70, column: 25, scope: !193, inlinedAt: !207)
!239 = !{!235, !221, i64 16}
!240 = !DILocation(line: 71, column: 18, scope: !193, inlinedAt: !207)
!241 = !DILocation(line: 71, column: 9, scope: !193, inlinedAt: !207)
!242 = !DILocation(line: 71, column: 16, scope: !193, inlinedAt: !207)
!243 = !{!235, !164, i64 8}
!244 = !DILocation(line: 74, column: 25, scope: !193, inlinedAt: !207)
!245 = !DILocation(line: 74, column: 3, scope: !193, inlinedAt: !207)
!246 = !DILocation(line: 76, column: 10, scope: !193, inlinedAt: !207)
!247 = !DILocation(line: 77, column: 1, scope: !193, inlinedAt: !207)
!248 = !DILocation(line: 111, column: 1, scope: !125)
