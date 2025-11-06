Return-Path: <linux-ext4+bounces-11591-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 80971C3DA37
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F1A534DD0E
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034763446A6;
	Thu,  6 Nov 2025 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPCG055j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29330B51B
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468776; cv=none; b=Vzb+/URpQl+C5q8AfbK5n2wxtmdzUJiPuAr7GH2BQ7/WYxjJrGBj+AoW0NyHyo3e/B/EwuRfiwbrPC9vJfNPOAIKkj6fd2kFmbX15MgsvyAxyTwTKGyuYR160eKQobWF/M+i2/OvJL9QjHv5MLU02DLGAIZiaPuwReHyKV+aY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468776; c=relaxed/simple;
	bh=fJANkMIPROAPd3YbUKQLPzlxv7zC62YI4SYJSDpLGj0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldOkN2jvO5ksz5z4B1ULqY+8EuVYtLQ8ARTv6MvJibzUwkQpzCN/yEMcyVfpTj6Wl51FmBhQ4RB+KgF72jAaHnCSAlYyZupY/4ROBj57xhtgz7sxh5x+h/oODKxNNAgnW//1BS2NuucHb9PLNuheJO0+Ljgzp0EZjiwDyrFZglc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPCG055j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5668EC4CEFB;
	Thu,  6 Nov 2025 22:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468776;
	bh=fJANkMIPROAPd3YbUKQLPzlxv7zC62YI4SYJSDpLGj0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QPCG055j0cvoVt0a/oh4Nckjkk6ioBznSSQ2eht61RcruGijXy1jyI+QpuM5qDxSV
	 y3Z0kuK8Dh6+ij9z2pU7ccc1KTHAb8oMOgMLnL8pQ0DW7xnJLUN++bI8Wzd46nTgn+
	 A4LyL0TWPoq1K70Wa+nanQmFnVKkgXwWphfENWg/F5JRXvkLyahDxawv9FxHkmw+zZ
	 YzTKvNYUvgr5exNffe0TZZndFUGqaWYLtgWUezejlDDU1WpZLi2BGnsZ7J2eH4ZW1U
	 wYCJJtqQaSDSDww7AjYAbE8HZ3o4UDHiQCUsnPwGU3oo2Aj2u2HsfFU9qQ9m6lw02Y
	 2CD2i99onASqQ==
Date: Thu, 06 Nov 2025 14:39:35 -0800
Subject: [PATCH 1/3] fuse2fs: split filesystem mounting into helper functions
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794668.2863550.4468222290307381568.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794639.2863550.14252706802579101303.stgit@frogsfrogsfrogs>
References: <176246794639.2863550.14252706802579101303.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Break up main() by moving the filesystem mounting logic into separate
helper functions.  This originally made it easier to move that part
around for fuseblk support, and I kept it around because splitting up
the mounting code into multiple smaller functions makes them easier to
understand.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  584 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 308 insertions(+), 276 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b096c3f496d740..e0134834d342dd 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1116,6 +1116,258 @@ static void fuse2fs_unmount(struct fuse2fs *ff)
 		fuse2fs_release_lockfile(ff);
 }
 
