; ModuleID = 'kern.c'
source_filename = "kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.0 = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.1 = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.2 = type { [2 x i32]*, i32*, i64*, [1 x i32]* }
%struct.anon.3 = type { [2 x i32]*, i32*, %struct.mmpp_source*, [4 x i32]* }
%struct.mmpp_source = type { i64, i64, i64, i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@window_start = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@packet_count = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !65
@average_count = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !78
@queue_size = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !86
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !34
@mmpp_sources = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !40
@llvm.used = appending global [7 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.1* @average_count to i8*), i8* bitcast (%struct.anon.3* @mmpp_sources to i8*), i8* bitcast (%struct.anon.0* @packet_count to i8*), i8* bitcast (%struct.anon.2* @queue_size to i8*), i8* bitcast (%struct.anon* @window_start to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_traffic_shaper to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_traffic_shaper(%struct.xdp_md* nocapture readnone %0) #0 section "xdp" !dbg !104 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !116, metadata !DIExpression()), !dbg !127
  %3 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !128
  call void @llvm.dbg.value(metadata i64 %3, metadata !117, metadata !DIExpression()), !dbg !127
  %4 = bitcast i32* %2 to i8*, !dbg !129
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4) #3, !dbg !129
  call void @llvm.dbg.value(metadata i32 0, metadata !118, metadata !DIExpression()), !dbg !127
  store i32 0, i32* %2, align 4, !dbg !130, !tbaa !131
  call void @llvm.dbg.value(metadata i32* %2, metadata !118, metadata !DIExpression(DW_OP_deref)), !dbg !127
  %5 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @window_start to i8*), i8* nonnull %4) #3, !dbg !135
  %6 = bitcast i8* %5 to i64*, !dbg !135
  call void @llvm.dbg.value(metadata i64* %6, metadata !119, metadata !DIExpression()), !dbg !127
  %7 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @packet_count to i8*), i8* nonnull %4) #3, !dbg !136
  %8 = bitcast i8* %7 to i64*, !dbg !136
  call void @llvm.dbg.value(metadata i64* %8, metadata !120, metadata !DIExpression()), !dbg !127
  %9 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.1* @average_count to i8*), i8* nonnull %4) #3, !dbg !137
  %10 = bitcast i8* %9 to i64*, !dbg !137
  call void @llvm.dbg.value(metadata i64* %10, metadata !121, metadata !DIExpression()), !dbg !127
  %11 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @queue_size to i8*), i8* nonnull %4) #3, !dbg !138
  %12 = bitcast i8* %11 to i64*, !dbg !138
  call void @llvm.dbg.value(metadata i64* %12, metadata !122, metadata !DIExpression()), !dbg !127
  %13 = icmp ne i8* %5, null, !dbg !139
  %14 = icmp ne i8* %7, null
  %15 = and i1 %13, %14, !dbg !141
  %16 = icmp ne i8* %9, null
  %17 = and i1 %15, %16, !dbg !141
  %18 = icmp ne i8* %11, null
  %19 = and i1 %17, %18, !dbg !141
  br i1 %19, label %20, label %51, !dbg !141

20:                                               ; preds = %1
  %21 = load i64, i64* %6, align 8, !dbg !142, !tbaa !143
  %22 = sub i64 %3, %21, !dbg !145
  %23 = icmp ugt i64 %22, 999999999, !dbg !146
  br i1 %23, label %27, label %24, !dbg !147

24:                                               ; preds = %20
  %25 = load i64, i64* %8, align 8, !dbg !148, !tbaa !143
  %26 = add i64 %25, 1, !dbg !147
  br label %34, !dbg !147

27:                                               ; preds = %20
  %28 = load i64, i64* %10, align 8, !dbg !149, !tbaa !143
  %29 = mul i64 %28, 900, !dbg !150
  %30 = load i64, i64* %8, align 8, !dbg !151, !tbaa !143
  %31 = mul i64 %30, 100, !dbg !152
  %32 = add i64 %31, %29, !dbg !153
  %33 = udiv i64 %32, 1000000, !dbg !154
  call void @llvm.dbg.value(metadata i64 %33, metadata !123, metadata !DIExpression()), !dbg !155
  store i64 %33, i64* %10, align 8, !dbg !156, !tbaa !143
  store i64 %3, i64* %6, align 8, !dbg !157, !tbaa !143
  store i64 0, i64* %8, align 8, !dbg !158, !tbaa !143
  br label %34, !dbg !159

