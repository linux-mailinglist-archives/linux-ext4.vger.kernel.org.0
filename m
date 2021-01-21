Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15592FEEEB
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 16:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbhAUNWK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 08:22:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53815 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbhAUNV0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 08:21:26 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2Zt6-0005g7-BI; Thu, 21 Jan 2021 13:20:36 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v6 04/40] capability: handle idmapped mounts
Date:   Thu, 21 Jan 2021 14:19:23 +0100
Message-Id: <20210121131959.646623-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=ePMljlU6SgOW2CsGAJQU42bgWmfl/2527kQxnJ4/OsA=; m=uZrGytpJK66vmcdQIAh4cQdVJC13QtEwI23m6gY7HP0=; p=6gsyRJF9Cy+pgOpvfHsdU+9ldB5Vob1j3CDvrGaQbz4=; g=dc88c5c3ca2aa4fedbfca69f25f903ea5e4373f7
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9owAKCRCRxhvAZXjcoh1WAP4vJLa HkhHZNwp7eLXt0Xqy0n3knklgTzgBa1xAE/mhUAEAhA7WVoNwiY7xYMqlb29ha7Iy6LdtwwZPwqQw 1zu/LAA=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In order to determine whether a caller holds privilege over a given
inode the capability framework exposes the two helpers
privileged_wrt_inode_uidgid() and capable_wrt_inode_uidgid(). The former
verifies that the inode has a mapping in the caller's user namespace and
the latter additionally verifies that the caller has the requested
capability in their current user namespace.
If the inode is accessed through an idmapped mount map it into the
mount's user namespace. Afterwards the checks are identical to
non-idmapped inodes. If the initial user namespace is passed all
operations are a nop so non-idmapped mounts will not see a change in
behavior.

Link: https://lore.kernel.org/r/20210112220124.837960-11-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Don't pollute the vfs with additional helpers simply extend the existing
    helpers with an additional argument and switch all callers.

/* v3 */
unchanged

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
base-commit: 19c329f6808995b142b3966301f217c831e7cf31

- Christoph Hellwig <hch@lst.de>:
  - Remove "extern" from headers.
  - Wrap lines over 80 chars.
---
 fs/attr.c                  |  8 ++++----
 fs/exec.c                  |  3 ++-
 fs/inode.c                 |  3 ++-
 fs/namei.c                 | 13 ++++++++-----
 fs/overlayfs/super.c       |  2 +-
 fs/posix_acl.c             |  2 +-
 fs/xfs/xfs_ioctl.c         |  2 +-
 include/linux/capability.h |  7 +++++--
 kernel/capability.c        | 14 +++++++++-----
 security/commoncap.c       |  5 +++--
 10 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index b4bbdbd4c8ca..d270f640a192 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -23,7 +23,7 @@ static bool chown_ok(const struct inode *inode, kuid_t uid)
 	if (uid_eq(current_fsuid(), inode->i_uid) &&
 	    uid_eq(uid, inode->i_uid))
 		return true;
-	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+	if (capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_CHOWN))
 		return true;
 	if (uid_eq(inode->i_uid, INVALID_UID) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
@@ -36,7 +36,7 @@ static bool chgrp_ok(const struct inode *inode, kgid_t gid)
 	if (uid_eq(current_fsuid(), inode->i_uid) &&
 	    (in_group_p(gid) || gid_eq(gid, inode->i_gid)))
 		return true;
-	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+	if (capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_CHOWN))
 		return true;
 	if (gid_eq(inode->i_gid, INVALID_GID) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
@@ -92,7 +92,7 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 		/* Also check the setgid bit! */
 		if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
 				inode->i_gid) &&
-		    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
+		    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
 			attr->ia_mode &= ~S_ISGID;
 	}
 
@@ -193,7 +193,7 @@ void setattr_copy(struct inode *inode, const struct iattr *attr)
 		umode_t mode = attr->ia_mode;
 
 		if (!in_group_p(inode->i_gid) &&
-		    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
+		    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
 	}
