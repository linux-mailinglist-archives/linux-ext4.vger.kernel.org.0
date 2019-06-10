Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A798D3AD33
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2019 04:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfFJCtY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Jun 2019 22:49:24 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58078 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726566AbfFJCtY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Jun 2019 22:49:24 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5A2nFPr019224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 9 Jun 2019 22:49:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3D7EB420481; Sun,  9 Jun 2019 22:49:15 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: enforce the immutable flag on open files
Date:   Sun,  9 Jun 2019 22:49:01 -0400
Message-Id: <20190610024901.10714-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

According to the chattr man page, "a file with the 'i' attribute
cannot be modified..."  Historically, this was only enforced when the
file was opened, per the rest of the description, "... and the file
can not be opened in write mode".

There is general agreement that we should standardize all file systems
to prevent modifications even for files that were opened at the time
the immutable flag is set.  Eventually, a change to enforce this at
the VFS layer should be landing in mainline.  Until then, enforce this
at the ext4 level to prevent xfstests generic/533 and generic/534 from
failing.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: stable@kernel.org
---
 fs/ext4/file.c  |  4 ++++
 fs/ext4/inode.c | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2c5baa5e8291..f4a24a46245e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -165,6 +165,10 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	ret = generic_write_checks(iocb, from);
 	if (ret <= 0)
 		return ret;
+
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return -EPERM;
+
 	/*
 	 * If we have encountered a bitmap-format file, the size limit
 	 * is smaller than s_maxbytes, which is for extent-mapped files.
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c16071547c9c..ed1d8f9ce5f9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5520,6 +5520,14 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return -EPERM;
+
+	if (unlikely(IS_APPEND(inode) &&
+		     (ia_valid & (ATTR_MODE | ATTR_UID |
+				  ATTR_GID | ATTR_TIMES_SET))))
+		return -EPERM;
+
 	error = setattr_prepare(dentry, attr);
 	if (error)
 		return error;
@@ -6194,6 +6202,9 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	get_block_t *get_block;
 	int retries = 0;
 
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return VM_FAULT_SIGBUS;
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vma->vm_file);
 
-- 
2.22.0

