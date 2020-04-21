Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E6A1B2C70
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 18:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgDUQSC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Apr 2020 12:18:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59455 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgDUQSB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Apr 2020 12:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587485875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZXXSFVJDuG4LPFh/+x0KJS0IZGOZjne+bWZWTK7hc8=;
        b=AnFi4dwRHMBm8Ud3Y4ntW1TdZgh4kjbOyNg5TLbhgEJpel4mrnCm19cmDxMhwW3qAwl+t9
        m2E9Mx2rcmW1TRzgq/dS/yUnmOZ8BsajNug9YQyarV6Gw6lQUUV5Bk4RsBzhxiUEvxjN67
        Iye2bLm9+4gkg7y2BmoD+hAeu7kYbsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-NpJvsCi6OKGIxM7egpdVHg-1; Tue, 21 Apr 2020 12:17:26 -0400
X-MC-Unique: NpJvsCi6OKGIxM7egpdVHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F59C1922027;
        Tue, 21 Apr 2020 16:17:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8E8D60C87;
        Tue, 21 Apr 2020 16:17:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200401151837.GB56931@magnolia>
References: <20200401151837.GB56931@magnolia> <2461554.1585726747@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: Exporting ext4-specific information through fsinfo attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2504711.1587485842.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Apr 2020 17:17:22 +0100
Message-ID: <2504712.1587485842@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Darrick J. Wong <darrick.wong@oracle.com> wrote:

> The entire superblock as a binary blob? :)

How about the attached?  Please forgive the duplication of struct
ext4_super_block into the test program, but it's not in the UAPI.

David
---
fsinfo: Add support to ext4
    =

Add support to ext4, including the following:

 (1) FSINFO_ATTR_SUPPORTS: Information about supported STATX attributes an=
d
     support for ioctls like FS_IOC_[GS]ETFLAGS and FS_IOC_FS[GS]ETXATTR.

 (2) FSINFO_ATTR_FEATURES: Information about features supported by an ext4
     filesystem, such as whether version counting, birth time and name cas=
e
     folding are in operation.

 (3) FSINFO_ATTR_VOLUME_NAME: The volume name from the superblock.

 (4) FSINFO_ATTR_EXT4_SUPERBLOCK: The entirety of the on disk-format
     superblock record as an opaque blob.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "Theodore Ts'o" <tytso@mit.edu>
cc: Andreas Dilger <adilger.kernel@dilger.ca>
cc: "Darrick J. Wong" <darrick.wong@oracle.com>
cc: Eric Biggers <ebiggers@kernel.org>
cc: linux-ext4@vger.kernel.org
---
 fs/ext4/Makefile            |    1 =

 fs/ext4/ext4.h              |    6 +
 fs/ext4/fsinfo.c            |  106 ++++++++++++++++++++++++++++++++
 fs/ext4/super.c             |    3 =

 include/uapi/linux/fsinfo.h |    2 =

 samples/vfs/test-fsinfo.c   |  143 ++++++++++++++++++++++++++++++++++++++=
++++++
 6 files changed, 261 insertions(+)


diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 4ccb3c9189d8..71d5b460c7c7 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -16,3 +16,4 @@ ext4-$(CONFIG_EXT4_FS_SECURITY)		+=3D xattr_security.o
 ext4-inode-test-objs			+=3D inode-test.o
 obj-$(CONFIG_EXT4_KUNIT_TESTS)		+=3D ext4-inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+=3D verity.o
+ext4-$(CONFIG_FSINFO)			+=3D fsinfo.o
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..674581da786c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -42,6 +42,7 @@
 =

 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
+#include <linux/fsinfo.h>
 =

 #include <linux/compiler.h>
 =

@@ -3207,6 +3208,11 @@ extern const struct inode_operations ext4_file_inod=
e_operations;
 extern const struct file_operations ext4_file_operations;
 extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
 =

+/* fsinfo.c */
+#ifdef CONFIG_FSINFO
+extern int ext4_fsinfo(struct path *path, struct fsinfo_context *ctx);
+#endif
+
 /* inline.c */
 extern int ext4_get_max_inline_size(struct inode *inode);
 extern int ext4_find_inline_data_nolock(struct inode *inode);
