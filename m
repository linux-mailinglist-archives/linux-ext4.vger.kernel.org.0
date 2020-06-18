Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D01FF69F
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgFRP2R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgFRP2Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF0CC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id g12so2562952pll.10
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c0w1EdPTy+QTYC4xEo8OKfg3zVJgKlGCbpPFVyCBBIE=;
        b=lJ2U+2hCi96dSYI9X6Z1H8N5PkrKg4RicliGXb0Ajyb/gGBQw2SJJTkZSufl0seerD
         YY7QVsfakMKrv2BsQSseOI0VLQtGQyN74FqANuygG2P1YxxOtyyunxcBPEY/hHThPGyx
         wXIL1puIMjdM6dq9/eMXJY1ore62S2DKJ/lqJtm6BQg4AGaRGrfnFbFAkJMlfjsx365H
         MgIv18Xd/jygtBUCQeUmNy/K06sSEvKlCGY6WobhV54m5vmei47O9Gs1JdCBWN+AwXKy
         6Xmr6+9zuy9LsJRgZ9Yj0ST/9/69ITCVykDFIshS49kdQmV4RDOwIhSa9csVBU3veaH1
         b2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c0w1EdPTy+QTYC4xEo8OKfg3zVJgKlGCbpPFVyCBBIE=;
        b=cvlJuiNHB0vhDzqSKOoq3mHc4KMt1ANCgnInYQMp5LT08HAzsuK8MhbtyP16ldQVXY
         zOHyDHMnQoBq/ZAwu803Js33LEHdfKxT5Xm0YZtifq84LDLK30gZOXlpt65yF8SvFkSU
         IPtf8igsuu4lF2eNaHwT/qOs4BAJ2t81piBesPiNKsCNLjnxBtjQOVcli0Jx0TB42ruK
         kPlSxG5NdrXyxGPUCh6JHy5tXrq3cwdeL4jxuHoDP2ALcyT5+/cE1+fl6JzRA4IqHJTn
         KEYdJYLCC1+0+uoKIl1VM1apoKlzkyNalTxWVI/kO05v2CZZwBJIIyMnzh87SuGX6aBd
         YLWw==
X-Gm-Message-State: AOAM531BlVpnn1lQ1aMlc2BI5g/ateZoPfq+HEy3anwF5LSiKj/QoS+K
        LQXm2t4fwzMoUqAZV/ram9YLqdU1iLU=
X-Google-Smtp-Source: ABdhPJyaqajtXoLQEUrytIR9nl6ZV2RsZqcfqmZ34mC40rpBb3vRd4IiiFW+6JRGLHdan+WXd5D8fg==
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr4117285plm.179.1592494095521;
        Thu, 18 Jun 2020 08:28:15 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:14 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 01/51] e2fsck: cleanup struct e2fsck_struct
Date:   Fri, 19 Jun 2020 00:27:04 +0900
Message-Id: <1592494074-28991-2-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Fields of "struct e2fsck_struct" are seperated into
different types according to how these fields will be
used when parallel fsck is enabled.

