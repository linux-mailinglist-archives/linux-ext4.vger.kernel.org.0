Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD78766659
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jul 2023 10:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjG1IG1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jul 2023 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjG1IGA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jul 2023 04:06:00 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2066.outbound.protection.outlook.com [40.92.98.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507844C0F
        for <linux-ext4@vger.kernel.org>; Fri, 28 Jul 2023 01:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdmqYvYCANyphtixMfWotADosN7x7obdnV6SqFeJ5vayuD1Qrii3HosP5jZImqvedaTxPRrEYCbn0zWxMX5stMTGsCJJ4RyeI9zgXdQxb9dy7BG85ewZE8VlNzE0bWkyhQ2BupQaHkZLfkG4HJYWXy3zA2w95NLBwBgcq10+3Vphde7E7RK0MqfIxLH5Voij3QbD8cl/s8jreaB90aXG/myeIdiieytVzhZmlJs+u1uro828g37Qk927HYwYsgajSAXzbGe8p7Y6EYln60CDIBtnehI8KYrCAdKoZR8LoYs4wZn9LUiceCxfghCsUMGUjt1hy7Esx5GEjU7nyYVK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKgXeH2bl93nkvUYvStGtcqpBrITdpA8k3LS1lmGetU=;
 b=N6rg2YYyRvoRBLu1c4Io3NlKOOHqQY5yQMMlPZKfFzhHFByYj1QI3Il6MBHhxq7xSRNl3aWFqnop6Y7lsI5g94qlDIuzfkVZ6SBX7by/nePTFsPdyUSQ6Iv6AxoXJWke2IdPPQW4RrA5Enyp33PJ9tmyErPRgAwXcBTvvyMbgIWRzPKIjDw1/agKcXsnDi7sqThkR9/7cpyBCKOoPElOVChPXGExdddFjs3k9NDDMlZ4SVqwNdg31VtV/qfDjB8725R9URHzooMHK2InTTFznb9oi7jiZb1wnr5sAwiKXM9eKaio9mr86JNoD4JYGTXsnbOeSZOuS9YAlCXzRkdxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKgXeH2bl93nkvUYvStGtcqpBrITdpA8k3LS1lmGetU=;
 b=LjTRFdAC62qFyqqwE3Yv9remryHT9riLmrnZBCo3ADMLqBflhXmMLb4U6iefy6RcTiIKh3voS3mw7Q2UQdMkMIf/rxDBbmarl21QwzYHpgyU6qyBb/GOcX6H3gwQ0eNO78937UMvtZhEIKgvkzdwQ3DGe/xWGIBN4z5fUG/O04eeNkX+9Dka5BEOAmR2XqzEVyqo5IegjgS/f+7DMHgMfLcjP6f9YUgHx7r8aAV/p90sTvEtcjO6AhMDt3K4JAIvFnB7NjXA4GFRQT/t+v32YLTc/FGbOusVVScQ1ixqYGk5Q8mDL+q1y/GWo2tKgRKuCZSP+nAfomYxdnOy9ilXPA==
Received: from OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d7::9) by
 TYWP286MB2154.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:175::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 08:04:51 +0000
