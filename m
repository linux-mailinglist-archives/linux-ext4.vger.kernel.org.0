Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABBD6104AF5
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2019 08:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUHGD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Nov 2019 02:06:03 -0500
Received: from mail-eopbgr690044.outbound.protection.outlook.com ([40.107.69.44]:15939
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfKUHGD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 21 Nov 2019 02:06:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4dvBNIYWUrMVB7suzAwRlZDMDx162jA5OrE+Fj9FaIzVgqMUrK0fqO4616BL90/3pW3t7il4lYiDcGGzOCARejexuMJWzAA9YjB+5O86Ys7xheB71NoAMdqKfZ4zOk6MLUa4HvrJcBmcVBP7zf17QGRH49s0mbim0DqC2wH63X7+ltENvp+QgOwxw8vDYQGW/nV/T1fEon4pQagDvTfOWIlsy41X27DzJLGadJ154DShoCVei0odE9/dsZnEfzuwmC3lYKr8LRwS/kcnUVnXd24Yq/f93NIZN30k65J599PaceyfJ1NxZ+eQSkFWy2uBV+nhWFYI7nM3Ilq7Ewh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JPcmcEqAglbyjrL2S//HQf6v2Wduo/GtYyZllqEJ7s=;
 b=Q0J9nFlmTguj/JxOOdhxQp0TJ2xDma3jIjBQO7HpwrfRHHhr1BPq/8IQW0ZAMHk1wP8Bc8fPlAh4zMPEOsCWXJjsdfcYqJ60Mqw+ibDZejOPIPbs0Gw7EUImba2CTzcXM0IVJ9wXIEsKFKjx/VAQUd/KM//+iDETxnlcKhg43FUOgqPLRal/GPDE0yfEhOXmNLp8qxQLNe0QU57I5CPOgn9xUhbY8B66rz8WfLqEb6DW2UL37TcvWYB7wLzlO6aCZS9Cj3yN9nm2Uq4dPaYWIIa2ZKkD6fOdKNm9m6HX3JY39w0Hz69CP9hE9oO1KjqHeIRLkvDYBK8oCzOROELWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JPcmcEqAglbyjrL2S//HQf6v2Wduo/GtYyZllqEJ7s=;
 b=ithk4II2vIQTvEr0BROcfTp41mbCidpvxf8udvVj70dhUcmnAsg924zfU/I7Zs5OAYXvQEqoAk29qUPqcS9Xe902Cw6R5qtfmx42+kfauZNp+SdKAlJG+v4fWg6/rAEkvxWdSgstDHX5iX4u5l75VYQ05zobwiqv2mIx5lOhugU=
Received: from BN8PR19MB2883.namprd19.prod.outlook.com (20.178.218.221) by
 BN8PR19MB2849.namprd19.prod.outlook.com (20.178.218.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 07:03:58 +0000
Received: from BN8PR19MB2883.namprd19.prod.outlook.com
 ([fe80::d09c:38e0:c805:f9d2]) by BN8PR19MB2883.namprd19.prod.outlook.com
 ([fe80::d09c:38e0:c805:f9d2%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 07:03:58 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [RFC] improve malloc for large filesystems
Thread-Topic: [RFC] improve malloc for large filesystems
Thread-Index: AQHVn45AfmzanBfwskq4XYElVj+Zs6eUXWuAgADXJ4A=
Date:   Thu, 21 Nov 2019 07:03:58 +0000
Message-ID: <0226604E-6CB1-4418-BA83-277ED22124CB@whamcloud.com>
References: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
 <20191120181353.GG4262@mit.edu>
In-Reply-To: <20191120181353.GG4262@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [128.72.176.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eec0f02e-684a-4a0a-d581-08d76e50fad8
x-ms-traffictypediagnostic: BN8PR19MB2849:
x-microsoft-antispam-prvs: <BN8PR19MB28496DC8BD04D6273E423800CB4E0@BN8PR19MB2849.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39850400004)(346002)(136003)(396003)(366004)(199004)(189003)(229853002)(66946007)(66476007)(305945005)(64756008)(7736002)(66556008)(76116006)(91956017)(66446008)(256004)(14444005)(6486002)(6436002)(86362001)(8936002)(71190400001)(71200400001)(6512007)(316002)(81166006)(26005)(8676002)(5660300002)(81156014)(2616005)(6246003)(186003)(66066001)(2171002)(11346002)(25786009)(446003)(36756003)(76176011)(6116002)(3846002)(53546011)(2906002)(478600001)(99286004)(6506007)(102836004)(4326008)(6916009)(33656002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR19MB2849;H:BN8PR19MB2883.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cevpWvbxHBKwrxcn3B5iO1gQm7HC+8WFWbHoIF7WhbcB5g+tHWFtFpsZZ8XlF0Tgxpa8XrbwXZWBiWZanKoalVuRZidSXnQ/8qh7pQ8YaWTTKMBH8kKuQQO3Q37wXcma9UTF+vFZkKUOslxnAP3L2WpVBPX8jh65WRX6+NFDY+wlmeaKp1ftIJwv/vNI9aPWGtMd3EqNN9BdSMoPYaXfTXo9Ro9yHyroq9oOzHqNFHcQXcbqUETilyiFeBdOiRTGdPP+vjbzE6vDnD83dvWNl315bzRlvbIMn+MUedaHiz9Q8zUvk9s/eXcf5u+6/OsWlxfeW2M7swCdkLEQBYR6HPNgEugiiC+XZT6NBkdk0z3daezjZBFgHnuzWwRn8mV6xd0Ji0vjDUMbvpHb98YAX0J3m5GZQ45G6YaTf84DDfGqQ/Kn5eH6laS+y+YAF/Z
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FA47DB1DB1C6D49858BB76FC6AB9F24@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec0f02e-684a-4a0a-d581-08d76e50fad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 07:03:58.0758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34UrzeCtXFqBfPQM+3q2eB/7PRezW9/wcaKuTSB36nbcUl0EGu1+JvVOa9VWwLYyet/PTs2/L4pilehIJdAJKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR19MB2849
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On 20 Nov 2019, at 21:13, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> Hi Alex,
>=20
> A couple of comments.  First, please separate this patch so that these
> two separate pieces of functionality can be reviewed and tested
> separately:
>=20

And this is the second one

Thanks, Alex

From d2ff76d76320ade5f53002aa522b6eccfa058d47 Mon Sep 17 00:00:00 2001
From: Alex Zhuravlev <bzzz@whamcloud.com>
Date: Thu, 21 Nov 2019 10:00:07 +0300
Subject: [PATCH 2/2] ext4: prefetch bitmaps during block allocation

when the cache is cold reading bitmaps one by one can slowdown
the process significantly, especially on legacy rotating drives.
---
 fs/ext4/balloc.c  | 12 ++++++++++--
 fs/ext4/ext4.h    |  4 +++-
 fs/ext4/mballoc.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/mballoc.h |  1 +
 fs/ext4/sysfs.c   |  2 ++
 5 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 0b202e00d93f..76547601384b 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -404,7 +404,8 @@ static int ext4_validate_block_bitmap(struct super_bloc=
k *sb,
  * Return buffer_head on success or NULL in case of failure.
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
@@ -435,6 +436,13 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, =
ext4_group_t block_group)
 	if (bitmap_uptodate(bh))
 		goto verify;
=20
+	if (ignore_locked && buffer_locked(bh)) {
+		/* buffer under IO already, do not wait
+		 * if called for prefetching */
+		err =3D 0;
+		goto out;
+	}
+
 	lock_buffer(bh);
 	if (bitmap_uptodate(bh)) {
 		unlock_buffer(bh);
@@ -524,7 +532,7 @@ ext4_read_block_bitmap(struct super_block *sb, ext4_gro=
up_t block_group)
 	struct buffer_head *bh;
 	int err;
=20
-	bh =3D ext4_read_block_bitmap_nowait(sb, block_group);
+	bh =3D ext4_read_block_bitmap_nowait(sb, block_group, 1);
 	if (IS_ERR(bh))
 		return bh;
 	err =3D ext4_wait_block_bitmap(sb, block_group, bh);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d4e47fdad87c..2320d7e2f8d6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1482,6 +1482,7 @@ struct ext4_sb_info {
 	unsigned long s_mb_last_start;
 	unsigned int s_mb_toscan0;
 	unsigned int s_mb_toscan1;
+	unsigned int s_mb_prefetch;
=20
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
@@ -2335,7 +2336,8 @@ extern struct ext4_group_desc * ext4_get_group_desc(s=
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
index cebd7d8df0b8..eac4ee225527 100644
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
@@ -2095,6 +2095,48 @@ static int ext4_mb_good_group(struct ext4_allocation=
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
+	ext4_group_t ngroups =3D ext4_get_groups_count(ac->ac_sb);
+	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
+	struct ext4_group_info *grp;
+	ext4_group_t group =3D start;
+	struct buffer_head *bh;
+	int nr;
+
+	/* batch prefetching to get few READs in flight */
+	if (group + (sbi->s_mb_prefetch >> 1) < ac->ac_prefetch)
+		return;
+
+	nr =3D sbi->s_mb_prefetch;
+	while (nr > 0) {
+		if (++group >=3D ngroups)
+			group =3D 0;
+		if (unlikely(group =3D=3D start))
+			break;
+		grp =3D ext4_get_group_info(ac->ac_sb, group);
+		/* ignore empty groups - those will be skipped
+		 * during the scanning as well */
+		if (grp->bb_free =3D=3D 0)
+			continue;
+		nr--;
+		if (!EXT4_MB_GRP_NEED_INIT(grp))
+			continue;
+		bh =3D ext4_read_block_bitmap_nowait(ac->ac_sb, group, 1);
+		brelse(bh);
+	}
+	ac->ac_prefetch =3D group;
+}
+
 static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
@@ -2160,6 +2202,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 	 * cr =3D=3D 0 try to get exact allocation,
 	 * cr =3D=3D 3  try to get anything
 	 */
+
+	ac->ac_prefetch =3D ac->ac_g_ex.fe_group;
+
 repeat:
 	for (; cr < 4 && ac->ac_status =3D=3D AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria =3D cr;
@@ -2187,6 +2232,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 			if (group >=3D ngroups)
 				group =3D 0;
=20
+			ext4_mb_prefetch(ac, group);
+
 			/* This now checks without needing the buddy page */
 			ret =3D ext4_mb_good_group(ac, group, cr);
 			if (ret <=3D 0) {
@@ -2882,6 +2929,7 @@ void ext4_process_freed_data(struct super_block *sb, =
tid_t commit_tid)
 	}
 	sbi->s_mb_toscan0 =3D 1024;
 	sbi->s_mb_toscan1 =3D 4096;
+	sbi->s_mb_prefetch =3D 32;
=20
 	list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
 		ext4_free_data_in_buddy(sb, entry);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 88c98f17e3d9..9ba5c75e6490 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -175,6 +175,7 @@ struct ext4_allocation_context {
 	struct page *ac_buddy_page;
 	struct ext4_prealloc_space *ac_pa;
 	struct ext4_locality_group *ac_lg;
+	ext4_group_t ac_prefetch;
 };
=20
 #define AC_STATUS_CONTINUE	1
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index c96ee20f5487..4476d828439b 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -200,6 +200,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
 EXT4_ATTR(journal_task, 0444, journal_task);
 EXT4_RW_ATTR_SBI_UI(mb_toscan0, s_mb_toscan0);
 EXT4_RW_ATTR_SBI_UI(mb_toscan1, s_mb_toscan1);
+EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
=20
 static unsigned int old_bump_val =3D 128;
 EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
@@ -232,6 +233,7 @@ static struct attribute *ext4_attrs[] =3D {
 	ATTR_LIST(journal_task),
 	ATTR_LIST(mb_toscan0),
 	ATTR_LIST(mb_toscan1),
+	ATTR_LIST(mb_prefetch),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
--=20
2.20.1



