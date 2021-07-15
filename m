Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7103C9663
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jul 2021 05:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhGODTe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jul 2021 23:19:34 -0400
Received: from foss.arm.com ([217.140.110.172]:46092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234354AbhGODTa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 14 Jul 2021 23:19:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B96EB11D4;
        Wed, 14 Jul 2021 20:16:37 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 26D283F7D8;
        Wed, 14 Jul 2021 20:16:34 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: [PATCH RFC 13/13] ext4: simplify the printing with '%pD' specifier
Date:   Thu, 15 Jul 2021 11:15:33 +0800
Message-Id: <20210715031533.9553-14-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After the behavior of '%pD' is changed to print the full path of file,
the log printing can be simplified.

The error case is well handled in d_path_unsafe(), the error string
would be copied in '%pD' buffer, no need to additionally handle IS_ERR().

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/ext4/super.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..89ad5a334b80 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -803,31 +803,27 @@ void __ext4_error_file(struct file *file, const char *function,
 	va_list args;
 	struct va_format vaf;
 	struct inode *inode = file_inode(file);
-	char pathname[80], *path;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
 	if (ext4_error_ratelimit(inode->i_sb)) {
-		path = file_path(file, pathname, sizeof(pathname));
-		if (IS_ERR(path))
-			path = "(unknown)";
 		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
 		if (block)
 			printk(KERN_CRIT
 			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
-			       "block %llu: comm %s: path %s: %pV\n",
+			       "block %llu: comm %s: path %pD: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
-			       block, current->comm, path, &vaf);
+			       block, current->comm, file, &vaf);
 		else
 			printk(KERN_CRIT
 			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
-			       "comm %s: path %s: %pV\n",
+			       "comm %s: path %pD: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
-			       current->comm, path, &vaf);
+			       current->comm, file, &vaf);
 		va_end(args);
 	}
 	ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
-- 
2.17.1

