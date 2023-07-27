Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B1176664C
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jul 2023 10:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjG1IEy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jul 2023 04:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjG1IEP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jul 2023 04:04:15 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2093.outbound.protection.outlook.com [40.92.98.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126C31BD9
        for <linux-ext4@vger.kernel.org>; Fri, 28 Jul 2023 01:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxvHY0+rgFDkCle1CxeqQ1irLttVEniNpqkevEADCnZijNAWFn4F7s3BQrIMLESrCVKRblRluBEXAgr94vPyYfhz5ljWEIZl3Afjy7kmlpS7BFDZ2uN03dQ0wOOWr8Lf+AbZhohGTs4r+n6wdN/FO9xdfxYZSuEyqKwnG2VBcsiPgAH0AQ4ZgJVhts2vaePemMuWn3ka+PDa3gCXv5YVFoTZPAtYpcmt71ZYinrGE8OeMpa2jWYos82ZDGL7orxORkWfvnCzApd097EE80GoEL7rqYB3c4wFMdyjJEdog60/dVRyHEbHqyfDvSuubRcZxR6lSQC1pE1ToXjW0qMHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGlDW+GlJvbUn0tMi6mo94mIzevKwatr+d2D2x0IBEc=;
 b=VGKsSP/8e84VUforFz5thpGlk4RkBCVmBqZjv9jsTLzN5pDz0PNP73Ggdo8/5osST9erdIBsQxFsU3Q1QcS4O1Z2QYBswPIvwEFBWfRHMMswnLyDLV2PTLVKS0zEkmnSaYgoH6cUVqKIyWKm/nL9z7GVtctnMZpcvcUxo3RetLZvLkGvPDnaUPB54j4uVEyMdfnEqBKuf2MDRi13E7hCKlZXIYqnZs5QrPyUWbLligQaJZSKQCQ1I+iAAiMpgqb1fgtCIgS25S+asr/c7jyH+3l3QhAwQ0fy9KOz9vB+Y3qYbrcR+OtH/7a0Q7ZFSF9A4UlHzF+CWiZEuAmXEGwjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGlDW+GlJvbUn0tMi6mo94mIzevKwatr+d2D2x0IBEc=;
 b=gZiZMIVb3/fQt/puc45F8rolBCT7YdDFFYaoKPQvGZeGgFsmHKzOvO0GybUEmzUUa8Bo3zHR2/ItntDRmQ4r5rla320aPBE1+Qiz1RrD6XH6SSovS3zQK1fvHvOxxIP8UlUAhWwpi819/2GYGlJBPUrjHrpR/dmZOwx2NP+LtpOVyB9hK3rWpICpRou/sCUgNlvBrXa8vsZaEfQSxJ5SX9CAjFut3YNblH6NN0Ll6DmOrnKZbSb1npkR6U3YBTqY3Wxupxz9bahUG6EZ6VIbzMqXd3xiuJdVD+J2Z5NcZb8RT/F2MQrdvjxz9zfOiWXkrkJozXxS8YEH7skXLOpY9g==
Received: from OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d7::9) by
 TYWP286MB2154.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:175::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 08:03:45 +0000
