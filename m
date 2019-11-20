Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E2103293
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 05:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfKTEgE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Nov 2019 23:36:04 -0500
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:29084
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727359AbfKTEgE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 19 Nov 2019 23:36:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+pnUWQCLnBVfLJTN7vFrryB8ULdU6jvBk/hNXLbrSflKHEazvmNLHMgoVx1v2Inm6+EVEVptK3DGccEB2XGsiAXGqtzhgmoZp7Oq3uJwe21SDWq3Jb2WJGizH/bxbxUFCf5pJBlzgTBusrbKMWdb2kND9loInpxYJzAX40KgsktV5pOxshBZ1kqzWB0rkLUe/TE0Wduzyh7fzuXIIwgiPAWv6y9jp/L9TWI693w/HGSeyABYseWsVuPuJbO8+ikOzSJVsiThxZtNNF6YDF3wRx0toX86R+Pu+Hc8AmMfzGMipLaCmMAUqVC7lRJ8bzyzMhR4UjAa73pIUorBp1Cww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlxIjpnQGhb+LswSvb9frci0u3Jl+YuVlHoob8qDJag=;
 b=cVjZL3PezeY/C2qCfSrzDK93fm9gaEqXPnGVh1wEZesMslvBBi0TQQ0SBSsrYQ5LES9Ual+mBZdoFQSQlRClDyR50ZjaD3FpSq3Sv53E8GNO/ghDzt514IEdV1SkhtNWzmwb45H4yuQaa9tUefp/kgHB9Noc0vvz6xXMILGvSUx9EEIz2JozfSljC8AgR1OEtaV89sj1aujiubzsmfwGzp3NbGxTTPTU2YX+evCi5OjOKC5F6QRv04Mdqr8f6D0gQrwYseMQpHuMKU8Au6AIUvvAc6F5PY7Y+h07vqG9mfHdepCHNdXd+xumS9syhKOmFvqpfeQXkac3U0nKDzWCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlxIjpnQGhb+LswSvb9frci0u3Jl+YuVlHoob8qDJag=;
 b=B17r47U1K90gpIbOUu5/OATywWWEaItsoc2yBL1KvDkEbzdq5OxBZkeEc8eMKUbOzu6wCOahcSPgWPee5MsDMKb0JsQweJU9bq674YaGM6uMlxhDN9uZ/TVE9GQjirSQY/hsaVJpxhE2cBr893p/4X0KRBn+4nwyJ7E/96lHJnM=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2002.namprd19.prod.outlook.com (52.132.17.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Wed, 20 Nov 2019 04:35:30 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8587:2f91:6a7b:8655]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8587:2f91:6a7b:8655%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 04:35:30 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH v3 5/5] ext4: record overhead in super block
Thread-Topic: [PATCH v3 5/5] ext4: record overhead in super block
Thread-Index: AQHVn1vwCuCxh8H040+zNz2bV0dPog==
Date:   Wed, 20 Nov 2019 04:35:29 +0000
Message-ID: <20191120043448.249988-5-dongyangli@ddn.com>
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
x-ms-office365-filtering-correlation-id: 0d784180-0be7-4f1c-0da5-08d76d73124d
x-ms-traffictypediagnostic: BL0PR1901MB2002:
x-microsoft-antispam-prvs: <BL0PR1901MB20020B787AF6EF4A2D362D9EBA4F0@BL0PR1901MB2002.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:51;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(376002)(346002)(136003)(366004)(189003)(199004)(66446008)(64756008)(66556008)(66946007)(26005)(66476007)(6116002)(3846002)(66066001)(76176011)(102836004)(5660300002)(1076003)(6916009)(52116002)(305945005)(6512007)(7736002)(36756003)(4326008)(446003)(11346002)(6486002)(8936002)(186003)(2616005)(81166006)(5640700003)(81156014)(50226002)(25786009)(8676002)(256004)(14444005)(6506007)(386003)(2906002)(478600001)(99286004)(2501003)(14454004)(2351001)(71200400001)(71190400001)(316002)(486006)(6436002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2002;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 62LVaf2hA/DbqWfFDIO+AT1Mh+7tpazYSzcPEAS+gvwXR1mpB38uSnT0UR5H9Juhslkkp4Xdh1y784UM8dgU1RMLSCf0aXQwwit5aSi9jYL4h9H+KvjmED7iybkk1IuUb050LrcJ37zveaseYRmg7AaQQ05R4A2cPrMTYYkKrO/UlX5Ov1xy/WzSMUJNXxVPQG3xkWh0wf8tXkmxSYd7YpRVVRXDPfD6mXPuPfsrplGunMT8QRSHBer7OyZf2O1NsGsJlYHaLv/l934F9fBSO2qrgzPitSD2jkR7O4iN+fErTQfMDtJXrXtTKEc2v2nGRTayrl1W+z102elybmj52bMp3GsXXDNH7LlHZPDxC5xVSBtQwu68kbG7NtT3qEsrk8AnZEv3KzKeqR5zfzYD0Sx3KyYs3FXbGriSfC6XSp33i2UqQ0zHqTpru3XGntJf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d784180-0be7-4f1c-0da5-08d76d73124d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 04:35:29.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /j3NozRvzDgfnH16F2FDxsyvjMwX8lAwPovP97HKbmB8FqTpZT8/VSlOV/vAX7D4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2002
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Store the overhead in super block so we don't have
to calculate again during next mount.
It also gets updated after online resizing.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 fs/ext4/resize.c | 1 +
 fs/ext4/super.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index c0e9aef376a7..edab58c8ff20 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1431,6 +1431,7 @@ static void ext4_update_super(struct super_block *sb,
 	 * Update the fs overhead information
 	 */
 	ext4_calculate_overhead(sb);
+	es->s_overhead_clusters =3D cpu_to_le32(sbi->s_overhead);
=20
 	if (test_opt(sb, DEBUG))
 		printk(KERN_DEBUG "EXT4-fs: added group %u:"
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..c859c67cd5db 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4467,6 +4467,10 @@ static int ext4_fill_super(struct super_block *sb, v=
oid *data, int silent)
 		err =3D ext4_calculate_overhead(sb);
 		if (err)
 			goto failed_mount_wq;
+		if (!sb_rdonly(sb)) {
+			es->s_overhead_clusters =3D cpu_to_le32(sbi->s_overhead);
+			ext4_commit_super(sb, 1);
+		}
 	}
=20
 	/*
--=20
2.24.0

