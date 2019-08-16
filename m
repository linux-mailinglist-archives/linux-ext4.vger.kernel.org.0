Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192448F987
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2019 05:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfHPDtV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Aug 2019 23:49:21 -0400
Received: from mail-eopbgr730086.outbound.protection.outlook.com ([40.107.73.86]:43683
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfHPDtV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Aug 2019 23:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj8D5ulswbcrSTlb0eQoYzaFAQz2URPw4z399HnElCycSicrgrV8sELO1O5hHBxj9fKDyOW0erMqEwuDiLbhGPL2kKMlD2aizRjpOpUXJOqx/hW6Al2YEcN10PLBa84Alq98mfXA6g80zHpU9G7e0ri4urlskfrnalkK0AUu0ZjUakqMrN/D6FUO/M44D3zakQW+2eQy5FLQt3cu9wVtyezOXJcznV8rZPhFldZbhQIpMssPRGMiHsVylGGHY+j+qPsPG7LfG2L8Fx+uSynptJi/NWUJtoah7fYaDP3rI+yD8QBsgDbNl6JXFK97ABUPjCkFbUVJbr5F39DA4kwJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsW/6qGSstRUqaV2eIwjKMvg9vxIUfTQLsA6yoM77as=;
 b=Ywoarr+6nja6SjFntLaUar79oELRg9AHqNq2SzrFpEYlWgnC2kLX9cQg8mw6SlWzIQbfJImpwcAcVsT9euaXeRjOV828eDIwcMTheizePgsocTLWsHyuSADH6zWEQPQW4fHZ/S2TLKcUpSq7iL5USeF8ng51DgltXj/XoXXMNAhVULuBxtDkcvSLrrWGJj9tvcVXRS/olwz6FdkPNMVqOf9jdArxX3Qnbb8aEsaS9DzxeGiC549v4BB8I/gZFXFu/yCsQqywf7LxEs9Ikg6C89UBKf0yXZmoyvCoENTH5v8Err+JxLQOhwp9b0R13ZfZGrUd4XWjKLHVXEMddVaCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsW/6qGSstRUqaV2eIwjKMvg9vxIUfTQLsA6yoM77as=;
 b=uKFJLp81+Bu/Hpsf8dcSbaHDAumpqOvMIp2v7Yp1L3ezZuYzmWCj8UGqLCCPywaLtc5Mh24nKASekGNhGmEMuP0tI1Kti+Puiat09/jjs+WmXOS+fzsz6h8icrnK2J8v+LdsvRJAnOWtskUU59CpQxtWhVdOI6qMl13v/vpzZ9w=
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com (52.132.24.157) by
 BL0PR1901MB2036.namprd19.prod.outlook.com (52.132.25.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Fri, 16 Aug 2019 03:49:14 +0000
Received: from BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737]) by BL0PR1901MB2004.namprd19.prod.outlook.com
 ([fe80::8106:5cf4:d22e:3737%7]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 03:49:14 +0000
From:   Dongyang Li <dongyangli@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "adilger@dilger.ca" <adilger@dilger.ca>
Subject: [PATCH 2/2] mke2fs: set overhead in super block for bigalloc
Thread-Topic: [PATCH 2/2] mke2fs: set overhead in super block for bigalloc
Thread-Index: AQHVU+WSK13T1X7pvEePBTUU+Qum5g==
Date:   Fri, 16 Aug 2019 03:49:14 +0000
Message-ID: <20190816034834.29439-2-dongyangli@ddn.com>
References: <20190816034834.29439-1-dongyangli@ddn.com>
In-Reply-To: <20190816034834.29439-1-dongyangli@ddn.com>
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
x-ms-office365-filtering-correlation-id: 470b90fb-bab2-4708-c120-08d721fcb4a3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR1901MB2036;
x-ms-traffictypediagnostic: BL0PR1901MB2036:
x-microsoft-antispam-prvs: <BL0PR1901MB2036761BD4464305CDF13D58CDAF0@BL0PR1901MB2036.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(2351001)(26005)(6916009)(486006)(186003)(66556008)(7736002)(64756008)(66476007)(52116002)(6506007)(14454004)(76176011)(2616005)(3846002)(6436002)(66946007)(11346002)(36756003)(6116002)(66066001)(50226002)(8936002)(86362001)(476003)(446003)(102836004)(386003)(66446008)(1076003)(14444005)(478600001)(2501003)(99286004)(25786009)(53936002)(5640700003)(2906002)(6512007)(305945005)(8676002)(71200400001)(71190400001)(5660300002)(81166006)(6486002)(256004)(316002)(4326008)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2036;H:BL0PR1901MB2004.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LrhQ3hNE+83rFYF4tZqCQ/M3/I2RYVBEAJn7QADnFcDKYKRv3kRm5KIKeYFxyAfNZSYfq6dQLbdBEvLOuvXmsV6WtzWHfOQ0fqaFOh9k+OERiXrUrIXS6fzFmoUi9ZZLwE1hiYXGfG6vdrul6OC5ZCq66Dhg3N4JLhalWYJKSvZhKl9tmTgUxvzbrCd8ow8VRkiT0gsMNBjnYGNLE1QUNqQu+Z/livro3TTYG5dA3OdFscSlXU0gaL8d/5eXOdAyvHxLbrOti4Iu5fstxZR1h7K+OacnK6YqLX3U2UmiB6GCtqmWhKvHNJsCtJc3hHN22E8hRkPwiIVU5mN3ek+SXW1Sjzkwdctt2DFo4tS+CrBmWBBpeT8LHE6q9YWXxwgrukTLxzZotGj3xUWmk1tpWE1XKHrsARkS8G5Mm0Cp1tk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470b90fb-bab2-4708-c120-08d721fcb4a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 03:49:14.3709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8MD0y9svSjkRLEf5DLjDLwrfahp/UQrrUs+gpzYDcP2/0Zjr9jdiLuA8chAZ968
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2036
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
it every time during mounting.

Overhead is s_first_data_block plus internal journal blocks plus
the block and inode bitmaps, inode table, super block backups and
group descriptor blocks for every group. With the patch we calculate
the overhead when converting the block bitmap to cluster bitmap.

When bad blocks are involved, it gets tricky because the blocks
counted as overhead and the bad blocks can end up in the same
allocation cluster. In this case we will unmark the bad blocks from
the block bitmap, covert to cluster bitmap and get the overhead,
then mark the bad blocks back in the cluster bitmap.

Fix a bug in handle_bad_blocks(), don't covert the bad block to
cluster when marking it as used, the bitmap is still a block bitmap,
will be coverted to cluster bitmap later.

Note: in kernel the overhead is the s_overhead_clusters field from
struct ext4_super_block, it's named s_overhead_blocks in e2fsprogs.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 lib/ext2fs/ext2fs.h       |  4 +++
 lib/ext2fs/gen_bitmap64.c | 61 ++++++++++++++++++++++++++++++++++-----
 misc/mke2fs.c             | 15 ++++++++--
 3 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 59fd9742..a70924b3 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1437,6 +1437,10 @@ errcode_t ext2fs_set_generic_bmap_range(ext2fs_gener=
ic_bitmap bmap,
 					void *in);
 errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
 					   ext2fs_block_bitmap *bitmap);
