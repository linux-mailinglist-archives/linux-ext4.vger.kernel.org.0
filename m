Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46586157EB9
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2020 16:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBJPZP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Feb 2020 10:25:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28980 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727431AbgBJPZP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 Feb 2020 10:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581348313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7BRCoUtNDZP6mqMg8zWqKyppzqYv+YEg9ROsmVEnJ8=;
        b=Zk25jnaIe1WNCF748dHIA8da92Y3s7VXJQx2i1LNBasapFBhSDEuNBauBy+eS8AypONDzn
        iehm/BJdseRoMU2IktPuUr7exv1nm3k5RwwKeXA2OwN8EfZrTf0UPBR9GleVIWF7x8QDMC
        slYcPYO1h5EMWcFDpb+9IYNSdXRsOrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-EAHJT_fuPZKJBXCVTNGB_g-1; Mon, 10 Feb 2020 10:25:05 -0500
X-MC-Unique: EAHJT_fuPZKJBXCVTNGB_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50DC6800D48;
        Mon, 10 Feb 2020 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-205-236.brq.redhat.com [10.40.205.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE61B82063;
        Mon, 10 Feb 2020 15:25:00 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, sandeen@redhat.com
Subject: [PATCH v2] tst_libext2fs: Avoid multiple definition of global variables
Date:   Mon, 10 Feb 2020 16:24:59 +0100
Message-Id: <20200210152459.19903-1-lczerner@redhat.com>
In-Reply-To: <20200130132122.21150-1-lczerner@redhat.com>
References: <20200130132122.21150-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

gcc version 10 changed the default from -fcommon to -fno-common and as a
result e2fsprogs make check tests fail because tst_libext2fs.c end up
with a build error.

This is because it defines two global variables debug_prog_name and
extra_cmds that are already defined in debugfs/debugfs.c. With -fcommon
linker was able to resolve those into the same object, however with
-fno-common it's no longer able to do it and we end up with multiple
definition errors.

Fix the problem by using SKIP_GLOBDEFS macro to skip the variables
definition in debugfs.c. Note that debug_prog_name is also defined in
lib/ext2fs/extent.c when DEBUG macro is used, but this does not work even
with older gcc versions and is never used regardless so I am not going to
bother with it.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
v2: Previous fix wasn't really working properly

 debugfs/debugfs.c      | 6 ++++++
 debugfs/debugfs.h      | 2 ++
 lib/ext2fs/Makefile.in | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 9b701455..5e8f8bdd 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -48,8 +48,14 @@ extern char *optarg;
 int journal_enable_debug =3D -1;
 #endif
=20
+/*
+ * There must be only one definition if we're hooking in extra commands =
or
+ * chaging default prompt. Use -DSKIP_GLOBDEF for that.
+ */
+#ifndef SKIP_GLOBDEFS
 ss_request_table *extra_cmds;
 const char *debug_prog_name;
+#endif
 int ss_sci_idx;
=20
 ext2_filsys	current_fs;
diff --git a/debugfs/debugfs.h b/debugfs/debugfs.h
index 477d9bbb..956517bc 100644
--- a/debugfs/debugfs.h
+++ b/debugfs/debugfs.h
@@ -123,6 +123,8 @@ extern void do_set_block_group_descriptor(int argc, c=
har **, int sci_idx, void *
 extern void do_dump_unused(int argc, char **argv, int sci_idx, void *inf=
op);
=20
 /* debugfs.c */
+extern ss_request_table *extra_cmds;
+extern const char *debug_prog_name;
 extern void internal_dump_inode(FILE *, const char *, ext2_ino_t,
 				struct ext2_inode *, int);
=20
diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index c2163bf5..f754b952 100644
--- a/lib/ext2fs/Makefile.in
+++ b/lib/ext2fs/Makefile.in
@@ -377,7 +377,7 @@ extent_cmds.c extent_cmds.h: $(top_srcdir)/debugfs/ex=
tent_cmds.ct
=20
 debugfs.o: $(top_srcdir)/debugfs/debugfs.c
 	$(E) "	CC $<"
-	$(Q) $(CC) $(DEBUGFS_CFLAGS) -c $< -o $@
+	$(Q) $(CC) $(DEBUGFS_CFLAGS) -DSKIP_GLOBDEFS -c $< -o $@
=20
 extent_inode.o: $(top_srcdir)/debugfs/extent_inode.c
 	$(E) "	CC $<"
--=20
2.21.1

