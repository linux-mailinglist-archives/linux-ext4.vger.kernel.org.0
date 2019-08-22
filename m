Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA52698DA6
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 10:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbfHVI05 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 04:26:57 -0400
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:44341
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732339AbfHVI0z (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Aug 2019 04:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Onn32XhvuU01RmBnShtTJAVdbPySULdn8AnczMniOdcDkEdwXG7IL+qaKMeiOlvpOKMTAOkAkNq4hPsJ61E6pUvMlDBPaguPdKFdtu3oOwosA+vUzYoqDXiFZeYaCvKApee/kqF8arX6Zx6BaK2a40QHlF7A8bbri6cynMgZjihRzGi9f36HdX9/+O8sSEEg0Fg61/GhTIAb+odHqgeVQD2dLCVfqbKofsETiVrGY+/6sV7WA5JUxQiMbMekG26Rwh3ho3qa8jEnq3rSkDsLjpzFebgJdlfMB9LC5ILkCQEYHeHiu6ZaItFFH1xVIPRSljxzb///Ec+UoyCGB2bWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J8mCNol/xzTx+9RAO7/H+bcCPc7BcpTejsZU+1MTYc=;
 b=KpFPmeIT5E/7ffK/9mLwqsMRGIM9FikIQWU4vdgdCjJdKIY/mgQF0HMo9O9BrkMgWiATcP7DR4XAdWr+x639sBnt+GMtrDkv/e18IGXzIY5/3XadwdtKvGjbjMCvlMsOkrkSFYEcWg2l7bIcFv+LPHChRuZCl84XniQZAKevi0lY5OJfl8qHRvf2lcsai4wr4ZF09EDe0rK7DCcV+fMgLuCDTWiE69Z/HPcgV7aF/2QD466arQ/FVCNpTr8Xay4P+2E4wvVkpdmihT5wDobG6Khqd3Ee3izB0RkgZrX1cLro/lYksHgRLR1EziOLf7jMRpvbryH7PWR7lKGYDm4a6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J8mCNol/xzTx+9RAO7/H+bcCPc7BcpTejsZU+1MTYc=;
 b=tyWTmYDbYQpoDXZ7WS00ukVM/1NDgzrfWpZffLsFWZXYeRR3Nc5/pOruL8hzrKLzkeIfOkYMQMdg5gDOJK1OA/oOW1tR6Wkabwjo/1TNMBogIHOPiQN9mavz+1wpqmWoUPvZ68NWeIarBjEZIzZbNwZyh6BWmYUjNU9n1XyCeR0=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2196.namprd19.prod.outlook.com (52.132.23.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 08:26:51 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 08:26:51 +0000
From:   Dongyang Li <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH v2 3/4] ext2fs: rename "s_overhead_blocks" to
 "s_overhead_clusters"
Thread-Topic: [PATCH v2 3/4] ext2fs: rename "s_overhead_blocks" to
 "s_overhead_clusters"
Thread-Index: AQHVWMNYyqZsv0l+JUmWybgurjZ4aQ==
Date:   Thu, 22 Aug 2019 08:26:50 +0000
Message-ID: <20190822082617.19180-3-dongyangli@ddn.com>
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
x-ms-office365-filtering-correlation-id: 0e54a19d-229e-469b-882e-08d726da7b1a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL0PR1901MB2196;
x-ms-traffictypediagnostic: BL0PR1901MB2196:
x-microsoft-antispam-prvs: <BL0PR1901MB2196B49B715C50B7D173E4BACDA50@BL0PR1901MB2196.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39850400004)(136003)(346002)(396003)(376002)(199004)(189003)(1076003)(71200400001)(256004)(81156014)(486006)(8676002)(476003)(2906002)(8936002)(66066001)(6916009)(11346002)(25786009)(64756008)(446003)(4326008)(66946007)(3846002)(2351001)(5660300002)(6116002)(2616005)(66476007)(66446008)(66556008)(71190400001)(50226002)(316002)(186003)(86362001)(36756003)(6436002)(14454004)(99286004)(478600001)(76176011)(386003)(5640700003)(6486002)(2501003)(26005)(6512007)(52116002)(102836004)(7736002)(14444005)(6506007)(53936002)(305945005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2196;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yUxW813XpuQGJqNDM5Kv9snrO4y14dUtti+I+BDje2i2SwhMks3OVJOy8YJDCsEBCQqljW1YTgS79+wB/spfZlRMCwNFUwBO3oLcLIq6YRAq2ioe/mDeQNbAWIoBzpZo3s3NXq0KvZJB+yQB4g8VuPUw5IIhNLwO7lzZOtUSk2VV3eDflhn9Obxcnp9FSte4f5pwHd5PLg8BE3YylI7aF9amk1ThZyit2peBZbKXLDLSUGiDH0eaIwnZl722GvEoouSw4gyQ/A20HdaGb8QuIXJVnpDF6LpNHNFDLbxqT6/gAqO7ainLy5/LcJWoQpVtI/2/GDZggJXgMFVSImFklns4gs8nzxIHfKE9XXjEjgpMYDmyX2UsC0TFy3HYpopElaL3B868ftHkpsLEioAIpy6MFNoBnMn7vnoxwDJYSjI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e54a19d-229e-469b-882e-08d726da7b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 08:26:50.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOi8QJYhP2i3oyjPQSl8MAtOeA7ewv1pNWRBs/cIpLYhCPhGJ5vegdW9d0yLBR6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2196
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rename s_overhead_blocks field from struct ext2_super_block to
make it consistent with the kernel counterpart.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
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
index cbb44bdb..5737dc61 100644
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
2.22.1

