Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1615F76191E
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 15:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjGYNAY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 09:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGYNAX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 09:00:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2035.outbound.protection.outlook.com [40.92.98.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651E010B
        for <linux-ext4@vger.kernel.org>; Tue, 25 Jul 2023 06:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYdgDdoDBrSqx+3pMiLf+rLwI6ffLs5dchNHPpa+nqDuTyt9xu3sGLTKHXfokRWSIOHf3xjYvLeucWmKU+Txr+9THxTy+/OBu8uzaslURufMBjuvXWuoEDaAExEQuWbdlr2IntTzEcmWkjrn30h6rHX1/izloyogv1wK9aF6u9WTUlFqVGLPTeEbP/c8d/7ZWabAOc7brza/wyThd1jg5gQvgSocc1pVNzpe0qZRQ2D5hWgv+oBQd7ntHU8B6iof8PUavVjyNOv8768zno8+RHrlsT5tqH3NAGmOb0yh6zSXWxksHD+wlx4BFltaByCyCRJ7P6A0/pNjwPCXtMLyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K015sFMvvP0sc4x5/ltTD0vKR2bG+hyGUp25geZ1w/E=;
 b=XVTmsOt1ZRp5GjToZqlQRPwjKbB2lh19lyYo70vJFlJRX8YUK8NDPmM+uOYNSXhQL3JGIAwdhDp1ObWO2N2DA+SiGodRc4tkOEBayiEM+pmi0xWJzHNrprrL/ARs0YIR1D0mJn6U1P2Dozz5K+a2hz8jVXc5jRaD2D0LdNvtNko2QIF7a4QksP4mDT6g7bsTkBIUUM5k+B7DDUIuuFZbN82ogJE6Bc40ajBx16eCyFdna9HRbDHD0hj/U4m0BnU/u62haYrEZgScVoAcSL0xJVf6S4LbhW+SQlL7/ST4TYw2yisc/xq+tcON0yXiXi/AfQs+V0khat0Uv4oJPS1umQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K015sFMvvP0sc4x5/ltTD0vKR2bG+hyGUp25geZ1w/E=;
 b=KVq1QE+6UJGCtQM6WING8GYoRREblsUif4iB70IuGQWIN0rXOUMaeLA3NdcKVgD4i5meHnYzcxWaNd+a2ua8BWE56KcPvchl80PLvzg1SZexw+nK4PNg1zlFzmNhiMl661x8Ql/g75vAUBJjf4B0ncr5TfnmoEz79FM+3vL1NtZ0EGkbOaAUmOqArWU6vcQyywPV9WahKStOiPGq20bB/XP+iP510mu+TD05PE/yVWoA4HLOe9AzW643bXOv5NqISm69OurrhWJz/lU39db3IlOBVLECfPJzZlGJndMfTpP+IPKMbQ6I5hYYW29B7OX0knVPFF0uV+yOf1LEPuMBQQ==
Received: from OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d7::9) by
 TYCP286MB3497.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 13:00:18 +0000
Received: from OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6d37:bb31:8707:ae72]) by OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6d37:bb31:8707:ae72%4]) with mapi id 15.20.6631.023; Tue, 25 Jul 2023
 13:00:18 +0000
