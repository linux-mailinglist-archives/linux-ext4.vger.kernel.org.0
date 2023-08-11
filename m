Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3190777875D
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 08:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjHKGTf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Aug 2023 02:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHKGTe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Aug 2023 02:19:34 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4582D6A
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 23:19:27 -0700 (PDT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168]) by mx-outbound13-154.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 11 Aug 2023 06:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8WHOV4SEjCQLJ8XJ5mswf0ZH0FG7MeySfBvzsvT2sqTPti6Z+C6XnAPz08H4YBevcWJ6ENlrJcU9309/szLEhKrWNfM8iOecAXkVPp+T9zhfsbwY/1/niI9pbBmCGcs5H6qWE3DZnGowoUq/hD7pvKvT1hdIwV0wSzXeVM5ixVStdAzEIohDyc91HulwJk0HySjh+X6LYYiPirCw6kqWeF9QTdB9lABqSMqTDNg5KInUY2w4CqmQUC2tpyUX7g/3QqV956FUXvDfuwGLulSsdgmiuzRDzrepKY6ZTAuK+nBETUkOqrEX/XUS36Xk34oqHPIO5W32x66eL+MWj7reA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG726rYsND1xZZmzB+q7PHpN6pf84OJeIN8DJwWUflI=;
 b=INOBJ7WteC8YmlRs3w6v94HmahaxS4AjMXUZgUJjhhX30R4pk6DAuNFI8JATLEI3WoxbM71KGbSim/kCXjcPeCY0G/8luT3usdPxp7Nklgmv9P9SHoYf6yaCXOZHhNZ5lI8fX/WL5h4ePL2Akejf2o1t6v85tHwl1Xv7T4hEZHd48Wl48VRxG93R7n7M5SRsZuV+Z+xpY7wVFKhZ7X7E2FxkACpBuqIVZojq5RMAyd9ZSjVAFLkthOpAzXDI20O1Oc3xjHc4uE2pqFWk6xsnTMA/ec0moMkaaVb5v0oD0luptEsc+AX5javKTgPN/9tbXwBy2HKr1PwNHdLemCAT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG726rYsND1xZZmzB+q7PHpN6pf84OJeIN8DJwWUflI=;
 b=BMd1jDNLFSqBLwsaUUaWsVHcfcMGoYHEzl1wuKQuwO11Y24dCqPXYno2KwBvjOwQMVV0QSjIBqEP/J8iXFPG7no9Z+tJbAwN8RbWWEWRcraTHDMmWbHE4eh5PbH3VF4O9G5SybskEt/8eDh/X5M13d0yvROue+5rcuyBZde85v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 PH7PR19MB7340.namprd19.prod.outlook.com (2603:10b6:510:27b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 06:19:21 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 06:19:21 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca, sihara@ddn.com, wangshilong1991@gmail.com
Subject: [PATCH 2/2] e2fsprogs: support EXT2_FLAG_BG_TRIMMED and EXT2_FLAGS_TRACK_TRIM
Date:   Fri, 11 Aug 2023 16:19:05 +1000
Message-ID: <20230811061905.301124-2-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811061905.301124-1-dongyangli@ddn.com>
References: <20230811061905.301124-1-dongyangli@ddn.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0006.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::10) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|PH7PR19MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c488404-d28c-409a-1878-08db9a32e6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+4wR1Yx59MMwaoyizSes0FE66byqQuEqxMn3FM2BzXTVeb29smNGxwYv79LvsfZAyMJsrmnE0LpEfHkj69MwYdT2Xxg+xgxheu9c+mAt9pNauCdS4yiQfgc2Fbeoenz1KjA+4yRP2PcOmXIEqyY8M7Z3PvkzLPmHqL1s8O/oe23KkPH7PdJjnwxIgkFxbL6cgnINECmY0JobmsmPP/XViUOF8/V3YF3SnBAPkb9eorNxHiuf2S6BzviGVoX2WqzhvkFpQ/38UGpPJxc79IDPVrGkJLKrT4rVOVRPFkhHPLVGNf4jCj7vVZR3jhMt07s3EN47XixA6GTY3hSbE//wz4RmSObMrvW2jHj7nx2ySMG8WkSJraZF2OKfCq2yv/UhajeTimyVZU+9v+Ry4fKLN9JHj6lYKt41HvUAOeXfThXso0uZZfT/vLuhychsMxClCdMy1nFNQkRUdnJFO2aqLuf7hf1XgYyYbHEStfOphkUCD+S7SORxS6KXAUZTJb6vJG+GOQmir+7lbyIZ5Irqg9nLYy2znUXiuxSZg8jsxIEH3WGnieYALnMa5MxQbgA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39850400004)(366004)(451199021)(186006)(1800799006)(6666004)(6486002)(6506007)(478600001)(55236004)(36756003)(38100700002)(26005)(1076003)(2906002)(6512007)(83380400001)(2616005)(4326008)(66476007)(66556008)(6916009)(5660300002)(8936002)(8676002)(66946007)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7BXtn+kWbS7KssJ8flqNoY+gr/f1vISS+JGGxfztjuwbsj60qHamc3+wPs/?=
 =?us-ascii?Q?8sOYfJt5zTlZr/OdMTD16J9CdyJYvmEP+ZJY58lKT9biMLRdvofcmSUYc9hO?=
 =?us-ascii?Q?9+OW2NigZtceDgLw8hq9iJyuzDCVliZe4fLyIWqHG3jMFQ4ELWuNSOml0UpT?=
 =?us-ascii?Q?rgDinOvebPHJB5j9Cb4oYJ4BJR033AsfxHunvYHSyIU+SABbNJ5kLkN067ZH?=
 =?us-ascii?Q?7lquJdNUV/f1uy79Byw7+DAgj403UowxjfkZ8DNFYThuD1Gwx8soXPuZ7aX5?=
 =?us-ascii?Q?ZbsF/E1X0pZz5jDRtmBsQojYjGs7gfT/8QWUtVeHmBAVzseDftUhK5agMcEk?=
 =?us-ascii?Q?vU6Yk1H0yISSE8OvFyS6sd4bI72hOLAKPjVuIeCFnCWePVLRiiLJd+G/nRTd?=
 =?us-ascii?Q?i8XXG3pPER7Ee540Qf/15dHs8Z+7VYqyU0duJR8JuzuJIsDWEHKAmETyuH62?=
 =?us-ascii?Q?/eLJwtR/lS8CqEeDC1d6Wuz3S4MRQbqsDQIKcbyBcW/K/UUKMIgpJiP/wfBo?=
 =?us-ascii?Q?HiwchzD31ODBSSkyM+7RkRHR0if4BzAqMFmY8KoMQUFchV2rOLk/UAXBoJ5B?=
 =?us-ascii?Q?ALZEfI5+u2ZeJYpNPGVIKlgF4dd0ObnlWtAjGfLXpi+AZIeD2AgIwOatvCWk?=
 =?us-ascii?Q?1mBhgPhMhNLZbkyjj/K5zVXcQuhKV083KITu7mhLSt6fBjhQ5Ads1Bqvrnzt?=
 =?us-ascii?Q?mBLIB7pSjf9D+VOOhFt+Y/nVtDzY7uoc8p6FW0HWdVhVNnEQHR8imx6p21EC?=
 =?us-ascii?Q?XT47APbiSpPOhBn031di4btXAGqbOfy0yaVay3ZIg8+cC62jAnQdVstpRD8Y?=
 =?us-ascii?Q?/XZs+B6GXSrTV5QxPWw105BO1mx8Q2ehAANd73QFI2NdE7Bx3XkulJPOKuwu?=
 =?us-ascii?Q?sfqs/gxf/HNmDEcEgNeq6MqLYU9/eIeqyMNNYqevjLGsyYMkULYiZLfKcrnJ?=
 =?us-ascii?Q?98lrkPyjtzIWKhiViGVQzwDuoOLFfwvVy7ckeCT9V/UOAnHDxO8kBvCgtvHs?=
 =?us-ascii?Q?aXP7q4V2t8AZXCd4yuygIUmOPNh6TClMWSDCOXtKNwEIJGs9VaLxpeYtXC+J?=
 =?us-ascii?Q?LWkVl5NSn7clQ8K5Ic1EfHk+vK8dJpp4vjsUOMteWchnX9kolcueUYIeNAhx?=
 =?us-ascii?Q?u9vyKL5B55H9++eMfNsAq5dtfyYdKK8cWoVmDnd9NNxP0YFz4aY+PPwwpt1l?=
 =?us-ascii?Q?57LCsmz13OxN5Mkxw8151AOCbImV4wN+DSj7Cow4+PlgvT8H1h1ZZCGNrF8Q?=
 =?us-ascii?Q?R0REAR8ArJK2bPsyLDr5UESxgnNsFscq/u+RPM4dT3DSuiB78uJ112LLcQtz?=
 =?us-ascii?Q?UAUCOv6gCU3ezDTyZwgViT37F6BhCpYVtS8Q1JohuvNERCQZUrkLDbHHwlUi?=
 =?us-ascii?Q?HFSZqhvHIvn9s8G5N2s757nos9yd4U+9kDtuYmZHOcCya7g5syJAQWgrVOwD?=
 =?us-ascii?Q?leKQjZrPrUVz1O+v1cc5yjGDs1e1wVXY1s7du1LRnn66uPq3NYicdXM6/8RX?=
 =?us-ascii?Q?skIZOLSewqUjw7AniBIzToNE3Dit/ej29x1pmrEWq1o4bhxgLa9q5mJQbZ8X?=
 =?us-ascii?Q?GpQvQDS3djAUH9eth64=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2L0emxUbX7irqONTyF5AsZafwzskApcCpvKyykNTamRxnomrMNACbVS0sF2LOEEaIQREu9xCF/IomxlIB5Lv63ULQP1K6GHWTkAldvEwy6TSLkRdSDMuOitshowMbCGpKmb+6lBxf2Aqa2akU1RZapt4aKP0MfeeNxtHg2TcDXidELwYJvHyA8712fkso3wH8bbgXI5qBiBREI3D3PkFVa+EKTg/U79Rmj0Tbc0GWvBC58OatRhTgzdRwuqLYPShgpOCSZM1yeTTTxqUR/tUJ7kQ3D3lRfc/0biru7E86Ah+L2But6ppDyqYWschRUWDY9C5lbS93C5I6FSKK3Mkv8GC9cF0qKfaM0ucM3UAxVgIAJeo4L06Gc/XCexAG4GQ8dsezjYRuOLX9xAGPqnE1MO0f1EAG3GGR/3KDRf4nzw1Lj+q6NhrTBJSl7BYix3fO05Oyg3EFBWzPESDXOvco68gKvfk86N8jnlWOCMAKVU0lwn1jYFsq/zq6QQ8IG3BMDwYld15GVA7s7beiKN3zeTUu4B38DAoozBeI7jLJwoNSKN2SGYzMR9DhjyS/fL3bLKYQ4euJWdQJXP0BOm8z57UIbSnV7vyKY4bHR1Jq2Xn7ECpU/VmTBKZpNyT/d/mdu61UOzvAAvweLZOfU5hbDuQJGbOXY+fv+6MjsBNikRuw2jacPxfzwwBCEUIMy+kwe1oVDZK99avKSqYVKWYlSni89cixET0PnsrwtGPozEMl6835eUrZrt0icmnS8L38u4TM12n2o0hnHOB6DVOanCeRCDlo3D9AhOdv2vzSEnMW++qTD5H71pXtiE0c63hbFQdYF9JxqRL2W78vMYO2utZsG/CuUStzQmh9a/akQI=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c488404-d28c-409a-1878-08db9a32e6bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 06:19:21.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7JgY3LRlyRtlXyGMwR2cIM24c7Vp5u1w75GHGIVLHEuU4g1nLzoA7lVs/eoDbX0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7340
