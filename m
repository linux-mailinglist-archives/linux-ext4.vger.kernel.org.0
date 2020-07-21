Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9206228406
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgGUPmR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 11:42:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39620 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUPmQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 11:42:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFGeSb045198;
        Tue, 21 Jul 2020 15:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+S7xkJS57Qn2TVjZEdvZ1LlwIBRcX1vN3PNA4ETukAA=;
 b=jf/VF8PomUAMLtbDfmpGvzGnG+Mxx4TpgED5IJtlr44uduRGtvtP+iCOJ8f0joYpDZhu
 z1gSN/ow4h3lIriEbYslPYb+RNuurTwRZnjTnxJn4pAGg6KccrPvjiHy8Kqkx3t9SLE2
 DZKjLTvYn59qN2ST0/JvPf5W8xHsTFFl2EQEK7PGff7ztU2TT7EI2iZLKcpi6/voar4A
 LqmMqMKhXfACtnCY7h3/t6E0+89i+wTTDJ9DxIS32ZVVtxlMHCZyyoKKo1DyvvRqzJr2
 7UPrN+OftciG+/wWXFk6A0+rNjYZQ9uQm56R7XSRH//W331mUijkiuSe8wzB4jYw8IVE EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32brgre2b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 15:42:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFMvgt084031;
        Tue, 21 Jul 2020 15:42:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32dufec1g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 15:42:05 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06LFg4GX007548;
        Tue, 21 Jul 2020 15:42:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jul 2020 08:42:03 -0700
Date:   Tue, 21 Jul 2020 08:42:02 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: Exporting ext4-specific information through fsinfo attributes
Message-ID: <20200721154202.GD848607@magnolia>
References: <20200401151837.GB56931@magnolia>
 <2461554.1585726747@warthog.procyon.org.uk>
 <2504712.1587485842@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2504712.1587485842@warthog.procyon.org.uk>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 suspectscore=5
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=5 adultscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210111
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 21, 2020 at 05:17:22PM +0100, David Howells wrote:
> Darrick J. Wong <darrick.wong@oracle.com> wrote:
> 
> > The entire superblock as a binary blob? :)
> 
> How about the attached?  Please forgive the duplication of struct
> ext4_super_block into the test program, but it's not in the UAPI.
> 
> David
> ---
> fsinfo: Add support to ext4
>     
> Add support to ext4, including the following:
> 
>  (1) FSINFO_ATTR_SUPPORTS: Information about supported STATX attributes and
>      support for ioctls like FS_IOC_[GS]ETFLAGS and FS_IOC_FS[GS]ETXATTR.
> 
>  (2) FSINFO_ATTR_FEATURES: Information about features supported by an ext4
>      filesystem, such as whether version counting, birth time and name case
>      folding are in operation.
> 
>  (3) FSINFO_ATTR_VOLUME_NAME: The volume name from the superblock.
> 
>  (4) FSINFO_ATTR_EXT4_SUPERBLOCK: The entirety of the on disk-format
>      superblock record as an opaque blob.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: "Theodore Ts'o" <tytso@mit.edu>
> cc: Andreas Dilger <adilger.kernel@dilger.ca>
> cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> cc: Eric Biggers <ebiggers@kernel.org>
> cc: linux-ext4@vger.kernel.org
> ---
>  fs/ext4/Makefile            |    1 
>  fs/ext4/ext4.h              |    6 +
>  fs/ext4/fsinfo.c            |  106 ++++++++++++++++++++++++++++++++
>  fs/ext4/super.c             |    3 
>  include/uapi/linux/fsinfo.h |    2 
>  samples/vfs/test-fsinfo.c   |  143 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 261 insertions(+)
> 
> 
> diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> index 4ccb3c9189d8..71d5b460c7c7 100644
> --- a/fs/ext4/Makefile
> +++ b/fs/ext4/Makefile
> @@ -16,3 +16,4 @@ ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
>  ext4-inode-test-objs			+= inode-test.o
>  obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
>  ext4-$(CONFIG_FS_VERITY)		+= verity.o
> +ext4-$(CONFIG_FSINFO)			+= fsinfo.o
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 91eb4381cae5..674581da786c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -42,6 +42,7 @@
>  
>  #include <linux/fscrypt.h>
>  #include <linux/fsverity.h>
> +#include <linux/fsinfo.h>
>  
>  #include <linux/compiler.h>
>  
> @@ -3207,6 +3208,11 @@ extern const struct inode_operations ext4_file_inode_operations;
>  extern const struct file_operations ext4_file_operations;
>  extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
>  
> +/* fsinfo.c */
> +#ifdef CONFIG_FSINFO
> +extern int ext4_fsinfo(struct path *path, struct fsinfo_context *ctx);
> +#endif
> +
>  /* inline.c */
>  extern int ext4_get_max_inline_size(struct inode *inode);
>  extern int ext4_find_inline_data_nolock(struct inode *inode);
> diff --git a/fs/ext4/fsinfo.c b/fs/ext4/fsinfo.c
> new file mode 100644
> index 000000000000..52bfd09e550f
> --- /dev/null
> +++ b/fs/ext4/fsinfo.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Filesystem information for ext4
> + *
> + * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/mount.h>
> +#include "ext4.h"
> +
> +static int ext4_fsinfo_supports(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_supports *p = ctx->buffer;
> +	struct inode *inode = d_inode(path->dentry);
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct ext4_inode *raw_inode;
> +	u32 flags;
> +
> +	fsinfo_generic_supports(path, ctx);
> +	p->stx_attributes |= (STATX_ATTR_APPEND |
> +			      STATX_ATTR_COMPRESSED |
> +			      STATX_ATTR_ENCRYPTED |
> +			      STATX_ATTR_IMMUTABLE |
> +			      STATX_ATTR_NODUMP |
> +			      STATX_ATTR_VERITY);
> +	if (EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime))
> +		p->stx_mask |= STATX_BTIME;
> +
> +	flags = EXT4_FL_USER_VISIBLE;
> +	if (S_ISREG(inode->i_mode))
> +		flags &= ~EXT4_PROJINHERIT_FL;
> +	p->fs_ioc_getflags = flags;
> +	flags &= EXT4_FL_USER_MODIFIABLE;
> +	p->fs_ioc_setflags_set = flags;
> +	p->fs_ioc_setflags_clear = flags;
> +
> +	p->fs_ioc_fsgetxattr_xflags = EXT4_FL_XFLAG_VISIBLE;
> +	p->fs_ioc_fssetxattr_xflags_set = EXT4_FL_XFLAG_VISIBLE;
> +	p->fs_ioc_fssetxattr_xflags_clear = EXT4_FL_XFLAG_VISIBLE;

