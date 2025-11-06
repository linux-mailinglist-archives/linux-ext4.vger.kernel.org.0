Return-Path: <linux-ext4+bounces-11559-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 589C2C3D9BF
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CFEE4E469F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E382E8E08;
	Thu,  6 Nov 2025 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoFuTQqZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEF3FBA7
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468265; cv=none; b=KfQYQ/X+cdNNovLsfiTKXRNi2qolgGNgxIbr/lgMPWb/jNZ8ey5Q3qLoESIm5fJc7FeBFVeVPYOVQDIi0euw2WZXDRtXtq1tMcepYpK1fMRsOA/YZn8FqBc9oznR2V/v5go8/gy93kufLrVVxRuFaiHR46oF81I+BWOQxk6SaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468265; c=relaxed/simple;
	bh=sO0+EwQnL2rv/3Dh0AzbZPy5uUZUiWLrX1y7y5n7sVA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQAN/1qLpIUzw2JN2aysiePqNhjtAjOVEhO59JZ5pmMgMesumys11GmmZJoFBKXVbgBfBwK0DuifN1+KjHSN8bDfaYdikDRKHJ40gybssTJy1LCG8cpH5c0LL3qzUDctGKRitDNjw+sX9UK/MPdSlsYs5xiXTN38+hWvF63Vvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoFuTQqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399F7C4CEF7;
	Thu,  6 Nov 2025 22:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468265;
	bh=sO0+EwQnL2rv/3Dh0AzbZPy5uUZUiWLrX1y7y5n7sVA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CoFuTQqZm+RhomuiKZwo2K6oGPW62xyJrkl6/oi0D+Ns5IdPj74zbH2LWvrgApwKo
	 pXwO+nVfVcdd1e70aRPQ8aRmwaS8ULjrb74z5ZQ41zUsK9NtPx+XTD1oFN5kkVzmd2
	 Zmtt6oNDS7f6PBzGVpdObJFP9RktTbbG/h9BJGfFniiZZiXuRT2Qz4U3t2qpxsJou6
	 oFO02q90e/VIrwdkqU5TicoTJ8EmZKsOeeT9nfHYgVbBQINiF5KF/n/IfLcyngrqQ2
	 3fxPBmCs8z6xCg+aXCDkRIDeyEbRYpqn8tXXP5aUmSweQPiIyPz2giyIISATcJrHoc
	 rnnABNjaBaPbg==
Date: Thu, 06 Nov 2025 14:31:04 -0800
Subject: [PATCH 4/4] fuse2fs: try to grab block device O_EXCL repeatedly
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176246793402.2862036.10955988600913253295.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793314.2862036.15869840216751367735.stgit@frogsfrogsfrogs>
References: <176246793314.2862036.15869840216751367735.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

generic/646 keeps failing to mount in this fashion:

 run fstests generic/646 at 2025-10-20 17:10:26
 [U] FUSE2FS (sda4): mounted filesystem f8f21d10-2ec9-4aef-a509-b32659b4e6b0.
 fuse: EXPERIMENTAL iomap feature enabled.  Use at your own risk!
 [U] FUSE2FS (sda4): shut down requested.
 [U] FUSE2FS (sda4): unmounted filesystem f8f21d10-2ec9-4aef-a509-b32659b4e6b0.
 [U] FUSE2FS (sda4): mounted filesystem 9efc6297-74c0-448c-b253-cecffd947239.
 fuse: EXPERIMENTAL iomap feature enabled.  Use at your own risk!
 [U] FUSE2FS (sda4): shut down requested.
 [U] FUSE2FS (sda4): unmounted filesystem 9efc6297-74c0-448c-b253-cecffd947239.
 [U] FUSE2FS (sda4): mounted filesystem 9efc6297-74c0-448c-b253-cecffd947239.
 [U] FUSE2FS (sda4): Warning: Mounting unchecked fs, running e2fsck is recommended.
 [U] FUSE2FS (sda4): Device or resource busy.
 [U] FUSE2FS (sda4): Please run e2fsck -fy.
 [U] Mount failed while opening filesystem.  Check dmesg(1) for details.
 [U] FUSE2FS (sda4): unmounted filesystem 9efc6297-74c0-448c-b253-cecffd947239.

