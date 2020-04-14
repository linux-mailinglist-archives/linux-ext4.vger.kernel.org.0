Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C71A721A
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 06:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDNEAw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Apr 2020 00:00:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:61620 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgDNEAt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Apr 2020 00:00:49 -0400
IronPort-SDR: XyLorU2JeoyBTcb/AQSOJDnxL6LgkYXVzgiuNkyUTgESD8N/ENFU8qdm1SjazDwa7pXo16gHvP
 JPw2OgFj6Kmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:48 -0700
IronPort-SDR: yVsi5uFMne5a2eU8Zb7MpKnoTwGjXNaPvof3XWsBiRvZNOvl4z4N+5Gps1nNIncN1rdBNAK8g4
 FNS97a95+YKw==
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="271278106"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:48 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 4/8] fs/ext4: Introduce DAX inode flag
Date:   Mon, 13 Apr 2020 21:00:26 -0700
Message-Id: <20200414040030.1802884-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414040030.1802884-1-ira.weiny@intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.

Set the flag to be user visible and changeable.  Set the flag to be
inherited.  Allow applications to change the flag at any time.

Finally, on regular files, flag the inode to not be cached to facilitate
changing S_DAX on the next creation of the inode.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext4/ext4.h  | 13 +++++++++----
 fs/ext4/ioctl.c | 21 ++++++++++++++++++++-
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 61b37a052052..434021fcec88 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -415,13 +415,16 @@ struct flex_groups {
 #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
 #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
 #define EXT4_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
+
+#define EXT4_DAX_FL			0x00800000 /* Inode is DAX */
+
 #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
 #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
 
-#define EXT4_FL_USER_VISIBLE		0x705BDFFF /* User visible flags */
-#define EXT4_FL_USER_MODIFIABLE		0x604BC0FF /* User modifiable flags */
+#define EXT4_FL_USER_VISIBLE		0x70DBDFFF /* User visible flags */
+#define EXT4_FL_USER_MODIFIABLE		0x60CBC0FF /* User modifiable flags */
 
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
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index ee3401a32e79..ca07d5086f03 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -539,12 +539,15 @@ static inline __u32 ext4_iflags_to_xflags(unsigned long iflags)
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
@@ -563,6 +566,8 @@ static inline unsigned long ext4_xflags_to_iflags(__u32 xflags)
 		iflags |= EXT4_NOATIME_FL;
 	if (xflags & FS_XFLAG_PROJINHERIT)
 		iflags |= EXT4_PROJINHERIT_FL;
+	if (xflags & FS_XFLAG_DAX)
+		iflags |= EXT4_DAX_FL;
 
 	return iflags;
 }
@@ -813,6 +818,17 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	return error;
 }
 
+static void ext4_dax_dontcache(struct inode *inode, unsigned int flags)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	if (S_ISDIR(inode->i_mode))
+		return;
+
+	if ((ei->i_flags ^ flags) == EXT4_DAX_FL)
+		inode->i_state |= I_DONTCACHE;
+}
+
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1273,6 +1289,9 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return err;
 
 		inode_lock(inode);
+
+		ext4_dax_dontcache(inode, flags);
+
 		ext4_fill_fsxattr(inode, &old_fa);
 		err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
 		if (err)
-- 
2.25.1

