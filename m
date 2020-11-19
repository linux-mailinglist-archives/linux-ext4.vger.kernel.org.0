Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D432B8B53
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Nov 2020 07:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKSGJP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Nov 2020 01:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgKSGJO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Nov 2020 01:09:14 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEEDC061A4A
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 22:09:13 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id p21so3178323pgb.11
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 22:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SLgs0iQsLlWyiqMNFAp8InT80xc0xnNJ/w2SdIsedrM=;
        b=lEc9IwJtnrFU+I4LOy2er5MPCDhqqE/c40hbLUsMFIYsdGfhSZpjSz4jC8JPbz3E9v
         /bQuOLrR5d32nLFwFisNqwWNSPWda2GLLfL/kV1xs2fOGOn2gDiYE+xd5hGEE+NiDtnC
         t0dZXN/ju8qMKRSLtfEPaak7bA5C+rrgRU83NhjMhWqGNClbhVau9HvTtPb+P2VznjXn
         2lpa/o7mvvE1LabacNKeqMTdgBO+s9ph9kugH1csugsZaiVgNUX9EBVt0ROQdAPlk4Rh
         vj1ZY7OlrIVrZ1eYVt3+Tj/wX1MOqVtyMhc5rh34E14ttvK4Lo8jYv24lj4vwWcA22ha
         a8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SLgs0iQsLlWyiqMNFAp8InT80xc0xnNJ/w2SdIsedrM=;
        b=gUFEbZHFVAMjDUd1r4+8+UV0x5PnDI4qSd1cCm30eQtndXToYKKsIclmVlOil0aurA
         oPhf4ecXR1r7NgkS2s1uLyIZXEHsN7V3iNgBHLMHmwwOaT9WMv3SfR3evAmmofBM4lpm
         cMapi2+60OzYU+JbGiZ8s9qedWAwr5OKXn2630RisAWLdr/EKWg1T4VY6KVqJA3AMJOe
         IZQQ/QMlmcDWtOr7RWbstxGITdeNvlDEsoE4himev29zYjmKmXTeHkm/bQ1qWXmDj+99
         kcb7qbH80ThxS9O2C5IX/GTg/qDWgbgmT+wqCw1l6uO4z2rmo/pyC5N/keqMnO/9xjGE
         KpdA==
X-Gm-Message-State: AOAM533S31rVzjkoc+8BR1OvURNwFy9DEvgIIRSESe/iqVK7J0TZm+Pb
        Ga6aF3kBP0I9wwJlwEPn6PFyLv++pks=
X-Google-Smtp-Source: ABdhPJyB7QPSPVEs1F2sx8O7KdJNLvoh03OdvLY+1uoa+NQsKLx7MvNb/Uqzugm43Q4OJhg0Fwc8eA2Whf0=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a63:cc07:: with SMTP id x7mr9267752pgf.209.1605766153372;
 Wed, 18 Nov 2020 22:09:13 -0800 (PST)
Date:   Thu, 19 Nov 2020 06:09:04 +0000
In-Reply-To: <20201119060904.463807-1-drosen@google.com>
Message-Id: <20201119060904.463807-4-drosen@google.com>
Mime-Version: 1.0
References: <20201119060904.463807-1-drosen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v4 3/3] f2fs: Handle casefolding with Encryption
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Expand f2fs's casefolding support to include encrypted directories.  To
index casefolded+encrypted directories, we use the SipHash of the
casefolded name, keyed by a key derived from the directory's fscrypt
master key.  This ensures that the dirhash doesn't leak information
about the plaintext filenames.

Encryption keys are unavailable during roll-forward recovery, so we
can't compute the dirhash when recovering a new dentry in an encrypted +
casefolded directory.  To avoid having to force a checkpoint when a new
file is fsync'ed, store the dirhash on-disk appended to i_name.

This patch incorporates work by Eric Biggers <ebiggers@google.com>
and Jaegeuk Kim <jaegeuk@kernel.org>.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Daniel Rosenberg <drosen@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/dir.c      | 98 +++++++++++++++++++++++++++++++++++-----------
 fs/f2fs/f2fs.h     |  8 ++--
 fs/f2fs/hash.c     | 11 +++++-
 fs/f2fs/inline.c   |  4 ++
 fs/f2fs/recovery.c | 12 +++++-
 fs/f2fs/super.c    |  6 ---
 6 files changed, 106 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 71fdf5076461..82b58d1f80eb 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
  */
+#include <asm/unaligned.h>
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
 #include <linux/sched/signal.h>
