Return-Path: <linux-ext4+bounces-10302-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F64B8A64D
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242153B9FAA
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399EC31D738;
	Fri, 19 Sep 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN0uEklB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C451E5718
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296955; cv=none; b=VK7S2wtAdPOzRjJcyeKshlPP8UCObgBC3WAY19/dXaUkAook2/mJBtqSeR5NWgK8beeeN0y6jKDLi96FGP+rXakMcVlq+E2qWxrZmI1zY9AhKKd19xzaHc+tg8+EQGUvp9/vnAd7nwv/IMydnlOcbvkzcs+pqFu2tu6qvIeoVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296955; c=relaxed/simple;
	bh=WzMigsI8XU1Mz2+AbYO0H8GUDTcyXuAAvNIV83fgeQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAVehHHFwhQGuIP/6GqD5ji7hWdHkDRxwLhZ5aqlTqn++cUNx3LrWXJsBFdKbHSs0da31xYDze87P6z7pi34EZP5SVIGvW/OaCE1giU4IF2bE8QMo+Mz52bJ9hJ95OLJSEDM3m3UviVI2CR5ZJLp0Gi4XiBe+MYO+tSf8NVw6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN0uEklB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4619eb182c8so21404755e9.1
        for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296952; x=1758901752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CXzD2xToz4myOdiuXS9HZSpzaqk5AwYCBtvdB4YBjyk=;
        b=PN0uEklBHgpCgn//Emm0AXpUS6cZUg637Lj00tnQ+t6su9H1XK1u++Ghm1I0boekgj
         FLOm+I2Pwn97z7zB/jR1H9OC9OoaZYIyaezc5AtmjKWvSwxPwD9a6CQJoiOub08SKoLf
         SS3/33ifcVRO6ynEuof8X05nYkfxB+qsjUXs7wafjdOreLxs2kE688XnhrXOq9VSfcuL
         cFwz4mw8u8waEjcaWj7kBHHf8XS3FuNLjKeHdz/nqwaBEdYNpVoPbZDRSfX8gvxTQDy2
         vLb+kBf0GmeAjTZPH9TBfD+406kFlG7fxWfonYiQtHFE8p3K+qX0IzIIA/+30kGfNMW+
         9NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296952; x=1758901752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXzD2xToz4myOdiuXS9HZSpzaqk5AwYCBtvdB4YBjyk=;
        b=It511Qz2Vw9ae+jOJPOaMMOyyraZUV64V1LiONcfxyNYDTIY+ewj1iOB4A3W7k7L6U
         Qvq6W2lnW/C63De45XlwwAttaPiCosTtrvsBdiwwoOI/DPd+HAQMVQQvMt1mvIKbDB6h
         EkMSJuruSbeRsN4yhPwPr7/1xeW5KhdjeWt6FNTMYeLpjIlkrEzqEbqJSwobRBj373dT
         b5aRW2irOoGVgS6LmCeTyI7+jr/qMy8MUBxq+S2yWd6EgNC1n9G8D8UV8LNwBaiAaC/s
         SWn2vp7A4W6mZqG3VhSqP9VBKrx3JVhMd8qLZxpvN4fGKP0na8sE23KnLOVRstgIS7GT
         3hcg==
X-Forwarded-Encrypted: i=1; AJvYcCWA+ZQhz2uoDxWPA+jTYwueRVvNpuTLNmpU2gs5CEWJSjQxV0J4YHQU7n3ZqIX4cT2P9PaJyMUvpH5h@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpP0XMfYMsRhKGSlVrPNVQqBw6rAaaO5MwEKVxe3G9SdYQhCs
	JayApzIsdQQT0ZNikR73AdNEk7jzWIYibL5mLtaJ0M1H+85M75Ar980U
