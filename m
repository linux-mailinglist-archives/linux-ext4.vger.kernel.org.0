Return-Path: <linux-ext4+bounces-9501-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F1EB30624
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7219A1D21E56
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F3B350D5E;
	Thu, 21 Aug 2025 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XyllwlvQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C0C27FB2D
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807620; cv=none; b=nxHNezuIGZPORNS/TbSS6pIUaMe5+y2GViw1aOJ7Z+n7Bq3av3Cdj3u1si4v4Cl5WF1Fb6O0vFqNOqtrsqxeM0cSlM4obK+zRln/PskYn9c73QwCOih2I4s5fnb6L9HpES/gbMMXE+m0I7vRQwo/dUBpc6qXNbzIxQHpfWXmVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807620; c=relaxed/simple;
	bh=/BdIefG1/27tHJXIb/J7ReJQO+Wd/JMyOnilC6r+beI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Vk30CIqTsFbUvmucYaL+l+zf9m8iZzZtv6BOz8ZyVlrYoBM/AT/Jhidov/xl17sRWh71cxWBEpLAfqb1KyLCe1Bk91ZlCEeRGSNu3R7zfn2UxGet+sSw+c7WCy8jVQPNd2rS8I1ORaVPV4ykAdJ2Hc5dCP+ojDG8Hw5ZtZi6evU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XyllwlvQ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so1153541276.3
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807616; x=1756412416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0SeVezRefrCpYYDCsSNYu7Co/BY5e8f2aGHEoMEe3eM=;
        b=XyllwlvQ6uPHQhwkWYYO4WrSXeL/jZZnBWsH/2D1yH8tDDkJoQex0WhEQR9mgQLLhg
         DcRl552u4lNDETTeGR3M8NTaIEYhJV/Y0ZwdvurtkcgN7duySD9L7Q2PJA/sLUTiD3XV
         rYsgQ4UZwg5SEbUhmqp/31V+777HAZCTJ05784bOFwxXSKIOb41ZBv791p/g/+H7/5Hp
         mmlIDj0eTCJsPUiMJ89/EsfmY7ugTN27YEY3jXaWx/z0Oc9P3NSLY7aJiUISUbNtAbr0
         kxjSixxzC6aCi85Oz9kykFujNIwCjHFoo00yRE2My4Lmo36SoZD/ptrZFozUrzGOCIlU
         66rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807616; x=1756412416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SeVezRefrCpYYDCsSNYu7Co/BY5e8f2aGHEoMEe3eM=;
        b=SENi20MP2Ce3krSnvFy7xZsN2WlRLePQWoxFC+OFJAWUAxA6jqRTXweBrejledbahT
         MELLLHE9qZCRhIPaNbH7DyjpfY9GxZV8H1675vTC9RjavErOMDMY2eotPxIwSx/ckuIY
         Rwd5/F9jCiPP+b88JPB3HIolOZtfCV3ME429VBstIAkbBl3KUSUkzvBioQmd9F2ZJps+
         6K2CrZ16+yFzbKAhyPXq+Sp2Y5u86UfByDsrUpEwwkGMbPGuRuZqg4B2+MyJX7Af7XHg
         Gzu7nG26ShRQlgo0Y80qOe1vKe/PPaRqDGA1eA6t02bgP+Yb9MgHf4+iyjpwS9A4RRcj
         0CTg==
X-Forwarded-Encrypted: i=1; AJvYcCWLX31bKDYnskm577LAyEhQtwvcHFm9kWsEVa0yJ6jf2BO42AGJkFfCr9VBcCust/RCDS0FCFGsddNR@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJUnUvWAj9hkGZyOdAcX5V2j8RuK0M55hy1VV/vhmmZYltZNf
	oK58SSw7he3JSvrJ0CuDhUWKO+pj/MrimJPQWsMmk7Ijwhh65bFYvdP6TMGyE9SkjvE=
X-Gm-Gg: ASbGncvFjecNj+fxMa1L60R/CVJvcFC3/PHJhfD2tTS9e9/R78tGi6VlKvhoLtOUen4
	Xme3eelo9sCvbQYFNDxeIHkEGmQ7lSgAAJj3blGnbwYOWoNeSDpl23Thy23gFSyiWrbJxpsg682
	tBjANxiy+MtXJI2i/+mAAZeyeO7Fa3sklPf3Lfto2EBcWhYjE2IHdR9eFxsj9N8xb4n29J6mhoa
	4YVBo6kKHSStuHxQBKWUTbEsfZ0Tu5JieQawnmkq2hAl5HvNN8vhMnIeT+LJa4zXRt+aFNxZD1q
	WZQ3sQJt/SO+HR3mk9Upo6tk87r2A0R3YitdGt3Nb3DZkbpXpszvYKJMicCqBbsF+oh8uMWjZ5z
	+scPFxEQe7c/c5CUHL/kuYYpz4Mz1cZCJ6xjh3/FOs1ALlU2EFqeVsM2VAsg=