diff --git a/fs/exec.c b/fs/exec.c
index 5d4d52039105..89d4780ff48f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1411,7 +1411,8 @@ void would_dump(struct linux_binprm *bprm, struct file *file)
 		/* Ensure mm->user_ns contains the executable */
 		user_ns = old = bprm->mm->user_ns;
 		while ((user_ns != &init_user_ns) &&
-		       !privileged_wrt_inode_uidgid(user_ns, inode))
+		       !privileged_wrt_inode_uidgid(user_ns, &init_user_ns,
+						    inode))
 			user_ns = user_ns->parent;
 
 		if (old != user_ns) {
diff --git a/fs/inode.c b/fs/inode.c
index 6442d97d9a4a..cd40cbf87ce4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2146,7 +2146,8 @@ void inode_init_owner(struct inode *inode, const struct inode *dir,
 			mode |= S_ISGID;
 		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
 			 !in_group_p(inode->i_gid) &&
-			 !capable_wrt_inode_uidgid(dir, CAP_FSETID))
+			 !capable_wrt_inode_uidgid(&init_user_ns, dir,
+						   CAP_FSETID))
 			mode &= ~S_ISGID;
 	} else
 		inode->i_gid = current_fsgid();
diff --git a/fs/namei.c b/fs/namei.c
index 78443a85480a..fd4724bce4f5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -357,10 +357,11 @@ int generic_permission(struct inode *inode, int mask)
 	if (S_ISDIR(inode->i_mode)) {
 		/* DACs are overridable for directories */
 		if (!(mask & MAY_WRITE))
-			if (capable_wrt_inode_uidgid(inode,
+			if (capable_wrt_inode_uidgid(&init_user_ns, inode,
 						     CAP_DAC_READ_SEARCH))
 				return 0;
-		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
+		if (capable_wrt_inode_uidgid(&init_user_ns, inode,
+					     CAP_DAC_OVERRIDE))
 			return 0;
 		return -EACCES;
 	}
@@ -370,7 +371,8 @@ int generic_permission(struct inode *inode, int mask)
 	 */
 	mask &= MAY_READ | MAY_WRITE | MAY_EXEC;
 	if (mask == MAY_READ)
-		if (capable_wrt_inode_uidgid(inode, CAP_DAC_READ_SEARCH))
+		if (capable_wrt_inode_uidgid(&init_user_ns, inode,
+					     CAP_DAC_READ_SEARCH))
 			return 0;
 	/*
 	 * Read/write DACs are always overridable.
@@ -378,7 +380,8 @@ int generic_permission(struct inode *inode, int mask)
 	 * at least one exec bit set.
 	 */
 	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
-		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
+		if (capable_wrt_inode_uidgid(&init_user_ns, inode,
+					     CAP_DAC_OVERRIDE))
 			return 0;
 
 	return -EACCES;
@@ -2659,7 +2662,7 @@ int __check_sticky(struct inode *dir, struct inode *inode)
 		return 0;
 	if (uid_eq(dir->i_uid, fsuid))
 		return 0;
-	return !capable_wrt_inode_uidgid(inode, CAP_FOWNER);
+	return !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FOWNER);
 }
 EXPORT_SYMBOL(__check_sticky);
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 2bd570cbe8a4..88d877787770 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1017,7 +1017,7 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 	if (unlikely(inode->i_mode & S_ISGID) &&
 	    handler->flags == ACL_TYPE_ACCESS &&
 	    !in_group_p(inode->i_gid) &&
-	    !capable_wrt_inode_uidgid(inode, CAP_FSETID)) {
+	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID)) {
 		struct iattr iattr = { .ia_valid = ATTR_KILL_SGID };
 
 		err = ovl_setattr(dentry, &iattr);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 95882b3f5f62..4ca6d53c6f0a 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -656,7 +656,7 @@ int posix_acl_update_mode(struct inode *inode, umode_t *mode_p,
 	if (error == 0)
 		*acl = NULL;
 	if (!in_group_p(inode->i_gid) &&
-	    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
+	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
 	return 0;
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 3fbd98f61ea5..97bd29fc8c43 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1502,7 +1502,7 @@ xfs_ioctl_setattr(
 	 */
 
 	if ((VFS_I(ip)->i_mode & (S_ISUID|S_ISGID)) &&
-	    !capable_wrt_inode_uidgid(VFS_I(ip), CAP_FSETID))
+	    !capable_wrt_inode_uidgid(&init_user_ns, VFS_I(ip), CAP_FSETID))
 		VFS_I(ip)->i_mode &= ~(S_ISUID|S_ISGID);
 
 	/* Change the ownerships and register project quota modifications */
diff --git a/include/linux/capability.h b/include/linux/capability.h
index b2f698915c0f..62bfa3ed84d7 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -247,8 +247,11 @@ static inline bool ns_capable_setid(struct user_namespace *ns, int cap)
 	return true;
 }
 #endif /* CONFIG_MULTIUSER */
-extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *inode);
-extern bool capable_wrt_inode_uidgid(const struct inode *inode, int cap);
+bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
+				 struct user_namespace *mnt_userns,
+				 const struct inode *inode);
+bool capable_wrt_inode_uidgid(struct user_namespace *mnt_userns,
+			      const struct inode *inode, int cap);
 extern bool file_ns_capable(const struct file *file, struct user_namespace *ns, int cap);
 extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
 static inline bool perfmon_capable(void)
