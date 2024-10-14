Return-Path: <linux-ext4+bounces-4582-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8445399CC56
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Oct 2024 16:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D0D1C20A70
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Oct 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B811B85DF;
	Mon, 14 Oct 2024 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6EPQcLb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7F1AAE27
	for <linux-ext4@vger.kernel.org>; Mon, 14 Oct 2024 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914820; cv=none; b=rG/pJjPbGIUwG8azb6raLp2vZKyWUNpHXuHT0X9g0L/Y12Bayo6fJ3KPc6PPnORwUr5e+XlH5amNez2Oi7X0pWG3Lho4DiN9us3EQX7WQ9iS0dMOhffRCwtAsDyrhd/kJpujtBTJrwTejTFYD1zW5oAAXdHbuxmiWGlb3Z04I/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914820; c=relaxed/simple;
	bh=GIKnbtw4OjDW9HBIpIyoV6sIvD+rqilVIhmp/nIyNOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WnElTknTgk5zZQGS0FbpSCew9AMcmR7Gj0E2S0wHQm+UAtFy24ULvv1vgPDyiDGDx3WloY1k8h6IVyFUqxAVFklqI+n+qAF2pXkK6wTBxr+OiQ9aVw/kt7O8asD7vcw5UP/P/Fw451+x8//hlJzWCtQwcJcmm4DD5e0MWItTfZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6EPQcLb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so2539697a91.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Oct 2024 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728914818; x=1729519618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4P3xkPM1jmi3GRwPuh1lej8JCImCz9xzR5FLPmVmk4c=;
        b=X6EPQcLbXpxGeVajxCse3fAYazLcSC2gJq3Px//ErMA/b+gy2+8URkcZu8Zbo06jjq
         B2qKIt1Dqmlq8mYPnvyoPkehk84A9xWyJt56/2+PLyNdLEHl0hFkBcfeNJChTSggpIa3
         +bznaBhp9c52HDjZ4ggaf0Ot9E1selVUVAjNypALffzK3Rz+4/+wVNb8KhkvmK9SHV16
         18ilx3npIGsbZAxuAZPJZf/LuFezmTaiYxIF7+pE+73900rzgjCCBKvVhTzjYNaak+ej
         EB4Ur/2KHpFQQNe4aODXDN7islP3v1vvIUHiNcw/ALk1ULdy2blN8VuSYLDNCwES12fr
         B1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914818; x=1729519618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4P3xkPM1jmi3GRwPuh1lej8JCImCz9xzR5FLPmVmk4c=;
        b=LZdgLQCdoOnKWkjBK7awBdunCVBKx7yByILg8GU5OagFW1V9Xs2gJUH7TpKFs+ic4w
         q7EyctCw2eNI7A6JdK0yoyuOnUJ347NcFx3MEM+oMQckI+YJkbVh4teEKLoJr0i81uGn
         EAFsDct8eE5yBgWUyHQ6kj96qOkkHWVOZT2FQgJmOHXUSmP9zAEg/tF2u1eH39KT3N/2
         wBfrWeI3FtItLBZle34FLwZ1n9puT1YQNQrYLrzWFh0mrVfySJrv7Ovpn5o8jVpVigM/
         Xz7S5d83vd46AUZkVbhVXiCDt8yBDShuVkhXXaFHa7cq3BZq0xpYpzG8KgXL6TkBIkHz
         Il4g==
X-Gm-Message-State: AOJu0YwkOgupB4FXoM6PPXawP3qkL28k+lo31+Flq46mGG6uJ71UIe5L
	Gf9k0I9OfPYOVKTZ2vBpBgd55Ch3rFI2ovN6HSPp46f9TEQ5kJa+
X-Google-Smtp-Source: AGHT+IGzyg3+gvwiU74wK763goJL2aLixliL9Ng+wnvGaC0+AQkJP+WfB3kK0V+jhnIaVMkYTnT2Cg==
X-Received: by 2002:a17:90a:b311:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2e2f0a488a0mr17956584a91.3.1728914818326;
        Mon, 14 Oct 2024 07:06:58 -0700 (PDT)
Received: from debianLT.home.io (67-60-32-97.cpe.sparklight.net. [67.60.32.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5dd2b4esm8897419a91.9.2024.10.14.07.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:06:58 -0700 (PDT)
From: Nicolas Bretz <bretznic@gmail.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Nicolas Bretz <bretznic@gmail.com>
Subject: [PATCH v2] ext4: inode: Delete braces for single statements
Date: Mon, 14 Oct 2024 07:06:54 -0700
Message-Id: <20241014140654.69613-1-bretznic@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl warnings - braces are not necessary

Removed trailing whitespaces introduced in v1

Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
---
 fs/ext4/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 03c2253005f0..1c1c1ccc8a0c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -440,11 +440,11 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 	 * could be converted.
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		retval = ext4_ext_map_blocks(handle, inode, map, 0);
-	} else {
+	else
 		retval = ext4_ind_map_blocks(handle, inode, map, 0);
-	}
+
 	up_read((&EXT4_I(inode)->i_data_sem));
 
 	/*
@@ -453,7 +453,7 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 	 */
 	if (es_map->m_lblk != map->m_lblk ||
 	    es_map->m_flags != map->m_flags ||
-	    es_map->m_pblk != map->m_pblk) {
+	    es_map->m_pblk != map->m_pblk)
 		printk("ES cache assertion failed for inode: %lu "
 		       "es_cached ex [%d/%d/%llu/%x] != "
 		       "found ex [%d/%d/%llu/%x] retval %d flags %x\n",
@@ -461,7 +461,6 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 		       es_map->m_pblk, es_map->m_flags, map->m_lblk,
 		       map->m_len, map->m_pblk, map->m_flags,
 		       retval, flags);
-	}
 }
 #endif /* ES_AGGRESSIVE_TEST */
 
@@ -547,11 +546,11 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * file system block.
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		retval = ext4_ext_map_blocks(handle, inode, map, 0);
-	} else {
+	else
 		retval = ext4_ind_map_blocks(handle, inode, map, 0);
-	}
+
 	if (retval > 0) {
 		unsigned int status;
 
-- 
2.39.5