Received: from OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6d37:bb31:8707:ae72]) by OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6d37:bb31:8707:ae72%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:03:45 +0000
From:   Bobi Jam <bobijam@hotmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Bobi Jam <bobijam@hotmail.com>
Subject: [PATCH 1/2] ext4: optimize metadata allocation for hybrid LUNs
Date:   Fri, 28 Jul 2023 07:45:42 +0800
Message-ID: <OS3P286MB056789DF4EBAA7363A4346B5AF06A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [aOE79NPsQMqaA1veeLQ3aIxlI1Ubn8pF]
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:d7::9)
X-Microsoft-Original-Message-ID: <20230727234543.223293-1-bobijam@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0567:EE_|TYWP286MB2154:EE_
X-MS-Office365-Filtering-Correlation-Id: ad721cfd-7c86-4886-ce19-08db8f412a22
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKw0QULYt1QB1fu3fpWx5VZ8WuXD9q5ftQJbd2Vsd6zs57EItn5gQ9RPYNDCvrbP/uxUa8WvYOpkuUlUtDSzD6DJ4If3gr9VwSdEZ95R2dweegccDR/Fs3agLS4DdPiMmM+GLZNrUOUDd8iAz1EfHir5vbcfM+8tpHhoNT6rZCDoyJh1gkGlS6dauiJbZRmgajaqe7uu95EHvKcnmR2XXhnIzuHp5RgbHx7Z50P+hCa2Jb2obcMvCQVOGPWZKybS1yxFOIgXcdAXNkBhtBwQglSn2f0ZWxLM3Z/sF5Am8Kd2Vik7Xf4hah/6z6RLfZPI7oMb9LVRFQspfNIWTjCquIPeab2TGGmabIBSZBM6d+SbnlTDJ22KCYY8CGq+KXmzfsoh/eTMf/SJGhfIg+D0rI64dci1F7VLqCJ7rC1LnGOtgXsZ4v9m24YeC3awP5EdbRf6L2fwNzN2VH7kwnwu8j/XRkV4iEjIEKr1benWxnwuaU2NTZjnE/g0/feE8FoQs1cYFgatYST3I+xf3ciYP+F9O274bdr07LqUzVoJUqLwuGMdIXQwjusNj5OgJ9gPxXalV7nZv1ow1kyS92UZzbaLWwefakuJ2txnXuyrFQRo7qETwnGB9M4wxWyEMEb99SrJeicrSmcWUDCocL4m103AgMSXiEwp+SPu7vUQBSwGjhz1t2VwOoGj3pPtgFe1IGQTV8nV61g4xgdKxmC5W0Td+ZQ3SyUe5F8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+fpt8g8ioB8/8z6HgaXetPUCC9Xao/u01hUCbEEb1jgRbbKsPHjbC8Fy/uiphlqwCLPeDpu5BwY2j+8pPi1iPggPtJOSoghpUnFCjlqfCFqpVTW84xd2wsxgdeToBwMvJVd0c18CTeYfq04yIHxHUpUpdprcoXReqMOWOHZgjDRSM5PIJM4lqq1FbJKlPHlSRtUD5+Wc+/lvKoytrFu74r1p+r3SQlTG4M107+FfteaqeGebqiG8X0h2NQWb+AOlWyEVb5EsGcuJdhQQkXSBMVZszFJ4DdgcJPHWo8gyJsyDBvDy/mWtlRvgWplX2azssvwv105vp4JTcJ/szmJtRnpdYYT3SVnFSuAmZCk14QlSSTeSFmeZWUKEA+EELKSoFEAtMv2ZR4VHGeqAA9yOJAzVu0jlYUgjgT4N0UhtCLci+FUWQV1TYwikHQiRX8dFPJk0NF5OOMbGM0+Kw6KZnjKmOccOdzMpQlaAmNRcYxlMAdKdGMKD14/6BrLeDDk1yNufwKE69t/JvEQ1oYQidVva9JqOf/Rl8kn5i9PIyKs7LdmaHzQ9FlFwmmsaw5iaGT8JEvQ3BZKNf8I1eCZ/8IHoWnDLOTZoYuKcuutchc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eIypSBrzPXX6FsGFHdhQOOgq5q4SDgnEBltc5/KeXZv81fdk8J1A+bob1IrW?=
 =?us-ascii?Q?ijnKZKQ9J/7UVr/NMLDCs48ahvUt2O/69jK7c7P/94Wv0Z3Ay0pVGcCqfvyH?=
 =?us-ascii?Q?QIV7Oo5nC1pm3CqLkchouRT+Tyae1U3LEkvoERp8mRSMg8B/dzC75KL1JEP7?=
 =?us-ascii?Q?z3YCmOAdNmIejbNx6kuqgRB9s69X1HNxKmszVY7qhDEU1sIbfoS7UchKin30?=
 =?us-ascii?Q?lbNN9oHXXALHmOx4xtcrPnrBeujhsRMdnDE4nu0h7eJCTEf/CukdSqs2OAXi?=
 =?us-ascii?Q?IvTOz80MQ7CBKza+J2ZuWut/XLpQNqoF+FZhIGEQ3p1IYjTHoriDqYK5+QTN?=
 =?us-ascii?Q?OAb4710r1jaPxsQzb02fAfQ83CM/JaS8T4TRlG1BBVlE88gVSCyVWciHMnra?=
 =?us-ascii?Q?leiMrHBpOTRQCnz/L1KIuyl2g+3z+AefXDOnbXkDoLtMLljF6wbZ30onl/xs?=
 =?us-ascii?Q?BJRVK3ZtyC21MDi42IE8TZmn4dh/Pq2VJFQT+cmS/CS4CBAHrWQNmYjAok+P?=
 =?us-ascii?Q?YEurSSHNk2Ar5l1vH2ule8acP6s4VxtdGCuaUycgBCwr1LTxKDthcOSJsTyL?=
 =?us-ascii?Q?vIRijKyn5LKxhkzLa6gtfpis3A0hjZc1C8zydJnGT/AD/mf3mKoeRxiJLK3i?=
 =?us-ascii?Q?98tDIymAnpuR6SiDqAHTkHlS8iHUSzFkw8F/cT0QO487QHJPjQ/IchndB6Xt?=
 =?us-ascii?Q?9IQvjQUWtIrzjeWH8Qr7HAvP+/XyQVp5kHOW7svBGa4Ebkye+7l6+X20ZYAB?=
 =?us-ascii?Q?vZfjYnAogoQRAkfHAtcEzXWas5YG6mzmuF4oxoYgG+xymWx3rt3Kkjtll7dR?=
 =?us-ascii?Q?ZvV/PZoJ0uFAhavSVSiSVBDOopQqD1KbcVT+cmg6e1I0Km9sjKJ0F8q5TKUr?=
 =?us-ascii?Q?f5C5feFRlBmh2O6uJn477gVW/m1mXRNHxmLOu1yu70Vz76kuUNMCnBSOBTbR?=
 =?us-ascii?Q?22pwxWwiDCqSbUXt5OUpHNTPShcVK57tAC8UdUaDjkU+zEk38Ot/eS9kUW57?=
 =?us-ascii?Q?pkgvikzqoSce9Gg/G8MGVYoImsvrjXHPtSjfEgV/8z5mTOr6L/kufJ/u55VV?=
 =?us-ascii?Q?ZOnvtYdGZxjH/E/gbvB2T+NcgbpiaPrdvNpKOSftq2U1u8DMKJV8bE7p2v4n?=
 =?us-ascii?Q?TpApdPRPVYRfQHJKKgfQmEPCGB0yqpSJXac+EyDZkQ45N2xdRuXU4oKcw5Tf?=
 =?us-ascii?Q?aIpxK1NEBelFYYSH4c42yx74sW3DBytXg/WL/w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ad721cfd-7c86-4886-ce19-08db8f412a22
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 08:03:45.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2154
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

