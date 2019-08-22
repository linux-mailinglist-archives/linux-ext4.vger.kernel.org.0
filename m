Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C133698DA8
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbfHVI1A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 04:27:00 -0400
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:44341
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732339AbfHVI07 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Aug 2019 04:26:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1bB79F28siDS+jlWjrNy8nxhvahNijxK7YdlmRCvy+H46+bnsF/0X93F1zEzx3p9ablPM6A0wSqWHbrbStf3ZrSAp8DKf2KKUk1fLPaC/W45RamVPHKoOwhmliBu5e/8MHp60TIyelJzCVUUsQUMKYUNsc/P6bak04GcDrmkpvlegKTddURgqVtuG6+GkcIH/4T8Z/bgsdqcZUKhqOYGFCC93JN//nhGD9pNgrwwF+qlrevyCwfDQcXzs8Rddh8KDfklJSWhkdfpH0r/uEX/+7idARAC+LOrdb+N7vTX4yMwmDZN8zKSetX/Q5o7Wi1DzUF07lan7pK/UVvtXXh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/WWaEGYOzP7hRqMZssQHi+5A/GiSQLkatRJ5v8QK40=;
 b=LJLkHkQn110YC3HuuYZKvIl9f9wJkJbjLRJZy55rqNoCI6f88AgmE7xkakG/gHEnW9QyigkNsZL03/PZXzP/mxg5dna66bvr1NhoUWQGl6IijsSwGItho1AulTfahIPqppSSh8WkXIKGYRwimO349uELMpBlrLeUE8QlTZJkEzQ/ZY3jlFj2U4fBSPAoYy0Pz4MmHxqV0yX0D6jfPYGxdBZPpn85ohhTeSD75/qWy1Z7k03Zn06s6iPnOPJMdWEjytkRWuOvHcrdHw+Go+zEtJcXdPljFtzkq9Uf5KyGtX9C+UlSZpWKOzK5GEPHwM3bcxZlJO7vui3chzPUu+M0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/WWaEGYOzP7hRqMZssQHi+5A/GiSQLkatRJ5v8QK40=;
 b=AavZaEBWzTYQ7bR+IlyKgPwTWvpo/8LJDBe6w0E5AHadItBiGrQx6c1x1/7NGDe6tGx8Yci10HPr3Gf8lJlcni74tdAoHvsKkp03mzaxI+jrNpmqQsdiYWmg5jLgSQ1+x6jIsESVRJJEN5GE6NtFjTntjRoicBceeFPTfeBoADE=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2196.namprd19.prod.outlook.com (52.132.23.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 08:26:52 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 08:26:52 +0000
From:   Dongyang Li <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH v2 4/4] mke2fs: set overhead in super block for bigalloc
Thread-Topic: [PATCH v2 4/4] mke2fs: set overhead in super block for bigalloc
Thread-Index: AQHVWMNZPnxfhKjn7UWVswnRm8HqlA==
Date:   Thu, 22 Aug 2019 08:26:52 +0000
Message-ID: <20190822082617.19180-4-dongyangli@ddn.com>
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
x-ms-office365-filtering-correlation-id: 35683faf-a544-45c2-8138-08d726da7c2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL0PR1901MB2196;
x-ms-traffictypediagnostic: BL0PR1901MB2196:
x-microsoft-antispam-prvs: <BL0PR1901MB21965AFB58974CD5E72E8F09CDA50@BL0PR1901MB2196.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39850400004)(136003)(346002)(396003)(376002)(199004)(189003)(1076003)(71200400001)(256004)(81156014)(486006)(8676002)(476003)(2906002)(8936002)(66066001)(6916009)(11346002)(25786009)(64756008)(446003)(4326008)(66946007)(3846002)(2351001)(5660300002)(6116002)(2616005)(66476007)(66446008)(66556008)(71190400001)(50226002)(316002)(186003)(86362001)(36756003)(6436002)(14454004)(99286004)(478600001)(76176011)(386003)(5640700003)(6486002)(2501003)(26005)(6512007)(52116002)(102836004)(7736002)(14444005)(6506007)(53936002)(305945005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2196;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5cOXVZSKFSBAKNVg1XzcWUBSIqDOMyfeTafRmxkqCI4x1EPRfj5V/AgsxxtmX0iJq02rpUTtz0+DaoHOWW8AsoRdEJFbxxz2epYaSTYDKYqecp+AAJGwMYfCkojmQd8e31tCRxSQQfR2HHW74wvicFfC6FuJ9vX4YMP4xJ90F9JcQ9Cpi4hVOtyTlLzJqH1blAAw4xfA8cMTCpHJxUgQZOH3jRueWG3mn5PlcMYVODPTywqAQfrksaQr4/mWuzCAm9espnv0Vjfel0hBVWTxL7drc7/ml+PT+U3IVDBBNsLVUP3Gf2ORRQk1s2P5s24pQHTzgzvWT1GrGX93kH2FrJgenZ4zDZinhujP34zl24JURfE4YSiirvgbKrQui+5ehJgb2VKTloOAImMN4GAGviQ6wYyd/rZgIhFJBuPmJaE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35683faf-a544-45c2-8138-08d726da7c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 08:26:52.6884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTk98gUC+Scl9le81MEyo+pzyhADuuJoG5i1uEEtxmhEMO2WpLH2v7OhA0Rq8k4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2196
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If overhead is not recorded in the super block, it is caculated
during mount in kernel, for bigalloc file systems the it takes
O(groups**2) in time.
For a 1PB deivce with 32K cluste size it takes ~12 mins to
mount, with most of the time spent on figuring out overhead.

While we can not improve the overhead algorithm in kernel
due to the nature of bigalloc, we can work out the overhead
during mke2fs and set it in the super block, avoiding calculating
it every time when it mounts.

Overhead is s_first_data_block plus internal journal blocks plus
the block and inode bitmaps, inode table, super block backups and
group descriptor blocks for every group. This patch introduces
ext2fs_count_used_clusters(), which calculates the clusters used
in the block bitmap for the given range.

When bad blocks are involved, it gets tricky because the blocks
counted as overhead and the bad blocks can end up in the same
allocation cluster. In this case we will unmark the bad blocks from
the block bitmap, covert to cluster bitmap and get the overhead,
then mark the bad blocks back in the cluster bitmap.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 lib/ext2fs/ext2fs.h       |  2 ++
 lib/ext2fs/gen_bitmap64.c | 35 +++++++++++++++++++++++++++
 misc/mke2fs.c             | 50 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 59fd9742..a8ddb9e4 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1437,6 +1437,8 @@ errcode_t ext2fs_set_generic_bmap_range(ext2fs_generi=
c_bitmap bmap,
 					void *in);
 errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
 					   ext2fs_block_bitmap *bitmap);
+errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
+				     blk64_t end, blk64_t *out);
=20
 /* get_num_dirs.c */
 extern errcode_t ext2fs_get_num_dirs(ext2_filsys fs, ext2_ino_t *ret_num_d=
irs);
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index f1dd1891..b2370667 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -940,3 +940,38 @@ errcode_t ext2fs_find_first_set_generic_bmap(ext2fs_ge=
neric_bitmap bitmap,
=20
 	return ENOENT;
 }
+
+errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
+				     blk64_t end, blk64_t *out)
+{
+	blk64_t		next;
+	blk64_t		tot_set =3D 0;
+	errcode_t	retval;
+
+	while (start < end) {
+		retval =3D ext2fs_find_first_set_block_bitmap2(fs->block_map,
+							start, end, &next);
+		if (retval) {
+			if (retval =3D=3D ENOENT)
+				retval =3D 0;
+			break;
+		}
+		start =3D next;
+
+		retval =3D ext2fs_find_first_zero_block_bitmap2(fs->block_map,
+							start, end, &next);
+		if (retval =3D=3D 0) {
+			tot_set +=3D next - start;
+			start  =3D next + 1;
+		} else if (retval =3D=3D ENOENT) {
+			retval =3D 0;
+			tot_set +=3D end - start + 1;
+			break;
+		} else
+			break;
+	}
+
+	if (!retval)
+		*out =3D EXT2FS_NUM_B2C(fs, tot_set);
+	return retval;
+}
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 30e353d3..1928c9bf 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -2912,6 +2912,8 @@ int main (int argc, char *argv[])
 	errcode_t	retval =3D 0;
 	ext2_filsys	fs;
 	badblocks_list	bb_list =3D 0;
+	badblocks_iterate	bb_iter;
+	blk_t		blk;
 	unsigned int	journal_blocks =3D 0;
 	unsigned int	i, checkinterval;
 	int		max_mnt_count;
@@ -2922,6 +2924,7 @@ int main (int argc, char *argv[])
 	char		opt_string[40];
 	char		*hash_alg_str;
 	int		itable_zeroed =3D 0;
+	blk64_t		overhead;
=20
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
@@ -3213,6 +3216,23 @@ int main (int argc, char *argv[])
 	if (!quiet)
 		printf("%s", _("done                            \n"));
=20
+	/*
+	 * Unmark bad blocks to calculate overhead, because metadata
+ 	 * blocks and bad blocks can land on the same allocation cluster.
+ 	 */
+	if (bb_list) {
+		retval =3D ext2fs_badblocks_list_iterate_begin(bb_list,
+							     &bb_iter);
+		if (retval) {
+			com_err("ext2fs_badblocks_list_iterate_begin", retval,
+				"%s", _("while unmarking bad blocks"));
+			exit(1);
+		}
+		while (ext2fs_badblocks_list_iterate(bb_iter, &blk))
+			ext2fs_unmark_block_bitmap2(fs->block_map, blk);
+		ext2fs_badblocks_list_iterate_end(bb_iter);
+	}
+
 	retval =3D ext2fs_convert_subcluster_bitmap(fs, &fs->block_map);
 	if (retval) {
 		com_err(program_name, retval, "%s",
@@ -3220,6 +3240,28 @@ int main (int argc, char *argv[])
 		exit(1);
 	}
=20
+	retval =3D ext2fs_count_used_clusters(fs, fs->super->s_first_data_block,
+					ext2fs_blocks_count(fs->super) - 1,
+					&overhead);
+	if (retval) {
+		com_err(program_name, retval, "%s",
+			_("while calculating overhead"));
+		exit(1);
+	}
+
+	if (bb_list) {
+		retval =3D ext2fs_badblocks_list_iterate_begin(bb_list,
+							     &bb_iter);
+		if (retval) {
+			com_err("ext2fs_badblocks_list_iterate_begin", retval,
+				"%s", _("while marking bad blocks as used"));
+			exit(1);
+		}
+		while (ext2fs_badblocks_list_iterate(bb_iter, &blk))
+			ext2fs_mark_block_bitmap2(fs->block_map, blk);
+		ext2fs_badblocks_list_iterate_end(bb_iter);
+	}
+
 	if (super_only) {
 		check_plausibility(device_name, CHECK_FS_EXIST, NULL);
 		printf(_("%s may be further corrupted by superblock rewrite\n"),
@@ -3317,6 +3359,7 @@ int main (int argc, char *argv[])
 		free(journal_device);
 	} else if ((journal_size) ||
 		   ext2fs_has_feature_journal(&fs_param)) {
+		overhead +=3D EXT2FS_NUM_B2C(fs, journal_blocks);
 		if (super_only) {
 			printf("%s", _("Skipping journal creation in super-only mode\n"));
 			fs->super->s_journal_inum =3D EXT2_JOURNAL_INO;
@@ -3359,8 +3402,13 @@ no_journal:
 			       fs->super->s_mmp_update_interval);
 	}
=20
-	if (ext2fs_has_feature_bigalloc(&fs_param))
+	overhead +=3D fs->super->s_first_data_block;
+
+	if (ext2fs_has_feature_bigalloc(&fs_param)) {
+		if (!super_only)
+			fs->super->s_overhead_clusters =3D overhead;
 		fix_cluster_bg_counts(fs);
+	}
 	if (ext2fs_has_feature_quota(&fs_param))
 		create_quota_inodes(fs);
=20
--=20
2.22.1

