Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509E2103290
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 05:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfKTEf0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Nov 2019 23:35:26 -0500
Received: from mail-eopbgr790084.outbound.protection.outlook.com ([40.107.79.84]:3710
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbfKTEf0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 19 Nov 2019 23:35:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUZ73t5TgjcVs2Go1aAqoGx0a67OmTOPviqMnPiuWnRoyq/MKK1f5U2PyF6IROi1NdG1s6w4mJY/Qq28gPcejZA4L5l/ZVsic1p1CmvMDZQGJrDVDHFiJ9SlY1KETEk1TtEBhEP6mwLFchjCaGVOaMnHzilLx3KMgPqCndmaHCL3fWwDAB3JTjoMLMRd3Vptsr7Ws6yK+/fdHitYYE379y9PwZIoIyPBp4Gx+IIK4CwkMeFvjubwjl3xvAsVn0CuYzOxSqMojkSHZxgIc1+E2dx/wX/CvU35BcxB61ohcvF3YEm1uT8bKQl7lpl+d+ptjsFG+XJLP4fHNEtHBerRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFEDrvto1DzvB4l7IUYyBM27uAy6swDcUDqYVJLMuDs=;
 b=WSVLi7jSBMyOVq+9MMN19gsXsppEDqU2t6Rl4P+4y266PJiJ6fmaJysZFfZhlbMi+VZ9DlWloyTCaRGbUKcUOhB4fSk/knM3LUMLw4nF9hZl33kg/WGP1f8UnxY/PsXu2GMe8SiJHWCWsPodalg16Y9ITGO+HeaDQpR/fAvSYROJGPnqK197gVzfJamfuIXDr7LoXGO/ypV4lS6BzCS5zGFAO7XlmLpz9mflgcJ9VagqmoI9PMYe1RuMPLl7sMo5km0SxHH23GNOWppTlXhwWvJsTBUOJLKmy/jpOskWLPD1eE6D3C0YBgleQni7htRLZeEPJjwNbfzzHnh57QriDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFEDrvto1DzvB4l7IUYyBM27uAy6swDcUDqYVJLMuDs=;
 b=ZExIvIQg34+p57GYj5g92qCdDkr1UEZfH9h2pkY7M6TZ7GMWB6yr8T2afNrrTJ7vG8tXRFjR8OPkOjEBBCU0Qcsw7rzJqvWC9HmP5bHTfIFleWriC6pgvmzwbf+byo4Wk7F98DN0PM+l0/Qn2YQ43RU7sAdL+1UbWiyUJnAko3Q=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2050.namprd19.prod.outlook.com (52.132.25.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Wed, 20 Nov 2019 04:35:22 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8587:2f91:6a7b:8655]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8587:2f91:6a7b:8655%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 04:35:22 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH v3 1/5] libext2fs: optimize ext2fs_convert_subcluster_bitmap()
Thread-Topic: [PATCH v3 1/5] libext2fs: optimize
 ext2fs_convert_subcluster_bitmap()
Thread-Index: AQHVn1vr3nLuCuqfSkeK2sMViUbk/w==
Date:   Wed, 20 Nov 2019 04:35:21 +0000
Message-ID: <20191120043448.249988-1-dongyangli@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0134.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::19) To BL0PR1901MB2004.namprd19.prod.outlook.com
 (2603:10b6:207:38::29)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=dli@ddn.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.0
