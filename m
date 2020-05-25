Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865811E14E4
	for <lists+linux-ext4@lfdr.de>; Mon, 25 May 2020 21:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbgEYTjq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 May 2020 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388705AbgEYTjq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 May 2020 15:39:46 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3138C061A0E;
        Mon, 25 May 2020 12:39:45 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:55633)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <janneke@gnu.org>)
        id 1jdIwo-0007Ly-Mh; Mon, 25 May 2020 15:39:42 -0400
Received: from [2001:980:1b4f:1:42d2:832d:bb59:862] (port=35888 helo=dundal.fritz.box)
        by fencepost.gnu.org with esmtpa (Exim 4.82)
        (envelope-from <janneke@gnu.org>)
        id 1jdIwo-0006mb-4U; Mon, 25 May 2020 15:39:42 -0400
From:   "Jan (janneke) Nieuwenhuizen" <janneke@gnu.org>
To:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Danny Milosavljevic <dannym@scratchpost.org>,
        Samuel Thibault <samuel.thibault@gnu.org>
Subject: [PATCH v2] ext4: support xattr gnu.* namespace for the Hurd
Date:   Mon, 25 May 2020 21:39:40 +0200
Message-Id: <20200525193940.878-1-janneke@gnu.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The Hurd gained[0] support for moving the translator and author
fields out of the inode and into the "gnu.*" xattr namespace.

In anticipation of that, an xattr INDEX was reserved[1].  The Hurd has
now been brought into compliance[2] with that.

This patch adds support for reading and writing such attributes from
Linux; you can now do something like

    mkdir -p hurd-root/servers/socket
    touch hurd-root/servers/socket/1
    setfattr --name=gnu.translator --value='"/hurd/pflocal\0"' \
        hurd-root/servers/socket/1
    getfattr --name=gnu.translator hurd-root/servers/socket/1
    # file: 1
    gnu.translator="/hurd/pflocal"

to setup a pipe translator, which is being used to create[3] a
vm-image for the Hurd from GNU Guix.

[0] https://summerofcode.withgoogle.com/projects/#5869799859027968
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3980bd3b406addb327d858aebd19e229ea340b9a
[2] https://git.savannah.gnu.org/cgit/hurd/hurd.git/commit/?id=a04c7bf83172faa7cb080fbe3b6c04a8415ca645
[3] https://git.savannah.gnu.org/cgit/guix.git/log/?h=wip-hurd-vm
---
 fs/ext4/Makefile           |  3 ++-
 fs/ext4/xattr.c            |  2 ++
 fs/ext4/xattr.h            |  1 +
 fs/ext4/xattr_hurd.c       | 51 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/xattr.h |  4 +++
 5 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 fs/ext4/xattr_hurd.c

diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 4ccb3c9189d8..2e42f47a7f98 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -9,7 +9,8 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
 		extents_status.o file.o fsmap.o fsync.o hash.o ialloc.o \
 		indirect.o inline.o inode.o ioctl.o mballoc.o migrate.o \
 		mmp.o move_extent.o namei.o page-io.o readpage.o resize.o \
-		super.o symlink.o sysfs.o xattr.o xattr_trusted.o xattr_user.o
+		super.o symlink.o sysfs.o xattr.o xattr_hurd.o xattr_trusted.o \
+		xattr_user.o
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 9b29a40738ac..7d2f6576d954 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -93,6 +93,7 @@ static const struct xattr_handler * const ext4_xattr_handler_map[] = {
 #ifdef CONFIG_EXT4_FS_SECURITY
 	[EXT4_XATTR_INDEX_SECURITY]	     = &ext4_xattr_security_handler,
 #endif
+	[EXT4_XATTR_INDEX_HURD]		     = &ext4_xattr_hurd_handler,
 };
 
 const struct xattr_handler *ext4_xattr_handlers[] = {
@@ -105,6 +106,7 @@ const struct xattr_handler *ext4_xattr_handlers[] = {
 #ifdef CONFIG_EXT4_FS_SECURITY
 	&ext4_xattr_security_handler,
 #endif
+	&ext4_xattr_hurd_handler,
 	NULL
 };
 
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index ffe21ac77f78..730b91fa0dd7 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -124,6 +124,7 @@ struct ext4_xattr_inode_array {
 extern const struct xattr_handler ext4_xattr_user_handler;
 extern const struct xattr_handler ext4_xattr_trusted_handler;
 extern const struct xattr_handler ext4_xattr_security_handler;
+extern const struct xattr_handler ext4_xattr_hurd_handler;
 
 #define EXT4_XATTR_NAME_ENCRYPTION_CONTEXT "c"
 
diff --git a/fs/ext4/xattr_hurd.c b/fs/ext4/xattr_hurd.c
new file mode 100644
index 000000000000..8cfa74a56361
--- /dev/null
+++ b/fs/ext4/xattr_hurd.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/fs/ext4/xattr_hurd.c
+ * Handler for extended gnu attributes for the Hurd.
+ *
+ * Copyright (C) 2001 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ * Copyright (C) 2020 by Jan (janneke) Nieuwenhuizen, <janneke@gnu.org>
+ */
+
+#include <linux/init.h>
+#include <linux/string.h>
+#include "ext4.h"
+#include "xattr.h"
+
+static bool
+ext4_xattr_hurd_list(struct dentry *dentry)
+{
+	return test_opt(dentry->d_sb, XATTR_USER);
+}
+
+static int
+ext4_xattr_hurd_get(const struct xattr_handler *handler,
+		    struct dentry *unused, struct inode *inode,
+		    const char *name, void *buffer, size_t size)
+{
+	if (!test_opt(inode->i_sb, XATTR_USER))
+		return -EOPNOTSUPP;
+
+	return ext4_xattr_get(inode, EXT4_XATTR_INDEX_HURD,
+			      name, buffer, size);
+}
+
+static int
+ext4_xattr_hurd_set(const struct xattr_handler *handler,
+		    struct dentry *unused, struct inode *inode,
+		    const char *name, const void *value,
+		    size_t size, int flags)
+{
+	if (!test_opt(inode->i_sb, XATTR_USER))
+		return -EOPNOTSUPP;
+
+	return ext4_xattr_set(inode, EXT4_XATTR_INDEX_HURD,
+			      name, value, size, flags);
+}
+
+const struct xattr_handler ext4_xattr_hurd_handler = {
+	.prefix	= XATTR_HURD_PREFIX,
+	.list	= ext4_xattr_hurd_list,
+	.get	= ext4_xattr_hurd_get,
+	.set	= ext4_xattr_hurd_set,
+};
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index c1395b5bd432..9463db2dfa9d 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -7,6 +7,7 @@
   Copyright (C) 2001 by Andreas Gruenbacher <a.gruenbacher@computer.org>
   Copyright (c) 2001-2002 Silicon Graphics, Inc.  All Rights Reserved.
   Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+  Copyright (c) 2020 Jan (janneke) Nieuwenhuizen <janneke@gnu.org>
 */
 
 #include <linux/libc-compat.h>
@@ -31,6 +32,9 @@
 #define XATTR_BTRFS_PREFIX "btrfs."
 #define XATTR_BTRFS_PREFIX_LEN (sizeof(XATTR_BTRFS_PREFIX) - 1)
 
+#define XATTR_HURD_PREFIX "gnu."
+#define XATTR_HURD_PREFIX_LEN (sizeof(XATTR_HURD_PREFIX) - 1)
+
 #define XATTR_SECURITY_PREFIX	"security."
 #define XATTR_SECURITY_PREFIX_LEN (sizeof(XATTR_SECURITY_PREFIX) - 1)
 
-- 
2.26.2

