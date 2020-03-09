Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74E317E1DB
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 15:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgCIOBB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 10:01:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48741 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726720AbgCIOBA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 10:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583762459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LCwQdPmaneRQtBpeq1ZGN6m1ErYqxzPhN+jQBM7D2cs=;
        b=F6UCwHWChdomw5TCq6HG6rSI89GkrdpaXVOm/tWU/WVhefJxV+5pvAJQhgOgdFQfeX/PN/
        izK3acddWddCuJp8rSvZ3++YizXrrgZyMjXFpCj1rh1pQtGuJ4DdiBcJh+x9kXW4nR4Wnb
        tqgJdtbtlGHbysicW74e+wlR0x75dUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-zAdC5ZQsMgOBZepluVmQNg-1; Mon, 09 Mar 2020 10:00:55 -0400
X-MC-Unique: zAdC5ZQsMgOBZepluVmQNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C455EDB63;
        Mon,  9 Mar 2020 14:00:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCFD18B773;
        Mon,  9 Mar 2020 14:00:46 +0000 (UTC)
Subject: [PATCH 00/14] VFS: Filesystem information [ver #18]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Theodore Ts'o <tytso@mit.edu>, Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 14:00:46 +0000
Message-ID: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Here's a set of patches that adds a system call, fsinfo(), that allows
information about the VFS, mount topology, superblock and files to be
retrieved.

The patchset is based on top of the notifications patchset and allows event
counters implemented in the latter to be retrieved to allow overruns to be
efficiently managed.

Included are a couple of sample programs plus limited example code for NFS
and Ext4.  The example code is not intended to go upstream as-is.


=======
THE WHY
=======

Why do we want this?

Using /proc/mounts (or similar) has problems:

 (1) Reading from it holds a global lock (namespace_sem) that prevents
     mounting and unmounting.  Lots of data is encoded and mangled into
     text whilst the lock is held, including superblock option strings and
     mount point paths.  This causes performance problems when there are a
     lot of mount objects in a system.

 (2) Even though namespace_sem is held during a read, reading the whole
     file isn't necessarily atomic with respect to mount-type operations.
     If a read isn't satisfied in one go, then it may return to userspace
     briefly and then continue reading some way into the file.  But changes
     can occur in the interval that may then go unseen.

 (3) Determining what has changed means parsing and comparing consecutive
     outputs of /proc/mounts.

 (4) Querying a specific mount or superblock means searching through
     /proc/mounts and searching by path or mount ID - but we might have an
     fd we want to query.

 (5) Mount topology is not explicit.  One must derive it manually by
     comparing entries.

 (6) Whilst you can poll() it for events, it only tells you that something
     changed in the namespace, not what or whether you can even see the
     change.

To fix the notification issues, the preceding notifications patchset added
mount watch notifications whereby you can watch for notifications in a
specific mount subtree.  The notification messages include the ID(s) of the
affected mounts.

To support notifications, however, we need to be able to handle overruns in
the notification queue.  I added a number of event counters to struct
super_block and struct mount to allow you to pin down the changes, but
there needs to be a way to retrieve them.  Exposing them through /proc
would require adding yet another /proc/mounts-type file.  We could add
per-mount directories full of attributes in sysfs, but that has issues also
(see below).

Adding an extensible system call interface for retrieving filesystem
information also allows other things to be exposed:

 (1) Jeff Layton's error handling changes need a way to allow error event
     information to be retrieved.

 (2) Bits in masks returned by things like statx() and FS_IOC_GETFLAGS are
     actually 3-state { Set, Unset, Not supported }.  It could be useful to
     provide a way to expose information like this[*].

 (3) Limits of the numerical metadata values in a filesystem[*].

 (4) Filesystem capability information[*].  Filesystems don't all have the
     same capabilities, and even different instances may have different
     capabilities, particularly with network filesystems where the set of
     may be server-dependent.  Capabilities might even vary at file
     granularity - though possibly such information should be conveyed
     through statx() instead.

 (5) ID mapping/shifting tables in use for a superblock.

 (6) Filesystem-specific information.  I need something for AFS so that I
     can do pioctl()-emulation, thereby allowing me to implement certain of
     the AFS command line utilities that query state of a particular file.
     This could also have application for other filesystems, such as NFS,
     CIFS and ext4.

 [*] In a lot of cases these are probably fixed and can be memcpy'd from
     static data.

There's a further consideration: I want to make it possible to have
fsconfig(fd, FSCONFIG_CMD_CREATE) be intercepted by a container manager
such that the manager can supervise a mount attempted inside the container.
The manager would be given an fd pointing to the fs_context struct and
would then need some way to query it (fsinfo()) and modify it (fsconfig()).
This could also be used to arbitrate user-requested mounts when containers
are not in play.


============================
WHY NOT USE PROCFS OR SYSFS?
============================

Why is it better to go with a new system call rather than adding more magic
stuff to /proc or /sysfs for each superblock object and each mount object?

 (1) It can be targetted.  It makes it easy to query directly by path or
     fd, but can also query by mount ID or fscontext fd.  procfs and sysfs
     cannot do three of these things easily.

 (2) Easier to provide LSM oversight.  Is the accessing process allowed to
     query information pertinent to a particular file?

 (3) It's more efficient as we can return specific binary data rather than
     making huge text dumps.  Granted, sysfs and procfs could present the
     same data, though as lots of little files which have to be
     individually opened, read, closed and parsed.

 (4) We wouldn't have the overhead of open and close (even adding a
     self-contained readfile() syscall has to do that internally).

 (5) Opening a file in procfs or sysfs has a pathwalk overhead for each
     file accessed.  We can use an integer attribute ID instead (yes, this
     is similar to ioctl) - but could also use a string ID if that is
     preferred.

 (6) Can query cross-namespace if, say, a container manager process is
     given an fs_context that hasn't yet been mounted into a namespace - or
     hasn't even been fully created yet.

 (7) Don't have to create/delete a bunch of sysfs/procfs nodes each time a
     mount happens or is removed - and since systemd makes much use of
     mount namespaces and mount propagation, this will create a lot of
     nodes.