Received: from OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6d37:bb31:8707:ae72]) by OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6d37:bb31:8707:ae72%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:04:51 +0000
From:   Bobi Jam <bobijam@hotmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Bobi Jam <bobijam@hotmail.com>
Subject: [PATCH 2/2] mke2fs: add "-E iops" to set IOPS storage group
Date:   Fri, 28 Jul 2023 07:47:03 +0800
Message-ID: <OS3P286MB05671A52A5472EFBDFE78FF2AF06A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MxIbltF6bTqk433ZqXy1V7fW6NyRxGcC]
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:d7::9)
X-Microsoft-Original-Message-ID: <20230727234703.223305-1-bobijam@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0567:EE_|TYWP286MB2154:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c239cc-dc30-4c18-86e3-08db8f41519b
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmoyETMvEuKw1oXBqTEVl4vtL1X7FRfdBlTrzQgAYnUM/6NEDWsJiqXvCw8ApBVOBCsHidKxInFu665xzb9iNavgIHeZuvNs3KRl9uLkjSs/84FZO60oAF3XKulaZ9CpNedDXvcFVHe9vbvH7rlmI+q8+01EcNnIuHvEH3KzygU43EMzYxgYbSN1JA2rsuyj6BsftnGzFX4/HaMSoUsgrOOzCeod0ve6oOXHc/ZMVy6qUh+GDv+cGJmNuplWeGKwdGy08pfNG0jQd0KDIMnZk91bUXZFxbf9KhMFERuMpDEk7aYWbskU4wxl4mdgdlUT4/k0X0QodqYn330/NUSDjrMjDq1TXCJofm4BMQASgez8nDgO/827e8ytrFlqDroHFCzGoJbX53FVNA7PZw+E6Qn71crmkq9F2IjticClCMBDlu5rrrSMEg+1mmNbRdMTzq1j8J1t/yQCXsB/WSpD8rnt3WIWEuQhNpc7faISLKdzzP+SgutgxaunIB5gm6e0q+GHp1ddf+FxMsm3Bd/3dTjrDE/144P0vVO1sqSLOeqKiTMSQTMGe2VwKAAG9SSnaCJ+kThCy2v3179T3jquRg/PUVxgQ7rOXNAhF4up/NqQ6iBwPQAIuJDHHh1XfLBueuAtEeKv4LLQUUkkSF9dfqKy92j7SPKiNKHJ7EDYUDxQj4iNVYAAczaqL8+m8mcfWeY9UAU84SA3O6ZB8D/zBvAsM8UwC8rMRt/OS7WLaRQLCsgJwyFudqvMW8+/jeDIiNk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1Dg0Qc3tkhgFPEPj0y+IECmbfg3E/xCAISWoxXNeEY/X6aF8dZZSUy3fLRzPupTcTh9pGC2agAjRCOOiKgMH1h8x5th+2kUP1Z3Ek4g0WC+7oEFTvfbU5Gsw/WhVWes3wQk8LXJ7ETEkozQ+gnwO2/ILWr6grFpHkmnHavdXmEaHpDyMj/bDtE2dxa6bZOsuGohd6ViVH1ufnCEwK2zEPvHL9UIgfl9lMILgfn2161bx7ZC9T9rc2wd8TxI48u2nwIlp63vYf5posUUBvRTCRAhUjO84uleWo0LUQJaHe1WQSpHY2CiRuN9GK3NNp9hR8GBLMCeHpNfD7mkuID4JByoY5tf4xsMYAUoMsa064nYg9yh8AexuPPmilE6/uJqu24UVlmZ8jQvFqt0tF6ZlhdZpfT4Qf/hvLcROXl0CcjgxZTjIOGP7JSf1dIMkByt5r/Rx1ttG6Q7go9mpKKX5Pmb9DSJkc6DUM+jUUKnx4yoxpevbCWT9h76uWyz2b4qysR4aWVjOfujlDBzbQ8/Wafy+g8q7X+Gro48qoLTbiRUoQ2Ng1FpFvqa542lk8z/sX9kmfbYMOelPog4mUhg4LuSTqtn7tySUhCGxTdU0JCkdlXUZT2YZRL0s+npMPnl
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RBcutXwjsaf1udOKAhrSfd+PgrfP8cler7ms6uUSwA/zpfuoBnAWWD5AJpaM?=
 =?us-ascii?Q?8s6YYU4lPSIinqozUVOG7CZFOE9HV03Mi3Me49dF+dhCXsD5IKoaq4eT15SJ?=
 =?us-ascii?Q?nPgqZ3xhMKQW0OwgqnThe/uH/CFrInHu7re7f9Ehj+Xx2SFAKl0/OW7UNVQh?=
 =?us-ascii?Q?D3FIdkeuSWkFgSSvQIYVKEJUj32vWruUi9DfuW3afUGS7YKSqjWObj4U0qSr?=
 =?us-ascii?Q?XyttAG+jHIlQPGWaW22AeHbe8ZQYmPfncJxyRoMQJ8NNw864MmJ+51iLIYa9?=
 =?us-ascii?Q?EggRsLbqnUFd9MEQABIvGfbAm+W7fr6A+F/rSf4ZThktuhNmhPAusd8177xp?=
 =?us-ascii?Q?fALTUAjtC/XiSoVA/pnkxJU6paeEg6BZOak7Q/XlJ4/a7csuXFYrx6HkY+f+?=
 =?us-ascii?Q?KS3kr46PX39P0I6/F1GkqPhQmw0majKTntPVaeo1tpDD12JbMCPgFFmIG/2c?=
 =?us-ascii?Q?37CaF0XXpbNQZkkLrTrfC9jgcqHJcwLnh1FimnFQ8Mw/5pjvVRj2O8XmIIoV?=
 =?us-ascii?Q?crAVK7g8tazmeMIo25Vrtgb+NHzlAtsnhR6AtThi6AKuCXKKZHPs2sp5Y+Lc?=
 =?us-ascii?Q?avdITUGBibH3fdAuJMBMux7NiR3471mOSUW2qjSRF0fLl05QzefNhXV8CNB/?=
 =?us-ascii?Q?gg23OKg5vuwagr7M9nU0IcOx4vMlF5HodsEZEhyQHWTpwNw3j5zizCQYLuPb?=
 =?us-ascii?Q?x63zKwborQ8gXLW8eS665NY+zGKCPEhH23I9wqUOjg/6f/XVPNZO1DHlJA6c?=
 =?us-ascii?Q?vjF74XUw9hFhkL+QtGq2Sq9FUCEvRJhTUv4MdCtR3k3BjxU0zRQ6lBPkh2sy?=
 =?us-ascii?Q?rv+dZLgSdcOP+wcCCcL+3thVgS5SBozUDg0GTrn2hoGH5xJTt7vdUyqB73UE?=
 =?us-ascii?Q?41gfpIbKDXc6Iryytwi8+rV5+P9jGNnSRAavVsIch7aHGogE+9/+SVvzLGZY?=
 =?us-ascii?Q?6LcgsVCWis4Sm7VSGiyBVWUnW8glN0Wt+FLhw92N1kITKJ4HuImOKwNMe4zK?=
 =?us-ascii?Q?YH6atcnkdQzqkMHBPgng4TcM9Xn4Ou1huTIwoeJ6ixn/7oKInAY0A2LxnXzf?=
 =?us-ascii?Q?eNxNIxZr4j49/oc4eAglTHDouXNfppttKMp1Tg2DfthMKqK2iKgGoJhkBVsS?=
 =?us-ascii?Q?LOV65nZ1fS5Yd+uTiFsaxzbYjDz2/PBkyT/7lvz4+0UlIUlAElnGdQrW3GA1?=
 =?us-ascii?Q?nT2ntLNI2QBUp4XhIZlsc3cAkCSct5KJ8KMj2A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c239cc-dc30-4c18-86e3-08db8f41519b
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 08:04:51.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2154
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With LVM it is possible to create an LV with SSD storage at the
beginning of the LV and HDD storage at the end of the LV, and use that
to separate ext4 metadata allocations (that need small random IOs)
from data allocations (that are better suited for large sequential
IOs) depending on the type of underlying storage.  Between 0.5-1.0% of
the filesystem capacity would need to be high-IOPS storage in order to
hold all of the internal metadata.

