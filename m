Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498A950EBE4
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Apr 2022 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiDYWZP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Apr 2022 18:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbiDYWEM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Apr 2022 18:04:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACE63D1
        for <linux-ext4@vger.kernel.org>; Mon, 25 Apr 2022 15:01:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B39251F4339D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650924065;
        bh=c8lFU9N0LceBGHRBW5cnITzHVTuouFri3tYwNZ5HHpc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=k3KFgYzbXJQINA+GKjkYnQWy+mWuNeMsuJQ5s5zEYYX5d73zNiiCIwb8OKbe31+aT
         JDu056qrYA9Vgn2LL+cT7a7u3Ltc80z8nb4pnjLpc5WVfJRJghlrTFv3n2L6qNVJua
         kRg+o+vZ4BLAAWdi+yc+WX9xIagmBTQCi8T66k/mvnt6586hdF4AG/fHpNRFrR3Yzh
         ZSPlRseVMxQ7xu01RkYcrEzxHocNd98zG10ZvZ0SFQtn1A8MAXOYYCemxxJmLyxlWJ
         DLutmuqSiY5MxHz4yi7X6UtQO9tQL1NwmTXmAQLu1kTr7XkaPhwbOBiOlCUF6gOA2l
         VYD1SHjGgNQNg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Peter Urbanec <linux-ext4.vger.kernel.org@urbanec.net>,
        linux-ext4@vger.kernel.org
Subject: [PATCH] e2fsck: Always probe filesystem blocksize with simple
 io_manager
Organization: Collabora
References: <493bbaea-b0d3-4f8e-20fb-5fb330a128a3@urbanec.net>
        <YlniK5dd1wV2bCXi@mit.edu>
Date:   Mon, 25 Apr 2022 18:01:00 -0400
In-Reply-To: <YlniK5dd1wV2bCXi@mit.edu> (Theodore Ts'o's message of "Fri, 15
        Apr 2022 17:22:51 -0400")
Message-ID: <87pml4lt5v.fsf_-_@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> So the failure of "e2fsck -f -C 0 -b 32768 -z /root/e2fsck.e2undo
> /dev/md0" appears to be a bug where e2fsck doesn't work correctly with
> an undo file when using a backup superblock.  I can replicate this
> using these commands:
>
> 	mke2fs -q -t ext4 /tmp/foo.img 2G
> 	e2fsck -b 32768 -z /tmp/undo /tmp/foo.img
>
> Running e2fsck without the -z option succeeds.  The combination of the
> -b and -z option seems to be broken.  As a workaround, I would suggest
> doing is to try running e2fsck with -n, which will open the block
> device read-only, e.g. "e2fsck -b 32768 -n /dev/mdXX".  If the changes
> e2fsck look safe, then you can run e2fsck without the -n option.

Ted,

I think this is a fix for the combination of -b and -z.

Thanks,

>8

Combining superblock (-b) with undo file (-z) fails iff the block size
is not specified (-B) and is different from the first blocksize probed
in try_open_fs (1k).  The reason is as follows:

try_open_fs will probe different blocksizes if none is provided on the
command line. It is done by opening and closing the filesystem until it
finds a blocksize that makes sense. This is fine for all io_managers,
but undo_io creates the undo file with that blocksize during
ext2fs_open.  Once try_open_fs realizes it had the wrong blocksize and
retries with a different blocksize, undo_io will read the previously
created file and think it's corrupt for this filesystem.

Ideally, undo_io would know this is a probe and would fix the undo file.
It is not simple, though, because it would require undo_io to know the
file was just created by the probe code, since an undo file survives
through different fsck sessions.  We'd have to pass this information
around somehow.  This seems like a complex change to solve a corner
case.

Instead, this patch changes the blocksize probe to always use the
unix_io_manager. This way, we safely probe for the blocksize without
side effects.  Once the blocksize is known, we can safely reopen the
filesystem under the proper io_manager.

An easily reproducer for this issue (from Ted, adapted by me) is:

 mke2fs -b 4k -q -t ext4 /tmp/foo.img 2G
 e2fsck -b 32768 -z /tmp/undo /tmp/foo.img

Reported-by: Peter Urbanec <linux-ext4.vger.kernel.org@urbanec.net>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 e2fsck/unix.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index ae231f93deb7..341b484e6ede 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1171,25 +1171,32 @@ static errcode_t try_open_fs(e2fsck_t ctx, int flags, io_manager io_ptr,
 	errcode_t retval;
 
 	*ret_fs = NULL;
-	if (ctx->superblock && ctx->blocksize) {
-		retval = ext2fs_open2(ctx->filesystem_name, ctx->io_options,
-				      flags, ctx->superblock, ctx->blocksize,
-				      io_ptr, ret_fs);
-	} else if (ctx->superblock) {
-		int blocksize;
-		for (blocksize = EXT2_MIN_BLOCK_SIZE;
-		     blocksize <= EXT2_MAX_BLOCK_SIZE; blocksize *= 2) {
-			if (*ret_fs) {
-				ext2fs_free(*ret_fs);
-				*ret_fs = NULL;
+
+	if (ctx->superblock) {
+		unsigned long blocksize = ctx->blocksize;
+
+		if (!blocksize) {
+			for (blocksize = EXT2_MIN_BLOCK_SIZE;
+			     blocksize <= EXT2_MAX_BLOCK_SIZE; blocksize *= 2) {
+
+				retval = ext2fs_open2(ctx->filesystem_name,
+						      ctx->io_options, flags,
+						      ctx->superblock, blocksize,
+						      unix_io_manager, ret_fs);
+				if (*ret_fs) {
+					ext2fs_free(*ret_fs);
+					*ret_fs = NULL;
+				}
+				if (!retval)
+					break;
 			}
-			retval = ext2fs_open2(ctx->filesystem_name,
-					      ctx->io_options, flags,
-					      ctx->superblock, blocksize,
-					      io_ptr, ret_fs);
-			if (!retval)
-				break;
+			if (retval)
+				return retval;
 		}
+
+		retval = ext2fs_open2(ctx->filesystem_name, ctx->io_options,
+				      flags, ctx->superblock, blocksize,
+				      io_ptr, ret_fs);
 	} else
 		retval = ext2fs_open2(ctx->filesystem_name, ctx->io_options,
 				      flags, 0, 0, io_ptr, ret_fs);
-- 
2.35.1