X-BESS-ID: 1691734757-103482-12728-84411-2
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.59.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmYmBoZAVgZQ0CwtJTHVyDzVxM
        jcNMk00cQk2SglJcUiLTXFzNgg2cxcqTYWAH+R5HBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250067 [from 
        cloudscan10-131.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 MAILTO_TO_SPAM_ADDR    META: Includes a link to a likely spammer email 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=MAILTO_TO_SPAM_ADDR, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This adds EXT2_FLAG_BG_TRIMMED, which is used on block group
descriptors during mke2fs after discard is done.
The EXT2_FLAG_BG_TRIMMED flag is cleared on the block group when
we free blocks.

Introduce EXT2_FLAGS_TRACK_TRIM, which is a new super block flag,
to indicate whether we should honour the EXT2_FLAG_BG_TRIMMED
set on each block group.
EXT2_FLAGS_TRACK_TRIM itself can be turned on/off via tune2fs.

Make dumpe2fs aware of the new flags.

Cc: Shuichi Ihara <sihara@ddn.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Wang Shilong <wangshilong1991@gmail.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 lib/e2p/ls.c             |  4 ++++
 lib/ext2fs/alloc_stats.c |  8 ++++++--
 lib/ext2fs/ext2_fs.h     |  2 ++
 misc/dumpe2fs.c          |  2 ++
 misc/mke2fs.c            |  9 +++++++++
 misc/tune2fs.8.in        |  8 ++++++++
 misc/tune2fs.c           | 10 ++++++++++
 7 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/lib/e2p/ls.c b/lib/e2p/ls.c
index 0b74aea2b..4b356eca6 100644
--- a/lib/e2p/ls.c
+++ b/lib/e2p/ls.c
@@ -162,6 +162,10 @@ static void print_super_flags(struct ext2_super_block * s, FILE *f)
 		fputs("test_filesystem ", f);
 		flags_found++;
 	}