================
DESIGN DECISIONS
================

 (1) Information is partitioned into sets of attributes.

 (2) Attribute IDs are integers as they're fast to compare.

 (3) Attribute values are typed (struct, list of structs, string, opaque
     blob).  They type is fixed for a particular attribute.

 (4) For structure types, the length is also a version.  New fields can be
     tacked onto the end.

 (5) When copying a versioned struct to userspace, the core handles a
     version mismatch by truncating or zero-padding the data as necessary.
     None of this is seen by the filesystem.

 (6) The core handles all the buffering and buffer resizing.

 (7) The filesystem never gets any access to the userspace parameter buffer
     or result buffer.

 (8) "Meta" attributes can describe other attributes.


========
OVERVIEW
========

fsinfo() is a system call that allows information about the filesystem at a
particular path point to be queried as a set of attributes.

Attribute values are of four basic types:

 (1) Structure with version-dependent length (the length is the version).

 (2) Variable-length string.

 (3) List of structures (all the same length).

 (4) Opaque blob.

Attributes can have multiple values either as a sequence of values or a
sequence-of-sequences of values and all the values of a particular
attribute must be of the same type.  Values can be up to INT_MAX size,
subject to memory availability.

Note that the values of an attribute *are* allowed to vary between dentries
within a single superblock, depending on the specific dentry that you're
looking at, but the values still have to be of the type for that attribute.

I've tried to make the interface as light as possible, so integer attribute
ID rather than string and the core does all the buffer allocation and
expansion and all the extensibility support work rather than leaving that
to the filesystems.  This means that userspace pointers are not exposed to
the filesystem.


fsinfo() allows a variety of information to be retrieved about a filesystem
and the mount topology:

 (1) General superblock attributes:

     - Filesystem identifiers (UUID, volume label, device numbers, ...)
     - The limits on a filesystem's capabilities
     - Information on supported statx fields and attributes and IOC flags.
     - A variety single-bit flags indicating supported capabilities.
     - Timestamp resolution and range.
     - The amount of space/free space in a filesystem (as statfs()).
     - Superblock notification counter.

 (2) Filesystem-specific superblock attributes:

     - Superblock-level timestamps.
     - Cell name, workgroup or other netfs grouping concept.
     - Server names and addresses.

 (3) VFS information:

     - Mount topology information.
     - Mount attributes.
     - Mount notification counter.
     - Mount point path.

 (4) Information about what the fsinfo() syscall itself supports, including
     the type and struct size of attributes.