This would improve performance for inode and other metadata access,
such as ls, find, e2fsck, and in general improve file access latency,
modification, truncate, unlink, transaction commit, etc.

For mke2fs, using the sparse_super2 and packed_meta_blocks options
places all of the static metadata (group descriptors, block/inode
bitmaps, inode tables, journal) at the start of the device in the
(IOPS) flash region.

Add an option to mark which blocks are in the IOPS region of storage
at format time:

  -E iops=0-1024G,4096-8192G

so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
group descriptors to decide which groups to allocate dynamic
filesystem metadata.

Change-Id: I13cc2820c71737848eab8a2d6e246748258a64df
Signed-off-by: Bobi Jam <bobijam@hotmail.com>
---
 debugfs/debugfs.c    |   2 +
 lib/e2p/ls.c         |   4 ++
 lib/ext2fs/ext2_fs.h |   2 +
 misc/dumpe2fs.c      |   2 +
 misc/mke2fs.8.in     |   8 +++
 misc/mke2fs.c        | 150 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 168 insertions(+)

diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 9b6321dc..81c51de1 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -515,6 +515,8 @@ void do_show_super_stats(int argc, char *argv[],
 			      &first, out);
 		print_bg_opts(current_fs, i, EXT2_BG_BLOCK_UNINIT, "Block not init",
 			      &first, out);
+		print_bg_opts(current_fs, i, EXT2_BG_IOPS, "IOPS",
+			      &first, out);
 		if (gdt_csum) {
 			fprintf(out, "%sChecksum 0x%04x",
 				first ? "           [":", ", ext2fs_bg_checksum(current_fs, i));
diff --git a/lib/e2p/ls.c b/lib/e2p/ls.c
index 0b74aea2..c13927c6 100644
--- a/lib/e2p/ls.c
+++ b/lib/e2p/ls.c
@@ -162,6 +162,10 @@ static void print_super_flags(struct ext2_super_block * s, FILE *f)
 		fputs("test_filesystem ", f);
 		flags_found++;
 	}