+	if (s->s_flags & EXT2_FLAGS_TRACK_TRIM) {
+		fputs("track_trim ", f);
+		flags_found++;
+	}
 	if (flags_found)
 		fputs("\n", f);
 	else
diff --git a/lib/ext2fs/alloc_stats.c b/lib/ext2fs/alloc_stats.c
index 6f98bcc7c..4e03f92a4 100644
--- a/lib/ext2fs/alloc_stats.c
+++ b/lib/ext2fs/alloc_stats.c
@@ -70,10 +70,12 @@ void ext2fs_block_alloc_stats2(ext2_filsys fs, blk64_t blk, int inuse)
 #endif
 		return;
 	}
-	if (inuse > 0)
+	if (inuse > 0) {
 		ext2fs_mark_block_bitmap2(fs->block_map, blk);
-	else
+	} else {
 		ext2fs_unmark_block_bitmap2(fs->block_map, blk);
+		ext2fs_bg_flags_clear(fs, group, EXT2_BG_TRIMMED);
+	}
 	ext2fs_bg_free_blocks_count_set(fs, group, ext2fs_bg_free_blocks_count(fs, group) - inuse);
 	ext2fs_bg_flags_clear(fs, group, EXT2_BG_BLOCK_UNINIT);
 	ext2fs_group_desc_csum_set(fs, group);
