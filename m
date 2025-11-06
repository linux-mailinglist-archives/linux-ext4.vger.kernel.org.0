Return-Path: <linux-ext4+bounces-11578-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C2C3D9FE
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34FC188D457
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E49F339709;
	Thu,  6 Nov 2025 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2jXlOD4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5973376A5
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468568; cv=none; b=D0Rg55+CK3MF5YOVeTr1SC5QOfge5uzPxtQfVGXy8J2LWgMjge5U9vtsZsohAwzSvxh3VqJf1nHWmtvH79VIP7agUeeKkO4AFpqhtkWvB8JsnvUB4PJMlpaxnKWFhbeesH7Oo2FTIqzFJdLYW8wwpfqn8XjyMAov+CVMIK+JPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468568; c=relaxed/simple;
	bh=Qiqfns9yPMPuK3l0iSq0pwwWHXAV1bRule9H4csrJG4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqbs9zlR5OD3qtF89IBGoJKiZnaohBSN8ZxfWO/IEnY9tRpHnvFaHGIA3TTm2WA0TZfXYmdQHsneyLNEKDdzLZyuC/C8xrEm8P5hvhlHLlzrEA2TGbVuuoGgxnDx3VPTyXL0hs9OBw++QupxXcxfEdHCKJgsIdnhqB2117h5iLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2jXlOD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B36C4CEF7;
	Thu,  6 Nov 2025 22:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468568;
	bh=Qiqfns9yPMPuK3l0iSq0pwwWHXAV1bRule9H4csrJG4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=l2jXlOD47KP4UrEscQwunMNwgIfb7BaWhL3yV5S7P/JevSGB98RqvU0qnkFy5bxN4
	 CRemmdAa0raSQQJer6d1ovks/52iT/J8fdR2yWGkSdm9DhsjQVTqVGMD3cHBsfxMd/
	 517wMNDnYlng/eWrW7SoQU1mJ3ty5lAN7dyViZp72BawBLcQLy2fEFJ2KyvEBR7gw/
	 +kqdiAx8rqO5/QagJTNKrdCthKUJyxo7cxTQkzJeNLO9r2lxVPuPP1hPjXapEAupXx
	 V912XD+RvNK5JnbUKoOpWkZVkeDNuZL6lrKi95hHiaeRvhAdI5VtGMglYe4I0FV4oI
	 fwwwOXFIoGKVA==
Date: Thu, 06 Nov 2025 14:36:07 -0800
Subject: [PATCH 19/19] fuse2fs: implement MMP updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793973.2862242.8082873020640643812.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Periodically rewrite the MMP block while we're mounted like the Linux
driver does, so that other potential users don't see EXT4_MMP_SEQ_FSCK
and erroneously report that the ext4 filesystem is being fscked.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b1cac46ddce567..589599f91b4390 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -46,6 +46,7 @@
 #include "ext2fs/ext2fs.h"
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fsP.h"
+#include "support/bthread.h"
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 # define FUSE_PLATFORM_OPTS	""
 #else
@@ -241,6 +242,10 @@ struct fuse2fs {
 	unsigned int next_generation;
 	unsigned long long cache_size;
 	char *lockfile;
+#ifdef CONFIG_MMP
+	struct bthread *mmp_thread;
+	unsigned int mmp_update_interval;
+#endif
 };
 
 #define FUSE2FS_CHECK_MAGIC(fs, ptr, num) do {if ((ptr)->magic != (num)) \
@@ -466,6 +471,133 @@ static inline errcode_t fuse2fs_write_inode(ext2_filsys fs, ext2_ino_t ino,
 				       sizeof(*inode));
 }
 