+	if (s->s_flags & EXT2_FLAGS_HAS_IOPS) {
+		fputs("iops ", f);
+		flags_found++;
+	}
 	if (flags_found)
 		fputs("\n", f);
 	else
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index fb69e964..ea26d356 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -223,6 +223,7 @@ struct ext4_group_desc
 #define EXT2_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not initialized */
 #define EXT2_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not initialized */
 #define EXT2_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
+#define EXT2_BG_IOPS		0x0010 /* In IOPS/fast storage */
 
 /*
  * Data structures used by the directory indexing feature
@@ -572,6 +573,7 @@ struct ext2_inode *EXT2_INODE(struct ext2_inode_large *large_inode)
 #define EXT2_FLAGS_IS_SNAPSHOT		0x0010	/* This is a snapshot image */
 #define EXT2_FLAGS_FIX_SNAPSHOT		0x0020	/* Snapshot inodes corrupted */
 #define EXT2_FLAGS_FIX_EXCLUDE		0x0040	/* Exclude bitmaps corrupted */
+#define EXT2_FLAGS_HAS_IOPS		0x0080	/* has IOPS storage */
 
 /*
  * Mount flags
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index 7c080ed9..c6e43d3a 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -131,6 +131,8 @@ static void print_bg_opts(ext2_filsys fs, dgrp_t i)
  		     &first);
 	print_bg_opt(bg_flags, EXT2_BG_INODE_ZEROED, "ITABLE_ZEROED",
  		     &first);
+	print_bg_opt(bg_flags, EXT2_BG_IOPS, "IOPS",
+		     &first);
 	if (!first)
 		fputc(']', stdout);
 	fputc('\n', stdout);
diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index 30f97bb5..2d1bc829 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -435,6 +435,14 @@ effect only if the
 feature is set.   The default quota types to be initialized if this
 option is not specified is both user and group quotas.  If the project
 feature is enabled that project quotas will be initialized as well.
+.TP
+.BI iops= <size_range>[:<size_range>][...]
+Specify IOPS block group size range like:
+.B iops=0-1024G:4096-8192G
+So the file system can get the knowledge that which block groups to be accessed
+are on a relatively faster storage and allow the kernel block allocator to
+optimize metadata allocations onto high-IOPS storage for a hybrid flash/HDD
+devices for better performance.
 .RE
 .TP
 .B \-F
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index c69efe39..ccfcf3d1 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -103,6 +103,10 @@ static __u64	offset;
 static blk64_t journal_location = ~0LL;
 static int	proceed_delay = -1;
 static blk64_t	dev_size;
+blk64_t		iops_array[64];
+unsigned int	iops_size = sizeof(iops_array);
+unsigned int	iops_count = 0;
+blk64_t		*iops_range = iops_array;
 
 static struct ext2_super_block fs_param;
 static __u32 zero_buf[4];
@@ -742,6 +746,54 @@ static int set_os(struct ext2_super_block *sb, char *os)
 	return 1;
 }
 
+static int parse_range(char *p_start, char *p_end, char *p_hyphen)
+{
+	blk64_t start, end;
+	blk64_t *new_array;
+
+	/**
+	 * e.g  0-1024G
+	 *      ^      ^
+	 *      |      |
+	 *   p_start  p_end
+	 */
+	end = parse_num_blocks(p_hyphen + 1, -1);
+
+	if (!isdigit(*(p_end - 1)) && isdigit(*(p_hyphen -1))) {
+		/* copy G/M/K unit to start value */
+		*p_hyphen = *(p_end - 1);
+		p_hyphen++;
+	}
+	*p_hyphen = 0;
+
+	start = parse_num_blocks(p_start, -1);
+
+	/* add to iops_range */
+	if (iops_count == iops_size) {
+		iops_size <<= 1;
+		if (iops_size == 0) {
+			iops_size = iops_count;
+			return -E2BIG;
+		}
+		if (iops_range == iops_array)
+			new_array = malloc(iops_size * sizeof(blk64_t));
+		else
+			new_array = realloc(iops_range,
+					    iops_size * sizeof(blk64_t));
+		if (!new_array) {
+			iops_size >>= 1;
+			return -ENOMEM;
+		} else {
+			iops_range = new_array;
+		}
+	}
+
+	iops_range[iops_count++] = start;
+	iops_range[iops_count++] = end;
+
+	return 0;
+}
+
 #define PATH_SET "PATH=/sbin"
 
 static void parse_extended_opts(struct ext2_super_block *param,
@@ -1059,6 +1111,62 @@ static void parse_extended_opts(struct ext2_super_block *param,
 				r_usage++;
 				continue;
 			}
+		} else if (!strcmp(token, "iops")) {
+			char *p_colon, *p_hyphen;
+			blk64_t start, end;
+
+			/* example: iops=0-1024G:4096-8192G */
+
+			if (!arg) {
+				r_usage++;
+				badopt = token;
+				continue;
+			}
+			p_colon = strchr(arg, ':');
+			while (p_colon != NULL) {
+				*p_colon = 0;
+
+				p_hyphen = strchr(arg, '-');
+				if (p_hyphen == NULL) {
+					fprintf(stderr,
+						_("error: parse iops %s\n"),
+						arg);
+					r_usage++;
+					badopt = token;
+					break;
+				}
+
+				ret = parse_range(arg, p_colon, p_hyphen);
+				if (ret < 0) {
+					fprintf(stderr,
+						_("error: parse iops %s:%d\n"),
+						arg, ret);
+					r_usage++;
+					badopt = token;
+					break;
+				}
+
+				arg = p_colon + 1;
+				p_colon = strchr(arg, ':');
+			}
+			p_hyphen = strchr(arg, '-');
+			if (p_hyphen == NULL) {
+				fprintf(stderr,
+					_("error: parse iops %s\n"), arg);
+				r_usage++;
+				badopt = token;
+				continue;
+			}
+
+			ret = parse_range(arg, arg + strlen(arg), p_hyphen);
+			if (ret	< 0) {
+				fprintf(stderr,
+					_("error: parse iops %s:%d\n"),
+					arg, ret);
+				r_usage++;
+				badopt = token;
+				continue;
+			}
 		} else {
 			r_usage++;
 			badopt = token;
@@ -1085,10 +1193,13 @@ static void parse_extended_opts(struct ext2_super_block *param,
 			"\tnodiscard\n"
 			"\tencoding=<encoding>\n"
 			"\tencoding_flags=<flags>\n"
+			"\tiops=<iops storage size range>\n"
 			"\tquotatype=<quota type(s) to be enabled>\n"
 			"\tassume_storage_prezeroed=<0 to disable, 1 to enable>\n\n"),
 			badopt ? badopt : "");
 		free(buf);
