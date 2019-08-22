Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1F98DA7
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfHVI07 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 04:26:59 -0400
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:44341
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731002AbfHVI06 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Aug 2019 04:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAev75N830kTJnnWK8liSJtQ+R2y6uuxxmMlYxUfkvymQPAF2vbxiuUF4e0gbKy7BB9qzaW5klbUsblI8/ih+LTOZuguv+aEvZFz3TmkoowxKfMZ71Ju99a23uODrxSA1UvZY8ugoCsMmf0Ol/PGpSjZeknQlKYujoYfBjMkIKSOD9JIm8bH8i9UIYADpcny33An7F9GRqc5R7IHypDL3vlP2Lb8JELQtIvtCJoC59OW1F5MGyauXM9ZhokE/aC3cYRXR2LFIxWEvENJhXhyPwU/6gT0WzTDLV4IrxZyqYlxlgQxnqSMXCnMiuJicpMzO2Lfj9dPSORcweNxWX8Fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDgdYrGJwlidN5ze1xlZJMNNZgR5rMkucms7pyJi3ew=;
 b=KEmztfHl9iuVy8oHc8nzsiaF0Vq8ehYnVo+rA4Ct/98xy0nnaxfOZtmYZ5FBgXgWiwOeVnZoyxaoqBKwBmS9F+tREwG+mZuzcD0dsdebhuUcZJeuDnXdcaSZxgSY7LDB2PLVAqBPb2dnSNOh6PVSoSFZoX8zUNYbDf5VPhcgrKgNaJeY5m3rb2p7+tuWoHPj1YdZkm9kZ6C8BZOZWy5/OFQAKJ3b/07h1J+tWkJ9HA7cRWzSeS/byZa9Th2XUxhnJtNCkpgj28tGkiAP8TkqTKPoZRYCJHSPlGS3v/eEZ1PPLkhg39ttSOdmn8Tie0uD8mwP9uUE5WtyoMQY0UpvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDgdYrGJwlidN5ze1xlZJMNNZgR5rMkucms7pyJi3ew=;
 b=Dpd8d9RGMK2Td8tCPg3AKP13XRs8kIKTseNQIOCyiKkW4pG5DFlm1+/rUjB8+NjeV/8QbGNNmQF5QCWJb7prQlPtmCEKJhwpqebJeoAivYPd9eDNJ91kflNOqNxuaR7M1UfGcClvg2zS/zy2E8nAEeCDLk4jOKSoh49Nq6UbzjU=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2196.namprd19.prod.outlook.com (52.132.23.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 08:26:47 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 08:26:47 +0000
From:   Dongyang Li <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH v2 1/4] libext2fs: optimize ext2fs_convert_subcluster_bitmap()
Thread-Topic: [PATCH v2 1/4] libext2fs: optimize
 ext2fs_convert_subcluster_bitmap()
Thread-Index: AQHVWMNWV7baaE571kmJTLMb3XylQQ==
Date:   Thu, 22 Aug 2019 08:26:47 +0000
Message-ID: <20190822082617.19180-1-dongyangli@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:404:42::16) To BL0PR1901MB2004.namprd19.prod.outlook.com
 (2603:10b6:207:38::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dongyangli@ddn.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.1
x-originating-ip: [220.233.193.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2267a6f4-966b-4cf0-6960-08d726da78cf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL0PR1901MB2196;
x-ms-traffictypediagnostic: BL0PR1901MB2196:
x-microsoft-antispam-prvs: <BL0PR1901MB2196590A2645860E09687BCBCDA50@BL0PR1901MB2196.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39850400004)(136003)(346002)(396003)(376002)(199004)(189003)(1076003)(71200400001)(256004)(81156014)(486006)(8676002)(476003)(2906002)(8936002)(66066001)(6916009)(25786009)(64756008)(4326008)(66946007)(3846002)(2351001)(5660300002)(6116002)(2616005)(66476007)(66446008)(66556008)(71190400001)(50226002)(316002)(186003)(86362001)(36756003)(6436002)(14454004)(99286004)(478600001)(386003)(5640700003)(6486002)(2501003)(26005)(6512007)(52116002)(102836004)(7736002)(6506007)(53936002)(305945005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2196;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S/IIctyTPZzpvhYPWNPqDtTi3UeVQctvdAq9blaScNz8NZItMS80YV6PS8wCtz7dHuyN3v3BP69uUkM4wVG2fTlNnZwtKsZGv+UH6xhbrf7SHA4eoYinbNQ0xSXTs/KRGMZZeTIrVr/ShAAFitmS9D2CwVo6GxZMsIHbzzoSKX+/xyLeGjdo+EwQbW+GwOMOVfkM9o1hCmHTLNA3lo0IX1HFrtKbCcfvtAGpCbeRE4loASWYNOX7vglhbD4HcAz/hBKi3T36fptMao+zH1EoL9a6i9w5TtqSxqyIulExag9g5F0Nz6Xb6spCv+hhcjkWnIrpan/D1YJLp0CIMTDBa0dGdROK2yjyDF3WEZNH+wV1iuD7lv0tTesago65J9lj8J9T6d37S7v5wr6SGHRTrNNEaKI/PD0smrMyGVgUGxE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2267a6f4-966b-4cf0-6960-08d726da78cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 08:26:47.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5B8oMSsW3d9JtydiqlQLEzssDodeaxHP76+y+i1Q3VoXITyoAEczfl6TkJlQ9Rr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2196
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
2.22.1