34:                                               ; preds = %24, %27
  %35 = phi i64 [ %26, %24 ], [ 1, %27 ]
  store i64 %35, i64* %8, align 8, !dbg !148, !tbaa !143
  %36 = mul i64 %35, 1000000, !dbg !160
  %37 = load i64, i64* %6, align 8, !dbg !161, !tbaa !143
  %38 = sub i64 %3, %37, !dbg !162
  %39 = udiv i64 %36, %38, !dbg !163
  call void @llvm.dbg.value(metadata i64 %39, metadata !126, metadata !DIExpression()), !dbg !127
  %40 = load i64, i64* %10, align 8, !dbg !164, !tbaa !143
  %41 = icmp ugt i64 %39, %40, !dbg !166
  %42 = load i64, i64* %12, align 8, !dbg !167, !tbaa !143
  br i1 %41, label %43, label %47, !dbg !168

43:                                               ; preds = %34
  %44 = icmp ugt i64 %42, 4999, !dbg !169
  br i1 %44, label %51, label %45, !dbg !172

45:                                               ; preds = %43
  %46 = add nuw nsw i64 %42, 1, !dbg !173
  store i64 %46, i64* %12, align 8, !dbg !173, !tbaa !143
  br label %51, !dbg !175

47:                                               ; preds = %34
  %48 = icmp eq i64 %42, 0, !dbg !176
  br i1 %48, label %51, label %49, !dbg !178

49:                                               ; preds = %47
  %50 = add i64 %42, -1, !dbg !179
  store i64 %50, i64* %12, align 8, !dbg !179, !tbaa !143
  br label %51, !dbg !181

