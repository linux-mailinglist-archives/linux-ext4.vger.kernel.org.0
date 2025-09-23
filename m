Return-Path: <linux-ext4+bounces-10366-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F8DB957D4
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 12:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7833B065F
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2713218C7;
	Tue, 23 Sep 2025 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBo+ivWt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355D31D741
	for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624447; cv=none; b=k9sMZueeS0fT4+AxLWACB9iM5khieM3eJtcEHKronyrnpuTh6QvZb3CMkz5PpH1JRncQoQv0aYoTlK+uSfP/HatY5l+cjSKmsq2paP7xlvEkXlicb/uAHlLjxSnlEoYhjOVmkf4S9BtDuiiQcAgpPJiAHQfh4OSxhkkgn6u9qbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624447; c=relaxed/simple;
	bh=y/G4XbLsOtwbe7wZLOUdsUIV02Do/ytAsS2jVq680LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVzHOiNgFdTwMzrWpV7cQ3Q0W6gN/mREsfGmrB/EcRCfAZsaMkoexsd1dHLZBSNydOs1IECVLD7hK8qs1+SRLczRY+UrU1+hgZMCVIZz3IoYyGZRZ6+ehMPtahVYiAygLwGBcjZ0EHozpjpMu4TzgWjv699hMinlEJbxXhdPuLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBo+ivWt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46cb53c5900so25881825e9.3
        for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758624442; x=1759229242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ/yJT0cXoTi93BkEkS2U1cj1fcL5N5BV/EnPhmld9E=;
        b=TBo+ivWtKLw2hvE4/ADdLULoCxdkqBngZ17HuFzdjLfw12wejEHkhAMxEp3Ee+g4r/
         QkY+gyF49Zdjshfp2GkfrTXeAkGqlPQPAwE5XnEKSBlx7KePFyhqCq5xtq2poZu3WhTU
         tosNaDOevVyDAjGj57CGR/WNm4sSmAc1pvRLpDxuXhPArh3IRdKSfwacAoyRWbOsMVEL
         +35zAFhSYquvoPUN4+OUJngaR3cg/BGoGVAU9OQF/nMXU6B0pjoZeTUj1l7jRA9Li5nm
         cslIYloBZQl8e+x/dmZ4oq3JQBz6BExLlD7Qx/73qgdd+i3Wit9F0JWCDrQ/QGaSftPX
         bGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624442; x=1759229242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ/yJT0cXoTi93BkEkS2U1cj1fcL5N5BV/EnPhmld9E=;
        b=l1BVtoHeplbXhR6C3nm2hlYNttvw5JisX0iP/Kgxn9l/VKPQob+4J7f6yHLTnqRutg
         SM+UTij8t3J4LtvDLBL3E8a6l8bYk5yoPeUvMSd2y4hXBglYNJzsL7COA4D8chyibVPh
         bXtrjICvXdzrOjRfYutDzbonISUNTZE7Khdf7V6ABMk0ZRa8DXO7G4V8hPxKHO5xWGJx
         BMHs+PqdVN+Q2YX/Xsg5d5ci8uD1K0CMtvOdtAgzNtwhLw8nKBt79vx6tlH2hkOSJmoh
         qU4rjM20abVmc8bH7u9YK8QUn54T/uc6GFt0crZH5jv7kpaThVRKbCsEJwWu85+YcC5D
         ANoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzvxIet3j2zBclNtvTzDLqAtS6EG4fHuo8InpXy/3tWmxChBbnp1jOqtuZvmsZWij0oxiUsTmNuU2E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ijcw6UnuJr/asyuCfpkErAZkRUOUJdnO7slA7IISqev6Ol/h
	lhxjGtMKiilf4CLztIAEIKx3wsYkTYPqyR9FWLKwwt2Zc8zObn707CXk
X-Gm-Gg: ASbGnctX/Hu130ggZQxDf2rV3I+U4rTWjqjNK6Q8yZGOZ03VSuaUrpKSSCjJ0+yEJae
	eUBNmlxldlR8F5VHSN11jERlC/Q0fnlh0GvxHu+W2Zh69iAYuV1wyl7ls/GkwEVgy31ZDxk5o93
	u8oR0WuSuby91KsJV+oR6G8aerY892RUI81QAWKQLRXegiW2VXja/MxMNGwmNJ3Q2j9M+tYVdJz
	u6rvSnhHWhoLAfgj6sRTyCNFT00Vhr3cjYDWzAfEmwhqIYZaeBFQswgua2Vlk9fotu4eZfkAOdv
	O9euqUMVSn3hDwtVKDvAql07SxFxTRZuGkzh9hAnNJDYBu0O+VQqbyAap8r0fWHpBiZ2eTmphXk
	JAjA8rj3bzKLU9bOPXEPMUMFkzKVlFRGeWJkroYo03hZvc/vNkVW3VEK6txJPdWuba4I0bw==
X-Google-Smtp-Source: AGHT+IGft/P7UVkw9hjNEMIp8gNGN2bfm7hLyZ+3GJgcSiUgUNJfZvWbxjLWOrPgRhiQYwqyWsexaA==
X-Received: by 2002:a05:600c:3baa:b0:46e:1f92:49aa with SMTP id 5b1f17b1804b1-46e1f924cd6mr18699845e9.15.1758624442124;
        Tue, 23 Sep 2025 03:47:22 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e23adce1bsm9710525e9.24.2025.09.23.03.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:47:21 -0700 (PDT)
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
Subject: [PATCH v6 0/4] hide ->i_state behind accessors
Date: Tue, 23 Sep 2025 12:47:06 +0200
Message-ID: <20250923104710.2973493-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)
[/quote]

Right now this is one big NOP, except for READ_ONCE/WRITE_ONCE for every access.

Given this, I decided to not submit any per-fs patches. Instead, the
conversion is done in 2 parts: coccinelle and whatever which was missed.

Generated against:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries

v6:
- rename routines:
set -> assign; add -> set; del -> clear
- update commentary in patch 3 replacing smp_store/load with smp_wmb/rmb

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
 include/linux/backing-dev.h           |   7 +-
 include/linux/fs.h                    |  42 ++++++++-
 include/linux/writeback.h             |   4 +-
 include/trace/events/writeback.h      |   8 +-
 mm/backing-dev.c                      |   2 +-
 security/landlock/fs.c                |   2 +-
 107 files changed, 345 insertions(+), 307 deletions(-)

-- 
2.43.0


