Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1626D3548
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Apr 2023 04:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDBChz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Apr 2023 22:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBChy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Apr 2023 22:37:54 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E15F0;
        Sat,  1 Apr 2023 19:37:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 53CBF320094C;
        Sat,  1 Apr 2023 22:37:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 01 Apr 2023 22:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680403067; x=1680489467; bh=Ma
        XWLS/nhQZwaTMtsdXoJ6M+0qaPQNoA1bM1WRsxPcw=; b=SGKTsorRgoBlgCt4YJ
        jNmtcNI+DTyOBB8iU69uG+YJLOKGlrxbmo8by4Rv0Is3ylgpBqxF2h02WBC+ezQ7
        VpyE+NRLGp+nd3n8ZoYcSmPoipMywYdmX8jk7iqLE8Yyb8RjzFJkfHR1XaUi7GRh
        iC0alJvhaDCXP1u1wVhd3j+8X8k+uEaYqUxZrT/p+elHsOuMV8jnjigLaE2kWoL4
        o9HLzImHSB5iIc1myqqLpz1WsvIEl/UqN8Q0BUxkWDeVUJABvVRxdP9p8vwty1q9
        8OIqywmtvd1tphpsveAfxBEMbtfs7l0z5SKMN6keN5KlyHfaUPm0Qcqo5+9QWVVs
        7A7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680403067; x=1680489467; bh=MaXWLS/nhQZwaTMtsdXoJ6M+0qaPQNoA1bM
        1WRsxPcw=; b=JJLQnB97qKJQ9B7B89YD0v+5VXQVXSoS34JhTRZiHHOq8xaugZn
        kx0TuCqeeLxA5fnTN9/Vbn2nglNWQAeh5fHxbFf4L0Bjb8w68whW/9jOnrCyWlAA
        sk8sQ4FL48y6TlAojfzsBOjdNnowJLiHZMnFUR5tqU+GIfxhtqx0+Kcy6QldW+3b
        BJR8sp3eQ1omCU2e4uoyrTf+MF9irxPzsTxmZXPEhbsTYiQncKrrLnypw1m1sYI7
        1bvcVAL400/7o9KXShNylrNA1Wg6eBdbXIovnDDTPQfR6jiZD9eHXCLe3cjt8GMH
        QxwexGVlZ8UG7aWp+/Hy7W5cTTFW8DnVdWg==
X-ME-Sender: <xms:e-ooZFHUV-ZUD4PIbl9sRqb54aGsuCxSZeS9X2DywN6pG9qSYYV8Kw>
    <xme:e-ooZKVIyDw2Zz4MtnT6KuqlM_pWdT4I3-SE8tsSwgqHRUdvTf6ouECynWlEw6EKq
    2W4RkKtF9AyEY4WbiQ>
X-ME-Received: <xmr:e-ooZHKEB9grLU0AA5DjNIhX0OBg99Uyu6aD7u7ZyZLsjUQgn4Gqxlmo3cI0hXmK8T-X-vZgQxVxYh5XB717ZTZyn1GbD1xEdfznr0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeigedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhr
    ihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeelteekheejvdfffedvjeduke
    evtefhffdugeffveffgeffkeekteefudeuteehveenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:e-ooZLE8LfbNhR0MCcDcJ9pMB1_UAV687K8UUK22RZPLAuEWBWSGgQ>
    <xmx:e-ooZLWhOSOnRv1R_QTonkrawrnQm5odcTvhGpmLBXRD8L2IEFhBig>
    <xmx:e-ooZGMUlVAa0V6wuc-3ei3-x9yp5jlLPdBM43vodAW0lr6eXE75sA>
    <xmx:e-ooZIhQ0dwLUu8d81KFtfW2JCX-3ZG_AtVENIT6FrI37ktQ7ynH8Q>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Apr 2023 22:37:45 -0400 (EDT)
Date:   Sun, 2 Apr 2023 11:37:42 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3] ext4: Add a uapi header for ext4 userspace APIs
Message-ID: <680175260970d977d16b5cc7e7606483ec99eb63.1680402881.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Sorry for the churn; I didn't encounter these errors in local
test builds.

v2:
- Add UAPI header to MAINTAINERS
- Fix include paths in UAPI header
- Formatting fix for EXT4_IOC_SHUTDOWN

v3:
- Leave compat ioctls in the private ext4.h header. It appears that some other
  UAPI headers already follow this pattern, with compat defined privately. For
  instance, quota and ethtool both follow that pattern.

 MAINTAINERS               |   1 +
 fs/ext4/ext4.h            |  91 +----------------------------
 include/uapi/linux/ext4.h | 117 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 90 deletions(-)
 create mode 100644 include/uapi/linux/ext4.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1dc8bd26b6cf..7d1e56a88f2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7728,6 +7728,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 F:	Documentation/filesystems/ext4/
 F:	fs/ext4/
 F:	include/trace/events/ext4.h
+F:	include/uapi/linux/ext4.h
 
 Extended Verification Module (EVM)
 M:	Mimi Zohar <zohar@linux.ibm.com>
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08b29c289da4..a395030cd0c8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -40,6 +40,7 @@
 #ifdef __KERNEL__
 #include <linux/compat.h>
 #endif
+#include <uapi/linux/ext4.h>
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
@@ -591,17 +592,6 @@ static inline void ext4_check_flag_values(void)
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
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 struct compat_ext4_new_group_input {
 	u32 group;
@@ -698,70 +688,6 @@ enum {
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
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
  * ioctl commands in 32 bit emulation
@@ -776,12 +702,6 @@ struct fsuuid {
 #define EXT4_IOC32_SETVERSION_OLD	FS_IOC32_SETVERSION
 #endif
 
-/*
- * Returned by EXT4_IOC_GET_ES_CACHE as an additional possible flag.
- * It indicates that the entry in extent status cache is for a hole.
- */
-#define EXT4_FIEMAP_EXTENT_HOLE		0x08000000
-
 /* Max physical block we can address w/o extents */
 #define EXT4_MAX_BLOCK_FILE_PHYS	0xFFFFFFFF
 
@@ -852,15 +772,6 @@ struct ext4_inode {
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
index 000000000000..1c4c2dd29112
--- /dev/null
+++ b/include/uapi/linux/ext4.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_EXT4_H
+#define _UAPI_LINUX_EXT4_H
+#include <linux/fiemap.h>
+#include <linux/fs.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
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
+#define EXT4_IOC_SHUTDOWN _IOR('X', 125, __u32)
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
+/*
+ * Returned by EXT4_IOC_GET_ES_CACHE as an additional possible flag.
+ * It indicates that the entry in extent status cache is for a hole.
+ */
+#define EXT4_FIEMAP_EXTENT_HOLE		0x08000000
+
+#endif /* _UAPI_LINUX_EXT4_H */
-- 
2.40.0

