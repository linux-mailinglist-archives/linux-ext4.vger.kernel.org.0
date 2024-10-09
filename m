Return-Path: <linux-ext4+bounces-4535-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BFA995E1B
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2024 05:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B3F1C20E62
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2024 03:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A88676C61;
	Wed,  9 Oct 2024 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgIYWErd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2B2119
	for <linux-ext4@vger.kernel.org>; Wed,  9 Oct 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728444339; cv=none; b=JouD9PBAgecLIMHYuGoMfKjwWjFG/RX614DlCtNJ6wdo63lq9fk6Mn5kRBbXE+L5o4hbw8utJOpg6U/TeqsPb3KSPqqJf+a4JGURkFARnB4rW6jlC1QmdlXAo0nESoNBuZQUucp/7G/2G8SZ2O+U7KAuIqmpbrDI1T6fl+V0q/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728444339; c=relaxed/simple;
	bh=QNpgUAKbZBomkZ743wtK3P6+N8TjEZ57RreEos7jVqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mRcik5F8Cs9RzzZBYv6RkR89m0GEOx1PQGZPMrrI6TDb7nNyYhPvKX7moqE2ZY2qqNRzdZnbjV3V6CbalqG6B3+xdL4c9L5IxRgwe24FUw4L06EXfyl4ku69KQPkiimvnbeBTr7wHxTFZVSWmLkMh8U+u39V+0ZBMWnutxL4JYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgIYWErd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e29555a1b2so654355a91.3
        for <linux-ext4@vger.kernel.org>; Tue, 08 Oct 2024 20:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728444337; x=1729049137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NR64AS8nlZvaquaZ8xVty4YAU20ExyFyPkMeRFRwoUY=;
        b=lgIYWErdN10SFCGHzJY2xU6FXr2YSKDn2J+x/yJu/C9/DkirbS9paHyOfTYCXXZ19u
         03m2mtNu3T+xHPtGJOdorhxFZiFAkAXgDwDG1aFtViNjrBDbUvEXRhD0Ib18aqxEJauz
         /QxvwlB0SFfaIbfHw5pvNmvV7RdZMlOzbOCMJgvi7NnaIxZ8fb5DIsQTBStkZc2bXB49
         hXqCUMDmWRI/X9KGi0J17+n5tcOXUyUUuOYZTGh2VJ+Nhk5cmoYzMsILZTS0vos5P2Ea
         D+mosvLVemB2GA8Ws8ya9ME5Vz3529Nm7tVz29EUI41FC6jpnp3mLMFbZeimK+S3kXMk
         abyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728444337; x=1729049137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NR64AS8nlZvaquaZ8xVty4YAU20ExyFyPkMeRFRwoUY=;
        b=wzIHTUcr0P3SrS3qOsiN69GrG+xVSu5r72VDJ0+A/8JwfAu0uIx+UqIvk5UlOGCUW6
         +7UBbF/MnF4PyaKywYN6fw8pB/S2hGWub/TUOXltu93xWao0UDlLjDggjOjYWA0YmMQZ
         dK68Rt0iQ+ftJGjm8kjzwhIZtlvpVRNyEP+Qdj3xu35HKRmlUf5zSOpFSlZzVZsRcmL/
         7RrZ+WGEvNyyEey1WZ1Ly+LZurWJaTUyL24jXNpbBUOOew0BTLJ8ccUwmLBUUCdBINNv
         Yvjye2WVAuMzt/VTN+SAqGEuU6kUdeli2OOzg4ujAlRJQi0rWxVn/RYRMZqcDaEQagmq
         mU2w==
X-Gm-Message-State: AOJu0YzlIx//NRJprMMc5QTO95GTi1UYPMPCdLN5l6C+GhvU1d8uRFAS
	KB4t2XYDrAIOIl5b4Viy8JwOdZlCwfjrSjYkDBV/DXUFMCrwYW275UOBog==
X-Google-Smtp-Source: AGHT+IG8JpY4NdqO+9lTNq3KTTfjGq2bY/+dJp9Ix5EKy4PEYtrvaUk9rHu6yZ5rgCHYRao4tQBH5Q==
X-Received: by 2002:a17:90b:3b86:b0:2cb:4e14:fd5d with SMTP id 98e67ed59e1d1-2e2a236b971mr1284196a91.17.1728444337464;
        Tue, 08 Oct 2024 20:25:37 -0700 (PDT)
Received: from debianLT.home.io (67-60-32-97.cpe.sparklight.net. [67.60.32.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55fc8eesm406695a91.6.2024.10.08.20.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 20:25:37 -0700 (PDT)
From: Nicolas Bretz <bretznic@gmail.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Nicolas Bretz <bretznic@gmail.com>
Subject: [PATCH] ext4: inode: Delete braces for single statements
Date: Tue,  8 Oct 2024 20:25:33 -0700
Message-Id: <20241009032533.1992508-1-bretznic@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl warnings - braces are not necessary

Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
---
 fs/ext4/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 03c2253005f0..fc0caeb69b17 100644
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