51:                                               ; preds = %43, %47, %49, %45, %1
  %52 = phi i32 [ 0, %1 ], [ 1, %43 ], [ 2, %47 ], [ 2, %49 ], [ 2, %45 ], !dbg !127
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4) #3, !dbg !182
  ret i32 %52, !dbg !182
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!100, !101, !102}
!llvm.ident = !{!103}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "window_start", scope: !2, file: !3, line: 35, type: !94, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "kern.c", directory: "/home/shrestha/btp/pktsniff/xdp/packet/redirecting/self_similar/c")
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
!14 = !{!15, !25, !34, !40, !0, !65, !78, !86}
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !17, line: 114, type: !18, isLocal: true, isDefinition: true)
!17 = !DIFile(filename: "/usr/local/include/bpf/bpf_helper_defs.h", directory: "")
!18 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !19)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DISubroutineType(types: !21)
!21 = !{!22}
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !23, line: 31, baseType: !24)
!23 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!24 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!25 = !DIGlobalVariableExpression(var: !26, expr: !DIExpression())
!26 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !17, line: 56, type: !27, isLocal: true, isDefinition: true)
!27 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !28)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = !DISubroutineType(types: !30)
!30 = !{!31, !31, !32}
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!34 = !DIGlobalVariableExpression(var: !35, expr: !DIExpression())
!35 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 104, type: !36, isLocal: false, isDefinition: true)
!36 = !DICompositeType(tag: DW_TAG_array_type, baseType: !37, size: 32, elements: !38)
!37 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!38 = !{!39}
!39 = !DISubrange(count: 4)
!40 = !DIGlobalVariableExpression(var: !41, expr: !DIExpression())
!41 = distinct !DIGlobalVariable(name: "mmpp_sources", scope: !2, file: !3, line: 28, type: !42, isLocal: false, isDefinition: true)
!42 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 23, size: 256, elements: !43)
!43 = !{!44, !50, !53, !62}
!44 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !42, file: !3, line: 24, baseType: !45, size: 64)
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !46, size: 64)
!46 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 64, elements: !48)
!47 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!48 = !{!49}
!49 = !DISubrange(count: 2)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !42, file: !3, line: 25, baseType: !51, size: 64, offset: 64)
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!52 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !23, line: 27, baseType: !7)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !42, file: !3, line: 26, baseType: !54, size: 64, offset: 128)
!54 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!55 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "mmpp_source", file: !3, line: 15, size: 320, elements: !56)
!56 = !{!57, !58, !59, !60, !61}
!57 = !DIDerivedType(tag: DW_TAG_member, name: "lambda1", scope: !55, file: !3, line: 16, baseType: !22, size: 64)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "lambda2", scope: !55, file: !3, line: 17, baseType: !22, size: 64, offset: 64)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "c1", scope: !55, file: !3, line: 18, baseType: !22, size: 64, offset: 128)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "c2", scope: !55, file: !3, line: 19, baseType: !22, size: 64, offset: 192)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "current_state", scope: !55, file: !3, line: 20, baseType: !22, size: 64, offset: 256)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !42, file: !3, line: 27, baseType: !63, size: 64, offset: 192)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 128, elements: !38)
!65 = !DIGlobalVariableExpression(var: !66, expr: !DIExpression())
!66 = distinct !DIGlobalVariable(name: "packet_count", scope: !2, file: !3, line: 42, type: !67, isLocal: false, isDefinition: true)
!67 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 37, size: 256, elements: !68)
!68 = !{!69, !70, !71, !73}
!69 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !67, file: !3, line: 38, baseType: !45, size: 64)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !67, file: !3, line: 39, baseType: !51, size: 64, offset: 64)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !67, file: !3, line: 40, baseType: !72, size: 64, offset: 128)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !67, file: !3, line: 41, baseType: !74, size: 64, offset: 192)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 32, elements: !76)
!76 = !{!77}
!77 = !DISubrange(count: 1)
!78 = !DIGlobalVariableExpression(var: !79, expr: !DIExpression())
!79 = distinct !DIGlobalVariable(name: "average_count", scope: !2, file: !3, line: 49, type: !80, isLocal: false, isDefinition: true)
!80 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 44, size: 256, elements: !81)
!81 = !{!82, !83, !84, !85}
!82 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !80, file: !3, line: 45, baseType: !45, size: 64)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !80, file: !3, line: 46, baseType: !51, size: 64, offset: 64)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !80, file: !3, line: 47, baseType: !72, size: 64, offset: 128)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !80, file: !3, line: 48, baseType: !74, size: 64, offset: 192)
!86 = !DIGlobalVariableExpression(var: !87, expr: !DIExpression())
!87 = distinct !DIGlobalVariable(name: "queue_size", scope: !2, file: !3, line: 56, type: !88, isLocal: false, isDefinition: true)
!88 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 51, size: 256, elements: !89)
!89 = !{!90, !91, !92, !93}
!90 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !88, file: !3, line: 52, baseType: !45, size: 64)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !88, file: !3, line: 53, baseType: !51, size: 64, offset: 64)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !88, file: !3, line: 54, baseType: !72, size: 64, offset: 128)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !88, file: !3, line: 55, baseType: !74, size: 64, offset: 192)
!94 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 30, size: 256, elements: !95)
!95 = !{!96, !97, !98, !99}
!96 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !94, file: !3, line: 31, baseType: !45, size: 64)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !94, file: !3, line: 32, baseType: !51, size: 64, offset: 64)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !94, file: !3, line: 33, baseType: !72, size: 64, offset: 128)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !94, file: !3, line: 34, baseType: !74, size: 64, offset: 192)
!100 = !{i32 7, !"Dwarf Version", i32 4}
!101 = !{i32 2, !"Debug Info Version", i32 3}
!102 = !{i32 1, !"wchar_size", i32 4}
!103 = !{!"Ubuntu clang version 11.1.0-++20211011094159+1fdec59bffc1-1~exp1~20211011214622.5"}
!104 = distinct !DISubprogram(name: "xdp_traffic_shaper", scope: !3, file: !3, line: 59, type: !105, scopeLine: 59, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !115)
!105 = !DISubroutineType(types: !106)
!106 = !{!47, !107}
!107 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !108, size: 64)
!108 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !109)
!109 = !{!110, !111, !112, !113, !114}
!110 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !108, file: !6, line: 3165, baseType: !52, size: 32)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !108, file: !6, line: 3166, baseType: !52, size: 32, offset: 32)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !108, file: !6, line: 3167, baseType: !52, size: 32, offset: 64)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !108, file: !6, line: 3169, baseType: !52, size: 32, offset: 96)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !108, file: !6, line: 3170, baseType: !52, size: 32, offset: 128)
!115 = !{!116, !117, !118, !119, !120, !121, !122, !123, !126}
!116 = !DILocalVariable(name: "ctx", arg: 1, scope: !104, file: !3, line: 59, type: !107)
!117 = !DILocalVariable(name: "now", scope: !104, file: !3, line: 60, type: !22)
!118 = !DILocalVariable(name: "key", scope: !104, file: !3, line: 61, type: !52)
!119 = !DILocalVariable(name: "window_start_ptr", scope: !104, file: !3, line: 62, type: !72)
!120 = !DILocalVariable(name: "packet_count_ptr", scope: !104, file: !3, line: 63, type: !72)
!121 = !DILocalVariable(name: "average_count_ptr", scope: !104, file: !3, line: 64, type: !72)
!122 = !DILocalVariable(name: "queue_size_ptr", scope: !104, file: !3, line: 65, type: !72)
!123 = !DILocalVariable(name: "new_average", scope: !124, file: !3, line: 74, type: !22)
!124 = distinct !DILexicalBlock(scope: !125, file: !3, line: 72, column: 47)
!125 = distinct !DILexicalBlock(scope: !104, file: !3, line: 72, column: 7)
!126 = !DILocalVariable(name: "current_rate", scope: !104, file: !3, line: 87, type: !22)
!127 = !DILocation(line: 0, scope: !104)
!128 = !DILocation(line: 60, column: 15, scope: !104)
!129 = !DILocation(line: 61, column: 3, scope: !104)
!130 = !DILocation(line: 61, column: 9, scope: !104)
!131 = !{!132, !132, i64 0}
!132 = !{!"int", !133, i64 0}
!133 = !{!"omnipotent char", !134, i64 0}
!134 = !{!"Simple C/C++ TBAA"}
!135 = !DILocation(line: 62, column: 29, scope: !104)
!136 = !DILocation(line: 63, column: 29, scope: !104)
!137 = !DILocation(line: 64, column: 30, scope: !104)
!138 = !DILocation(line: 65, column: 27, scope: !104)
!139 = !DILocation(line: 67, column: 8, scope: !140)
!140 = distinct !DILexicalBlock(scope: !104, file: !3, line: 67, column: 7)
!141 = !DILocation(line: 67, column: 25, scope: !140)
!142 = !DILocation(line: 72, column: 13, scope: !125)
!143 = !{!144, !144, i64 0}
!144 = !{!"long long", !133, i64 0}
!145 = !DILocation(line: 72, column: 11, scope: !125)
!146 = !DILocation(line: 72, column: 31, scope: !125)
!147 = !DILocation(line: 72, column: 7, scope: !104)
!148 = !DILocation(line: 84, column: 22, scope: !104)
!149 = !DILocation(line: 75, column: 11, scope: !124)
!150 = !DILocation(line: 75, column: 30, scope: !124)
!151 = !DILocation(line: 75, column: 40, scope: !124)
!152 = !DILocation(line: 75, column: 58, scope: !124)
!153 = !DILocation(line: 75, column: 37, scope: !124)
!154 = !DILocation(line: 75, column: 66, scope: !124)
!155 = !DILocation(line: 0, scope: !124)
!156 = !DILocation(line: 76, column: 24, scope: !124)
!157 = !DILocation(line: 79, column: 23, scope: !124)
!158 = !DILocation(line: 80, column: 23, scope: !124)
!159 = !DILocation(line: 81, column: 3, scope: !124)
!160 = !DILocation(line: 88, column: 26, scope: !104)
!161 = !DILocation(line: 88, column: 51, scope: !104)
!162 = !DILocation(line: 88, column: 49, scope: !104)
!163 = !DILocation(line: 88, column: 42, scope: !104)
!164 = !DILocation(line: 91, column: 22, scope: !165)
!165 = distinct !DILexicalBlock(scope: !104, file: !3, line: 91, column: 7)
!166 = !DILocation(line: 91, column: 20, scope: !165)
!167 = !DILocation(line: 0, scope: !165)
!168 = !DILocation(line: 91, column: 7, scope: !104)
!169 = !DILocation(line: 92, column: 25, scope: !170)
!170 = distinct !DILexicalBlock(scope: !171, file: !3, line: 92, column: 9)
!171 = distinct !DILexicalBlock(scope: !165, file: !3, line: 91, column: 42)
!172 = !DILocation(line: 92, column: 9, scope: !171)
!173 = !DILocation(line: 95, column: 24, scope: !174)
!174 = distinct !DILexicalBlock(scope: !170, file: !3, line: 94, column: 12)
!175 = !DILocation(line: 97, column: 3, scope: !171)
!176 = !DILocation(line: 97, column: 30, scope: !177)
!177 = distinct !DILexicalBlock(scope: !165, file: !3, line: 97, column: 14)
!178 = !DILocation(line: 97, column: 14, scope: !165)
!179 = !DILocation(line: 98, column: 22, scope: !180)
!180 = distinct !DILexicalBlock(scope: !177, file: !3, line: 97, column: 35)
!181 = !DILocation(line: 99, column: 3, scope: !180)
!182 = !DILocation(line: 102, column: 1, scope: !104)
