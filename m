Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B135103294
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 05:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKTEgK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Nov 2019 23:36:10 -0500
Received: from mail-eopbgr740088.outbound.protection.outlook.com ([40.107.74.88]:49538
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbfKTEgJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 19 Nov 2019 23:36:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEJFWJAQbwVXDjDbiwySAx0qbeFPj5bWl6WDAufEAp3i+BzIFTUHV7tIidUJP6fDNFze/adBauMQQ1XXw3nFHlBxJqtXuP6V5IiKMnjCcWE71MhnGPWRbaM3H3F4yMw5OL77HyGmXrzlGIr7DC8QCByqvD2lnAQ3QKiPtWgy4aXebQAdOsgtuP2XIFzzucv9FA8ie1U9FwBnf8wsmm1ZR4pAIl84sO2PP3OSDA/BFBqKNerRpUGJZMGJfhUslj+i23MepW+HXHTgZTdievazljrVNu3BqRfEQ1FN6bAwwFzpwRkbI3Eamq1pAXatZgdt1WqnjaljnWe0K5WpdAOhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVLkiMXYD7q5U/7cxTAunPjufK+4PcnJYED1BrrdyJY=;
 b=KRvlXud1fXObF1LsZysD10X+yDt0EpB3xYndw2faEKWSdOTgqpn3yocOBQmxGa3WvZ1bS8LE/MmLz5KdCkFqOvxvZS35XasJpoinU+N43mTb1PIX/qcOJXV3qaBi0mgt7pp8RadD27MSK/mwUjoN+d2pzj73CKmmTUm/+yqBIsxJrq187HGu24qmA37Xsi8WEwUDDWUhlqBrqrfYqRN9PyPgFwNiaSNFDMgtpl3kUGjEj0dQna6bp80HL2A4K+aTWzl9qu0wFtszm5qkcTsUPKUSbaQMT8fCy2qLSqRtbpoKX+ULXPZRq/zftSUCdVzieEk/n0twmz/f0d8vPGOMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVLkiMXYD7q5U/7cxTAunPjufK+4PcnJYED1BrrdyJY=;
 b=J0DQW70qHDZ1CjJt8HYchwrkEZKm16WZ9RayYj1SA+3Vv9zu+2zvKqYJfuC0Gj2egrl6ndum6GADDmsInCjvPcz/S2fs7jlLBwQf5g7Ovk+mGthGonrGIK0aBkOlrReTJKpiEc3oC8dr4m2CPszKx+jkjvWGY6j6P9DKngg6UhA=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2002.namprd19.prod.outlook.com (52.132.17.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Wed, 20 Nov 2019 04:35:28 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8587:2f91:6a7b:8655]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8587:2f91:6a7b:8655%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 04:35:28 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH v3 4/5] mke2fs: set overhead in super block