@@ -139,6 +141,8 @@ void ext2fs_block_alloc_stats_range(ext2_filsys fs, blk64_t blk,
 			ext2fs_bg_free_blocks_count(fs, group) -
 			inuse*n/EXT2FS_CLUSTER_RATIO(fs));
 		ext2fs_bg_flags_clear(fs, group, EXT2_BG_BLOCK_UNINIT);
+		if (inuse < 0)
+			ext2fs_bg_flags_clear(fs, group, EXT2_BG_TRIMMED);
 		ext2fs_group_desc_csum_set(fs, group);
 		ext2fs_free_blocks_count_add(fs->super, -inuse * (blk64_t) n);
 		blk += n;
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index 0fc9c09a5..88e1114c9 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -223,6 +223,7 @@ struct ext4_group_desc
 #define EXT2_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not initialized */
 #define EXT2_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not initialized */
 #define EXT2_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
+#define EXT2_BG_TRIMMED		0x0008 /* Block group was trimmed */
 
 /*
  * Data structures used by the directory indexing feature
@@ -563,6 +564,7 @@ struct ext2_inode *EXT2_INODE(struct ext2_inode_large *large_inode)
 #define EXT2_FLAGS_SIGNED_HASH		0x0001  /* Signed dirhash in use */
 #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in use */
 #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* OK for use on development code */