diff --git a/kernel/capability.c b/kernel/capability.c
index de7eac903a2a..46a361dde042 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -484,10 +484,12 @@ EXPORT_SYMBOL(file_ns_capable);
  *
  * Return true if the inode uid and gid are within the namespace.
  */
-bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *inode)
+bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
+				 struct user_namespace *mnt_userns,
+				 const struct inode *inode)
 {
-	return kuid_has_mapping(ns, inode->i_uid) &&
-		kgid_has_mapping(ns, inode->i_gid);
+	return kuid_has_mapping(ns, i_uid_into_mnt(mnt_userns, inode)) &&
+	       kgid_has_mapping(ns, i_gid_into_mnt(mnt_userns, inode));
 }
 
 /**
@@ -499,11 +501,13 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *
  * its own user namespace and that the given inode's uid and gid are
  * mapped into the current user namespace.
  */
-bool capable_wrt_inode_uidgid(const struct inode *inode, int cap)
+bool capable_wrt_inode_uidgid(struct user_namespace *mnt_userns,
+			      const struct inode *inode, int cap)
 {
 	struct user_namespace *ns = current_user_ns();
 
-	return ns_capable(ns, cap) && privileged_wrt_inode_uidgid(ns, inode);
+	return ns_capable(ns, cap) &&
+	       privileged_wrt_inode_uidgid(ns, mnt_userns, inode);
 }
 EXPORT_SYMBOL(capable_wrt_inode_uidgid);
 
diff --git a/security/commoncap.c b/security/commoncap.c
index bacc1111d871..88ee345f7bfa 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -489,7 +489,7 @@ int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size)
 		return -EINVAL;
 	if (!validheader(size, cap))
 		return -EINVAL;
-	if (!capable_wrt_inode_uidgid(inode, CAP_SETFCAP))
+	if (!capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_SETFCAP))
 		return -EPERM;
 	if (size == XATTR_CAPS_SZ_2)
 		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
@@ -956,7 +956,8 @@ int cap_inode_removexattr(struct dentry *dentry, const char *name)
 		struct inode *inode = d_backing_inode(dentry);
 		if (!inode)
 			return -EINVAL;
-		if (!capable_wrt_inode_uidgid(inode, CAP_SETFCAP))
+		if (!capable_wrt_inode_uidgid(&init_user_ns, inode,
+					      CAP_SETFCAP))
 			return -EPERM;
 		return 0;
 	}
-- 
2.30.0

