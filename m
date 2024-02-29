Return-Path: <linux-ext4+bounces-1433-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E52F86CB6E
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 15:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46981F25E6B
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E213136647;
	Thu, 29 Feb 2024 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtcduGf/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0512FB0B
	for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216665; cv=none; b=N3hETBVN7v2lYqUEe6HZqdRDdTPzaUL2oZU7EOZSPIque9lrjiAUIlPxbyl1j1NUcQjh89DiBJEx5oFfM6ek/gGSQ9knxidr+u19Spg/lk0ubW8BxxnrP6IC+LjBxaoAyzf49NeZUtTnkxY1zy6bqI/NL5Dv4DEkSUDWGiaT8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216665; c=relaxed/simple;
	bh=iekEPTmQteBtjTG7D3blaVP/ayR2+DAqjKW89ic8p1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MvqyP9yqaM5tybQCtepTaHIJOfwtpzYldlB3v+1Bu3Hu4msnRZS9sYsIjogIQCMu9jfklSlOiQAZgKMe/DEbWCe+zbiP0T33CeOBarg9QBvMXBWY0ldg6zWmahCoZAbg6tuObRNE6AKZF0AyYv3iUT2yILe/Sr0IxJN961TcnJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtcduGf/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e581ba25e1so752022b3a.1
        for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 06:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709216662; x=1709821462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qu3U8IuSgRhuL6lhNV0IIoBjHo1cngp25DTu7fDPeiY=;
        b=mtcduGf/aQHIdZ74YxOybIJwGYcV1HLnFco/veKEZHyNbGdidYsb0//fEfrmXTt/yQ
         KgCraE6rnIbjHtWIYVmThSaOA1sYqHEWN5JyiUJdPYKWYKbU87CDQoiOnYnv4/Otf79v
         jgttawaMEy3SrN1RULX9ZmMDPTg+OwmaJO+/HjJL4EG0TloHjXCd9ik3MmTJP07VaILb
         wc2gtsz8Vs9w08sVOPHsUnnZbaYtdDjamGAyVajGpcjVqTCy/Hq/CG8h3KMCA9B0P3bf
         bqwPCtOLn3fqv2bYAwkP6NMpHJ6QfU+E4J5Jwi/XfC+2R65CMsN6ddssVzD0KeLYYBoL
         sLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216662; x=1709821462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qu3U8IuSgRhuL6lhNV0IIoBjHo1cngp25DTu7fDPeiY=;
        b=WTYqEK+98q88ZxiWd6X/kZGn2o6DfGrycNxYQwhh5fbu+lZyS8Hs1y3sFE0qstOv3e
         8ndzPOh3Axz4cxPPEI7epOvgpwGIYitYoLLnZUZtJgOejtqgQpUJCLBSSSeJ3386RDCI
         Xnub7c2gNSIiePSNbXp7jF6R2mTyhUCu/0sdUZVPI4vvLvWAdxUjzMaiEucCzHEULnBm
         3XJgJPv8HGXNindwsVa/EosYju9PgDbC/n/uexrI139d+BoL4xLYUv8xUCq8i65GHbPe
         h8swwSoIS6SS135wKRJ2vR9hSBHJV26N76Bh50UQ7kWwpoAqEYY6/YU4iqfP/AGID/6a
         NmMg==
X-Gm-Message-State: AOJu0Yzd+T9oyzezCXiBDWS4ykFgfvRvxpS4jeaGHE18hRe/jg1WTJ/Q
	XcfP0j/njfYmIsWcO9zebUPrt3TCqY/H3mLLXoFvpHnaCAewWFTaZTXiIbK/tOQ=
X-Google-Smtp-Source: AGHT+IFJjBr8/SQiaav8xld6BxO8N2vBa72d21C5CPmY42Ts6Lc2p9wJ4JYWXApr/x0RImqZQhorLg==
X-Received: by 2002:a05:6a00:4b4e:b0:6e4:c592:deaa with SMTP id kr14-20020a056a004b4e00b006e4c592deaamr2702475pfb.11.1709216661673;
        Thu, 29 Feb 2024 06:24:21 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79911000000b006e58920c58asm1306693pff.185.2024.02.29.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:24:20 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH 1/2] ext4: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
Date: Thu, 29 Feb 2024 19:54:12 +0530
Message-ID: <e5797bb597219a49043e53e4e90aa494b97dc328.1709215665.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
wiring up a dummy direct_IO method to indicate support for direct I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[RH: Rebased to upstream]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
Stumbled upon [1], while I was trying to enable this flag in ext4_file_open().
Looks like it might have slipped through the cracks.
Hence sending this patch with Christoph as the author.
[1]: https://lore.kernel.org/linux-ext4/20230612053731.585947-1-hch@lst.de/

 fs/ext4/file.c  | 2 +-
 fs/ext4/inode.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 54d6ff22585c..965febab1d04 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -886,7 +886,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 	}
 
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC |
-			FMODE_DIO_PARALLEL_WRITE;
+			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
 	return dquot_file_open(inode, filp);
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2ccf3b5e3a7c..60a03b2ca178 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3530,7 +3530,6 @@ static const struct address_space_operations ext4_aops = {
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
 	.release_folio		= ext4_release_folio,
-	.direct_IO		= noop_direct_IO,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
@@ -3547,7 +3546,6 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_journalled_invalidate_folio,
 	.release_folio		= ext4_release_folio,
-	.direct_IO		= noop_direct_IO,
 	.migrate_folio		= buffer_migrate_folio_norefs,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
@@ -3564,7 +3562,6 @@ static const struct address_space_operations ext4_da_aops = {
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
 	.release_folio		= ext4_release_folio,
-	.direct_IO		= noop_direct_IO,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
@@ -3573,7 +3570,6 @@ static const struct address_space_operations ext4_da_aops = {
 
 static const struct address_space_operations ext4_dax_aops = {
 	.writepages		= ext4_dax_writepages,
-	.direct_IO		= noop_direct_IO,
 	.dirty_folio		= noop_dirty_folio,
 	.bmap			= ext4_bmap,
 	.swap_activate		= ext4_iomap_swap_activate,
-- 
2.39.2