X-Google-Smtp-Source: AGHT+IE6Qk/uCJGKI3wxomxr6wsEq4XUy1mGV5MwcGWRTIhxV9r/kfkTBxnBTTgL2CLxX+LStcCrXA==
X-Received: by 2002:a05:6902:600c:b0:e90:39b7:6085 with SMTP id 3f1490d57ef6-e951c3200fdmr856373276.17.1755807615867;
        Thu, 21 Aug 2025 13:20:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94f1ddbbbfsm2363100276.12.2025.08.21.13.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 00/50] fs: rework inode reference counting
Date: Thu, 21 Aug 2025 16:18:11 -0400
Message-ID: <cover.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series is the first part of a larger body of work geared towards solving a
variety of scalability issues in the VFS.

We have historically had a variety of foot-guns related to inode freeing.  We
have I_WILL_FREE and I_FREEING flags that indicated when the inode was in the
different stages of being reclaimed.  This lead to confusion, and bugs in cases
where one was checked but the other wasn't.  Additionally, it's frankly
confusing to have both of these flags and to deal with them in practice.

However, this exists because we have an odd behavior with inodes, we allow them
to have a 0 reference count and still be usable. This again is a pretty unfun
footgun, because generally speaking we want reference counts to be meaningful.

The problem with the way we reference inodes is the final iput(). The majority
of file systems do their final truncate of a unlinked inode in their
->evict_inode() callback, which happens when the inode is actually being
evicted. This can be a long process for large inodes, and thus isn't safe to
happen in a variety of contexts. Btrfs, for example, has an entire delayed iput
infrastructure to make sure that we do not do the final iput() in a dangerous
context. We cannot expand the use of this reference count to all the places the
inode is used, because there are cases where we would need to iput() in an IRQ
context  (end folio writeback) or other unsafe context, which is not allowed.

To that end, resolve this by introducing a new i_obj_count reference count. This
will be used to control when we can actually free the inode. We then can use
this reference count in all the places where we may reference the inode. This
removes another huge footgun, having ways to access the inode itself without
having an actual reference to it. The writeback code is one of the main places
where we see this. Inodes end up on all sorts of lists here without a proper
reference count. This allows us to protect the inode from being freed by giving
this an other code mechanisms to protect their access to the inode.

With this we can separate the concept of the inode being usable, and the inode
being freed.  The next part of the patch series is to stop allowing for inodes
to have an i_count of 0 and still be viable.  This comes with some warts. The
biggest wart is now if we choose to cache inodes in the LRU list we have to
remove the inode from the LRU list if we access it once it's on the LRU list.
This will result in more contention on the lru list lock, but in practice we
rarely have inodes that do not have a dentry, and if we do that inode is not
long for this world.

With not allowing inodes to hit a refcount of 0, we can take advantage of that
common pattern of using refcount_inc_not_zero() in all of the lockless places
where we do inode lookup in cache.  From there we can change all the users who
check I_WILL_FREE or I_FREEING to simply check the i_count. If it is 0 then they
aren't allowed to do their work, othrwise they can proceed as normal.

With all of that in place we can finally remove these two flags.

This is a large series, but it is mostly mechanical. I've kept the patches very
small, to make it easy to review and logic about each change. I have run this
through fstests for btrfs and ext4, xfs is currently going. I wanted to get this
out for review to make sure this big design changes are reasonable to everybody.

The series is based on vfs/vfs.all branch, which is based on 6.9-rc1. Thanks,

Josef

