Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F696CFA3C
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Mar 2023 06:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjC3EgN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Mar 2023 00:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC3EgM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Mar 2023 00:36:12 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ECB19A5;
        Wed, 29 Mar 2023 21:36:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DA4D5C0134;
        Thu, 30 Mar 2023 00:36:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 Mar 2023 00:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680150968; x=1680237368; bh=Ox
        ydhHm5sByppJZY7BF+AtV3TG8Tt4eR+iaK+Zt8tTE=; b=hBSWUpzx1G6jZSAuC7
        rmb3SxniDBpxbSf91cwWxi0GrJlfjAfm0gHo2KRMjm2DEjjsehuDDJCLKmtidNCA
        17XwEYHl/BXTJPhtAB9lAMV9X2Shi2y9rcvNNSaICLTUp1mZqsTB7GiFoeXq0a2k
        wB5WwcZ26aPcPwQ/7OcloDENS53d1J8ZhBiGs7rFfgYZbqAdkb2umANA9ft48KGE
        V2f1tFHdw9MZIbODY7PSMbvljnJgvSkQuit1hjG1v2Dz8fD85GJl3RgXU4GQ2Y3Y
        6vUTcNp8WrUteRr2ZqhyqxpJEeV5kEVzjf8c7oIfyKkNTj3hD/9/xH+8sCOQigIS
        ZBQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680150968; x=1680237368; bh=OxydhHm5sByppJZY7BF+AtV3TG8Tt4eR+ia
        K+Zt8tTE=; b=R9Ht4JkVmIGN2vXDizoSVjW3MDebL2NfU4UMtxtt+/nwcclBMjO
        PhWtyj/1sXcOEk0ud75QA7E7v5NZVs9rxriqsOyy1hc1z3Y8LZjmCxeFJgN9OEMo
        NLZmkHC4r70aZoy8qZgqd2aLSeNqIskIXMgQRaTW+m0kUJQKLy5m0Q45JmvMDmLJ
        SnxAvnF2mmZK3Tqho5A+wSnILhNqZMIMijjQoF2eFl1KdNuhFHKJWuPqdYmi73sv
        HOohLVntnawn0czBMTRAYsgi6ETE0HeXz0c4g5mImALRzs7CoGThniwclDXOsJvg
        37sJX/ZOPpZsR4Vk6kO7pdKmyxUwbjvS1xQ==
X-ME-Sender: <xms:uBElZAfdPL8xAkUd-SH7jA5cMQiGvvpwT9rnZGbRKan8KHzvfot3kQ>
    <xme:uBElZCOC6DdjmvnrSPpiVAUP2mhSZ9FDRrB7Ob7TVNBWFv2wDiGoJho2OqCsjTwHi
    ytv6aWu-Z30RPRaEwo>
X-ME-Received: <xmr:uBElZBgzj_w6zLE-rldCIgGcQhiq77Gfx1M5Si-ToVUdllVLL9-SsmLc9nKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehjedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhr
    ihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeelteekheejvdfffedvjeduke
    evtefhffdugeffveffgeffkeekteefudeuteehveenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:uBElZF-9419FF1XEKk2g1XgX4W97_JIBR0AYsPGVRUP3ma_t27-enQ>
    <xmx:uBElZMu_8qF4XEKfKheRBm2AZp42lL-xGdS8aVb2iuwveS4661IonA>
    <xmx:uBElZMGntmbLRL3egEuwYg5TJ1sikNBARIsn2_LzX1QLCgUj0YarCA>
    <xmx:uBElZF7biy_EWBGmFh6jRFaA9AgM3tgm9sx142eWFQXMf_-UpLCv_Q>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 00:36:05 -0400 (EDT)
Date:   Thu, 30 Mar 2023 13:36:00 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: Add a uapi header for ext4 userspace APIs
Message-ID: <f0c650c0a0bcc799101573d265f3006c6f6bd046.1680149153.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Create a uapi header include/uapi/linux/ext4.h, move the ioctls and
associated data structures to the uapi header, and include it from
fs/ext4/ext4.h.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

Found myself needing this, for the benefit of generating userspace ioctl
bindings, and I saw in
https://lore.kernel.org/linux-ext4/YJ7q+QA%2FYX3Q1s+q@mit.edu/ that Ted
mentioned a desire for include/uapi/linux/ext4.h in the future.