It turns out that one can mount a fuse filesystem and unmount it before
the kernel even has a chance to send FUSE_INIT to the fuse server.  If
this occurs, the unmount code will abort the FUSE_INIT request and tear
down the fs mount immediately.

Unfortunately for fstests, the fuse server may have already opened the
block device with O_EXCL and will keep running with the bdev open until
libfuse notices that the connection to the kernel died and tells the
fuse server to destroy itself.  That might not happen for a long time
after the unmount program exits, in which case a subsequent invocation
of the fuse server can race with the dying fuse server to open the block
device.  When this happens, the new invocation fails with "Device or
resource busy".

This is exactly what's happening in this test, which is only noticeable
because it cycles the scratch mount so quickly.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   67 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 13 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index bbd79d6c09f4bc..76872d793ea394 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4821,21 +4821,62 @@ int main(int argc, char *argv[])
 	sprintf(options, "offset=%lu", fctx.offset);
 	if (fctx.directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
-	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
-			   &global_fs);
-	if ((err == EPERM || err == EACCES) &&
-	    (!fctx.ro || (flags & EXT2_FLAG_RW))) {
-		/*
-		 * Source device cannot be opened for write.  Under these
-		 * circumstances, mount(8) will try again with a ro mount,
-		 * and the kernel will open the block device readonly.
-		 */
-		log_printf(&fctx, "%s\n",
- _("WARNING: source write-protected, mounted read-only."));
-		flags &= ~EXT2_FLAG_RW;
-		fctx.ro = 1;
+
+	/*
+	 * If the filesystem is stored on a block device, the _EXCLUSIVE flag
+	 * causes libext2fs to try to open the block device with O_EXCL.  If
+	 * the block device is already opened O_EXCL by something else, the
+	 * open call returns EBUSY.
+	 *
+	 * Unfortunately, there's a nasty race between fuse2fs going through
+	 * its startup sequence (open fs, parse superblock, daemonize, create
+	 * mount, respond to FUSE_INIT) in response to a mount(8) invocation
+	 * and another process that calls umount(2) on the same mount.
+	 *
+	 * If fuse2fs is being run as a mount(8) helper and has daemonized, the
+	 * original fuse2fs subprocess exits and so will mount(8).  This can
+	 * occur before the kernel issues a FUSE_INIT request to fuse2fs.  If
+	 * a process then umount(2)'s the mount, the kernel will abort the
+	 * fuse connection.  If the FUSE_INIT request hasn't been issued, now
+	 * it won't ever be issued.  The kernel tears down the mount and
+	 * returns from umount(2), but fuse2fs has no idea that any of this has
+	 * happened because it receives no requests.
+	 *
+	 * At this point, the original fuse2fs server holds the block device
+	 * open O_EXCL.  If mount(8) is invoked again on the same device, the
+	 * new fuse2fs server will try to open the block device O_EXCL and
+	 * fail.  A crappy solution here is to retry for 5 seconds, hoping that
+	 * the first fuse2fs server will wake up and exit.
+	 *
+	 * If the filesystem is in a regular file, O_EXCL (without O_CREAT) has
+	 * no defined behavior, but it never returns EBUSY.
+	 */
+	deadline = init_deadline(FUSE2FS_OPEN_TIMEOUT);
+	do {
 		err = ext2fs_open2(fctx.device, options, flags, 0, 0,
 				   unix_io_manager, &global_fs);
+		if ((err == EPERM || err == EACCES) &&
+		    (!fctx.ro || (flags & EXT2_FLAG_RW))) {
+			/*
+			 * Source device cannot be opened for write.  Under
+			 * these circumstances, mount(8) will try again with a
+			 * ro mount, and the kernel will open the block device
+			 * readonly.
+			 */
+			log_printf(&fctx, "%s\n",
+ _("WARNING: source write-protected, mounted read-only."));
+			flags &= ~EXT2_FLAG_RW;
+			fctx.ro = 1;
+
+			/* Force the loop to run once more */
+			err = -1;
+		}
+	} while (err == -1 ||
+		 (err == EBUSY && retry_before_deadline(deadline)));
+	if (err == EBUSY) {
+		err_printf(&fctx, "%s: %s.\n",
+ _("Could not lock filesystem block device"), error_message(err));
+		goto out;
 	}
 	if (err) {
 		err_printf(&fctx, "%s.\n", error_message(err));


