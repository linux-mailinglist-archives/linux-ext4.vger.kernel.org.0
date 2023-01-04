Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFCC65CEFD
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 10:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjADJDl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 04:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjADJDJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 04:03:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515DDB1B
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 01:03:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 063F5B8133B
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 09:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B98C433EF;
        Wed,  4 Jan 2023 09:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672822985;
        bh=k1uPoNqAHdL6Rca2cRUhMBtrkHhGlNDWcNrRDqd3l1U=;
        h=From:To:Cc:Subject:Date:From;
        b=i1TeCx3BCLRrLjrcgpU8K7OA50B6s53W8EY31mwXMdX/5XkI8xebTNwzQ+mpyti/c
         qyz94SEuwSLiqIcEcejaLpwUGkm9rr63ixv3cnnULMlkkJGCr+2nCEVJViOg/geT3l
         OvWE1Vo+cN8g+u83W88AgiGOo2l7YJOL+ZD65l99ch0YLO4EoRPJvMBo91ND7d7j32
         5cG0ek8p7H8kG96OnQav0zmFVVxeZaTAkXYHN5ENMVj7nYpqS3RjdgxQ2SINHcTVQm
         vUqJJ1JhHtdDkI/bNzXIyWVZx5IEXkOATuaZuaM7/kqylDMkO6rrXCEYt8sOyhJm1a
         a7d01Q9DpmNTA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: [e2fsprogs PATCH] libext2fs: fix 32-bit Windows build
Date:   Wed,  4 Jan 2023 01:03:01 -0800
Message-Id: <20230104090301.275976-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

_WIN32 is the standard macro to detect Windows, regardless of 32-bit or
64-bit.  _WIN64 is for 64-bit Windows only.  Use _WIN32 where _WIN64 was
incorrectly being used.

This fixes several 32-bit Windows build errors, for example this one:

plausible.c: In function ‘print_ext2_info’:
plausible.c:109:31: error: ‘unix_io_manager’ undeclared (first use in this function); did you mean ‘undo_io_manager’?
  109 |                               unix_io_manager,
      |                               ^~~~~~~~~~~~~~~
      |                               undo_io_manager

Fixes: 86b6db9f5a43 ("libext2fs: code adaptation to use the Windows IO manager")
Cc: Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/getsectsize.c | 12 ++++++------
 lib/support/plausible.c  |  2 +-
 util/subst.c             |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/ext2fs/getsectsize.c b/lib/ext2fs/getsectsize.c
index 3a461eb9..bd978c53 100644
--- a/lib/ext2fs/getsectsize.c
+++ b/lib/ext2fs/getsectsize.c
@@ -51,10 +51,10 @@
  */
 errcode_t ext2fs_get_device_sectsize(const char *file, int *sectsize)
 {
-#ifdef _WIN64
+#ifdef _WIN32
 	*sectsize = 512; // just guessing
 	return 0;
-#else // not _WIN64
+#else // not _WIN32
 
 	int	fd;
 
@@ -78,7 +78,7 @@ errcode_t ext2fs_get_device_sectsize(const char *file, int *sectsize)
 	close(fd);
 	return 0;
 
-#endif // ifdef _WIN64
+#endif // ifdef _WIN32
 }
 
 /*
@@ -117,11 +117,11 @@ int ext2fs_get_dio_alignment(int fd)
  */
 errcode_t ext2fs_get_device_phys_sectsize(const char *file, int *sectsize)
 {
-#ifdef _WIN64
+#ifdef _WIN32
 
 	return ext2fs_get_device_sectsize(file, sectsize);
 
-#else // not _WIN64
+#else // not _WIN32
 
 	int	fd;
 
@@ -147,5 +147,5 @@ errcode_t ext2fs_get_device_phys_sectsize(const char *file, int *sectsize)
 	close(fd);
 	return 0;
 
-#endif // ifdef _WIN64
+#endif // ifdef _WIN32
 }
diff --git a/lib/support/plausible.c b/lib/support/plausible.c
index bbed2a70..349aa2c4 100644
--- a/lib/support/plausible.c
+++ b/lib/support/plausible.c
@@ -103,7 +103,7 @@ static void print_ext2_info(const char *device)
 	time_t			tm;
 
 	retval = ext2fs_open2(device, 0, EXT2_FLAG_64BITS, 0, 0,
-#ifdef _WIN64
+#ifdef _WIN32
 			      windows_io_manager,
 #else
 			      unix_io_manager,
diff --git a/util/subst.c b/util/subst.c
index c0eda5cf..be2a0dda 100644
--- a/util/subst.c
+++ b/util/subst.c
@@ -434,7 +434,7 @@ int main(int argc, char **argv)
 					printf("Using original atime\n");
 				set_utimes(outfn, fileno(old), tv);
 			}
-#ifndef _WIN64
+#ifndef _WIN32
 			if (ofd >= 0)
 				(void) fchmod(ofd, 0444);
 #endif
@@ -444,7 +444,7 @@ int main(int argc, char **argv)
 		} else {
 			if (verbose)
 				printf("Creating or replacing %s.\n", outfn);
-#ifndef _WIN64
+#ifndef _WIN32
 			if (ofd >= 0)
 				(void) fchmod(ofd, 0444);
 #endif
-- 
2.39.0