+errcode_t ext2fs_convert_subcluster_bitmap_overhead(ext2_filsys fs,
+						    ext2fs_block_bitmap *bitmap,
+						    badblocks_list bb_list,
+						    unsigned int *count);
=20
 /* get_num_dirs.c */
 extern errcode_t ext2fs_get_num_dirs(ext2_filsys fs, ext2_ino_t *ret_num_d=
irs);
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index 97601232..0f67f9c4 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -794,18 +794,46 @@ void ext2fs_warn_bitmap32(ext2fs_generic_bitmap gen_b=
itmap, const char *func)
 #endif
 }
=20
-errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
-					   ext2fs_block_bitmap *bitmap)
+errcode_t ext2fs_convert_subcluster_bitmap_overhead(ext2_filsys fs,
+						    ext2fs_block_bitmap *bitmap,
+						    badblocks_list bb_list,
+						    unsigned int *count)
 {
 	ext2fs_generic_bitmap_64 bmap, cmap;
 	ext2fs_block_bitmap	gen_bmap =3D *bitmap, gen_cmap;
 	errcode_t		retval;
-	blk64_t			i, next, b_end, c_end;
+	blk64_t			blk, next, b_end, c_end;
+	unsigned int		clusters =3D 0;
+	blk_t			super_and_bgd, bblk;
+	badblocks_iterate	bb_iter;
+	dgrp_t			i;
 	int			ratio;
=20
 	bmap =3D (ext2fs_generic_bitmap_64) gen_bmap;
-	if (fs->cluster_ratio_bits =3D=3D ext2fs_get_bitmap_granularity(gen_bmap)=
)
+	if (fs->cluster_ratio_bits =3D=3D
+				ext2fs_get_bitmap_granularity(gen_bmap)) {
+		if (count) {
+			for (i =3D 0; i < fs->group_desc_count; i++) {
+				ext2fs_super_and_bgd_loc2(fs, i, NULL, NULL,
+							  NULL,
+							  &super_and_bgd);
+				clusters +=3D super_and_bgd +
+					    fs->inode_blocks_per_group + 2;
+			}
+			*count =3D clusters;
+		}
 		return 0;	/* Nothing to do */
+	}
+
+	if (bb_list) {
+		retval =3D ext2fs_badblocks_list_iterate_begin(bb_list,
+							     &bb_iter);
+		if (retval)
+			return retval;
+		while (ext2fs_badblocks_list_iterate(bb_iter, &bblk))
+			ext2fs_unmark_block_bitmap2(gen_bmap, bblk);
+		bb_iter->ptr =3D 0;
+	}
=20
 	retval =3D ext2fs_allocate_block_bitmap(fs, "converted cluster bitmap",
 					      &gen_cmap);
@@ -813,27 +841,44 @@ errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsy=
s fs,
 		return retval;
=20
 	cmap =3D (ext2fs_generic_bitmap_64) gen_cmap;
-	i =3D bmap->start;
+	blk =3D bmap->start;
 	b_end =3D bmap->end;
 	bmap->end =3D bmap->real_end;
 	c_end =3D cmap->end;
 	cmap->end =3D cmap->real_end;
 	ratio =3D 1 << fs->cluster_ratio_bits;
-	while (i < bmap->real_end) {
+	while (blk < bmap->real_end) {
 		retval =3D ext2fs_find_first_set_block_bitmap2(gen_bmap,
-						i, bmap->real_end, &next);
+						blk, bmap->real_end, &next);
 		if (retval)
 			break;
 		ext2fs_mark_block_bitmap2(gen_cmap, next);
-		i =3D bmap->start + roundup(next - bmap->start + 1, ratio);
+		blk =3D bmap->start + roundup(next - bmap->start + 1, ratio);
+		clusters++;
 	}
 	bmap->end =3D b_end;
 	cmap->end =3D c_end;
 	ext2fs_free_block_bitmap(gen_bmap);
+
+	if (bb_list) {
+		while (ext2fs_badblocks_list_iterate(bb_iter, &bblk))
+			ext2fs_mark_block_bitmap2(gen_cmap, bblk);
+		ext2fs_badblocks_list_iterate_end(bb_iter);
+	}
+
 	*bitmap =3D (ext2fs_block_bitmap) cmap;
+	if (count)
+		*count =3D clusters;
 	return 0;
 }
