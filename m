Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B89310FACE
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Dec 2019 10:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfLCJgc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Dec 2019 04:36:32 -0500
Received: from mail-eopbgr740084.outbound.protection.outlook.com ([40.107.74.84]:64300
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCJgc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Dec 2019 04:36:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDQq5udVMKWojfve+Zz2wHBve+d8gojhJ7yxwFMR8wELQgEFaxrQ+WZQsmvpGdfrquh4cl1XQ/Z4zgxWKkYSjbSHCarhTppxnqgyaiVn8G18hdw5ue3e3PmkWutkrHge2iZ/kAgO8Wc7hOql4Ukc41lrLYYWSMQrfZ9a26bInu8nUegAA1iUrL3B58GT0DuCh4OLwlAbpHyWykdzXpqcR0hbb1ziUcjm7CbMBSrxdOm2rVOVz4DBEOOESmogmK2jcm6QS8KdeRyVf0D3unKrRam/bA8dqjajt0KScZGzlIFGwcXGAQongMpHoPg1ck2Kfcvq0g4wi66MHReIwQiYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ATBZpyNz2+HTs7xf+TYQyDF0lzEygryj4bjbUjyZws=;
 b=MNzbft9u2NZGW4oMK4t1PGS945lI+Bt9vMy18iihG+7P1JER/TPXtIRjEP6q2l5mwde92/w3iL2BReGIOa5Z2mByHRL0w7ieHqd+DcQrYBkLvk3hWuvJ1Kf9RskmiJsGq8vj8O4BHOxCT1FzvSxf2QOXnHhW/2LTiAqBkA7TzxES0mwIoQT0z4yi2/QW4QecKCni3FpMnPLroOKzxouE4RZoEIQr2G8ymKSCF2XM7pjLL21F17pDMj7Yu3HxVrXI9ZIx1lzuvslrPLEgIJHcrNONKtbO/r/6kqhpfzA26eIsLHiOEuNguPoYO9VsDIUCKBbaIJ6i6vl47dt4v52KBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ATBZpyNz2+HTs7xf+TYQyDF0lzEygryj4bjbUjyZws=;
 b=SakjVxL/0lnpgrpqJxNJxjlGXS3BI2skHdDMl+QQCia36yqogrLt+YC3qpUMZB6taI1sH8of8G/nnrbNuac0Q4NeFspwpwvLWuqHFj7+k06dPggacbR4GTt4whjPS6zdACN4A2aFUvh5cXakhNTHZwo8tarVwPKI4+wZsuIPa1c=
Received: from MN2PR19MB2894.namprd19.prod.outlook.com (20.178.254.95) by
 MN2PR19MB2576.namprd19.prod.outlook.com (20.179.82.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 09:36:23 +0000
Received: from MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e]) by MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 09:36:23 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [RFC] improve mballoc for large filesystems: prefetch bitmaps
Thread-Topic: [RFC] improve mballoc for large filesystems: prefetch bitmaps
Thread-Index: AQHVqPAU37Gel4qjtUm51ke7qy2z36enYgIAgADGXAA=
Date:   Tue, 3 Dec 2019 09:36:23 +0000
Message-ID: <C63B4CF2-B40A-44C9-9B31-D0CD4C9E5FEA@whamcloud.com>
References: <E4874E78-3D87-46A3-A3B3-3128ED8A2ED2@whamcloud.com>
 <F26AB24A-4110-4F5E-B310-1AD69D7910B4@dilger.ca>
