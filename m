Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E927768426
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Jul 2023 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjG3HZ1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Jul 2023 03:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG3HZ0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Jul 2023 03:25:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2084.outbound.protection.outlook.com [40.92.98.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147FD1703
        for <linux-ext4@vger.kernel.org>; Sun, 30 Jul 2023 00:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ytntv5R2Qs4jEIWZmtElUPxgExyhFWWZlLVltfrdgMOCOxIqI3lOzSxP2me2gbPDGdp7Qchfl9wqjHgNfSD3pqtl24rkJEzEObxBylt2yTU1OOT8KNiVUU7/xe6zV+EN51bT72i2QeyUwK3rW0eB7pKJuX7BT//frShpBZQv9g+KL0Niu8URGEc7FbBD2IMO6kg6EIHbYYHa5VRI3lfwAzY7FFw1aaT3Jxp2/0JBVGM3QyyTqTlKz233dkpGGeDqATYBeHjzp7l8JuLS7xdG+fbYJOen/2Wt503GNqU5rcBETE6yefjj8FW1cpG6DopFCE4/6khV5LEuhFuROgRDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZn2WG2DSHG5Q34zwESr3Nie9l056M67qz1KNN5o4LE=;
 b=km8XY4V0Q/KHtQTXoxHm0pxssR5bDT0bqPKs6ZZV1B7+OVkDroExEkJYmpId5cQ8grhK1RWgDHi/AzSFED7vb40zug2Mz14PP31W1VYKXfx4V4WsML4pR18ujAsZl5Z3Ux2EeDRh0+af2wa+zjclVGW9QdbDaHudtfY7QbxrYx2jZ7jXoUGfPlDclYKc8pGf+VVU3nzd179ZGwjcl9P2JeFvCoTGKIbUcuPOnztZdiH7zaxTZjn3rtrHUD4WplSB2rxG9z4JWwWAnQ095XvA2VeBWZ3XhV4iHRmkanlJuwzePkLFgqsfl4/jgkKE7F0GH+FB9En03RNcSpGZxUTYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZn2WG2DSHG5Q34zwESr3Nie9l056M67qz1KNN5o4LE=;
 b=X34g43YSD5JNBTXEEZnZzQ8oKx8S1w4bEg0Cop4rHzBKl+qHucgH/bPV7UZJKqYC/nwTvzmZ3ZNDBEhTwgCEnpV+fBadAa/8fOX0VlGOlQigcVbcpUlzJObtEnvIlC1nEve6i/Fimjo7VMhqh7s9iu5IrXEZbe89FDVKRNSgEkQD8RI738RPjZGJtcT+YCUMK9TXgsUktumHDiDUWFIpN7qL25P1DUuzpvTxblicNEejbV2rlSZWcDvE9yF5rpo4hx+NItsiPFFXy3BGQiYWTXYvLMvvyWrXPulp4uthh9ct6yS99T/WzOTxOVrOYLSNKsy8zC2wvgrMgewMoMpmAQ==
Received: from OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d7::9) by
 TYTP286MB3519.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42; Sun, 30 Jul 2023 07:25:18 +0000