From:   Bobi Jam <bobijam@hotmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Bobi Jam <bobijam@hotmail.com>
Subject: [PATCH] ext4: optimize metadata allocation for hybrid LUNs
Date:   Tue, 25 Jul 2023 21:00:08 +0800
Message-ID: <OS3P286MB05671817672B9B67D7AD643CAF03A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [hcqdo/pi2ttRKcKHqmwCzuZ6awGncgQ7bemP48qeqXM1mgvVfa6xk5M94JJFPYkozle7D3E2SbQ=]
X-ClientProxiedBy: TYCP301CA0053.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::20) To OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:d7::9)
X-Microsoft-Original-Message-ID: <20230725130009.91207-1-bobijam@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0567:EE_|TYCP286MB3497:EE_
X-MS-Office365-Filtering-Correlation-Id: aefc9c6f-bf4a-406e-9958-08db8d0f18bb
X-MS-Exchange-SLBlob-MailProps: Vs63Iqe4sQkEXrwYbjJmyXRdeQu8GzTTuuV0Z3tPSh8pYdM0ZV/oi/eS/GeI5G7Ny3x0wi2qkEdIt7K/sMhE7tB7YRhmYdc87puMLT6cn7jOpUmLybKNbmOCaLz5hSXGeDJxpW8mzmBi3sDqvF+p0pnG7vyE6XRhWJvtOA7dRVjLkZrDhXnNwwdJx3mnRRRfadZnZp+3lS87xbbmAZ55YJc9O4XCDIe4IVxfNXe2wvpDwlUXH5+0MFoMySwBMb3OX7Pr0CchCPLnGxdZPwaG4P6pH4w45/hNPjKazd/wweki2ywpp9qxtHG4AdeauegHUcWAdm/yfWOGDFwpXVBDYQjyrZZwiQPBPSTZ47K/Zks64RmHgxdaJyPSyGeJb+51FrN1WiouB/0RPc4S6TTuBuGXJx2ZzHh4tJZNJiTo8WZjmqrTZFuIYt3GBLsPcLcCreqirXzBL3UtsQZcSvFy3wauO5YGi1d61drkKK6hQmXQMAB3FoZi8o6lb0QRyj1cbN+KfJeSiUKvla92nEeMWu3k2vhb1mlE5EMBB+9s/LCavXOgNOHigJV4nLryRstk3ywGd4/0kcillV8NLDz2RFSXbbxq0nQD84bfaDX/bwwktX4iNkSBM/Yb0L/pIDpjkqJZ43TkG5jLmpLeRx9RYCblbYS4wFt8C8eAAZ3fIhA5X2pmcRWn7JKghH1V3BhzLEunXpn+iBl8HZrLR+Sfg/KxKUqAkWW/6oS8dMo58qs=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsoXtfS4yvBqFY9iq3wBhj1TXwkG48jOlsx2eviwvbt2rphEzf/WZZyYTTjA9B86yb+F5YpoVa0qiUVB1CXCiGosTclujmq4DJMotmo/QgXW6gJSxNDLy0xpCOtmKOPZrXm/bnCnkbNKWgSzbCzuvQbAyYbtWs1em2Y8KAQOvBLgk+XVpBeIjeDCrAR/g739U83UD4ZueOwiZiZtZ6E0Tq4ZeJqI9Ac+ANyXrcaMy16stay5bFyrkYhvFyxbqsg3kjC0FMNk254JnDNI9KKUNgA0i4EWA0Kb9ctpTmAKTMPx61mD+nXSAMt1oKAgL3h0/6T5imUh8FUiIqRBTVxkYh6lFC+vTr3dOni+cZ/hjWpyj777jlEbqelPvQcgUjwkfcKFajuw6j14SzDMoyoSLAOR92KbXh+XeLbTfhecNsg892HWB7fWe5prGjp/vrF69s0oeAHj5eAqqIOQNuRCQsqbCELPNIu5yaII0TzGAWj07kZyERJHtIWEtItsblS31eayIFu5oMIViDhSooahtJsOrNcH1Al5XhbaYI16kKinxDVmjCT6duVNw6mF/wIgflGa7pDl0zXSzyHFBRa4Z0hs9FtmPCiWAk7TVBJVfX4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LUqc1cnE+Kr2o4s0L+yXkxaBmX34Og7rPthuIuMwJ5saThZxUjVEJlPEmsRs?=
 =?us-ascii?Q?qi3SS11yxTZHQiOLVrbymLEUWs3KkusMYucSyu7xZBj5rAT2q8+oPhzQQHJR?=
 =?us-ascii?Q?Wf3wV8rofVI8sg0DQaj/s1fb7vurUG5sOENhJhJspk8KYdCkzv2AgvYQu+yT?=
 =?us-ascii?Q?8pJmKRIABx3uu17BCFI6IHHu2aaVIkHsbUqNCmZWsLHc79aDDY+eMfwpfsL+?=
 =?us-ascii?Q?YDxpPq7EAaFB0EpGmHAI7mu53my9IR1q5xfPOzXmiWoosXDO5HqvBc9itEJ9?=
 =?us-ascii?Q?wdNItuSUWpY9AYTHkg6tCSaoXrDAJ+wuPQ5hfAlcDK3Qk9+0J2LadLNxZ1A5?=
 =?us-ascii?Q?jzUzrW7OHMpRo4K7MZMa9/CN2SXd3AdXPE7UpwVWJqO4Kq97GOBXEKGQL2tK?=
 =?us-ascii?Q?HLmcDI7ynEtAFLlQ+ymi2pC9XBVrHtYxE4PfQVHbFKZqi2ME6crlPcK4wZeV?=
 =?us-ascii?Q?dprpxbz46f5gyLS9dZg9AcPbvndHkITOOyRBftfjaRbMShD8WJiwA+b2Xj6G?=
 =?us-ascii?Q?oNhbej8FS36Qvd0+q3OQWh7QhTFHZ4qz3NbkMHs/Mr4D9NOIMksEgLssfKT1?=
 =?us-ascii?Q?JX5UAYRqxd49aEaSJrt28DwMkpvW56jAsZxgJE21AqBQCrfJBWwiBPdb/1QI?=
 =?us-ascii?Q?YBmyOpEWIhxDegBOJIbKkCspw115dk7sJHPevgHzXHbKjP3VcTcpWmi11iTq?=
 =?us-ascii?Q?x9337h+4L2vZ/R44aq+lgbWdQm8awDxNvjYh+rR3mshTK0Fb3pQkSeNMNtce?=
 =?us-ascii?Q?HnRRHsJcFBF71ZnZFEEskDog3rHYsJC1S3DhUepvt5Sdyik4nlj7Qn8tpq+9?=
 =?us-ascii?Q?jfkPRWtQY1bdQhZnXw2nSadZmI8A7Qia+4lDRqZKXkkg4VSrScznasfzAvcI?=
 =?us-ascii?Q?i3oDleD2P7B28kjLlD5Hd/0DfEzm0l5nJwfRDjZBQNBvybdG8V1HCjzZtcqc?=
 =?us-ascii?Q?MpO4SEDCRqX/YQBlhgjlWy1ezcOnjeiC6Jlg5J3n71hTmc3jvmU20YIfUxl1?=
 =?us-ascii?Q?nOXQFS0JvF7L4pb0omzCoFfSeNn/o0kPMoNdS9UfiVQjZ91zcGOnRLEHmbuf?=
 =?us-ascii?Q?y98IquWuEBtrkoJUKXr9SFc/sVIJYsqP4efMGwbMDcEHWkyNWg1RH2DrxM/u?=
 =?us-ascii?Q?VMBDZ0N6zFAAZ7tRRqu8p7xjBsih4+ZqOCPW1FfplNUrGNOXHNxiHhmJgSyZ?=
 =?us-ascii?Q?p8MeJtciKeO02QgLuQsDK93eijzM/dsPflIuL4lbl72F7fvHJmCAbAIVOBj0?=
 =?us-ascii?Q?7B1A6UIxZQbBep7fl+hE2KxUEwXYXoBZPNVcmZgSkQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aefc9c6f-bf4a-406e-9958-08db8d0f18bb
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:00:18.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Split largest free order group lists and average fragment size lists
into other two lists for IOPS/fast storage groups, and cr 0 / cr 1
group scanning for metadata block allocation in following order:

cr 0 on largest free order IOPS group list
cr 1 on average fragment size IOPS group list
cr 0 on largest free order non-IOPS group list
cr 1 on average fragment size non-IOPS group list
cr >= 2 perform the linear search as before

Non-metadata block allocation does not allocate from the IOPS groups.

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