Oooh.... I like that we finally have a way to tell userspace which bits
actually have any meaning. :)

> +	return sizeof(*p);
> +}
> +
> +static int ext4_fsinfo_features(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_features *p = ctx->buffer;
> +	struct super_block *sb = path->dentry->d_sb;
> +	struct inode *inode = d_inode(path->dentry);
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct ext4_inode *raw_inode;
> +
> +	fsinfo_generic_features(path, ctx);
> +	fsinfo_set_unix_features(p);
> +	fsinfo_set_feature(p, FSINFO_FEAT_VOLUME_UUID);
> +	fsinfo_set_feature(p, FSINFO_FEAT_VOLUME_NAME);
> +	fsinfo_set_feature(p, FSINFO_FEAT_O_SYNC);
> +	fsinfo_set_feature(p, FSINFO_FEAT_O_DIRECT);
> +	fsinfo_set_feature(p, FSINFO_FEAT_ADV_LOCKS);

Where are these FSINFO_FEAT* constants defined, and where are they
documented?

This generally looks ok to me, but I would like to see documentation
first.

--D

> +
> +	if (test_opt(sb, XATTR_USER))
> +		fsinfo_set_feature(p, FSINFO_FEAT_XATTRS);
> +	if (ext4_has_feature_journal(sb))
> +		fsinfo_set_feature(p, FSINFO_FEAT_JOURNAL);
> +	if (ext4_has_feature_casefold(sb))
> +		fsinfo_set_feature(p, FSINFO_FEAT_NAME_CASE_INDEP);
> +
> +	if (sb->s_flags & SB_I_VERSION &&
> +	    !test_opt2(sb, HURD_COMPAT) &&
> +	    EXT4_INODE_SIZE(sb) > EXT4_GOOD_OLD_INODE_SIZE) {
> +		fsinfo_set_feature(p, FSINFO_FEAT_IVER_DATA_CHANGE);
> +		fsinfo_set_feature(p, FSINFO_FEAT_IVER_MONO_INCR);
> +	}
> +
> +	if (EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime))
> +		fsinfo_set_feature(p, FSINFO_FEAT_HAS_BTIME);
> +	return sizeof(*p);
> +}
> +
> +static int ext4_fsinfo_get_volume_name(struct path *path, struct fsinfo_context *ctx)
> +{
> +	const struct ext4_sb_info *sbi = EXT4_SB(path->mnt->mnt_sb);
> +	const struct ext4_super_block *es = sbi->s_es;
> +
> +	memcpy(ctx->buffer, es->s_volume_name, sizeof(es->s_volume_name));
> +	return strlen(ctx->buffer) + 1;
> +}
> +
> +static int ext4_fsinfo_get_superblock(struct path *path, struct fsinfo_context *ctx)
> +{
> +	const struct ext4_sb_info *sbi = EXT4_SB(path->mnt->mnt_sb);
> +	const struct ext4_super_block *es = sbi->s_es;
> +
> +	return fsinfo_opaque(es, ctx, sizeof(*es));
> +}
> +
> +static const struct fsinfo_attribute ext4_fsinfo_attributes[] = {
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		ext4_fsinfo_supports),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		ext4_fsinfo_features),
> +	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	ext4_fsinfo_get_volume_name),
> +	FSINFO_OPAQUE	(FSINFO_ATTR_EXT4_SUPERBLOCK,	ext4_fsinfo_get_superblock),
> +	{}
> +};
> +
> +int ext4_fsinfo(struct path *path, struct fsinfo_context *ctx)
> +{
> +	return fsinfo_get_attribute(path, ctx, ext4_fsinfo_attributes);
> +}
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index bf5fcb477f66..201287a90c4b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1482,6 +1482,9 @@ static const struct super_operations ext4_sops = {
>  	.freeze_fs	= ext4_freeze,
>  	.unfreeze_fs	= ext4_unfreeze,
>  	.statfs		= ext4_statfs,
> +#ifdef CONFIG_FSINFO
> +	.fsinfo		= ext4_fsinfo,
> +#endif
>  	.remount_fs	= ext4_remount,
>  	.show_options	= ext4_show_options,
>  #ifdef CONFIG_QUOTA
> diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
> index 3483dd9a5d05..51214c0c82b1 100644
> --- a/include/uapi/linux/fsinfo.h
> +++ b/include/uapi/linux/fsinfo.h
> @@ -42,6 +42,8 @@
>  #define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of the Nth server (string) */
>  #define FSINFO_ATTR_AFS_SERVER_ADDRESSES 0x302	/* List of addresses of the Nth server */
>  
> +#define FSINFO_ATTR_EXT4_SUPERBLOCK	0x400	/* Ext4 superblock (opaque) */
> +
>  /*
>   * Optional fsinfo() parameter structure.
>   *
> diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> index 4c6f3f1002dd..a6dacc2ec59d 100644
> --- a/samples/vfs/test-fsinfo.c
> +++ b/samples/vfs/test-fsinfo.c
> @@ -24,6 +24,7 @@
>  #include <sys/stat.h>
>  #include <arpa/inet.h>
>  #include <linux/rxrpc.h>
> +#include <linux/byteorder/little_endian.h>
>  
>  #ifndef __NR_fsinfo
>  #define __NR_fsinfo -1
> @@ -389,6 +390,147 @@ static void dump_afs_fsinfo_server_address(void *reply, unsigned int size)
>  	printf("family=%u\n", ss->ss_family);
>  }
>  
> +static char *dump_ext4_time(char *buffer, time_t tim)
> +{
> +	struct tm tm;
> +	int len;
> +
> +	if (tim == 0)
> +		return "-";
> +
> +	if (!localtime_r(&tim, &tm)) {
> +		perror("localtime_r");
> +		exit(1);
> +	}
> +	len = strftime(buffer, 100, "%F %T", &tm);
> +	if (len == 0) {
> +		perror("strftime");
> +		exit(1);
> +	}
> +	return buffer;
> +}
> +
> +static void dump_ext4_fsinfo_superblock(void *reply, unsigned int size)
> +{
> +	struct ext4_super_block {
> +	/*00*/	__le32	s_inodes_count;		/* Inodes count */
> +		__le32	s_blocks_count_lo;	/* Blocks count */
> +		__le32	s_r_blocks_count_lo;	/* Reserved blocks count */
> +		__le32	s_free_blocks_count_lo;	/* Free blocks count */
> +	/*10*/	__le32	s_free_inodes_count;	/* Free inodes count */
> +		__le32	s_first_data_block;	/* First Data Block */
> +		__le32	s_log_block_size;	/* Block size */
> +		__le32	s_log_cluster_size;	/* Allocation cluster size */
> +	/*20*/	__le32	s_blocks_per_group;	/* # Blocks per group */
> +		__le32	s_clusters_per_group;	/* # Clusters per group */
> +		__le32	s_inodes_per_group;	/* # Inodes per group */
> +		__le32	s_mtime;		/* Mount time */
> +	/*30*/	__le32	s_wtime;		/* Write time */
> +		__le16	s_mnt_count;		/* Mount count */
> +		__le16	s_max_mnt_count;	/* Maximal mount count */
> +		__le16	s_magic;		/* Magic signature */
> +		__le16	s_state;		/* File system state */
> +		__le16	s_errors;		/* Behaviour when detecting errors */
> +		__le16	s_minor_rev_level;	/* minor revision level */
> +	/*40*/	__le32	s_lastcheck;		/* time of last check */
> +		__le32	s_checkinterval;	/* max. time between checks */
> +		__le32	s_creator_os;		/* OS */
> +		__le32	s_rev_level;		/* Revision level */
> +	/*50*/	__le16	s_def_resuid;		/* Default uid for reserved blocks */
> +		__le16	s_def_resgid;		/* Default gid for reserved blocks */
> +		__le32	s_first_ino;		/* First non-reserved inode */
> +		__le16  s_inode_size;		/* size of inode structure */
> +		__le16	s_block_group_nr;	/* block group # of this superblock */
> +		__le32	s_feature_compat;	/* compatible feature set */
> +	/*60*/	__le32	s_feature_incompat;	/* incompatible feature set */
> +		__le32	s_feature_ro_compat;	/* readonly-compatible feature set */
> +	/*68*/	__u8	s_uuid[16];		/* 128-bit uuid for volume */
> +	/*78*/	char	s_volume_name[16];	/* volume name */
> +	/*88*/	char	s_last_mounted[64];	/* directory where last mounted */
> +	/*C8*/	__le32	s_algorithm_usage_bitmap; /* For compression */
> +		__u8	s_prealloc_blocks;	/* Nr of blocks to try to preallocate*/
> +		__u8	s_prealloc_dir_blocks;	/* Nr to preallocate for dirs */
> +		__le16	s_reserved_gdt_blocks;	/* Per group desc for online growth */
> +	/*D0*/	__u8	s_journal_uuid[16];	/* uuid of journal superblock */
> +	/*E0*/	__le32	s_journal_inum;		/* inode number of journal file */
> +		__le32	s_journal_dev;		/* device number of journal file */
> +		__le32	s_last_orphan;		/* start of list of inodes to delete */
> +		__le32	s_hash_seed[4];		/* HTREE hash seed */
> +		__u8	s_def_hash_version;	/* Default hash version to use */
> +		__u8	s_jnl_backup_type;
> +		__le16  s_desc_size;		/* size of group descriptor */
> +	/*100*/	__le32	s_default_mount_opts;
> +		__le32	s_first_meta_bg;	/* First metablock block group */
> +		__le32	s_mkfs_time;		/* When the filesystem was created */
> +		__le32	s_jnl_blocks[17];	/* Backup of the journal inode */
> +	/*150*/	__le32	s_blocks_count_hi;	/* Blocks count */
> +		__le32	s_r_blocks_count_hi;	/* Reserved blocks count */
> +		__le32	s_free_blocks_count_hi;	/* Free blocks count */
> +		__le16	s_min_extra_isize;	/* All inodes have at least # bytes */
> +		__le16	s_want_extra_isize; 	/* New inodes should reserve # bytes */
> +		__le32	s_flags;		/* Miscellaneous flags */
> +		__le16  s_raid_stride;		/* RAID stride */
> +		__le16  s_mmp_update_interval;  /* # seconds to wait in MMP checking */
> +		__le64  s_mmp_block;            /* Block for multi-mount protection */
> +		__le32  s_raid_stripe_width;    /* blocks on all data disks (N*stride)*/
> +		__u8	s_log_groups_per_flex;  /* FLEX_BG group size */
> +		__u8	s_checksum_type;	/* metadata checksum algorithm used */
> +		__u8	s_encryption_level;	/* versioning level for encryption */
> +		__u8	s_reserved_pad;		/* Padding to next 32bits */
> +		__le64	s_kbytes_written;	/* nr of lifetime kilobytes written */
> +		__le32	s_snapshot_inum;	/* Inode number of active snapshot */
> +		__le32	s_snapshot_id;		/* sequential ID of active snapshot */
> +		__le64	s_snapshot_r_blocks_count; /* reserved blocks for active
> +						      snapshot's future use */
> +		__le32	s_snapshot_list;	/* inode number of the head of the
> +						   on-disk snapshot list */
> +		__le32	s_error_count;		/* number of fs errors */
> +		__le32	s_first_error_time;	/* first time an error happened */
> +		__le32	s_first_error_ino;	/* inode involved in first error */
> +		__le64	s_first_error_block;	/* block involved of first error */
> +		__u8	s_first_error_func[32];	/* function where the error happened */
> +		__le32	s_first_error_line;	/* line number where error happened */
> +		__le32	s_last_error_time;	/* most recent time of an error */
> +		__le32	s_last_error_ino;	/* inode involved in last error */
> +		__le32	s_last_error_line;	/* line number where error happened */
> +		__le64	s_last_error_block;	/* block involved of last error */
> +		__u8	s_last_error_func[32];	/* function where the error happened */
> +		__u8	s_mount_opts[64];
> +		__le32	s_usr_quota_inum;	/* inode for tracking user quota */
> +		__le32	s_grp_quota_inum;	/* inode for tracking group quota */
> +		__le32	s_overhead_clusters;	/* overhead blocks/clusters in fs */
> +		__le32	s_backup_bgs[2];	/* groups with sparse_super2 SBs */
> +		__u8	s_encrypt_algos[4];	/* Encryption algorithms in use  */
> +		__u8	s_encrypt_pw_salt[16];	/* Salt used for string2key algorithm */
> +		__le32	s_lpf_ino;		/* Location of the lost+found inode */
> +		__le32	s_prj_quota_inum;	/* inode for tracking project quota */
> +		__le32	s_checksum_seed;	/* crc32c(uuid) if csum_seed set */
> +		__u8	s_wtime_hi;
> +		__u8	s_mtime_hi;
> +		__u8	s_mkfs_time_hi;
> +		__u8	s_lastcheck_hi;
> +		__u8	s_first_error_time_hi;
> +		__u8	s_last_error_time_hi;
> +		__u8	s_first_error_errcode;
> +		__u8    s_last_error_errcode;
> +		__le16  s_encoding;		/* Filename charset encoding */
> +		__le16  s_encoding_flags;	/* Filename charset encoding flags */
> +		__le32	s_reserved[95];		/* Padding to the end of the block */
> +		__le32	s_checksum;		/* crc32c(superblock) */
> +	} *r = reply;
> +	char buffer[100];
> +
> +#define Z(S) ((unsigned long long)__le32_to_cpu(S) | (((unsigned long long)S##_hi) << 32))
> +
> +	printf("\n");
> +	printf("\tmkfs    : %s\n", dump_ext4_time(buffer, Z(r->s_mkfs_time)));
> +	printf("\tmount   : %s\n", dump_ext4_time(buffer, Z(r->s_mtime)));
> +	printf("\twrite   : %s\n", dump_ext4_time(buffer, Z(r->s_wtime)));
> +	printf("\tfsck    : %s\n", dump_ext4_time(buffer, Z(r->s_lastcheck)));
> +	printf("\t1st-err : %s\n", dump_ext4_time(buffer, Z(r->s_first_error_time)));
> +	printf("\tlast-err: %s\n", dump_ext4_time(buffer, Z(r->s_last_error_time)));
> +}
> +
>  static void dump_string(void *reply, unsigned int size)
>  {
>  	char *s = reply, *p;
> @@ -476,6 +618,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
>  	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	string),
>  	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	string),
>  	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),
> +	FSINFO_OPAQUE	(FSINFO_ATTR_EXT4_SUPERBLOCK,	ext4_fsinfo_superblock),
>  	{}
>  };
>  
