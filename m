Return-Path: <linux-ext4+bounces-8131-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71614AC0007
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12199E3A52
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690F82192E3;
	Wed, 21 May 2025 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJEe9HEo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0291EA65
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867712; cv=none; b=oBdUbH5ZqdGSq13uKl0TeP9LXJUGYyQdar69P2uFBw696jsDjSWuPoEWGnJh2c2qf67V4be1X/7g2hafB4fVQWxD78oDPGZxyZ3o+hYVEX6br9Wq6MhwiZzAP68oBDsGtOBwqHYFW+apQB11niVHlO62xmKCW2BSoPRGyw5m4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867712; c=relaxed/simple;
	bh=zXEwxfGalJKex3cqNkKEfIKMYsMVnUoJ/rA7PW7A24E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwaZGKrK5b0vmVUn6iyQm9YMSP4TPutNHuLvBAK0vpLfY+bwZbZtvmY4xXyZEX4rKymXdfFJhO+zFQGHguWavg+k/20BFr+wgTEmiHMvTjd0T1ei6q7O7U5DXUuyYxsSiEa1B8SAgntHJ+rNfW8FLYrEb98Kq48yl0WvvkRoNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJEe9HEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669EBC4CEE4;
	Wed, 21 May 2025 22:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867711;
	bh=zXEwxfGalJKex3cqNkKEfIKMYsMVnUoJ/rA7PW7A24E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MJEe9HEouoC8YLBCDsJMhV/NvNEIKCuHgmn8zNggUFtcmVmZFrEhyToskh82CczW0
	 pe5VEj+9GGtQ89bHK3B+ff8SDJQr2esD1bAxnI8ijK/LetP0VX6Q3S8kvjGRnz2gcM
	 6ns0sprQdkECLHa99/ifMv+vOpXHSPPt2aE3XN70gXgBc+rXohBz44eLtD7nT+/MXW
	 SFZ4rOdXjB1XVvYothBzmeOkqtK2hwnle5HoousIc/3/QRq/kSh4y0Knbasyfj+Y2/
	 m/PhkZJBVSa9p5HhoaMUoNcL3hjjKncXEPjttIqPSED2Ldt31do/Wx4gIdclHm5TcJ
	 vXxQi2JbvS0cQ==
Date: Wed, 21 May 2025 15:48:30 -0700
Subject: [PATCH 3/4] fuse2fs: log all errors being sent to libfuse
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786679059.1385778.4497680668615630766.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678990.1385778.5352134289344525189.stgit@frogsfrogsfrogs>
References: <174786678990.1385778.5352134289344525189.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Whenever a filesystem operation is going to return a negative errno to
libfuse, log the errno if debugging is enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index d78ab5558b6182..fa7618adef48d1 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1132,6 +1132,8 @@ static int op_getattr(const char *path, struct stat *statbuf
 		goto out;
 	ret = stat_inode(fs, ino, statbuf);
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -1208,6 +1210,8 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	}
 
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -1448,6 +1452,8 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	if (ret)
 		goto out2;
 out2:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 out:
 	free(temp_path);
@@ -1592,6 +1598,8 @@ static int op_mkdir(const char *path, mode_t mode)
 out3:
 	ext2fs_free_mem(&block);
 out2:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 out:
 	free(temp_path);
@@ -1781,6 +1789,8 @@ static int op_unlink(const char *path)
 	FUSE2FS_CHECK_CONTEXT(ff);
 	pthread_mutex_lock(&ff->bfl);
 	ret = __op_unlink(ff, path);
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -1908,6 +1918,8 @@ static int op_rmdir(const char *path)
 	FUSE2FS_CHECK_CONTEXT(ff);
 	pthread_mutex_lock(&ff->bfl);
 	ret = __op_rmdir(ff, path);
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -2006,6 +2018,8 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 	}
 out2:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 out:
 	free(temp_path);
@@ -2278,6 +2292,8 @@ static int op_rename(const char *from, const char *to
 	free(temp_from);
 	free(temp_to);
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -2387,6 +2403,8 @@ static int op_link(const char *src, const char *dest)
 	}
 
 out2:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 out:
 	free(temp_path);
@@ -2525,6 +2543,8 @@ static int op_chmod(const char *path, mode_t mode
 	}
 
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -2598,6 +2618,8 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	}
 
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -2696,6 +2718,8 @@ static int op_truncate(const char *path, off_t len
 		goto out;
 
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -2813,6 +2837,8 @@ static int op_open(const char *path, struct fuse_file_info *fp)
 	FUSE2FS_CHECK_CONTEXT(ff);
 	pthread_mutex_lock(&ff->bfl);
 	ret = __op_open(ff, path, fp);
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -2870,6 +2896,8 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 			goto out;
 	}
 out:
+	if (!got && ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return got ? (int) got : ret;
 }
@@ -2943,6 +2971,8 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 
 out:
+	if (!got && ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return got ? (int) got : ret;
 }
@@ -2973,6 +3003,8 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	}
 
 	fp->fh = 0;
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 
 	ext2fs_free_mem(&fh);
@@ -3003,6 +3035,8 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
 	}
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 
 	return ret;
@@ -3126,6 +3160,8 @@ static int op_getxattr(const char *path, const char *key, char *value,
 
 	ext2fs_free_mem(&ptr);
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 
 	return ret;
@@ -3224,6 +3260,8 @@ static int op_listxattr(const char *path, char *names, size_t len)
 	if (err && !ret)
 		ret = translate_error(fs, ino, err);
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 
 	return ret;
@@ -3318,6 +3356,8 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 	if (!ret && err)
 		ret = translate_error(fs, ino, err);
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 
 	return ret;
@@ -3414,6 +3454,8 @@ static int op_removexattr(const char *path, const char *key)
 	if (err && !ret)
 		ret = translate_error(fs, ino, err);
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 
 	return ret;
@@ -3552,6 +3594,8 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 			goto out;
 	}
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -3580,6 +3624,8 @@ static int op_access(const char *path, int mask)
 		goto out;
 
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -3706,6 +3752,8 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	if (ret)
 		goto out2;
 out2:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 out:
 	free(temp_path);
@@ -3761,6 +3809,8 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -3782,6 +3832,8 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	pthread_mutex_lock(&ff->bfl);
 	ret = stat_inode(fs, fh->ino, statbuf);
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 
 	return ret;
@@ -3856,6 +3908,8 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	}
 
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -4206,6 +4260,8 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 		dbg_printf(ff, "%s: Unknown ioctl %d\n", __func__, cmd);
 		ret = -ENOTTY;
 	}
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 
 	return ret;
@@ -4239,6 +4295,8 @@ static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 	}
 
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
 }
@@ -4481,6 +4539,8 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 	else
 		ret = fallocate_helper(fp, mode, offset, len);
 out:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 
 	return ret;


