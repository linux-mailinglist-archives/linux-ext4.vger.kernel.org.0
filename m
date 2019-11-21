Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71214104AF3
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2019 08:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKUHEJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Nov 2019 02:04:09 -0500
Received: from mail-eopbgr690044.outbound.protection.outlook.com ([40.107.69.44]:15939
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfKUHEJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 21 Nov 2019 02:04:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4TqJF4KRrAtuhsz+Ug0yF9W2NTJ1+lo5D6Q9eoOEBS1OFtf375qy3P6CT/Z8CS/s/kZ2sQLQE0A1W3yXHTL57RIhiLGup9QpyPogJiMRRTH0SmxHba8FCik0mu3fg8bXrdcnsslwzykVt5uxtc1DPxdqFtBWr3pItbMqj5D7QeEe6lEQ2Q//8nChZr/XpoIfDtw+W6K5Q4msj1OsmjAfoUqOg2vH1iRqiuTK4IBNPEkh9IKA46cACCvHe9eV1ViKgEGcTR0DKO03KaY1cQ29bykgWqAYy3qbkCxcVudznoz12dVroqd0VVM55CdJUSk45YOxld/JAdbGGkn/xHR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1quu/ko+o/RaBKoo/1XRRHtIr4kZvNXLlDQKnHCnK4U=;
 b=Ct+UpmRZX0YdLwE6aOcaoENPE/Mzcv3i2pXv/nu9+tcNbXsqzF+HQWf77lHgTEmvmi7a9EV6R393Rf393cJdZ5yA8CiUUX73SW0fici1xynJZ5PKknF/34zL5iM2cGuH4iR04FKEJGDT2IKXJI3xo/bNXvS1z4Pf+Y0Yp+wsoUzdJiKM2V3qyn/bctRRGi59jOQ/yygjdK6amTz7RudgezrupfrsGzhH9d0G8023rDrzvzzyAcRSkXDw1E12VJQimzgNp094HYjZTUp9v1Sk1GkqmwV5IcWSYKBT1d+SZYdY+qRSuBGjMIUH9zmgUvE1DD4lTOIDdHKmnvocTlqVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1quu/ko+o/RaBKoo/1XRRHtIr4kZvNXLlDQKnHCnK4U=;
 b=oDSwfMeCGIv8ElUj2de0Fun0z/LJtF0TmkQI32LV5r6UCSNn6W/iGIfTD5Yow817brNO9I5sHhMdSiqPnhumU2L6pFJ516EL4XyvybZC1WyY33lqX/jj+q70qcR9stmGSTYnswQYF8iHfN4R9ikbsTSVx71z8qQKuyqyjHxq5cc=
Received: from BN8PR19MB2883.namprd19.prod.outlook.com (20.178.218.221) by
 BN8PR19MB2849.namprd19.prod.outlook.com (20.178.218.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 07:03:26 +0000
Received: from BN8PR19MB2883.namprd19.prod.outlook.com
 ([fe80::d09c:38e0:c805:f9d2]) by BN8PR19MB2883.namprd19.prod.outlook.com
 ([fe80::d09c:38e0:c805:f9d2%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 07:03:26 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [RFC] improve malloc for large filesystems
Thread-Topic: [RFC] improve malloc for large filesystems
Thread-Index: AQHVn45AfmzanBfwskq4XYElVj+Zs6eUXWuAgADXAYA=
Date:   Thu, 21 Nov 2019 07:03:26 +0000
Message-ID: <9E04C147-D878-45CE-8473-EF8C67FE4E86@whamcloud.com>
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
x-ms-office365-filtering-correlation-id: e649aa7e-ae71-406a-1235-08d76e50e80c
x-ms-traffictypediagnostic: BN8PR19MB2849:
x-microsoft-antispam-prvs: <BN8PR19MB28499340BC13ECD39F4EAEFACB4E0@BN8PR19MB2849.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39850400004)(346002)(136003)(396003)(366004)(199004)(189003)(229853002)(66946007)(66476007)(305945005)(64756008)(7736002)(66556008)(76116006)(91956017)(66446008)(256004)(14444005)(6486002)(6436002)(86362001)(8936002)(71190400001)(71200400001)(6512007)(316002)(81166006)(26005)(8676002)(5660300002)(81156014)(2616005)(6246003)(186003)(66066001)(2171002)(11346002)(25786009)(446003)(36756003)(76176011)(6116002)(3846002)(53546011)(2906002)(478600001)(99286004)(6506007)(102836004)(4326008)(6916009)(33656002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR19MB2849;H:BN8PR19MB2883.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9YPhG/bInDsGhYoO2NfVBomBJcDrVBhEgbBPLfMCHpXsCbC1dh38q8GjfPLDJwX2zbXxkAchxWhaPa4CnhYEE18oW8igpwuZldZrhRyKcEl9afcojFo3CQTswGpmwr+irtl2K9XqdB8CkamNI96yu/kCJQjeliGUJlkjvIflOU1PmE+8LItC/0mVcUwhc4YeSF9KMTviYkaTvPZTECqkW31XSPs9BS5MuIPdLqvRTCzq2ojN62NAFqcD8CVITHjOx9+P+T4ewfx8PXpvQqQLcC7XY5JSdJM4IHAG1fQGqmBO5IwVD1r6A7PLPTmVQh1ktXQLx9RUUnuTurEuMvSVYm5B0VJ01CK1NDOUkq3Ry4k8P58nftKt6sVg9V8oQrcY3x8G34NGSk6yyeaWujHhQRo7/ECJjpfUQKXlw616ylcwL6YBDxCMkqznnFn8C1U
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C6D9B1993F69946B8CA47FC4ADB3942@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e649aa7e-ae71-406a-1235-08d76e50e80c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 07:03:26.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUeTQd9K3S++xobfp4Z1SSn22QFkI6yZK2+Vq9YikywwgjfizPjPpY5poy74a6CdoRmfxCvh0BIlKBa2diiZTg==
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

This is the first patch of the series.

Thanks, Alex

From 81c4b3b5a17d94525bbc6d2d89b20f6618b05bc6 Mon Sep 17 00:00:00 2001
From: Alex Zhuravlev <bzzz@whamcloud.com>
Date: Thu, 21 Nov 2019 09:53:13 +0300
Subject: [PATCH 1/2] ext4: limit scanning for a good group

at first two rounds to prevent situation when 10x-100x thousand
of groups are scanned, especially non-initialized groups.

Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
---
 fs/ext4/ext4.h    |  2 ++
 fs/ext4/mballoc.c | 14 ++++++++++++--
 fs/ext4/sysfs.c   |  4 ++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 03db3e71676c..d4e47fdad87c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1480,6 +1480,8 @@ struct ext4_sb_info {
 	/* where last allocation was done - for stream allocation */
 	unsigned long s_mb_last_group;
 	unsigned long s_mb_last_start;
+	unsigned int s_mb_toscan0;
+	unsigned int s_mb_toscan1;
=20
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a3e2767bdf2f..cebd7d8df0b8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2098,7 +2098,7 @@ static int ext4_mb_good_group(struct ext4_allocation_=
context *ac,
 static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
-	ext4_group_t ngroups, group, i;
+	ext4_group_t ngroups, toscan, group, i;
 	int cr;
 	int err =3D 0, first_err =3D 0;
 	struct ext4_sb_info *sbi;
@@ -2169,7 +2169,15 @@ ext4_mb_regular_allocator(struct ext4_allocation_con=
text *ac)
 		 */
 		group =3D ac->ac_g_ex.fe_group;
=20
-		for (i =3D 0; i < ngroups; group++, i++) {
+		/* limit number of groups to scan at the first two rounds
+		 * when we hope to find something really good */
+		toscan =3D ngroups;
+		if (cr =3D=3D 0)
+			toscan =3D sbi->s_mb_toscan0;
+		else if (cr =3D=3D 1)
+			toscan =3D sbi->s_mb_toscan1;
+
+		for (i =3D 0; i < toscan; group++, i++) {
 			int ret =3D 0;
 			cond_resched();
 			/*
@@ -2872,6 +2880,8 @@ void ext4_process_freed_data(struct super_block *sb, =
tid_t commit_tid)
 			bio_put(discard_bio);
 		}
 	}
+	sbi->s_mb_toscan0 =3D 1024;
+	sbi->s_mb_toscan1 =3D 4096;
=20
 	list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
 		ext4_free_data_in_buddy(sb, entry);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index eb1efad0e20a..c96ee20f5487 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -198,6 +198,8 @@ EXT4_RO_ATTR_ES_UI(errors_count, s_error_count);
 EXT4_ATTR(first_error_time, 0444, first_error_time);
 EXT4_ATTR(last_error_time, 0444, last_error_time);
 EXT4_ATTR(journal_task, 0444, journal_task);
+EXT4_RW_ATTR_SBI_UI(mb_toscan0, s_mb_toscan0);
+EXT4_RW_ATTR_SBI_UI(mb_toscan1, s_mb_toscan1);
=20
 static unsigned int old_bump_val =3D 128;
 EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
@@ -228,6 +230,8 @@ static struct attribute *ext4_attrs[] =3D {
 	ATTR_LIST(first_error_time),
 	ATTR_LIST(last_error_time),
 	ATTR_LIST(journal_task),
+	ATTR_LIST(mb_toscan0),
+	ATTR_LIST(mb_toscan1),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
--=20
2.20.1


