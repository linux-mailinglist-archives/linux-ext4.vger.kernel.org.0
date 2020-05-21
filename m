Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D021DD6E4
	for <lists+linux-ext4@lfdr.de>; Thu, 21 May 2020 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgEUTNh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 May 2020 15:13:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:22666 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbgEUTNg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 21 May 2020 15:13:36 -0400
IronPort-SDR: N2FYv9Cy4/a7vmOx9Lz7P347uaL4RvCdQEGfUekykXDxcQyL9eBFOJygFLIIXkqEpplOaJopzo
 wGj0NyP2eRUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 12:13:20 -0700
IronPort-SDR: 2m/i3Bx4LkWEFmNFD2t5c07S3dGr2tovkvZdwFW8gvxa5rIjYqg33Mhd4e/4+ru7fkyoFGEB0B
 PXbdWFAajozw==
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="254079981"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 12:13:20 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 7/8] fs/ext4: Introduce DAX inode flag
Date:   Thu, 21 May 2020 12:13:12 -0700
Message-Id: <20200521191313.261929-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521191313.261929-1-ira.weiny@intel.com>
References: <20200521191313.261929-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.

Set the flag to be user visible and changeable.  Set the flag to be
inherited.  Allow applications to change the flag at any time with the
exception of if VERITY or ENCRYPT is set.

Disallow setting VERITY or ENCRYPT if DAX is set.

Finally, on regular files, flag the inode to not be cached to facilitate
changing S_DAX on the next creation of the inode.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V3:
	Move bit to bit25 per Andreas

Change from V2:
	Add in making verity and DAX exclusive.
	'Squash' in making encryption and DAX exclusive.
	Add in EXT4_INODE_DAX flag definition to be compatible with
		ext4_[set|test]_inode_flag() bit operations
	Use ext4_[set|test]_inode_flag() bit operations to be consistent
		with other code.

Change from V0:
	Add FS_DAX_FL to include/uapi/linux/fs.h
		to be consistent
	Move ext4_dax_dontcache() to ext4_ioctl_setflags()
		This ensures that it is only set when the flags are going to be
		set and not if there is an error
		Also this sets don't cache in the FS_IOC_SETFLAGS case

Change from RFC:
	use new d_mark_dontcache()
	Allow caching if ALWAYS/NEVER is set
	Rebased to latest Linus master
	Change flag to unused 0x01000000
	update ext4_should_enable_dax()
---
 fs/ext4/ext4.h          | 14 ++++++++++----
 fs/ext4/inode.c         |  2 +-
 fs/ext4/ioctl.c         | 34 +++++++++++++++++++++++++++++++++-
 fs/ext4/super.c         |  3 +++
 fs/ext4/verity.c        |  2 +-
 include/uapi/linux/fs.h |  1 +
 6 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 65ffb831b2b9..09b8906568d2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -415,13 +415,16 @@ struct flex_groups {
 #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
 #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
 /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
+
+#define EXT4_DAX_FL			0x02000000 /* Inode is DAX */
+
 #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
 #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
 
-#define EXT4_FL_USER_VISIBLE		0x705BDFFF /* User visible flags */
-#define EXT4_FL_USER_MODIFIABLE		0x604BC0FF /* User modifiable flags */
+#define EXT4_FL_USER_VISIBLE		0x725BDFFF /* User visible flags */
+#define EXT4_FL_USER_MODIFIABLE		0x624BC0FF /* User modifiable flags */
 
 /* Flags we can manipulate with through EXT4_IOC_FSSETXATTR */
 #define EXT4_FL_XFLAG_VISIBLE		(EXT4_SYNC_FL | \
@@ -429,14 +432,16 @@ struct flex_groups {
 					 EXT4_APPEND_FL | \
 					 EXT4_NODUMP_FL | \
 					 EXT4_NOATIME_FL | \
-					 EXT4_PROJINHERIT_FL)
+					 EXT4_PROJINHERIT_FL | \
+					 EXT4_DAX_FL)
 
 /* Flags that should be inherited by new inodes from their parent. */
 #define EXT4_FL_INHERITED (EXT4_SECRM_FL | EXT4_UNRM_FL | EXT4_COMPR_FL |\
 			   EXT4_SYNC_FL | EXT4_NODUMP_FL | EXT4_NOATIME_FL |\
 			   EXT4_NOCOMPR_FL | EXT4_JOURNAL_DATA_FL |\
 			   EXT4_NOTAIL_FL | EXT4_DIRSYNC_FL |\
-			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL)
+			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL |\
+			   EXT4_DAX_FL)
 
 /* Flags that are appropriate for regular files (all but dir-specific ones). */
 #define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL |\
