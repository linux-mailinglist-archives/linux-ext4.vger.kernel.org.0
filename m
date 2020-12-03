Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B41C2CE362
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 01:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgLDACP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 19:02:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41702 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387439AbgLDACO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 19:02:14 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkyXM-0007ka-VU; Fri, 04 Dec 2020 00:01:25 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
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
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 06/40] fs: add mount_setattr()
Date:   Fri,  4 Dec 2020 00:57:02 +0100
Message-Id: <20201203235736.3528991-7-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This implements the missing mount_setattr() syscall. While the new mount
api allows to change the properties of a superblock there is currently
no way to change the properties of a mount or a mount tree using file
descriptors which the new mount api is based on. In addition the old
mount api has the restriction that mount options cannot be applied
recursively. This hasn't changed since changing mount options on a
per-mount basis was implemented in [1] and has been a frequent request
not just for convenience but also for security reasons. The legacy
mount syscall is unable to accommodate this behavior without introducing
a whole new set of flags because MS_REC | MS_REMOUNT | MS_BIND |
MS_RDONLY | MS_NOEXEC | [...] only apply the mount option to the topmost
mount. Changing MS_REC to apply to the whole mount tree would mean
introducing a significant uapi change and would likely cause significant
regressions.

The new mount_setattr() syscall allows to recursively clear and set
mount options in one shot. Multiple calls to change mount options
requesting the same changes are idempotent:

int mount_setattr(int dfd, const char *path, unsigned flags,
                  struct mount_attr *uattr, size_t usize);

Flags to modify path resolution behavior are specified in the @flags
argument. Currently, AT_EMPTY_PATH, AT_RECURSIVE, AT_SYMLINK_NOFOLLOW,
and AT_NO_AUTOMOUNT are supported. If useful, additional lookup flags to
restrict path resolution as introduced with openat2() might be supported
in the future.

The mount_setattr() syscall can be expected to grow over time and is
designed with extensibility in mind. It follows the extensible syscall
pattern we have used with other syscalls such as openat2(), clone3(),
sched_{set,get}attr(), and others.
The set of mount options is passed in the uapi struct mount_attr which
currently has the following layout:

struct mount_attr {
	__u64 attr_set;
	__u64 attr_clr;
	__u32 propagation;
};

The @attr_set and @attr_clr members are used to clear and set mount
options. This way a user can e.g. request that a set of flags is to be
raised such as turning mounts readonly by raising MOUNT_ATTR_RDONLY in
@attr_set while at the same time requesting that another set of flags is
to be lowered such as removing noexec from a mount tree by specifying
MOUNT_ATTR_NOEXEC in @attr_clr.

Note, since the MOUNT_ATTR_<atime> values are an enum starting from 0,
not a bitmap, users wanting to transition to a different atime setting
cannot simply specify the atime setting in @attr_set, but must also
specify MOUNT_ATTR__ATIME in the @attr_clr field. So we ensure that
MOUNT_ATTR__ATIME can't be partially set in @attr_clr and that @attr_set
can't have any atime bits set if MOUNT_ATTR__ATIME isn't set in
@attr_clr.

The @propagation field lets callers specify the propagation type of a
mount tree. Propagation is a single property that has four different
settings and as such is not really a flag argument but an enum.
Specifically, it would be unclear what setting and clearing propagation
settings in combination would amount to. The legacy mount() syscall thus
forbids the combination of multiple propagation settings too. The goal
is to keep the semantics of mount propagation somewhat simple as they
are overly complex as it is.

[1]: commit 2e4b7fcd9260 ("[PATCH] r/o bind mounts: honor mount writer counts at remount")
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Split into multiple helpers.

/* v3 */
- kernel test robot <lkp@intel.com>:
  - Fix unknown __u64 type by including linux/types.h in linux/mount.h.