diff --git a/fs/ext4/fsinfo.c b/fs/ext4/fsinfo.c
new file mode 100644
index 000000000000..52bfd09e550f
--- /dev/null
+++ b/fs/ext4/fsinfo.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Filesystem information for ext4
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/mount.h>
+#include "ext4.h"
+
+static int ext4_fsinfo_supports(struct path *path, struct fsinfo_context =
*ctx)
+{
+	struct fsinfo_supports *p =3D ctx->buffer;
+	struct inode *inode =3D d_inode(path->dentry);
+	struct ext4_inode_info *ei =3D EXT4_I(inode);
+	struct ext4_inode *raw_inode;
+	u32 flags;
+
+	fsinfo_generic_supports(path, ctx);
+	p->stx_attributes |=3D (STATX_ATTR_APPEND |
+			      STATX_ATTR_COMPRESSED |
+			      STATX_ATTR_ENCRYPTED |
+			      STATX_ATTR_IMMUTABLE |
+			      STATX_ATTR_NODUMP |
+			      STATX_ATTR_VERITY);
+	if (EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime))
+		p->stx_mask |=3D STATX_BTIME;
+
+	flags =3D EXT4_FL_USER_VISIBLE;
+	if (S_ISREG(inode->i_mode))
+		flags &=3D ~EXT4_PROJINHERIT_FL;
+	p->fs_ioc_getflags =3D flags;
+	flags &=3D EXT4_FL_USER_MODIFIABLE;
+	p->fs_ioc_setflags_set =3D flags;
+	p->fs_ioc_setflags_clear =3D flags;
+
+	p->fs_ioc_fsgetxattr_xflags =3D EXT4_FL_XFLAG_VISIBLE;
+	p->fs_ioc_fssetxattr_xflags_set =3D EXT4_FL_XFLAG_VISIBLE;
+	p->fs_ioc_fssetxattr_xflags_clear =3D EXT4_FL_XFLAG_VISIBLE;
+	return sizeof(*p);
+}
+
+static int ext4_fsinfo_features(struct path *path, struct fsinfo_context =
*ctx)
+{
+	struct fsinfo_features *p =3D ctx->buffer;
+	struct super_block *sb =3D path->dentry->d_sb;
+	struct inode *inode =3D d_inode(path->dentry);
+	struct ext4_inode_info *ei =3D EXT4_I(inode);
+	struct ext4_inode *raw_inode;
+
+	fsinfo_generic_features(path, ctx);
+	fsinfo_set_unix_features(p);
+	fsinfo_set_feature(p, FSINFO_FEAT_VOLUME_UUID);
+	fsinfo_set_feature(p, FSINFO_FEAT_VOLUME_NAME);
+	fsinfo_set_feature(p, FSINFO_FEAT_O_SYNC);
+	fsinfo_set_feature(p, FSINFO_FEAT_O_DIRECT);
+	fsinfo_set_feature(p, FSINFO_FEAT_ADV_LOCKS);
+
+	if (test_opt(sb, XATTR_USER))
+		fsinfo_set_feature(p, FSINFO_FEAT_XATTRS);
+	if (ext4_has_feature_journal(sb))
+		fsinfo_set_feature(p, FSINFO_FEAT_JOURNAL);
+	if (ext4_has_feature_casefold(sb))
+		fsinfo_set_feature(p, FSINFO_FEAT_NAME_CASE_INDEP);
+
+	if (sb->s_flags & SB_I_VERSION &&
+	    !test_opt2(sb, HURD_COMPAT) &&
+	    EXT4_INODE_SIZE(sb) > EXT4_GOOD_OLD_INODE_SIZE) {
+		fsinfo_set_feature(p, FSINFO_FEAT_IVER_DATA_CHANGE);
+		fsinfo_set_feature(p, FSINFO_FEAT_IVER_MONO_INCR);
+	}
+
+	if (EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime))
+		fsinfo_set_feature(p, FSINFO_FEAT_HAS_BTIME);
+	return sizeof(*p);
+}
+
+static int ext4_fsinfo_get_volume_name(struct path *path, struct fsinfo_c=
ontext *ctx)
+{
+	const struct ext4_sb_info *sbi =3D EXT4_SB(path->mnt->mnt_sb);
+	const struct ext4_super_block *es =3D sbi->s_es;
+
+	memcpy(ctx->buffer, es->s_volume_name, sizeof(es->s_volume_name));
+	return strlen(ctx->buffer) + 1;
+}
+
+static int ext4_fsinfo_get_superblock(struct path *path, struct fsinfo_co=
ntext *ctx)
+{
+	const struct ext4_sb_info *sbi =3D EXT4_SB(path->mnt->mnt_sb);
+	const struct ext4_super_block *es =3D sbi->s_es;
+
+	return fsinfo_opaque(es, ctx, sizeof(*es));
+}
+
+static const struct fsinfo_attribute ext4_fsinfo_attributes[] =3D {
+	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		ext4_fsinfo_supports),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		ext4_fsinfo_features),
+	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	ext4_fsinfo_get_volume_name),
+	FSINFO_OPAQUE	(FSINFO_ATTR_EXT4_SUPERBLOCK,	ext4_fsinfo_get_superblock),
+	{}
+};
+
+int ext4_fsinfo(struct path *path, struct fsinfo_context *ctx)
+{
+	return fsinfo_get_attribute(path, ctx, ext4_fsinfo_attributes);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bf5fcb477f66..201287a90c4b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1482,6 +1482,9 @@ static const struct super_operations ext4_sops =3D {
 	.freeze_fs	=3D ext4_freeze,
 	.unfreeze_fs	=3D ext4_unfreeze,
 	.statfs		=3D ext4_statfs,
+#ifdef CONFIG_FSINFO
+	.fsinfo		=3D ext4_fsinfo,
+#endif
 	.remount_fs	=3D ext4_remount,
 	.show_options	=3D ext4_show_options,
 #ifdef CONFIG_QUOTA
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 3483dd9a5d05..51214c0c82b1 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -42,6 +42,8 @@
 #define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of the Nth server (stri=
ng) */
 #define FSINFO_ATTR_AFS_SERVER_ADDRESSES 0x302	/* List of addresses of th=
e Nth server */
 =

+#define FSINFO_ATTR_EXT4_SUPERBLOCK	0x400	/* Ext4 superblock (opaque) */
+
 /*
  * Optional fsinfo() parameter structure.
  *
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 4c6f3f1002dd..a6dacc2ec59d 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -24,6 +24,7 @@
 #include <sys/stat.h>
 #include <arpa/inet.h>
 #include <linux/rxrpc.h>
+#include <linux/byteorder/little_endian.h>
 =

 #ifndef __NR_fsinfo
 #define __NR_fsinfo -1
@@ -389,6 +390,147 @@ static void dump_afs_fsinfo_server_address(void *rep=
ly, unsigned int size)
 	printf("family=3D%u\n", ss->ss_family);
 }
 =

+static char *dump_ext4_time(char *buffer, time_t tim)
+{
+	struct tm tm;
+	int len;
+
+	if (tim =3D=3D 0)
+		return "-";
+
+	if (!localtime_r(&tim, &tm)) {
+		perror("localtime_r");
+		exit(1);
+	}
+	len =3D strftime(buffer, 100, "%F %T", &tm);
+	if (len =3D=3D 0) {
+		perror("strftime");
+		exit(1);
+	}
+	return buffer;
+}
+
+static void dump_ext4_fsinfo_superblock(void *reply, unsigned int size)
+{
+	struct ext4_super_block {
+	/*00*/	__le32	s_inodes_count;		/* Inodes count */
+		__le32	s_blocks_count_lo;	/* Blocks count */
+		__le32	s_r_blocks_count_lo;	/* Reserved blocks count */
+		__le32	s_free_blocks_count_lo;	/* Free blocks count */
+	/*10*/	__le32	s_free_inodes_count;	/* Free inodes count */
+		__le32	s_first_data_block;	/* First Data Block */
+		__le32	s_log_block_size;	/* Block size */
+		__le32	s_log_cluster_size;	/* Allocation cluster size */
+	/*20*/	__le32	s_blocks_per_group;	/* # Blocks per group */
+		__le32	s_clusters_per_group;	/* # Clusters per group */
+		__le32	s_inodes_per_group;	/* # Inodes per group */
+		__le32	s_mtime;		/* Mount time */
+	/*30*/	__le32	s_wtime;		/* Write time */
+		__le16	s_mnt_count;		/* Mount count */
+		__le16	s_max_mnt_count;	/* Maximal mount count */
+		__le16	s_magic;		/* Magic signature */
+		__le16	s_state;		/* File system state */
+		__le16	s_errors;		/* Behaviour when detecting errors */
+		__le16	s_minor_rev_level;	/* minor revision level */
+	/*40*/	__le32	s_lastcheck;		/* time of last check */
+		__le32	s_checkinterval;	/* max. time between checks */
+		__le32	s_creator_os;		/* OS */
+		__le32	s_rev_level;		/* Revision level */
+	/*50*/	__le16	s_def_resuid;		/* Default uid for reserved blocks */
+		__le16	s_def_resgid;		/* Default gid for reserved blocks */
+		__le32	s_first_ino;		/* First non-reserved inode */
+		__le16  s_inode_size;		/* size of inode structure */
+		__le16	s_block_group_nr;	/* block group # of this superblock */
+		__le32	s_feature_compat;	/* compatible feature set */
+	/*60*/	__le32	s_feature_incompat;	/* incompatible feature set */
+		__le32	s_feature_ro_compat;	/* readonly-compatible feature set */
+	/*68*/	__u8	s_uuid[16];		/* 128-bit uuid for volume */
+	/*78*/	char	s_volume_name[16];	/* volume name */
+	/*88*/	char	s_last_mounted[64];	/* directory where last mounted */
+	/*C8*/	__le32	s_algorithm_usage_bitmap; /* For compression */
+		__u8	s_prealloc_blocks;	/* Nr of blocks to try to preallocate*/
+		__u8	s_prealloc_dir_blocks;	/* Nr to preallocate for dirs */
+		__le16	s_reserved_gdt_blocks;	/* Per group desc for online growth */
+	/*D0*/	__u8	s_journal_uuid[16];	/* uuid of journal superblock */
+	/*E0*/	__le32	s_journal_inum;		/* inode number of journal file */
+		__le32	s_journal_dev;		/* device number of journal file */
+		__le32	s_last_orphan;		/* start of list of inodes to delete */
+		__le32	s_hash_seed[4];		/* HTREE hash seed */
+		__u8	s_def_hash_version;	/* Default hash version to use */
+		__u8	s_jnl_backup_type;
+		__le16  s_desc_size;		/* size of group descriptor */
+	/*100*/	__le32	s_default_mount_opts;
+		__le32	s_first_meta_bg;	/* First metablock block group */
+		__le32	s_mkfs_time;		/* When the filesystem was created */
+		__le32	s_jnl_blocks[17];	/* Backup of the journal inode */
+	/*150*/	__le32	s_blocks_count_hi;	/* Blocks count */
+		__le32	s_r_blocks_count_hi;	/* Reserved blocks count */
+		__le32	s_free_blocks_count_hi;	/* Free blocks count */
+		__le16	s_min_extra_isize;	/* All inodes have at least # bytes */
+		__le16	s_want_extra_isize; 	/* New inodes should reserve # bytes */
+		__le32	s_flags;		/* Miscellaneous flags */
+		__le16  s_raid_stride;		/* RAID stride */
+		__le16  s_mmp_update_interval;  /* # seconds to wait in MMP checking */
+		__le64  s_mmp_block;            /* Block for multi-mount protection */
+		__le32  s_raid_stripe_width;    /* blocks on all data disks (N*stride)*=
/
+		__u8	s_log_groups_per_flex;  /* FLEX_BG group size */
+		__u8	s_checksum_type;	/* metadata checksum algorithm used */
+		__u8	s_encryption_level;	/* versioning level for encryption */
+		__u8	s_reserved_pad;		/* Padding to next 32bits */
+		__le64	s_kbytes_written;	/* nr of lifetime kilobytes written */
+		__le32	s_snapshot_inum;	/* Inode number of active snapshot */
+		__le32	s_snapshot_id;		/* sequential ID of active snapshot */
+		__le64	s_snapshot_r_blocks_count; /* reserved blocks for active
+						      snapshot's future use */
+		__le32	s_snapshot_list;	/* inode number of the head of the
+						   on-disk snapshot list */
+		__le32	s_error_count;		/* number of fs errors */
+		__le32	s_first_error_time;	/* first time an error happened */
+		__le32	s_first_error_ino;	/* inode involved in first error */
+		__le64	s_first_error_block;	/* block involved of first error */
+		__u8	s_first_error_func[32];	/* function where the error happened */
+		__le32	s_first_error_line;	/* line number where error happened */
+		__le32	s_last_error_time;	/* most recent time of an error */
+		__le32	s_last_error_ino;	/* inode involved in last error */
+		__le32	s_last_error_line;	/* line number where error happened */
+		__le64	s_last_error_block;	/* block involved of last error */
+		__u8	s_last_error_func[32];	/* function where the error happened */
+		__u8	s_mount_opts[64];
+		__le32	s_usr_quota_inum;	/* inode for tracking user quota */
+		__le32	s_grp_quota_inum;	/* inode for tracking group quota */
+		__le32	s_overhead_clusters;	/* overhead blocks/clusters in fs */
+		__le32	s_backup_bgs[2];	/* groups with sparse_super2 SBs */
+		__u8	s_encrypt_algos[4];	/* Encryption algorithms in use  */
+		__u8	s_encrypt_pw_salt[16];	/* Salt used for string2key algorithm */
+		__le32	s_lpf_ino;		/* Location of the lost+found inode */
+		__le32	s_prj_quota_inum;	/* inode for tracking project quota */
+		__le32	s_checksum_seed;	/* crc32c(uuid) if csum_seed set */
+		__u8	s_wtime_hi;
+		__u8	s_mtime_hi;
+		__u8	s_mkfs_time_hi;
+		__u8	s_lastcheck_hi;
+		__u8	s_first_error_time_hi;
+		__u8	s_last_error_time_hi;
+		__u8	s_first_error_errcode;
+		__u8    s_last_error_errcode;
+		__le16  s_encoding;		/* Filename charset encoding */
+		__le16  s_encoding_flags;	/* Filename charset encoding flags */
+		__le32	s_reserved[95];		/* Padding to the end of the block */
+		__le32	s_checksum;		/* crc32c(superblock) */
+	} *r =3D reply;
+	char buffer[100];
+
+#define Z(S) ((unsigned long long)__le32_to_cpu(S) | (((unsigned long lon=
g)S##_hi) << 32))
+
+	printf("\n");
+	printf("\tmkfs    : %s\n", dump_ext4_time(buffer, Z(r->s_mkfs_time)));
+	printf("\tmount   : %s\n", dump_ext4_time(buffer, Z(r->s_mtime)));
+	printf("\twrite   : %s\n", dump_ext4_time(buffer, Z(r->s_wtime)));
+	printf("\tfsck    : %s\n", dump_ext4_time(buffer, Z(r->s_lastcheck)));
+	printf("\t1st-err : %s\n", dump_ext4_time(buffer, Z(r->s_first_error_tim=
e)));
+	printf("\tlast-err: %s\n", dump_ext4_time(buffer, Z(r->s_last_error_time=
)));
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s =3D reply, *p;
@@ -476,6 +618,7 @@ static const struct fsinfo_attribute fsinfo_attributes=
[] =3D {
 	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	string),
 	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	string),
 	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_addre=
ss),
+	FSINFO_OPAQUE	(FSINFO_ATTR_EXT4_SUPERBLOCK,	ext4_fsinfo_superblock),
 	{}
 };
 =