This patch split largest free order group lists and average fragment
size lists into other two lists for IOPS/fast storage groups, and
cr 0 / cr 1 group scanning for metadata block allocation in following
order:

cr 0 on largest free order IOPS group list
cr 1 on average fragment size IOPS group list
cr 0 on largest free order non-IOPS group list
cr 1 on average fragment size non-IOPS group list
cr >= 2 perform the linear search as before

Non-metadata block allocation does not allocate from the IOPS groups.

Add for mke2fs an option to mark which blocks are in the IOPS region
of storage at format time:

  -E iops=0-1024G,4096-8192G

so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
group descriptors to decide which groups to allocate dynamic filesystem
metadata.

Signed-off-by: Bobi Jam <bobijam@hotmail.com>
---
 fs/ext4/balloc.c  |   2 +-
 fs/ext4/ext4.h    |  12 +++++
 fs/ext4/mballoc.c | 154 ++++++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 134 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index c1edde8..7b1b3ec 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -739,7 +739,7 @@ ext4_fsblk_t ext4_new_meta_blocks(handle_t *handle, struct inode *inode,
 	ar.inode = inode;
 	ar.goal = goal;
 	ar.len = count ? *count : 1;
-	ar.flags = flags;
+	ar.flags = flags | EXT4_MB_HINT_METADATA;
 
 	ret = ext4_mb_new_blocks(handle, &ar, errp);
 	if (count)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8104a21..3444b6e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -382,6 +382,7 @@ struct flex_groups {
 #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use */
 #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
 #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
+#define EXT4_BG_IOPS		0x0010 /* In IOPS/fast storage */
 
 /*
  * Macro-instructions used to manage group descriptors
@@ -1112,6 +1113,8 @@ struct ext4_inode_info {
 #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in use */
 #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* to test development code */
 
+#define EXT2_FLAGS_HAS_IOPS		0x0080	/* has IOPS storage */
+
 /*
  * Mount flags set via mount options or defaults
  */
@@ -1514,8 +1517,12 @@ struct ext4_sb_info {
 	atomic_t s_retry_alloc_pending;
 	struct list_head *s_mb_avg_fragment_size;
 	rwlock_t *s_mb_avg_fragment_size_locks;
+	struct list_head *s_avg_fragment_size_list_iops;  /* avg_frament_size for IOPS groups */
+	rwlock_t *s_avg_fragment_size_locks_iops;
 	struct list_head *s_mb_largest_free_orders;
 	rwlock_t *s_mb_largest_free_orders_locks;
+	struct list_head *s_largest_free_orders_list_iops; /* largest_free_orders for IOPS grps */
+	rwlock_t *s_largest_free_orders_locks_iops;
 
 	/* tunables */
 	unsigned long s_stripe;
@@ -3366,6 +3373,7 @@ struct ext4_group_info {
 #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
 	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
 #define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
+#define EXT4_GROUP_INFO_IOPS_BIT		5
 
 #define EXT4_MB_GRP_NEED_INIT(grp)	\
 	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
@@ -3382,6 +3390,10 @@ struct ext4_group_info {
 	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
 #define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
 	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, &((grp)->bb_state)))
+#define EXT4_MB_GRP_TEST_IOPS(grp)	\
+	(test_bit(EXT4_GROUP_INFO_IOPS_BIT, &((grp)->bb_state)))
+#define EXT4_MB_GRP_SET_IOPS(grp)	\
+	(set_bit(EXT4_GROUP_INFO_IOPS_BIT, &((grp)->bb_state)))
 
 #define EXT4_MAX_CONTENTION		8
 #define EXT4_CONTENTION_THRESHOLD	2
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 20f67a2..6d218af 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -828,6 +828,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
 mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	rwlock_t *afs_locks;
+	struct list_head *afs_list;
 	int new_order;
 
 	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
@@ -838,20 +840,23 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
 	if (new_order == grp->bb_avg_fragment_size_order)
 		return;
 
+	if (EXT4_MB_GRP_TEST_IOPS(grp)) {
+		afs_locks = sbi->s_avg_fragment_size_locks_iops;
+		afs_list = sbi->s_avg_fragment_size_list_iops;
+	} else {
+		afs_locks = sbi->s_mb_avg_fragment_size_locks;
+		afs_list = sbi->s_mb_avg_fragment_size;
+	}
+
 	if (grp->bb_avg_fragment_size_order != -1) {
-		write_lock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
+		write_lock(&afs_locks[grp->bb_avg_fragment_size_order]);
 		list_del(&grp->bb_avg_fragment_size_node);
-		write_unlock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
+		write_unlock(&afs_locks[grp->bb_avg_fragment_size_order]);
 	}
 	grp->bb_avg_fragment_size_order = new_order;
-	write_lock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
-	list_add_tail(&grp->bb_avg_fragment_size_node,
-		&sbi->s_mb_avg_fragment_size[grp->bb_avg_fragment_size_order]);
-	write_unlock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
+	write_lock(&afs_locks[new_order]);
+	list_add_tail(&grp->bb_avg_fragment_size_node, &afs_list[new_order]);
+	write_unlock(&afs_locks[new_order]);
 }
 
 /*
@@ -863,6 +868,10 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *iter, *grp;
+	bool iops = ac->ac_flags & EXT4_MB_HINT_METADATA &&
+		    ac->ac_sb->s_flags & EXT2_FLAGS_HAS_IOPS;
+	rwlock_t *lfo_locks;
+	struct list_head *lfo_list;
 	int i;
 
 	if (ac->ac_status == AC_STATUS_FOUND)
@@ -871,17 +880,25 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR0_OPTIMIZED))
 		atomic_inc(&sbi->s_bal_cr0_bad_suggestions);
 
+	if (iops) {
+		lfo_locks = sbi->s_largest_free_orders_locks_iops;
+		lfo_list = sbi->s_largest_free_orders_list_iops;
+	} else {
+		lfo_locks = sbi->s_mb_largest_free_orders_locks;
+		lfo_list = sbi->s_mb_largest_free_orders;
+	}
+
 	grp = NULL;
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
+		if (list_empty(&lfo_list[i]))
 			continue;
-		read_lock(&sbi->s_mb_largest_free_orders_locks[i]);
-		if (list_empty(&sbi->s_mb_largest_free_orders[i])) {
-			read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
+		read_lock(&lfo_locks[i]);
+		if (list_empty(&lfo_list[i])) {
+			read_unlock(&lfo_locks[i]);
 			continue;
 		}
 		grp = NULL;
-		list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
+		list_for_each_entry(iter, &lfo_list[i],
 				    bb_largest_free_order_node) {
 			if (sbi->s_mb_stats)
 				atomic64_inc(&sbi->s_bal_cX_groups_considered[0]);
@@ -890,7 +907,7 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 				break;
 			}
 		}
-		read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
+		read_unlock(&lfo_locks[i]);
 		if (grp)
 			break;
 	}
@@ -913,6 +930,10 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *grp = NULL, *iter;
+	bool iops = ac->ac_flags & EXT4_MB_HINT_METADATA &&
+		    ac->ac_sb->s_flags & EXT2_FLAGS_HAS_IOPS;
+	rwlock_t *afs_locks;
+	struct list_head *afs_list;
 	int i;
 
 	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
@@ -920,16 +941,24 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 			atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
 	}
 
+	if (iops) {
+		afs_locks = sbi->s_avg_fragment_size_locks_iops;
+		afs_list = sbi->s_avg_fragment_size_list_iops;
+	} else {
+		afs_locks = sbi->s_mb_avg_fragment_size_locks;
+		afs_list = sbi->s_mb_avg_fragment_size;
+	}
+
 	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
 	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		if (list_empty(&sbi->s_mb_avg_fragment_size[i]))
+		if (list_empty(&afs_list[i]))
 			continue;
-		read_lock(&sbi->s_mb_avg_fragment_size_locks[i]);
-		if (list_empty(&sbi->s_mb_avg_fragment_size[i])) {
-			read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
+		read_lock(&afs_locks[i]);
+		if (list_empty(&afs_list[i])) {
+			read_unlock(&afs_locks[i]);
 			continue;
 		}
-		list_for_each_entry(iter, &sbi->s_mb_avg_fragment_size[i],
+		list_for_each_entry(iter, &afs_list[i],
 				    bb_avg_fragment_size_node) {
 			if (sbi->s_mb_stats)
 				atomic64_inc(&sbi->s_bal_cX_groups_considered[1]);
@@ -938,7 +967,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 				break;
 			}
 		}
-		read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
+		read_unlock(&afs_locks[i]);
 		if (grp)
 			break;
 	}
@@ -947,7 +976,15 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 		*group = grp->bb_group;
 		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
 	} else {
-		*new_cr = 2;
+		if (iops) {
+			/* cannot find proper group in IOPS storage,
+			 * fall back to cr0 for non-IOPS groups.
+			 */
+			ac->ac_flags &= ~EXT4_MB_HINT_METADATA;
+			*new_cr = 0;
+		} else {
+			*new_cr = 2;
+		}
 	}
 }
 
