Return-Path: <linux-ext4+bounces-10700-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B0BC7D86
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 09:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05D454F61EE
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 07:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEFC2D1F4E;
	Thu,  9 Oct 2025 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIb5BFDa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20262D0C7A
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996782; cv=none; b=D1JkdD3+bqDI2gol4+qB8wO2DxCi4unAcI7wu71rfDvIPoe8c5R4apTu9xRXs2JImQRI0BnANG/9CyOrRGrKA///GAXV7goVOqC9yjD3UU5hTS2Sl8A7Cv+6KqmXIpDm44NMzxjfVxWIWFDV4gDqmUNyVhUy01zruFeMd2jwiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996782; c=relaxed/simple;
	bh=8KM3XRYIjTwuzpr/lrxk58FYUfQaYzmfu1nCUPuKAcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F6gI90hFTcu2kcayzoeAXxJpllRLoR7/sJw8JN/zZZhuw0NoGPESeHwiYC9lJp57rhf8Hv9bDAJVAzcjgET9rqZgy1NUvs+TY9Lj8sgtldDQD9hXiRwH8/Soesmy4iQT/pa1mfpqEiI9nfbf7kmR0m7caZQfhDBPKr4AGjWGL/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIb5BFDa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b50206773adso323863966b.0
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 00:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996779; x=1760601579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDY30uCLUAl+2ZHS218rVwJb7fqTgFel4NJt/414PVE=;
        b=mIb5BFDa9XEUY2p+dX0mZuwiC7p+bKlkOfIsY7J6EO3dkqkqvUqxcipp2wNkgV5X3g
         e4RXNLgqzNayaZEzz0pLQqFQbg3iJZ07pQmHVfyq4lo059IJjIzAkYXW14HWSD1oX/i7
         m0urz2YXugkfEkx4YQAuug91RXH+6kmuXMiV+JI82ArveWpfA5auetoFj7GMM+Ojivac
         jEtp6K4w9Nsv46zeScoS/fXRcodhhh79GOT2Fve5VNTnMGs74ksO0tfOKOjA0JhbxhA9
         OQ75og3vdRvPzxCYMCx5doiB/8X0KPW3DH+4pMBeFl9XzPVcO7PBWD7zx8lUGLpsesDo
         D4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996779; x=1760601579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDY30uCLUAl+2ZHS218rVwJb7fqTgFel4NJt/414PVE=;
        b=V9R+sdrfIOM9T4lgqmxRZlWgrJacR6FyKYL9Lp+bAJHXqqdKYS6rNAirPAcorDFO3X
         N18JUF/0OSSrziHPnDnRO83yqYUqMmVN1zRYJc7tlrrdxWSJxXGFy+AalwdqUrAurFLN
         jxKy2G68OzfmgjTYEUDd/jOiA2uE5ZIqHN/vyO1xZMnohYUKGsHvYFqAhzBH6o6e/obn
         JA4rZzulCkWVr9nTuf37+uxrj77SqeRINMjFWMW0iny35Pd7oXY57Q+vi1F0XrkBCrdt
         NP9U6DbEjchXrlIGuGR2BgsEKGSwYHtB8l3PBPicZMh1f5ueBR1W5z+fy+1aW6pUPwmj
         EjtA==
X-Forwarded-Encrypted: i=1; AJvYcCU1PcYBH9yNYtCPCqEEriuTKmELcEqy7zQxxV9kccw8QjM1PQZtA+q11zoeOm8jpMprznNTz8zvJ4t4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7NNw3QqxK4Pvp2NQZ2Mb/xV10HhUhCxK1ff3melnziqO1vBrR
	2mtsAIChquedGbu8A4JMsyIsmNJqhWqB+4l0F0whW+4jlnYa0DUv32Aq
X-Gm-Gg: ASbGncvYcx3M/9Gx+vwLIMBA3raCgqkpdfze41oSoa10SDYCYUTjq/K+4WrgNIifMlY
	RYL0+zd3VmAWD32jXUmP64VcT2+japbv2twqnQ7pQ9d0eLWpOixTv8nadkTm4amQoSjXmnamN7p
	YmofzsrUut6juIlRiWlOHbwuZU2jpIqEVNfSgA6oApJ/Ftr3tcEXKk6ucf72g9aEsADh0PRuai+
	mQ2IoLw0473GeFArNAbU03wMpuwYUDRbKkKsIJAjXoIJ/IDrwoiOrR0xNLVHq9s3pMwwCV67V0p
	nWXcqwheBlFFyHh2d8rwqkinBGFR+K8CqZMWkAdHH2PEFSiVxI8w0s2NqCiWsP0joiyd/YP4Ql2
	op4cotVA7vwL5l0TNMWjT6m6XlwDyr1HEqT+6ol8/yrlBNvjQE/5sEnj4RQaUNXm0jT0rRmMwtm
	bXSwPgzXeZmw4In8BfSFdDZA==