X-Gm-Gg: ASbGncvlcG14AJ01oUtfUVB2Hu9uY0424m/jIaYWqnvMV5k5oQKEgvzg+a2sXLHuWE/
	shf/9b6GWSk7qAzdMopyMUFOM/jZE8ZIztEE/+ndp8n1dwhUVSFrac2mKbCCrwD4jeADkqhhHWr
	Wc2FzT7A7WJ5vGEaMu5joUT+lqDksdEG0MO24PggxsmuJ2n22jD9qFDdP6T8NuzL4+Xf/bpl5l1
	mh6FCezInP2a1g6zFEID/FQPTKDdNKGKIdbGHqVYHVQBYlZaPa8RYnU1XjROzO5ccbfTd9+0XJO
	fSujlxQNnP1Fjvrmn6esJHE/VLcDEmtyxhvnM3vAisX+QZJF6Q2lcHaMb/X3MSFghg+yF6EoLmF
	Uitb0eAcjxKXZ9BDnWU6fCDmp5+i5rV/qbmz4MblHNyYLPrliGp4zydVbJouS0jX+ee3aIORNzK
	m48K838TE=
X-Google-Smtp-Source: AGHT+IEbFuXtdTSkzWivIeO3XAAKwZOU9is/JOJp4hfdLKzSu67HGXZJVYrLPblPcD5dEqny6zTaoA==
X-Received: by 2002:a05:600c:45c9:b0:45f:286e:49a8 with SMTP id 5b1f17b1804b1-467eaa88162mr40026405e9.30.1758296952033;
        Fri, 19 Sep 2025 08:49:12 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm8446746f8f.3.2025.09.19.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:49:11 -0700 (PDT)
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
Subject: [PATCH v5 0/4] hide ->i_state behind accessors
Date: Fri, 19 Sep 2025 17:49:00 +0200
Message-ID: <20250919154905.2592318-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is generated against:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries

First commit message quoted verbatim with rationable + API:

[quote]
Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

Given the late stage of the release cycle this patchset only aims to
hide access, it does not provide any of the checks.

Consumers can be trivially converted. Suppose flags I_A and I_B are to
be handled, then:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_set(inode, I_A | I_B)
[/quote]

Right now this is one big NOP, except for READ_ONCE/WRITE_ONCE for every access.

Given this, I decided to not submit any per-fs patches. Instead, the
conversion is done in 2 parts: coccinelle and whatever which was missed.

v5:
- drop lockdep for the time being

v4:
https://lore.kernel.org/linux-fsdevel/CAGudoHFViBUZ4TPNuLWC7qyK0v8LRwxbpZd9Mx3rHdh5GW9CrQ@mail.gmail.com/T/#m866b3b5740691de9b4008184a9a3f922dfa8e439

Mateusz Guzik (4):
  fs: provide accessors for ->i_state
  Convert the kernel to use ->i_state accessors
  Manual conversion of ->i_state uses
  fs: make plain ->i_state access fail to compile

 Documentation/filesystems/porting.rst |   2 +-
 block/bdev.c                          |   4 +-
 drivers/dax/super.c                   |   2 +-
 fs/9p/vfs_inode.c                     |   2 +-
 fs/9p/vfs_inode_dotl.c                |   2 +-
 fs/affs/inode.c                       |   2 +-
 fs/afs/dynroot.c                      |   6 +-
 fs/afs/inode.c                        |   6 +-
 fs/bcachefs/fs.c                      |   8 +-
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
 fs/fs-writeback.c                     | 121 +++++++++++++-------------
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
 fs/inode.c                            | 100 ++++++++++-----------
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
 fs/ocfs2/inode.c                      |  10 +--
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
 include/linux/backing-dev.h           |   3 +-
 include/linux/fs.h                    |  42 ++++++++-
 include/linux/writeback.h             |   4 +-
 include/trace/events/writeback.h      |   8 +-
 mm/backing-dev.c                      |   2 +-
 security/landlock/fs.c                |   2 +-
 107 files changed, 342 insertions(+), 304 deletions(-)

-- 
2.43.0


