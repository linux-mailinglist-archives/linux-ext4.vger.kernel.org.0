Return-Path: <linux-ext4+bounces-11555-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C00C3D9A1
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6E04E4ABF
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB9335579;
	Thu,  6 Nov 2025 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH+37TNx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C95336ED2
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468203; cv=none; b=B+/WtcYSz7jgaA31TtazFYfYrDmw/wUwjFpijBT8mseUSQts1WfsSAFfFx/lOnnGDRNBKDfCgKML4F3M+HhUZSKyQLz8vsB1/cGMFRNKxM4Kri8WiINaEI3FMt7+sffzdiW+D/SC5ewg2Os+Ihc1fJLHsqzDuJNR058neXGfY1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468203; c=relaxed/simple;
	bh=EY/oBynQusnkLDODo1Y9gs6RgY7wn8yZFAgfx9xsvDc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgoEq2uIEYCzg7DEJTMVXvZ6Z5O8EKE7M62RvFwQDIIT0twNxuIpQufXBfjdUUtCP273+uQ96csvK+56O+NvjuCRrc8pwm8Kl2ntWzS+hBqOra8r23LdQAeHRoHztXm9jo8QSS+q3xt6I20QLnhiPOgzuefsC39RCPwipou714o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH+37TNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBF0C116D0;
	Thu,  6 Nov 2025 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468201;
	bh=EY/oBynQusnkLDODo1Y9gs6RgY7wn8yZFAgfx9xsvDc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TH+37TNxR/9GnR/QfRa/S5omOvUpsqxmzgC7qOrh5AJpiP2euhnlGJmjsZAHAyq3f
	 sp70VrW74brKbu5STIsftV3kpz+8bmFsWUv7cyqDjwzEuu7D+wv7GkhVwheiN75ct4
	 mDi/EXNS4DaBlwmFolDLWBys2p8QXY72rhLalu3Vy7Ub3C2hx0cSpKtrq88IMRqfPU
	 gf/38/VfIItk60QIMdXmUfcfWmcx6adR8GslRomtY9HALCXV1tlAn/deOK64bu9CwM
	 lA1gLKwK9Uvj5eJ1eThEuCKWeS95xhAKx6Mz+Vd3Vek6Kz6P+bEnaywQ+5VEF/8E8j
	 eyjdIBAj7Lwjw==
Date: Thu, 06 Nov 2025 14:30:00 -0800
Subject: [PATCHSET 9/9] fuse4fs: fork a low level fuse server
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: amir73il@gmail.com, linux-ext4@vger.kernel.org
Message-ID: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
In-Reply-To: <20251106221440.GJ196358@frogsfrogsfrogs>
References: <20251106221440.GJ196358@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Whilst developing the fuse2fs+iomap prototype, I discovered a
fundamental design limitation of the upper-level libfuse API: hardlinks.
The upper level fuse library really wants to communicate with the fuse
server with file paths, instead of using inode numbers.  This works
great for filesystems that don't have inodes, create files dynamically
at runtime, or lack stable inode numbers.

Unfortunately, the libfuse path abstraction assigns a unique nodeid to
every child file in the entire filesystem, without regard to hard links.
In other words, a hardlinked regular file may have one ondisk inode
number but multiple kernel inodes.  For classic fuse2fs this isn't a
problem because all file access goes through the fuse server and the big
library lock protects us from corruption.

For fuse2fs + iomap this is a disaster because we rely on the kernel to
coordinate access to inodes.  For hardlinked files, we *require* that
there only be one in-kernel inode for each ondisk inode.

The path based mechanism is also very inefficient for fuse2fs.  Every
time a file is accessed, the upper level libfuse passes a new nodeid to
the kernel, and on every file access the kernel passes that same nodeid
back to libfuse.  libfuse then walks its internal directory entry cache
to construct a path string for that nodeid and hands it to fuse2fs.
fuse2fs then walks the ondisk directory structure to find the ext2 inode
number.  Every time.

Create a new fuse4fs server from fuse2fs that uses the lowlevel fuse
API.  This affords us direct control over nodeids and eliminates the
path wrangling.  Hardlinks can be supported when iomap is turned on,
and metadata-heavy workloads run twice as fast.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse4fs-fork
---
Commits in this patchset:
 * fuse2fs: separate libfuse3 and fuse2fs detection in configure
 * fuse2fs: start porting fuse2fs to lowlevel libfuse API
 * debian: create new package for fuse4fs
 * fuse4fs: namespace some helpers
 * fuse4fs: convert to low level API
 * libsupport: port the kernel list.h to libsupport
 * libsupport: add a cache
 * cache: disable debugging
 * cache: use modern list iterator macros
 * cache: embed struct cache in the owner
 * cache: pass cache pointer to callbacks
 * cache: pass a private data pointer through cache_walk
 * cache: add a helper to grab a new refcount for a cache_node
 * cache: return results of a cache flush
 * cache: add a "get only if incore" flag to cache_node_get
 * cache: support gradual expansion
 * cache: support updating maxcount and flags
 * cache: support channging flags
 * cache: implement automatic shrinking
 * fuse4fs: add cache to track open files
 * fuse4fs: use the orphaned inode list
 * fuse4fs: implement FUSE_TMPFILE
 * fuse4fs: create incore reverse orphan list
---
 lib/ext2fs/jfs_compat.h  |    2 
 lib/ext2fs/kernel-list.h |  111 -
 lib/support/cache.h      |  184 +
 lib/support/list.h       |  901 ++++++
 lib/support/xbitops.h    |  128 +
 Makefile.in              |    3 
 configure                |  414 +--
 configure.ac             |  156 +
 debian/control           |   12 
 debian/fuse4fs.install   |    2 
 debian/fuse4fs.links     |    3 
 debian/rules             |   11 
 debugfs/Makefile.in      |   12 
 e2fsck/Makefile.in       |   56 
 fuse4fs/Makefile.in      |  193 +
 fuse4fs/fuse4fs.1.in     |  118 +
 fuse4fs/fuse4fs.c        | 6430 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/config.h.in          |    3 
 lib/e2p/Makefile.in      |    4 
 lib/ext2fs/Makefile.in   |   14 
 lib/support/Makefile.in  |    8 
 lib/support/cache.c      |  882 ++++++
 misc/Makefile.in         |   18 
 misc/tune2fs.c           |    4 
 24 files changed, 9222 insertions(+), 447 deletions(-)
 delete mode 100644 lib/ext2fs/kernel-list.h
 create mode 100644 lib/support/cache.h
 create mode 100644 lib/support/list.h
 create mode 100644 lib/support/xbitops.h
 create mode 100644 debian/fuse4fs.install
 create mode 100644 debian/fuse4fs.links
 create mode 100644 fuse4fs/Makefile.in
 create mode 100644 fuse4fs/fuse4fs.1.in
 create mode 100644 fuse4fs/fuse4fs.c
 create mode 100644 lib/support/cache.c


