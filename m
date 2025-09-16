Return-Path: <linux-ext4+bounces-10088-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD39B588B8
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9AA7AE0A9
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 23:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5D9450FE;
	Tue, 16 Sep 2025 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUx7z8i3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B27494
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980853; cv=none; b=YU+B/bxgwJS2V3RYYcTK2F45zUeVLNU5Amyz6CutTV5kflSXIx1l+m4cAzh8MOiYdIbj0fudjWEmce16nrBv05ZRHHOeVZqiTtdno8xQ7p7EsK0xT289bvJAhiZY1jnECrcjd7crD+BP7GxF57b3vnmw1gRj3aBw8OsacVCx0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980853; c=relaxed/simple;
	bh=0UWiOv+jQMVHgSnzRDeE8mle6LtI3fHMiKnfz9zy0eU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtNU8kpsvr62NEMlnYEf7PiLHrWZ5K/USyYFQ7iIJ2n37gOypjfx/XRbyWWvglFElGJOi7sPpNfDGW0/k8nc5yMTq/JCf6UpnFhlR1wCEbY6clFsaQKw29Yzc0K52a2YZBbsxpYqQ9DfOZLeN1DJMMNcgMON9JzEbaR88ug1kCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUx7z8i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00616C4CEF1;
	Tue, 16 Sep 2025 00:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980853;
	bh=0UWiOv+jQMVHgSnzRDeE8mle6LtI3fHMiKnfz9zy0eU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TUx7z8i3jWwIJL+q4FGpmHY513z+Vqc5EA0RT9wsFU7V3CpU2kz135d3gAVfu9TXu
	 oCmB0qPPk94BpBOGNijLz1+9OaT6uOe7xrgi+4Qkm70qupeMPQJv+7mAq22dfjIowT
	 EXCjRYihNBUaSqtXkixKr0psN3aGWugn7eGAeHWvx6Gl0Y7Tn4N+ED+JlBgpMQzd1m
	 fxeOYkjliGlwkyWeAkGpDDSUQ9y76lKsGihj2PDHiZc36Mz7gv4MwHjza0MTrrED98
	 3mue9PxRqS9qq9Bgpm4tzHh1KVUMos7LW2MizN+C6uAP9c/Kp55RlUOEcxl2mOtZv2
	 d6jYmuXD+tcjA==
Date: Mon, 15 Sep 2025 17:00:52 -0700
Subject: [PATCH 7/9] fuse2fs: clean up operation completion
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064221.349283.10566068410497082317.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
References: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a helper to release the BFL and log any errors.  This cuts down
on the boilerplate.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   73 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 32 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9ea42eeeb13bfd..b856cc3a6f23ed 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -443,6 +443,15 @@ static inline ext2_filsys fuse2fs_start(struct fuse2fs *ff)
 	return ff->fs;
 }
 
+static inline void __fuse2fs_finish(struct fuse2fs *ff, int ret,
+				    const char *func)
+{
+	if (ret)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", func, ret);
+	pthread_mutex_unlock(&ff->bfl);
+}
+#define fuse2fs_finish(ff, ret) __fuse2fs_finish((ff), (ret), __func__)
+
 static void get_now(struct timespec *now)
 {
 #ifdef CLOCK_REALTIME
@@ -817,7 +826,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		log_printf(ff, "%s %s.\n", _("unmounting filesystem"), uuid);
 	}
 
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, 0);
 }
 
 /* Reopen @stream with @fileno */
@@ -1106,7 +1115,7 @@ static int op_getattr(const char *path, struct stat *statbuf
 		goto out;
 	ret = stat_inode(fs, ino, statbuf);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -1179,7 +1188,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	}
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -1488,7 +1497,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 
 out2:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 out:
 	free(temp_path);
 	return ret;
@@ -1623,7 +1632,7 @@ static int op_mkdir(const char *path, mode_t mode)
 out3:
 	ext2fs_free_mem(&block);
 out2:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 out:
 	free(temp_path);
 	return ret;
@@ -1823,7 +1832,7 @@ static int op_unlink(const char *path)
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fuse2fs_start(ff);
 	ret = __op_unlink(ff, path);
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -1947,7 +1956,7 @@ static int op_rmdir(const char *path)
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fuse2fs_start(ff);
 	ret = __op_rmdir(ff, path);
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -2055,7 +2064,7 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 
 out2:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 out:
 	free(temp_path);
 	return ret;
@@ -2320,7 +2329,7 @@ static int op_rename(const char *from, const char *to
 	free(temp_from);
 	free(temp_to);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -2415,7 +2424,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 
 out2:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 out:
 	free(temp_path);
 	return ret;
@@ -2575,7 +2584,7 @@ static int op_chmod(const char *path, mode_t mode
 	}
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -2645,7 +2654,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	}
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -2748,7 +2757,7 @@ static int op_truncate(const char *path, off_t len
 		goto out;
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -2865,7 +2874,7 @@ static int op_open(const char *path, struct fuse_file_info *fp)
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fuse2fs_start(ff);
 	ret = __op_open(ff, path, fp);
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -2921,7 +2930,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 			goto out;
 	}
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return got ? (int) got : ret;
 }
 
@@ -2993,7 +3002,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return got ? (int) got : ret;
 }
 
@@ -3022,7 +3031,7 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	}
 
 	fp->fh = 0;
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	ext2fs_free_mem(&fh);
 
@@ -3051,7 +3060,7 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
 	}
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3100,7 +3109,7 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 	if (!(fs->flags & EXT2_FLAG_RW))
 		buf->f_flag |= ST_RDONLY;
 	buf->f_namemax = EXT2_NAME_LEN;
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, 0);
 
 	return 0;
 }
@@ -3174,7 +3183,7 @@ static int op_getxattr(const char *path, const char *key, char *value,
 
 	ext2fs_free_mem(&ptr);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3271,7 +3280,7 @@ static int op_listxattr(const char *path, char *names, size_t len)
 	if (err && !ret)
 		ret = translate_error(fs, ino, err);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3364,7 +3373,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 	if (!ret && err)
 		ret = translate_error(fs, ino, err);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3459,7 +3468,7 @@ static int op_removexattr(const char *path, const char *key)
 	if (err && !ret)
 		ret = translate_error(fs, ino, err);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3596,7 +3605,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 			goto out;
 	}
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -3623,7 +3632,7 @@ static int op_access(const char *path, int mask)
 		goto out;
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -3751,7 +3760,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 
 out2:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 out:
 	free(temp_path);
 	return ret;
@@ -3806,7 +3815,7 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -3826,7 +3835,7 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	fs = fuse2fs_start(ff);
 	ret = stat_inode(fs, fh->ino, statbuf);
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3899,7 +3908,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	}
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -4294,7 +4303,7 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 		dbg_printf(ff, "%s: Unknown ioctl %d\n", __func__, cmd);
 		ret = -ENOTTY;
 	}
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -4326,7 +4335,7 @@ static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 	}
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -4582,7 +4591,7 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 	else
 		ret = fuse2fs_allocate_range(ff, fh, mode, offset, len);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }


