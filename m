Return-Path: <linux-ext4+bounces-7471-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA114A9BA09
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6AA16C144
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450F223DD7;
	Thu, 24 Apr 2025 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKeTEFtp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FA1F4297
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530910; cv=none; b=CknbnyxnQkS6rW5YORlXfj2EPrRhe19YEczjjhMufuvdTpxeiOT03tui1fMxrWUDteC6vI/ys/TF/RYmXiGsbAWZt3zHtD/YBynRdXKShbkWjgER9YsPfWoqZq/jR7J4H8+fH0desnb+JqL+NhQLPE3R+GPaM+5EqCEMPCamfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530910; c=relaxed/simple;
	bh=eeFN9BzuZlvUZE5pS6q0XdCN+Q53JkaU+InlCJNRRRE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GP+FCRjtmxfQuUKG3SvszWT8XHToXlqQWDjTZ6o0MHH8+3kXWdFF98lOxnUkC2Gm1tIVfqY5mdCH9vLZOYFJb9FmgMENpCiMPiFdB2+aL3/DjdZOutk6oZ2sV5Wqpd2QUtEYUYwAW9goRedVeAIyyCU6dtyhiH+awamoU9Cdzm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKeTEFtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21755C4CEE3;
	Thu, 24 Apr 2025 21:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530910;
	bh=eeFN9BzuZlvUZE5pS6q0XdCN+Q53JkaU+InlCJNRRRE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kKeTEFtpPl3kyPRLjviHyOGiircDA2+8sn48Xi1y/xxADCxZ/ywEPtf2hfSYNtOMa
	 dVIJVBqyEm6MKJQTVukIuSLgTA/wlAb0EcoZKK3uOf3FliANBEOJoB5n6r3l63Jy2g
	 Z2OtDzxYl13jzg43KVIDnjBgi3QYICkZlauSTHwZkYF1YHwt1DQ/SlqJ4TqyBkRuCy
	 1Hdse+c7mPKYbjh/6//sYaIo7sRevof59J19962yVt3+rheUAfzakHHHuPaFwgoIii
	 Q80qPt7g+PAMwwie3chAxZ7la18mhXDHVRMi/NEw/qd431+GGALHkQ/UulZNDlm3WT
	 bH4EchX6thuwg==
Date: Thu, 24 Apr 2025 14:41:49 -0700
Subject: [PATCH 04/16] fuse2fs: remove posix acl translation
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064997.1160461.14235157932332388225.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Remove the POSIX ACL format translation since libext2fs takes care of
that now.

Fixes: 0ee1eaf70c257e ("libext2fs: translate internal ext4 acl to Posix ACL in ext2fs_xattr_[sg]et()")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  267 +-------------------------------------------------------
 1 file changed, 4 insertions(+), 263 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4f3074261d0f53..5de6562ff97ecd 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -17,12 +17,6 @@
 # include <linux/fs.h>
 # include <linux/falloc.h>
 # include <linux/xattr.h>
-# ifdef HAVE_SYS_ACL_H
-#  define TRANSLATE_LINUX_ACLS
-# endif
-#endif
-#ifdef TRANSLATE_LINUX_ACLS
-# include <sys/acl.h>
 #endif
 #include <sys/ioctl.h>
 #include <unistd.h>
@@ -135,206 +129,6 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
 int journal_enable_debug = -1;
 #endif
 