X-Google-Smtp-Source: AGHT+IGCRoblKt0f/ND3yZrgi//Fmws8IyMEBWOboU8aP0sv4OpoASXW7HqSnMRjLZtNQA8UxsxpIw==
X-Received: by 2002:a17:906:794b:b0:b41:8ad3:1b5c with SMTP id a640c23a62f3a-b50bd23ebebmr891429166b.13.1759996778537;
        Thu, 09 Oct 2025 00:59:38 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:37 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v7 00/14] hide ->i_state behind accessors
Date: Thu,  9 Oct 2025 09:59:14 +0200
Message-ID: <20251009075929.1203950-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit message from the patch adding helpers quoted verbatim with rationable + API:

[quote]
Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

In order to keep things manageable this patchset merely gets the thing
off the ground with only lockdep checks baked in.

Current consumers can be trivially converted.

Suppose flags I_A and I_B are to be handled.

If ->i_lock is held, then:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)

The "_once" vs "_raw" discrepancy stems from the read variant differing
by READ_ONCE as opposed to just lockdep checks.

Finally, if you want to atomically clear flags and set new ones, the
following:

state = inode->i_state;
state &= ~I_A;
state |= I_B;
inode->i_state = state;

turns into:

inode_state_replace(inode, I_A, I_B);
[/quote]

In order to manage bisectability vs total patch count, I decided to only
split out fs conversion if manual intervention went beyond altering
inode_state_read into inode_state_read_once in a place or two.

Almost all places were patched by coccinelle generating a variant
requesting a lock, then patched up to use variants which don't expect
one as needed. Or to put it differently, if there is fallout, it should
be just lockdep complaining.

NOTES ON MERGING:

v6 got acked by Jan Kara and Dave Chinner. Given the extent of changes
made in v7 I decided to *not* add their ACKs.

More importantly though, this is generated against:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.19.inode

but that branch happens to be significantly lagging behind master,
notably it does not include some writeback changes and bcachefs removal.
Thus before generating the patchset I did a rebase on master.

Top commit at the time:
commit ec714e371f22f716a04e6ecb2a24988c92b26911 (origin/master, origin/HEAD, master)
Merge: 37bfdbc11b24 f3b601f90090
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Oct 8 19:24:24 2025 -0700

    Merge tag 'perf-tools-for-v6.18-1-2025-10-08' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools

v7:
- move wait_on_inode() to fs.h
- restructure the patchset a little bit
- add inode_state_replace()
- bring back lockdep now that the merge window was missed

v6:
- rename routines:
set -> assign; add -> set; del -> clear
- update commentary in patch 3 replacing smp_store/load with smp_wmb/rmb

v5:
- drop lockdep for the time being

v4:
https://lore.kernel.org/linux-fsdevel/CAGudoHFViBUZ4TPNuLWC7qyK0v8LRwxbpZd9Mx3rHdh5GW9CrQ@mail.gmail.com/T/#m866b3b5740691de9b4008184a9a3f922dfa8e439

