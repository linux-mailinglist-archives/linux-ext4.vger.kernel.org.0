Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B08F986
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2019 05:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfHPDtS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Aug 2019 23:49:18 -0400
Received: from mail-eopbgr730062.outbound.protection.outlook.com ([40.107.73.62]:47904
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfHPDtR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Aug 2019 23:49:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2hlrhD5htbUO2hk/T+Es90FVdzjb78KIT976TDwQgnfOWeBLlHaUJrs7bkztwiyqnT0XQWLVcHtM64KD0cUij5VvV4rTePx5Uz/VNSxaOLxQqda2ahUd/eLCEclaYRaWulHtRg7pp7b0AmNFSZIuhqkJTFQVZmGDcCwnIPSasoYctOaIoF2bOkD53oOyEqnPHeI7bA09MejJ8pvk0pmvnxHDNQHQEF/hfJdwNLqklNMo/gE+TZBLqCheBV49v+3yGUUdL6zk4xDWLA63KU85RquiwxjzyuzxoppSCmSkBtllJBbuniqFQyMoB/07K7/GX5jqvCmHeGjUiJThmETyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3SFQTGznjkWDvcTJ5DZvJdTH0lSVJygiagCWfxQSRs=;
 b=AMOrDviF/yagu/Bqxb0SK7z0Ir7X7LLYwT+ykCNR5/vJ5aGrhRNoEyK6eNhZjxKcyNceE7m0tRsATsV+reWEEl4ZhossjR+SuMO5Rev4PRW1a0sZlKhItrcUgUzhum22BhXyN7+genTPLyzOH5lvcuBiwGt9tRj0qug+NZkZxwcZIQVys+ed/wei7yLMCJgJp8Hw6q/PL4ZkRmFQvUZpOF0AAUKrvp6WZSy6Z/3uGVfw5M4+U0jonElCvXoooYJkTbeqC0fLrXsgEextVyzDIUOHdxhHeKkky4SvyZwVtV8fzQUa6JfMQh9mTumCNwcPJ9I8C4xa6rphyp+NWADDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3SFQTGznjkWDvcTJ5DZvJdTH0lSVJygiagCWfxQSRs=;
 b=Lba6HY+mCOo0MnrnEBcF9Y5z0hCHEI4sJAujj4qcpLtOxFj4/t3t9XdYOQIRmuDgDuaoz6COjrIjHVX3C1d7HCJhnMPK/KxiB5HksR83odJFhUCHnr5kOobFB090uiEgxcRYDhjckFVtNJBU5O6HRJkjuUMlNFCPBAPi6NCJPis=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2036.namprd19.prod.outlook.com (52.132.25.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Fri, 16 Aug 2019 03:49:13 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737%7]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 03:49:12 +0000
From:   Dongyang Li <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH 1/2] libext2fs: optimize ext2fs_convert_subcluster_bitmap()
Thread-Topic: [PATCH 1/2] libext2fs: optimize
 ext2fs_convert_subcluster_bitmap()
Thread-Index: AQHVU+WRSVrR0wfOJEiX477ZjZ6FYw==
Date:   Fri, 16 Aug 2019 03:49:12 +0000
Message-ID: <20190816034834.29439-1-dongyangli@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYAPR01CA0031.ausprd01.prod.outlook.com (2603:10c6:1:1::19)
 To BL0PR1901MB2004.namprd19.prod.outlook.com (2603:10b6:207:38::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dongyangli@ddn.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.1
x-originating-ip: [220.233.193.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e211b553-a843-4bce-244f-08d721fcb396
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR1901MB2036;
x-ms-traffictypediagnostic: BL0PR1901MB2036:
x-microsoft-antispam-prvs: <BL0PR1901MB2036042AF55FAC62A4664AE8CDAF0@BL0PR1901MB2036.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(2351001)(26005)(6916009)(486006)(186003)(66556008)(7736002)(64756008)(66476007)(52116002)(6506007)(14454004)(2616005)(3846002)(6436002)(66946007)(36756003)(6116002)(66066001)(50226002)(8936002)(86362001)(476003)(102836004)(386003)(66446008)(1076003)(478600001)(2501003)(99286004)(25786009)(53936002)(5640700003)(2906002)(6512007)(305945005)(8676002)(71200400001)(71190400001)(5660300002)(81166006)(6486002)(256004)(316002)(4326008)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2036;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ADAXlZQq4VBzTrVDkaX1KaYwqZfQdXO8A/y/oU0ptkCg4zfUUHj8dxn2h/h8Mp8oS/gRbjwh0YcmKHIvZ8im1Jp74gDXPvNJ4qa5jA0uMI+CBzyz5Jplp1v6TMBb3BuepWFdo0axgUnA+pUg70EV1niJGgGYyp1gBydffyHNST1alo4RE++/AGp5fKm1UY6zBf4rWIPV+6ekmQWqo03GyB5IMTIRu/ABNMNDdk1dXG6G7i2VEBz/3cYL6mi3pNw3egUk6Wvln16FmLmxwa7wvMpk66xepoLVeNmC4L7Si3ptc1UXOwnryH9GNf7AG+bFAlsu47MrIm1pwSZRhb2E9ZGsj/Io5AJ5xitqsxszVeLWXx39c7NAZWqYRdvBR9wFF+ojCfHsh1w2bPUVJi2V3BGxHYCC35UIdWHMRjmL7mA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e211b553-a843-4bce-244f-08d721fcb396
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 03:49:12.7679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWav5XxtRqrPYhcdjtZGNVu0t1fTqCdP1QYDJzoQNY1AEJXH918Bgb+ezKZZV3zG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2036
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

e2fsck can also benifit from this during pass1 block scanning.

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
---
 lib/ext2fs/gen_bitmap64.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index 6e4d8b71..97601232 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -28,6 +28,7 @@
 #ifdef HAVE_SYS_TIME_H
 #include <sys/time.h>
 #endif
+#include <sys/param.h>
=20
 #include "ext2_fs.h"
 #include "ext2fsP.h"
@@ -799,8 +800,8 @@ errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys =
fs,
 	ext2fs_generic_bitmap_64 bmap, cmap;
 	ext2fs_block_bitmap	gen_bmap =3D *bitmap, gen_cmap;
 	errcode_t		retval;
-	blk64_t			i, b_end, c_end;
-	int			n, ratio;
+	blk64_t			i, next, b_end, c_end;
+	int			ratio;
=20
 	bmap =3D (ext2fs_generic_bitmap_64) gen_bmap;
 	if (fs->cluster_ratio_bits =3D=3D ext2fs_get_bitmap_granularity(gen_bmap)=
)
@@ -817,18 +818,14 @@ errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsy=
s fs,
 	bmap->end =3D bmap->real_end;
 	c_end =3D cmap->end;
 	cmap->end =3D cmap->real_end;
-	n =3D 0;
 	ratio =3D 1 << fs->cluster_ratio_bits;
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
+		i =3D bmap->start + roundup(next - bmap->start + 1, ratio);
 	}
 	bmap->end =3D b_end;
 	cmap->end =3D c_end;
--=20
2.22.1

