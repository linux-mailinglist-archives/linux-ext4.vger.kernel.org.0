Return-Path: <linux-ext4+bounces-11492-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD0C35EEC
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 14:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45A718C7A38
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631B326D4F;
	Wed,  5 Nov 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6RjlWu4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B133254B0
	for <linux-ext4@vger.kernel.org>; Wed,  5 Nov 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350914; cv=none; b=CnN5/ZtZ3Q6AMUxLITe1/oXpfM40NZ1FHYDag2Dp15+t2jmxsV2Lw4ptwPQ+APKW0oUE+lJ906NAW18rlYh1piDKXEd7Dwp+JaZECoWSxqv1OICrmXRrDskZp/q/Owf6q7qO2SVBvJHzHZ6e5SxhYXjsRD77EpXsTuIj0R7m3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350914; c=relaxed/simple;
	bh=xOAkdwx5XMPuZBweonSMuobYigRFLMCprX2fUOYbHWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kssr2TMw8dY9rUaM/oi1NC4MX3zKsUNCXGybu0rhCyyI6fb5YYdKq0VHVeeRYKrzapMccwBNclPggCufNObc1bamhCfImWDwWoVYpYBwK9UyCGGzcV7cXc+8oQkMvo+h5+OfQhJh5//zUmGZQQxhQKbfgiz8FP2asCS/pVbZ244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6RjlWu4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47117f92e32so54256455e9.1
        for <linux-ext4@vger.kernel.org>; Wed, 05 Nov 2025 05:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762350910; x=1762955710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKxkYfDxy0NxD5aWbghbexk5V7RHrrReQ225T2JDBP0=;
        b=H6RjlWu4V15Cmhb4HdlaEGyPLHGQ+7c5808dkeB6fdPy3MK8TGCXen8JcxEN1fqj9f
         r9MxqMHHRhYlrjzA1ixVoJZBuNhR82vkVN7VR6LtOwQh7U71ud7uAQVqnydFOyN9g7eO
         6tRID8nXP5V1qZI8GF6rdVwwQReu3vDwUDN2HmA/oxBTAxVa/7PREWALRjj6M2U1qS2u
         wfwK62JQA/MKAHhyFMJFNrlk+TcHGrgWeH/Q9ZOvxpcgFawijw3abb13cDktbH8r0QhR
         ruvm2a0hO1lDftSbJ/wHPl7BDOm0HCHrvi6GzHn6HoXuqX+I36rJOhjQSz3jKiEZRJwV
         +tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350910; x=1762955710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKxkYfDxy0NxD5aWbghbexk5V7RHrrReQ225T2JDBP0=;
        b=jTIIfXzwnpS4uoPwRM0YYsjRbYdVf6z/yUgopZE1/5fSf30TMYL+t2qQ7ZUPXWpMne
         nVW5uC1eMk/FAk78HN3TQ0sUIvxCUSy9+h3dWjEAVff7Lj6v6RzZHg+d84ab6FEHt4Xz
         tPkxIdlvgFP7YhGyzFyxlUFITR1HyBaV7lCmE8oZdN+9wPhLNF0xVr4A0bPSBL2rY5uJ
         Wb6ABmdLmXs04Obp8T+6MqC3Psgs32rJIoDRnneDbYGmIU/SHBewJ28ugDB9imngviwh
         AcnQ1hoMLkyt7ZAL6ZJ5SPuBwcTTiMsedpnOetYr1jm3HiRCdXaTaUyWY/jAzo5f7/EF
         chkw==
X-Forwarded-Encrypted: i=1; AJvYcCVFBl9Pd/FZD7Y71Vylx1fEb72g9EPBuCbmhxE0AJiXHZXzxsLEqTm5mrJ7XN3qu/OoX/amxDAPQMoE@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMnxlhKitLwT7Y0h8P1aAd+lTnc9yNzrJUYICT4S2ZwHwNfAL
	zE8wjoJNI7Mf0VfNF4GrZc/nIq/LFii37OmR1tnL+nMfpGyAJ6XbQQHw