@@ -488,6 +493,7 @@ enum {
 	EXT4_INODE_VERITY	= 20,	/* Verity protected inode */
 	EXT4_INODE_EA_INODE	= 21,	/* Inode used for large EA */
 /* 22 was formerly EXT4_INODE_EOFBLOCKS */
+	EXT4_INODE_DAX		= 25,	/* Inode is DAX */
 	EXT4_INODE_INLINE_DATA	= 28,	/* Data in inode. */
 	EXT4_INODE_PROJINHERIT	= 29,	/* Create with parents projid */
 	EXT4_INODE_RESERVED	= 31,	/* reserved for ext4 lib */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 68fac9289109..778b0dbe3da6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4419,7 +4419,7 @@ static bool ext4_should_enable_dax(struct inode *inode)
 	if (test_opt(inode->i_sb, DAX_ALWAYS))
 		return true;
 
-	return false;
+	return ext4_test_inode_flag(inode, EXT4_INODE_DAX);
 }
 
 void ext4_set_inode_flags(struct inode *inode, bool init)
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 145083e8cd1e..668b8c17d6eb 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -292,6 +292,21 @@ static int ext4_ioctl_check_immutable(struct inode *inode, __u32 new_projid,
 	return 0;
 }
 
+static void ext4_dax_dontcache(struct inode *inode, unsigned int flags)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	if (S_ISDIR(inode->i_mode))
+		return;
+
+	if (test_opt2(inode->i_sb, DAX_NEVER) ||
+	    test_opt(inode->i_sb, DAX_ALWAYS))
+		return;
+
+	if ((ei->i_flags ^ flags) & EXT4_DAX_FL)
+		d_mark_dontcache(inode);
+}
+
 static int ext4_ioctl_setflags(struct inode *inode,
 			       unsigned int flags)
 {
@@ -303,6 +318,16 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	unsigned int jflag;
 	struct super_block *sb = inode->i_sb;
 
+	if (ext4_test_inode_flag(inode, EXT4_INODE_DAX)) {
+		if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY) ||
+		    ext4_test_inode_flag(inode, EXT4_INODE_ENCRYPT) ||
+		    ext4_test_inode_state(inode,
+					  EXT4_STATE_VERITY_IN_PROGRESS)) {
+			err = -EOPNOTSUPP;
+			goto flags_out;
+		}
+	}
+
 	/* Is it quota file? Do not allow user to mess with it */
 	if (ext4_is_quota_file(inode))
 		goto flags_out;
@@ -369,6 +394,8 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	if (err)
 		goto flags_err;
 
+	ext4_dax_dontcache(inode, flags);
+
 	for (i = 0, mask = 1; i < 32; i++, mask <<= 1) {
 		if (!(mask & EXT4_FL_USER_MODIFIABLE))
 			continue;
@@ -528,12 +555,15 @@ static inline __u32 ext4_iflags_to_xflags(unsigned long iflags)
 		xflags |= FS_XFLAG_NOATIME;
 	if (iflags & EXT4_PROJINHERIT_FL)
 		xflags |= FS_XFLAG_PROJINHERIT;
+	if (iflags & EXT4_DAX_FL)
+		xflags |= FS_XFLAG_DAX;
 	return xflags;
 }
 
 #define EXT4_SUPPORTED_FS_XFLAGS (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | \
 				  FS_XFLAG_APPEND | FS_XFLAG_NODUMP | \
-				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT)
+				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT | \
+				  FS_XFLAG_DAX)
 
 /* Transfer xflags flags to internal */
 static inline unsigned long ext4_xflags_to_iflags(__u32 xflags)
@@ -552,6 +582,8 @@ static inline unsigned long ext4_xflags_to_iflags(__u32 xflags)
 		iflags |= EXT4_NOATIME_FL;
 	if (xflags & FS_XFLAG_PROJINHERIT)
 		iflags |= EXT4_PROJINHERIT_FL;
+	if (xflags & FS_XFLAG_DAX)
+		iflags |= EXT4_DAX_FL;
 
 	return iflags;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5e056aa20ce9..3658e3016999 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1323,6 +1323,9 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
 		return -EINVAL;
 
+	if (ext4_test_inode_flag(inode, EXT4_INODE_DAX))
+		return -EOPNOTSUPP;
+
 	res = ext4_convert_inline_data(inode);
 	if (res)
 		return res;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 89a155ece323..4fecb3e4e338 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -113,7 +113,7 @@ static int ext4_begin_enable_verity(struct file *filp)
 	handle_t *handle;
 	int err;
 
-	if (IS_DAX(inode))
+	if (IS_DAX(inode) || ext4_test_inode_flag(inode, EXT4_INODE_DAX))
 		return -EINVAL;
 
 	if (ext4_verity_in_progress(inode))
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8f1d..f44eb0a04afd 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -262,6 +262,7 @@ struct fsxattr {
 #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
 #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
 #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
+#define FS_DAX_FL			0x02000000 /* Inode is DAX */
 #define FS_INLINE_DATA_FL		0x10000000 /* Reserved for ext4 */
 #define FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define FS_CASEFOLD_FL			0x40000000 /* Folder is case insensitive */
-- 
2.25.1

