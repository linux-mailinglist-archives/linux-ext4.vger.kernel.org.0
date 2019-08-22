Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C4C98DA5
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 10:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfHVI0y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 04:26:54 -0400
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:44341
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731002AbfHVI0x (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Aug 2019 04:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD3BwVZnxMy4pHiJCdry5gWNEYjhY4XrNRG2x5tBjPU4Tk7a8peRBou2usEkJebd7iL0lIDDt48WsoO348vmrNo8+RkchtlrRd7iNOmjj+3gMStmZoY+1KgqVAZbqo23pt7KqFTnOPWlZz1in4po2nKLrSY5UjiCyhTtgQSGPPIj5aRxFJPKrXJJeGq6VHrqOozJ7xW2Vd+qylDa8PfTkkbz4NT1wHQUyxitrBH6SoOF59DRVyRYIyAsp0eOhqmkNIfH3iNjGh9kFIbNTTfixEB9WNw3TyOJj/aDKtuNpnvAXq3MV/XUU1b0LOzGk7msnDoVZH6pOyRvMsDLE5/iuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpWzgGFIEXBCyYrkcKdSZ3uEaOkVFhGWXgyKv0D5mHM=;
 b=jlFEexb67haPhOjGFE58H4LrxL7V5AMzuUJ3LWRNFjEkkHdrrMN3vEwEF5kM5+3esmxrSmhLrGnBxqS1iA0JEjvF7nQqo295rzXkeVn2m3vZoEypXyKIBI+bt3R20oMB1LSOBFhXl+A0o8+YBCL6KFJCHdH/RQ9bH81+rkv4QMPhGzZjK13NDFBus3oc9n3r51Tg5sg0dvR7etsFZIRICR98NAfrbvyhv9qiBD5qcbSgv94JOgprsBxfTYHzcrzXqnjVOR6GVWCuaEE/NIv0oEmBd4jELjfR/t5BbcEodbF4i7IR4rTro0nNo1NyNqKMc/f5PZF80eX/9dXKXh1BwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpWzgGFIEXBCyYrkcKdSZ3uEaOkVFhGWXgyKv0D5mHM=;
 b=G1eePSijjRQmlwjZ0YXsWvFzbFaDV2H6aZ4rLZfV26G/FgtgN3AS1wy1la9KZ+YR7i+n9wKxOlG2YGejZYy92MnuuYOk0tH6feLw8/hQ/RPEe5SaBEPZ/19C//G3movhF9csPkCLK7soxpYgaOJCzw/htG6/7t5w+04ykIJ4SjY=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2196.namprd19.prod.outlook.com (52.132.23.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 08:26:49 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 08:26:49 +0000
From:   Dongyang Li <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH v2 2/4] mke2fs: fix setting bad blocks in the block bitmap
Thread-Topic: [PATCH v2 2/4] mke2fs: fix setting bad blocks in the block
 bitmap
Thread-Index: AQHVWMNXR30YlyChdEiwP1RrOlhDKQ==
Date:   Thu, 22 Aug 2019 08:26:49 +0000
Message-ID: <20190822082617.19180-2-dongyangli@ddn.com>
References: <20190822082617.19180-1-dongyangli@ddn.com>
In-Reply-To: <20190822082617.19180-1-dongyangli@ddn.com>
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
x-ms-office365-filtering-correlation-id: e1f9804e-9a93-43c7-3de3-08d726da79f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL0PR1901MB2196;
x-ms-traffictypediagnostic: BL0PR1901MB2196:
x-microsoft-antispam-prvs: <BL0PR1901MB2196EA36BA0037E560641F04CDA50@BL0PR1901MB2196.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39850400004)(136003)(346002)(396003)(376002)(199004)(189003)(1076003)(71200400001)(256004)(81156014)(486006)(8676002)(476003)(2906002)(8936002)(66066001)(6916009)(11346002)(25786009)(64756008)(446003)(4326008)(66946007)(3846002)(2351001)(5660300002)(6116002)(4744005)(2616005)(66476007)(66446008)(66556008)(71190400001)(50226002)(316002)(186003)(86362001)(36756003)(6436002)(14454004)(99286004)(478600001)(76176011)(386003)(5640700003)(6486002)(2501003)(26005)(6512007)(52116002)(102836004)(7736002)(14444005)(6506007)(53936002)(305945005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2196;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qwj5XNH3lBSwkeyUqyobrQdG8L4xPR/68KNYVXN/bXZkTMCwg0h6u4S7CPj74sxFYdAtGUJ5Dw7wBX/XqdTKhKpmuxrz617U65abMoXTwMyx33kf8UuFA4hGQL8WCpupjqNKYz7bKT+vRo8INiClfZbOyoQLSWnF5UhGe8Wcw9KMnPMoLIHL/1M5xiVB/zzrLPKmK8H7brS9AZkd7LlSX++/q/7UsFdwsZmNpM3qLVEav0ReeytzRNVoGXTAVCW4d+GzOT3PRAGSiVG/V/y0xqKaGkWCWXwBSn2FTAY45BAEil5fZtjUgHxX7GAbdFgqDocm2nLsSuYUmjTIfwzHW9mYdpu+AkIPc8xb9YRKpN5r94lBpC+BVF5IiHy1G/dAUP/4SeQvLPRL/uPDGtasdlr93cKxdt5/ML7Ch/Kn354=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f9804e-9a93-43c7-3de3-08d726da79f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 08:26:49.1235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZPrp0bywA06oO8QD9LxEg9qAoMcY3EQ/5JHRkNwtlS8RezbeiN8Jm1EFvXrL7LH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2196
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
index d7cf257e..30e353d3 100644
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
2.22.1

