Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B296B201A38
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394939AbgFSSXZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Jun 2020 14:23:25 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:12305
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388666AbgFSSXU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 19 Jun 2020 14:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/nwiB3pXwYUxR6ubNk5OnSKng4BGp2BP0IBfwZ6QAEV2IVpiWU0p9D3MKk9WaLrV2ulLnYH/IwxB8OY5ejjy+2CNpeW+RF6pxQDF+zsEeli9JyPjjfdo+5fHzG+k4R7btCPMhFM32werBLoFOqBkBHHXPyfCtF+U/GuVJin75pVKrkbZI8lQ4/yMFz/gmR6M0yb92PARqCPeaV8stlAzalHColSiFQoc0m809KN6PbICKW8X/9nNyXWQP/C7wd5Wf+pfVXaXQMWioYfY2VRLggbIwfDsLskYNhy38m7OXLonIbUdIvzHTuvaW5etT5K89H4gSTyfEHkV1WJyYalWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0cQjv1UWSAuHuPu56qGsvXBjfDrjYgpCchlGy3s7Do=;
 b=Vicid24qcHQazWFICQ4KcrJbZaT1rmIBqH+huqz9y3M2CDDIpIY3Dl9591OmWiIUQeaYIokUTstHB6udcac4Cz7NMb7n5Xk1SvadTW+I67vRKANh2vDjdvY/aI5o0e6tQ1WRvQM6aYTbkEaXsjhNBTF9G2PejovPPkO7zZXOrs/lPK2WGctIEhqjyyNmE45BEYr5jnt2zWTf6U4POUd/fQ4eL123ld+tBpJa8fT6WDPScPg+qvxgy7jipeC+GKV0lpwjLwztW236qvC3lwX5DpJ9FFMsc2BAakUYC3s6HLeWJDEmadG6t6jUEOjMAkMixc+fI2DfwA0l/M9xqz7kyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0cQjv1UWSAuHuPu56qGsvXBjfDrjYgpCchlGy3s7Do=;
 b=a3CYFvX8XNzg7GWypKlv4mwzfdadkyi9DUVvTvedf/U2DCREQAMS8ZFl/uU+SrOm85YPvUw5xF2r93aYtTHpEllEBGm9APjmCztsvCJPeK6ksDwhGPzgRbjKzZxUCKfCzIIV7UrCy/eASu6xAhJ+nlxMv1jIX5JtAhCxv+pKdIA=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM5PR19MB0922.namprd19.prod.outlook.com (2603:10b6:3:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Fri, 19 Jun
 2020 18:23:15 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::f1b0:78b:8c87:47c3]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::f1b0:78b:8c87:47c3%4]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 18:23:15 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        =?koi8-r?B?4szBx8/EwdLFzsvPIOHS1KPN?= 
        <artem.blagodarenko@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps
Thread-Topic: [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps
Thread-Index: AQHWKqCXlzEPeqf4R0Gj8cV11zoPPqi/VJEAgADU+4CAIDv+gIAAEpgA
Date:   Fri, 19 Jun 2020 18:23:14 +0000
Message-ID: <677D0073-DD4B-46A0-9076-A1A70BF6F3DA@whamcloud.com>
References: <262A2973-9B2D-4DBE-8752-67E91D52C632@whamcloud.com>
 <90289086-E2DD-469A-86E2-3BB72CAC59E0@gmail.com>
 <895DB4D0-0F00-4467-A87F-33222443615A@whamcloud.com>
 <20200619171641.GA3963397@mit.edu>
In-Reply-To: <20200619171641.GA3963397@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=whamcloud.com;
x-originating-ip: [95.72.151.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbde9356-40c6-4cb8-ed5b-08d8147dd525
x-ms-traffictypediagnostic: DM5PR19MB0922:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR19MB0922D657993BB7C7DE91571ACB980@DM5PR19MB0922.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V9ZgXJQceV5mXLFC+iI+ramvZyPMCvMyNmNPSx5b0ZrvRXAmu4g/st1o7bCZUYjXAk+4MMqSt1V4ypqZH/t/ovec4IhYUYMMbcpGjVynQEGM4FYycXKTZJvKgQHSztJ7thmvB4fa5gfaaIRinsC9xRju6k8kcABaSdOfu4LZAqn1xONIRA0kM/CjZfX2RGtT7o568r9oGAsKybnRLC/Arm3jLOecJsVgxzt2klFywqwGw0DyG54ulPTio5gIa6JqdqMqIypnx9AQAAq0F+YEc1E84cu3gwxLIiYHtaGpZJI4SUZxXf8w991J+mV9yFFA3qjNLxT6qpzoF2AjaF+tNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(366004)(66476007)(66946007)(66446008)(5660300002)(64756008)(66556008)(30864003)(76116006)(86362001)(36756003)(2906002)(91956017)(8676002)(33656002)(6916009)(6512007)(186003)(6486002)(2616005)(53546011)(4326008)(6506007)(71200400001)(26005)(83380400001)(8936002)(54906003)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5j8uWSWAS6UrlZBF9bMxdaV0Js6IhRisu/JWdCKmW0M8tLh3GcCsmKrjnUZE6ho5CTUyLH7t1sN6KBrmW4p/RiLIJGqrOHxuFWu7P1YUBMWxtKcjEDJiWU9HVfl/e0N/MpamDxsivB3uF3ZvgLDWumh/R4pTt8COLEo9McDPSakgr0sI6BzPjnwPOoRBkfpO1eWLoVcy3Lf6lJhEI1JqE9KCgNstX+2GH5Y6jDoMugAPdyg0XdnC+d5JprFvikSECoG2sM55lmpO2fvsMTcS7XB6wXhSDRmwsB8rjNBn3fCcpwptIvGW9fvB3JJnOSv/KsuFjlXdZNrwWyIICr+FjAfdjq5HSabJzpRF/o98voSsc17k1rW9Qre/chOFSpgOgUX329HgNCKuATXGfs9UPENNLAVTUPCxnvJbv0xcflPHYpQ5hMAU5Fsr54Xb+G9EXkE3PSzOkYR78fVjgmN/geXMKU++uf/A81MrbzqhJs4=
Content-Type: text/plain; charset="koi8-r"
Content-ID: <1793DE9826EA364CAF81058E3F50308D@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbde9356-40c6-4cb8-ed5b-08d8147dd525
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 18:23:15.0026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MC/28km2TwNv/sCwUBhXMpEsFjkLJ5IwvQZZPQsMvxUOvhz3xeTgbq1am0ylepgG6CEy4LJahE2gMFHcPudiIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0922
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Please find it attached, rebased against latest tree.

Thanks, Alex


> On 19 Jun 2020, at 20:16, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> I'm not seeing any newer version of this patch since the one on this
> thread, posted on May 15th.
>=20
> Am I missing something?   What's the latest version of this patch that yo=
u have?
>=20
>     	     		  	     	    - Ted


From 023a44b30b1c77873401ee310705933482a89b02 Mon Sep 17 00:00:00 2001
From: Alex Zhuravlev <bzzz@whamcloud.com>
Date: Tue, 21 Apr 2020 10:54:07 +0300
Subject: [PATCH] [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps

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
 fs/ext4/mballoc.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/mballoc.h |   2 +
 fs/ext4/sysfs.c   |   4 ++
 5 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 1ba46d87cdf1..c52011af4812 100644
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
index 42f5060f3cdf..7451662e092a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1505,6 +1505,8 @@ struct ext4_sb_info {
 	/* where last allocation was done - for stream allocation */
 	unsigned long s_mb_last_group;
 	unsigned long s_mb_last_start;
+	unsigned int s_mb_prefetch;
+	unsigned int s_mb_prefetch_limit;
=20
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
@@ -2446,7 +2448,8 @@ extern struct ext4_group_desc * ext4_get_group_desc(s=
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
@@ -3145,6 +3148,7 @@ struct ext4_group_info {
 	(1 << EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT)
 #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
 	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
+#define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
=20
 #define EXT4_MB_GRP_NEED_INIT(grp)	\
 	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
@@ -3159,6 +3163,8 @@ struct ext4_group_info {
 	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
 #define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
 	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
+#define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
+	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, &((grp)->bb_state)))
=20
 #define EXT4_MAX_CONTENTION		8
 #define EXT4_CONTENTION_THRESHOLD	2
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9d69f0a1372d..88af980e945e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -922,7 +922,7 @@ static int ext4_mb_init_cache(struct page *page, char *=
incore, gfp_t gfp)
 			bh[i] =3D NULL;
 			continue;
 		}
-		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group);
+		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group, false);
 		if (IS_ERR(bh[i])) {
 			err =3D PTR_ERR(bh[i]);
 			bh[i] =3D NULL;
@@ -2244,6 +2244,91 @@ static int ext4_mb_good_group_nolock(struct ext4_all=
ocation_context *ac,
 	return ret;
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
+	/* limit prefetching at cr=3D0/1, otherwise mballoc can
+	 * spend a lot of time loading imperfect groups */
+	if (ac->ac_criteria < 2 && ac->ac_prefetch_ios >=3D sbi->s_mb_prefetch_li=
mit)
+		return;
+
+	/* batch prefetching to get few READs in flight */
+	if (ac->ac_prefetch !=3D group)
+		return;
+
+	nr =3D sbi->s_mb_prefetch;
+	if (ext4_has_feature_flex_bg(sb)) {
+		/* align to flex_bg to get more bitmaps with a single IO */
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
@@ -2317,6 +2402,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 		 * from the goal value specified
 		 */
 		group =3D ac->ac_g_ex.fe_group;
+		ac->ac_prefetch =3D group;
=20
 		for (i =3D 0; i < ngroups; group++, i++) {
 			int ret =3D 0;
@@ -2328,6 +2414,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 			if (group >=3D ngroups)
 				group =3D 0;
=20
+			ext4_mb_prefetch(ac, group);
+
 			/* This now checks without needing the buddy page */
 			ret =3D ext4_mb_good_group_nolock(ac, group, cr);
 			if (ret <=3D 0) {
@@ -2402,6 +2490,10 @@ ext4_mb_regular_allocator(struct ext4_allocation_con=
text *ac)
 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr=
 %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, cr, err);
+
+	/* use prefetched bitmaps to init buddy so that read info is not lost */
+	ext4_mb_prefetch_fini(ac);
+
 	return err;
 }
=20
@@ -2648,6 +2740,25 @@ static int ext4_mb_init_backend(struct super_block *=
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
index 6b4d17c2935d..45103cdf08cb 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -171,6 +171,8 @@ struct ext4_allocation_context {
 	struct page *ac_buddy_page;
 	struct ext4_prealloc_space *ac_pa;
 	struct ext4_locality_group *ac_lg;
+	ext4_group_t ac_prefetch;
+	int ac_prefetch_ios; /* number of initialied prefetch IO */
 };
=20
 #define AC_STATUS_CONTINUE	1
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6c9fc9e21c13..31e0db726d21 100644
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

