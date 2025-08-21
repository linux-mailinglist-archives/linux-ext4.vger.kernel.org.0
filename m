Return-Path: <linux-ext4+bounces-9527-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEA5B3067E
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F27AE5A95
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1E236CC76;
	Thu, 21 Aug 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="aOBn9oFN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66511373F9F
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807656; cv=none; b=qR1oREf49RAiSiavFxnfARLGzQLRWVZnkrjRGqaxPD2YMdj8v5QCZmKZTYP3qP8e6afTT74mK+zUHB9R1WhIg4YahwIeBdYB0N+ca1Wu7YQHCbEjUMPG4AN8qb1C8dXZfk+NGLBKToJJilnLkd1jCOB/9tHUnqgowFk57+G36Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807656; c=relaxed/simple;
	bh=NKVthHrTpyCuYxypL0G6ZssB8gJJwQE+Gjakb3Uib/0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZGbEfA+BGQEs6w5/ozu2itJqt6siueCv5Osvn7vmymgwCyRPxk8TRT/GQ3j59usUFUQ+JXlAbYhFKqspKuYwOFE1N1lMRfR4h7vjtHfxI4nFj7RrfAGxlHRWuXNKAZ6Naf2xHBhGxzqPdMayDVwKQ1UthU2pNA7DWvsE7u4Z4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=aOBn9oFN; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e9513a4b346so988539276.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807654; x=1756412454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PorrIJhHXaHO27cDWxDKTAUw8tGpPd1qttfIj42aEmU=;
        b=aOBn9oFNsc51+699KhZE2yc79RJokgJKK9twxQhRbiO48sY/4ek8a9vjqBoCAFFBoh
         wyGcYOMGeCvDABETL7qL9UrzrtEvjEMrUgd80UtZhMTldUb3kClKs4SmdNdkWg/xlYs/
         E6rMPvGBXy1sg0FsKBBNDTjnVb3KU77NC4xSO7bfWccIqnn4/9YVl0gwUTbKrwelCtTy
         2aalGomFgU9e9NZJ5teqxdgsBDR3EL+3D5wG+QPAxN9/rhQpQUj6nKUMAjVMOurDkpPL
         6X+ZtPNWvujefTv5NiYyaqdvRTlUr9btUibDyvnnMwsn4ar6qdjCOXjbu7/UwoJbNW21
         /EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807654; x=1756412454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PorrIJhHXaHO27cDWxDKTAUw8tGpPd1qttfIj42aEmU=;
        b=S0JLzTu/zbl8ZfypiMUBdtD1/a0/VkRJAb7NurcWWlr6HZffOTUdYHMtPPRbzocLEd
         vfyEP37/c30B0G2yINFoOXu9sKkHy3pUHAO8zruGmfPEW65acxI7RYi3Dek0e25/x770
         MdPOQKl5/dWGpyb5t5zGGCVlVBT9UNSLw+FAP9ogTQCQWWBkfJfADPA3IBsoj7ok/MUW
         jTyMfLTZFzotQU2oFGCCkQKPK2FuYS96L3VOKl9ilwWAHqxq+j5KIT14jTKSNecJakOw
         whK6lGr6PsLTdMa9p98H9OJvtEW3iZerQztH6nFgAM1jkHLFEB4nnhS9EBs6cAQQ5KzG
         tpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6xTALna1DNMFEKa4OxeEU2TBemvNTXARJwc11PjD5EFoPUTZskHPQLPCjqIOMi8d9rdo54ROwXoJx@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5gS56bii+tz09EVRqNW3Fl3Wdm7UXpwzpVXvVQDoCocuopuH
	YGrDe94L7dT5TspjvLYDw4P/e+XleFlp2fb+YP+bu1KZnwl0TQ0+W2BRD0kIUWjpRxVBb6/N3Uc
	M2xDjNSwJifHr
X-Gm-Gg: ASbGncu7KHu4KnIzRJ+EAAgRIBeA06dpBk96ZJzJmO/3rcH8iCvIi6lmhYKbOCWfOdD
	dSDufW6EA7z2vy89z558hl/h1ye3WGOBlYfQxKAJVUAuIZhj0CLlUlU28LenxY4ZfuNkBMrC2DX
	R4iLkwJrZDDPjAAftYt2ne8L8KB7aGszLf8WfH+4HJ/F0Bg9d7b2dbK61XuY/gQz8PUzWykIyOi
	rHyFm9wYaIiU9OhAfmuDQulUNwxcybUfiv8eCHlxnE48r1b7ud8ZVtTi25JNeLhHHwyUlF+98tp
	mbYHP6JU1ed6KXKjTuXzcMayr8FAsTih8Av3FlPOd/Jz3Tqieok+yx/6js+5YNXBLvMZeVN7Bos
	EwLaP7cJLwiV2KH30Dar1wpkmwnhy6XfBlasIyRLGSpSA0p0m7S+cKuNWG3ciX2qjUYvr4g==
X-Google-Smtp-Source: AGHT+IGbGhHtW+dkKRPeIKh0lukvvT4QFrNpyVadJdYASbUMv52STVjCCLg+pYG9C9deIRU2g8iINg==
X-Received: by 2002:a05:6902:2b8d:b0:e95:18dd:6a83 with SMTP id 3f1490d57ef6-e951ce0495emr555156276.11.1755807654366;
        Thu, 21 Aug 2025 13:20:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e951c976124sm142232276.34.2025.08.21.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 26/50] fs: remove I_WILL_FREE|I_FREEING check in inode_pin_lru_isolating
Date: Thu, 21 Aug 2025 16:18:37 -0400
Message-ID: <954a16d781fd9bfc1b6cfec40af80475f710acf2.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the inode is on the LRU list then it has a valid reference and we do
not need to check for these flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index c61400f39876..a14b3a54c4b5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -682,7 +682,7 @@ void inode_lru_list_del(struct inode *inode)
 static void inode_pin_lru_isolating(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	WARN_ON(inode->i_state & I_LRU_ISOLATING);
 	inode->i_state |= I_LRU_ISOLATING;
 }
 
-- 
2.49.0