/* v4 */
- Christoph Hellwig <hch@lst.de>:
  - Make sure lines wrap at 80 chars.
  - Move struct mount_kattr out of the internal.h header and completely
    into fs/namespace.c as it's not used outside of that file.
  - Add missing space between ( and { when initializing mount_kattr.
  - Split flag validation and calculation into separate preparatory
    patch.
  - Simplify flag validation in build_mount_kattr() to avoid
    upper_32_bits() and lower_32_bits() calls. This will also lead to
    better code generation.
  - Remove new propagation enums and simply use the old flags.
  - Strictly adhere to 80 char limit.
  - Restructure the time setting code in build_mount_kattr().
---
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/namespace.c                              | 271 ++++++++++++++++++++
 include/linux/syscalls.h                    |   3 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/mount.h                  |  14 +
 tools/include/uapi/asm-generic/unistd.h     |   4 +-
 22 files changed, 312 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index ee7b01bb7346..24d8709624b8 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -480,3 +480,4 @@
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	faccessat2			sys_faccessat2
 550	common	process_madvise			sys_process_madvise
+551	common	mount_setattr			sys_mount_setattr
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index d056a548358e..e3785513d445 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -454,3 +454,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mount_setattr			sys_mount_setattr
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 107f08e03b9f..78af754e070a 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -889,6 +889,8 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_process_madvise 440
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
+#define __NR_mount_setattr 441
+__SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index b96ed8b8a508..f7d4b1f55be0 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -361,3 +361,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mount_setattr			sys_mount_setattr
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 625fb6d32842..e96e9c6a6ffa 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mount_setattr			sys_mount_setattr
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index aae729c95cf9..6538f075a18e 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -446,3 +446,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mount_setattr			sys_mount_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 32817c954435..64d129db1aa7 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -379,3 +379,4 @@
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	faccessat2			sys_faccessat2
 440	n32	process_madvise			sys_process_madvise
+441	n32	mount_setattr			sys_mount_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 9e4ea3c31b1c..94b24e6b2608 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -355,3 +355,4 @@
 438	n64	pidfd_getfd			sys_pidfd_getfd
 439	n64	faccessat2			sys_faccessat2
 440	n64	process_madvise			sys_process_madvise
+441	n64	mount_setattr			sys_mount_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 29f5f28cf5ce..eae522306767 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -428,3 +428,4 @@
 438	o32	pidfd_getfd			sys_pidfd_getfd
 439	o32	faccessat2			sys_faccessat2
 440	o32	process_madvise			sys_process_madvise
+441	o32	mount_setattr			sys_mount_setattr
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index f375ea528e59..c7e25f1d219f 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mount_setattr			sys_mount_setattr
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 1275daec7fec..0b309ef64e91 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -530,3 +530,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mount_setattr			sys_mount_setattr
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 28c168000483..0b30398fee42 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -443,3 +443,4 @@
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
+441  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 783738448ff5..8e4949c5b740 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -443,3 +443,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mount_setattr			sys_mount_setattr
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 78160260991b..409f21a650b8 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -486,3 +486,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mount_setattr			sys_mount_setattr
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0d0667a9fbd7..2a694420f6cd 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -445,3 +445,4 @@
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
 440	i386	process_madvise		sys_process_madvise
+441	i386	mount_setattr		sys_mount_setattr
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 379819244b91..4d594d0246c1 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -362,6 +362,7 @@
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
 440	common	process_madvise		sys_process_madvise
+441	common	mount_setattr		sys_mount_setattr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index b070f272995d..a650dc05593d 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -411,3 +411,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mount_setattr			sys_mount_setattr
diff --git a/fs/namespace.c b/fs/namespace.c
index b2a9eb7b43d3..51cfacfb3f82 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -73,6 +73,14 @@ static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 
+struct mount_kattr {
+	unsigned int attr_set;
+	unsigned int attr_clr;
+	unsigned int propagation;
+	unsigned int lookup_flags;
+	bool recurse;
+};
+
 /* /sys/fs */
 struct kobject *fs_kobj;
 EXPORT_SYMBOL_GPL(fs_kobj);
@@ -3454,6 +3462,8 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV |            \
 	 MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME | MOUNT_ATTR_NODIRATIME)
 
+#define MOUNT_SETATTR_VALID_FLAGS FSMOUNT_VALID_FLAGS
+
 static unsigned int attr_flags_to_mnt_flags(u64 attr_flags)
 {
 	unsigned int mnt_flags = 0;
@@ -3805,6 +3815,267 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	return error;
 }
 
+static unsigned int recalc_flags(struct mount_kattr *kattr, struct mount *mnt)
+{
+	unsigned int flags = mnt->mnt.mnt_flags;
+
+	/*  flags to clear */
+	flags &= ~kattr->attr_clr;
+	/* flags to raise */
+	flags |= kattr->attr_set;
+
+	return flags;
+}
+
+static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
+					   struct mount *mnt, int *err)
+{
+	struct mount *m = mnt, *last = NULL;
+
+	if (!is_mounted(&m->mnt)) {
+		*err = -EINVAL;
+		goto out;
+	}
+
+	if (!(mnt_has_parent(m) ? check_mnt(m) : is_anon_ns(m->mnt_ns))) {
+		*err = -EINVAL;
+		goto out;
+	}
+
+	do {
+		unsigned int flags;
+
+		flags = recalc_flags(kattr, m);
+		if (!can_change_locked_flags(m, flags)) {
+			*err = -EPERM;
+			goto out;
+		}
+
+		last = m;
+
+		if ((kattr->attr_set & MNT_READONLY) &&
+		    !(m->mnt.mnt_flags & MNT_READONLY)) {
+			*err = mnt_hold_writers(m);
+			if (*err)
+				goto out;
+		}
+	} while (kattr->recurse && (m = next_mnt(m, mnt)));
+
+out:
+	return last;
+}
+
+static void mount_setattr_commit(struct mount_kattr *kattr,
+				 struct mount *mnt, struct mount *last,
+				 int err)
+{
+	struct mount *m = mnt;
+
+	do {
+		if (!err) {
+			unsigned int flags;
+
+			flags = recalc_flags(kattr, m);
+			WRITE_ONCE(m->mnt.mnt_flags, flags);
+		}
+
+		/*
+		 * We either set MNT_READONLY above so make it visible
+		 * before ~MNT_WRITE_HOLD or we failed to recursively
+		 * apply mount options.
+		 */
+		if ((kattr->attr_set & MNT_READONLY) &&
+		    (m->mnt.mnt_flags & MNT_WRITE_HOLD))
+			mnt_unhold_writers(m);
+
+		if (!err && kattr->propagation)
+			change_mnt_propagation(m, kattr->propagation);
+
+		/*
+		 * On failure, only cleanup until we found the first mount
+		 * we failed to handle.
+		 */
+		if (err && m == last)
+			break;
+	} while (kattr->recurse && (m = next_mnt(m, mnt)));
+
+	if (!err)
+		touch_mnt_namespace(mnt->mnt_ns);
+}
+
+static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
+{
+	struct mount *mnt = real_mount(path->mnt), *last = NULL;
+	int err = 0;
+
+	if (path->dentry != mnt->mnt.mnt_root)
+		return -EINVAL;
+
+	if (kattr->propagation) {
+		/*
+		 * Only take namespace_lock() if we're actually changing
+		 * propagation.
+		 */
+		namespace_lock();
+		if (kattr->propagation == MS_SHARED) {
+			err = invent_group_ids(mnt, kattr->recurse);
+			if (err) {
+				namespace_unlock();
+				return err;
+			}
+		}
+	}
+
+	lock_mount_hash();
+
+	/*
+	 * Get the mount tree in a shape where we can change mount
+	 * properties without failure.
+	 */
+	last = mount_setattr_prepare(kattr, mnt, &err);
+	if (last) /* Commit all changes or revert to the old state. */
+		mount_setattr_commit(kattr, mnt, last, err);
+
+	unlock_mount_hash();
+
+	if (kattr->propagation) {
+		namespace_unlock();
+		if (err)
+			cleanup_group_ids(mnt, NULL);
+	}
+
+	return err;
+}
+
+static int build_mount_kattr(const struct mount_attr *attr,
+			     struct mount_kattr *kattr, unsigned int flags)
+{
+	unsigned int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
+
+	if (flags & AT_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (flags & AT_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	*kattr = (struct mount_kattr) {
+		.lookup_flags	= lookup_flags,
+		.recurse	= !!(flags & AT_RECURSIVE),
+	};
+
+	switch (attr->propagation) {
+	case 0:
+		kattr->propagation = 0;
+		break;
+	case MS_UNBINDABLE:
+		kattr->propagation = MS_UNBINDABLE;
+		break;
+	case MS_PRIVATE:
+		kattr->propagation = MS_PRIVATE;
+		break;
+	case MS_SLAVE:
+		kattr->propagation = MS_SLAVE;
+		break;
+	case MS_SHARED:
+		kattr->propagation = MS_SHARED;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if ((attr->attr_set | attr->attr_clr) & ~MOUNT_SETATTR_VALID_FLAGS)
+		return -EINVAL;
+
+	kattr->attr_set = attr_flags_to_mnt_flags(attr->attr_set);
+	kattr->attr_clr = attr_flags_to_mnt_flags(attr->attr_clr);
+
+	/*
+	 * Since the MOUNT_ATTR_<atime> values are an enum, not a bitmap,
+	 * users wanting to transition to a different atime setting cannot
+	 * simply specify the atime setting in @attr_set, but must also
+	 * specify MOUNT_ATTR__ATIME in the @attr_clr field.
+	 * So ensure that MOUNT_ATTR__ATIME can't be partially set in
+	 * @attr_clr and that @attr_set can't have any atime bits set if
+	 * MOUNT_ATTR__ATIME isn't set in @attr_clr.
+	 */
+	if (attr->attr_clr & MOUNT_ATTR__ATIME) {
+		if ((attr->attr_clr & MOUNT_ATTR__ATIME) != MOUNT_ATTR__ATIME)
+			return -EINVAL;
+
+		/*
+		 * Clear all previous time settings as they are mutually
+		 * exclusive.
+		 */
+		kattr->attr_clr |= MNT_RELATIME | MNT_NOATIME;
+		switch (attr->attr_set & MOUNT_ATTR__ATIME) {
+		case MOUNT_ATTR_RELATIME:
+			kattr->attr_set |= MNT_RELATIME;
+			break;
+		case MOUNT_ATTR_NOATIME:
+			kattr->attr_set |= MNT_NOATIME;
+			break;
+		case MOUNT_ATTR_STRICTATIME:
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		if (attr->attr_set & MOUNT_ATTR__ATIME)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
+		unsigned int, flags, struct mount_attr __user *, uattr,
+		size_t, usize)
+{
+	int err;
+	struct path target;
+	struct mount_attr attr;
+	struct mount_kattr kattr;
+
+	BUILD_BUG_ON(sizeof(struct mount_attr) != MOUNT_ATTR_SIZE_VER0);
+
+	if (flags & ~(AT_EMPTY_PATH |
+		      AT_RECURSIVE |
+		      AT_SYMLINK_NOFOLLOW |
+		      AT_NO_AUTOMOUNT))
+		return -EINVAL;
+
+	if (unlikely(usize > PAGE_SIZE))
+		return -E2BIG;
+	if (unlikely(usize < MOUNT_ATTR_SIZE_VER0))
+		return -EINVAL;
+
+	if (!may_mount())
+		return -EPERM;
+
+	err = copy_struct_from_user(&attr, sizeof(attr), uattr, usize);
+	if (err)
+		return err;
+
+	/* Don't bother walking through the mounts if this is a nop. */
+	if (attr.attr_set == 0 &&
+	    attr.attr_clr == 0 &&
+	    attr.propagation == 0)
+		return 0;
+
+	err = build_mount_kattr(&attr, &kattr, flags);
+	if (err)
+		return err;
+
+	err = user_path_at(dfd, path, kattr.lookup_flags, &target);
+	if (err)
+		return err;
+
+	err = do_mount_setattr(&target, &kattr);
+	path_put(&target);
+	return err;
+}
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 37bea07c12f2..a62d5904fb6a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -68,6 +68,7 @@ union bpf_attr;
 struct io_uring_params;
 struct clone_args;
 struct open_how;
+struct mount_attr;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -999,6 +1000,8 @@ asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
 asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
 			       int to_dfd, const char __user *to_path,
 			       unsigned int ms_flags);
+asmlinkage long sys_mount_setattr(int dfd, const char __user *path, unsigned int flags,
+				  struct mount_attr __user *uattr, size_t usize);
 asmlinkage long sys_fsopen(const char __user *fs_name, unsigned int flags);
 asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
 			     const void __user *value, int aux);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2056318988f7..0517f36fe783 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -859,9 +859,11 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_process_madvise 440
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
+#define __NR_mount_setattr 441
+__SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 
 #undef __NR_syscalls
-#define __NR_syscalls 441
+#define __NR_syscalls 442
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index dd8306ea336c..2255624e91c8 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -1,6 +1,8 @@
 #ifndef _UAPI_LINUX_MOUNT_H
 #define _UAPI_LINUX_MOUNT_H
 
+#include <linux/types.h>
+
 /*
  * These are the fs-independent mount-flags: up to 32 flags are supported
  *
@@ -118,4 +120,16 @@ enum fsconfig_command {
 #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
 #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
 
+/*
+ * mount_setattr()
+ */
+struct mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u64 propagation;
+};
+
+/* List of all mount_attr versions. */
+#define MOUNT_ATTR_SIZE_VER0	24 /* sizeof first published struct */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 2056318988f7..0517f36fe783 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -859,9 +859,11 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_process_madvise 440
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
+#define __NR_mount_setattr 441
+__SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 
 #undef __NR_syscalls
-#define __NR_syscalls 441
+#define __NR_syscalls 442
 
 /*
  * 32 bit systems traditionally used different
-- 
2.29.2

