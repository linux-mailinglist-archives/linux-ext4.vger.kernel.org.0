Return-Path: <linux-ext4+bounces-11557-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D36C3D9B9
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 569A74E5405
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2D33EAF2;
	Thu,  6 Nov 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBx7qb4R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A4733DEE6
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468233; cv=none; b=rSnPEzg3/xQp0L52onT079yj8XgK/cO7qFcs9Y83Y7AcLN5Fwr/TmuLCD/06GFgs9zvpsOq98iklngL0tOu7VfXcne4lA4iFMONjoqmnLu6kGWtN+I5y4xsSiz2Vz9d49jh/3uFRRqr87+cKTHaN1ZNG9sCYR2NjltBAB+LOZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468233; c=relaxed/simple;
	bh=u/Rr4vqugUJTcLBtbKKl0MESIEDqrte5NOwof4EN/T0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AipvOLh+g+WY4na/EEt0QgnC34yyC2Tkll/GM/HLkeXrcn1mZpmYq5UKuF47O/yUSWMKKYCVmfC4A55xjvzQw5kY4cOEFdVLwoqOBYJ4O9mC9f2z7Y0chsZL1VjtZcC12vAsrNpE7PqfnrfESDyoa2s3w2excfLJywp/mOe1YnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBx7qb4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E506C116D0;
	Thu,  6 Nov 2025 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468233;
	bh=u/Rr4vqugUJTcLBtbKKl0MESIEDqrte5NOwof4EN/T0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gBx7qb4Rf3pEtdRu5aBRkGvsYx4ZyQ3bOU/2pLYr+oRVbMhivXgcz41pRgx4//u+O
	 p/G5y8DNyfKQ0BR/8QOWGOg3FHvXWmGDrsYksOOznMjYeKJbwBTnSDINF0afh4VpFK
	 Nqkyuua4DNdARnVmdq7FqDCGHRN+5FGS5x2y7mCsauRzQ11lKSu2/8BFFNo7ipcpKL
	 uRWwKl4Im0UIokMdkaLf6N+WZAEOiqUslyEild7Ol8wtP6XlCUAxnEKFJwfiYytXi6
	 h9ptQ20mqwzmN3UBbTzBs8Kux0qNVBeMZ53AnWT0G5mPFfc4WL+MT0eXSkQq829/qZ
	 sydoO6a/CmgIQ==
Date: Thu, 06 Nov 2025 14:30:32 -0800
Subject: [PATCH 2/4] fuse2fs: try to lock filesystem image files before using
 them
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793366.2862036.13609826616488702282.stgit@frogsfrogsfrogs>
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

Originally, this patch added support for using flock() to protect the
files opened by the Unix IO manager so that systemd and udev could not
access the block device while e2fsprogs is doing something with the
device.  However, flocking block devices for the duration of a mount
creates stalling problems with udev, because it will not process a
uevent for a block device until it can flock(LOCK_SH) the block device.
As a result, udevsettle blocks for 2 minutes until it times out and
exits with failure.

Since libext2fs generally opens block devices (on Linux) with O_EXCL,
fuse2fs is guaranteed to be the only program accessing the filesystem if
it's on a block device.  However, O_EXCL doesn't do anything for
non-block devices, so we need a way to coordinate write access to
filesystem image files.  Use the locking code, but only if we have a
non-block device.

Link: https://systemd.io/BLOCK_DEVICE_LOCKING/
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 83886faf2eada8..7b94f0df1688a1 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -297,6 +297,55 @@ static inline off_t FUSE2FS_FSB_TO_B(const struct fuse2fs *ff, blk64_t bno)
 	return bno << ff->blocklog;
 }
 
+static double gettime_monotonic(void)
+{
+#ifdef CLOCK_MONOTONIC
+	struct timespec ts;
+#endif
+	struct timeval tv;
+	static pthread_mutex_t fake_lock = PTHREAD_MUTEX_INITIALIZER;
+	static double fake_time = 0;
+	double dret;
+	int ret;
+
+#ifdef CLOCK_MONOTONIC
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts);
+	if (ret == 0)
+		return (double)ts.tv_sec + (ts.tv_nsec / 1000000000.0);
+#endif
+	ret = gettimeofday(&tv, NULL);
+	if (ret == 0)
+		return (double)tv.tv_sec + (tv.tv_usec / 1000000.0);
+
+	/* If we have no clock sources at all, fake it */
+	pthread_mutex_lock(&fake_lock);
+	fake_time += 1.0;
+	dret = fake_time;
+	pthread_mutex_unlock(&fake_lock);
+
+	return dret;
+}
+
+static double init_deadline(double timeout)
+{
+	return gettime_monotonic() + timeout;
+}
+
+static int retry_before_deadline(double deadline)
+{
+	double now = gettime_monotonic();
+
+	if (now >= deadline)
+		return 0;
+
+	/* sleep for 0.1s before trying again */
+	usleep(100000);
+	return 1;
+}
+
+/* Wait this many seconds to acquire the filesystem device */
+#define FUSE2FS_OPEN_TIMEOUT	(15.0)
+
 #define EXT4_EPOCH_BITS 2
 #define EXT4_EPOCH_MASK ((1 << EXT4_EPOCH_BITS) - 1)
 #define EXT4_NSEC_MASK  (~0UL << EXT4_EPOCH_BITS)
@@ -4684,6 +4733,7 @@ int main(int argc, char *argv[])
 	errcode_t err;
 	FILE *orig_stderr = stderr;
 	char extra_args[BUFSIZ];
+	double deadline;
 	int ret;
 	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE |
 		    EXT2_FLAG_RW;
@@ -4791,6 +4841,34 @@ int main(int argc, char *argv[])
 		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
 		goto out;
 	}
+
+	/*
+	 * If the filesystem is stored in a regular file, take an (advisory)
+	 * exclusive lock to prevent other instances of e2fsprogs from writing
+	 * to the filesystem image.  On Linux we don't want to do this for
+	 * block devices because udev will spin forever trying to settle a
+	 * uevent and cause weird userspace stalls, and block devices have
+	 * O_EXCL so we don't need this there.
+	 */
+	if (!(global_fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE)) {
+		unsigned int lock_flags = IO_CHANNEL_FLOCK_TRYLOCK;
+
+		if (global_fs->flags & IO_FLAG_RW)
+			lock_flags |= IO_CHANNEL_FLOCK_EXCLUSIVE;
+		else
+			lock_flags |= IO_CHANNEL_FLOCK_SHARED;
+
+		deadline = init_deadline(FUSE2FS_OPEN_TIMEOUT);
+		do {
+			err = io_channel_flock(global_fs->io, lock_flags);
+		} while (err == EWOULDBLOCK && retry_before_deadline(deadline));
+		if (err) {
+			err_printf(&fctx, "%s: %s\n",
+ _("Could not lock filesystem image"), error_message(err));
+			goto out;
+		}
+	}
+
 	fctx.fs = global_fs;
 	global_fs->priv_data = &fctx;
 	fctx.blocklog = u_log2(fctx.fs->blocksize);