Mateusz Guzik (14):
  fs: move wait_on_inode() from writeback.h to fs.h
  fs: spell out fenced ->i_state accesses with explicit smp_wmb/smp_rmb
  fs: provide accessors for ->i_state
  Coccinelle-based conversion to use ->i_state accessors
  Manual conversion to use ->i_state accessors of all places not covered
    by coccinelle
  btrfs: use the new ->i_state accessors
  ceph: use the new ->i_state accessors
  smb: use the new ->i_state accessors
  f2fs: use the new ->i_state accessors
  gfs2: use the new ->i_state accessors
  overlayfs: use the new ->i_state accessors
  nilfs2: use the new ->i_state accessors
  xfs: use the new ->i_state accessors
  fs: make plain ->i_state access fail to compile

 Documentation/filesystems/porting.rst |   2 +-
 block/bdev.c                          |   4 +-
 drivers/dax/super.c                   |   2 +-
 fs/9p/vfs_inode.c                     |   2 +-
 fs/9p/vfs_inode_dotl.c                |   2 +-
 fs/affs/inode.c                       |   2 +-
 fs/afs/dynroot.c                      |   6 +-
 fs/afs/inode.c                        |   8 +-
 fs/befs/linuxvfs.c                    |   2 +-
 fs/bfs/inode.c                        |   2 +-
 fs/btrfs/inode.c                      |  10 +--
 fs/buffer.c                           |   4 +-
 fs/ceph/cache.c                       |   2 +-
 fs/ceph/crypto.c                      |   4 +-
 fs/ceph/file.c                        |   4 +-
 fs/ceph/inode.c                       |  28 +++---
 fs/coda/cnode.c                       |   4 +-
 fs/cramfs/inode.c                     |   2 +-
 fs/crypto/keyring.c                   |   2 +-
 fs/crypto/keysetup.c                  |   2 +-
 fs/dcache.c                           |   8 +-
 fs/drop_caches.c                      |   2 +-
 fs/ecryptfs/inode.c                   |   6 +-
 fs/efs/inode.c                        |   2 +-
 fs/erofs/inode.c                      |   2 +-
 fs/ext2/inode.c                       |   2 +-
 fs/ext4/inode.c                       |  10 +--
 fs/ext4/orphan.c                      |   4 +-
 fs/f2fs/data.c                        |   2 +-
 fs/f2fs/inode.c                       |   2 +-
 fs/f2fs/namei.c                       |   4 +-
 fs/f2fs/super.c                       |   2 +-
 fs/freevxfs/vxfs_inode.c              |   2 +-
 fs/fs-writeback.c                     | 123 +++++++++++++-------------
 fs/fuse/inode.c                       |   4 +-
 fs/gfs2/file.c                        |   2 +-
 fs/gfs2/glops.c                       |   2 +-
 fs/gfs2/inode.c                       |   4 +-
 fs/gfs2/ops_fstype.c                  |   2 +-
 fs/hfs/btree.c                        |   2 +-
 fs/hfs/inode.c                        |   2 +-
 fs/hfsplus/super.c                    |   2 +-
 fs/hostfs/hostfs_kern.c               |   2 +-
 fs/hpfs/dir.c                         |   2 +-
 fs/hpfs/inode.c                       |   2 +-
 fs/inode.c                            | 106 +++++++++++-----------
 fs/isofs/inode.c                      |   2 +-
 fs/jffs2/fs.c                         |   4 +-
 fs/jfs/file.c                         |   4 +-
 fs/jfs/inode.c                        |   2 +-
 fs/jfs/jfs_txnmgr.c                   |   2 +-
 fs/kernfs/inode.c                     |   2 +-
 fs/libfs.c                            |   6 +-
 fs/minix/inode.c                      |   2 +-
 fs/namei.c                            |   8 +-
 fs/netfs/misc.c                       |   8 +-
 fs/netfs/read_single.c                |   6 +-
 fs/nfs/inode.c                        |   2 +-
 fs/nfs/pnfs.c                         |   2 +-
 fs/nfsd/vfs.c                         |   2 +-
 fs/nilfs2/cpfile.c                    |   2 +-
 fs/nilfs2/dat.c                       |   2 +-
 fs/nilfs2/ifile.c                     |   2 +-
 fs/nilfs2/inode.c                     |  10 +--
 fs/nilfs2/sufile.c                    |   2 +-
 fs/notify/fsnotify.c                  |   2 +-
 fs/ntfs3/inode.c                      |   2 +-
 fs/ocfs2/dlmglue.c                    |   2 +-
 fs/ocfs2/inode.c                      |   4 +-
 fs/omfs/inode.c                       |   2 +-
 fs/openpromfs/inode.c                 |   2 +-
 fs/orangefs/inode.c                   |   2 +-
 fs/orangefs/orangefs-utils.c          |   6 +-
 fs/overlayfs/dir.c                    |   2 +-
 fs/overlayfs/inode.c                  |   6 +-
 fs/overlayfs/util.c                   |  10 +--
 fs/pipe.c                             |   2 +-
 fs/qnx4/inode.c                       |   2 +-
 fs/qnx6/inode.c                       |   2 +-
 fs/quota/dquot.c                      |   2 +-
 fs/romfs/super.c                      |   2 +-
 fs/smb/client/cifsfs.c                |   2 +-
 fs/smb/client/inode.c                 |  14 +--
 fs/squashfs/inode.c                   |   2 +-
 fs/sync.c                             |   2 +-
 fs/ubifs/file.c                       |   2 +-
 fs/ubifs/super.c                      |   2 +-
 fs/udf/inode.c                        |   2 +-
 fs/ufs/inode.c                        |   2 +-
 fs/xfs/scrub/common.c                 |   2 +-
 fs/xfs/scrub/inode_repair.c           |   2 +-
 fs/xfs/scrub/parent.c                 |   2 +-
 fs/xfs/xfs_bmap_util.c                |   2 +-
 fs/xfs/xfs_health.c                   |   4 +-
 fs/xfs/xfs_icache.c                   |   6 +-
 fs/xfs/xfs_inode.c                    |   6 +-
 fs/xfs/xfs_inode_item.c               |   4 +-
 fs/xfs/xfs_iops.c                     |   2 +-
 fs/xfs/xfs_reflink.h                  |   2 +-
 fs/zonefs/super.c                     |   4 +-
 include/linux/backing-dev.h           |   5 +-
 include/linux/fs.h                    |  99 ++++++++++++++++++++-
 include/linux/writeback.h             |  13 +--
 include/trace/events/writeback.h      |   8 +-
 mm/backing-dev.c                      |   2 +-
 security/landlock/fs.c                |   2 +-
 106 files changed, 395 insertions(+), 315 deletions(-)

-- 
2.34.1