X-Gm-Gg: ASbGncs7tsPmTQc8URH2k/A77jC1YyZIyezo7TJjSWt2+F9smsOaIZTLFFIYdMFKWbs
	YJoixFl4WdUOKIzkEuH98DPzaELTzY3xNc8b+MpaTcSaUoEeCtuqUPj8KLo0gvBc1zy8MLgljin
	h07gJNdVaBMavv9i+q1+cIHZVpjD5aDctA6P2udrPOnJ1i9Xm0cdyoQ7mPs5B9ocGjLMeDQyEC4
	3F5BNRFtV5iPYj3ql/kih9PidqM3CFxr3v7HV9rjrkoBoV8ISU3ADjAGq08HnwZ9z6FQPIi2BVk
	4Vgr5VxiQP5fodr7k/1nryWNknXna+LIZwzC5//vXjb6PaurDSGgDRUURa05jtnn2XwpXBHKTy5
	AHQEVUbM5IJg/4hAV+pShsbHyNSHSebVlKccJ53mA3NQh0YqksRDIsV04HeaL9hkWgHT+XTfn5T
	PfNbsA9Df9eRegzU0G2BdDjFfvyrz+aeuXwefKuNagsYdqUviU
X-Google-Smtp-Source: AGHT+IFbrMOkwHlj7tzUq3CNHRE0pCkUygQWliDIrQ/V6eJXbLgxVBRh+H6LBamQYBVrY23ibi9f2w==
X-Received: by 2002:a05:600c:3ba0:b0:475:e007:baf1 with SMTP id 5b1f17b1804b1-4775ce207a3mr42747085e9.34.1762350910176;
        Wed, 05 Nov 2025 05:55:10 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc193e27sm10797646f8f.18.2025.11.05.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:55:09 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [WIP PATCH] fs: speed up path lookup with cheaper MAY_EXEC checks
Date: Wed,  5 Nov 2025 14:55:05 +0100
Message-ID: <20251105135505.751454-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WARNING:
This is not a real submission yet, will need to do more testing for
correctness.

Also I slapped ext4 support into this patch as opposed to posting it
separately. The no_acl caching was written by Linus, also see the
necroed thread here:
https://lore.kernel.org/linux-fsdevel/kn44smk4dgaj5rqmtcfr7ruecixzrik6omur2l2opitn7lbvfm@rm4y24fcfzbz/T/#m30d6cea6be48e95c0d824e98a328fb90c7a5766d
and full thread:
https://lore.kernel.org/linux-fsdevel/kn44smk4dgaj5rqmtcfr7ruecixzrik6omur2l2opitn7lbvfm@rm4y24fcfzbz/T/#t

Not pointing fingers, but someone promised to get that bit in. ;)

Now to business:

Vast majority of real-world traversals happen on directories which are
traversable by anyone. The patch below adds support for pre-computing
that state and branching on it during lookup, avoiding tons of work.

Stats from calls to security_inode_permission during kernel build:
missing: 6097127
present: 60579018

Or just above 90% of all lookups on my debian install benefited from it.

A simple microbench of stating /usr/include/linux/fs.h on ext4 in a loop
on Sapphire Rapids (ops/s):
before: 3640352
after:	3797258 (+4%)

Note the speed up would be higher if it was not for stat itself being
dog slow (to be addressed separately).

Filesystems interested in participating call
inode_enable_fast_may_exec() when instatianating an inode.

Explicit opt-in is necessary as some filesystems have custom inode
permission check hooks which happen to be of no significance for
MAY_EXEC. With an opt-in we now it can be safely ignored. Otherwise any
inode with such a func present would need to be excluded.

---
 fs/attr.c          |   1 +
 fs/ext4/inode.c    |   6 +++
 fs/ext4/namei.c    |   1 +
 fs/file_table.c    |  12 +++++
 fs/namei.c         | 106 +++++++++++++++++++++++++++++++++++++++++++--
 fs/posix_acl.c     |   1 +
 fs/xattr.c         |   1 +
 include/linux/fs.h |  20 ++++++---
 mm/shmem.c         |   2 +
 9 files changed, 141 insertions(+), 9 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 795f231d00e8..572363ff9c6d 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -549,6 +549,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
+		inode_recalc_fast_may_exec(inode);
 		security_inode_post_setattr(idmap, dentry, ia_valid);
 	}
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a163c0871373..ce2bfe3167e7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5519,6 +5519,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		goto bad_inode;
 	brelse(iloc.bh);
 
+	/* Initialize the "no ACL's" state for the simple cases */
+	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
+		cache_no_acl(inode);
+
+	inode_enable_fast_may_exec(inode);
+
 	unlock_new_inode(inode);
 	return inode;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2cd36f59c9e3..bedd9bfca440 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3042,6 +3042,7 @@ static struct dentry *ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	ext4_fc_track_create(handle, dentry);
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
+	inode_enable_fast_may_exec(inode);
 
 out_stop:
 	if (handle)
