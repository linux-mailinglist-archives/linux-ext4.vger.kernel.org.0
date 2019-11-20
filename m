Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A0E103292
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 05:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKTEf2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Nov 2019 23:35:28 -0500
Received: from mail-eopbgr740055.outbound.protection.outlook.com ([40.107.74.55]:56019
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbfKTEf1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 19 Nov 2019 23:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAXD/+jAjgPtODcAAdITzSaitdnlSv5Uc0Cv40SSUF7AKoCNPcIXAT9bITnPQA+OlpgbAkeCWN7oiUykJZ2hmP+s1hj9ehlMZA012dZEc5KqLlRZKqecS8VS/Ms26us7hdWT92P2BD9/oesX8rbiuj6EWXsBUlnGalZoGXc+fFgz4ufmpRehkF/B3n2qEvo1Duuyt8XYpXm0YQ5FJ2RBOsMhuSW/gfYpbbezQ9mst/ejwsczYVowAXjJKH4afVw1IDJHcopbhFQadCt6S/SDk9+vVBmFrdoxDAXEay5ZJndITYTUxHZC+WE+gjLBw0YVkcoGe2zcwwE+CRacu0KQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxAPbM6gPG0GCuvSlAB7lIPmxNVCg4RB9do4hQJJqAc=;
 b=G3JSht3ctzUnBIZMgYXwPZOckiaoPsOpSkEPedGAjpQKwtnlLVrpIpvKLpBs2EHHzG8s10lHriqyhv6wFoFEmBYBevbEzPJdCmTfiHCIu+VyLmTWL9FXPXxAH2i5hbbvZttXHVqUho6rPuEY5XnVo9DqfkoU8v/u0KzL6t5kHVVVEAPQuJTag+8UYyLwtcdgajPGg/wbWqcQJ87YvwlpaQi+NOk5IYZvcvlwG8gPFUA9KINb2AHQtbk8cro9X70U5TOvYaNrmR7Zisa5PoYCAspjzZkRSlO/Ho7HNXqzeN2poHujJODRO32LSYtFXHLikR1uwXAESSoWFcyg5vAeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxAPbM6gPG0GCuvSlAB7lIPmxNVCg4RB9do4hQJJqAc=;
 b=goGoj+D0yRgUgtwvkzp02O1FlAYPq+77ypRsZFtdxiyloCCO3A8TlqkvsXq9ojBdWGToh3ORE8w7uZEk3Hk1t5ahRAQh071VlpWz/gvWLktQkWrOPfSUzdBce1XpBlEcju/ZhQrO/4YeAsknoygFCv9y64iwF4I+Sc9NxRBmx94=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2002.namprd19.prod.outlook.com (52.132.17.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Wed, 20 Nov 2019 04:35:26 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8587:2f91:6a7b:8655]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8587:2f91:6a7b:8655%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 04:35:26 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH v3 3/5] ext2fs: rename "s_overhead_blocks" to
 "s_overhead_clusters"
Thread-Topic: [PATCH v3 3/5] ext2fs: rename "s_overhead_blocks" to
 "s_overhead_clusters"