+#define EXT2_FLAGS_TRACK_TRIM		0x0008	/* Track trim status in each bg */
 #define EXT2_FLAGS_IS_SNAPSHOT		0x0010	/* This is a snapshot image */
 #define EXT2_FLAGS_FIX_SNAPSHOT		0x0020	/* Snapshot inodes corrupted */
 #define EXT2_FLAGS_FIX_EXCLUDE		0x0040	/* Exclude bitmaps corrupted */
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index 7c080ed9f..afe569dff 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -131,6 +131,8 @@ static void print_bg_opts(ext2_filsys fs, dgrp_t i)
  		     &first);
 	print_bg_opt(bg_flags, EXT2_BG_INODE_ZEROED, "ITABLE_ZEROED",
  		     &first);
+	print_bg_opt(bg_flags, EXT2_BG_TRIMMED, "TRIMMED",
+		     &first);
 	if (!first)
 		fputc(']', stdout);
 	fputc('\n', stdout);
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 4a9c1b092..bbfcde478 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -3154,6 +3154,15 @@ int main (int argc, char *argv[])
 	/* Can't undo discard ... */
 	if (!noaction && discard && dev_size && (io_ptr != undo_io_manager)) {
 		retval = mke2fs_discard_device(fs);
+		if (!retval) {
+			dgrp_t i;
+
+			fs->super->s_flags |= EXT2_FLAGS_TRACK_TRIM;
+			for (i = 0; i < fs->group_desc_count; i++) {
+				ext2fs_bg_flags_set(fs, i, EXT2_BG_TRIMMED);
+				ext2fs_group_desc_csum_set(fs, i);
+			}
+		}
 		if (!retval && io_channel_discard_zeroes_data(fs->io)) {
 			if (verbose)
 				printf("%s",
diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index dcf108c1f..2eb7e88ed 100644
--- a/misc/tune2fs.8.in
+++ b/misc/tune2fs.8.in
@@ -273,6 +273,14 @@ mounted using experimental kernel code, such as the ext4dev file system.
 .B ^test_fs
 Clear the test_fs flag, indicating the file system should only be mounted
 using production-level file system code.
+.TP
+.B track_trim
+Set a flag in the file system superblock to make fstrim save the trim status
+in each block group and skip the block groups already been trimmed.
+.TP
+.B ^track_trim
+Clear the track_trim flag to make fstrim ignore the trim status saved in
+each block group, and trim every block group.
 .RE
 .TP
 .B \-f
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 458f7cf6a..dd9e8eab0 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -2312,6 +2312,14 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 			sb->s_flags &= ~EXT2_FLAGS_TEST_FILESYS;
 			printf("Clearing test filesystem flag\n");
 			ext2fs_mark_super_dirty(fs);
+		} else if (!strcmp(token, "track_trim")) {
+			sb->s_flags |= EXT2_FLAGS_TRACK_TRIM;
+			printf("Setting track_trim flag\n");
+			ext2fs_mark_super_dirty(fs);
+		} else if (!strcmp(token, "^track_trim")) {
+			sb->s_flags &= ~EXT2_FLAGS_TRACK_TRIM;
+			printf("Clearing track_trim flag\n");
+			ext2fs_mark_super_dirty(fs);
 		} else if (strcmp(token, "stride") == 0) {
 			if (!arg) {
 				r_usage++;
@@ -2458,6 +2466,8 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 			"\tforce_fsck\n"
 			"\ttest_fs\n"
 			"\t^test_fs\n"
+			"\ttrack_trim\n"
+			"\t^track_trim\n"
 			"\tencoding=<encoding>\n"
 			"\tencoding_flags=<flags>\n"));
 		free(buf);
-- 
2.41.0

