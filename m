Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE3103291
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 05:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKTEf1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Nov 2019 23:35:27 -0500
Received: from mail-eopbgr740055.outbound.protection.outlook.com ([40.107.74.55]:56019
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbfKTEf1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 19 Nov 2019 23:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuwI/f6wHUv8Udr4GiLdKHWzkJ4pUl4LH7PEFpo3gP/JHfkgidwlFHSuz5g+C+3PYnpghk7RO+DuyfDDK/oqlOmUU9CfKwY/YwaqGRajV3mNHhBTQvqiwMb2kWRvdLgwqDsZhhMvDGbFv5X00BnzxkSLm+roj7vSvlOAYcWNWKIeZSXcga+qoqk+djqxL7HkZmm5oIx/yaJJPHRCByxJPZNoyI1Fz2/Uq2MRos19ceKeGqSVcHzOESRYRMj7croFSKmCc893UAqlGBzp4WCv0QQVeAhNEa4Zwf69V4GrONHK/qM2C+f37hId089M/A1FGV+h7cN+hcdTEnwDHaObWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oNur8ffPnGc4/SbmWtG8jiZAAyxy+l/JQsDT4dMT3E=;
 b=LAx7hy3G4UqpriUIFK7RPF3xpxWJn8lfBiRdA/oCxy2HWASysEiWXDn5njdshIJzdldg2KjpqWBmBLajSCCOzooSOBUbzLtjBdH+1BYqmYr/YNz1q4TwAhSr+8DhapHSV0pvbfBdoGNcYtammZO+u4aEnBX8Gnyv8djI0UY/nlBtCHhHwocctfTtbS0ySd+IX/2jY2A5vYutEtjrvRUAkCUnGKp02d5cQ8XKI+wDF+6HlwtckR2VnudVBOlCFoIXSy0mk1FTPf/Lh7mzPyVx9fuXINDUbWjZPA7q76WA9L3oTGeA28lSYG6xU2W6IL5o+D3vdgw+UDb5gjIv+Wf1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oNur8ffPnGc4/SbmWtG8jiZAAyxy+l/JQsDT4dMT3E=;
 b=VKzGOnRmPKwggRyrVbqJaF/X/mTZ1oAdfLgYesDGPkzaHqoXyZDQgnKQMdKIwkTd/UsKsEkqoFpb1WyCWrEMPaCXwHOTOKCpiI+B70lw8lgy7XTOeIMd77SqCrwg3+OBEDoPfFKWHBMfRsjLEoCB6sOeplJn8RWvC/F9OhRspzk=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2002.namprd19.prod.outlook.com (52.132.17.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Wed, 20 Nov 2019 04:35:24 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8587:2f91:6a7b:8655]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8587:2f91:6a7b:8655%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 04:35:24 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH v3 2/5] mke2fs: fix setting bad blocks in the block bitmap
Thread-Topic: [PATCH v3 2/5] mke2fs: fix setting bad blocks in the block
 bitmap
Thread-Index: AQHVn1vs9FtAuHiukkqPCXsW87kHBA==
Date:   Wed, 20 Nov 2019 04:35:24 +0000
Message-ID: <20191120043448.249988-2-dongyangli@ddn.com>
References: <20191120043448.249988-1-dongyangli@ddn.com>
In-Reply-To: <20191120043448.249988-1-dongyangli@ddn.com>
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
x-ms-office365-filtering-correlation-id: 5fe6f548-81a0-4150-af05-08d76d730eb8
x-ms-traffictypediagnostic: BL0PR1901MB2002:
x-microsoft-antispam-prvs: <BL0PR1901MB2002BD2EA5089E0026400156BA4F0@BL0PR1901MB2002.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(376002)(346002)(136003)(366004)(189003)(199004)(66446008)(64756008)(66556008)(66946007)(26005)(66476007)(6116002)(3846002)(66066001)(76176011)(4744005)(102836004)(5660300002)(1076003)(6916009)(52116002)(305945005)(6512007)(7736002)(36756003)(4326008)(446003)(11346002)(6486002)(8936002)(186003)(2616005)(81166006)(5640700003)(81156014)(50226002)(25786009)(8676002)(256004)(14444005)(6506007)(386003)(2906002)(478600001)(99286004)(2501003)(14454004)(2351001)(71200400001)(71190400001)(316002)(486006)(6436002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2002;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jB1Lv9ZgBrGlhjgG6O8MmXJk6kmNZuL6yx6zvezfWKYClm5Ao9OtlqZwGaKapvFXVS+mX7GpYdDc3LYLzoRlaRbubgSemZj3eFbetYQH9Y/pAmIlj8SWMwmo/qGBIpszK6JYb4wgZs9vktFLoopAsB8urAzUTE+LOxEdSHnfGGAjJRnYLpdQiun4Kg5vq2O+IcCCyI8kC1msyTYXsN+tax8V0y3ZJ9xO7zbUCl3HQ8+RwQdz8Ajfs604+fuWRaUvDGnNs8Nc6PV2tZI2oZrezg62urNAnPAeq4g22ZzF5pRyzlETGC0Ne+rbAqYaRjj1fI1euwS0BOtAn7L9YzWaOn336wUSQ6K7kgJmp7yyOo1u0ihShTN9vamS0uSHfpVIDOUg/ug+AcBv2UxWZPh3RnCh5WJqTODdBFWAOgncLn/9quBaNHUF6/cYft3IscpS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe6f548-81a0-4150-af05-08d76d730eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 04:35:24.3788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltkC0mfHO91DIVyxJUe6ex8L1Nyv+K3RBESPUWM+86bdx27HqlzbqPbmE0t0UVsA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2002
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We mark the bad blocks as used on fs->block_map
before allocating group tables.
Don't translate the block number to cluster number
when doing this, the fs->block_map is still a
block-granularity allocation map, it will be coverted
later by ext2fs_convert_subcluster_bitmap().

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 misc/mke2fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index ffea8233..be38d2c4 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -344,7 +344,7 @@ _("Warning: the backup superblock/group descriptors at =
block %u contain\n"
 		exit(1);
 	}
 	while (ext2fs_badblocks_list_iterate(bb_iter, &blk))
-		ext2fs_mark_block_bitmap2(fs->block_map, EXT2FS_B2C(fs, blk));
+		ext2fs_mark_block_bitmap2(fs->block_map, blk);
 	ext2fs_badblocks_list_iterate_end(bb_iter);
 }
=20
--=20
2.24.0

