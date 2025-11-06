Return-Path: <linux-ext4+bounces-11585-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17089C3DA19
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E618854F0
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D943081D7;
	Thu,  6 Nov 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMTHHLCE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B830B511
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468681; cv=none; b=OGREIP9T4x0O+uYTr+7mdZjJw2i7yB07gz2nAp9vKioWF/QDkEESDI/0WheK6UmHLLHJNy6rlwh/B5c8ZVXBL9760kTvNjfmFOIFweJ4hhMtt6mUvDRZiCqyaz0MIBZxM1AtNiBJiDk0dFFsp7edHp1CVE1sy0P+GT7i1E1WRko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468681; c=relaxed/simple;
	bh=J8ShEgPD3u5JUxAGaY5FJJm56eUXwdxTTWhmDz+TzCY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umHcHv+LJr3g3+pKGri/XqjczUpX2FF9nlMGmiAat1mjmXU0Drx8AVVMIGAEIymZG1xhr7MGXiM/z16sYtb306jzdjGEzDyO37weTUILLnUjOJZb8Vm/Xvx+nB9m5v0PelKapXPKWG/HFT++woAY7FJTZcOFZa5gF/mubjvnNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMTHHLCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B32C116D0;
	Thu,  6 Nov 2025 22:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468680;
	bh=J8ShEgPD3u5JUxAGaY5FJJm56eUXwdxTTWhmDz+TzCY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tMTHHLCEcKDSspgPS2V8pARTwjrBU9NYMc6VarR2lVrg+8zFXhi+FwKpONoMLkTOQ
	 yMpJ7FNUWcYKTDUQ9xu/QVNGvLQsuFqIdqcRySGr+L/6is7euJuNyv6BcDWDrOl0Jy
	 1+CZbx9jg2sDtyyDr5cQJ4guNhpISMENNzf8OFpJBFoBdD35FgZMa5m07eXiai4PPZ
	 tbtgaZaTO1tNxXC6qaaLZGReuxUI6dud/+EmTrux8M38/gederIaxMjb6Qqiw5XTg9
	 Hk0+Nt7PoUX8JzuOKGfiFz1ppOpnIl+ywPhdLmB7jnDzjH4338DMu1+qE+/Nq5/trR
	 smEuLoyOFGqbA==
Date: Thu, 06 Nov 2025 14:37:59 -0800
Subject: [PATCH 7/9] fuse2fs: clean up operation completion
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794291.2862990.6883410373261367333.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
References: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   75 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 33 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 3baeec67c2b4b7..77d0eddbe805dc 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -498,6 +498,15 @@ static inline ext2_filsys fuse2fs_start(struct fuse2fs *ff)
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
 #ifdef CONFIG_MMP
 static bool fuse2fs_mmp_wanted(const struct fuse2fs *ff)
 {
@@ -552,7 +561,7 @@ static void fuse2fs_mmp_bthread(void *data)
 	fuse2fs_start(ff);
 	if (fuse2fs_mmp_wanted(ff) && !bthread_cancelled(ff->mmp_thread))
 		fuse2fs_mmp_touch(ff, false);
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, 0);
 }
 
 static void fuse2fs_mmp_start(struct fuse2fs *ff)
@@ -1029,7 +1038,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		log_printf(ff, "%s %s.\n", _("unmounting filesystem"), uuid);
 	}
 
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, 0);
 }
 
 /* Reopen @stream with @fileno */
@@ -1325,7 +1334,7 @@ static int op_getattr(const char *path, struct stat *statbuf
 		goto out;
 	ret = stat_inode(fs, ino, statbuf);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -1398,7 +1407,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	}
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -1707,7 +1716,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 
 out2:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 out:
 	free(temp_path);
 	return ret;
@@ -1842,7 +1851,7 @@ static int op_mkdir(const char *path, mode_t mode)
 out3:
 	ext2fs_free_mem(&block);
 out2:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 out:
 	free(temp_path);
 	return ret;
@@ -2055,7 +2064,7 @@ static int op_unlink(const char *path)
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fuse2fs_start(ff);
 	ret = __op_unlink(ff, path);
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -2174,7 +2183,7 @@ static int op_rmdir(const char *path)
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fuse2fs_start(ff);
 	ret = __op_rmdir(ff, path);
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -2282,7 +2291,7 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 
 out2:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 out:
 	free(temp_path);
 	return ret;
@@ -2587,7 +2596,7 @@ static int op_rename(const char *from, const char *to
 	free(temp_from);
 	free(temp_to);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -2687,7 +2696,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 
 out2:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 out:
 	free(temp_path);
 	return ret;
@@ -2847,7 +2856,7 @@ static int op_chmod(const char *path, mode_t mode
 	}
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -2917,7 +2926,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	}
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -3020,7 +3029,7 @@ static int op_truncate(const char *path, off_t len
 		goto out;
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -3137,7 +3146,7 @@ static int op_open(const char *path, struct fuse_file_info *fp)
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fuse2fs_start(ff);
 	ret = __op_open(ff, path, fp);
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -3193,7 +3202,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 			goto out;
 	}
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return got ? (int) got : ret;
 }
 
@@ -3265,7 +3274,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return got ? (int) got : ret;
 }
 
@@ -3294,7 +3303,7 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	}
 
 	fp->fh = 0;
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	ext2fs_free_mem(&fh);
 
@@ -3323,7 +3332,7 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
 	}
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3372,7 +3381,7 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 	if (!(fs->flags & EXT2_FLAG_RW))
 		buf->f_flag |= ST_RDONLY;
 	buf->f_namemax = EXT2_NAME_LEN;
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, 0);
 
 	return 0;
 }
@@ -3446,7 +3455,7 @@ static int op_getxattr(const char *path, const char *key, char *value,
 
 	ext2fs_free_mem(&ptr);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3543,7 +3552,7 @@ static int op_listxattr(const char *path, char *names, size_t len)
 	if (err && !ret)
 		ret = translate_error(fs, ino, err);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3636,7 +3645,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 	if (!ret && err)
 		ret = translate_error(fs, ino, err);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3731,7 +3740,7 @@ static int op_removexattr(const char *path, const char *key)
 	if (err && !ret)
 		ret = translate_error(fs, ino, err);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -3868,7 +3877,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 			goto out;
 	}
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -3895,7 +3904,7 @@ static int op_access(const char *path, int mask)
 		goto out;
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -4023,7 +4032,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 
 out2:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 out:
 	free(temp_path);
 	return ret;
@@ -4078,7 +4087,7 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -4098,7 +4107,7 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	fs = fuse2fs_start(ff);
 	ret = stat_inode(fs, fh->ino, statbuf);
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -4171,7 +4180,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	}
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -4566,7 +4575,7 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 		dbg_printf(ff, "%s: Unknown ioctl %d\n", __func__, cmd);
 		ret = -ENOTTY;
 	}
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }
@@ -4598,7 +4607,7 @@ static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 	}
 
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 	return ret;
 }
 
@@ -4854,7 +4863,7 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 	else
 		ret = fuse2fs_allocate_range(ff, fh, mode, offset, len);
 out:
-	pthread_mutex_unlock(&ff->bfl);
+	fuse2fs_finish(ff, ret);
 
 	return ret;
 }


