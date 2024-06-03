Return-Path: <linux-ext4+bounces-2753-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB98D83B1
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 15:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8801C20E59
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C0884D0F;
	Mon,  3 Jun 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYkAomWC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A212D747
	for <linux-ext4@vger.kernel.org>; Mon,  3 Jun 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420532; cv=none; b=cNpVcpuaszRkSM48kng9cxWSSTvTOL5vhRlhVhUXtj6xlzb63avupcmskwUyuhRrdYrgdQtEtCEwm4eITAE2oUYMeVA0WLVtjtfzjdkbrK+fdhZv29Xtur842W77c3FS3NiTPLFTeLDB6+uCqpM3A1La76ADr/kwq6bj5YaJmBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420532; c=relaxed/simple;
	bh=VAEsm378SBRwNjuOF2HT7ky+qTZcNBnlsUKg7NdlCFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FHpmoSu6ijEZoN02Jy8FneESg7QV9uirswAsradzZJVLjo2cByG2uctu3uAoiQ51dNyXeQ24nHmOwLZRlR4UHzONCOTRWgFh5caoqTcGB9KxAdK9D/n5kZXhJpToECm9624ILDQh/6MXcIKbRaPr9A7UQpW09LKJ9qBJoj1tyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYkAomWC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f44b45d6abso30594495ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 03 Jun 2024 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717420530; x=1718025330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/AppQrtGjIHDChNDICJ5hJRi1+uzDCNcLrYoDw3em8=;
        b=jYkAomWCLtIAYtVxISf0KAWCGOe7xf19WVzU90RmBC1fG6ykubrwYJVal34zZHUUks
         Qd8rdQ8yU/6o/mccLVXBqjv41eB2kJG4qbT13FuvkPDztwnQzfL9nNwXer8itcW/pYQ2
         +6nyDHWzePaB+jC6WpZyMvHg5Dd0G9BfzKZQKMSET8iQj8OvNN2FCbQgAfpLbFAxym80
         rmzjAgZatQ9mO15iHPh6aOZ+QWqKit+cPImlPtCi5vRFljBSoANFYzVu+VSisShoFPQt
         UQeJW7d8or0jNGVXKRVVKwYUaRdpoo8zj3YCyS9EX9xhA6VAioM8yFOckmxSq7XGuHn5
         Ca4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717420530; x=1718025330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/AppQrtGjIHDChNDICJ5hJRi1+uzDCNcLrYoDw3em8=;
        b=g4IG7IScgdufhPtOybAy04jZbB8fZQsT7/HBR0YHBM3QzlSpjmsrY+GybCG8wD31iw
         MWSUiXaZiSjGG19Z4ZLtPpCGWau646NvxfS1Xj9ncnDamc8Jnjf6AeIRciAjjLkk55gf
         6aZQWLV1ZxLS1IZTHXNfuqrT3fwwKeZskUcJxSVf59BeiFB+vsWK5M8HWTokDwyziAtd
         OiZmKor4WpXVr0EjGEgS9CN9f187lKUzVSH3XSA37Hf6/h5bjgpkjwbjC8kQ4N8q6Clc
         Hk3C/5m6Mq++U2fOtgtRffUG8SSYDxC74qSjQMb5SSSTQDYLGzZit1s6j3areCxyRtrv
         j+Qw==
X-Gm-Message-State: AOJu0Yw2G6CJlkkIE5m9SmFoMwPvydKzoD7wbRRZmyrRvn48qjLZNmQt
	69o3teIH2evv5RfUmMPmJ1UfX0bvZaJ7fsocNzG+AWXFDuo3hgpd23XwXwca
X-Google-Smtp-Source: AGHT+IH7UwQmKRdlRrlWWVPZDMtgczK8T5Bd8f2w0Zm20Bzgo8BJ/q3hpDTiLZK9llF42zJ1Lco8oA==
X-Received: by 2002:a17:903:2442:b0:1f6:565f:2779 with SMTP id d9443c01a7336-1f6565f28ecmr61524885ad.61.1717420529472;
        Mon, 03 Jun 2024 06:15:29 -0700 (PDT)
Received: from localhost ([123.113.100.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63237a319sm64305415ad.109.2024.06.03.06.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:15:29 -0700 (PDT)
From: Junchao Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	Junchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] ext4: Adjust the layout of the ext4_inode_info structure to save memory.
Date: Mon,  3 Jun 2024 21:15:24 +0800
Message-Id: <20240603131524.324224-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using pahole, we can see that there are some padding holes
in the current ext4_inode_info structure. Adjusting the
layout of ext4_inode_info can reduce these holes,
resulting in the size of the structure decreasing
from 2424 bytes to 2408 bytes.

Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/ext4.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 023571f8dd1b..42bcd4f749a8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1055,6 +1055,7 @@ struct ext4_inode_info {
 
 	/* Number of ongoing updates on this inode */
 	atomic_t  i_fc_updates;
+	atomic_t i_unwritten; /* Nr. of inflight conversions pending */
 
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
@@ -1103,6 +1104,10 @@ struct ext4_inode_info {
 
 	/* mballoc */
 	atomic_t i_prealloc_active;
+
+	/* allocation reservation info for delalloc */
+	/* In case of bigalloc, this refer to clusters rather than blocks */
+	unsigned int i_reserved_data_blocks;
 	struct rb_root i_prealloc_node;
 	rwlock_t i_prealloc_lock;
 
@@ -1119,10 +1124,6 @@ struct ext4_inode_info {
 	/* ialloc */
 	ext4_group_t	i_last_alloc_group;
 
-	/* allocation reservation info for delalloc */
-	/* In case of bigalloc, this refer to clusters rather than blocks */
-	unsigned int i_reserved_data_blocks;
-
 	/* pending cluster reservations for bigalloc file systems */
 	struct ext4_pending_tree i_pending_tree;
 
@@ -1146,7 +1147,6 @@ struct ext4_inode_info {
 	 */
 	struct list_head i_rsv_conversion_list;
 	struct work_struct i_rsv_conversion_work;
-	atomic_t i_unwritten; /* Nr. of inflight conversions pending */
 
 	spinlock_t i_block_reservation_lock;
 
-- 
2.39.2