@@ -206,30 +207,55 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 /*
  * Test whether a case-insensitive directory entry matches the filename
  * being searched for.
+ *
+ * Returns 1 for a match, 0 for no match, and -errno on an error.
  */
-static bool f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
+static int f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
 			       const u8 *de_name, u32 de_name_len)
 {
 	const struct super_block *sb = dir->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
+	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
 	struct qstr entry = QSTR_INIT(de_name, de_name_len);
 	int res;
 
+	if (IS_ENCRYPTED(dir)) {
+		const struct fscrypt_str encrypted_name =
+			FSTR_INIT((u8 *)de_name, de_name_len);
+
+		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(dir)))
+			return -EINVAL;
+
+		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		if (!decrypted_name.name)
+			return -ENOMEM;
+		res = fscrypt_fname_disk_to_usr(dir, 0, 0, &encrypted_name,
+						&decrypted_name);
+		if (res < 0)
+			goto out;
+		entry.name = decrypted_name.name;
+		entry.len = decrypted_name.len;
+	}
+
 	res = utf8_strncasecmp_folded(um, name, &entry);
-	if (res < 0) {
-		/*
-		 * In strict mode, ignore invalid names.  In non-strict mode,
-		 * fall back to treating them as opaque byte sequences.
-		 */
-		if (sb_has_strict_encoding(sb) || name->len != entry.len)
-			return false;
-		return !memcmp(name->name, entry.name, name->len);
+	/*
+	 * In strict mode, ignore invalid names.  In non-strict mode,
+	 * fall back to treating them as opaque byte sequences.
+	 */
+	if (res < 0 && !sb_has_strict_encoding(sb)) {
+		res = name->len == entry.len &&
+				memcmp(name->name, entry.name, name->len) == 0;
+	} else {
+		/* utf8_strncasecmp_folded returns 0 on match */
+		res = (res == 0);
 	}
-	return res == 0;
+out:
+	kfree(decrypted_name.name);
+	return res;
 }
 #endif /* CONFIG_UNICODE */
 
-static inline bool f2fs_match_name(const struct inode *dir,
+static inline int f2fs_match_name(const struct inode *dir,
 				   const struct f2fs_filename *fname,
 				   const u8 *de_name, u32 de_name_len)
 {
@@ -256,6 +282,7 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
 	int max_len = 0;
+	int res = 0;
 
 	if (max_slots)
 		*max_slots = 0;
@@ -273,10 +300,15 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 			continue;
 		}
 
-		if (de->hash_code == fname->hash &&
-		    f2fs_match_name(d->inode, fname, d->filename[bit_pos],
-				    le16_to_cpu(de->name_len)))
-			goto found;
+		if (de->hash_code == fname->hash) {
+			res = f2fs_match_name(d->inode, fname,
+					      d->filename[bit_pos],
+					      le16_to_cpu(de->name_len));
+			if (res < 0)
+				return ERR_PTR(res);
+			if (res)
+				goto found;
+		}
 
 		if (max_slots && max_len > *max_slots)
 			*max_slots = max_len;
@@ -326,7 +358,11 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 		}
 
 		de = find_in_block(dir, dentry_page, fname, &max_slots);
-		if (de) {
+		if (IS_ERR(de)) {
+			*res_page = ERR_CAST(de);
+			de = NULL;
+			break;
+		} else if (de) {
 			*res_page = dentry_page;
 			break;
 		}
@@ -448,17 +484,39 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	f2fs_put_page(page, 1);
 }
 
-static void init_dent_inode(const struct f2fs_filename *fname,
+static void init_dent_inode(struct inode *dir, struct inode *inode,
+			    const struct f2fs_filename *fname,
 			    struct page *ipage)
 {
 	struct f2fs_inode *ri;
 
+	if (!fname) /* tmpfile case? */
+		return;
+
 	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 
 	/* copy name info. to this inode page */
 	ri = F2FS_INODE(ipage);
 	ri->i_namelen = cpu_to_le32(fname->disk_name.len);
 	memcpy(ri->i_name, fname->disk_name.name, fname->disk_name.len);
+	if (IS_ENCRYPTED(dir)) {
+		file_set_enc_name(inode);
+		/*
+		 * Roll-forward recovery doesn't have encryption keys available,
+		 * so it can't compute the dirhash for encrypted+casefolded
+		 * filenames.  Append it to i_name if possible.  Else, disable
+		 * roll-forward recovery of the dentry (i.e., make fsync'ing the
+		 * file force a checkpoint) by setting LOST_PINO.
+		 */
+		if (IS_CASEFOLDED(dir)) {
+			if (fname->disk_name.len + sizeof(f2fs_hash_t) <=
+			    F2FS_NAME_LEN)
+				put_unaligned(fname->hash, (f2fs_hash_t *)
+					&ri->i_name[fname->disk_name.len]);
+			else
+				file_lost_pino(inode);
+		}
+	}
 	set_page_dirty(ipage);
 }
 
@@ -541,11 +599,7 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
 			return page;
 	}
 