Thread-Topic: [PATCH v3 4/5] mke2fs: set overhead in super block
Thread-Index: AQHVn1vv8aUzx6r/80yoWojoOcTFqw==
Date:   Wed, 20 Nov 2019 04:35:27 +0000
Message-ID: <20191120043448.249988-4-dongyangli@ddn.com>
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
x-ms-office365-filtering-correlation-id: 5b9a08a2-6b6b-4644-ea9d-08d76d73115f
x-ms-traffictypediagnostic: BL0PR1901MB2002:
x-microsoft-antispam-prvs: <BL0PR1901MB200278CDEFA520F87A29C6B7BA4F0@BL0PR1901MB2002.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(376002)(346002)(136003)(366004)(189003)(199004)(66446008)(64756008)(66556008)(66946007)(26005)(66476007)(6116002)(3846002)(66066001)(76176011)(102836004)(5660300002)(1076003)(6916009)(52116002)(305945005)(6512007)(7736002)(36756003)(4326008)(446003)(11346002)(6486002)(8936002)(186003)(2616005)(81166006)(5640700003)(81156014)(50226002)(25786009)(8676002)(256004)(14444005)(6506007)(386003)(2906002)(478600001)(99286004)(2501003)(14454004)(2351001)(71200400001)(71190400001)(316002)(486006)(6436002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2002;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ux35iRTHr/slwiM0QLegnXbrt9+bbAd9xuCADwq9H7LgEpfbV69DA87m686AjFAU6/Tul5nw6aIa23b7v5uOujNAe0zAc6Clc81QDgcl+xfbD5KUZZerPtl0mANGTcLm4RpB5CsUqvJ1qQK8SpMvwmrIZbIbnj4RSrdjr6Ss2KNDuQlAJ7tJp1BOhoxWGajhdgJfj0iIOxPfUQvC8+IVABthYZlkIA9xcA8tOz16bL98bBTJYiaP0FtFL1kD3JDmwQZc7t+MmrYY3FtpiV3qHBQNFPf7ygjKsRXOa2GBXCFvDiE4o7ElwJofWnyir+FWWzo0N7aL1NbyxrrwJeVYOyBIYdCBHKmbGJGGg98D1aHvkf6q+GUgLARkqGSTbNvrOelTSAno9kEGqpmVtqM34l2sTmqpoQpC51tSA+yboECPifD31O30o2ztFEDJsclT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9a08a2-6b6b-4644-ea9d-08d76d73115f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 04:35:27.9587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBb+2RXKNYiJugMHoNT/K4tsl0qRkYwGtVbhc/X6xZu4emcF4iRxvM5I+OamvQJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2002
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
the block bitmap, convert to cluster bitmap and get the overhead,
then mark the bad blocks back in the cluster bitmap.

Reset the overhead to zero when resizing, we can not simplly count
the used blocks as overhead like we do when mke2fs. The overhead
can be calculated by kernel side during mount.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 lib/ext2fs/ext2fs.h       |  2 ++
 lib/ext2fs/gen_bitmap64.c | 35 +++++++++++++++++++++++++++++
 misc/mke2fs.c             | 47 +++++++++++++++++++++++++++++++++++++++
 resize/resize2fs.c        |  1 +
 4 files changed, 85 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index da309947..78f84632 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1442,6 +1442,8 @@ errcode_t ext2fs_set_generic_bmap_range(ext2fs_generi=
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
index be38d2c4..542a3030 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -2914,6 +2914,8 @@ int main (int argc, char *argv[])
 	errcode_t	retval =3D 0;
 	ext2_filsys	fs;
 	badblocks_list	bb_list =3D 0;
+	badblocks_iterate	bb_iter;
+	blk_t		blk;
 	unsigned int	journal_blocks =3D 0;
 	unsigned int	i, checkinterval;
 	int		max_mnt_count;
@@ -2924,6 +2926,7 @@ int main (int argc, char *argv[])
 	char		opt_string[40];
 	char		*hash_alg_str;
 	int		itable_zeroed =3D 0;
+	blk64_t		overhead;
=20
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
@@ -3215,6 +3218,23 @@ int main (int argc, char *argv[])
 	if (!quiet)
 		printf("%s", _("done                            \n"));
=20
+	/*
+	 * Unmark bad blocks to calculate overhead, because metadata
+	 * blocks and bad blocks can land on the same allocation cluster.
+	 */
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
@@ -3222,6 +3242,28 @@ int main (int argc, char *argv[])
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
@@ -3319,6 +3361,7 @@ int main (int argc, char *argv[])
 		free(journal_device);
 	} else if ((journal_size) ||
 		   ext2fs_has_feature_journal(&fs_param)) {
+		overhead +=3D EXT2FS_NUM_B2C(fs, journal_blocks);
 		if (super_only) {
 			printf("%s", _("Skipping journal creation in super-only mode\n"));
 			fs->super->s_journal_inum =3D EXT2_JOURNAL_INO;
@@ -3361,6 +3404,10 @@ no_journal:
 			       fs->super->s_mmp_update_interval);
 	}
=20
+	overhead +=3D fs->super->s_first_data_block;
+	if (!super_only)
+		fs->super->s_overhead_clusters =3D overhead;
+
 	if (ext2fs_has_feature_bigalloc(&fs_param))
 		fix_cluster_bg_counts(fs);
 	if (ext2fs_has_feature_quota(&fs_param))
diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index 8a3d08db..2443ff67 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -703,6 +703,7 @@ errcode_t adjust_fs_info(ext2_filsys fs, ext2_filsys ol=
d_fs,
 	double		percent;
=20
 	ext2fs_blocks_count_set(fs->super, new_size);
+	fs->super->s_overhead_clusters =3D 0;
=20
 retry:
 	fs->group_desc_count =3D ext2fs_div64_ceil(ext2fs_blocks_count(fs->super)=
 -
--=20
2.24.0