Received: from OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6d37:bb31:8707:ae72]) by OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6d37:bb31:8707:ae72%4]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 07:25:18 +0000
From:   Bobi Jam <bobijam@hotmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Bobi Jam <bobijam@hotmail.com>
Subject: [PATCH 2/2] mke2fs: add "-E iops" to set IOPS storage group
Date:   Sun, 30 Jul 2023 15:24:47 +0800
Message-ID: <OS3P286MB05671E90B00F727A1A40CEB0AF04A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [RBmz7g+AA41BcESwWjuKGzAzTtyyTCgT]
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:d7::9)
X-Microsoft-Original-Message-ID: <20230730072447.2458-1-bobijam@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0567:EE_|TYTP286MB3519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f65c541-8a06-4444-cdd6-08db90ce1ffc
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmprXCmKzjWdGe9VkZ3ogWermaGStHppspFiczDDg4z8JRhoWGDyaE2/NH9obomwlBkU5q7ozRFXfI56C5fhyUhJ0XvKDeV2Ep05Yw/rCe0wTv3sf8coAAZS49t4WYhJgOabEZj9KflA4oE2mxFoETHvSGYebVw7zH5AbMHM8K35HQis5V1sxqUAFZn9LYRo08C1LxVPM/ukv8gbB2x0tf/6zIlYKn103BKOKk4DgsdPEJhOer+vy37fEeInPOLxEJLGXUvfOeGChWTAftnlgHRDrBQ0NQF3VXnVqzjoTqgdwJNn+GS0GsOY3Z7ig52lDhSsCSV8fIDMggNjJZ/+qVmGGQFK0a1SIxhPnBVLCcwy+1UerVi1ZLbqMRfIq7izGobAU8liswY82gmaYLi9SjRrPKLzN1bUkqR2KxPJ0jHJWRivjWjpxqbg5bnH5K9h8RehEk22iC0ax0UwPI/vXHbFiBcWIKlRwtPteDpmxJCZG7a1eDNrSFEZTxuykrgPMP80AbzZ5Y8ZnkW5xwA02FAW+HMqvFIAF9VITlR7ndYwflLCzElkBMuahITs115LpfdVfQtauXMBklL84x+DLrXbzzdy3VbxC2au0R+M2n+yr++tuiKiS9V94EQbwos2Hm1UpVLJGdFJPKkWoCC10mhCk4p+V0R/Z0LCp42jky/Ej7mSZrR/X5xwQ35bQA5ntJrcAgu2Iv5prSmSZUEG6hBtUQRwRfUzNngXA8rlu8U6vpmHacWhct+/GP6BKPljO90=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3aV/IJDI8yzVacsblMkdwaxzRvdpzLQ6OyL6qAUtbMi5yXu6WzQKIt8Uftkx8n+NhO2BwvO3mDYVRlCGuYqa8rl5B6vQKuKw9XYQYl3IFJvsZYkiONf/vCp3nxBDDT/HtZnuv/U+9zNZELeB6ebCw7ochjp/xBWEmTrBXUZ141E6RWPfLXDJUtJkxRgjMvnh0eyjGf9dwKhXTBhr5vDufSKJvxAET3g2wn9XgTlloJ8kOTPilfvWmCtEwG7HlLiRYNk8YSfJwwmveFoohN8BoQI6J+xhbabig5eYIIh1VYuE0f/lrJ7ka9YIQ783cptoI1h7TTkKfxBm+V5AP6qngM7Idc1hlO77K1Qw5wIJyI5OQRMHSIj4NLtADKCo+5l6QN+YK8Kl6RWpj+6tdn1nx2axCGwe5l8ZFBfVfuguq42rn+eepZZYrms3AndCkqCe373u8pMHqb8fY/bGFgVlg9Q2hPbVsjRLuv6VBjJ10VCZnapPBlNnzLTDqzwwF/266UnMSfpxpfIwFRMFvIxd5aj5ujFue3lmSCS77GVwO12W12sNCDIrdDrzAj5scvfFi2v9hr4JzKUr/vhMiqt2kjqSHTGEKD3FATJsdpyBCJ4aEf0rMNTz7Q9w9RnEyRm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H1A1mWtE6G8v49GUSVP9YyjnTBcg4umuI30DoGo0T1r+o0J/b4i44C2EwHtl?=
 =?us-ascii?Q?8FZkHUB1fcoF4E6dl3C0HQw9QVDva3AQZQ4cSdv8NM4zDzAsPxOVPuvf4i2/?=
 =?us-ascii?Q?FHRFW01cJ4wAK25esYtjyDZb+ehl0N91sc38oFYYJwUhQAYJatvGWNegj+Mn?=
 =?us-ascii?Q?pGdRhrh066IV2ZMEdtBIw739NguXz9+jnPQNTg5lgyJJ1yz0F/vmuqCMBGtL?=
 =?us-ascii?Q?bvOYc1/ebogUufe5qnOpZ1nd9FVnRYxx62IpZZx61b0UOmaZ1qR8+XjhCUAV?=
 =?us-ascii?Q?kU3a3U5hB5DUYp/Fkb3AkF6LChk9EFlvDOVTcdzU2oLmKlqakxsg1euhtZgp?=
 =?us-ascii?Q?f2XiL7VPZ+gOfyum+oaEtqX3UneYiIxjLtew/qHd8O+awvWmE5XfiHXefyLR?=
 =?us-ascii?Q?L/nqqZ/ym8y9ikmWyukdWBREBZSLklmAMhIHukBdihZp9J5/1lVOKTu+Bl4b?=
 =?us-ascii?Q?GX+c5KaX9KfCucFmHctmkzUFl4WVXYuHK4Bu1cnXkK8I3s0/ZDQr6oI164RR?=
 =?us-ascii?Q?6pvVIAG7jLaBzqfexOOL6REuuVF6arsO2PrYyaEVWKQyBmkUDPxJ5mOccWFk?=
 =?us-ascii?Q?8eApaBCKhiEr4NGtOrRXAZaJ4IM1jP9DW1N0W2oO1AlagpZL+TITWvcbnWDc?=
 =?us-ascii?Q?2HCNS1PjB+aZhTOHQt8/cJbTTcJQH8wtddrrebx7v0G3F0g4ZT7B3/qLsZrk?=
 =?us-ascii?Q?SuthASJoW7vTjXawdFmI2kLQjNJgy0vVB/5yTVHX6QlIvti9oVv8oTn3bVJz?=
 =?us-ascii?Q?+idW4F0Q4fpNsGC86LnXTgKHHgH0qPf1ia+guhc8ms2RHuga+9u9lXafxDGC?=
 =?us-ascii?Q?bjASe3uFki6VvIiObXydNsP5itEagEXnRNE4wsLmR63nSmKerCI53G49SyzR?=
 =?us-ascii?Q?FwUzoo6a1Gpr7QhVWDFQ5syTMY8Y3KG881o8G3IIa9hNtr6fx0IMI/fsPPvK?=
 =?us-ascii?Q?5atW/avuagivcY11/NGJlB9a/c9iz7CkYZS8sUba4x0z1/JKzZm7F3tD2f/D?=
 =?us-ascii?Q?QjUVPGfdr1hiwsbvzePGQCxY52d4D2bRKgDBmXV7rmHyaFq9IsgDiC+QulOQ?=
 =?us-ascii?Q?D+GLYt0a0d31BxCPvBkHlabQcKHrTEV5qu7KJ+dGpc0V7Z0j8Vi9UQvluT9Y?=
 =?us-ascii?Q?RjVs+9+sFOHwpGgENhfX7BM5EexMX+JnfTLOJK0mhy2SXsJijqJNxHAdku0p?=
 =?us-ascii?Q?Bxo4mXf4CpcE8CSfQYQowh0Zeho5Gbqdo8gmqA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f65c541-8a06-4444-cdd6-08db90ce1ffc
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 07:25:18.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Bobi Jam <bobijam@hotmail.com>
---
 debugfs/debugfs.c    |   2 +
 lib/e2p/ls.c         |   4 ++
 lib/ext2fs/ext2_fs.h |   2 +
 misc/dumpe2fs.c      |   2 +
 misc/mke2fs.8.in     |   8 +++
 misc/mke2fs.c        | 144 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 162 insertions(+)

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
index c69efe39..61803828 100644
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
@@ -2973,6 +3084,29 @@ try_user:
 	return 0;
 }
 
+static void ext2fs_set_iops_group(ext2_filsys fs, blk64_t *array, int count)
+{
+	int i;
+	dgrp_t j, start, end;
+
+	if (!array || !count)
+		return;
+
+	for (i = 0; i < count; i += 2) {
+		start = ext2fs_div64_ceil(ext2fs_div64_ceil(array[i],
+							    fs->blocksize),
+					  EXT2_BLOCKS_PER_GROUP(fs->super));
+		end = ext2fs_div64_ceil(ext2fs_div64_ceil(array[i + 1],
+							  fs->blocksize),
+					EXT2_BLOCKS_PER_GROUP(fs->super));
+
+		for (j = start; j < end; j++) {
+			ext2fs_bg_flags_set(fs, j, EXT2_BG_IOPS);
+			ext2fs_group_desc_csum_set(fs, j);
+		}
+	}
+}
+
 int main (int argc, char *argv[])
 {
 	errcode_t	retval = 0;
@@ -3054,6 +3188,16 @@ int main (int argc, char *argv[])
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

