Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA9F650C69
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Dec 2022 14:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiLSNGA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Dec 2022 08:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiLSNF6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Dec 2022 08:05:58 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315C65E6
        for <linux-ext4@vger.kernel.org>; Mon, 19 Dec 2022 05:05:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiOjDCbAznNhYnL/n2oSACWgNvKpspS2J7vRhbFkylgUf+iP4vyq3M+70lXJpGle9VxqEKCZR9Md1qga6efcnnilwvxlUweFxDlNJDNwF8xMqusemDqckNobxvm6jF7PpViAivCmqhIqsvzHHyv73cZpRQPc8YN8fwX6cQqfm7lMZ0CqWRMrKDQwMHUFmD9kDG4aoh0QYO5lw9SOlQLaRT5tBG6ZjqW5BmwLkp/fghV7AVI3xk5qZFejIaoRVqAv7RJNbpK1Gie9k1aRTMz+7LZ/QJdwaDlRvxhKD8NvfUcRPPcA2ElTRcAhxXMeH73v9SETWVANaAXvZUi433BGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HfD2JK+cvjc1PbYsuSxE6oUy5zgHwkcQLUVAhpj4LI=;
 b=aAjaDqLP9zbZDZh4FMiEHs9oEuVqq6E/2tQqYDz9L1naaUDm3eMEmBikoS6S8CUHY2lhn0oVEKe00zaceP/BSNT0CmHr4bAqoNemibWMX7dvx06p92wrfDja4u+h+bNFKwzQe1Kzj22AvDslft0wks0KxYGInhtusLMNM60TE+XUBgauMOGRzowHS0XUPKesylB+3AV52UXc3M43NursbyVNXnbslv47Y2qZBeesD3o5jYEpYwCYASN9HBaASUMdRDY/mXbEGmLWLeuvpJgqPyRX8yoY1GvUJ87RRtNe7bVsoOOS8PuFcu55koWsFVDXk66UCdkYwRp2VHj9D8r1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HfD2JK+cvjc1PbYsuSxE6oUy5zgHwkcQLUVAhpj4LI=;
 b=KOK1m66KnymD/W0IVBvz9MBmXsrNoE/Hhu2U3b6nB5cK48JKToo3nmJ5x4ya+PsxhF9obRP5mijvXlln4CRqYZfa4i3Q/3uyFVnrAlGGttIdjN+h9TIFjJSxvv82I2qIsdznQw7kgSQlV4waCckpu62U04mYviEIiEyu07ZIsMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 PH7PR19MB6613.namprd19.prod.outlook.com (2603:10b6:510:1b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 13:05:54 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::d76d:22cb:7015:d323]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::d76d:22cb:7015:d323%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 13:05:54 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca
Subject: [PATCH] e2fsck: optimize clone_file on large devices
Date:   Tue, 20 Dec 2022 00:05:44 +1100
Message-Id: <20221219130544.259410-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0005.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::13) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|PH7PR19MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: e886e1c0-da48-4599-dbf1-08dae1c1c2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fm5BsAKXVVN7Boz3W+p/dV/HGYkIQqwFa6StgwZvacoUkJkROk1X1GHP4zX5NeXqghr8c7bYdSnrvkyFbcCAllwSeHPkYHoRwfiJvaLZMj92oviOkte0zOy0TiXjGNr622iI3mc+JcrXK6c+dxnkq+1xeSvHcVrcTJXulzK1QgwSiyelo/JfFRuJ7vuwJrDL2lBYQUjrkxk8ZXmEJz2Q6SpTP6RY4x0twC1+Szk6h/pBHxbx7q1YMb8CUNvuDfl8IDgKZLJcy1VnEoCcsyW5FEGn7qBJNNPm5iqsPNcoyIqhaaorg/uaXOFM5kPJq0ElPYGAuSiC0IPPilaMPm3KAb8bwhOnvAMe5XrMXZjQaB3V0bPQF5+T3yaiuo2O8jl1SxGE7bHMI8CCnrPIiL7hzNdT9simmb83Vp7L5xapdXjby9mGYV3qoTdAlmAzcAE9pT2oU6NONO593eh9bGj75JAntt7wHeC68fmt0Gw/bH7aGneRR9d+nuyajz5+kDL+4Y5+vy8Wa3LX+0LUmI8VCzkOkZOsNS3ix/hoAFn5vHVCWfp2APjk6NEUMLn8AMDf72r/xLiqii8CwezhjqMxy2jyxzKCgGbaoLuNo1CGe6m3DSkpJqNwMbqsah9Ov4gTIXbfUz2Mbw6LQQUE8opB9io4RqjqSteussRLo+gPsgbd5KvRyBtoS4Na+xzYi9uA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39850400004)(396003)(136003)(366004)(451199015)(41300700001)(8936002)(66476007)(4326008)(5660300002)(66946007)(66556008)(8676002)(6916009)(316002)(2906002)(6506007)(6512007)(55236004)(186003)(26005)(38100700002)(6666004)(36756003)(83380400001)(1076003)(2616005)(6486002)(478600001)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DzkWGmcFq5tqsAUfN5p8Z5IrvfdPAJStfJ/fx1HuroK+bH6PKt6K/lTrxtK?=
 =?us-ascii?Q?OURqx16FgM9kBSgUwniY3/5E1Ex0kJ35r7teFSKbPvxblsvBlPKLVEQPhc0C?=
 =?us-ascii?Q?BFwlcaBWCxPKYaJKWOmkiHRDlNmocgZuj2t+KvyXx9Ue+bSFAZ13XKhLqoRT?=
 =?us-ascii?Q?HndyS/GXrnHqB06OMyABN06W+YpD4KESPSOEMqoA3lTdFm9r1F/l8Vxe0GcX?=
 =?us-ascii?Q?J5EKAZpM7VjVPUIid4ZdqmUNN1+1Rk3A/Z2bevV7/Qcx32Dfki3vjSdLVr7S?=
 =?us-ascii?Q?wIlg7YoH3bE2PX28vuHlcV0n9fmabmxIOJcJtCCGxyJiOU5ohZpmTuiXGlAh?=
 =?us-ascii?Q?zEOHh9nh7S/IEURakCBxrO94izmiAGbqvnIK0v7zXcGpJWwg7MMyT7adlJOK?=
 =?us-ascii?Q?ddENl+H8BsbJ0iibRXay7Zemuw5ooSVH/a6+56dpsP9mA2i8a0Df6qn57Yub?=
 =?us-ascii?Q?xS6J8WgaTsWGJtcN2JrGLz75aXbYxKORQB1WAkc2K/UFtdNmmclOd4wUt1EH?=
 =?us-ascii?Q?WWQuXDCCC0KD8aYNrUJhhCfWHxUaQx/+P00aLK5fgQK8kMPAFXsMmW0Php8Y?=
 =?us-ascii?Q?gOIl5VnhnLNyM7cWZLF8YkaKau4KfIQj3V7hKSIMMujgtV9Tn/LKFTaOoOn5?=
 =?us-ascii?Q?O19FQ4jyCcBgMN/XH3worLbT6zN4lwU8yOqT+1+hdsmLPj5D1dBlehhVRq2x?=
 =?us-ascii?Q?CAi1hocHUaEzWufv4u3icuTzkiAbuudDHMOURoNK4OPH1POsrZ0QTOmNzgg3?=
 =?us-ascii?Q?QtxB6nio2CYLxNJNq/jI0RcavaXJYmrNA3HdFtxUKchtyzkq9KF49T70x8+k?=
 =?us-ascii?Q?jA6yJ+nrNingM/3C0eNtvQN+Q4W/JZDdrHaHGsQI+/S69Xdqq7F3AcKLacXB?=
 =?us-ascii?Q?hFc3S5GuSHuGLxWOcZK8RIvXYLL+uaoBF9zhDRmMcyaDc92Ge2511gaD6DiN?=
 =?us-ascii?Q?05xKVmiOlGvvc1IZiTD7X3GsTbj2xfq5QrTb+gVSPOAaG9rhfOrnpa1UWQiX?=
 =?us-ascii?Q?PWZh+Tg+amg1flVkrajoVGT/RsVjNThSk85n/xkPr5MTURlMNApOYmv/h31C?=
 =?us-ascii?Q?R7qv4I2Tfs2y6+llGyosEBLiNf+2Z3M7RpLdJmV45BCoWGDWDwa1OJLXfgbZ?=
 =?us-ascii?Q?veW8g6K4S0ngibeo2iP50lcQyK8dKCyCvTkH/iIUj/uRscLNMvFnYhoxENJp?=
 =?us-ascii?Q?UPvT4t2pmbMYpWFx1x/Wl12+7nm+PzCsoa0v9FKdsxkTaJUs0IaTrJ1DuVAt?=
 =?us-ascii?Q?H0YFo34yMYD/qxC+6cskkVvB3SMlK5ZI4tfGSIy/cUZQT2TkCIfZrRCLyBWi?=
 =?us-ascii?Q?oytdVdE3iPKYNf2aV/czyXD4iYfaIRAoFRZhwb1A9rZaQ4yh0emamS+GQ9YL?=
 =?us-ascii?Q?yBC9TD/6zO2olEfldauGIGBs5XTNjqDrR5FC1VvhV6dmIbMbU1+tHIxB2a17?=
 =?us-ascii?Q?RDJmZt9uGNCWygMSZs0EBwBp7ZsV5WXilfDSc1G/4CZY16n2Np6ZVjbzRu0L?=
 =?us-ascii?Q?0PnfAU5TT/8oiwlwhjSnyBehrUN2Oeo/pKg0zNeUY8Z2M1jfq0rofNtdDq9x?=
 =?us-ascii?Q?euEqP+NIYtafCnQK5Xg=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e886e1c0-da48-4599-dbf1-08dae1c1c2a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 13:05:54.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kLXAlGqs0F9jraIOEqs+R3FqZXjXEK8fouL7S6K7Uqvrdy5eRlLtM/7KCt2KhsM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6613
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When cloning multiply-claimed blocks for an inode,
clone_file() uses ext2fs_block_iterate3() to iterate
every block calling clone_file_block().
clone_file_block() calls check_if_fs_cluster(), even
the block is not on the block_dup_map, which could take
a long time on a large device.

