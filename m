Return-Path: <linux-ext4+bounces-9543-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68228B30713
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1603E6408AC
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D9E392197;
	Thu, 21 Aug 2025 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gNRTtKkd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D739193D
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807682; cv=none; b=kl4wWrA5YBW3O97RF9FIz3RUOzvwBVytUk7DLQg3Fy+mDNg4/ootdrJAd4qd5PUb7f3kdvDv98626YKyd6V+4cT6pVVU7yRjslg9ZM5V+AAUR3n3l0MqYNF5t4eelCiNm9PK7NOjY4oYzDHy6iH/uI79LIt46yIDBgDbjgIM2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807682; c=relaxed/simple;
	bh=x0LPojx9IQXc26jVCUZk/B2yhhxr/cir7ETQSThbsBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdGUA0kzAUmhau08ApCF4AKEbtvWmJXHmy5Al4qORYEo2IpYv0KrR0AJDc+n/+kECqvAukGqsPzEkipt0vnaIc3E7+tcfFUChS9xs9gi9tmH+6HNKbzDSb6F8WTsRbouUlSBKMD1e5lvsOlubHykUcougyMEsfkwzcz7W6erQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gNRTtKkd; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e93498d41a1so1456213276.2
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807680; x=1756412480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNYt8ttislOZxvkBkAGWr4O/dXYuvufQNUeuNOJLG/o=;
        b=gNRTtKkdMvkvxvuahbNvL3tjJvNdsEghXxKMzPuhKSWuvyDSi5gLeJ2CXTVhEm3Aae
         0XaQXGRZiTQHP2JD4R2r4D8XyGwqwfx2cbP1NFthqGxHRHDOaTlQWo7O2TPi0un7zFiQ
         yw2YgbOz+E7nrMioLhlpsbE/ZVFrf6sq+hDesa41SQJNztLdAhIAFs3H3gsvr26Q4eSO
         knwmYkJhjJX9FZlDHf3U6jJfai3yJLdyaCQNXqV/UQkK88hztEuKIuCF93KTe/xOm+x1
         1NhfuFnYqm/h96WDvmzstVrPHD/EaNjM43VRExbypaOYNu9Oo1Iq6mnFnGICz846JACf
         B43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807680; x=1756412480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNYt8ttislOZxvkBkAGWr4O/dXYuvufQNUeuNOJLG/o=;
        b=SLXN50ArbNOvgol4v5fSagKrXa6f++t0pdLWVGqHxtqhpYAB9uXy8iWw+h8vrIpyh1
         7yOpQpMqMAuKRjdMN3envIRtILOLIdJnpnOaOZ5X3epfpu40ea6REdw20jdzUZfnY/Ch
         sz+yxC/cqrqwVnPajuUEw0/DMx+ll7rbZKHucH55tvk70MZJdhBDCSo8Zjcc/OJ21M4A
         XtJy9JCg1q9E4x5uGxqaZn/U2pAUVG1zkhKwQDzNbcNLJX1jt+oTgKC2tUU6aK+QwnxI
         5jjVOeKBiQErf2YlJtZVl4TCICzwT7Jyf6RnRGrqAnDQNQ6CLIbOfY+2BLMLBf08I/Pw
         +esA==
X-Forwarded-Encrypted: i=1; AJvYcCUsWOJMBh9gwCQPzypwego3D5xxt4zkvXU9MfWqmOEEdMHpNjsoOdtI2YLxkl/w9NmwraZREoZMCaLh@vger.kernel.org
X-Gm-Message-State: AOJu0YyJcsvuUblhX85A6EH2dd0iZiG+7/S+1VyGwXpeNoVXrICBBpND
	vntAflMidLOBHQCpy4cSZfHm/e/otfVSdr/09MBujDn996hD9AvleVdUNv000nZfuzA=
X-Gm-Gg: ASbGncsCy64zpECu0w9RKyFotNrzRKuobaE4yShw7wJOzmu8f+cWywOLC8s4PtA0ZMy
	Bb575C4QEb4sxI6yXGcrNW/q6a/G9Xktt6Rw0QAoeSirNykE+j7RVesdnI7BEzincNkwjgHuvAr
	zKli7HxoMQa5lvtBdLoCgtJe4fWUnJSeO4YjMd7PqK5uWrHNTpOqRE+gdUbwb9YSqTLe0u/dh0Y
	Oa6HTr1JUN86LsNl8wp+TLI8NXUZ+YD3Q80Q+U2WeUnaFv6d2HYjTB/lbKu98oqkHAp/+gsvxaS
	1+wlqHdbqs/besSkkpsIo7VtCcSsjx9L92IKyNcfFTBEBECLphj45Bfn1ZQQfLTbvQf4fc9xXcy
	+T9MbldHWBQ5Ph+3ls5qHpJl4bYX1IJwixvB3a6M7DjQAAwyd2GdDSvLHJp73WNkLIH2sMQ==
X-Google-Smtp-Source: AGHT+IEdC0jxj0VQq2eeW7F/rssUiimWnvaXknuXhDlY2cRwdeuJW2P1Cj0gPVf99SnzHF6lzwYwTg==
X-Received: by 2002:a05:6902:f84:b0:e94:e1e7:fde with SMTP id 3f1490d57ef6-e951c42b49cmr876849276.52.1755807679876;
        Thu, 21 Aug 2025 13:21:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e93456fa756sm5217858276.30.2025.08.21.13.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 42/50] btrfs: remove references to I_FREEING
Date: Thu, 21 Aug 2025 16:18:53 -0400
Message-ID: <36185d8a18759d2ed86fa6a0d45ffc61bce82571.1755806649.git.josef@toxicpanda.com>
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

We do not need the BUG_ON in our evict truncate code, and in the
invalidate path we can simply check for the i_count == 0 to see if we're
evicting the inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 03fc3cbdb4af..191ded69ab38 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5338,7 +5338,6 @@ static void evict_inode_truncate_pages(struct inode *inode)
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct rb_node *node;
 
-	ASSERT(inode->i_state & I_FREEING);
 	truncate_inode_pages_final(&inode->i_data);
 
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
@@ -7448,7 +7447,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	u64 page_start = folio_pos(folio);
 	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
-	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	int inode_evicting = refcount_read(&inode->vfs_inode.i_count) == 0;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
-- 
2.49.0