remove unused @abort_code

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h | 274 ++++++++++++++++++++++++------------------------
 1 file changed, 139 insertions(+), 135 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 9b2b9ce8..f403360e 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -227,91 +227,153 @@ typedef struct e2fsck_struct *e2fsck_t;
 #define MAX_EXTENT_DEPTH_COUNT 5
 
 struct e2fsck_struct {
-	ext2_filsys fs;
-	const char *program_name;
-	char *filesystem_name;
-	char *device_name;
-	char *io_options;
-	FILE	*logf;
-	char	*log_fn;
-	FILE	*problem_logf;
-	char	*problem_log_fn;
-	int	flags;		/* E2fsck internal flags */
-	int	options;
-	unsigned blocksize;	/* blocksize */
-	blk64_t	use_superblock;	/* sb requested by user */
-	blk64_t	superblock;	/* sb used to open fs */
-	blk64_t	num_blocks;	/* Total number of blocks */
-	blk64_t	free_blocks;
-	ext2_ino_t free_inodes;
-	int	mount_flags;
-	int	openfs_flags;
-	blkid_cache blkid;	/* blkid cache */
-
+	/* ---- Following fields are never updated during the pass1 ---- */
+	const char		*program_name;
+	char			*filesystem_name;
+	char			*device_name;
+	char			*io_options;
+	int			 options; /* E2F_OPT_* flags */
+	int			 blocksize; /* blocksize */
+	blk64_t			 use_superblock; /* sb requested by user */
+	blk64_t			 superblock; /* sb used to open fs */
+	blk64_t			 num_blocks; /* Total number of blocks */
+	blk64_t			 free_blocks;
+	ext2_ino_t		 free_inodes;
+	int			 mount_flags;
+	int			 openfs_flags;
+	blkid_cache		 blkid; /* blkid cache */
 #ifdef HAVE_SETJMP_H
-	jmp_buf	abort_loc;
+	jmp_buf			 abort_loc;
 #endif
-	unsigned long abort_code;
+#ifdef RESOURCE_TRACK
+	/*
+	 * For timing purposes
+	 */
+	struct resource_track	global_rtrack;
+#endif
+	int			bad_lost_and_found;
+	/*
+	 * Tuning parameters
+	 */
+	int			process_inode_size;
+	int			inode_buffer_blocks;
+	unsigned int		htree_slack_percentage;
+
+	/*
+	 * ext3 journal support
+	 */
+	io_channel		journal_io;
+	char			*journal_name;
+	/* misc fields */
+	time_t			now;
+	/* For working around buggy init scripts */
+	time_t			time_fudge;
+
+	int			ext_attr_ver;
+	int			blocks_per_page;
+	/* Are we connected directly to a tty? */
+	int			interactive;
+	char			start_meta[2], stop_meta[2];
+	/*
+	 * For the use of callers of the e2fsck functions; not used by
+	 * e2fsck functions themselves.
+	 */
+	void			*priv_data;
+	/* Undo file */
+	char			*undo_file;
+	/* How much are we allowed to readahead? */
+	unsigned long long	readahead_kb;
 
+	/* ---- Following fields are shared by different threads for pass1 -*/
+	/* E2fsck internal flags */
+	int			flags;
+	/*
+	 * How we display the progress update (for unix)
+	 */
+	int			progress_fd;
+	int			progress_pos;
+	int			progress_last_percent;
+	unsigned int		progress_last_time;
 	int (*progress)(e2fsck_t ctx, int pass, unsigned long cur,
 			unsigned long max);
-
-	ext2fs_inode_bitmap inode_used_map; /* Inodes which are in use */
-	ext2fs_inode_bitmap inode_bad_map; /* Inodes which are bad somehow */
-	ext2fs_inode_bitmap inode_dir_map; /* Inodes which are directories */
-	ext2fs_inode_bitmap inode_bb_map; /* Inodes which are in bad blocks */
-	ext2fs_inode_bitmap inode_imagic_map; /* AFS inodes */
-	ext2fs_inode_bitmap inode_reg_map; /* Inodes which are regular files*/
-
-	ext2fs_block_bitmap block_found_map; /* Blocks which are in use */
-	ext2fs_block_bitmap block_dup_map; /* Blks referenced more than once */
-	ext2fs_block_bitmap block_ea_map; /* Blocks which are used by EA's */
+	/* Metadata blocks */
+	ext2fs_block_bitmap	block_metadata_map;
+	profile_t		profile;
+	/* Reserve blocks for root and l+f re-creation */
+	blk64_t			root_repair_block, lnf_repair_block;
+	/*
+	 * Location of the lost and found directory
+	 */
+	ext2_ino_t		lost_and_found;
+
+	/* ---- Following fields are seperated for each thread for pass1- */
+	ext2_filsys		 fs;
+	FILE			*logf;
+	char			*log_fn;
+	FILE			*problem_logf;
+	char			*problem_log_fn;
+
+	/* Inodes which are in use */
+	ext2fs_inode_bitmap	inode_used_map;
+	/* Inodes which are bad somehow */
+	ext2fs_inode_bitmap	inode_bad_map;
+	/* Inodes which are directories */
+	ext2fs_inode_bitmap	inode_dir_map;
+	/* Inodes which are in bad blocks */
+	ext2fs_inode_bitmap	inode_bb_map;
+	/* AFS inodes */
+	ext2fs_inode_bitmap	inode_imagic_map;
+	/* Inodes which are regular files */
+	ext2fs_inode_bitmap	inode_reg_map;
+	/* Inodes to rebuild extent trees */
+	ext2fs_inode_bitmap	inodes_to_rebuild;
+	/* Blocks which are in use */
+	ext2fs_block_bitmap	block_found_map;
+	/* Blks referenced more than once */
+	ext2fs_block_bitmap	block_dup_map;
+	/* Blocks which are used by EA's */
+	ext2fs_block_bitmap	block_ea_map;
 
 	/*
 	 * Inode count arrays
 	 */
-	ext2_icount_t	inode_count;
-	ext2_icount_t inode_link_info;
+	ext2_icount_t		inode_count;
+	ext2_icount_t		inode_link_info;
 
-	ext2_refcount_t	refcount;
-	ext2_refcount_t refcount_extra;
+	ext2_refcount_t		refcount;
+	ext2_refcount_t		refcount_extra;
 
 	/*
 	 * Quota blocks and inodes to be charged for each ea block.
 	 */
-	ext2_refcount_t ea_block_quota_blocks;
-	ext2_refcount_t ea_block_quota_inodes;
+	ext2_refcount_t		ea_block_quota_blocks;
+	ext2_refcount_t		ea_block_quota_inodes;
 
 	/*
 	 * ea_inode references from attr entries.
 	 */
-	ext2_refcount_t ea_inode_refs;
+	ext2_refcount_t		ea_inode_refs;
 
 	/*
 	 * Array of flags indicating whether an inode bitmap, block
 	 * bitmap, or inode table is invalid
 	 */
-	int *invalid_inode_bitmap_flag;
-	int *invalid_block_bitmap_flag;
-	int *invalid_inode_table_flag;
-	int invalid_bitmaps;	/* There are invalid bitmaps/itable */
+	int			*invalid_inode_bitmap_flag;
+	int			*invalid_block_bitmap_flag;
+	int			*invalid_inode_table_flag;
+	/* There are invalid bitmaps/itable */
+	int			invalid_bitmaps;
 
 	/*
 	 * Block buffer
 	 */
-	char *block_buf;
+	char			*block_buf;
 
 	/*
 	 * For pass1_check_directory and pass1_get_blocks
 	 */
-	ext2_ino_t stashed_ino;
-	struct ext2_inode *stashed_inode;
-
-	/*
-	 * Location of the lost and found directory
-	 */
-	ext2_ino_t lost_and_found;
-	int bad_lost_and_found;
+	ext2_ino_t		stashed_ino;
+	struct ext2_inode	*stashed_inode;
 
 	/*
 	 * Directory information
@@ -328,96 +390,38 @@ struct e2fsck_struct {
 	/*
 	 * Directories to hash
 	 */
-	ext2_u32_list	dirs_to_hash;
+	ext2_u32_list		dirs_to_hash;
 
 	/*
 	 * Encrypted file information
 	 */
 	struct encrypted_file_info *encrypted_files;
 
-	/*
-	 * Tuning parameters
-	 */
-	int process_inode_size;
-	int inode_buffer_blocks;
-	unsigned int htree_slack_percentage;
-
-	/*
-	 * ext3 journal support
-	 */
-	io_channel	journal_io;
-	char	*journal_name;
-
 	/*
 	 * Ext4 quota support
 	 */
-	quota_ctx_t qctx;
-#ifdef RESOURCE_TRACK
-	/*
-	 * For timing purposes
-	 */
-	struct resource_track	global_rtrack;
-#endif
-
-	/*
-	 * How we display the progress update (for unix)
-	 */
-	int progress_fd;
-	int progress_pos;
-	int progress_last_percent;
-	unsigned int progress_last_time;
-	int interactive;	/* Are we connected directly to a tty? */
-	char start_meta[2], stop_meta[2];
-
-	/* File counts */
-	__u32 fs_directory_count;
-	__u32 fs_regular_count;
-	__u32 fs_blockdev_count;
-	__u32 fs_chardev_count;
-	__u32 fs_links_count;
-	__u32 fs_symlinks_count;
-	__u32 fs_fast_symlinks_count;
-	__u32 fs_fifo_count;
-	__u32 fs_total_count;
-	__u32 fs_badblocks_count;
-	__u32 fs_sockets_count;
-	__u32 fs_ind_count;
-	__u32 fs_dind_count;
-	__u32 fs_tind_count;
-	__u32 fs_fragmented;
-	__u32 fs_fragmented_dir;
-	__u32 large_files;
-	__u32 fs_ext_attr_inodes;
-	__u32 fs_ext_attr_blocks;
-	__u32 extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
-
-	/* misc fields */
-	time_t now;
-	time_t time_fudge;	/* For working around buggy init scripts */
-	int ext_attr_ver;
-	profile_t	profile;
-	int blocks_per_page;
-
-	/* Reserve blocks for root and l+f re-creation */
-	blk64_t root_repair_block, lnf_repair_block;
-
-	/*
-	 * For the use of callers of the e2fsck functions; not used by
-	 * e2fsck functions themselves.
-	 */
-	void *priv_data;
-	ext2fs_block_bitmap block_metadata_map; /* Metadata blocks */
-
-	/* How much are we allowed to readahead? */
-	unsigned long long readahead_kb;
-
-	/*
-	 * Inodes to rebuild extent trees
-	 */
-	ext2fs_inode_bitmap inodes_to_rebuild;
-
-	/* Undo file */
-	char *undo_file;
+	quota_ctx_t		qctx;
+
+	__u32			fs_directory_count;
+	__u32			fs_regular_count;
+	__u32			fs_blockdev_count;
+	__u32			fs_chardev_count;
+	__u32			fs_links_count;
+	__u32			fs_symlinks_count;
+	__u32			fs_fast_symlinks_count;
+	__u32			fs_fifo_count;
+	__u32			fs_total_count;
+	__u32			fs_badblocks_count;
+	__u32			fs_sockets_count;
+	__u32			fs_ind_count;
+	__u32			fs_dind_count;
+	__u32			fs_tind_count;
+	__u32			fs_fragmented;
+	__u32			fs_fragmented_dir;
+	__u32			large_files;
+	__u32			fs_ext_attr_inodes;
+	__u32			fs_ext_attr_blocks;
+	__u32			extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
 };
 
 /* Data structures to evaluate whether an extent tree needs rebuilding. */
-- 
2.25.4