Only check if it's metadata block when we need to clone
it.

Test block_metadata_map in check_if_fs_block()
and check_if_fs_cluster(), so we don't need to go over
each bg every time. The metadata blocks are already
marked in the bitmap.

Before this patch on a 500TB device with 3 files having
3 multiply-claimed blocks between them, pass1b is stuck
for more than 48 hours without progressing,
before e2fsck was terminated.
After this patch pass1b could finish in 180 seconds.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 e2fsck/pass1b.c             | 73 ++++++-------------------------------
 tests/f_dup_resize/expect.1 |  3 +-
 2 files changed, 13 insertions(+), 63 deletions(-)

diff --git a/e2fsck/pass1b.c b/e2fsck/pass1b.c
index 92c746c1d..950af5be0 100644
--- a/e2fsck/pass1b.c
+++ b/e2fsck/pass1b.c
@@ -90,7 +90,7 @@ static void delete_file(e2fsck_t ctx, ext2_ino_t ino,
 			struct dup_inode *dp, char *block_buf);
 static errcode_t clone_file(e2fsck_t ctx, ext2_ino_t ino,
 			    struct dup_inode *dp, char* block_buf);
-static int check_if_fs_block(e2fsck_t ctx, blk64_t test_block);
+static int check_if_fs_block(e2fsck_t ctx, blk64_t block);
 static int check_if_fs_cluster(e2fsck_t ctx, blk64_t cluster);
 
 static void pass1b(e2fsck_t ctx, char *block_buf);
@@ -815,8 +815,6 @@ static int clone_file_block(ext2_filsys fs,
 		should_write = 0;
 
 	c = EXT2FS_B2C(fs, blockcnt);
-	if (check_if_fs_cluster(ctx, EXT2FS_B2C(fs, *block_nr)))
-		is_meta = 1;
 
 	if (c == cs->dup_cluster && cs->alloc_block) {
 		new_block = cs->alloc_block;
@@ -894,6 +892,8 @@ cluster_alloc_ok:
 				return BLOCK_ABORT;
 			}
 		}
+		if (check_if_fs_cluster(ctx, EXT2FS_B2C(fs, *block_nr)))
+			is_meta = 1;
 		cs->save_dup_cluster = (is_meta ? NULL : p);
 		cs->save_blocknr = *block_nr;
 		*block_nr = new_block;