x-originating-ip: [150.203.248.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b9be9e9-b55c-4df0-48da-08d76d730dac
x-ms-traffictypediagnostic: BL0PR1901MB2050:
x-microsoft-antispam-prvs: <BL0PR1901MB20500383EB99A744F119B886BA4F0@BL0PR1901MB2050.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(4326008)(5660300002)(25786009)(66476007)(2501003)(102836004)(26005)(7736002)(99286004)(66556008)(256004)(52116002)(2351001)(66946007)(2906002)(36756003)(6512007)(386003)(6506007)(186003)(316002)(6436002)(66446008)(5640700003)(64756008)(6486002)(8936002)(476003)(486006)(6916009)(50226002)(1076003)(305945005)(478600001)(71190400001)(71200400001)(14454004)(66066001)(8676002)(6116002)(3846002)(81156014)(2616005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2050;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: boLUOjOgTGyTj8tyRCI5mawxuytl+kPmUGxuiXZ9ZSrVza5NZKFV7FFc7McUgd1huBTKZxqQBxCXOuo/01kb57oO7RdKJP4gh0cl8fVRd8DOdR+9sEbTBzehXKRpbaKm31dsTGSho8gjfig57GsgtHFNx0HqK/XhZOEhOZDlaNLW3xvidzVjoJ9T68Raw75oQeg1Kqcao+9cbnNWY+eYPrG3VYvxWNTVds2F7bV507xirvsoSFmvF9zXRXCC7w0Znvqj/JXSWYkSAIPVO/gM68GeJ6bt7CKfLuIfi3uxFnZKOL71XhSVKYi2VTD9GLxvuMph80YYP56Ib76QX2HZ0XkI13GLFChZzUXfiwcwNNvk+BaE/uHCvPvjaDDLKrmy3/OLmGvuAjRxWVOzpSzxaCaV+xoRgjyN0Dox81gI2ReBuJc0lmI6CyXOsEPS589S
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9be9e9-b55c-4df0-48da-08d76d730dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 04:35:21.9292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCCdqU5xQQ9Xy1pNJVk4lHZM9NZRXjqSeTMrxkoNAQ2lEqMJsfuH9Qt7aJTfNqwj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2050
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For a bigalloc filesystem, converting the block bitmap from blocks
to chunks in ext2fs_convert_subcluster_bitmap() can take a long time
when the device is huge, because we test the bitmap
bit-by-bit using ext2fs_test_block_bitmap2().
Use ext2fs_find_first_set_block_bitmap2() which is more efficient
for mke2fs when the fs is mostly empty.

e2fsck can also benefit from this during pass1 block scanning.

Time taken for "mke2fs -O bigalloc,extent -C 131072 -b 4096" on a 1PB
device:

without patch:
real    27m49.457s
user    21m36.474s
sys     6m9.514s

with patch:
real    6m31.908s
user    0m1.806s
sys    6m29.697s

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 lib/ext2fs/gen_bitmap64.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index 6e4d8b71..f1dd1891 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -799,8 +799,7 @@ errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys =
fs,
 	ext2fs_generic_bitmap_64 bmap, cmap;
 	ext2fs_block_bitmap	gen_bmap =3D *bitmap, gen_cmap;
 	errcode_t		retval;
-	blk64_t			i, b_end, c_end;
-	int			n, ratio;
+	blk64_t			i, next, b_end, c_end;
=20
 	bmap =3D (ext2fs_generic_bitmap_64) gen_bmap;
 	if (fs->cluster_ratio_bits =3D=3D ext2fs_get_bitmap_granularity(gen_bmap)=
)
@@ -817,18 +816,13 @@ errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsy=
s fs,
 	bmap->end =3D bmap->real_end;
 	c_end =3D cmap->end;
 	cmap->end =3D cmap->real_end;
-	n =3D 0;
-	ratio =3D 1 << fs->cluster_ratio_bits;
 	while (i < bmap->real_end) {
-		if (ext2fs_test_block_bitmap2(gen_bmap, i)) {
-			ext2fs_mark_block_bitmap2(gen_cmap, i);
-			i +=3D ratio - n;
-			n =3D 0;
-			continue;
-		}
-		i++; n++;
-		if (n >=3D ratio)
-			n =3D 0;
+		retval =3D ext2fs_find_first_set_block_bitmap2(gen_bmap,
+						i, bmap->real_end, &next);
+		if (retval)
+			break;
+		ext2fs_mark_block_bitmap2(gen_cmap, next);
+		i =3D EXT2FS_C2B(fs, EXT2FS_B2C(fs, next) + 1);
 	}
 	bmap->end =3D b_end;
 	cmap->end =3D c_end;
--=20
2.24.0