Happy to adjust this as desired. I started out very conservative about
what was "userspace API", just including the ioctls and associated data
structures, and not (for instance) anything related to the on-disk
format such as feature flags.

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08b29c289da4..e976c272cc77 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -40,6 +40,7 @@
 #ifdef __KERNEL__
 #include <linux/compat.h>
 #endif
+#include <uapi/linux/ext4.h>
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
@@ -591,29 +592,6 @@ static inline void ext4_check_flag_values(void)
 	CHECK_FLAG_VALUE(RESERVED);
 }
 
-/* Used to pass group descriptor data when online resize is done */
-struct ext4_new_group_input {
-	__u32 group;		/* Group number for this data */
-	__u64 block_bitmap;	/* Absolute block number of block bitmap */
-	__u64 inode_bitmap;	/* Absolute block number of inode bitmap */
-	__u64 inode_table;	/* Absolute block number of inode table start */
-	__u32 blocks_count;	/* Total number of blocks in this group */
-	__u16 reserved_blocks;	/* Number of reserved blocks in this group */
-	__u16 unused;
-};
-
-#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
-struct compat_ext4_new_group_input {
-	u32 group;
-	compat_u64 block_bitmap;
-	compat_u64 inode_bitmap;
-	compat_u64 inode_table;
-	u32 blocks_count;
-	u16 reserved_blocks;
-	u16 unused;
-};
-#endif
-
 /* The struct ext4_new_group_input in kernel space, with free_blocks_count */
 struct ext4_new_group_data {
 	__u32 group;
@@ -698,90 +676,6 @@ enum {
 #define EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER	0x0020
 #define EXT4_FREE_BLOCKS_RERESERVE_CLUSTER      0x0040
 
-/*
- * ioctl commands
- */
-#define	EXT4_IOC_GETVERSION		_IOR('f', 3, long)
-#define	EXT4_IOC_SETVERSION		_IOW('f', 4, long)
-#define	EXT4_IOC_GETVERSION_OLD		FS_IOC_GETVERSION
-#define	EXT4_IOC_SETVERSION_OLD		FS_IOC_SETVERSION
-#define EXT4_IOC_GETRSVSZ		_IOR('f', 5, long)
-#define EXT4_IOC_SETRSVSZ		_IOW('f', 6, long)
-#define EXT4_IOC_GROUP_EXTEND		_IOW('f', 7, unsigned long)
-#define EXT4_IOC_GROUP_ADD		_IOW('f', 8, struct ext4_new_group_input)
-#define EXT4_IOC_MIGRATE		_IO('f', 9)
- /* note ioctl 10 reserved for an early version of the FIEMAP ioctl */
- /* note ioctl 11 reserved for filesystem-independent FIEMAP ioctl */
-#define EXT4_IOC_ALLOC_DA_BLKS		_IO('f', 12)
-#define EXT4_IOC_MOVE_EXT		_IOWR('f', 15, struct move_extent)
-#define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
-#define EXT4_IOC_SWAP_BOOT		_IO('f', 17)
-#define EXT4_IOC_PRECACHE_EXTENTS	_IO('f', 18)
-/* ioctl codes 19--39 are reserved for fscrypt */
-#define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
-#define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
-#define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
-#define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
-#define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
-#define EXT4_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
-
-#define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
-
-/*
- * Flags for going down operation
- */
-#define EXT4_GOING_FLAGS_DEFAULT		0x0	/* going down */
-#define EXT4_GOING_FLAGS_LOGFLUSH		0x1	/* flush log but not data */
-#define EXT4_GOING_FLAGS_NOLOGFLUSH		0x2	/* don't flush log nor data */
-
-/*
- * Flags returned by EXT4_IOC_GETSTATE
- *
- * We only expose to userspace a subset of the state flags in
- * i_state_flags
- */
-#define EXT4_STATE_FLAG_EXT_PRECACHED	0x00000001
-#define EXT4_STATE_FLAG_NEW		0x00000002
-#define EXT4_STATE_FLAG_NEWENTRY	0x00000004
-#define EXT4_STATE_FLAG_DA_ALLOC_CLOSE	0x00000008
-
-/* flags for ioctl EXT4_IOC_CHECKPOINT */
-#define EXT4_IOC_CHECKPOINT_FLAG_DISCARD	0x1
-#define EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT	0x2
-#define EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN	0x4
-#define EXT4_IOC_CHECKPOINT_FLAG_VALID		(EXT4_IOC_CHECKPOINT_FLAG_DISCARD | \
-						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
-						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
-
-/*
- * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
- */
-struct fsuuid {
-	__u32       fsu_len;
-	__u32       fsu_flags;
-	__u8        fsu_uuid[];
-};
-
-#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
-/*
- * ioctl commands in 32 bit emulation
- */
-#define EXT4_IOC32_GETVERSION		_IOR('f', 3, int)
-#define EXT4_IOC32_SETVERSION		_IOW('f', 4, int)
-#define EXT4_IOC32_GETRSVSZ		_IOR('f', 5, int)
-#define EXT4_IOC32_SETRSVSZ		_IOW('f', 6, int)
-#define EXT4_IOC32_GROUP_EXTEND		_IOW('f', 7, unsigned int)
-#define EXT4_IOC32_GROUP_ADD		_IOW('f', 8, struct compat_ext4_new_group_input)
-#define EXT4_IOC32_GETVERSION_OLD	FS_IOC32_GETVERSION
-#define EXT4_IOC32_SETVERSION_OLD	FS_IOC32_SETVERSION
-#endif
-
-/*
- * Returned by EXT4_IOC_GET_ES_CACHE as an additional possible flag.
- * It indicates that the entry in extent status cache is for a hole.
- */
-#define EXT4_FIEMAP_EXTENT_HOLE		0x08000000
-
 /* Max physical block we can address w/o extents */
 #define EXT4_MAX_BLOCK_FILE_PHYS	0xFFFFFFFF
 
@@ -852,15 +746,6 @@ struct ext4_inode {
 	__le32	i_projid;	/* Project ID */
 };
 
-struct move_extent {
-	__u32 reserved;		/* should be zero */
-	__u32 donor_fd;		/* donor file descriptor */
-	__u64 orig_start;	/* logical start offset in block for orig */
-	__u64 donor_start;	/* logical start offset in block for donor */
-	__u64 len;		/* block length to be moved */
-	__u64 moved_len;	/* moved block length */
-};
-
 #define EXT4_EPOCH_BITS 2
 #define EXT4_EPOCH_MASK ((1 << EXT4_EPOCH_BITS) - 1)
 #define EXT4_NSEC_MASK  (~0UL << EXT4_EPOCH_BITS)
diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
new file mode 100644
index 000000000000..efebc2e88192
--- /dev/null
+++ b/include/uapi/linux/ext4.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_EXT4_H
+#define _UAPI_LINUX_EXT4_H
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#include <uapi/linux/fiemap.h>
+#include <uapi/linux/fs.h>
+
+/*
+ * ext4-specific ioctl commands
+ */
+#define	EXT4_IOC_GETVERSION		_IOR('f', 3, long)
+#define	EXT4_IOC_SETVERSION		_IOW('f', 4, long)
+#define	EXT4_IOC_GETVERSION_OLD		FS_IOC_GETVERSION
+#define	EXT4_IOC_SETVERSION_OLD		FS_IOC_SETVERSION
+#define EXT4_IOC_GETRSVSZ		_IOR('f', 5, long)
+#define EXT4_IOC_SETRSVSZ		_IOW('f', 6, long)
+#define EXT4_IOC_GROUP_EXTEND		_IOW('f', 7, unsigned long)
+#define EXT4_IOC_GROUP_ADD		_IOW('f', 8, struct ext4_new_group_input)
+#define EXT4_IOC_MIGRATE		_IO('f', 9)
+ /* note ioctl 10 reserved for an early version of the FIEMAP ioctl */
+ /* note ioctl 11 reserved for filesystem-independent FIEMAP ioctl */
+#define EXT4_IOC_ALLOC_DA_BLKS		_IO('f', 12)
+#define EXT4_IOC_MOVE_EXT		_IOWR('f', 15, struct move_extent)
+#define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
+#define EXT4_IOC_SWAP_BOOT		_IO('f', 17)
+#define EXT4_IOC_PRECACHE_EXTENTS	_IO('f', 18)
+/* ioctl codes 19--39 are reserved for fscrypt */
+#define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
+#define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
+#define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
+#define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
+#define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
+#define EXT4_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
+
+#define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
+
+/*
+ * ioctl commands in 32 bit emulation
+ */
+#define EXT4_IOC32_GETVERSION		_IOR('f', 3, int)
+#define EXT4_IOC32_SETVERSION		_IOW('f', 4, int)
+#define EXT4_IOC32_GETRSVSZ		_IOR('f', 5, int)
+#define EXT4_IOC32_SETRSVSZ		_IOW('f', 6, int)
+#define EXT4_IOC32_GROUP_EXTEND		_IOW('f', 7, unsigned int)
+#define EXT4_IOC32_GROUP_ADD		_IOW('f', 8, struct compat_ext4_new_group_input)
+#define EXT4_IOC32_GETVERSION_OLD	FS_IOC32_GETVERSION
+#define EXT4_IOC32_SETVERSION_OLD	FS_IOC32_SETVERSION
+
+/*
+ * Flags returned by EXT4_IOC_GETSTATE
+ *
+ * We only expose to userspace a subset of the state flags in
+ * i_state_flags
+ */
+#define EXT4_STATE_FLAG_EXT_PRECACHED	0x00000001
+#define EXT4_STATE_FLAG_NEW		0x00000002
+#define EXT4_STATE_FLAG_NEWENTRY	0x00000004
+#define EXT4_STATE_FLAG_DA_ALLOC_CLOSE	0x00000008
+
+/*
+ * Flags for ioctl EXT4_IOC_CHECKPOINT
+ */
+#define EXT4_IOC_CHECKPOINT_FLAG_DISCARD	0x1
+#define EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT	0x2
+#define EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN	0x4
+#define EXT4_IOC_CHECKPOINT_FLAG_VALID		(EXT4_IOC_CHECKPOINT_FLAG_DISCARD | \
+						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
+						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
+
+/*
+ * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
+ */
+struct fsuuid {
+	__u32       fsu_len;
+	__u32       fsu_flags;
+	__u8        fsu_uuid[];
+};
+
+/*
+ * Structure for EXT4_IOC_MOVE_EXT
+ */
+struct move_extent {
+	__u32 reserved;		/* should be zero */
+	__u32 donor_fd;		/* donor file descriptor */
+	__u64 orig_start;	/* logical start offset in block for orig */
+	__u64 donor_start;	/* logical start offset in block for donor */
+	__u64 len;		/* block length to be moved */
+	__u64 moved_len;	/* moved block length */
+};
+
+/*
+ * Flags used by EXT4_IOC_SHUTDOWN
+ */
+#define EXT4_GOING_FLAGS_DEFAULT		0x0	/* going down */
+#define EXT4_GOING_FLAGS_LOGFLUSH		0x1	/* flush log but not data */
+#define EXT4_GOING_FLAGS_NOLOGFLUSH		0x2	/* don't flush log nor data */
+
+/* Used to pass group descriptor data when online resize is done */
+struct ext4_new_group_input {
+	__u32 group;		/* Group number for this data */
+	__u64 block_bitmap;	/* Absolute block number of block bitmap */
+	__u64 inode_bitmap;	/* Absolute block number of inode bitmap */
+	__u64 inode_table;	/* Absolute block number of inode table start */
+	__u32 blocks_count;	/* Total number of blocks in this group */
+	__u16 reserved_blocks;	/* Number of reserved blocks in this group */
+	__u16 unused;
+};
+
+struct compat_ext4_new_group_input {
+	__u32 group;
+	compat_u64 block_bitmap;
+	compat_u64 inode_bitmap;
+	compat_u64 inode_table;
+	__u32 blocks_count;
+	__u16 reserved_blocks;
+	__u16 unused;
+};
+
+/*
+ * Returned by EXT4_IOC_GET_ES_CACHE as an additional possible flag.
+ * It indicates that the entry in extent status cache is for a hole.
+ */
+#define EXT4_FIEMAP_EXTENT_HOLE		0x08000000
+
+#endif /* _UAPI_LINUX_EXT4_H */
-- 
2.40.0