+#ifdef CONFIG_MMP
+static bool fuse2fs_mmp_wanted(const struct fuse2fs *ff)
+{
+	ext2_filsys fs = ff->fs;
+
+	if (!fs || !ext2fs_has_feature_mmp(fs->super) ||
+	    !(fs->flags & EXT2_FLAG_RW) || (fs->flags & EXT2_FLAG_SKIP_MMP))
+		return false;
+	return true;
+}
+
+static int fuse2fs_mmp_touch(struct fuse2fs *ff, bool immediate)
+{
+	ext2_filsys fs = ff->fs;
+	struct mmp_struct *mmp = fs->mmp_buf;
+	struct mmp_struct *mmp_cmp = fs->mmp_cmp;
+	struct timeval tv;
+	errcode_t retval = 0;
+
+	gettimeofday(&tv, 0);
+	if (!immediate &&
+	    tv.tv_sec - fs->mmp_last_written < ff->mmp_update_interval)
+		return 0;
+
+	retval = ext2fs_mmp_read(fs, fs->super->s_mmp_block, NULL);
+	if (retval)
+		return translate_error(fs, 0, retval);
+
+	if (memcmp(mmp, mmp_cmp, sizeof(*mmp_cmp)))
+		return translate_error(fs, 0, EXT2_ET_MMP_CHANGE_ABORT);
+
+	/*
+	 * Believe it or not, ext2fs_mmp_read actually overwrites fs->mmp_cmp
+	 * and leaves fs->mmp_buf untouched.  Hence we copy mmp_cmp into
+	 * mmp_buf, update mmp_buf, and write mmp_buf out to disk.
+	 */
+	memcpy(mmp, mmp_cmp, sizeof(*mmp_cmp));
+	mmp->mmp_time = tv.tv_sec;
+	mmp->mmp_seq = ext2fs_mmp_new_seq();
+
+	retval = ext2fs_mmp_write(fs, fs->super->s_mmp_block, fs->mmp_buf);
+	if (retval)
+		return translate_error(fs, 0, retval);
+
+	return 0;
+}
+
+static void fuse2fs_mmp_bthread(void *data)
+{
+	struct fuse2fs *ff = data;
+
+	pthread_mutex_lock(&ff->bfl);
+	if (fuse2fs_mmp_wanted(ff) && !bthread_cancelled(ff->mmp_thread))
+		fuse2fs_mmp_touch(ff, false);
+	pthread_mutex_unlock(&ff->bfl);
+}
+
+static void fuse2fs_mmp_start(struct fuse2fs *ff)
+{
+	int ret;
+
+	if (!fuse2fs_mmp_wanted(ff))
+		return;
+
+	ret = bthread_create("fuse2fs_mmp", fuse2fs_mmp_bthread, ff,
+			     ff->mmp_update_interval, &ff->mmp_thread);
+	if (ret) {
+		err_printf(ff, "MMP: %s.\n", error_message(ret));
+		return;
+	}
+
+	ret = bthread_start(ff->mmp_thread);
+	if (ret)
+		err_printf(ff, "MMP: %s.\n", error_message(ret));
+}
+
+static void fuse2fs_mmp_cancel(struct fuse2fs *ff)
+{
+	if (ff->mmp_thread)
+		bthread_cancel(ff->mmp_thread);
+}
+
+static void fuse2fs_mmp_config(struct fuse2fs *ff)
+{
+	ext2_filsys fs = ff->fs;
+	struct mmp_struct *mmp_s = fs->mmp_buf;
+	unsigned int mmp_update_interval = fs->super->s_mmp_update_interval;
+
+	if (!ext2fs_has_feature_mmp(fs->super) ||
+	    !(fs->flags & EXT2_FLAG_RW) ||
+	    (fs->flags & EXT2_FLAG_SKIP_MMP))
+		return;
+
+	/*
+	 * If update_interval in MMP block is larger, use that instead of
+	 * update_interval from the superblock.
+	 */
+	if (mmp_s->mmp_check_interval > mmp_update_interval)
+		mmp_update_interval = mmp_s->mmp_check_interval;
+
+	/* Clamp to the relevant(?) interval values */
+	if (mmp_update_interval < EXT4_MMP_MIN_CHECK_INTERVAL)
+		mmp_update_interval = EXT4_MMP_MIN_CHECK_INTERVAL;
+	if (mmp_update_interval > EXT4_MMP_MAX_UPDATE_INTERVAL)
+		mmp_update_interval = EXT4_MMP_MAX_UPDATE_INTERVAL;
+
+	ff->mmp_update_interval = mmp_update_interval;
+
+	/*
+	 * libext2fs writes EXT4_MMP_SEQ_FSCK after mounting, so we need to
+	 * update it immediately so that it doesn't look like another node is
+	 * actually running fsck.
+	 */
+	fuse2fs_mmp_touch(ff, true);
+}
+
+static void fuse2fs_mmp_destroy(struct fuse2fs *ff)
+{
+	bthread_destroy(&ff->mmp_thread);
+}
+#else
+# define fuse2fs_mmp_start(...)		((void)0)
+# define fuse2fs_mmp_cancel(...)	((void)0)
+# define fuse2fs_mmp_config(...)	((void)0)
+# define fuse2fs_mmp_destroy(...)	((void)0)
+#endif
+
 static void get_now(struct timespec *now)
 {
 #ifdef CLOCK_REALTIME
@@ -1052,6 +1184,13 @@ static void *op_init(struct fuse_conn_info *conn
 	if (global_fs->flags & EXT2_FLAG_RW)
 		fuse2fs_read_bitmaps(ff);
 
+	/*
+	 * Background threads must be started from op_init because libfuse
+	 * might daemonize us in fuse_main() by forking, and threads are not
+	 * conveyed to the new child process.
+	 */
+	fuse2fs_mmp_start(ff);
+
 	return ff;
 }
 
@@ -5018,6 +5157,7 @@ int main(int argc, char *argv[])
 	memset(&fctx, 0, sizeof(fctx));
 	fctx.magic = FUSE2FS_MAGIC;
 	fctx.logfd = -1;
+	fctx.bfl = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
 
 	ret = fuse_opt_parse(&args, &fctx, fuse2fs_opts, fuse2fs_opt_proc);
 	if (ret)
@@ -5193,6 +5333,8 @@ int main(int argc, char *argv[])
 	fctx.blocklog = u_log2(fctx.fs->blocksize);
 	fctx.blockmask = fctx.fs->blocksize - 1;
 
+	fuse2fs_mmp_config(&fctx);
+
 	if (!fctx.cache_size)
 		fctx.cache_size = default_cache_size();
 	if (fctx.cache_size) {
@@ -5351,10 +5493,7 @@ int main(int argc, char *argv[])
 		fflush(stdout);
 	}
 
-	pthread_mutex_init(&fctx.bfl, NULL);
 	ret = fuse_main(args.argc, args.argv, &fs_ops, &fctx);
-	pthread_mutex_destroy(&fctx.bfl);
-
 	switch(ret) {
 	case 0:
 		/* success */
@@ -5389,6 +5528,7 @@ int main(int argc, char *argv[])
  _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
 		fflush(orig_stderr);
 	}
+	fuse2fs_mmp_destroy(&fctx);
 	if (global_fs) {
 		err = ext2fs_close_free(&global_fs);
 		if (err)
@@ -5405,6 +5545,7 @@ int main(int argc, char *argv[])
 	}
 	if (fctx.device)
 		free(fctx.device);
+	pthread_mutex_destroy(&fctx.bfl);
 	fuse_opt_free_args(&args);
 	return ret;
 }
@@ -5575,6 +5716,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 		if (fs->flags & EXT2_FLAG_RW)
 			err_printf(ff, "%s\n",
  _("Remounting read-only due to errors."));
+		fuse2fs_mmp_cancel(ff);
 		fs->flags &= ~EXT2_FLAG_RW;
 		break;
 	case EXT2_ERRORS_PANIC:


