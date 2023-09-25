Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F229A7ACFD8
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Sep 2023 08:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjIYGIY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Sep 2023 02:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIYGIX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Sep 2023 02:08:23 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36CB83
        for <linux-ext4@vger.kernel.org>; Sun, 24 Sep 2023 23:08:15 -0700 (PDT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43]) by mx-outbound10-136.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 25 Sep 2023 06:08:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOJhKAJ79tjKZp2YwkrviSNTB0RXfJbdyRc3mEfwlSYkUooufHdLfBULU9xxJ6k1mYK4Ccv2ZjyfD6bL5L38xRYbhpWBtMOmwDNK6hTo747iKoteHBcFy74b5jNbw3Gc93p4mvRo0srGgFz6SUcN3D95FNSeLZQFQlBZch6pxCajKVC/k3LtnfOkWqwH2Fj77LN+1/1l/F0isW8ObTDoMzlYHh2KvQMRAqUowaWCMvS33GWUDp7F4YrOGjQHfavihFsN8FJtEJa8KeGOLuYk04v4rQ41whbmsRXuqdMovUook8kyJvhlzXs68srTh7Nnx8ttI56Vuo8wklSPQfbPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK2jhjolLfI3hexfCk1cw7Eh0QdBGi4XJ9ulIQl1M40=;
 b=D7ER4bn2nIz7T1/ZjTixlCRJ1tq/5pXTzM/DbVaS3OqPrn3VHAyamRhOQQ324IYiqpBSTSmaSVl4OIcJXyxKd+pXcIsxFfyr+jBIoCUE6DF04qCVpXMxIX0+ASN93UKMHjoBt8WSpZ8B48xOg3GOHRImApE+8V26k76etFfnYr6H1e4+QXIDTXNrel+gEtSMaseY6vPnBGYRwEHjhVvu6gNTVN526w8t3X6FiBBO1qRl6KXu7x4awtBhcueqEj4WcJibUJ2Dohq8z+y8mFkVNELBYXf+Z/UvtG8H4QkeC9EdJnVzsW0OqIA/4W4PqWgTQk14ZrmpXRg37TQ5AqYLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK2jhjolLfI3hexfCk1cw7Eh0QdBGi4XJ9ulIQl1M40=;
 b=aJFEhsDZrfnBJdQHdeZ95lmQpr6hNtAaGxLhQZ6vLWNO1qdFsnC9kfW7cyzlxTFgd1HEZpLceU4veQX5n7nbgHWZF89hGSLFS8KdzIH9JmJ0ULHzgB2/Hki1KUnp2AN4ECrRhwICgQKl40DRj7C+/5LIUzxm8s004rHKrM31uD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 PH8PR19MB7048.namprd19.prod.outlook.com (2603:10b6:510:224::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Mon, 25 Sep 2023 06:08:09 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::e470:7b70:6ca2:4038]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::e470:7b70:6ca2:4038%2]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 06:08:08 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca
Subject: [PATCH 1/2] mke2fs: set free blocks accurately for groups has GDT
Date:   Mon, 25 Sep 2023 16:08:00 +1000
Message-ID: <20230925060801.1397581-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0162.ausprd01.prod.outlook.com
 (2603:10c6:10:d::30) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|PH8PR19MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: f665caf8-9a82-437e-756f-08dbbd8dc9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deG0RmJ+6rbfK+zudNpuvxr0Iicw/N68STq9JtjmEN7YltheZ6NvqMvDs8d35tjKmYnlTgE12+nsGd7AbJqgczy5fZle7SHquwAL9iiB3bOJQRhn/nPyzPrMwOCEVsDRvvEblNZwKoh+PdRdtFteuESdb64JFTUtat7spXr87rq9MbjtKRl+fzqUjlyGgkBvtonx45Ua0TO5axHlAeFJAiN1fdAQONAbftFBnODF8DzeQiUhpYYigItMk15/PFtnW8tnRLyyXtSoPtBLifRm926lwYSDMH7nyUOPd/RQkFYoJbvqn/v8E54h8vAOXJQVScGMDEATD47C1IZx/wCshGUJYKwZrhnCDLqOBEpHkUM+B/NnPSyFNChS8GXMQyGDfK1gFFyjlVu1i2qBX/BeQo6DAEfd7aDwtYK8sOg/eHPW1qU0iZWyl7TCBtIOHrHTvWFPa7KMfj0DEj63g4OQXWifwx2JIiIav7tzEywfD2rzKGgrxOBDHfOQN2rPfyBbZuszPUXhdchaezWfbDfU6I0KiqDprqIgAxENjDibSUmdIOJEaDroNRn95uW94kho
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39840400004)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(6486002)(83380400001)(26005)(36756003)(5660300002)(478600001)(8676002)(8936002)(4326008)(2906002)(6666004)(38100700002)(6916009)(316002)(66476007)(66556008)(66946007)(41300700001)(1076003)(2616005)(6506007)(6512007)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vggAHyBBpTKjOhKJqW8yp+9QYpNHRlPjNq03gBMluGTwBvhGigkupmauHSi?=
 =?us-ascii?Q?hk4PxB476xN4D0MHpgaLaAEF8mgnpV5ST2/XNQqaW91HzLKidG/cJTykyfef?=
 =?us-ascii?Q?W9mIFafMZBt3jmhyig5Dk1S4uiF98epwHt8RvK4y8cl9G5DAK9BgCJnnuoYN?=
 =?us-ascii?Q?cVWEK2x6qbMYF9BM3POqASbgUUkoU926Fwc12+10Icj2v/GvjhTWgg957mpC?=
 =?us-ascii?Q?wGH4oyGIy6Gt3+ep138fuQFdwwrvEjU34dH+AfUZWglx7q3dH8DUf0FEPxJq?=
 =?us-ascii?Q?GNuVVRafPspdQBtVwZt0dJ0iXbE7c5ZjPpk02ZQNpXZAU8M7BTvvRJdkHUvt?=
 =?us-ascii?Q?huAJcuPdsE5vBpep0N3tn2cvuTzm3YFkLjaoN5nXR6iaGrI+vn24wwvFI/5r?=
 =?us-ascii?Q?BRu/Fgvj1KraFq5AlD7jkZcXbAb2QyhaNqyq/Xr/aknBLnaAboERVYLyI901?=
 =?us-ascii?Q?yOSy2WDv0U4mI6l76WdDo2fod1rkazDxEzCpYDddcpneZ3S8FXwsQGaugzJx?=
 =?us-ascii?Q?ef1afonbqxtPh0MoLS9uk4WjNusYc/Vx0SCl4vIsWTDLg0K4XOj3Lg46beNJ?=
 =?us-ascii?Q?b+0m845tBGUoBr0NpnrZU71UEueDIb2GQ9ZY3XuhJfA6YmvUCFNZ5NZx4dIm?=
 =?us-ascii?Q?RbCVlu6vgJzh3SymdbQIOXrgY6Z2XF+I4iQFfTbr1fQ4R6reClrbuYqtuXJi?=
 =?us-ascii?Q?S5CWwV3+W4IKpQIYoz395+8tmp6ZcNTU8rJHMpAvQr440BeMI31gJs65AtZP?=
 =?us-ascii?Q?4x1G4QVbjICJ00QOcFQOD6knHGzATxJrQjrjaw1iaGJtiXe55unlhVycKZZw?=
 =?us-ascii?Q?ZwbW2wpFJ+7zF1uxFCjWuwrLrIiqXUJwzxERb+mkoxlEzXgqDEfKKca6TWBO?=
 =?us-ascii?Q?zcLd1g0crA0WqC5qJBHHskuXdXFXcelt0ju4YGMjTu//kPnqZhYGKL1puQ4A?=
 =?us-ascii?Q?Ggszd3MWAKO1SZ9suYovFaLdLqJM2vuO0x5E8bpgEpVZml6exveesHJ4CzmC?=
 =?us-ascii?Q?0qTT62lqy5t9cskpgpeVHTk206CeMpcxyMQ5gqmpgLQSslwZbHHTLY3aPKcR?=
 =?us-ascii?Q?+SroeH0ahzHKXURXJCGhpzwnaNNNVEC/TGDTXsIFdS2T4q/B8x3xo3bGwTVC?=
 =?us-ascii?Q?FR/On+eVGE9XDXMMloffS6oUTqNXMLHtBGZYuDvUilHdnIaVSSFkWPSwRBo5?=
 =?us-ascii?Q?CK2ZYAIMcxaT0qwEkJ16JdIeFNhpqUpHKJfYwR8PVSMTZDfcgzLCVq9jpwvT?=
 =?us-ascii?Q?uuSAddpXw2sLeALTO7hPI8mxzynAdR9UbF6cD1CU7lUaR3ExrHX0Wy0FEmej?=
 =?us-ascii?Q?bNoK2O6+WxauP32ch50kdVGoX+D0G/q33sNWXKa9e/nIGeHshc3Q8zbxwH1d?=
 =?us-ascii?Q?mlHcFQ5VQb8G5K6Tn3tWhsGn6dYjJ/V326thbX8Ol91UzS+n34NFgPaqaZ7S?=
 =?us-ascii?Q?ZWUjhbxynkg8S1HJDmFDlsAlLBcMx31x0eWgMhlRnhoQDqEj/qq/8fCASShQ?=
 =?us-ascii?Q?qY6HX0Lrnlf1EeFeZcwgmvY4ACfP/xcZHUorY9oAlQWwEQi1RVl6ZLjU459/?=
 =?us-ascii?Q?Shms/9enorvKp3vpLH0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tLudLySHbJy7eKh37/bXuWWXX89WZFyQteXx3Ir+EJkzvJgUz+XwlefUEQRAIOknVGgsBMZb7z4Wg/M/Du/sxW3eGesIQrBB6AvEraLv3Xe/ZGVvVuxX96DgT79OMemfEP2wpYwEDDjgJsxIQzP8avxFi7nV2ZpybTn7uzEcnTPZRZrCsnEqh2IuuPRO1CFOz266jAn743s/ykWykgsLG3CSgXRye4USuCEeM3ihSHMS/mvxJF0OdMn908jLqgSozTU1habKFCBmb1d/+HLGQG6aQG85PzjQVX9sjkv2C7bZW2BhGH5jw1IHEXmPxcVvuogPo7BamRFqfmOYFPbxXC3dQd+qWNf9bWUCIJvIFjRzjXKHfF2c7eis3gDGcjPm8cDhi3QtACLXaOKLcHsS8KQKQKV+cVlmZDHI8w/EGZrWZBfVn0dQohbTWVS4zTlnasrxFmgXKWx4d8bIpdy6g0/10+SrpC2f+B/lZK/gTG4C2AN8GqkvAZSl7olQ8yp6FgxA8BjwVVnduKmCpvjRLDD0H3QiVAsiT0lrugWpyrB4VH2Oesn4Z3ZbVU55uiEOggTeogujqPPuSiZ4yDwxRURAkmRYbnntdJOz7niPZv6EPLh3vO/DsGqnAAoqpIiCNSO44euqx6BazFrwECplN3wiTtYDX6VK7wM/DTZ1hGop8TjSuGHofAibt1mUqPbHtTi1lA2L8lcfnkd8cePlAYzzb4qjZ8JBNwTTJ1b4WKd0LFR7vTcYDZVhrbL4E7ZIPpg5ZN7P1rd+qF2SuZpwyu9qI+wDmEbs+f1S09JcaWZFCbu4Zq8ljVtNEOaKWPoZg8nPGpxrO3GKTIMn9wo9AA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f665caf8-9a82-437e-756f-08dbbd8dc9fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 06:08:08.4002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGqvqfG/vA10z0tV/LtqH2fsnLUv57XTgVLOmyWaYo9O1YyknGQn/nv0gGRxMK84
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7048
X-BESS-ID: 1695622093-102696-26662-4047-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.66.43
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmbGRuZAVgZQ0MDQwMIgzdws2S
        AtJTUpKS3ZwNLM2DAxydLA1NzcwDhVqTYWAN+D9yJBAAAA
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251066 [from 
        cloudscan9-88.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      META: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch is part of the preparation required to allow
GDT blocks expand beyond a single group,
it introduces 2 new interfaces:
- ext2fs_count_used_blocks(), to return the blocks used
in the bitmap range.
- ext2fs_reserve_super_and_bgd2() to return blocks used by
superblock/GDT blocks for every group, by looking up blocks used.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 lib/ext2fs/alloc_sb.c     | 28 ++++++++++++++++++++++++++--
 lib/ext2fs/ext2fs.h       |  6 ++++++
 lib/ext2fs/gen_bitmap64.c | 17 +++++++++++++++--
 lib/ext2fs/initialize.c   | 30 ++++++++++++++++++++----------
 misc/mke2fs.c             |  2 +-
 5 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/lib/ext2fs/alloc_sb.c b/lib/ext2fs/alloc_sb.c
index 8530b40f6..e92739ecc 100644
--- a/lib/ext2fs/alloc_sb.c
+++ b/lib/ext2fs/alloc_sb.c
@@ -46,8 +46,7 @@ int ext2fs_reserve_super_and_bgd(ext2_filsys fs,
 				 ext2fs_block_bitmap bmap)
 {
 	blk64_t	super_blk, old_desc_blk, new_desc_blk;
-	blk_t	used_blks;
-	int	old_desc_blocks, num_blocks;
+	blk_t	used_blks, old_desc_blocks, num_blocks;
 
 	ext2fs_super_and_bgd_loc2(fs, group, &super_blk,
 				  &old_desc_blk, &new_desc_blk, &used_blks);
@@ -79,3 +78,28 @@ int ext2fs_reserve_super_and_bgd(ext2_filsys fs,
 
 	return num_blocks  ;
 }
+
+/*
+ * This function reserves the superblock and block group descriptors
+ * for a given block group and returns the number of blocks used by the
+ * super block and group descriptors by looking up the block bitmap.
+ */
+errcode_t ext2fs_reserve_super_and_bgd2(ext2_filsys fs,
+				        dgrp_t group,
+				        ext2fs_block_bitmap bmap,
+				        blk_t *desc_blocks)
+{
+	blk64_t	num_blocks;
+	errcode_t retval = 0;
+
+	ext2fs_reserve_super_and_bgd(fs, group, bmap);
+
+	retval = ext2fs_count_used_blocks(fs,
+					ext2fs_group_first_block2(fs, group),
+					ext2fs_group_last_block2(fs, group),
+					&num_blocks);
+	if (!retval)
+		*desc_blocks = num_blocks;
+
+	return retval;
+}
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 72c60d2b5..ae79a3443 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -795,6 +795,10 @@ errcode_t ext2fs_alloc_range(ext2_filsys fs, int flags, blk64_t goal,
 extern int ext2fs_reserve_super_and_bgd(ext2_filsys fs,
 					dgrp_t group,
 					ext2fs_block_bitmap bmap);
+extern errcode_t ext2fs_reserve_super_and_bgd2(ext2_filsys fs,
+					       dgrp_t group,
+					       ext2fs_block_bitmap bmap,
+					       blk_t *desc_blocks);
 extern void ext2fs_set_block_alloc_stats_callback(ext2_filsys fs,
 						  void (*func)(ext2_filsys fs,
 							       blk64_t blk,
@@ -1483,6 +1487,8 @@ errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
 					   ext2fs_block_bitmap *bitmap);
 errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
 				     blk64_t end, blk64_t *out);
+errcode_t ext2fs_count_used_blocks(ext2_filsys fs, blk64_t start,
+				   blk64_t end, blk64_t *out);
 
 /* get_num_dirs.c */
 extern errcode_t ext2fs_get_num_dirs(ext2_filsys fs, ext2_ino_t *ret_num_dirs);
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index 4289e8155..5936dcf53 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -945,8 +945,8 @@ errcode_t ext2fs_find_first_set_generic_bmap(ext2fs_generic_bitmap bitmap,
 	return ENOENT;
 }
 
-errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
-				     blk64_t end, blk64_t *out)
+errcode_t ext2fs_count_used_blocks(ext2_filsys fs, blk64_t start,
+				   blk64_t end, blk64_t *out)
 {
 	blk64_t		next;
 	blk64_t		tot_set = 0;
@@ -975,6 +975,19 @@ errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
 			break;
 	}
 
+	if (!retval)
+		*out = tot_set;
+	return retval;
+}
+
+errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
+				     blk64_t end, blk64_t *out)
+{
+	blk64_t		tot_set = 0;
+	errcode_t	retval = 0;
+
+	retval = ext2fs_count_used_blocks(fs, start, end, &tot_set);
+
 	if (!retval)
 		*out = EXT2FS_NUM_B2C(fs, tot_set);
 	return retval;
diff --git a/lib/ext2fs/initialize.c b/lib/ext2fs/initialize.c
index edd692bb9..90012f732 100644
--- a/lib/ext2fs/initialize.c
+++ b/lib/ext2fs/initialize.c
@@ -521,6 +521,15 @@ ipg_retry:
 	csum_flag = ext2fs_has_group_desc_csum(fs);
 	reserved_inos = super->s_first_ino;
 	for (i = 0; i < fs->group_desc_count; i++) {
+		blk_t grp_free_blocks;
+		ext2_ino_t inodes;
+
+		retval = ext2fs_reserve_super_and_bgd2(fs, i,
+						       fs->block_map,
+						       &numblocks);
+		if (retval)
+			goto cleanup;
+
 		/*
 		 * Don't set the BLOCK_UNINIT group for the last group
 		 * because the block bitmap needs to be padded.
@@ -530,24 +539,25 @@ ipg_retry:
 				ext2fs_bg_flags_set(fs, i,
 						    EXT2_BG_BLOCK_UNINIT);
 			ext2fs_bg_flags_set(fs, i, EXT2_BG_INODE_UNINIT);
-			numblocks = super->s_inodes_per_group;
+			inodes = super->s_inodes_per_group;
 			if (reserved_inos) {
-				if (numblocks > reserved_inos) {
-					numblocks -= reserved_inos;
+				if (inodes > reserved_inos) {
+					inodes -= reserved_inos;
 					reserved_inos = 0;
 				} else {
-					reserved_inos -= numblocks;
-					numblocks = 0;
+					reserved_inos -= inodes;
+					inodes = 0;
 				}
 			}
-			ext2fs_bg_itable_unused_set(fs, i, numblocks);
+			ext2fs_bg_itable_unused_set(fs, i, inodes);
 		}
-		numblocks = ext2fs_reserve_super_and_bgd(fs, i, fs->block_map);
-		if (fs->super->s_log_groups_per_flex)
+
+		if (!fs->super->s_log_groups_per_flex)
 			numblocks += 2 + fs->inode_blocks_per_group;
 
-		free_blocks += numblocks;
-		ext2fs_bg_free_blocks_count_set(fs, i, numblocks);
+		grp_free_blocks = ext2fs_group_blocks_count(fs, i) - numblocks;
+		free_blocks += grp_free_blocks;
+		ext2fs_bg_free_blocks_count_set(fs, i, grp_free_blocks);
 		ext2fs_bg_free_inodes_count_set(fs, i, fs->super->s_inodes_per_group);
 		ext2fs_bg_used_dirs_count_set(fs, i, 0);
 		ext2fs_group_desc_csum_set(fs, i);
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 4a9c1b092..72c9da12e 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -3522,7 +3522,7 @@ no_journal:
 			       fs->super->s_mmp_update_interval);
 	}
 
-	overhead += fs->super->s_first_data_block;
+	overhead += EXT2FS_NUM_B2C(fs, fs->super->s_first_data_block);
 	if (!super_only)
 		fs->super->s_overhead_clusters = overhead;
 
-- 
2.41.0

