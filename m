Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6D9931A
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 14:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfHVMR2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 08:17:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfHVMR2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Aug 2019 08:17:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE68B11A08
        for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2019 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E76E7E23
        for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2019 12:17:27 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 2/2] tune2fs: Warn if page size != blocksize when enabling encrypt
Date:   Thu, 22 Aug 2019 14:17:25 +0200
Message-Id: <20190822121725.22550-1-lczerner@redhat.com>
In-Reply-To: <20190821131813.9456-2-lczerner@redhat.com>
References: <20190821131813.9456-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 22 Aug 2019 12:17:27 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With encrypt feature enabled the file system block size must match
system page size. Currently tune2fs will not complain at all when we try
to enable encrypt on a file system that does not satisfy this
requirement for the system. Add a warning for this case.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 misc/tune2fs.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 7d2d38d7..f1604447 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -130,6 +130,8 @@ void do_findfs(int argc, char **argv);
 int journal_enable_debug = -1;
 #endif
 
+static int sys_page_size = 4096;
+
 static void usage(void)
 {
 	fprintf(stderr,
@@ -1407,6 +1409,30 @@ mmp_error:
 			      stderr);
 			return 1;
 		}
+
+		/*
+		 * When encrypt feature is enabled, the file system blocksize
+		 * needs to match system page size otherwise the file system
+		 * won't mount.
+		 */
+		if (fs->blocksize != sys_page_size) {
+			if (!f_flag) {
+				com_err(program_name, 0,
+					_("Encryption feature requested, but "
+					  "block size (%dB) does not match "
+					  "system page size (%dB). File "
+					  "system won't be usable on this "
+					  "system"),
+					fs->blocksize, sys_page_size);
+				proceed_question(-1);
+			}
+			fprintf(stderr,_("Warning: Encrypt feature enabled, "
+					 "but block size (%dB) does not match "
+					 "system page size (%dB), forced to "
+					 "cointinue\n"),
+				fs->blocksize, sys_page_size);
+		}
+
 		fs->super->s_encrypt_algos[0] =
 			EXT4_ENCRYPTION_MODE_AES_256_XTS;
 		fs->super->s_encrypt_algos[1] =
@@ -2844,6 +2870,7 @@ int main(int argc, char **argv)
 int tune2fs_main(int argc, char **argv)
 #endif  /* BUILD_AS_LIB */
 {
+	long sysval;
 	errcode_t retval;
 	ext2_filsys fs;
 	struct ext2_super_block *sb;
@@ -2879,6 +2906,18 @@ int tune2fs_main(int argc, char **argv)
 #endif
 		io_ptr = unix_io_manager;
 
+	/* Determine the system page size if possible */
+#ifdef HAVE_SYSCONF
+#if (!defined(_SC_PAGESIZE) && defined(_SC_PAGE_SIZE))
+#define _SC_PAGESIZE _SC_PAGE_SIZE
+#endif
+#ifdef _SC_PAGESIZE
+	sysval = sysconf(_SC_PAGESIZE);
+	if (sysval > 0)
+		sys_page_size = sysval;
+#endif /* _SC_PAGESIZE */
+#endif /* HAVE_SYSCONF */
+
 retry_open:
 	if ((open_flag & EXT2_FLAG_RW) == 0 || f_flag)
 		open_flag |= EXT2_FLAG_SKIP_MMP;
-- 
2.21.0

