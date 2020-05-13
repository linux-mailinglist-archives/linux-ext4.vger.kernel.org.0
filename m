Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6051D0698
	for <lists+linux-ext4@lfdr.de>; Wed, 13 May 2020 07:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgEMFnb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 May 2020 01:43:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:41741 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728995AbgEMFna (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 13 May 2020 01:43:30 -0400
IronPort-SDR: Rw+znrtGboFc4WDrDgAVJWzPzd/joAzJhSZVill7BQovLkcel19fNr+YCj5zu2rizttQnpQ9ra
 Lc6RHgkzWPiQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:29 -0700
IronPort-SDR: 5wqj0BBx2nEZC4PK11xvD2t9L0FVPR8XQ3DBJJHdyjnVnMIsUSsmMZQtsT/jgGm87ZC1/mU94T
 2Mbq8aM0AMIQ==
X-IronPort-AV: E=Sophos;i="5.73,386,1583222400"; 
   d="scan'208";a="306688131"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:29 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] fs/ext4: Disallow encryption if inode is DAX
Date:   Tue, 12 May 2020 22:43:18 -0700
Message-Id: <20200513054324.2138483-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200513054324.2138483-1-ira.weiny@intel.com>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Encryption and DAX are incompatible.  Changing the DAX mode due to a
change in Encryption mode is wrong without a corresponding
address_space_operations update.

Make the 2 options mutually exclusive by returning an error if DAX was
set first.

Furthermore, clarify the documentation of the exclusivity and how that
will work.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
	remove WARN_ON_ONCE
	Add documentation to the encrypt doc WRT DAX
---
 Documentation/filesystems/fscrypt.rst |  4 +++-
 fs/ext4/super.c                       | 10 +---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index aa072112cfff..1475b8d52fef 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1038,7 +1038,9 @@ astute users may notice some differences in behavior:
 - The ext4 filesystem does not support data journaling with encrypted
   regular files.  It will fall back to ordered data mode instead.
 
-- DAX (Direct Access) is not supported on encrypted files.
+- DAX (Direct Access) is not supported on encrypted files.  Attempts to enable
+  DAX on an encrypted file will fail.  Mount options will _not_ enable DAX on
+  encrypted files.
 
 - The st_size of an encrypted symlink will not necessarily give the
   length of the symlink target as required by POSIX.  It will actually
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bf5fcb477f66..9873ab27e3fa 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1320,7 +1320,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	if (inode->i_ino == EXT4_ROOT_INO)
 		return -EPERM;
 
-	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
+	if (IS_DAX(inode))
 		return -EINVAL;
 
 	res = ext4_convert_inline_data(inode);
@@ -1344,10 +1344,6 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
 			ext4_clear_inode_state(inode,
 					EXT4_STATE_MAY_INLINE_DATA);
-			/*
-			 * Update inode->i_flags - S_ENCRYPTED will be enabled,
-			 * S_DAX may be disabled
-			 */
 			ext4_set_inode_flags(inode);
 		}
 		return res;
@@ -1371,10 +1367,6 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 				    ctx, len, 0);
 	if (!res) {
 		ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
-		/*
-		 * Update inode->i_flags - S_ENCRYPTED will be enabled,
-		 * S_DAX may be disabled
-		 */
 		ext4_set_inode_flags(inode);
 		res = ext4_mark_inode_dirty(handle, inode);
 		if (res)
-- 
2.25.1

