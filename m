Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D456267695C
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjAUUhK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5162917E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CBA360B6E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9DFC4339C;
        Sat, 21 Jan 2023 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333404;
        bh=omOEh/OU/autDrsEmmKxzE47wZxPhhPXi4Sar7ryPus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VbYgZSBhwIEW8/lslE2qXsqF/04GnDQzSBm6AI1SGVyrynhXdB6JN7cOfMKc5z6C1
         FAB/a2XC+QVxjh9fr/kjXaN8ddqRZOGjVrEVLR8F6cWejuOi3UbgZm4uxPXy0IpKFM
         RnHPRpOCdyqlp5v4tCzqbYSGwUVzviko7Gr3nRBiL6VxKRHL/4MJzViPelaHXzfVxo
         tmLa3En1iGg64j5rfmzQY2YPUzWXSa9GZmtIyWHPNaIPJCOkGY4AJpkyjSEuq2NbPi
         QFCuhXVBH2QKoBEoT08Ksmot8lgcGXiJsdQWoKwWXwFNo5UQScA4Sp8arUnkqJJCkX
         XlSxm/ZNoBQzg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: [PATCH 32/38] misc/mke2fs: fix Windows build
Date:   Sat, 21 Jan 2023 12:32:24 -0800
Message-Id: <20230121203230.27624-33-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
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

unix_io_manager is no longer available on Windows.  windows_io_manager
must be used instead.

Fixes: 86b6db9f5a43 ("libext2fs: code adaptation to use the Windows IO manager")
Cc: Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/ext2_io.h    |  2 ++
 lib/support/plausible.c |  7 +------
 misc/mke2fs.c           | 12 ++++++------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 8fe5b3235..679184e39 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -145,10 +145,12 @@ extern errcode_t io_channel_cache_readahead(io_channel io,
 #ifdef _WIN32
 /* windows_io.c */
 extern io_manager windows_io_manager;
+#define default_io_manager windows_io_manager
 #else
 /* unix_io.c */
 extern io_manager unix_io_manager;
 extern io_manager unixfd_io_manager;
+#define default_io_manager unix_io_manager
 #endif
 
 /* sparse_io.c */
diff --git a/lib/support/plausible.c b/lib/support/plausible.c
index 349aa2c4f..65a6b2e14 100644
--- a/lib/support/plausible.c
+++ b/lib/support/plausible.c
@@ -103,12 +103,7 @@ static void print_ext2_info(const char *device)
 	time_t			tm;
 
 	retval = ext2fs_open2(device, 0, EXT2_FLAG_64BITS, 0, 0,
-#ifdef _WIN32
-			      windows_io_manager,
-#else
-			      unix_io_manager,
-#endif
-                  &fs);
+			      default_io_manager, &fs);
 	if (retval)
 		return;
 	sb = fs->super;
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index bde1e582e..24cc14750 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -1950,10 +1950,10 @@ profile_error:
 #ifdef CONFIG_TESTIO_DEBUG
 		if (getenv("TEST_IO_FLAGS") || getenv("TEST_IO_BLOCK")) {
 			io_ptr = test_io_manager;
-			test_io_backing_manager = unix_io_manager;
+			test_io_backing_manager = default_io_manager;
 		} else
 #endif
-			io_ptr = unix_io_manager;
+			io_ptr = default_io_manager;
 		retval = ext2fs_open(journal_device,
 				     EXT2_FLAG_JOURNAL_DEV_OK, 0,
 				     0, io_ptr, &jfs);
@@ -2736,7 +2736,7 @@ static int should_do_undo(const char *name)
 	io_channel channel;
 	__u16	s_magic;
 	struct ext2_super_block super;
-	io_manager manager = unix_io_manager;
+	io_manager manager = default_io_manager;
 	int csum_flag, force_undo;
 
 	csum_flag = ext2fs_has_feature_metadata_csum(&fs_param) ||
@@ -3041,10 +3041,10 @@ int main (int argc, char *argv[])
 #ifdef CONFIG_TESTIO_DEBUG
 	if (getenv("TEST_IO_FLAGS") || getenv("TEST_IO_BLOCK")) {
 		io_ptr = test_io_manager;
-		test_io_backing_manager = unix_io_manager;
+		test_io_backing_manager = default_io_manager;
 	} else
 #endif
-		io_ptr = unix_io_manager;
+		io_ptr = default_io_manager;
 
 	if (undo_file != NULL || should_do_undo(device_name)) {
 		retval = mke2fs_setup_tdb(device_name, &io_ptr);
@@ -3449,7 +3449,7 @@ int main (int argc, char *argv[])
 
 		retval = ext2fs_open(journal_device, EXT2_FLAG_RW|
 				     EXT2_FLAG_JOURNAL_DEV_OK, 0,
-				     fs->blocksize, unix_io_manager, &jfs);
+				     fs->blocksize, default_io_manager, &jfs);
 		if (retval) {
 			com_err(program_name, retval,
 				_("while trying to open journal device %s\n"),
-- 
2.39.0