diff --git a/fs/file_table.c b/fs/file_table.c
index cd4a3db4659a..de1ef700d144 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -109,6 +109,8 @@ static int proc_nr_files(const struct ctl_table *table, int write, void *buffer,
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 
+unsigned long magic_tunable;
+
 static const struct ctl_table fs_stat_sysctls[] = {
 	{
 		.procname	= "file-nr",
@@ -126,6 +128,16 @@ static const struct ctl_table fs_stat_sysctls[] = {
 		.extra1		= SYSCTL_LONG_ZERO,
 		.extra2		= SYSCTL_LONG_MAX,
 	},
+	{
+		.procname	= "magic_tunable",
+		.data		= &magic_tunable,
+		.maxlen		= sizeof(magic_tunable),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= SYSCTL_LONG_ZERO,
+		.extra2		= SYSCTL_LONG_MAX,
+	},
+
 	{
 		.procname	= "nr_open",
 		.data		= &sysctl_nr_open,
diff --git a/fs/namei.c b/fs/namei.c
index 39c4d52f5b54..ac7252c0a428 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -123,6 +123,9 @@
  * PATH_MAX includes the nul terminator --RR.
  */
 
+static __always_inline int inode_permission_may_exec(struct mnt_idmap *idmap,
+		     struct inode *inode, int mask);
+
 #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
 
 static inline void initname(struct filename *name, const char __user *uptr)
@@ -574,7 +577,7 @@ int inode_permission(struct mnt_idmap *idmap,
 	if (unlikely(retval))
 		return retval;
 
-	if (unlikely(mask & MAY_WRITE)) {
+	if (mask & MAY_WRITE) {
 		/*
 		 * Nobody gets write access to an immutable file.
 		 */
@@ -601,6 +604,103 @@ int inode_permission(struct mnt_idmap *idmap,
 	return security_inode_permission(inode, mask);
 }
 EXPORT_SYMBOL(inode_permission);
+extern unsigned long magic_tunable;
+
+/**
+ * inode_permission_may_exec - Check traversal right for given inode
+ *
+ * This is a special case routine for may_lookup(). Use inode_permission()
+ * instead even if MAY_EXEC is the only thing you want to check for.
+ */
+static __always_inline int inode_permission_may_exec(struct mnt_idmap *idmap,
+	struct inode *inode, int mask)
+{
+	mask |= MAY_EXEC;
+
+#if 1
+	if (!magic_tunable || !(READ_ONCE(inode->i_opflags) & IOP_FAST_MAY_EXEC))
+		return inode_permission(idmap, inode, mask);
+#else
+	if (!(READ_ONCE(inode->i_opflags) & IOP_FAST_MAY_EXEC))
+		return inode_permission(idmap, inode, mask);
+#endif
+
+#ifdef CONFIG_DEBUG_VFS
+	/*
+	 * We expect everyone has the execute permission and that there are no
+	 * acls. We assert the filesystem at hand complies by validating it
+	 * below.
+	 *
+	 * However, We may be racing against setattr and/or setacl, in which case
+	 * we will have to redo the check with the appropriate lock held to avoid
+	 * false-positives.
+	 */
+	unsigned int mode = READ_ONCE(inode->i_mode);
+
+	VFS_BUG_ON_INODE(!S_ISDIR(mode), inode);
+	if (((mode & 0111) != 0111) || !no_acl_inode(inode)) {
+		/*
+		 * If we are in RCU mode may_lookup() will unlazy and try again.
+		 * Worst case if we are still racing the lock will be taken below.
+		 */
+		if (mask & MAY_NOT_BLOCK)
+			return -ECHILD;
+		inode_lock(inode);
+		if (inode->i_opflags & IOP_FAST_MAY_EXEC) {
+			VFS_BUG_ON_INODE((inode->i_mode & 0111) != 0111, inode);
+			VFS_BUG_ON_INODE(!no_acl_inode(inode), inode);
+		}
+		inode_unlock(inode);
+		return inode_permission(idmap, inode, mask);
+	}
+#endif
+	return security_inode_permission(inode, mask);
+}
+
+/**
+ * inode_recalc_fast_may_exec - recalc IOP_FAST_MAY_EXEC
+ * @inode: Inode to set/unset the bit on
+ *
+ * To be called if the fs considers the inode eligible for short-circuited
+ * permission checks.
+ */
+void inode_recalc_fast_may_exec(struct inode *inode)
+{
+	unsigned int mode;
+	bool wantbit = false;
+
+	if (!(inode_state_read(inode) & I_NEW))
+		lockdep_assert_held_write(inode->i_rwsem);
+
+	if (!(inode->i_flags & S_CAN_FAST_EXEC)) {
+		VFS_BUG_ON_INODE(inode->i_opflags & IOP_FAST_MAY_EXEC, inode);
+		return;
+	}
+
+	mode = inode->i_mode;
+	if (!S_ISDIR(mode)) {
+		VFS_BUG_ON_INODE(inode->i_opflags & IOP_FAST_MAY_EXEC, inode);
+		return;
+	}
+
+	if (((mode & 0111) == 0111) && no_acl_inode(inode))
+		wantbit = true;
+
+	if (wantbit) {
+		if (inode->i_opflags & IOP_FAST_MAY_EXEC)
+			return;
+		spin_lock(&inode->i_lock);
+		inode->i_opflags |= IOP_FAST_MAY_EXEC;
+		spin_unlock(&inode->i_lock);
+	} else {
+		if (!(inode->i_opflags & IOP_FAST_MAY_EXEC))
+			return;
+		spin_lock(&inode->i_lock);
+		inode->i_opflags &= ~IOP_FAST_MAY_EXEC;
+		spin_unlock(&inode->i_lock);
+	}
+}
+EXPORT_SYMBOL(inode_recalc_fast_may_exec);
 
 /**
  * path_get - get a reference to a path
@@ -1855,7 +1955,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
 	int err, mask;
 
 	mask = nd->flags & LOOKUP_RCU ? MAY_NOT_BLOCK : 0;
-	err = inode_permission(idmap, nd->inode, mask | MAY_EXEC);
+	err = inode_permission_may_exec(idmap, nd->inode, mask);
 	if (likely(!err))
 		return 0;
 
@@ -1870,7 +1970,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
 	if (err != -ECHILD)	// hard error
 		return err;
 
-	return inode_permission(idmap, nd->inode, MAY_EXEC);
+	return inode_permission_may_exec(idmap, nd->inode, 0);
 }
 
 static int reserve_stack(struct nameidata *nd, struct path *link)
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 4050942ab52f..da27dd536058 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1135,6 +1135,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		error = -EIO;
 	if (!error) {
 		fsnotify_xattr(dentry);
+		inode_recalc_fast_may_exec(inode);
 		security_inode_post_set_acl(dentry, acl_name, kacl);
 	}
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 8851a5ef34f5..917946a7f367 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -235,6 +235,7 @@ int __vfs_setxattr_noperm(struct mnt_idmap *idmap,
 				       size, flags);
 		if (!error) {
 			fsnotify_xattr(dentry);
+			inode_recalc_fast_may_exec(inode);
 			security_inode_post_setxattr(dentry, name, value,
 						     size, flags);
 		}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a8ffab9d4a64..41c855ef0594 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -659,13 +659,14 @@ is_uncached_acl(struct posix_acl *acl)
 	return (long)acl & 1;
 }
 
-#define IOP_FASTPERM	0x0001
-#define IOP_LOOKUP	0x0002
-#define IOP_NOFOLLOW	0x0004
-#define IOP_XATTR	0x0008
+#define IOP_FASTPERM		0x0001
+#define IOP_LOOKUP		0x0002
+#define IOP_NOFOLLOW		0x0004
+#define IOP_XATTR		0x0008
 #define IOP_DEFAULT_READLINK	0x0010
-#define IOP_MGTIME	0x0020
-#define IOP_CACHED_LINK	0x0040
+#define IOP_MGTIME		0x0020
+#define IOP_CACHED_LINK		0x0040
+#define IOP_FAST_MAY_EXEC	0x0080
 
 /*
  * Inode state bits.  Protected by inode->i_lock
@@ -2607,6 +2608,7 @@ struct super_operations {
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
 #define S_ANON_INODE	(1 << 19) /* Inode is an anonymous inode */
+#define S_CAN_FAST_EXEC	(1 << 20) /* Inode is eligible for IOP_FAST_MAY_EXEC */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -3395,6 +3397,12 @@ static inline int inode_init_always(struct super_block *sb, struct inode *inode)
 {
 	return inode_init_always_gfp(sb, inode, GFP_NOFS);
 }
+void inode_recalc_fast_may_exec(struct inode *);
+static inline void inode_enable_fast_may_exec(struct inode *inode)
+{
+	inode->i_flags |= S_CAN_FAST_EXEC;
+	inode_recalc_fast_may_exec(inode);
+}
 
 extern void inode_init_once(struct inode *);
 extern void address_space_init_once(struct address_space *mapping);
diff --git a/mm/shmem.c b/mm/shmem.c
index c819cecf1ed9..15d769882371 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3105,6 +3105,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 		break;
 	}
 
+	inode_recalc_fast_may_exec(inode);
+
 	lockdep_annotate_inode_mutex_key(inode);
 	return inode;
 }
-- 
2.48.1