The system is extensible:

 (1) New attributes can be added.  There is no requirement that a
     filesystem implement every attribute.  A helper function is provided
     to scan a list of attributes and a filesystem can have multiple such
     lists.

 (2) Version length-dependent structure attributes can be made larger and
     have additional information tacked on the end, provided it keeps the
     layout of the existing fields.  If an older process asks for a shorter
     structure, it will only be given the bits it asks for.  If a newer
     process asks for a longer structure on an older kernel, the extra
     space will be set to 0.  In all cases, the size of the data actually
     available is returned.

     In essence, the size of a structure is that structure's version: a
     smaller size is an earlier version and a later version includes
     everything that the earlier version did.

 (3) New single-bit capability flags can be added.  This is a structure-typed
     attribute and, as such, (2) applies.  Any bits you wanted but the kernel
     doesn't support are automatically set to 0.

fsinfo() may be called like the following, for example:

	struct fsinfo_params params = {
		.resolve_flags	= RESOLVE_NO_TRAILING_SYMLINKS,
		.flags		= FSINFO_FLAGS_QUERY_PATH,
		.request	= FSINFO_ATTR_AFS_SERVER_ADDRESSES,
		.Nth		= 2,
	};
	struct fsinfo_server_address address;
	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
		     &address, sizeof(address));

The above example would query an AFS filesystem to retrieve the address
list for the 3rd server, and:

	struct fsinfo_params params = {
		.resolve_flags	= RESOLVE_NO_TRAILING_SYMLINKS,
		.flags		= FSINFO_FLAGS_QUERY_PATH,
		.request	= FSINFO_ATTR_NFS_SERVER_NAME;
	};
	char server_name[256];
	len = fsinfo(AT_FDCWD, "/home/dhowells/", &params,
		     &server_name, sizeof(server_name));

would retrieve the name of the NFS server as a string.

In future, I want to make fsinfo() capable of querying a context created by
fsopen() or fspick(), e.g.:

	fd = fsopen("ext4", 0);
	struct fsinfo_params params = {
		.flags		= FSINFO_FLAGS_QUERY_FSCONTEXT,
		.request	= FSINFO_ATTR_CONFIGURATION;
	};
	char buffer[65536];
	fsinfo(fd, NULL, &params, &buffer, sizeof(buffer));

even if that context doesn't currently have a superblock attached.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

on branch:

	fsinfo-core


===================
SIGNIFICANT CHANGES
===================

 ver #18:

 (*) Moved the mount and superblock notification patches into a different
     branch.

 (*) Made superblock configuration (->show_opts), bindmount path
     (->show_path) and filesystem statistics (->show_stats) available as
     the CONFIGURATION, MOUNT_PATH and FS_STATISTICS attributes.

 (*) Made mountpoint device name available, filtered through the superblock
     (->show_devname), as the SOURCE attribute.

 (*) Made the mountpoint available as a full path as well as a relative
     one.

 (*) Added more event counters to MOUNT_INFO, including a subtree
     notification counter, to make it easier to clean up after a
     notification overrun.

 (*) Made the event counter value returned by MOUNT_CHILDREN the sum of the
     five event counters.

 (*) Added a mount uniquifier and added that to the MOUNT_CHILDREN entries
     also so that mount ID reuse can be detected.

 (*) Merged the SB_NOTIFICATION attribute into the MOUNT_INFO attribute to
     avoid duplicate information.

 (*) Switched to using the RESOLVE_* flags rather than AT_* flags for
     pathwalk control.  Added more RESOLVE_* flags.

 (*) Used a lock instead of RCU to enumerate children for the
     MOUNT_CHILDREN attribute for safety.  This is probably worth
     revisiting at a later date, however.


 ver #17:

 (*) Applied comments from Jann Horn, Darrick Wong and Christian Brauner.

 (*) Rearranged the order in which fsinfo() does things so that the
     superblock operations table can have a function pointer rather than a
     table pointer.  The ->fsinfo() op is now called at least twice, once
     to determine the size of buffer needed and then to retrieve the data.
     If the retrieval step indicates yet more space is needed, the buffer
     will be expanded and that step repeated.

 (*) Merge the element size into the size in the fsinfo_attribute def and
     don't set size for strings or opaques.  Let a helper work that out.
     This means that strings can actually get larger then 4K.

 (*) A helper is provided to scan a list of attributes and call the
     appropriate get function.  This can be called from a filesystem's
     ->fsinfo() method multiple times.  It also handles attribute
     enumeration and info querying.

 (*) Rearranged the patches to put all the notification patches first.
     This allowed some of the bits to be squashed together.  At some point,
     I'll move the notification patches into a different branch.

 ver #16:

 (*) Split the features bits out of the fsinfo() core into their own patch
     and got rid of the name encoding attributes.

 (*) Renamed the 'array' type to 'list' and made AFS use it for returning
     server address lists.

 (*) Changed the ->fsinfo() method into an ->fsinfo_attributes[] table,
     where each attribute has a ->get() method to deal with it.  These
     tables can then be returned with an fsinfo meta attribute.

 (*) Dropped the fscontext query and parameter/description retrieval
     attributes for now.

 (*) Picked the mount topology attributes into this branch.

 (*) Picked the mount notifications into this branch and rebased on top of
     notifications-pipe-core.

 (*) Picked the superblock notifications into this branch.

 (*) Add sample code for Ext4 and NFS.

