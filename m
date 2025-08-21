Return-Path: <linux-ext4+bounces-9509-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF8B30647
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC9C189644A
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9E38B642;
	Thu, 21 Aug 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zI6kRgSf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96E372180
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807630; cv=none; b=lzdvDiRabI9sNoKQzLgh1QNI6q1J6/E+LwCYUxopv4Sa6QLL7qoRl2ovdViwMiRy/KgJhPHu+oDmaru+81RFp/9yeVwyXWq2adE/Y2TzqXuFF8tyaz0snrjtkbQU4ynD9o3gxlIoffyyIpJFMxSxBnhUV0Nbc4+iir8q5y1vrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807630; c=relaxed/simple;
	bh=JqyAltqlHsDhxnWV26UFEbViQ/nho1N/pG6i6mXuWqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvEUtZY9exwG1rATAAPQ1QZow96lBs1ZJSUa+QVFPY7jg+w5u4IZnHtjxXdoZ5ghwi8nMHwf/oz+KKI39PyDUpomZDZim6KferaeKmXoyiAjYPltNYd7nLqh7Ozf4/GmsSFHGKIirk/lNr0bZHTExx8ewC1oFExva50CGQIwpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zI6kRgSf; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e94f19917d2so1385722276.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807627; x=1756412427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cb2V9k5PVP583r5lr+1rASUj/P55tkAhqxStui+NIFo=;
        b=zI6kRgSfIggsXgynOSYpwQgheZHPxE9zDKl56XoWVJlL7+8yc7XqTV/DMoTsB5JYiG
         JOm1NHV86TInnLQK3VauPw9cIgv9QIEJ1/E9HN8TthgjSuEn0ycFwNERlixjrvgyF8KL
         ZfEBpE0LQ9i9tO7rBtULHfH6XIyjUtOtjpx05nIA65T7p+hICIr46vB4XqOwZQLnoONB
         zD5vyoinQodbs1Nyry584tRUz81OLdmFVSEd6UscaP7STMVTh6TA7wMazQGwJbgzOokx
         GJMKyYOQe2aMN/oOIr9t0R5++hIoloQvJgx/WW03drSojf3TBFGN/ZSe23oCE7hTiivc
         SpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807627; x=1756412427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb2V9k5PVP583r5lr+1rASUj/P55tkAhqxStui+NIFo=;
        b=QX5zn06rHu6MJ/6eCKXlutGRlWajA/I5artBfFsF2+TopfHT6kof4MODjskAPRyY1m
         i5Ez1f5T9t63+Z3yVWpi2v6IBnv7QLA7tOkF/XOkRV2HqYFf0+sQFhFrnMhwtJ2HjzYH
         ch8Lyy4K2S1ZNTw3DgjLUmDH2mBfb5LnYModsfyGhRbf9eEPt2rC6FE2YHa0isTLoLwk
         60bPwgLd8iVPj8Pfie0F0dzhBOw9C6GSaSJw0nD7qUFZDh1VNPrTwYO38bIMxTXSmGH0
         wJmwQdl5xMxP2uUinZJfT5RgABGjZwIVoSnukPO1J2hlsVpth0iseb8ZP6XQV2fwwIGO
         Q5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCW5WZqHQkqp9RzRKH4JRatFWlyBvT/+1fIDcmZIqFE3pZU+xsmpEr9VYoZp3kLE+E08wNFIykMYRcnd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+wMfbNfzt1QkGrnwNAi27cfHTqgfRzqWn5beHZ8CfWR7GrRH
	CkE3Taic+JTAT0k2V+9425pGeUl5bnT2L9mtaMwNYUgtjyEEMnqhoFMs051tqyR3iMnd1IDmDIY
	VaG60OehiyA==
X-Gm-Gg: ASbGnct/YrCqs/OfevZka8gItgJgwE4VJ8wlOQa4nbNb6qU+KqGuL/FLBcFP8SOrqW8
	baQ2Ux0cS/3rYEhfoPHZbSoqRdNpc86mFUOOMmnXxpq2cX9fw1jDf12VgtTgUS7AUeBwpwvzA6B
	CKVtUZ5RTjdDYpidIHET7GGoARLXLkKeEt52ea2V1v50eLcepW+3E3d6HKWw4tUq7VARnBDuT6C
	8+97KufmO56q4fKdKA4nxlYm98hpkv1MGRSI7uyD5IWkLlAXEtHMaoLcHjuRYq5wgNIJv0WoOBE
	ZBpp2wii+e2gZ53Xbg+CqMjmt+3hT47HJtBWi0oryqBGt75fsRQYEU0F7yh5/5egmadPl/lPzzz
	mMjP6DoPx11lHRi3fiSbExJYcscM8heWXlO/c8AZCH3KV9wo6UpaBKQCHDDM=
X-Google-Smtp-Source: AGHT+IE87W5Ra788mXEaYg1x3BO4fJJ18wjL8kms/6rnsfpL0Qf/z0M6cHEdhh+NBNhq7o8SIEAtHA==
X-Received: by 2002:a05:6902:6c13:b0:e94:ffa6:177a with SMTP id 3f1490d57ef6-e951c2428f4mr1122255276.23.1755807627448;
        Thu, 21 Aug 2025 13:20:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9519ef31c6sm374368276.23.2025.08.21.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 08/50] fs: hold an i_obj_count reference while on the LRU list
Date: Thu, 21 Aug 2025 16:18:19 -0400
Message-ID: <1e6c8bb039a6f1e76347b3214be78326b403c57d.1755806649.git.josef@toxicpanda.com>
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

While on the LRU list we need to make sure the object itself does not
disappear, so hold an i_obj_count reference.

This is a little wonky currently as we're dropping the reference before
we call evict(), because currently we drop the last reference right
before we free the inode.  This will be fixed in a future patch when the
freeing of the inode is moved under the control of the i_obj_count
reference.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1ff46d9417de..7e506050a0bc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -542,10 +542,12 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 	if (!mapping_shrinkable(&inode->i_data))
 		return;
 
-	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		iobj_get(inode);
 		this_cpu_inc(nr_unused);
-	else if (rotate)
+	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
+	}
 }
 
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
@@ -571,8 +573,10 @@ void inode_add_lru(struct inode *inode)
 
 static void inode_lru_list_del(struct inode *inode)
 {
-	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		iobj_put(inode);
 		this_cpu_dec(nr_unused);
+	}
 }
 
 static void inode_pin_lru_isolating(struct inode *inode)
@@ -861,6 +865,15 @@ static void dispose_list(struct list_head *head)
 		inode = list_first_entry(head, struct inode, i_lru);
 		list_del_init(&inode->i_lru);
 
+		/*
+		 * This is going right here for now only because we are
+		 * currently not using the i_obj_count reference for anything,
+		 * and it needs to hit 0 when we call evict().
+		 *
+		 * This will be moved when we change the lifetime rules in a
+		 * future patch.
+		 */
+		iobj_put(inode);
 		evict(inode);
 		cond_resched();
 	}
@@ -897,6 +910,7 @@ void evict_inodes(struct super_block *sb)
 		}
 
 		inode->i_state |= I_FREEING;
+		iobj_get(inode);
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
-- 
2.49.0


