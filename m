Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD511D4A71
	for <lists+linux-ext4@lfdr.de>; Fri, 15 May 2020 12:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgEOKHM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 May 2020 06:07:12 -0400
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com ([40.107.237.80]:4064
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728007AbgEOKHL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 15 May 2020 06:07:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brAWLP07LAeuUrRS2wtI9qAb7pqsMHBoIFNpLou4UYArDcYBE5d2HqknO4lkRsiss12pTarFzjCmfZYYbgrVpLzV3fN4LfiZUPXzR3PCmDTSl4PYXFNXbYUPH3tRHCw6wQgVeh43KtbtIgXuy3IVMSwSHrbnz1UCbiU5K0/ROa+ipBWzlmd2cwQ0OOpF/RHZ20Wl6s6sDOdVSZ8GucacNAXcu+YZLbTO7k8J8L0pRavIBnFuy6a7Kq4sPnnKGomlxfm7lzMFa2GtWVScVMSWU4iPthklZctsIyYBUlSKCtSO/3Ay5HQ1hzWh6g8cSP1rdvkWOJZTO7IYNWpMJkuQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMFq8AYgnLKU63e5C6NA2X9zMqu2At2u1uPg+xKH8E8=;
 b=VRxriAjhNzGe/YB/Zmh8TpgzJIQovFIxUnuaeIOy8GtRNiAcsJtcj+TN7sqioxySxGBkUsOz9dsaFZobKqiGu5vz5b5iBaK/a47QxgBHfaKc4F8/2HzWTb0KKxjaNFgIcrUR9eGTWcMhvO4hGUFf945Er3Pqdsb02IMHSpQ+B3zCg3uQ0DPq+DUCdGBKEuwThNBLaGvBeoR/v1+kT4CePCHGBfM0ETVFGOTB1oL/WBTbbKh0ai+6PIAw+765aS8HRYIXc2g6XmYzIpH06FGVkzKOAV6zSlkY0FVEkZRl1Y0k00J6V6xu8hzN7CZ3yc1fDQjXgI3IjH5/3AQ7YXIkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMFq8AYgnLKU63e5C6NA2X9zMqu2At2u1uPg+xKH8E8=;
 b=gVAMwkW8Brna78wa/IFXPXiz+iDh3f8rNA1yCZPe7vTF9l70EKMr3dPHKGpxzLs+pSiksdPSnwGexwSSnybvT2F+wzUxWMADvfPfY1av3RPqCZ7Lb5X17L36xoTwYv3V1E6vDLN0+d+vW45JGEpTyMReOGc+/QMjD//yK7NJv5M=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM6PR19MB4060.namprd19.prod.outlook.com (2603:10b6:5:249::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Fri, 15 May
 2020 10:07:06 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4%7]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 10:07:06 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps
Thread-Topic: [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps
Thread-Index: AQHWKqCWw4qzGBAMuEeYjSA1mDJZiA==
Date:   Fri, 15 May 2020 10:07:06 +0000
Message-ID: <262A2973-9B2D-4DBE-8752-67E91D52C632@whamcloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=whamcloud.com;
x-originating-ip: [95.73.85.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a00365c3-2362-413a-8fdb-08d7f8b7b95e
x-ms-traffictypediagnostic: DM6PR19MB4060:
x-microsoft-antispam-prvs: <DM6PR19MB4060CAADCD87799650F084A8CBBD0@DM6PR19MB4060.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XGvpvOqU1WvfczwAFrhZj4n3sF1B0AsnT89/yZ7Ut/B7Z9Z2Agi0VRVBvcT75sUDg2xMtilH3X5BDlGbzgzEXowH4nEWR+HMB3sf35QmQb0m7L2gVmbGWfgflxnnYWQpiINw3dmJ/qoLBpGIJOFOuDDCximkpKXQuo2tf+qW59ZRSQawU1WNf687MVY+nRjbM94R6ZcBhNMI8XAF2F1eUZY4U5f5XG7qjNebdFR14zDrKw69+XJIrrrxcb5JRCFz6uF09eBzHlWP62N+tmQ5t3+4Zn094q+ZAHAfxza3TvL/vv2cXb7rmXvlKvB1DBz3G2ws2wXfNCX5jZhlCiwWrh0ZiGYPs8ZAFc+6EN2skctuxAMIKiqv4RP3WPFkiZ5ClzLtOUDfj6uTY7QMREeRaTtw78tFO5UwTfsr4tDyKWjduYX+0/rTJkrMbHktxXdJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39850400004)(136003)(346002)(376002)(396003)(36756003)(186003)(6916009)(66446008)(8676002)(6486002)(64756008)(91956017)(30864003)(76116006)(5660300002)(8936002)(71200400001)(66556008)(26005)(66946007)(2906002)(6506007)(33656002)(2616005)(6512007)(316002)(86362001)(478600001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rPiCymAebFu7+y/599tAlJzxueHYe437JzjJqAkljD2VaBfj618VSgI2w/OyIHLU6uz9Dp/n4i1Mr7R98aBynMm17JqSXx4h7dSO9bpHX4vG/iggq0akqiik7gF/avb8ULido3KL0BhgfoXW2CxLr09q5JGRI7HzNCvP50tewOkQqVkuyuEReXGRTRAVE0HCeRIrEVKxLTXXcIZjp8Uwwy/+2Z3mQjn7fx41NefNx8Jx/JRQwM5eFw5KfjkS9haCAG2gHUYj41oOOwBpvtnympBFq0PU0qG8Ff2sI6b7O7E2Amr3zeC4PSnWUAODtLTY/8/62jO36RPvOBAwkhSd0wwUFZDbtG5ZClkv01hVKQvdxHOQj5Hk7uGOo9d7hu30KMXFtSs8olwzVyX+76Y7dki8qi0rc4LUER0kutqCJ+RBz0X1Vz4IkOlAwxVJ5ejsYkVdCPBjWPotrhHkLTOebqaZPKMZbK7A39vqJQanlZE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D13CC8853AB3D45A1AB96B11B09469C@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00365c3-2362-413a-8fdb-08d7f8b7b95e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 10:07:06.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBN4oj5Jzw16+K3uSLQAjS69zFJzjsA5dOvqV8mWsU5kQSQHA0KzetxX5OeTCweH1vlbmTi0PCwHUtpEqsnHhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4060
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This should significantly improve bitmap loading, especially for flex
groups as it tries to load all bitmaps within a flex.group instead of
one by one synchronously.

Prefetching is done in 8 * flex_bg groups, so it should be 8 read-ahead
reads for a single allocating thread. At the end of allocation the
thread waits for read-ahead completion and initializes buddy information
so that read-aheads are not lost in case of memory pressure.

At cr=3D0 the number of prefetching IOs is limited per allocation context
to prevent a situation when mballoc loads thousands of bitmaps looking
for a perfect group and ignoring groups with good chunks.

Together with the patch "ext4: limit scanning of uninitialized groups"
the mount time (which includes few tiny allocations) of a 1PB filesystem
is reduced significantly:

               0% full    50%-full unpatched    patched
  mount time       33s                9279s       563s

Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
---
 fs/ext4/balloc.c  |  12 ++++-
 fs/ext4/ext4.h    |   8 +++-
 fs/ext4/mballoc.c | 116 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/mballoc.h |   2 +
 fs/ext4/sysfs.c   |   4 ++
 5 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index a32e5f7b5385..6712146195ed 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -413,7 +413,8 @@ static int ext4_validate_block_bitmap(struct super_bloc=
k *sb,
  * Return buffer_head on success or an ERR_PTR in case of failure.
  */
 struct buffer_head *
-ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_g=
roup)
+ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_g=
roup,
+				 bool ignore_locked)
 {
 	struct ext4_group_desc *desc;
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
@@ -444,6 +445,13 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, =
ext4_group_t block_group)
 	if (bitmap_uptodate(bh))
 		goto verify;
=20
+	if (ignore_locked && buffer_locked(bh)) {
+		/* buffer under IO already, do not wait
+		 * if called for prefetching */
+		put_bh(bh);
+		return NULL;
+	}
+
 	lock_buffer(bh);
 	if (bitmap_uptodate(bh)) {
 		unlock_buffer(bh);
@@ -534,7 +542,7 @@ ext4_read_block_bitmap(struct super_block *sb, ext4_gro=
up_t block_group)
 	struct buffer_head *bh;
 	int err;
=20
-	bh =3D ext4_read_block_bitmap_nowait(sb, block_group);
+	bh =3D ext4_read_block_bitmap_nowait(sb, block_group, false);
 	if (IS_ERR(bh))
 		return bh;
 	err =3D ext4_wait_block_bitmap(sb, block_group, bh);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..521fbcd8efc7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1483,6 +1483,8 @@ struct ext4_sb_info {
 	/* where last allocation was done - for stream allocation */
 	unsigned long s_mb_last_group;
 	unsigned long s_mb_last_start;
+	unsigned int s_mb_prefetch;
+	unsigned int s_mb_prefetch_limit;
=20
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
@@ -2420,7 +2422,8 @@ extern struct ext4_group_desc * ext4_get_group_desc(s=
truct super_block * sb,
 extern int ext4_should_retry_alloc(struct super_block *sb, int *retries);
=20
 extern struct buffer_head *ext4_read_block_bitmap_nowait(struct super_bloc=
k *sb,
-						ext4_group_t block_group);
+						ext4_group_t block_group,
+						bool ignore_locked);
 extern int ext4_wait_block_bitmap(struct super_block *sb,
 				  ext4_group_t block_group,
 				  struct buffer_head *bh);
@@ -3119,6 +3122,7 @@ struct ext4_group_info {
 	(1 << EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT)
 #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
 	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
+#define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
=20
 #define EXT4_MB_GRP_NEED_INIT(grp)	\
 	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
@@ -3133,6 +3137,8 @@ struct ext4_group_info {
 	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
 #define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
 	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
+#define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
+	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, &((grp)->bb_state)))
=20
 #define EXT4_MAX_CONTENTION		8
 #define EXT4_CONTENTION_THRESHOLD	2
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index afb8bd9a10e9..ebfe258bfd0f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -861,7 +861,7 @@ static int ext4_mb_init_cache(struct page *page, char *=
incore, gfp_t gfp)
 			bh[i] =3D NULL;
 			continue;
 		}
-		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group);
+		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group, false);
 		if (IS_ERR(bh[i])) {
 			err =3D PTR_ERR(bh[i]);
 			bh[i] =3D NULL;
@@ -2127,6 +2127,96 @@ static int ext4_mb_good_group(struct ext4_allocation=
_context *ac,
 	return 0;
 }
=20
+/*
+ * each allocation context (i.e. a thread doing allocation) has own
+ * sliding prefetch window of @s_mb_prefetch size which starts at the
+ * very first goal and moves ahead of scaning.
+ * a side effect is that subsequent allocations will likely find
+ * the bitmaps in cache or at least in-flight.
+ */
+static void
+ext4_mb_prefetch(struct ext4_allocation_context *ac,
+		    ext4_group_t start)
+{
+	struct super_block *sb =3D ac->ac_sb;
+	ext4_group_t ngroups =3D ext4_get_groups_count(sb);
+	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+	struct ext4_group_info *grp;
+	ext4_group_t nr, group =3D start;
+	struct buffer_head *bh;
+
+	/* limit prefetching at cr=3D0, otherwise mballoc can
+	 * spend a lot of time loading imperfect groups */
+	if (ac->ac_criteria < 2 && ac->ac_prefetch_ios >=3D sbi->s_mb_prefetch_li=
mit)
+		return;
+
+	/* batch prefetching to get few READs in flight */
+	nr =3D ac->ac_prefetch - group;
+	if (ac->ac_prefetch < group)
+		/* wrapped to the first groups */
+		nr +=3D ngroups;
+	if (nr > 0)
+		return;
+	BUG_ON(nr < 0);
+
+	nr =3D sbi->s_mb_prefetch;
+	if (ext4_has_feature_flex_bg(sb)) {
+		/* align to flex_bg to get more bitmas with a single IO */
+		nr =3D (group / sbi->s_mb_prefetch) * sbi->s_mb_prefetch;
+		nr =3D nr + sbi->s_mb_prefetch - group;
+	}
+	while (nr-- > 0) {
+		grp =3D ext4_get_group_info(sb, group);
+
+		/* prevent expensive getblk() on groups w/ IO in progress */
+		if (EXT4_MB_GRP_TEST_AND_SET_READ(grp))
+			goto next;
+
+		/* ignore empty groups - those will be skipped
+		 * during the scanning as well */
+		if (grp->bb_free > 0 && EXT4_MB_GRP_NEED_INIT(grp)) {
+			bh =3D ext4_read_block_bitmap_nowait(sb, group, true);
+			if (bh && !IS_ERR(bh)) {
+				if (!buffer_uptodate(bh))
+					ac->ac_prefetch_ios++;
+				brelse(bh);
+			}
+		}
+next:
+		if (++group >=3D ngroups)
+			group =3D 0;
+	}
+	ac->ac_prefetch =3D group;
+}
+
+static void
+ext4_mb_prefetch_fini(struct ext4_allocation_context *ac)
+{
+	struct ext4_group_info *grp;
+	ext4_group_t group;
+	int nr, rc;
+
+	/* initialize last window of prefetched groups */
+	nr =3D ac->ac_prefetch_ios;
+	if (nr > EXT4_SB(ac->ac_sb)->s_mb_prefetch)
+		nr =3D EXT4_SB(ac->ac_sb)->s_mb_prefetch;
+	group =3D ac->ac_prefetch;
+	if (!group)
+		group =3D ext4_get_groups_count(ac->ac_sb);
+	group--;
+	while (nr-- > 0) {
+		grp =3D ext4_get_group_info(ac->ac_sb, group);
+		if (grp->bb_free > 0 && EXT4_MB_GRP_NEED_INIT(grp)) {
+			rc =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
+			if (rc)
+				break;
+		}
+		if (!group)
+			group =3D ext4_get_groups_count(ac->ac_sb);
+		group--;
+	}
+}
+
 static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
@@ -2200,6 +2290,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 		 * from the goal value specified
 		 */
 		group =3D ac->ac_g_ex.fe_group;
+		ac->ac_prefetch =3D group;
=20
 		for (i =3D 0; i < ngroups; group++, i++) {
 			int ret =3D 0;
@@ -2211,6 +2302,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 			if (group >=3D ngroups)
 				group =3D 0;
=20
+			ext4_mb_prefetch(ac, group);
+
 			/* This now checks without needing the buddy page */
 			ret =3D ext4_mb_good_group(ac, group, cr);
 			if (ret <=3D 0) {
@@ -2283,6 +2376,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 out:
 	if (!err && ac->ac_status !=3D AC_STATUS_FOUND && first_err)
 		err =3D first_err;
+	/* use prefetched bitmaps to init buddy so that read info is not lost */
+	ext4_mb_prefetch_fini(ac);
 	return err;
 }
=20
@@ -2542,6 +2637,25 @@ static int ext4_mb_init_backend(struct super_block *=
sb)
 			goto err_freebuddy;
 	}
=20
+	if (ext4_has_feature_flex_bg(sb)) {
+		/* a single flex group is supposed to be read by a single IO */
+		sbi->s_mb_prefetch =3D 1 << sbi->s_es->s_log_groups_per_flex;
+		sbi->s_mb_prefetch *=3D 8; /* 8 prefetch IOs in flight at most */
+	} else {
+		sbi->s_mb_prefetch =3D 32;
+	}
+	if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
+		sbi->s_mb_prefetch =3D ext4_get_groups_count(sb);
+	/* now many real IOs to prefetch within a single allocation at cr=3D0
+	 * given cr=3D0 is an CPU-related optimization we shouldn't try to
+	 * load too many groups, at some point we should start to use what
+	 * we've got in memory.
+	 * with an average random access time 5ms, it'd take a second to get
+	 * 200 groups (* N with flex_bg), so let's make this limit 4 */
+	sbi->s_mb_prefetch_limit =3D sbi->s_mb_prefetch * 4;
+	if (sbi->s_mb_prefetch_limit > ext4_get_groups_count(sb))
+		sbi->s_mb_prefetch_limit =3D ext4_get_groups_count(sb);
+
 	return 0;
=20
 err_freebuddy:
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 88c98f17e3d9..c96a2bd81f72 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -175,6 +175,8 @@ struct ext4_allocation_context {
 	struct page *ac_buddy_page;
 	struct ext4_prealloc_space *ac_pa;
 	struct ext4_locality_group *ac_lg;
+	ext4_group_t ac_prefetch;
+	int ac_prefetch_ios; /* number of initialied prefetch IO */
 };
=20
 #define AC_STATUS_CONTINUE	1
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 04bfaf63752c..5f443f9d54b8 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -240,6 +240,8 @@ EXT4_RO_ATTR_ES_STRING(last_error_func, s_last_error_fu=
nc, 32);
 EXT4_ATTR(first_error_time, 0444, first_error_time);
 EXT4_ATTR(last_error_time, 0444, last_error_time);
 EXT4_ATTR(journal_task, 0444, journal_task);
+EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
+EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
=20
 static unsigned int old_bump_val =3D 128;
 EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
@@ -283,6 +285,8 @@ static struct attribute *ext4_attrs[] =3D {
 #ifdef CONFIG_EXT4_DEBUG
 	ATTR_LIST(simulate_fail),
 #endif
+	ATTR_LIST(mb_prefetch),
+	ATTR_LIST(mb_prefetch_limit),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
--=20
2.21.3