@@ -1030,6 +1067,8 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	rwlock_t *lfo_locks;
+	struct list_head *lfo_list;
 	int i;
 
 	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--)
@@ -1042,21 +1081,24 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 		return;
 	}
 
+	if (EXT4_MB_GRP_TEST_IOPS(grp)) {
+		lfo_locks = sbi->s_largest_free_orders_locks_iops;
+		lfo_list = sbi->s_largest_free_orders_list_iops;
+	} else {
+		lfo_locks = sbi->s_mb_largest_free_orders_locks;
+		lfo_list = sbi->s_mb_largest_free_orders;
+	}
+
 	if (grp->bb_largest_free_order >= 0) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+		write_lock(&lfo_locks[grp->bb_largest_free_order]);
 		list_del_init(&grp->bb_largest_free_order_node);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+		write_unlock(&lfo_locks[grp->bb_largest_free_order]);
 	}
 	grp->bb_largest_free_order = i;
 	if (grp->bb_largest_free_order >= 0 && grp->bb_free) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
-		list_add_tail(&grp->bb_largest_free_order_node,
-		      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+		write_lock(&lfo_locks[i]);
+		list_add_tail(&grp->bb_largest_free_order_node, &lfo_list[i]);
+		write_unlock(&lfo_locks[i]);
 	}
 }
 