In-Reply-To: <F26AB24A-4110-4F5E-B310-1AD69D7910B4@dilger.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [128.72.176.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aca7c5f-c625-4b2c-5e6c-08d777d442d8
x-ms-traffictypediagnostic: MN2PR19MB2576:
x-microsoft-antispam-prvs: <MN2PR19MB2576FC98C68CB4D5B5B301E0CB420@MN2PR19MB2576.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:194;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(39850400004)(376002)(136003)(51914003)(189003)(199004)(66946007)(66446008)(446003)(2616005)(6512007)(102836004)(76116006)(91956017)(86362001)(64756008)(76176011)(36756003)(66556008)(7736002)(5660300002)(11346002)(26005)(6506007)(53546011)(6116002)(3846002)(2906002)(305945005)(186003)(8676002)(8936002)(81156014)(66476007)(6916009)(33656002)(229853002)(316002)(71190400001)(4326008)(256004)(14444005)(71200400001)(6246003)(478600001)(99286004)(6436002)(81166006)(6486002)(25786009)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB2576;H:MN2PR19MB2894.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTjthgnM4Nt/vWkj+AcpH5/mt6E0LC/77knsKwcR3Acv1BWcVUjhn2Ywcc2p2e5/8xZX++W0s+rbBHGIXW+et2hr19/mQ/uFA5xLvXHJ9hsxR2CsZdY5S3ThhfFwq4KIFRQfaAG1v/HRy7F44NYsHHHRj78FR5fIcEy4WEuF4EE7oyt3r2kxkUp5UktAX1kFTqGmLw6rs1C8npexgBVbUwktSHoSGfSNJNN1rXn4QBLHMP9qh+EV1ETJ6TJWV4XUd2Q549N3b6dV2eJVMb27Pz2CdCWzgOkSgZfwWOgPTn0WjVgSICOI8Ft4yHOy001CdryKeFemWYYzdhyWwQZnIMcO+HIbLErDXPkEqq7JFH1FdfaR3+nfuMakdmedJDj6NyzN3btPNLnmNE0XAK0Xr5Gq8ZcrDhj0PiS0sD1Yh5M+3Ag0FMrHYND1KxsiCAP3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C855C6B1EAEDD746B8E85DCF7E41F781@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aca7c5f-c625-4b2c-5e6c-08d777d442d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 09:36:23.2963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ey38bqbDzIpFTSE0tmlKCXCm8S5Ma/2hzccfqHCq5lqadzHyRwX/Vn+IOaqj4RgVsEvpDHhtYNIdfQQR2PIItQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2576
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On 3 Dec 2019, at 00:46, Andreas Dilger <adilger@dilger.ca> wrote:
>=20

Thanks for the review, here is the refreshed patch, will think a bit more a=
bout skipping in ext4_mb_prefetch()

Thanks, Alex

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 0b202e00d93f..12ebbf482f7c 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -397,6 +397,7 @@ static int ext4_validate_block_bitmap(struct super_bloc=
k *sb,
  * ext4_read_block_bitmap_nowait()
  * @sb:			super block
  * @block_group:	given block group
+ * @ignore_locked:	do not block on locked bh
  *
  * Read the bitmap for a given block_group,and validate the
  * bits for block/inode/inode tables are set in the bitmaps
@@ -404,7 +405,8 @@ static int ext4_validate_block_bitmap(struct super_bloc=
k *sb,
  * Return buffer_head on success or NULL in case of failure.
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
@@ -435,6 +437,13 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, =
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
@@ -524,7 +533,7 @@ ext4_read_block_bitmap(struct super_block *sb, ext4_gro=
up_t block_group)
 	struct buffer_head *bh;
 	int err;
=20
-	bh =3D ext4_read_block_bitmap_nowait(sb, block_group);
+	bh =3D ext4_read_block_bitmap_nowait(sb, block_group, true);
 	if (IS_ERR(bh))
 		return bh;
 	err =3D ext4_wait_block_bitmap(sb, block_group, bh);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f8578caba40d..edbd94a53221 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1485,6 +1485,10 @@ struct ext4_sb_info {
 	/* where last allocation was done - for stream allocation */
 	unsigned long s_mb_last_group;
 	unsigned long s_mb_last_start;
+	/* bitmap prefetch window */
+	unsigned int s_mb_prefetch;
+	/* how many bitmaps to prefetch at most at cr=3D0 */
+	unsigned int s_mb_prefetch_limit;
=20
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
@@ -2339,7 +2343,8 @@ extern struct ext4_group_desc * ext4_get_group_desc(s=
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
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7c6c34fd8e1c..03cc6f8dd22c 100644
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
@@ -2103,6 +2103,85 @@ static int ext4_mb_good_group(struct ext4_allocation=
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
+static void ext4_mb_prefetch(struct ext4_allocation_context *ac,
+			     ext4_group_t start)
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
+	if (!ac->ac_criteria && ac->ac_prefetch_ios >=3D sbi->s_mb_prefetch_limit=
)
+		return;
+
+	/* batch prefetching to get few READs in flight */
+	nr =3D ac->ac_prefetch - group;
+	if (nr < 0) /* ac_prefetch wrapped to the first groups */
+		nr +=3D ngroups;
+	if (nr > 0)
+		return;
+	BUG_ON(nr < 0);
+
+	nr =3D sbi->s_mb_prefetch;
+	if (ext4_has_feature_flex_bg(ac->ac_sb)) {
+		/* align to flex_bg to get more bitmas with a single IO */
+		//nr =3D roundup(group, sbi->s_mb_prefetch);
+		nr =3D (group / sbi->s_mb_prefetch) * sbi->s_mb_prefetch;
+		nr =3D nr + sbi->s_mb_prefetch - group;
+	}
+	while (nr-- > 0) {
+		grp =3D ext4_get_group_info(sb, group);
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
+		if (++group >=3D ngroups)
+			group =3D 0;
+	}
+	ac->ac_prefetch =3D group;
+}
+
+/* initialize most recent prefetched groups */
+static void ext4_mb_prefetch_fini(struct ext4_allocation_context *ac)
+{
+	struct ext4_group_info *grp;
+	ext4_group_t group;
+	int nr, rc;
+
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
@@ -2175,7 +2254,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 		 * searching for the right group start
 		 * from the goal value specified
 		 */
-		group =3D ac->ac_g_ex.fe_group;
+		group =3D ac->ac_g_ex.fe_group + 1;
+		ac->ac_prefetch =3D group;
=20
 		for (i =3D 0; i < ngroups; group++, i++) {
 			int ret =3D 0;
@@ -2187,6 +2267,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 			if (group >=3D ngroups)
 				group =3D 0;
=20
+			ext4_mb_prefetch(ac, group);
+
 			/* This now checks without needing the buddy page */
 			ret =3D ext4_mb_good_group(ac, group, cr);
 			if (ret <=3D 0) {
@@ -2259,6 +2341,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 out:
 	if (!err && ac->ac_status !=3D AC_STATUS_FOUND && first_err)
 		err =3D first_err;
+	/* use prefetched bitmaps to init buddy so that read info is not lost */
+	ext4_mb_prefetch_fini(ac);
 	return err;
 }
=20
@@ -2880,6 +2964,20 @@ void ext4_process_freed_data(struct super_block *sb,=
 tid_t commit_tid)
 			bio_put(discard_bio);
 		}
 	}
+	if (ext4_has_feature_flex_bg(sb)) {
+		/* a single flex group is supposed to be read by a single IO */
+		sbi->s_mb_prefetch =3D 1 << sbi->s_es->s_log_groups_per_flex;
+		sbi->s_mb_prefetch *=3D 8; /* 8 prefetch IOs in flight at most */
+	} else {
+		sbi->s_mb_prefetch =3D 32;
+	}
+	if (sbi->s_mb_prefetch >=3D ext4_get_groups_count(sb) >> 2)
+		sbi->s_mb_prefetch =3D ext4_get_groups_count(sb) >> 2;
+	/* now many real IOs to prefetch within a single allocation at cr=3D0
+	 * given cr=3D0 is an CPU-related optimization we shouldn't try to
+	 * load too many groups, at some point we should start to use what
+	 * we've got in memory */
+	sbi->s_mb_prefetch_limit =3D sbi->s_mb_prefetch * 64;
=20
 	list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
 		ext4_free_data_in_buddy(sb, entry);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 88c98f17e3d9..73868ffb9a38 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -175,6 +175,8 @@ struct ext4_allocation_context {
 	struct page *ac_buddy_page;
 	struct ext4_prealloc_space *ac_pa;
 	struct ext4_locality_group *ac_lg;
+	ext4_group_t ac_prefetch;
+	int ac_prefetch_ios; /* number of initialized prefetch IOs */
 };
=20
 #define AC_STATUS_CONTINUE	1
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index eb1efad0e20a..a14ce23c1444 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -186,6 +186,8 @@ EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
 EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
 EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
 EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
+EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
+EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
 EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.inter=
val);
@@ -215,6 +217,8 @@ static struct attribute *ext4_attrs[] =3D {
 	ATTR_LIST(mb_order2_req),
 	ATTR_LIST(mb_stream_req),
 	ATTR_LIST(mb_group_prealloc),
+	ATTR_LIST(mb_prefetch),
+	ATTR_LIST(mb_prefetch_limit),
 	ATTR_LIST(max_writeback_mb_bump),
 	ATTR_LIST(extent_max_zeroout_kb),
 	ATTR_LIST(trigger_fs_error),