+		if (iops_range != iops_array)
+			free(iops_range);
 		exit(1);
 	}
 	if (param->s_raid_stride &&
@@ -2973,6 +3084,35 @@ try_user:
 	return 0;
 }
 
+static int ext2fs_group_in_range(ext2_filsys fs, dgrp_t group,
+				 blk64_t *array, int count)
+{
+	int i;
+	blk64_t grp_off = group * EXT2_BLOCKS_PER_GROUP(fs->super) *
+			  fs->blocksize;
+
+	for (i = 0; i < count; i += 2) {
+		if (grp_off >= array[i] && grp_off < array[i + 1])
+			return 1;
+	}
+	return 0;
+}
+
+static void ext2fs_set_iops_group(ext2_filsys fs, blk64_t *array, int count)
+{
+	dgrp_t i;
+
+	if (!array || !count)
+		return;
+
+	for (i = 0; i < fs->group_desc_count; i++) {
+		if (ext2fs_group_in_range(fs, i, array, count)) {
+			ext2fs_bg_flags_set(fs, i, EXT2_BG_IOPS);
+			ext2fs_group_desc_csum_set(fs, i);
+		}
+	}
+}
+
 int main (int argc, char *argv[])
 {
 	errcode_t	retval = 0;
@@ -3054,6 +3194,16 @@ int main (int argc, char *argv[])
 			_("while setting up superblock"));
 		exit(1);
 	}
+
+	if (iops_range && iops_count) {
+		ext2fs_set_iops_group(fs, iops_range, iops_count);
+		fs->super->s_flags |= EXT2_FLAGS_HAS_IOPS;
+		ext2fs_mark_super_dirty(fs);
+
+		if (iops_range != iops_array)
+			free(iops_range);
+	}
+
 	fs->progress_ops = &ext2fs_numeric_progress_ops;
 
 	/* Set the error behavior */
-- 
2.41.0