Thread-Index: AQHVn1vtM42MghAqPECfuY10H3Mk5Q==
Date:   Wed, 20 Nov 2019 04:35:25 +0000
Message-ID: <20191120043448.249988-3-dongyangli@ddn.com>
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
x-ms-office365-filtering-correlation-id: e0dfba44-0187-46f6-6662-08d76d73104f
x-ms-traffictypediagnostic: BL0PR1901MB2002:
x-microsoft-antispam-prvs: <BL0PR1901MB2002E53603B6A992C6DCC395BA4F0@BL0PR1901MB2002.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(376002)(346002)(136003)(366004)(189003)(199004)(66446008)(64756008)(66556008)(66946007)(26005)(66476007)(6116002)(3846002)(66066001)(76176011)(102836004)(5660300002)(1076003)(6916009)(52116002)(305945005)(6512007)(7736002)(36756003)(4326008)(446003)(11346002)(6486002)(8936002)(186003)(2616005)(81166006)(5640700003)(81156014)(50226002)(25786009)(8676002)(256004)(14444005)(6506007)(386003)(2906002)(478600001)(99286004)(2501003)(14454004)(2351001)(71200400001)(71190400001)(316002)(486006)(6436002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2002;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XUZjjen9km0ByVpYh73jVTPL5xxgyamf6qbRxKAoFqFqz7YDOCgPEvm0N/O1C9GQfmAVhtUZ0rzAI3mkQ+pGeNDwNujXroKgFBdBQfy9jbApGIOzZCU6jZukmVI2HV2eETp3alSI5b4fo88DVscwad/y6+P7/Z78Tl7WETQEluTnoZEm8rwk3FzuWJ+qCZOYkjjzFjrn1Z9EkGOhU9F36g6AIpfJxEz4YoZS1n0CaAtsEHJvvScZcd4BYPTzqhKjww3/xGZXI1FQN9/87uyvpCGZE+AHqTxvd+ivtxSMGVCbbQSGZQJJJXcl1Sgxt458EceoMzwYRLRZsD6L17fM4ZpQQJu6JOXAYoKQIkApf7NoSTEFINWMIPneZRgMIWfhGmY0IV/Ho5NJvEpGHRtoBGXpyAmMHW5oNMtLDLHXY5xhdv4JznOyJhDHScd1VrVU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dfba44-0187-46f6-6662-08d76d73104f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 04:35:26.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7L7frmj5lK4rKxT6gpUSwgYc+ptKZkKu0LlpaXSK1nPg2SKdIeJ7HpY/Yk1+ycd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2002
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rename s_overhead_blocks field from struct ext2_super_block to
make it consistent with the kernel counterpart.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 debugfs/set_fields.c        | 2 +-
 lib/e2p/ls.c                | 6 +++---
 lib/ext2fs/ext2_fs.h        | 2 +-
 lib/ext2fs/swapfs.c         | 2 +-
 lib/ext2fs/tst_super_size.c | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/debugfs/set_fields.c b/debugfs/set_fields.c
index 5142554d..f497bd92 100644
--- a/debugfs/set_fields.c
+++ b/debugfs/set_fields.c
@@ -160,7 +160,7 @@ static struct field_set_info super_fields[] =3D {
 	{ "usr_quota_inum", &set_sb.s_usr_quota_inum, NULL, 4, parse_uint },
 	{ "grp_quota_inum", &set_sb.s_grp_quota_inum, NULL, 4, parse_uint },
 	{ "prj_quota_inum", &set_sb.s_prj_quota_inum, NULL, 4, parse_uint },
-	{ "overhead_blocks", &set_sb.s_overhead_blocks, NULL, 4, parse_uint },
+	{ "overhead_clusters", &set_sb.s_overhead_clusters, NULL, 4, parse_uint }=
,
 	{ "backup_bgs", &set_sb.s_backup_bgs[0], NULL, 4, parse_uint,
 	  FLAG_ARRAY, 2 },
 	{ "checksum", &set_sb.s_checksum, NULL, 4, parse_uint },
diff --git a/lib/e2p/ls.c b/lib/e2p/ls.c
index 5a446178..5ca750f6 100644
--- a/lib/e2p/ls.c
+++ b/lib/e2p/ls.c
@@ -272,9 +272,9 @@ void list_super2(struct ext2_super_block * sb, FILE *f)
 	fprintf(f, "Inode count:              %u\n", sb->s_inodes_count);
 	fprintf(f, "Block count:              %llu\n", e2p_blocks_count(sb));
 	fprintf(f, "Reserved block count:     %llu\n", e2p_r_blocks_count(sb));
-	if (sb->s_overhead_blocks)
-		fprintf(f, "Overhead blocks:          %u\n",
-			sb->s_overhead_blocks);
+	if (sb->s_overhead_clusters)
+		fprintf(f, "Overhead clusters:          %u\n",
+			sb->s_overhead_clusters);
 	fprintf(f, "Free blocks:              %llu\n", e2p_free_blocks_count(sb))=
;
 	fprintf(f, "Free inodes:              %u\n", sb->s_free_inodes_count);
 	fprintf(f, "First block:              %u\n", sb->s_first_data_block);
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index 3165b389..7fa8406f 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -742,7 +742,7 @@ struct ext2_super_block {
 /*200*/	__u8	s_mount_opts[64];
 /*240*/	__u32	s_usr_quota_inum;	/* inode number of user quota file */
 	__u32	s_grp_quota_inum;	/* inode number of group quota file */
-	__u32	s_overhead_blocks;	/* overhead blocks/clusters in fs */
+	__u32	s_overhead_clusters;	/* overhead blocks/clusters in fs */
 /*24c*/	__u32	s_backup_bgs[2];	/* If sparse_super2 enabled */
 /*254*/	__u8	s_encrypt_algos[4];	/* Encryption algorithms in use  */
 /*258*/	__u8	s_encrypt_pw_salt[16];	/* Salt used for string2key algorithm =
*/
diff --git a/lib/ext2fs/swapfs.c b/lib/ext2fs/swapfs.c
index a1560045..63b24330 100644
--- a/lib/ext2fs/swapfs.c
+++ b/lib/ext2fs/swapfs.c
@@ -121,7 +121,7 @@ void ext2fs_swap_super(struct ext2_super_block * sb)
 	/* sb->s_mount_opts is __u8 and does not need swabbing */
 	sb->s_usr_quota_inum =3D ext2fs_swab32(sb->s_usr_quota_inum);
 	sb->s_grp_quota_inum =3D ext2fs_swab32(sb->s_grp_quota_inum);
-	sb->s_overhead_blocks =3D ext2fs_swab32(sb->s_overhead_blocks);
+	sb->s_overhead_clusters =3D ext2fs_swab32(sb->s_overhead_clusters);
 	sb->s_backup_bgs[0] =3D ext2fs_swab32(sb->s_backup_bgs[0]);
 	sb->s_backup_bgs[1] =3D ext2fs_swab32(sb->s_backup_bgs[1]);
 	/* sb->s_encrypt_algos is __u8 and does not need swabbing */
diff --git a/lib/ext2fs/tst_super_size.c b/lib/ext2fs/tst_super_size.c
index a932685d..ab38dd59 100644
--- a/lib/ext2fs/tst_super_size.c
+++ b/lib/ext2fs/tst_super_size.c
@@ -135,7 +135,7 @@ int main(int argc, char **argv)
 	check_field(s_mount_opts, 64);
 	check_field(s_usr_quota_inum, 4);
 	check_field(s_grp_quota_inum, 4);
-	check_field(s_overhead_blocks, 4);
+	check_field(s_overhead_clusters, 4);
 	check_field(s_backup_bgs, 8);
 	check_field(s_encrypt_algos, 4);
 	check_field(s_encrypt_pw_salt, 16);
--=20
2.24.0

