Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E087F1BB5CA
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 07:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgD1FUU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 01:20:20 -0400
Received: from mail-eopbgr750059.outbound.protection.outlook.com ([40.107.75.59]:29518
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbgD1FUT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 01:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl/50K1c9T26ncaDYZ5ILuThDtSAlvKfD1anMuDajREi/0yeidzcOh98rIBG34Jr0LD1BWtdYjSXqcmA9HI3eP9GFakTl8jVD2+ZDpk6ioM7gyZY5U8Ab/IZVB9tFaDLiiCBSIVYO5FPcsfPhWOBte1QMnTH0sKUkWVb8sgmLkaTrl39dMG1qEl+zvUKSaft6B82iSTSdHSr2k9aU5W5PTD0A7reoz9rd0MJKsWhqngBtKY9HZKcyXRVBGM2ZAWECfyErpYBatapKAOc5D+t5POAKdK55Q1hAl6MX8xJbVaWgH2pqvPQBLpsCjnq8cd72lTrKpP0WDEF4OxgrumcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KXvLpiOJhvsLg9SMSWn5lQyh0bRwUSve1XtZ8SEOnM=;
 b=jKNabKnx0LwC47+0WBH5hXLa7I9aqLHUxnViCgaK8v9i/HeyiMQoBX7WKsdPnnUAVoj/JI/HfLEEj0i/a9tqYGjyVVOZM9+hcZUSQ/868DgWGuF4wgsEJ/Gy8PZC2xZb30/5izhwofAckeyWRmF3OA2WAXGGTSEYmWT2R3IyfXPlEPGKfWe9QmH8lf7M+oRGYMVq9U0vVJf9jvFcUlG4F+PzTVo7uXHaufs1PL2RG5QJ+WzDIpdi6qtg86CEcj0/Q22zNGeuGOdnGU8MJ38gTYePXB4NpewPXvZost/6mykuz5k6umdVRUBjhqHtWYb64RwOXbCsAFaUn+3Z/iFFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KXvLpiOJhvsLg9SMSWn5lQyh0bRwUSve1XtZ8SEOnM=;
 b=rKQtDEIT2RHl4IrdqHaCCviIjhVIIK3vKDSRk0R8Hpa5vM2ENvm4lzU6VGSMlsTu+IiBDOLDA+rRd/0vgowdBiAoQe4nHHXbBdqRG2W+sPoPhn0ld1Bxi8bqmjtEbnDYtUca7BHZ2pSHE9qPuYD3AMf1y8O0z7TwUBRM7Ez8bXQ=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM6PR19MB3626.namprd19.prod.outlook.com (2603:10b6:5:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 05:20:15 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 05:20:14 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [PATCH 1/2] ext4: mballoc to prefetch groups ahead of scanning 
Thread-Topic: [PATCH 1/2] ext4: mballoc to prefetch groups ahead of scanning 
Thread-Index: AQHWHRyyuev+sPPxRkqB+AvAwEyX6g==
Date:   Tue, 28 Apr 2020 05:20:14 +0000
Message-ID: <DF4ADFBC-BC4B-4E6A-894A-5BCED5464F42@whamcloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [95.73.42.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e00f4f9f-86bd-49ff-0cc9-08d7eb33d547
x-ms-traffictypediagnostic: DM6PR19MB3626:
x-microsoft-antispam-prvs: <DM6PR19MB3626804F3565A7D3236387BACBAC0@DM6PR19MB3626.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(366004)(39850400004)(396003)(346002)(6916009)(2616005)(66476007)(71200400001)(966005)(66946007)(64756008)(66446008)(33656002)(91956017)(2906002)(8936002)(8676002)(81156014)(66556008)(86362001)(26005)(4743002)(316002)(478600001)(76116006)(6486002)(6506007)(5660300002)(186003)(6512007)(36756003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svFEB9uk6AGKiX7teFAw2G+0YwTmub2SHCac3FrAGtz7nSnOh3BvfU5jbceSj5O157YmBQOUiEEGDIGkYZ6YOvfIPXPUWjXs1GKYSJCpLbfuQlqSVyduntqojQn8+j4TVm82E1oB37Jy1TBtwLGKne4pZ+uDXBFq6lfDyOJ43z2wJfp/RxnVwu4OP9mZFDFK4Gvj5IEhP/kcIHbTNoysuN8PvC4aJ/gqnBjecjpTJWnhGN2ymHaOPKM4V80KNzxyb2IIviKg+/RUP7Y6x4r0O+27rxzyZhZRTgIquvvC2/nGdX+heDHpLjaqvsWIi/taN4lpxMnnLMhhBrSjpigCYuZ7zPf4S1YxsWSGwzelypan+7tYrNdltnu2mzG15k/A1RNsh+5LmOv6/tRyoCdrLTJTK5u77JbeA8LDU3og3OZDM/8pVEpWTVWeoAkDd29C24XhokYKyxQ3b7pIUhOQ2uJBHeSWPNNFInzX3fO4pD7GsOUUQKhV/mAltx4SpDE1mJSTXRwimaAGis+M90HLqw==
x-ms-exchange-antispam-messagedata: 7iiQHlh1A4NOeK08agOzS/euTu61UYJg8HJZPWuRcXnppW3yilw4HGLxZ4hSnOl6uI9Z0MYcvj+Pfi4izKffEBTnWFmaFAYlBPJTOB7Wn2Q86MBvgzp4a/72fuHb9iCc0El5YGDGqj1QAqCt8n6JwJRxkxt6J3OFvCwxW//lpsRAT+o4xz39S0Zi/3zmAQ3jW1v4lrlo9c6CIiyw0i1PRXqhZ7KciiPXnTlf1vHRz0t2/GemrHorDYnkQSmjjoxzzIFi2uPu8Qo2kjutcm64/4YDb+ZWFVHiQ9hTDxdEe2C6mU5fOcN0zq/e0Gqjx4Ux+TJYNoFVnCDqu6lPxrRWfOvIxdFr0Pd6E2mNOcQ8l2t0OeQKmJDJgislWJWR+j9iKDxfSn00ocUb5hUMutl81g+gQ1/P72UbdnNBvjdg82YqSImH+rBxaKivSA2IjS9lowW7wc+d/IEs+JEivFrrrQej716vRzQpjotHa4fT26u9//dtlvotGnNojCfVRH/oYzX5op2PgP9K2QSCdtiKkMOzOajqzyTmtDjcIp1DhnZEgZT/5wLQCDzx1sN2qkEr66BlspZ2Onj4yIHn9CAahUeU+UaLeUVf2h+6b/48KyQqPCZJBfDCUEaoPS9UNQVItOWQAXSW84Q8MMQSxpZKTyxHITcLJlvoKK0r4lob/tqLYq6HJ1rfBiaDTu7o1purOSTTH1flhaBD0D8nSeqGRZJHmXYjD83CMCflE1JGmADowG9hLZ1k+XzXYRkIILrW+Uw2jBVlhSUxKyCerN7unezU5DVZgw2F8zixFtMXIoo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CDE7A8014F12B40BAA16F501749FA46@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00f4f9f-86bd-49ff-0cc9-08d7eb33d547
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 05:20:14.7608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7d9x830+9tTz0rdzD+z9unIQk8LjnfVIZ12rVVenbjKsjYwI6EdU3898NDbu9y1pCyXbiNGULA4Muj5QtBLQuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3626
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Here is a refreshed patch to improve bitmap loading.
This should significantly improve bitmap loading, especially for flex group=
s as it tries
to load all bitmaps within a flex.group instead of one by one synchronously=
.

Prefetching is done in 8 * flex_bg groups, so it should be 8 read-ahead
reads for a single allocating thread. At the end of allocation the
thread waits for read-ahead completion and initializes buddy information
so that read-aheads are not lost in case of memory pressure.

At cr=3D0 the number of prefetching IOs is limited per allocation context
to prevent a situation when mballoc loads thousands of bitmaps looking
for a perfect group and ignoring groups with good chunks.

Together with the patch "ext4: limit scanning of uninitialized groups"
the mount time of a 1PB filesystem is reduced significantly:

               0% full    50%-full unpatched    patched
  mount time       33s                9279s       563s

Lustre-bug-id: https://jira.whamcloud.com/browse/LU-12988
Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
---
 fs/ext4/balloc.c  |  12 +++++-
 fs/ext4/ext4.h    |   5 ++-
 fs/ext4/mballoc.c | 106 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/mballoc.h |   2 +
 fs/ext4/sysfs.c   |   4 ++
 5 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index a32e5f7b5385..dc6cc8c7b0f8 100644
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
+				 int ignore_locked)
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
+	bh =3D ext4_read_block_bitmap_nowait(sb, block_group, 0);
 	if (IS_ERR(bh))
 		return bh;
 	err =3D ext4_wait_block_bitmap(sb, block_group, bh);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..1a4afaecc967 100644
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
+						int ignore_locked);
 extern int ext4_wait_block_bitmap(struct super_block *sb,
 				  ext4_group_t block_group,
 				  struct buffer_head *bh);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 30d5d97548c4..e84c298e739b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -861,7 +861,7 @@ static int ext4_mb_init_cache(struct page *page, char *=
incore, gfp_t gfp)
 			bh[i] =3D NULL;
 			continue;
 		}
-		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group);
+		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group, 0);
 		if (IS_ERR(bh[i])) {
 			err =3D PTR_ERR(bh[i]);
 			bh[i] =3D NULL;
@@ -2104,6 +2104,87 @@ static int ext4_mb_good_group(struct ext4_allocation=
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
+	ext4_group_t group =3D start;
+	struct buffer_head *bh;
+	int nr;
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
+		/* ignore empty groups - those will be skipped
+		 * during the scanning as well */
+		if (grp->bb_free > 0 && EXT4_MB_GRP_NEED_INIT(grp)) {
+			bh =3D ext4_read_block_bitmap_nowait(sb, group, 1);
+			if (bh && !IS_ERR(bh)) {
+				if (!buffer_uptodate(bh))
+					ac->ac_prefetch_ios++;
+				brelse(bh);
+			}
+		}
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
+	while (nr-- > 0) {
+		grp =3D ext4_get_group_info(ac->ac_sb, group);
+		if (grp->bb_free > 0 && EXT4_MB_GRP_NEED_INIT(grp)) {
+			rc =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
+			if (rc)
+				break;
+		}
+		if (group-- =3D=3D 0)
+			group =3D ext4_get_groups_count(ac->ac_sb) - 1;
+	}
+}
+
 static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
@@ -2177,6 +2258,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 		 * from the goal value specified
 		 */
 		group =3D ac->ac_g_ex.fe_group;
+		ac->ac_prefetch =3D group;
=20
 		for (i =3D 0; i < ngroups; group++, i++) {
 			int ret =3D 0;
@@ -2188,6 +2270,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 			if (group >=3D ngroups)
 				group =3D 0;
=20
+			ext4_mb_prefetch(ac, group);
+
 			/* This now checks without needing the buddy page */
 			ret =3D ext4_mb_good_group(ac, group, cr);
 			if (ret <=3D 0) {
@@ -2260,6 +2344,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 out:
 	if (!err && ac->ac_status !=3D AC_STATUS_FOUND && first_err)
 		err =3D first_err;
+	/* use prefetched bitmaps to init buddy so that read info is not lost */
+	ext4_mb_prefetch_fini(ac);
 	return err;
 }
=20
@@ -2776,6 +2862,24 @@ int ext4_mb_release(struct super_block *sb)
 				atomic_read(&sbi->s_mb_preallocated),
 				atomic_read(&sbi->s_mb_discarded));
 	}
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
=20
 	free_percpu(sbi->s_locality_groups);
=20
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