@@ -3150,6 +3192,8 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
 	init_rwsem(&meta_group_info[i]->alloc_sem);
 	meta_group_info[i]->bb_free_root = RB_ROOT;
+	if (desc->bg_flags & EXT4_BG_IOPS)
+		EXT4_MB_GRP_SET_IOPS(meta_group_info[i]);
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_avg_fragment_size_node);
 	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
@@ -3423,6 +3467,24 @@ int ext4_mb_init(struct super_block *sb)
 		INIT_LIST_HEAD(&sbi->s_mb_avg_fragment_size[i]);
 		rwlock_init(&sbi->s_mb_avg_fragment_size_locks[i]);
 	}
+	sbi->s_avg_fragment_size_list_iops =
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
+			      GFP_KERNEL);
+	if (!sbi->s_avg_fragment_size_list_iops) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	sbi->s_avg_fragment_size_locks_iops =
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
+			      GFP_KERNEL);
+	if (!sbi->s_avg_fragment_size_locks_iops) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
+		INIT_LIST_HEAD(&sbi->s_avg_fragment_size_list_iops[i]);
+		rwlock_init(&sbi->s_avg_fragment_size_locks_iops[i]);
+	}
 	sbi->s_mb_largest_free_orders =
 		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
 			GFP_KERNEL);