Josef Bacik (50):
  fs: add an i_obj_count refcount to the inode
  fs: make the i_state flags an enum
  fs: hold an i_obj_count reference in wait_sb_inodes
  fs: hold an i_obj_count reference for the i_wb_list
  fs: hold an i_obj_count reference for the i_io_list
  fs: hold an i_obj_count reference in writeback_sb_inodes
  fs: hold an i_obj_count reference while on the hashtable
  fs: hold an i_obj_count reference while on the LRU list
  fs: hold an i_obj_count reference while on the sb inode list
  fs: stop accessing ->i_count directly in f2fs and gfs2
  fs: hold an i_obj_count when we have an i_count reference
  fs: rework iput logic
  fs: add an I_LRU flag to the inode
  fs: maintain a list of pinned inodes
  fs: delete the inode from the LRU list on lookup
  fs: change evict_inodes to use iput instead of evict directly
  fs: hold a full ref while the inode is on a LRU
  fs: disallow 0 reference count inodes
  fs: make evict_inodes add to the dispose list under the i_lock
  fs: convert i_count to refcount_t
  fs: use refcount_inc_not_zero in igrab
  fs: use inode_tryget in find_inode*
  fs: update find_inode_*rcu to check the i_count count
  fs: use igrab in insert_inode_locked
  fs: remove I_WILL_FREE|I_FREEING check from __inode_add_lru
  fs: remove I_WILL_FREE|I_FREEING check in inode_pin_lru_isolating
  fs: use inode_tryget in evict_inodes
  fs: change evict_dentries_for_decrypted_inodes to use refcount
  block: use igrab in sync_bdevs
  bcachefs: use the refcount instead of I_WILL_FREE|I_FREEING
  btrfs: don't check I_WILL_FREE|I_FREEING
  fs: use igrab in drop_pagecache_sb
  fs: stop checking I_FREEING in d_find_alias_rcu
  ext4: stop checking I_WILL_FREE|IFREEING in ext4_check_map_extents_env
  fs: remove I_WILL_FREE|I_FREEING from fs-writeback.c
  gfs2: remove I_WILL_FREE|I_FREEING usage
  fs: remove I_WILL_FREE|I_FREEING check from dquot.c
  notify: remove I_WILL_FREE|I_FREEING checks in fsnotify_unmount_inodes
  xfs: remove I_FREEING check
  landlock: remove I_FREEING|I_WILL_FREE check
  fs: change inode_is_dirtytime_only to use refcount
  btrfs: remove references to I_FREEING
  ext4: remove reference to I_FREEING in inode.c
  ext4: remove reference to I_FREEING in orphan.c
  pnfs: use i_count refcount to determine if the inode is going away
  fs: remove some spurious I_FREEING references in inode.c
  xfs: remove reference to I_FREEING|I_WILL_FREE
  ocfs2: do not set I_WILL_FREE
  fs: remove I_FREEING|I_WILL_FREE
  fs: add documentation explaining the reference count rules for inodes

 Documentation/filesystems/vfs.rst        |  23 ++
 arch/powerpc/platforms/cell/spufs/file.c |   2 +-
 block/bdev.c                             |   8 +-
 fs/bcachefs/fs.c                         |   3 +-
 fs/btrfs/inode.c                         |  11 +-
 fs/ceph/mds_client.c                     |   2 +-
 fs/crypto/keyring.c                      |   7 +-
 fs/dcache.c                              |   4 +-
 fs/drop_caches.c                         |  11 +-
 fs/ext4/ialloc.c                         |   4 +-
 fs/ext4/inode.c                          |   8 +-
 fs/ext4/orphan.c                         |   6 +-
 fs/f2fs/super.c                          |   4 +-
 fs/fs-writeback.c                        | 105 +++++--
 fs/gfs2/ops_fstype.c                     |  17 +-
 fs/hpfs/inode.c                          |   2 +-
 fs/inode.c                               | 371 ++++++++++++++++-------
 fs/internal.h                            |   1 +
 fs/nfs/inode.c                           |   4 +-
 fs/nfs/pnfs.c                            |   2 +-
 fs/notify/fsnotify.c                     |  26 +-
 fs/ocfs2/inode.c                         |   4 -
 fs/quota/dquot.c                         |   6 +-
 fs/super.c                               |   3 +
 fs/ubifs/super.c                         |   2 +-
 fs/xfs/scrub/common.c                    |   3 +-
 fs/xfs/xfs_bmap_util.c                   |   2 +-
 fs/xfs/xfs_inode.c                       |   2 +-
 fs/xfs/xfs_trace.h                       |   2 +-
 include/linux/fs.h                       | 284 ++++++++++-------
 include/trace/events/filelock.h          |   2 +-
 include/trace/events/writeback.h         |   6 +-
 security/landlock/fs.c                   |  22 +-
 33 files changed, 607 insertions(+), 352 deletions(-)

-- 
2.49.0


