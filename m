Return-Path: <linux-ext4+bounces-9668-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C9B36EC1
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA8464C0A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5393705BA;
	Tue, 26 Aug 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="du07Fhm+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9937059D
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222914; cv=none; b=LrngRz2Lf6Y5YbyJIU+VD8nxs9KoInunn6rO+kIwkBSyHGSGcHs80uzYHG+MB7k5706x78mkCWkScXpyznwprcRyfpPrLVF8kOVCLa4B0Ay+4b7u2CiekoyEOhZ7gpzAaA0WHRqlF45lZlzGsANbiGppNaDs+auGb5BxYeZs5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222914; c=relaxed/simple;
	bh=dwwe0MEH5iO3x5aF5QurpKCYlNFdYiCh2i6JCishoj4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjfyEzFd3gyVqT++ZA1KQglqZqWuVkI+lGnP9isAxG7hl3e9vWqERERWyKEAC8XK7AQoC9h23ZbcVuLAUD132vkAhUPmaVKB1OmzM7GY+Z1yDq/sq/DayZpZvlSrMxTVecj75gBNs7WxTIqSmgnThwUtUTdi7x08pLzqQT2IU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=du07Fhm+; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e95380515bbso15525276.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222912; x=1756827712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqvplDu+lNSK1bVRdwN5sEI2iN4Y4F8Nug6abxM7ea0=;
        b=du07Fhm+E2K75A21FLUay2gY/LIECLDwj8QJpWSLT7JEI1eYR/PzKjv9AjIMUAf+3Y
         0mQyMgg26Y+H5drT1jRmdaTurj79cVC4zl+yNoF+SyXJOrSR8tlTcsbHyeCr0OqeeEr2
         g5wnR7B7nVP50zr+WRcdoT8MQWTVYTZ+BrM1HqoNHvtdKCTP/LGgri6n6gz/zJOU6fnO
         f0Hf7bCn3xUYy2SpN28T5B8cWL6ZEuQck6b5rhndsVyIz69FYDYg/0bitHGlJmD+a3Zq
         zi+KbNH7jLO6Mnc+dpu9whKOdXv8DtVurbaJZdq624RXiQE1gWtjCVBWShg010G51Zui
         LfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222912; x=1756827712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqvplDu+lNSK1bVRdwN5sEI2iN4Y4F8Nug6abxM7ea0=;
        b=wBWnlT3gG5jmaKCe2qotLlsbStfNVe+FRfnJUQ+bFec9K7BIZ57nVejUphULd8T4sb
         fY0puF8U0WLlmyi0cL8yInEXKlH8RGmMbbI7meMzFCKlGKpBVayyQJ6Aj7/z25SCoFCq
         Y0EgJyBO3wGIJZ3yTa4JZHNW1Zeh2pW9q68zu+1Z3A3/voufOoQr104hKocyDfokB6/i
         34ahJ/W34CsinNPyqvXKs59ovvKLR4w09LQVvx1fFIdKILYYny6yEuUH7i7QwgwqULtT
         qIiYbHhW+nWMrgvVUl1QeA+TLVN9L2/pKywveblhA8QU76cCNI3vih41oxPMM0wFhLQn
         cTow==
X-Forwarded-Encrypted: i=1; AJvYcCU53Eka0ft9QOAff4eFSxV+N65UhvJXLDYH77NkOrWb6OUqrVI8iEqXlgJOQh/KZwdKeoxa0i9z7aFj@vger.kernel.org
X-Gm-Message-State: AOJu0YziArbTjjqYMFTYc6ErDhUUIQtu6Ef2rKt+nMHR8gMBSG2zFRHo
	xen0Uwykc5ACwoVnCwPpc47T+OXjY3HIxs423VoVJAKMvRxY2FohA4C7I7gPAU8Lw5cBr/DNS2k
	1VHNV
X-Gm-Gg: ASbGncutxJvL3BePmUHm+B4tpmz6b1gnHcx/+5KBWHBUxnNSWQRKjNbLJaDPnv1Hu1M
	SyMngPrx1unI1xGB1VkM7NIIIXhBVI3navLQsqpGtbvmuZ25xe2aFqC5J3zpYrJccvUpapvDemO
	cponnONlehLZ3eYHT0DtoF48O9Ml1r4JbIp5UrHNJFO+SWFFFdExxoEWv6DSo8bjNMj9gVAHvU3
	PCd32cLpHJgyVSOxQ8x/ByHRX73m4KvsAMwXlJ7fBOWHozo8/Go0kbvymmhapP0wT/+K9gfAZ2w
	EDbEf4G+1Ryz9usmV8izeemI9zeN899tLx3Db9UQt44DAT5/ThcSs5PxAs/Og2OqspCRNkYdsev
	Sa9jxgyeQnPJnyQtwvw2/6rXWGy1QPmzTzaol7XXl//52Bf5eZd4rDu1zYpw=
X-Google-Smtp-Source: AGHT+IEmTijuWh+ST4YjRGo7H4pufM7FApdnNjecK9pfpFaUwQCk/e/q5IjGGvh2/UXNpr28Nq68Jg==
X-Received: by 2002:a05:690c:2606:b0:721:2c21:3614 with SMTP id 00721157ae682-72132cd7378mr19923627b3.22.1756222911738;
        Tue, 26 Aug 2025 08:41:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f65a223d29sm2530427d50.5.2025.08.26.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 43/54] fs: change inode_is_dirtytime_only to use refcount
Date: Tue, 26 Aug 2025 11:39:43 -0400
Message-ID: <caa80372b21562257d938b200bb720dcb53336cd.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need the I_WILL_FREE|I_FREEING check, we can use the refcount
to see if the inode is valid.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/fs.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b13d057ad0d7..531a6d0afa75 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2628,6 +2628,11 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+static inline int icount_read(const struct inode *inode)
+{
+	return refcount_read(&inode->i_count);
+}
+
 /*
  * Returns true if the given inode itself only has dirty timestamps (its pages
  * may still be dirty) and isn't currently being allocated or freed.
@@ -2639,8 +2644,8 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
  */
 static inline bool inode_is_dirtytime_only(struct inode *inode)
 {
-	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
-				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
+	return (inode->i_state & (I_DIRTY_TIME | I_NEW)) == I_DIRTY_TIME &&
+	       icount_read(inode);
 }
 
 extern void inc_nlink(struct inode *inode);
@@ -3432,11 +3437,6 @@ static inline void __iget(struct inode *inode)
 	refcount_inc(&inode->i_count);
 }
 
-static inline int icount_read(const struct inode *inode)
-{
-	return refcount_read(&inode->i_count);
-}
-
 extern void iget_failed(struct inode *);
 extern void clear_inode(struct inode *);
 extern void __destroy_inode(struct inode *);
-- 
2.49.0


