Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5078BE05
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Aug 2023 07:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjH2Fni (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Aug 2023 01:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjH2Fn1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Aug 2023 01:43:27 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDBADF
        for <linux-ext4@vger.kernel.org>; Mon, 28 Aug 2023 22:43:23 -0700 (PDT)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175]) by mx-outbound10-79.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 29 Aug 2023 05:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJlYr4so8zGe/r7s71Kab7vmlUu7wAH2/28Ca6uWAMPQXPx95yArlnaNfskmjYiDE1AetJBt5P0/tkIvmdJaxi1fnr0JRLHJteloIinbpjOS2NmkmRd9Uv6N602/kVotjp6noZfkzzKT6DyULNmhM1L5LabRuQYPXgaqB286sutUcHdtIbqy4l9UhpBvFCwf89i8/6uhe0fj56QsusndlYFQq79lT+gfeU0OOltWorZuOJUW1BnzGwbQ0AMDBJ80zMp/J8d2dN0jqLN4mUprYpZGFRNXxNWsM10s/ZJF1e1iGAkua5MpwquHYBlfae+ouZRDjDuWutG/PHeto3WSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifm4LxgoFMAOwRd6QAI8fq9JaAx6jj6dZWl875D2Dzg=;
 b=R9ypSmDTi/zNx6+wYRvnCPw1E1E9DpAgVyUEprI5Gy1Rf5u9UdQIxJ72XeaZBtrJ8fsDqSLbHdfClsQmSAFz9M5bZLDHO6FpiurccX4r9eeN6il4fCaAF1xE8jMkkQiPjPiltGDuKfCs6gxyk/O+mr+EXowi1n03EnyI3hoszHf7YWPPFa4zjgUOk4Qq7KCEAdJE9DuvGTvxYXyCi57eEJkNNrT9dMdXuM+hwsXQXxkPiK+HZB8N4aKgojfxfPuZWbeikY75VdGrMsKbAMLm+VpmHq9YxLvR+NhGw9J/anWCAY7ZXtQDgNAzV3uPdzpzlUTTLI8Y/s3YmcCmEs0sIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifm4LxgoFMAOwRd6QAI8fq9JaAx6jj6dZWl875D2Dzg=;
 b=jL23dKsPavrR9wx4AGPCApEYi2JSIIJ05v3S4mDGYTaAX1JOYfGA2Pq6p7N5EbG5hRF2Nmm6ImGi0HUAcjQLh1BMEFezosEPl8sTvE5EPdEVmBxG7FvE/C2sV+U/JolnrnE9Jb54Trbu4ErLGEpCdgg9hq0exwEx+oEgU0eAjXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 SA0PR19MB4633.namprd19.prod.outlook.com (2603:10b6:806:c0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Tue, 29 Aug 2023 05:43:18 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 05:43:17 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca, sihara@ddn.com, wangshilong1991@gmail.com
Subject: [PATCH V2] e2fsprogs: support EXT2_FLAG_BG_TRIMMED and EXT2_FLAGS_TRACK_TRIM
Date:   Tue, 29 Aug 2023 15:43:09 +1000
Message-ID: <20230829054309.684530-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0008.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::18) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|SA0PR19MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ae6ecb-8dd5-4e68-c0f9-08dba852d813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WVbgROMNwIQYZ8SWxwDVQD9Sgr4H5XwWfINXAMD9Aik9A8vFNfhq+gsT7QrClqlHbTAB6QM1BPtUe0GQdogCKnfzhh9vVfrGb2FsgttUG6eI8Wm6D4ugeqC8XTVndJQmOvbrmr2/34f10NunAeujhFffTAurD3juFnN+1UQuEzzSSa8Bakxb1ajAnT8qHcAJBtmrElvHl20y2dbR4xFiGTc678qmiPVNCpjB8zJKP67PpJbQgxXzAY2fEmItnJtIaFzcVsvPqbGH2NO0/hcVKr4m/zxgJNIATvR5kSz0n9jQsNGtONAj88J6PYIxP3af8QaLvIEm3GIge1vHrK7uI07ftXB2mOtrIwuKLOVIhsPeTQ8TqLzy4O7FhjSBxMpaUBl7kKVuyL1NMUt4IqylHAl5lc+nj8HZkfAVty1/FXqnm9jb2WmBzHzeu9caFAjFTAzR0Vxbm1YAVy7x87eawTGom1fyRlFHnEv6xGrMGkbSlulP6jr1W6XfgL0zEetln6B04O18fmBIfqcgU5/PGusFyj/QbFmtJILat9pOTW9RNEJennrtv0XNzRZrNPV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(346002)(376002)(366004)(1800799009)(186009)(451199024)(478600001)(83380400001)(26005)(1076003)(2616005)(6486002)(55236004)(6506007)(6512007)(6666004)(2906002)(316002)(66476007)(38100700002)(6916009)(8676002)(4326008)(5660300002)(41300700001)(66946007)(8936002)(36756003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RkADKyGK7HfBNs7sE4TVB3Z7+9ndXBK4c/vyXEpKD+mLaxQWUM9rt7k5sDX4?=
 =?us-ascii?Q?COP3BFV2lpzE81J8lwmavCkHlGvzT/2mpwPBPeZolFpA/mMxVRjlZpbQJOqR?=
 =?us-ascii?Q?2lyuYuTTIVv/gcjMmGylgc3Wcse68ruQW1uq9Suozrv2qvswakMXEf+OGpx/?=
 =?us-ascii?Q?HmmwuYDENTG6rtc+vEnlWwqVv9sCshgzkX3au3+7kgGJK0uIbcDvtH1sCPfh?=
 =?us-ascii?Q?/AsDDVB6GN1UyDdPR6wHY0tBSIU1CRfiIjf9AIA3xNliohSKHWIIpa8X4pH1?=
 =?us-ascii?Q?wD8lftXtOndAaacDV2Ni9jAzZrGbmCGxuN4jpj9h5anAITdN2D4R1K8G7txX?=
 =?us-ascii?Q?0AlihTAcyNm9vBP8p6I/GPqCgG34DOQWI0YJIV5O5CIKph5batc6hgN3Z0Hu?=
 =?us-ascii?Q?79OnRnzdpuSX0PKjooVSPrPAvZFtXHRc8Qkea3vCK/ZpH7uuVNkVoOaXJhoA?=
 =?us-ascii?Q?xOk+9CG1zfUP3FiDoQUlV/rQfpM22WNBBqehV6y/Aw50J74P6LehrfpeSbsG?=
 =?us-ascii?Q?Pj5CZ2dJhM8/iKkgWG5BlTtBZgkC+QXdgqO3esj3G403u6crT2YdWzjiwSi9?=
 =?us-ascii?Q?fbWrlEItC81F9Ed2UyGOQQC+OAxvlYChLx1DsjxyQ+vr8xN45HPhXv23mI0P?=
 =?us-ascii?Q?C8xzbNr6sAQLE6runAyIsSYFdoX4Z77jBynqcpNKfM11PKpi82WVJgUoWcbI?=
 =?us-ascii?Q?k23ANW+IwZ/DJ52thmTgXhPPJQW349q0b76I/RrItZwlUi/MpkO9s9yQsSO2?=
 =?us-ascii?Q?5aDLo1ouGaDtEEDgTY1RZtUlHAK1hUCbg4OLxIQ/hSv2SO++lhFsntdNfeDU?=
 =?us-ascii?Q?uctmlaKGev8icS7++I+62sgoq/593inhcINR4WdVHKHm/hbnqnXipHLNGWpc?=
 =?us-ascii?Q?XQSyXXp0L/BXirn8dB0KwizM4xrBfnow0srAvMxBE5VouvekPSOkW0QZyYWJ?=
 =?us-ascii?Q?393TtYJ4nfcaAO1jVu6XL+E2uec+a+/cm5mRCp5pVDqPpHhc8rUqmYK9s38O?=
 =?us-ascii?Q?DxfxqWgxP54DVzpgEAYR6G6NXQuYfq9oYApIiR/Gnl4yLz/Tb2xZncS/A2Ns?=
 =?us-ascii?Q?g0Fd02pm79O0VtgjgSBpEjTqNxOUUOFVxfHRhkmqtXXCpnUwx2oSeGr2ae1e?=
 =?us-ascii?Q?z+zcoNIl3HEKpjjuvxkEBbQi/WDiBDMchdyW5cmvsxVOfOFRjIqVXhjquTBd?=
 =?us-ascii?Q?mGDkuQEJydGG5K0CQXl3NLD1r+9/IJMOanXBRXpXx3EbC7uWoWVDz7v70Avz?=
 =?us-ascii?Q?soyul/A2b2MsdLyOIk3ID/v8/P292YlnrQ22BRXWpCA0NJC3dIy7JIGI7PHy?=
 =?us-ascii?Q?5NJTRtaGR/ByxaE20I269qb5j5bA2UgZY65Yj1bo/6XEvrY4AO4/JwEg3yIi?=
 =?us-ascii?Q?px6Vb8i/QIkNciPSDanTo8SjglhN8MrMVgjQ55+zE9VDtp0gOOesWBkc4NLT?=
 =?us-ascii?Q?aqcOi59m0IZo16Ak+kUPGr5dbg22TDylepftUuC14OicS91UGTznJVQ6G6t7?=
 =?us-ascii?Q?213l7sjST1exTXA8rjepDOTUGKezXksbi6PRk0Ef4qc3DRvm0wsQfp1QNpMp?=
 =?us-ascii?Q?enAqvQa96VAdLFKV+dI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0QrAlF56trsI6WHFxMgGgxUdr8dVn3K9XMK3hsv7NVxR74fNbIIrgZsaUvr4qAdYingg1uM4uMTqJSOUyApAri5uwtE0a7LZ2p6gI50Ibi2iDOAOnKm+jtONjqrGheuokp8fWKDhvuFJC9oxtAuWKCLPU7zvxdH+IlTjSNYey2Tz5xOTUUCdhlmOabF/FOeHoGnVn6JdY1fBPQLxZXaK+jq9FYn85q41koSKFAy8tTSAPuGODQV6t3XPvlHL8Vo7En0enOruoPWkkmahem2hCzfqnEgh7CEx0duS1SWreJYF3yC3tM4M/bMMl9rWoAsxUrw920kWYo3HCznzSVe/MewItJrydvFaKyb98omFEV+vi/1B3oIgG7iZ5CZvuJZ9JchQbe5mjYKLlKPZd3u5tHAfkyJi28YNSHhu9dPeAwx9HSrqjd8a5i2niuN2sr8x36InC8BWj0U9EMm4OZrLrsZTLiogfrpgHxtMO13VtvTrVt35omJu5727V+5dofa9Ork68MtjKcJ9fLZI/WGH1EMG8O2g2c0d8f3a9aRoLpwoWn8QshpokOi1L86P9HGdIiwjJteYUtv3MDO0xvOp3auhQxN9Z7DmFL8O8TUKgdaTwwCdjvCwjBnhQ0Jpqvtjy3fCvib03b3XybNpPtcKryaGzI6whKolGUhw5A9//iCT5SV+UaKDfs+u1gYVtWWF4JWe55bgcfWWkG0UalAM7OReWEeAuTENB2cUjojXZ1hmlBfgQr5RCCb2+E5HoWktUcvefE1m9BFIgCK0BGAJvH4xI68vS2fzqy+WGMM1lZtCMk0EfDnCSPaWm3zpiZoo+JE4BmCtwqSYRVCNxkLrWus4gyuKm3chcC4C1Oi2iL8=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ae6ecb-8dd5-4e68-c0f9-08dba852d813
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 05:43:17.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK9MEqUJHLuBOwhL4bgC0HdNn+w1xSBVx93k3UDrj35N9V1EWQUtk434v62+Oi2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4633
X-BESS-ID: 1693287800-102639-29827-14105-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.55.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZmBuZAVgZQMC3NzCI1McXS0t
        TCyCDR1MgyNdnS3CIlySItJdXIJM1IqTYWANeGqJVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250460 [from 
        cloudscan19-224.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 MAILTO_TO_SPAM_ADDR    META: Includes a link to a likely spammer email 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=MAILTO_TO_SPAM_ADDR, BSF_BESS_OUTBOUND
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

This adds EXT2_FLAG_BG_TRIMMED, which is set on block group
descriptors during mke2fs after discard is done for that group.
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
v1->v2:
set BG_TRIMMED flag on gd progressively as we discard the groups.
---
 lib/e2p/ls.c             |  4 ++++
 lib/ext2fs/alloc_stats.c |  8 ++++++--
 lib/ext2fs/ext2_fs.h     |  2 ++
 misc/dumpe2fs.c          |  2 ++
 misc/mke2fs.c            | 34 +++++++++++++++++-----------------
 misc/tune2fs.8.in        |  8 ++++++++
 misc/tune2fs.c           | 10 ++++++++++
 7 files changed, 49 insertions(+), 19 deletions(-)

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
index 4a9c1b092..0eff41aad 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -71,8 +71,6 @@ extern int optind;
 #define ZAP_BOOTBLOCK
 #endif
 
-#define DISCARD_STEP_MB		(2048)
-
 extern int isatty(int);
 extern FILE *fpopen(const char *cmd, const char *mode);
 
@@ -2872,9 +2870,7 @@ err:
 static int mke2fs_discard_device(ext2_filsys fs)
 {
 	struct ext2fs_numeric_progress_struct progress;
-	blk64_t blocks = ext2fs_blocks_count(fs->super);
-	blk64_t count = DISCARD_STEP_MB;
-	blk64_t cur = 0;
+	dgrp_t group;
 	int retval = 0;
 
 	/*
@@ -2886,22 +2882,26 @@ static int mke2fs_discard_device(ext2_filsys fs)
 	if (retval)
 		return retval;
 
-	count *= (1024 * 1024);
-	count /= fs->blocksize;
-
 	ext2fs_numeric_progress_init(fs, &progress,
 				     _("Discarding device blocks: "),
-				     blocks);
-	while (cur < blocks) {
-		ext2fs_numeric_progress_update(fs, &progress, cur);
+				     ext2fs_blocks_count(fs->super));
 
-		if (cur + count > blocks)
-			count = blocks - cur;
+	for (group = 0; group < fs->group_desc_count; group++) {
+		blk64_t start = ext2fs_group_first_block2(fs, group);
+		blk64_t count = ext2fs_group_blocks_count(fs, group);
+		int retval_discard;
 
-		retval = io_channel_discard(fs->io, cur, count);
-		if (retval)
-			break;
-		cur += count;
+		retval_discard = io_channel_discard(fs->io, start, count);
+		if (!retval_discard) {
+			ext2fs_bg_flags_set(fs, group, EXT2_BG_TRIMMED);
+			ext2fs_group_desc_csum_set(fs, group);
+			fs->super->s_flags |= EXT2_FLAGS_TRACK_TRIM;
+		} else if (!retval) {
+			retval = retval_discard;
+		}
+
+		ext2fs_numeric_progress_update(fs, &progress,
+					ext2fs_group_last_block2(fs, group));
 	}
 
 	if (retval) {
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