-/* ACL translation stuff */
-#ifdef TRANSLATE_LINUX_ACLS
-/*
- * Copied from acl_ea.h in libacl source; ACLs have to be sent to and from fuse
- * in this format... at least on Linux.
- */
-#define ACL_EA_ACCESS		"system.posix_acl_access"
-#define ACL_EA_DEFAULT		"system.posix_acl_default"
-
-#define ACL_EA_VERSION		0x0002
-
-typedef struct {
-	u_int16_t	e_tag;
-	u_int16_t	e_perm;
-	u_int32_t	e_id;
-} acl_ea_entry;
-
-typedef struct {
-	u_int32_t	a_version;
-#if __GNUC_PREREQ (4, 8)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wpedantic"
-#endif
-	acl_ea_entry	a_entries[0];
-#if __GNUC_PREREQ (4, 8)
-#pragma GCC diagnostic pop
-#endif
-} acl_ea_header;
-
-static inline size_t acl_ea_size(int count)
-{
-	return sizeof(acl_ea_header) + count * sizeof(acl_ea_entry);
-}
-
-static inline int acl_ea_count(size_t size)
-{
-	if (size < sizeof(acl_ea_header))
-		return -1;
-	size -= sizeof(acl_ea_header);
-	if (size % sizeof(acl_ea_entry))
-		return -1;
-	return size / sizeof(acl_ea_entry);
-}
-
-/*
- * ext4 ACL structures, copied from fs/ext4/acl.h.
- */
-#define EXT4_ACL_VERSION	0x0001
-
-typedef struct {
-	__u16		e_tag;
-	__u16		e_perm;
-	__u32		e_id;
-} ext4_acl_entry;
-
-typedef struct {
-	__u16		e_tag;
-	__u16		e_perm;
-} ext4_acl_entry_short;
-
-typedef struct {
-	__u32		a_version;
-} ext4_acl_header;
-
-static inline size_t ext4_acl_size(int count)
-{
-	if (count <= 4) {
-		return sizeof(ext4_acl_header) +
-		       count * sizeof(ext4_acl_entry_short);
-	} else {
-		return sizeof(ext4_acl_header) +
-		       4 * sizeof(ext4_acl_entry_short) +
-		       (count - 4) * sizeof(ext4_acl_entry);
-	}
-}
-
-static inline int ext4_acl_count(size_t size)
-{
-	ssize_t s;
-
-	size -= sizeof(ext4_acl_header);
-	s = size - 4 * sizeof(ext4_acl_entry_short);
-	if (s < 0) {
-		if (size % sizeof(ext4_acl_entry_short))
-			return -1;
-		return size / sizeof(ext4_acl_entry_short);
-	}
-	if (s % sizeof(ext4_acl_entry))
-		return -1;
-	return s / sizeof(ext4_acl_entry) + 4;
-}
-
-static errcode_t fuse_to_ext4_acl(acl_ea_header *facl, size_t facl_sz,
-				  ext4_acl_header **eacl, size_t *eacl_sz)
-{
-	int i, facl_count;
-	ext4_acl_header *h;
-	size_t h_sz;
-	ext4_acl_entry *e;
-	acl_ea_entry *a;
-	unsigned char *hptr;
-	errcode_t err;
-
-	facl_count = acl_ea_count(facl_sz);
-	h_sz = ext4_acl_size(facl_count);
-	if (facl_count < 0 || facl->a_version != ACL_EA_VERSION)
-		return EXT2_ET_INVALID_ARGUMENT;
-
-	err = ext2fs_get_mem(h_sz, &h);
-	if (err)
-		return err;
-
-	h->a_version = ext2fs_cpu_to_le32(EXT4_ACL_VERSION);
-	hptr = (unsigned char *) (h + 1);
-	for (i = 0, a = facl->a_entries; i < facl_count; i++, a++) {
-		e = (ext4_acl_entry *) hptr;
-		e->e_tag = ext2fs_cpu_to_le16(a->e_tag);
-		e->e_perm = ext2fs_cpu_to_le16(a->e_perm);
-
-		switch (a->e_tag) {
-		case ACL_USER:
-		case ACL_GROUP:
-			e->e_id = ext2fs_cpu_to_le32(a->e_id);
-			hptr += sizeof(ext4_acl_entry);
-			break;
-		case ACL_USER_OBJ:
-		case ACL_GROUP_OBJ:
-		case ACL_MASK:
-		case ACL_OTHER:
-			hptr += sizeof(ext4_acl_entry_short);
-			break;
-		default:
-			err = EXT2_ET_INVALID_ARGUMENT;
-			goto out;
-		}
-	}
-
-	*eacl = h;
-	*eacl_sz = h_sz;
-	return err;
-out:
-	ext2fs_free_mem(&h);
-	return err;
-}
-
-static errcode_t ext4_to_fuse_acl(acl_ea_header **facl, size_t *facl_sz,
-				  ext4_acl_header *eacl, size_t eacl_sz)
-{
-	int i, eacl_count;
-	acl_ea_header *f;
-	ext4_acl_entry *e;
-	acl_ea_entry *a;
-	size_t f_sz;
-	unsigned char *hptr;
-	errcode_t err;
-
-	eacl_count = ext4_acl_count(eacl_sz);
-	f_sz = acl_ea_size(eacl_count);
-	if (eacl_count < 0 ||
-	    eacl->a_version != ext2fs_cpu_to_le32(EXT4_ACL_VERSION))
-		return EXT2_ET_INVALID_ARGUMENT;
-
-	err = ext2fs_get_mem(f_sz, &f);
-	if (err)
-		return err;
-
-	f->a_version = ACL_EA_VERSION;
-	hptr = (unsigned char *) (eacl + 1);
-	for (i = 0, a = f->a_entries; i < eacl_count; i++, a++) {
-		e = (ext4_acl_entry *) hptr;
-		a->e_tag = ext2fs_le16_to_cpu(e->e_tag);
-		a->e_perm = ext2fs_le16_to_cpu(e->e_perm);
-
-		switch (a->e_tag) {
-		case ACL_USER:
-		case ACL_GROUP:
-			a->e_id = ext2fs_le32_to_cpu(e->e_id);
-			hptr += sizeof(ext4_acl_entry);
-			break;
-		case ACL_USER_OBJ:
-		case ACL_GROUP_OBJ:
-		case ACL_MASK:
-		case ACL_OTHER:
-			hptr += sizeof(ext4_acl_entry_short);
-			break;
-		default:
-			err = EXT2_ET_INVALID_ARGUMENT;
-			goto out;
-		}
-	}
-
-	*facl = f;
-	*facl_sz = f_sz;
-	return err;
-out:
-	ext2fs_free_mem(&f);
-	return err;
-}
-#endif /* TRANSLATE_LINUX_ACLS */
-
 /*
  * ext2_file_t contains a struct inode, so we can't leave files open.
  * Use this as a proxy instead.
@@ -2451,30 +2245,6 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 	return 0;
 }
 
-typedef errcode_t (*xattr_xlate_get)(void **cooked_buf, size_t *cooked_sz,
-				     const void *raw_buf, size_t raw_sz);
-typedef errcode_t (*xattr_xlate_set)(const void *cooked_buf, size_t cooked_sz,
-				     const void **raw_buf, size_t *raw_sz);
-struct xattr_translate {
-	const char *prefix;
-	xattr_xlate_get get;
-	xattr_xlate_set set;
-};
-
-#define XATTR_TRANSLATOR(p, g, s) \
-	{.prefix = (p), \
-	 .get = (xattr_xlate_get)(g), \
-	 .set = (xattr_xlate_set)(s)}
-
-static struct xattr_translate xattr_translators[] = {
-#ifdef TRANSLATE_LINUX_ACLS
-	XATTR_TRANSLATOR(ACL_EA_ACCESS, ext4_to_fuse_acl, fuse_to_ext4_acl),
-	XATTR_TRANSLATOR(ACL_EA_DEFAULT, ext4_to_fuse_acl, fuse_to_ext4_acl),
-#endif
-	XATTR_TRANSLATOR(NULL, NULL, NULL),
-};
-#undef XATTR_TRANSLATOR
-
 static int op_getxattr(const char *path, const char *key, char *value,
 		       size_t len)
 {
@@ -2482,9 +2252,8 @@ static int op_getxattr(const char *path, const char *key, char *value,
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
-	struct xattr_translate *xt;
-	void *ptr, *cptr;
-	size_t plen, clen;
+	void *ptr;
+	size_t plen;
 	ext2_ino_t ino;
 	errcode_t err;
 	int ret = 0;
@@ -2526,17 +2295,6 @@ static int op_getxattr(const char *path, const char *key, char *value,
 		goto out2;
 	}
 
-	for (xt = xattr_translators; xt->prefix != NULL; xt++) {
-		if (strncmp(key, xt->prefix, strlen(xt->prefix)) == 0) {
-			err = xt->get(&cptr, &clen, ptr, plen);
-			if (err)
-				goto out3;
-			ext2fs_free_mem(&ptr);
-			ptr = cptr;
-			plen = clen;
-		}
-	}
-
 	if (!len) {
 		ret = plen;
 	} else if (len < plen) {
@@ -2546,7 +2304,6 @@ static int op_getxattr(const char *path, const char *key, char *value,
 		ret = plen;
 	}
 
-out3:
 	ext2fs_free_mem(&ptr);
 out2:
 	err = ext2fs_xattrs_close(&h);
@@ -2664,9 +2421,6 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
-	struct xattr_translate *xt;
-	const void *cvalue;
-	size_t clen;
 	ext2_ino_t ino;
 	errcode_t err;
 	int ret = 0;
@@ -2705,26 +2459,13 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		goto out2;
 	}
 
-	cvalue = value;
-	clen = len;
-	for (xt = xattr_translators; xt->prefix != NULL; xt++) {
-		if (strncmp(key, xt->prefix, strlen(xt->prefix)) == 0) {
-			err = xt->set(value, len, &cvalue, &clen);
-			if (err)
-				goto out3;
-		}
-	}
-
-	err = ext2fs_xattr_set(h, key, cvalue, clen);
+	err = ext2fs_xattr_set(h, key, value, len);
 	if (err) {
 		ret = translate_error(fs, ino, err);
-		goto out3;
+		goto out2;
 	}
 
 	ret = update_ctime(fs, ino, NULL);
-out3:
-	if (cvalue != value)
-		ext2fs_free_mem(&cvalue);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (!ret && err)