=20
+errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
+					   ext2fs_block_bitmap *bitmap)
+{
+	return ext2fs_convert_subcluster_bitmap_overhead(fs, bitmap,
+							 NULL, NULL);
+}
+
 errcode_t ext2fs_find_first_zero_generic_bmap(ext2fs_generic_bitmap bitmap=
,
 					      __u64 start, __u64 end, __u64 *out)
 {
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index d7cf257e..baa87b36 100644
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
@@ -2913,6 +2913,7 @@ int main (int argc, char *argv[])
 	ext2_filsys	fs;
 	badblocks_list	bb_list =3D 0;
 	unsigned int	journal_blocks =3D 0;
+	unsigned int	overhead;
 	unsigned int	i, checkinterval;
 	int		max_mnt_count;
 	int		val, hash_alg;
@@ -3213,7 +3214,9 @@ int main (int argc, char *argv[])
 	if (!quiet)
 		printf("%s", _("done                            \n"));
=20
-	retval =3D ext2fs_convert_subcluster_bitmap(fs, &fs->block_map);
+	retval =3D ext2fs_convert_subcluster_bitmap_overhead(fs, &fs->block_map,
+							   bb_list,
+							   &overhead);
 	if (retval) {
 		com_err(program_name, retval, "%s",
 			_("\n\twhile converting subcluster bitmap"));
@@ -3317,6 +3320,7 @@ int main (int argc, char *argv[])
 		free(journal_device);
 	} else if ((journal_size) ||
 		   ext2fs_has_feature_journal(&fs_param)) {
+		overhead +=3D EXT2FS_B2C(fs, journal_blocks);
 		if (super_only) {
 			printf("%s", _("Skipping journal creation in super-only mode\n"));
 			fs->super->s_journal_inum =3D EXT2_JOURNAL_INO;
@@ -3359,8 +3363,13 @@ no_journal:
 			       fs->super->s_mmp_update_interval);
 	}
=20
-	if (ext2fs_has_feature_bigalloc(&fs_param))
+	overhead +=3D fs->super->s_first_data_block;
+
+	if (ext2fs_has_feature_bigalloc(&fs_param)) {
 		fix_cluster_bg_counts(fs);
+		if (!super_only)
+			fs->super->s_overhead_blocks =3D overhead;
+	}
 	if (ext2fs_has_feature_quota(&fs_param))
 		create_quota_inodes(fs);
=20
--=20
2.22.1