@@ -3441,6 +3503,24 @@ int ext4_mb_init(struct super_block *sb)
 		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
 		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
 	}
+	sbi->s_largest_free_orders_list_iops =
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
+			      GFP_KERNEL);
+	if (!sbi->s_largest_free_orders_list_iops) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	sbi->s_largest_free_orders_locks_iops =
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
+			      GFP_KERNEL);
+	if (!sbi->s_largest_free_orders_locks_iops) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
+		INIT_LIST_HEAD(&sbi->s_largest_free_orders_list_iops[i]);
+		rwlock_init(&sbi->s_largest_free_orders_locks_iops[i]);
+	}
 
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
@@ -3512,8 +3592,12 @@ int ext4_mb_init(struct super_block *sb)
 out:
 	kfree(sbi->s_mb_avg_fragment_size);
 	kfree(sbi->s_mb_avg_fragment_size_locks);
+	kfree(sbi->s_avg_fragment_size_list_iops);
+	kfree(sbi->s_avg_fragment_size_locks_iops);
 	kfree(sbi->s_mb_largest_free_orders);
 	kfree(sbi->s_mb_largest_free_orders_locks);
+	kfree(sbi->s_largest_free_orders_list_iops);
+	kfree(sbi->s_largest_free_orders_locks_iops);
 	kfree(sbi->s_mb_offsets);
 	sbi->s_mb_offsets = NULL;
 	kfree(sbi->s_mb_maxs);
@@ -3582,8 +3666,12 @@ int ext4_mb_release(struct super_block *sb)
 	}
 	kfree(sbi->s_mb_avg_fragment_size);
 	kfree(sbi->s_mb_avg_fragment_size_locks);
+	kfree(sbi->s_avg_fragment_size_list_iops);
+	kfree(sbi->s_avg_fragment_size_locks_iops);
 	kfree(sbi->s_mb_largest_free_orders);
 	kfree(sbi->s_mb_largest_free_orders_locks);
+	kfree(sbi->s_largest_free_orders_list_iops);
+	kfree(sbi->s_largest_free_orders_locks_iops);
 	kfree(sbi->s_mb_offsets);
 	kfree(sbi->s_mb_maxs);
 	iput(sbi->s_buddy_cache);
-- 
1.8.3.1