+static errcode_t fuse2fs_open(struct fuse2fs *ff)
+{
+	char options[128];
+	double deadline;
+	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_RW |
+		    EXT2_FLAG_EXCLUSIVE;
+	errcode_t err;
+
+	if (ff->lockfile) {
+		err = fuse2fs_acquire_lockfile(ff);
+		if (err)
+			return err;
+	}
+
+	snprintf(options, sizeof(options) - 1, "offset=%lu", ff->offset);
+
+	if (ff->directio)
+		flags |= EXT2_FLAG_DIRECT_IO;
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
+		err = ext2fs_open2(ff->device, options, flags, 0, 0,
+				   unix_io_manager, &ff->fs);
+		if ((err == EPERM || err == EACCES) &&
+		    (!ff->ro || (flags & EXT2_FLAG_RW))) {
+			/*
+			 * Source device cannot be opened for write.  Under
+			 * these circumstances, mount(8) will try again with a
+			 * ro mount, and the kernel will open the block device
+			 * readonly.
+			 */
+			log_printf(ff, "%s\n",
+ _("WARNING: source write-protected, mounted read-only."));
+			flags &= ~EXT2_FLAG_RW;
+			ff->ro = 1;
+
+			/* Force the loop to run once more */
+			err = -1;
+		}
+	} while (err == -1 ||
+		 (err == EBUSY && retry_before_deadline(deadline)));
+	if (err == EBUSY) {
+		err_printf(ff, "%s: %s.\n",
+ _("Could not lock filesystem block device"), error_message(err));
+		return err;
+	}
+	if (err) {
+		err_printf(ff, "%s.\n", error_message(err));
+		err_printf(ff, "%s\n", _("Please run e2fsck -fy."));
+		return err;
+	}
+
+	/*
+	 * If the filesystem is stored in a regular file, take an (advisory)
+	 * exclusive lock to prevent other instances of e2fsprogs from writing
+	 * to the filesystem image.  On Linux we don't want to do this for
+	 * block devices because udev will spin forever trying to settle a
+	 * uevent and cause weird userspace stalls, and block devices have
+	 * O_EXCL so we don't need this there.
+	 */
+	if (!(ff->fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE)) {
+		unsigned int lock_flags = IO_CHANNEL_FLOCK_TRYLOCK;
+
+		if (ff->fs->flags & IO_FLAG_RW)
+			lock_flags |= IO_CHANNEL_FLOCK_EXCLUSIVE;
+		else
+			lock_flags |= IO_CHANNEL_FLOCK_SHARED;
+
+		deadline = init_deadline(FUSE2FS_OPEN_TIMEOUT);
+		do {
+			err = io_channel_flock(ff->fs->io, lock_flags);
+		} while (err == EWOULDBLOCK && retry_before_deadline(deadline));
+		if (err) {
+			err_printf(ff, "%s: %s\n",
+ _("Could not lock filesystem image"), error_message(err));
+			return err;
+		}
+	}
+
+	if (ff->kernel) {
+		char uuid[UUID_STR_SIZE];
+
+		uuid_unparse(ff->fs->super->s_uuid, uuid);
+		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
+	}
+
+	ff->fs->priv_data = ff;
+	ff->blocklog = u_log2(ff->fs->blocksize);
+	ff->blockmask = ff->fs->blocksize - 1;
+
+	fuse2fs_mmp_config(ff);
+	return 0;
+}
+
+/* Figure out a reasonable default size for the disk cache */
+static unsigned long long default_cache_size(void)
+{
+	long pages = 0, pagesize = 0;
+	unsigned long long max_cache;
+	unsigned long long ret = 32ULL << 20; /* 32 MB */
+
+#ifdef _SC_PHYS_PAGES
+	pages = sysconf(_SC_PHYS_PAGES);
+#endif
+#ifdef _SC_PAGESIZE
+	pagesize = sysconf(_SC_PAGESIZE);
+#endif
+	if (pages > 0 && pagesize > 0) {
+		max_cache = (unsigned long long)pagesize * pages / 20;
+
+		if (max_cache > 0 && ret > max_cache)
+			ret = max_cache;
+	}
+	return ret;
+}
+
+static errcode_t fuse2fs_config_cache(struct fuse2fs *ff)
+{
+	char buf[128];
+	errcode_t err;
+
+	if (!ff->cache_size)
+		ff->cache_size = default_cache_size();
+	if (!ff->cache_size)
+		return 0;
+
+	snprintf(buf, sizeof(buf), "cache_blocks=%llu",
+		 FUSE2FS_B_TO_FSBT(ff, ff->cache_size));
+	err = io_channel_set_options(ff->fs->io, buf);
+	if (err) {
+		err_printf(ff, "%s %lluk: %s\n",
+			   _("cannot set disk cache size to"),
+			   ff->cache_size >> 10,
+			   error_message(err));
+		return err;
+	}
+
+	return 0;
+}
+
+static int fuse2fs_mount(struct fuse2fs *ff)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+
+	if (ext2fs_has_feature_journal_needs_recovery(fs->super)) {
+		if (ff->norecovery) {
+			log_printf(ff, "%s\n",
+ _("Mounting read-only without recovering journal."));
+			ff->ro = 1;
+			ff->fs->flags &= ~EXT2_FLAG_RW;
+		} else if (!(fs->flags & EXT2_FLAG_RW)) {
+			err_printf(ff, "%s\n",
+ _("Cannot replay journal on read-only device."));
+			return -1;
+		} else {
+			log_printf(ff, "%s\n", _("Recovering journal."));
+			err = ext2fs_run_ext3_journal(&ff->fs);
+			if (err) {
+				err_printf(ff, "%s.\n", error_message(err));
+				err_printf(ff, "%s\n",
+						_("Please run e2fsck -fy."));
+				return translate_error(fs, 0, err);
+			}
+			fs = ff->fs;
+
+			err = fuse2fs_check_support(ff);
+			if (err)
+				return err;
+		}
+	} else if (ext2fs_has_feature_journal(fs->super)) {
+		err = ext2fs_check_ext3_journal(fs);
+		if (err)
+			return translate_error(fs, 0, err);
+	}
+
+	/* Make sure the root directory is readable. */
+	err = fuse2fs_read_inode(fs, EXT2_ROOT_INO, &inode);
+	if (err)
+		return translate_error(fs, EXT2_ROOT_INO, err);
+
+	if (fs->flags & EXT2_FLAG_RW) {
+		if (ext2fs_has_feature_journal(fs->super))
+			log_printf(ff, "%s",
+ _("Warning: fuse2fs does not support using the journal.\n"
+   "There may be file system corruption or data loss if\n"
+   "the file system is not gracefully unmounted.\n"));
+	}
+
+	if (!(fs->super->s_state & EXT2_VALID_FS))
+		err_printf(ff, "%s\n",
+ _("Warning: Mounting unchecked fs, running e2fsck is recommended."));
+	if (fs->super->s_max_mnt_count > 0 &&
+	    fs->super->s_mnt_count >= fs->super->s_max_mnt_count)
+		err_printf(ff, "%s\n",
+ _("Warning: Maximal mount count reached, running e2fsck is recommended."));
+	if (fs->super->s_checkinterval > 0 &&
+	    (time_t) (fs->super->s_lastcheck +
+		      fs->super->s_checkinterval) <= time(0))
+		err_printf(ff, "%s\n",
+ _("Warning: Check time reached; running e2fsck is recommended."));
+	if (fs->super->s_last_orphan)
+		err_printf(ff, "%s\n",
+ _("Orphans detected; running e2fsck is recommended."));
+
+	if (!ff->errors_behavior)
+		ff->errors_behavior = fs->super->s_errors;
+
+	/* Clear the valid flag so that an unclean shutdown forces a fsck */
+	if (fs->flags & EXT2_FLAG_RW) {
+		fs->super->s_mnt_count++;
+		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
+		fs->super->s_state &= ~EXT2_VALID_FS;
+		ext2fs_mark_super_dirty(fs);
+		err = ext2fs_flush2(fs, 0);
+		if (err)
+			return translate_error(fs, 0, err);
+	}
+
+	return 0;
+}
+
 static void op_destroy(void *p EXT2FS_ATTR((unused)))
 {
 	struct fuse2fs *ff = fuse2fs_get();
@@ -1318,13 +1570,6 @@ static void *op_init(struct fuse_conn_info *conn
 	cfg->nullpath_ok = 1;
 #endif
 
-	if (ff->kernel) {
-		char uuid[UUID_STR_SIZE];
-
-		uuid_unparse(fs->super->s_uuid, uuid);
-		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
-	}
-
 	if (ff->fs->flags & EXT2_FLAG_RW)
 		fuse2fs_read_bitmaps(ff);
 
@@ -5183,39 +5428,59 @@ static const char *get_subtype(const char *argv0)
 	return "ext4";
 }
 
-/* Figure out a reasonable default size for the disk cache */
-static unsigned long long default_cache_size(void)
+static void fuse2fs_compute_libfuse_args(struct fuse2fs *ff,
+					 struct fuse_args *args,
+					 const char *argv0)
 {
-	long pages = 0, pagesize = 0;
-	unsigned long long max_cache;
-	unsigned long long ret = 32ULL << 20; /* 32 MB */
+	char extra_args[BUFSIZ];
 
-#ifdef _SC_PHYS_PAGES
-	pages = sysconf(_SC_PHYS_PAGES);
+	/* Set up default fuse parameters */
+	snprintf(extra_args, BUFSIZ, "-okernel_cache,subtype=%s,"
+		 "fsname=%s,attr_timeout=0" FUSE_PLATFORM_OPTS,
+		 get_subtype(argv0),
+		 ff->device);
+	if (ff->no_default_opts == 0)
+		fuse_opt_add_arg(args, extra_args);
+
+	if (ff->ro)
+		fuse_opt_add_arg(args, "-oro");
+
+	if (ff->fakeroot) {
+#ifdef HAVE_MOUNT_NODEV
+		fuse_opt_add_arg(args,"-onodev");
 #endif
-#ifdef _SC_PAGESIZE
-	pagesize = sysconf(_SC_PAGESIZE);
+#ifdef HAVE_MOUNT_NOSUID
+		fuse_opt_add_arg(args,"-onosuid");
 #endif
-	if (pages > 0 && pagesize > 0) {
-		max_cache = (unsigned long long)pagesize * pages / 20;
+	}
 
-		if (max_cache > 0 && ret > max_cache)
-			ret = max_cache;
+	if (ff->kernel) {
+		/*
+		 * ACLs are always enforced when kernel mode is enabled, to
+		 * match the kernel ext4 driver which always enables ACLs.
+		 */
+		ff->acl = 1;
+		fuse_opt_insert_arg(args, 1,
+ "-oallow_other,default_permissions,suid,dev");
 	}
-	return ret;
-}
 
-/* Make sure the root directory is readable. */
-static errcode_t fuse2fs_check_root_dir(ext2_filsys fs)
-{
-	struct ext2_inode_large inode;
-	errcode_t err;
+	/*
+	 * Since there's a Big Kernel Lock around all the libext2fs code, we
+	 * only need to start four threads -- one to decode a request, another
+	 * to do the filesystem work, a third to transmit the reply, and a
+	 * fourth to handle fuse notifications.
+	 */
+	fuse_opt_insert_arg(args, 1, "-omax_threads=4");
 
-	err = fuse2fs_read_inode(fs, EXT2_ROOT_INO, &inode);
-	if (err)
-		return translate_error(fs, EXT2_ROOT_INO, err);
+	if (ff->debug) {
+		int	i;
 
-	return 0;
+		printf("FUSE2FS (%s): fuse arguments:", ff->shortdev);
+		for (i = 0; i < args->argc; i++)
+			printf(" '%s'", args->argv[i]);
+		printf("\n");
+		fflush(stdout);
+	}
 }
 
 int main(int argc, char *argv[])
@@ -5224,11 +5489,7 @@ int main(int argc, char *argv[])
 	struct fuse2fs fctx;
 	errcode_t err;
 	FILE *orig_stderr = stderr;
-	char extra_args[BUFSIZ];
-	double deadline;
 	int ret;
-	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE |
-		    EXT2_FLAG_RW;
 
 	memset(&fctx, 0, sizeof(fctx));
 	fctx.magic = FUSE2FS_MAGIC;
@@ -5274,134 +5535,23 @@ int main(int argc, char *argv[])
 		fctx.alloc_all_blocks = 1;
 	}
 
-	if (fctx.lockfile && fuse2fs_acquire_lockfile(&fctx)) {
-		ret |= 32;
+	err = fuse2fs_open(&fctx);
+	if (err) {
+		ret = 32;
 		goto out;
 	}
 
-	/* Start up the fs (while we still can use stdout) */
-	ret = 2;
-	char options[50];
-	sprintf(options, "offset=%lu", fctx.offset);
-	if (fctx.directio)
-		flags |= EXT2_FLAG_DIRECT_IO;
-
-	/*
-	 * If the filesystem is stored on a block device, the _EXCLUSIVE flag
-	 * causes libext2fs to try to open the block device with O_EXCL.  If
-	 * the block device is already opened O_EXCL by something else, the
-	 * open call returns EBUSY.
-	 *
-	 * Unfortunately, there's a nasty race between fuse2fs going through
-	 * its startup sequence (open fs, parse superblock, daemonize, create
-	 * mount, respond to FUSE_INIT) in response to a mount(8) invocation
-	 * and another process that calls umount(2) on the same mount.
-	 *
-	 * If fuse2fs is being run as a mount(8) helper and has daemonized, the
-	 * original fuse2fs subprocess exits and so will mount(8).  This can
-	 * occur before the kernel issues a FUSE_INIT request to fuse2fs.  If
-	 * a process then umount(2)'s the mount, the kernel will abort the
-	 * fuse connection.  If the FUSE_INIT request hasn't been issued, now
-	 * it won't ever be issued.  The kernel tears down the mount and
-	 * returns from umount(2), but fuse2fs has no idea that any of this has
-	 * happened because it receives no requests.
-	 *
-	 * At this point, the original fuse2fs server holds the block device
-	 * open O_EXCL.  If mount(8) is invoked again on the same device, the
-	 * new fuse2fs server will try to open the block device O_EXCL and
-	 * fail.  A crappy solution here is to retry for 5 seconds, hoping that
-	 * the first fuse2fs server will wake up and exit.
-	 *
-	 * If the filesystem is in a regular file, O_EXCL (without O_CREAT) has
-	 * no defined behavior, but it never returns EBUSY.
-	 */
-	deadline = init_deadline(FUSE2FS_OPEN_TIMEOUT);
-	do {
-		err = ext2fs_open2(fctx.device, options, flags, 0, 0,
-				   unix_io_manager, &fctx.fs);
-		if ((err == EPERM || err == EACCES) &&
-		    (!fctx.ro || (flags & EXT2_FLAG_RW))) {
-			/*
-			 * Source device cannot be opened for write.  Under
-			 * these circumstances, mount(8) will try again with a
-			 * ro mount, and the kernel will open the block device
-			 * readonly.
-			 */
-			log_printf(&fctx, "%s\n",
- _("WARNING: source write-protected, mounted read-only."));
-			flags &= ~EXT2_FLAG_RW;
-			fctx.ro = 1;
-
-			/* Force the loop to run once more */
-			err = -1;
-		}
-	} while (err == -1 ||
-		 (err == EBUSY && retry_before_deadline(deadline)));
-	if (err == EBUSY) {
-		err_printf(&fctx, "%s: %s.\n",
- _("Could not lock filesystem block device"), error_message(err));
-		goto out;
-	}
+	err = fuse2fs_config_cache(&fctx);
 	if (err) {
-		err_printf(&fctx, "%s.\n", error_message(err));
-		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
+		ret = 32;
 		goto out;
 	}
 
-	/*
-	 * If the filesystem is stored in a regular file, take an (advisory)
-	 * exclusive lock to prevent other instances of e2fsprogs from writing
-	 * to the filesystem image.  On Linux we don't want to do this for
-	 * block devices because udev will spin forever trying to settle a
-	 * uevent and cause weird userspace stalls, and block devices have
-	 * O_EXCL so we don't need this there.
-	 */
-	if (!(fctx.fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE)) {
-		unsigned int lock_flags = IO_CHANNEL_FLOCK_TRYLOCK;
-
-		if (fctx.fs->flags & IO_FLAG_RW)
-			lock_flags |= IO_CHANNEL_FLOCK_EXCLUSIVE;
-		else
-			lock_flags |= IO_CHANNEL_FLOCK_SHARED;
-
-		deadline = init_deadline(FUSE2FS_OPEN_TIMEOUT);
-		do {
-			err = io_channel_flock(fctx.fs->io, lock_flags);
-		} while (err == EWOULDBLOCK && retry_before_deadline(deadline));
-		if (err) {
-			err_printf(&fctx, "%s: %s\n",
- _("Could not lock filesystem image"), error_message(err));
-			goto out;
-		}
-	}
-
-	fctx.fs->priv_data = &fctx;
-	fctx.blocklog = u_log2(fctx.fs->blocksize);
-	fctx.blockmask = fctx.fs->blocksize - 1;
-
-	fuse2fs_mmp_config(&fctx);
-
-	if (!fctx.cache_size)
-		fctx.cache_size = default_cache_size();
-	if (fctx.cache_size) {
-		char buf[55];
-
-		snprintf(buf, sizeof(buf), "cache_blocks=%llu",
-			 FUSE2FS_B_TO_FSBT(&fctx, fctx.cache_size));
-		err = io_channel_set_options(fctx.fs->io, buf);
-		if (err) {
-			err_printf(&fctx, "%s %lluk: %s\n",
-				   _("cannot set disk cache size to"),
-				   fctx.cache_size >> 10,
-				   error_message(err));
-			goto out;
-		}
-	}
-
-	ret = 3;
 	err = fuse2fs_check_support(&fctx);
-	if (err)
+	if (err) {
+		ret = 32;
 		goto out;
+	}
 
 	/*
 	 * ext4 can't do COW of shared blocks, so if the feature is enabled,
@@ -5410,134 +5560,16 @@ int main(int argc, char *argv[])
 	if (ext2fs_has_feature_shared_blocks(fctx.fs->super))
 		fctx.ro = 1;
 
-	if (ext2fs_has_feature_journal_needs_recovery(fctx.fs->super)) {
-		if (fctx.norecovery) {
-			log_printf(&fctx, "%s\n",
- _("Mounting read-only without recovering journal."));
-			fctx.ro = 1;
-			fctx.fs->flags &= ~EXT2_FLAG_RW;
-		} else if (!(fctx.fs->flags & EXT2_FLAG_RW)) {
-			err_printf(&fctx, "%s\n",
- _("Cannot replay journal on read-only device."));
-			ret = 32;
-			goto out;
-		} else {
-			log_printf(&fctx, "%s\n", _("Recovering journal."));
-			err = ext2fs_run_ext3_journal(&fctx.fs);
-			if (err) {
-				err_printf(&fctx, "%s.\n", error_message(err));
-				err_printf(&fctx, "%s\n",
-						_("Please run e2fsck -fy."));
-				goto out;
-			}
-
-			err = fuse2fs_check_support(&fctx);
-			if (err)
-				goto out;
-		}
-	} else if (ext2fs_has_feature_journal(fctx.fs->super)) {
-		err = ext2fs_check_ext3_journal(fctx.fs);
-		if (err) {
-			translate_error(fctx.fs, 0, err);
-			goto out;
-		}
-	}
-
-	ret = fuse2fs_check_root_dir(fctx.fs);
-	if (ret)
+	err = fuse2fs_mount(&fctx);
+	if (err) {
+		ret = 32;
 		goto out;
-
-	if (fctx.fs->flags & EXT2_FLAG_RW) {
-		if (ext2fs_has_feature_journal(fctx.fs->super))
-			log_printf(&fctx, "%s",
- _("Warning: fuse2fs does not support using the journal.\n"
-   "There may be file system corruption or data loss if\n"
-   "the file system is not gracefully unmounted.\n"));
 	}
 
-	if (!(fctx.fs->super->s_state & EXT2_VALID_FS))
-		err_printf(&fctx, "%s\n",
- _("Warning: Mounting unchecked fs, running e2fsck is recommended."));
-	if (fctx.fs->super->s_max_mnt_count > 0 &&
-	    fctx.fs->super->s_mnt_count >= fctx.fs->super->s_max_mnt_count)
-		err_printf(&fctx, "%s\n",
- _("Warning: Maximal mount count reached, running e2fsck is recommended."));
-	if (fctx.fs->super->s_checkinterval > 0 &&
-	    (time_t) (fctx.fs->super->s_lastcheck +
-		      fctx.fs->super->s_checkinterval) <= time(0))
-		err_printf(&fctx, "%s\n",
- _("Warning: Check time reached; running e2fsck is recommended."));
-	if (fctx.fs->super->s_last_orphan)
-		err_printf(&fctx, "%s\n",
- _("Orphans detected; running e2fsck is recommended."));
-
-	/* Clear the valid flag so that an unclean shutdown forces a fsck */
-	if (fctx.fs->flags & EXT2_FLAG_RW) {
-		fctx.fs->super->s_mnt_count++;
-		ext2fs_set_tstamp(fctx.fs->super, s_mtime, time(NULL));
-		fctx.fs->super->s_state &= ~EXT2_VALID_FS;
-		ext2fs_mark_super_dirty(fctx.fs);
-		err = ext2fs_flush2(fctx.fs, 0);
-		if (err) {
-			translate_error(fctx.fs, 0, err);
-			ret |= 32;
-			goto out;
-		}
-	}
-
-	if (!fctx.errors_behavior)
-		fctx.errors_behavior = fctx.fs->super->s_errors;
-
 	/* Initialize generation counter */
 	get_random_bytes(&fctx.next_generation, sizeof(unsigned int));
 
-	/* Set up default fuse parameters */
-	snprintf(extra_args, BUFSIZ, "-okernel_cache,subtype=%s,"
-		 "fsname=%s,attr_timeout=0" FUSE_PLATFORM_OPTS,
-		 get_subtype(argv[0]),
-		 fctx.device);
-	if (fctx.no_default_opts == 0)
-		fuse_opt_add_arg(&args, extra_args);
-
-	if (fctx.ro)
-		fuse_opt_add_arg(&args, "-oro");
-
-	if (fctx.fakeroot) {
-#ifdef HAVE_MOUNT_NODEV
-		fuse_opt_add_arg(&args,"-onodev");
-#endif
-#ifdef HAVE_MOUNT_NOSUID
-		fuse_opt_add_arg(&args,"-onosuid");
-#endif
-	}
-
-	if (fctx.kernel) {
-		/*
-		 * ACLs are always enforced when kernel mode is enabled, to
-		 * match the kernel ext4 driver which always enables ACLs.
-		 */
-		fctx.acl = 1;
-		fuse_opt_insert_arg(&args, 1,
- "-oallow_other,default_permissions,suid,dev");
-	}
-
-	/*
-	 * Since there's a Big Kernel Lock around all the libext2fs code, we
-	 * only need to start four threads -- one to decode a request, another
-	 * to do the filesystem work, a third to transmit the reply, and a
-	 * fourth to handle fuse notifications.
-	 */
-	fuse_opt_insert_arg(&args, 1, "-omax_threads=4");
-
-	if (fctx.debug) {
-		int	i;
-
-		printf("FUSE2FS (%s): fuse arguments:", fctx.shortdev);
-		for (i = 0; i < args.argc; i++)
-			printf(" '%s'", args.argv[i]);
-		printf("\n");
-		fflush(stdout);
-	}
+	fuse2fs_compute_libfuse_args(&fctx, &args, argv[0]);
 
 	ret = fuse_main(args.argc, args.argv, &fs_ops, &fctx);
 	switch(ret) {