-	if (fname) {
-		init_dent_inode(fname, page);
-		if (IS_ENCRYPTED(dir))
-			file_set_enc_name(inode);
-	}
+	init_dent_inode(dir, inode, fname, page);
 
 	/*
 	 * This file should be checkpointed during fsync.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 62b4f31d30e2..878308736761 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -533,9 +533,11 @@ struct f2fs_filename {
 #ifdef CONFIG_UNICODE
 	/*
 	 * For casefolded directories: the casefolded name, but it's left NULL
-	 * if the original name is not valid Unicode or if the filesystem is
-	 * doing an internal operation where usr_fname is also NULL.  In these
-	 * cases we fall back to treating the name as an opaque byte sequence.
+	 * if the original name is not valid Unicode, if the directory is both
+	 * casefolded and encrypted and its encryption key is unavailable, or if
+	 * the filesystem is doing an internal operation where usr_fname is also
+	 * NULL.  In all these cases we fall back to treating the name as an
+	 * opaque byte sequence.
 	 */
 	struct fscrypt_str cf_name;
 #endif
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index de841aaf3c43..e3beac546c63 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -111,7 +111,9 @@ void f2fs_hash_filename(const struct inode *dir, struct f2fs_filename *fname)
 		 * If the casefolded name is provided, hash it instead of the
 		 * on-disk name.  If the casefolded name is *not* provided, that
 		 * should only be because the name wasn't valid Unicode, so fall
-		 * back to treating the name as an opaque byte sequence.
+		 * back to treating the name as an opaque byte sequence.  Note
+		 * that to handle encrypted directories, the fallback must use
+		 * usr_fname (plaintext) rather than disk_name (ciphertext).
 		 */
 		WARN_ON_ONCE(!fname->usr_fname->name);
 		if (fname->cf_name.name) {
@@ -121,6 +123,13 @@ void f2fs_hash_filename(const struct inode *dir, struct f2fs_filename *fname)
 			name = fname->usr_fname->name;
 			len = fname->usr_fname->len;
 		}
+		if (IS_ENCRYPTED(dir)) {
+			struct qstr tmp = QSTR_INIT(name, len);
+
+			fname->hash =
+				cpu_to_le32(fscrypt_fname_siphash(dir, &tmp));
+			return;
+		}
 	}
 #endif
 	fname->hash = cpu_to_le32(TEA_hash_name(name, len));
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 70384e31788d..92e9852d316a 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -332,6 +332,10 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
 	de = f2fs_find_target_dentry(&d, fname, NULL);
 	unlock_page(ipage);
+	if (IS_ERR(de)) {
+		*res_page = ERR_CAST(de);
+		de = NULL;
+	}
 	if (de)
 		*res_page = ipage;
 	else
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 4f12ade6410a..0947d36af1a8 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
  */
+#include <asm/unaligned.h>
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
 #include "f2fs.h"
@@ -128,7 +129,16 @@ static int init_recovered_filename(const struct inode *dir,
 	}
 
 	/* Compute the hash of the filename */
-	if (IS_CASEFOLDED(dir)) {
+	if (IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)) {
+		/*
+		 * In this case the hash isn't computable without the key, so it
+		 * was saved on-disk.
+		 */
+		if (fname->disk_name.len + sizeof(f2fs_hash_t) > F2FS_NAME_LEN)
+			return -EINVAL;
+		fname->hash = get_unaligned((f2fs_hash_t *)
+				&raw_inode->i_name[fname->disk_name.len]);
+	} else if (IS_CASEFOLDED(dir)) {
 		err = f2fs_init_casefolded_name(dir, fname);
 		if (err)
 			return err;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f51d52591c99..42293b7ceaf2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3399,12 +3399,6 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 		struct unicode_map *encoding;
 		__u16 encoding_flags;
 
-		if (f2fs_sb_has_encrypt(sbi)) {
-			f2fs_err(sbi,
-				"Can't mount with encoding and encryption");
-			return -EINVAL;
-		}
-
 		if (f2fs_sb_read_encoding(sbi->raw_super, &encoding_info,
 					  &encoding_flags)) {
 			f2fs_err(sbi,
-- 
2.29.2.454.gaff20da3a2-goog