@@ -1021,37 +1021,9 @@ errout:
  * This routine returns 1 if a block overlaps with one of the superblocks,
  * group descriptors, inode bitmaps, or block bitmaps.
  */
-static int check_if_fs_block(e2fsck_t ctx, blk64_t test_block)
+static int check_if_fs_block(e2fsck_t ctx, blk64_t block)
 {
-	ext2_filsys fs = ctx->fs;
-	blk64_t	first_block;
-	dgrp_t	i;
-
-	first_block = fs->super->s_first_data_block;
-	for (i = 0; i < fs->group_desc_count; i++) {
-
-		/* Check superblocks/block group descriptors */
-		if (ext2fs_bg_has_super(fs, i)) {
-			if (test_block >= first_block &&
-			    (test_block <= first_block + fs->desc_blocks))
-				return 1;
-		}
-
-		/* Check the inode table */
-		if ((ext2fs_inode_table_loc(fs, i)) &&
-		    (test_block >= ext2fs_inode_table_loc(fs, i)) &&
-		    (test_block < (ext2fs_inode_table_loc(fs, i) +
-				   fs->inode_blocks_per_group)))
-			return 1;
-
-		/* Check the bitmap blocks */
-		if ((test_block == ext2fs_block_bitmap_loc(fs, i)) ||
-		    (test_block == ext2fs_inode_bitmap_loc(fs, i)))
-			return 1;
-
-		first_block += fs->super->s_blocks_per_group;
-	}
-	return 0;
+	return ext2fs_test_block_bitmap2(ctx->block_metadata_map, block);
 }
 
 /*
@@ -1061,37 +1033,14 @@ static int check_if_fs_block(e2fsck_t ctx, blk64_t test_block)
 static int check_if_fs_cluster(e2fsck_t ctx, blk64_t cluster)
 {
 	ext2_filsys fs = ctx->fs;
-	blk64_t	first_block;
-	dgrp_t	i;
-
-	first_block = fs->super->s_first_data_block;
-	for (i = 0; i < fs->group_desc_count; i++) {
-
-		/* Check superblocks/block group descriptors */
-		if (ext2fs_bg_has_super(fs, i)) {
-			if (cluster >= EXT2FS_B2C(fs, first_block) &&
-			    (cluster <= EXT2FS_B2C(fs, first_block +
-						   fs->desc_blocks)))
-				return 1;
-		}
+	blk64_t	block = EXT2FS_C2B(fs, cluster);
+	int i;
 
-		/* Check the inode table */
-		if ((ext2fs_inode_table_loc(fs, i)) &&
-		    (cluster >= EXT2FS_B2C(fs,
-					   ext2fs_inode_table_loc(fs, i))) &&
-		    (cluster <= EXT2FS_B2C(fs,
-					   ext2fs_inode_table_loc(fs, i) +
-					   fs->inode_blocks_per_group - 1)))
+	for (i = 0; i < EXT2FS_CLUSTER_RATIO(fs); i++) {
+		if (ext2fs_test_block_bitmap2(ctx->block_metadata_map,
+					      block + i))
 			return 1;
-
-		/* Check the bitmap blocks */
-		if ((cluster == EXT2FS_B2C(fs,
-					   ext2fs_block_bitmap_loc(fs, i))) ||
-		    (cluster == EXT2FS_B2C(fs,
-					   ext2fs_inode_bitmap_loc(fs, i))))
-			return 1;
-
-		first_block += fs->super->s_blocks_per_group;
 	}
+
 	return 0;
 }
diff --git a/tests/f_dup_resize/expect.1 b/tests/f_dup_resize/expect.1
index e0d869795..8a2764d32 100644
--- a/tests/f_dup_resize/expect.1
+++ b/tests/f_dup_resize/expect.1
@@ -11,7 +11,8 @@ Pass 1D: Reconciling multiply-claimed blocks
 (There are 1 inodes containing multiply-claimed blocks.)
 
 File /debugfs (inode #12, mod time Mon Apr 11 00:00:00 2005) 
-  has 4 multiply-claimed block(s), shared with 1 file(s):
+  has 4 multiply-claimed block(s), shared with 2 file(s):
+	<filesystem metadata>
 	<The group descriptor inode> (inode #7, mod time Mon Apr 11 06:13:20 2005)
 Clone multiply-claimed blocks? yes
 
-- 
2.37.3