David
---
David Howells (14):
      VFS: Add additional RESOLVE_* flags
      fsinfo: Add fsinfo() syscall to query filesystem information
      fsinfo: Provide a bitmap of supported features
      fsinfo: Allow retrieval of superblock devname, options and stats
      fsinfo: Allow fsinfo() to look up a mount object by ID
      fsinfo: Add a uniquifier ID to struct mount
      fsinfo: Allow mount information to be queried
      fsinfo: Allow the mount topology propogation flags to be retrieved
      fsinfo: Provide notification overrun handling support
      fsinfo: sample: Mount listing program
      fsinfo: Add API documentation
      fsinfo: Add support for AFS
      fsinfo: Example support for Ext4
      fsinfo: Example support for NFS


 Documentation/filesystems/fsinfo.rst        |  564 +++++++++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/include/asm/unistd.h             |    2 
 arch/ia64/kernel/syscalls/syscall.tbl       |    1 
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
 arch/s390/kernel/syscalls/syscall.tbl       |    1 
 arch/sh/kernel/syscalls/syscall.tbl         |    1 
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
 fs/Kconfig                                  |    7 
 fs/Makefile                                 |    1 
 fs/afs/internal.h                           |    1 
 fs/afs/super.c                              |  218 +++++++
 fs/d_path.c                                 |    2 
 fs/ext4/Makefile                            |    1 
 fs/ext4/ext4.h                              |    6 
 fs/ext4/fsinfo.c                            |   45 +
 fs/ext4/super.c                             |    3 
 fs/fsinfo.c                                 |  720 ++++++++++++++++++++++
 fs/internal.h                               |   13 
 fs/mount.h                                  |    3 
 fs/namespace.c                              |  362 +++++++++++
 fs/nfs/Makefile                             |    1 
 fs/nfs/fsinfo.c                             |  230 +++++++
 fs/nfs/internal.h                           |    6 
 fs/nfs/nfs4super.c                          |    3 
 fs/nfs/super.c                              |    3 
 fs/open.c                                   |    8 
 include/linux/fcntl.h                       |    3 
 include/linux/fs.h                          |    4 
 include/linux/fsinfo.h                      |  111 +++
 include/linux/syscalls.h                    |    4 
 include/uapi/asm-generic/unistd.h           |    4 
 include/uapi/linux/fsinfo.h                 |  360 +++++++++++
 include/uapi/linux/mount.h                  |   10 
 include/uapi/linux/openat2.h                |    8 
 include/uapi/linux/windows.h                |   35 +
 kernel/sys_ni.c                             |    1 
 samples/vfs/Makefile                        |    7 
 samples/vfs/test-fsinfo.c                   |  880 +++++++++++++++++++++++++++
 samples/vfs/test-mntinfo.c                  |  277 ++++++++
 50 files changed, 3905 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/filesystems/fsinfo.rst
 create mode 100644 fs/ext4/fsinfo.c
 create mode 100644 fs/fsinfo.c
 create mode 100644 fs/nfs/fsinfo.c
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 include/uapi/linux/windows.h
 create mode 100644 samples/vfs/test-fsinfo.c
 create mode 100644 samples/vfs/test-mntinfo.c


