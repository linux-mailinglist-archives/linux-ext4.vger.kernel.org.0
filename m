Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B624A7910A8
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 06:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbjIDE6C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Sep 2023 00:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbjIDE6B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Sep 2023 00:58:01 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB980C5
        for <linux-ext4@vger.kernel.org>; Sun,  3 Sep 2023 21:57:56 -0700 (PDT)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46]) by mx-outbound9-53.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 04 Sep 2023 04:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCvXpiAurw4d2qcgmc2IBbjfjv8gdjoyA99ER7gqEEYHxWVL9+GYByVA/VqWHkFTxF2tNbJlZywu5TywYw4X1wUef7maRzJ5lkJC+Ms0Y2C/G7wYQQXmWzTTmbuZ8KCyHmVtOs6H9mpvMpATEL44H6TEv7iR8KKhiaN9X4n/m0iBuBqiax5ukSZF9Xtn5vExC9ptxbbxu5vK2weMYhghm4urMBOS/nvg9pYrBRSp64vNjwTxc2hzc6XfzfQEV7FNN7UPkRw+tRiJBg66P0xBWtlvMZUTMVeGoT1WyGaGLLfXr1PIoAsCIM1XKkqa78Y39dV6yBO/NhzqHgAc7d9EYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeolKiGVSM1V4NjY145gM4d+kNBawyiag/VwxWhQEec=;
 b=AhQSzb/3BMkJB0SFbJZINqDYikD+xCOx3beezYx0dJ+g31jRhOCej8HUOch3q5UnkMuXev6dxIY7GbFocVAVUtRz2+5HtLF47IbhunW6ZfQ5WWHkjECFzJmNMjr/2qToxWzYCO8GzWzHTUK1+Ath6dQOZswAneGloZX9CAwJzVkTLoTzYJ+KekEHhmyZzpiJbqWVNQqBIDjgm808MKUnibDlJ2EznLpKGNR44/V5FWQo+S4GbOkw3h+GpDJxNfYLz+M8mIWIpnut9uXgkH7WzWESfz5kXKKl5K/LHhkFoHbEtFaJnM9NLLIhyvrjLebaFuGC+Ep8wlZzWYomMvycUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeolKiGVSM1V4NjY145gM4d+kNBawyiag/VwxWhQEec=;
 b=qHFX0Z08IJyo1AE7qid1EmjDaeC9oHVAPUm5enqcP0XiFInYsqzYVM2KuH4j6/DDWNUVBX6ucxKWAzXFwiJhHYQmgsIiAoAjViyCjqLwOJ48HbYof2ph76A+MgwdXoKhtYsEhNERA2Dqq4D66BtYgIrN5MvTZ5QD/RxDAhtE4mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 PH7PR19MB6635.namprd19.prod.outlook.com (2603:10b6:510:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Mon, 4 Sep
 2023 04:57:51 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 04:57:51 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca
Subject: [PATCH] e2fsck: check all sparse_super backups
Date:   Mon,  4 Sep 2023 14:57:42 +1000
Message-ID: <20230904045742.827584-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0072.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::15) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|PH7PR19MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc7749d-e05d-4521-c249-08dbad037d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGS3UPOg3kMmHfboPbVcTALu8vLfP/1RRSNt4HDqqQToZC/4wgSV/6NrjdBxrNx0ifcTXzVcUBViOJ6ZVq0M1KCn//33vFgMM/4DpXf1Cd/Ths8kb++m8qchrI6S5LaTqwQjznMjWJ7hCAE8Cml2r6lx05CqmwR+1GGhH2mplzRQl5ibJUKHehkz6yQYrkivY0wHX5ToLCUDHwKVpzFb5oRRu+OjnwRhXpvmk8HRxwZyuU7Eu9cwK5xB41Gb0BuuOxOXQkqJ37ppbTybNz58Q6NpsJb8Vh0KE0IAvLzg5H0KFTFPhu3f7tzswSefUdqjJV2bEH8whLiw/LIRsDenQziaSyZwDPfzPHkh7stYfR6SVa6KYu4O9QqHVpcpXeRYg9jBpYPpKxpLlZ3AOHsm0K+5VH5tKlHXDPOpxryvHC5OjgdGMqVGY4PvnB6mTYXe5d0m4Q25aPfypCkETmTRlQ1DLQhPj5ykoZLQZZ1JtuO0tj07W60ml6HJA1jDMqZN+GzX2M00BnwlrRbI83Gy8GyGMY6YqrfjMKPduNUBrRvfyIO5x4lrk6fvHfv1qyy6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(136003)(376002)(346002)(366004)(186009)(1800799009)(451199024)(2616005)(478600001)(6666004)(66946007)(66556008)(66476007)(26005)(1076003)(55236004)(6486002)(6512007)(6506007)(2906002)(4326008)(8676002)(8936002)(316002)(6916009)(41300700001)(5660300002)(36756003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WDxY5EscLA2ur0OVnatkNjaNsVqA+5AL4Ky5bYGmHTmQ5mnyWhz0p2wNnQXx?=
 =?us-ascii?Q?iBXdDIorhwE9X8CLutKZme0l4lceX/1CduB6q2oLq95NnddnD+H5Dy+Dd1wH?=
 =?us-ascii?Q?f3674lzeDKjQUrXTsOwC6NRKMttlsBrrA9e2O3xyBTvGniaqT3Nd19HvQt5F?=
 =?us-ascii?Q?2PGLz/89cq89a4AN4Oho90DxLJaahJLAcqbK2YKInY34tURcUSO5kWaiLO5e?=
 =?us-ascii?Q?p8ZdAW8u/Jk2nLFd6r1xzBzcMoVpB1h++c/NSQps40699BFtyP6+2mCaaFP9?=
 =?us-ascii?Q?6q0BTobJCH5DgPzc4LSg55Mz2gtrU9pjB4ZHuQrXZgAsqgduPyD7nZCzyGZe?=
 =?us-ascii?Q?duShCgPyghfyEIV/OPZwMzPvgFhGaA1ov2HhZlIT+rZgqR2gU4Znzl2CD4J/?=
 =?us-ascii?Q?XLZUlVD3HNwpODTQBuAY4MgJMqg9gj4TGNYUSsw54aWq9m6QyFyE4+BdUakJ?=
 =?us-ascii?Q?7fmdGMqeTKt2qOC7TXC+dMkaxfUWS6/lzK8nwt5tkbWJ6BztKVs9pUwrRTFx?=
 =?us-ascii?Q?SL7wrTp3MCdkfKhpXIVZvYr8brMQsbk/WUOsLZ2qqeuArzaObbQ66SxyIMHb?=
 =?us-ascii?Q?/HtkdLb3ripC6CBwK5AxkKFNYuIvfgr8Tj2vLvDrl1zb/K+3dQa6ZBHLG8f1?=
 =?us-ascii?Q?nr4smySbHHLL1KNOVhuqiS6zZf8sb0LKj+Dnk21qdSQogl6p4J2g4mUwVhGM?=
 =?us-ascii?Q?IX+KiorYq2wS0LzZImoy0Se4EIp8qhRQM5JxVd7TdvcOhFH8RU/NgA7+EFqn?=
 =?us-ascii?Q?BY70HRwmAq8DZHDGUJ3IAfi2lt1e1JCJh9btBM3sjxlcIjZtY91JwNgOpSxe?=
 =?us-ascii?Q?+Bw6e/RSjkBT+KdWyaOKGRHd0xLWRMwFlFoKJ1p+bjqOG2HiMMZTeCpF+RdA?=
 =?us-ascii?Q?CzOE1UcxK1zrD3SHGi/qr3egMdWbVI8TiiCmg+HYfceFlKep9RXMUn9J/Qk3?=
 =?us-ascii?Q?xKTnxyEWpu14fWxnWM/IEDN1o7R5diniknF3YgcNwyHFttaGdW8AXfH9j95l?=
 =?us-ascii?Q?PTaqCOUmmKXl+2kSKBKpKdo2nq5ldL+Em2fX5aLvPmofXcF14ojtURnBoQ2m?=
 =?us-ascii?Q?tz5kgL+eg5tiuIFLrWq8saRu/aMN99pP2RGYCvSPCCoBNAd/w6zTmLlD7Lt0?=
 =?us-ascii?Q?T/Os9WY2G4Y69YjiRifo7/9COXEMk8fKqSzQ7UwXIKSCZGNzxMvxhn6R6j9i?=
 =?us-ascii?Q?cPf2//Ky1OrzAZlcuy3Yxcb6uuonGkSYFp4Wr4q/mIGt1bXWEktCrPOCHNjo?=
 =?us-ascii?Q?ngaHvZMVtp95H8mH1Mju23gxzo/akXFfQvS/jgo8ZehaVgK5kA1tXVrJjlWh?=
 =?us-ascii?Q?rCUwLgjHZXNUS3zesAgGZZSuU0bCuveo6UpjB1ib6OzRrQ5gkLRxFVqrEXVK?=
 =?us-ascii?Q?P3NO/14SFOEMN6nmEk4aPTc2UcTWzI2HYlEthdj39EyBA4a0apiVitAPeg6Z?=
 =?us-ascii?Q?7swp5BqdO8KOuVzvy9iFGFBULGychIBceSSa8F5bA486R9WpbgdoTCsNPuO0?=
 =?us-ascii?Q?Xak8ZKvcbdKuaI7KPravIL154bfpciRh+XeMBN2bg8b6b/o7fL2oa6Vk4RRa?=
 =?us-ascii?Q?sSR7PxiYpqbK/ajEcMI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8l0DeqFOFsbOCXhZlTr+vSJn3Ijm/bZsrWxG21cUjXsn3VHKxvw4LaEDwKkO6/U4fSof0eDXjEuMnzeSVlLh+u7+SC/ifZhJ5gd+bpLBOVbia6vTWyx/R+eftiMwL96gbzgT/1cb6mcCu+g9NLwuYhHHgxA5vx9VGNXcv42fqdpHcQFiUM3nVH1dl8Y0aEhhO3ZMvFS6bxjvzXQKBugPeOBTqMGWaiZ8EL3fgGLNh7VQOt0Pg9VoSdlX+dOSgZEsxqX57qWRvUD9iTnnDvTyUh4QuKZ66N91GZrccfTJnHmv78ECq4ormtyIKZjAXSPOtVJh1Yib+oE0LlgEZ4s3Z0xSKI1bxLsYF4YGgpS/f/cIWqJR25TEY/y2vidAWKh9t1cQTyh32HzCPN+zJNPMyq8ZjngnT1LuMfLP3wv32aR5pRRu+0/F7qaEDxXyZjcJy7EeflfuOYVkPJM43XJJdyny5tJsavhyF4eKNDqsKEAiL4zO9ovKJPq0L1Igl9yXDwVa6vPcPGRcw2UfD2ZXAyku1TWLdsQwYUq68lkTPSnzH45/BQlo4Ow0gP6vxqU+ageqyRucbyEN0DVSIQwwimx71TshbNNqahe5rxUBnytfzvlIYtBxbV9msM7XnbH7NYDQDhzJoCPaEYNz8EHyxVUO2ukxZdgKWJ1hwRE5Uqa/gTvlS89iCREx1oTy5KX58ILMH+Py7qow2v1FA5PoXIHER90ZK+gSIdkK3XvfSkrx5A1NyL5FLJpeRBfmpJNSOOVPeyE0O01E2l9WUEvFGrs3k3mW09khHBfrlpZLVtiLGvAiAdK0ldDfDNMM0Xi9
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc7749d-e05d-4521-c249-08dbad037d58
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 04:57:50.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewdsQoTtJNq/cTR/gS+AlPowhlMGb8lcKVPBC2hP7CKBvX9NihfuyKs3qE01ElxJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6635
X-BESS-ID: 1693803474-102357-12728-47817-1
X-BESS-VER: 2019.1_20230901.1930
X-BESS-Apparent-Source-IP: 104.47.73.46
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZGFqZAVgZQMDXR0sgszSjFLC
        0xzSI5NS3NONEkMc3MKMXQKNESyFeqjQUAnyzFqEEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250593 [from 
        cloudscan8-114.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

From: Andreas Dilger <adilger@whamcloud.com>

Teach e2fsck to look for backup super blocks in the "sparse_super"
groups, by checking group #1 first and then powers of 3^n, 5^n,
and 7^n, up to the limit of available block groups.

Export ext2fs_list_backups() function to efficiently iterate groups
for backup sb/GDT instead of checking every group.  Ensure that the
group counters do not try to overflow the 2^32-1 group limit, and
try to limit scanning to the size of the block device (if available).

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
---
 e2fsck/util.c                | 77 +++++++++++++++++++-----------------
 lib/ext2fs/ext2fs.h          |  2 +
 lib/ext2fs/res_gdt.c         | 34 ++++++++++------
 tests/f_boundscheck/expect.1 |  1 -
 tests/f_boundscheck/expect.2 |  1 -
 5 files changed, 64 insertions(+), 51 deletions(-)

diff --git a/e2fsck/util.c b/e2fsck/util.c
index 0fe436031..6982966e6 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -560,29 +560,20 @@ blk64_t get_backup_sb(e2fsck_t ctx, ext2_filsys fs, const char *name,
 	struct ext2_super_block *sb;
 	io_channel		io = NULL;
 	void			*buf = NULL;
-	int			blocksize;
-	blk64_t			superblock, ret_sb = 8193;
+	int			blocksize = EXT2_MIN_BLOCK_SIZE;
+	int			blocksize_known = 0;
+	blk_t			bpg = 0;
+	blk64_t			ret_sb = 8193;
 
 	if (fs && fs->super) {
-		ret_sb = (fs->super->s_blocks_per_group +
-			  fs->super->s_first_data_block);
-		if (ctx) {
-			ctx->superblock = ret_sb;
-			ctx->blocksize = fs->blocksize;
-		}
-		return ret_sb;
+		blocksize = fs->blocksize;
+		blocksize_known = 1;
+		bpg = fs->super->s_blocks_per_group;
 	}
 
-	if (ctx) {
-		if (ctx->blocksize) {
-			ret_sb = ctx->blocksize * 8;
-			if (ctx->blocksize == 1024)
-				ret_sb++;
-			ctx->superblock = ret_sb;
-			return ret_sb;
-		}
-		ctx->superblock = ret_sb;
-		ctx->blocksize = 1024;
+	if (ctx && ctx->blocksize) {
+		blocksize = ctx->blocksize;
+		blocksize_known = 1;
 	}
 
 	if (!name || !manager)
@@ -595,28 +586,42 @@ blk64_t get_backup_sb(e2fsck_t ctx, ext2_filsys fs, const char *name,
 		goto cleanup;
 	sb = (struct ext2_super_block *) buf;
 
-	for (blocksize = EXT2_MIN_BLOCK_SIZE;
-	     blocksize <= EXT2_MAX_BLOCK_SIZE ; blocksize *= 2) {
-		superblock = blocksize*8;
-		if (blocksize == 1024)
-			superblock++;
+	for (; blocksize <= EXT2_MAX_BLOCK_SIZE; blocksize *= 2) {
+		dgrp_t grp, three = 1, five = 5, seven = 7;
+		dgrp_t limit = (dgrp_t)-1;
+		blk_t this_bpg = bpg ? bpg : blocksize * 8;
+
+		if (ctx->num_blocks && limit > ctx->num_blocks / this_bpg)
+			limit = ctx->num_blocks / this_bpg;
+
 		io_channel_set_blksize(io, blocksize);
-		if (io_channel_read_blk64(io, superblock,
-					-SUPERBLOCK_SIZE, buf))
-			continue;
+
+		while ((grp = ext2fs_list_backups(NULL, &three,
+						  &five, &seven)) < limit) {
+			blk64_t superblock = (blk64_t)grp * this_bpg;
+
+			if (blocksize == 1024)
+				superblock++;
+			if (io_channel_read_blk64(io, superblock,
+						-SUPERBLOCK_SIZE, buf))
+				continue;
 #ifdef WORDS_BIGENDIAN
-		if (sb->s_magic == ext2fs_swab16(EXT2_SUPER_MAGIC))
-			ext2fs_swap_super(sb);
+			if (sb->s_magic == ext2fs_swab16(EXT2_SUPER_MAGIC))
+				ext2fs_swap_super(sb);
 #endif
-		if ((sb->s_magic == EXT2_SUPER_MAGIC) &&
-		    (EXT2_BLOCK_SIZE(sb) == blocksize)) {
-			ret_sb = superblock;
-			if (ctx) {
-				ctx->superblock = superblock;
-				ctx->blocksize = blocksize;
+			if ((sb->s_magic == EXT2_SUPER_MAGIC) &&
+			    (EXT2_BLOCK_SIZE(sb) == blocksize)) {
+				ret_sb = superblock;
+				if (ctx) {
+					ctx->superblock = superblock;
+					ctx->blocksize = blocksize;
+				}
+				goto cleanup;
 			}
-			break;
 		}
+
+		if (blocksize_known)
+			break;
 	}
 
 cleanup:
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 72c60d2b5..7f3f6794a 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1483,6 +1483,8 @@ errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
 					   ext2fs_block_bitmap *bitmap);
 errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
 				     blk64_t end, blk64_t *out);
+extern unsigned int ext2fs_list_backups(ext2_filsys fs, unsigned int *three,
+				unsigned int *five, unsigned int *seven);
 
 /* get_num_dirs.c */
 extern errcode_t ext2fs_get_num_dirs(ext2_filsys fs, ext2_ino_t *ret_num_dirs);
diff --git a/lib/ext2fs/res_gdt.c b/lib/ext2fs/res_gdt.c
index fa8d8d6be..e4e290bba 100644
--- a/lib/ext2fs/res_gdt.c
+++ b/lib/ext2fs/res_gdt.c
@@ -20,18 +20,19 @@
 /*
  * Iterate through the groups which hold BACKUP superblock/GDT copies in an
  * ext3 filesystem.  The counters should be initialized to 1, 5, and 7 before
- * calling this for the first time.  In a sparse filesystem it will be the
- * sequence of powers of 3, 5, and 7: 1, 3, 5, 7, 9, 25, 27, 49, 81, ...
+ * calling this for the first time.  In a sparse_super filesystem it will be
+ * the sequence of powers of 3, 5, and 7: 1, 3, 5, 7, 9, 25, 27, 49, 81, ...
  * For a non-sparse filesystem it will be every group: 1, 2, 3, 4, ...
+ * For a sparse_super2 filesystem there are two backups in specific groups.
  */
-static unsigned int list_backups(ext2_filsys fs, unsigned int *three,
-				 unsigned int *five, unsigned int *seven)
+dgrp_t ext2fs_list_backups(ext2_filsys fs, dgrp_t *three,
+			   dgrp_t *five, dgrp_t *seven)
 {
-	unsigned int *min = three;
-	int mult = 3;
-	unsigned int ret;
+	dgrp_t *min = three;
+	unsigned long long mult = 3;
+	dgrp_t ret;
 
-	if (ext2fs_has_feature_sparse_super2(fs->super)) {
+	if (fs && ext2fs_has_feature_sparse_super2(fs->super)) {
 		if (*min == 1) {
 			*min += 1;
 			if (fs->super->s_backup_bgs[0])
@@ -42,11 +43,14 @@ static unsigned int list_backups(ext2_filsys fs, unsigned int *three,
 			if (fs->super->s_backup_bgs[1])
 				return fs->super->s_backup_bgs[1];
 		}
+
 		return fs->group_desc_count;
 	}
-	if (!ext2fs_has_feature_sparse_super(fs->super)) {
+
+	if (fs && !ext2fs_has_feature_sparse_super(fs->super)) {
 		ret = *min;
 		*min += 1;
+
 		return ret;
 	}
 
@@ -60,7 +64,11 @@ static unsigned int list_backups(ext2_filsys fs, unsigned int *three,
 	}
 
 	ret = *min;
-	*min *= mult;
+	mult *= *min;
+	if (mult > (dgrp_t)-1)
+		*min = (dgrp_t)-1;
+	else
+		*min = mult;
 
 	return ret;
 }
@@ -142,8 +150,8 @@ errcode_t ext2fs_create_resize_inode(ext2_filsys fs)
 	     gdt_blk = sb_blk + 1 + fs->desc_blocks;
 	     rsv_off < sb->s_reserved_gdt_blocks;
 	     rsv_off++, gdt_off++, gdt_blk++) {
-		unsigned int three = 1, five = 5, seven = 7;
-		unsigned int grp, last = 0;
+		dgrp_t three = 1, five = 5, seven = 7;
+		dgrp_t grp, last = 0;
 		int gdt_dirty = 0;
 
 		gdt_off %= apb;
@@ -183,7 +191,7 @@ errcode_t ext2fs_create_resize_inode(ext2_filsys fs)
 			goto out_dindir;
 		}
 
-		while ((grp = list_backups(fs, &three, &five, &seven)) <
+		while ((grp = ext2fs_list_backups(fs, &three, &five, &seven)) <
 		       fs->group_desc_count) {
 			blk_t expect = gdt_blk + grp * sb->s_blocks_per_group;
 
diff --git a/tests/f_boundscheck/expect.1 b/tests/f_boundscheck/expect.1
index c2170b8f9..5c9ead485 100644
--- a/tests/f_boundscheck/expect.1
+++ b/tests/f_boundscheck/expect.1
@@ -1,6 +1,5 @@
 ext2fs_check_desc: Corrupt group descriptor: bad block for inode table
 ../e2fsck/e2fsck: Group descriptors look bad... trying backup blocks...
-../e2fsck/e2fsck: Bad magic number in super-block while using the backup blocks../e2fsck/e2fsck: going back to original superblock
 Note: if several inode or block bitmap blocks or part
 of the inode table require relocation, you may wish to try
 running e2fsck with the '-b 8193' option first.  The problem
diff --git a/tests/f_boundscheck/expect.2 b/tests/f_boundscheck/expect.2
index c2170b8f9..5c9ead485 100644
--- a/tests/f_boundscheck/expect.2
+++ b/tests/f_boundscheck/expect.2
@@ -1,6 +1,5 @@
 ext2fs_check_desc: Corrupt group descriptor: bad block for inode table
 ../e2fsck/e2fsck: Group descriptors look bad... trying backup blocks...
-../e2fsck/e2fsck: Bad magic number in super-block while using the backup blocks../e2fsck/e2fsck: going back to original superblock
 Note: if several inode or block bitmap blocks or part
 of the inode table require relocation, you may wish to try
 running e2fsck with the '-b 8193' option first.  The problem
-- 
2.41.0

