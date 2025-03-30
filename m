Return-Path: <linux-ext4+bounces-7016-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893AA758DE
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Mar 2025 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC816B288
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Mar 2025 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA982154457;
	Sun, 30 Mar 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCyXoOYh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12634431
	for <linux-ext4@vger.kernel.org>; Sun, 30 Mar 2025 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743321380; cv=none; b=M3Bz3nc6CyOfz8gZwIPkx+geVREBvlscKjcr0zIF5eYckMYY7mUiDGDs/v4p4Y99ZkTWOOWTj69GwK3Z/DL5G+NQhj41wpI4qeQa67Dx53Pj8+Z7CiN1VosSe5YjT7UpQnklZaixOJsBMToBIgmU+AWl0Fiv3Q444M9k3PGwHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743321380; c=relaxed/simple;
	bh=J1LEcIMtnZY6iYMwZHR6JMzArXcTpbOlYKHvQT5E/U8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JtjvsYyysKC31716Ur1nPI6kg9ASCUfJutweNrgNQk3C8vCaI3eYAkPqf4Zz5nOnMqhGTC7FY9hmcFI6cX5kzA/uST0xhDmAt52y/si0lIfVVUhOkTBRBeOj8TKfA8DAtCvcT/FyKxDNcZ9j9syKS0M1SfK63hbIbO6hI8zELAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCyXoOYh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227a8cdd241so33114235ad.3
        for <linux-ext4@vger.kernel.org>; Sun, 30 Mar 2025 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743321378; x=1743926178; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpZnxtf4oLZFX9H21jqDyswqtiSfv83vliWCawBg7lQ=;
        b=TCyXoOYhTCOLcp0FTQxKg4u5H1ZMwIItCwpcyJ71I2SgtGdVSHR2qtUDMEDsH49EkZ
         hWnojAqybXNerAtWAoY6174HKP7QRKb8pNu5mVnXXYMyxxt2Rr1tC/l2PVt30BpDeRI8
         5HvWtHMelEsFFJ4cvAx4RTmP96jcl5du3U0d0f3py3Gj6Ef6tkNtaHTJZiEhd4eL+yMV
         vJv5+Ry3CYtMagsWczwhHjPI0hIFSiop/je4IcHqRyihnmA2dQ2X3fRPS3wtczfTKZ1u
         /yuv01fsMdRUC/LM5xuZmaIXNJh9/NaR71Pk9ohh5dfoE34ax34Pg71E/vMBvxQv4j2Q
         sZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743321378; x=1743926178;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpZnxtf4oLZFX9H21jqDyswqtiSfv83vliWCawBg7lQ=;
        b=ilZKBlavS2ahrGos80/hyBOgQy0H/rfeJYRNGsgtLi8RsCwhmORcgkyswGpXatspp3
         2Qjo7jka/TTSH8ba3aWQ94/4NOQN3nKHW21rUmqoD47N+bx9MGs99QtSFuZWFonwdYQW
         qxMZpdJrR3iWpsZifQFjJhPdGTuRiwwVm4sWeSeUwlO2Yl6KDDTkB/FfhBs/lv6L6nwf
         tLq+2GAras0RRV4vPIZLv33SIrtzGvrFKxEgBpCZMvCVBUqcTyxLP5D2t9S0xziZKTDV
         Mn6OgI2s8Nk61dU5uv3gIYTy9QYz+8xKBGJe7+srhEKjbSXdVQLzidMrQIuQPa175mtd
         DkTQ==
X-Gm-Message-State: AOJu0Ywbb+5FdUpyN0+HP++b+W5wG5fiEfbPSas0ylMA2sa4QMI/1U2N
	YRM6/h4XbFekHso2EUpGIPGmM3kdUy0ocjRz6I+Z7kg4nODcWj6O
X-Gm-Gg: ASbGncvhQJ6Kf/XHoVlvb4fNnoTYA743D903+VwuqOXla+g4ZqjLPFEJFoqf4m3fTlB
	8GnH7TSubPEtLmqKA7BEWokbbQSIHlsNO7UJW4lUwa2UkJjAyz4iriDWeTrL5YmWJfhEkB9uaTN
	xQQWjjhKf/PX3fPC1wIkKVy5Nei4tB5YVpvzVBl1AZ8eJ6xuJvIUMQkfvWTJMmP8WbFN2RgOENR
	6eskfT42BbOlXsYsZHO+BVDOH6ySCqp9ci6wfr72ZlELlzv6tuEheoCF76jpah4U71ZEcRuSB76
	mN04K932oetW1f6c3UgJAOJg6ENdfGDo9R4F88ojPbaPjUrz4XekgBvrcqLAwM59xDmMfjKdtw=
	=
X-Google-Smtp-Source: AGHT+IGibMTl59kvVxsU2fs390YpR3n8n0mqeCHirVfrCJczg9q/DjWWTjhrVFxbxqQ+xzaWQ7KqDw==
X-Received: by 2002:a17:902:d54f:b0:224:24d3:6103 with SMTP id d9443c01a7336-2292f9e630bmr101066385ad.35.1743321378170;
        Sun, 30 Mar 2025 00:56:18 -0700 (PDT)
Received: from localhost.localdomain ([221.214.202.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cfec1sm47470115ad.118.2025.03.30.00.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 00:56:17 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.or,
	syzbot+d14b2bea87fe2aaffa3b@syzkaller.appspotmail.com,
	Penglei Jiang <superman.xpt@gmail.com>
Subject: [PATCH] ext4: Fix the issue of missing lock in ext4_page_mkwrite
Date: Sun, 30 Mar 2025 00:55:15 -0700
Message-Id: <20250330075515.37699-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

In ext4_page_mkwrite, it calls ext4_convert_inline_data, but it does
not use inode_lock to hold i_rwsem.

Fixes: 7b4cc9787fe35 ("ext4: evict inline data when writing to memory map")
Reported-by: syzbot+d14b2bea87fe2aaffa3b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67e57c6c.050a0220.2f068f.0037.GAE@google.com
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
 fs/ext4/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bcb96caf77c0..4e726c86377a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6203,6 +6203,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vma->vm_file);
 
+	inode_lock(inode);
+
 	filemap_invalidate_lock_shared(mapping);
 
 	err = ext4_convert_inline_data(inode);
@@ -6308,6 +6310,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	ret = vmf_fs_error(err);
 out:
 	filemap_invalidate_unlock_shared(mapping);
+	inode_unlock(inode);
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 out_error:
-- 
2.17.1


