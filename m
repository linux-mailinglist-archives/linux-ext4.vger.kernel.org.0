Return-Path: <linux-ext4+bounces-12161-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAACCA62FE
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 06:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27D731577B6
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 05:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8602F3624;
	Fri,  5 Dec 2025 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGGdRQpf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41313D539
	for <linux-ext4@vger.kernel.org>; Fri,  5 Dec 2025 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764914366; cv=none; b=KfbYaI/yNT85xph1A5WgtuIMjbfAGyufAIkUPSzBgRPUqjNFaLs9venuMn556BXnGwGFhWP1kcQ+ZNekuXPbkZk3EbjfhI/SEYey/3CJYZCJXpeHcBGw3TJljH+WIthBgFs7q/eC9jB2azPFb+N1wHpXRnsq30xFsfhZ05E/Jr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764914366; c=relaxed/simple;
	bh=v3qKnkp64bhmNVNTkIDedzgiGCfEjfMUA4wc3TYHZAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2imiysb/XcBDCku2Vx7k/MnWoFeqwIJsxteLaN5Lu9T04z9lGkHKXYs5rt0/DnxRYUnHzMA+OCbZyATph6OzwujSH7eVgZ0QP2uY5ISC71Vh79vpjbEtEZdCzfSkD/fd2sNp2fFHFE/tHF4mQw013eRSyrJTg8ePqLKELCIX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGGdRQpf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so2130770b3a.1
        for <linux-ext4@vger.kernel.org>; Thu, 04 Dec 2025 21:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764914363; x=1765519163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFAk5wktF2UPyOn0DQ7lF1B8QLbujwtGCDKJwa1qmTI=;
        b=VGGdRQpfoWMtELD8rWabJmyrua0ogyJYd/NiHnZLxC9d53SGtOrpiS8NrN8uhno0JZ
         3VMR4Dj/2VI8tgREBXcfN4rkfXH1bx4sMDqB6DzLBw7BG+WamM6PsljMawWw3xyxgGCG
         AFfqNNKr56+tSAxB5Dy15wZqjCvmTgOzGzhcGx2bSuYKg79NB/B5A2Eh/iRa2iRuFATW
         Z0igJCYRjFcK0L2LuN2a7mGCopC/uTVjG9UP8tKeTW+zJ1x18UF5EHI95dGHyznzZwMw
         faZ/6rhgIfpa5Gc0HHpm1oyrtm73rqgzsip2n8VfYTm3eekgIEZpXD/4lYug4xAZPHIB
         EaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764914363; x=1765519163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFAk5wktF2UPyOn0DQ7lF1B8QLbujwtGCDKJwa1qmTI=;
        b=LLmjprMJO39mmiMSFQRBNR7b7Xe2Id1xEidyda9Hx37ck8qqF/nuaEke2sVfA3XBEu
         2Yq+giQWDLEwUsE7xGrvcao8l4KvfvEO+Uc1ZaUMmmw5cWnb3fu8J7OQRRsGmskBMgG/
         MkyufEMQM0i30BwHmcYWalBBaEIjAgrwmrgP1w7JQejPX99B94t6Zfvd6mrdEB42uuvu
         iCBI2np7TQ2UenyDlWKKNjeCcArs9422QXOJXG+6E2Mao/UYqOgCspdC3zecM4OaOHAu
         KMAYWMmCZ+SUvjUrzb7KufxcpM9NRK5wSvhqhuIKzap+1htQPdO7FGVdIx0nV8zTUS93
         f9nQ==
X-Gm-Message-State: AOJu0YzaMXV17hNSq13ccmpOHJw2EwDZf3dLQ/99IR/16GjOy4isytjF
	TU/VpUGRBfD9X8QFsd3pid7NFkYEBq4/2dxqeyYbx92bXQ0h6jhfv/Lq
X-Gm-Gg: ASbGnct2EboSYxUqbmr1ElbFxq1dNHcYkpAoC7Zrf7YJMbxFTNTF0OijGYBCJT0m+aZ
	mka7GoUIm88cH7taXfT07T9gj2W8W7oU5UBxQHkQMoaFPCP34B8YwFA5mW6ZP49vTrG0DMbXMGF
	WUNIp9pAAe731a13QZmu4PsL2F/iB8DJ/n1SARDe6bcNc1Y/PaCJxegZsRfvDXh7i+M3PXpZmgz
	+5bjCo5GkfPPDD2BDAE6DaSkhshrxfufX6l5DMxNqey1GL1DhE2MJ/xr2WrASspPhs1I1/51Py+
	FfkSD6sZuSvXOSi32u/lj1td1n83g+6RzhY+KLlPXKWM1oOg9IX3eOmQ1OC4EqTjbPUU2o05fcS
	ssAl5SHu9j/NX9ABBKwTmMxqhUv03ZWbqYYBaE13wPS3JDKpcg6aIxq0jxEnxZzH7itac/AM9qx
	VQQii34DiTpmYteLNY4Pe9G3optrc7oR7a7XnIoeHGFtfJX5RCWAxOa61Zl/FjdZHVv1t6YLcbq
	8m3
X-Google-Smtp-Source: AGHT+IErHmTOgxQdfHXp41sLKOKxSJ4zHAhFZyhwuy4ysXGwWzRghuqw0arHP6wu7kMlAl94HE0eaA==
X-Received: by 2002:a05:6a20:6a1a:b0:35d:d477:a7ff with SMTP id adf61e73a8af0-363f5d3eacemr10179646637.21.1764914362786;
        Thu, 04 Dec 2025 21:59:22 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:7d03:7bff:42c:9a84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a2364693sm3469759a12.26.2025.12.04.21.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 21:59:22 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	willy@infradead.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huaweicloud.com,
	djwong@kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
Subject: [PATCH v3] ext4: unmap invalidated folios from page tables in mpage_release_unused_pages()
Date: Fri,  5 Dec 2025 11:29:14 +0530
Message-ID: <20251205055914.1393799-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When delayed block allocation fails (e.g., due to filesystem corruption
detected in ext4_map_blocks()), the writeback error handler calls
mpage_release_unused_pages(invalidate=true) which invalidates affected
folios by clearing their uptodate flag via folio_clear_uptodate().

However, these folios may still be mapped in process page tables. If a
subsequent operation (such as ftruncate calling ext4_block_truncate_page)
triggers a write fault, the existing page table entry allows access to
the now-invalidated folio. This leads to ext4_page_mkwrite() being called
with a non-uptodate folio, which then gets marked dirty, triggering:

    WARNING: CPU: 0 PID: 5 at mm/page-writeback.c:2960
    __folio_mark_dirty+0x578/0x880

    Call Trace:
     fault_dirty_shared_page+0x16e/0x2d0
     do_wp_page+0x38b/0xd20
     handle_pte_fault+0x1da/0x450

The sequence leading to this warning is:

1. Process writes to mmap'd file, folio becomes uptodate and dirty
2. Writeback begins, but delayed allocation fails due to corruption
3. mpage_release_unused_pages(invalidate=true) is called:
   - block_invalidate_folio() clears dirty flag
   - folio_clear_uptodate() clears uptodate flag
   - But folio remains mapped in page tables
4. Later, ftruncate triggers ext4_block_truncate_page()
5. This causes a write fault on the still-mapped folio
6. ext4_page_mkwrite() is called with folio that is !uptodate
7. block_page_mkwrite() marks buffers dirty
8. fault_dirty_shared_page() tries to mark folio dirty
9. block_dirty_folio() calls __folio_mark_dirty(warn=1)
10. WARNING triggers: WARN_ON_ONCE(warn && !uptodate && !dirty)

Fix this by unmapping folios from page tables before invalidating them
using unmap_mapping_pages(). This ensures that subsequent accesses
trigger new page faults rather than reusing invalidated folios through
stale page table entries.

Note that this results in data loss for any writes to the mmap'd region
that couldn't be written back, but this is expected behavior when
writeback fails due to filesystem corruption. The existing error message
already states "This should not happen!! Data will be lost".

Changes in v3:
- Complete redesign based on feedback from Matthew Wilcox and Ted Ts'o
- Moved fix from ext4_page_mkwrite() to mpage_release_unused_pages()
- Now unmaps folios from page tables before invalidation using
  unmap_mapping_pages()
- Prevents non-uptodate folios from being accessible via stale PTEs
- No performance impact (only affects error path with invalidate=true)
- Removed folio_lock() overhead from page fault path

Changes in v2:
- Corrected explanation of when folios become non-uptodate
- Added detailed description of mpage_release_unused_pages() invocation
- Clarified that folio_clear_uptodate() is explicitly called during
  error handling, not a side effect

Reported-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
Tested-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0a0670332b6b3230a0a
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47c..16f73c0c33c4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1749,8 +1749,17 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 			BUG_ON(!folio_test_locked(folio));
 			BUG_ON(folio_test_writeback(folio));
 			if (invalidate) {
-				if (folio_mapped(folio))
+				if (folio_mapped(folio)) {
 					folio_clear_dirty_for_io(folio);
+					/*
+					 * Unmap folio from page tables to prevent subsequent
+					 * accesses through stale PTEs. This ensures future
+					 * accesses trigger new page faults rather than reusing
+					 * the invalidated folio.
+					 */
+					unmap_mapping_pages(folio->mapping, folio->index,
+							    folio_nr_pages(folio), false);
+				}
 				block_invalidate_folio(folio, 0,
 						folio_size(folio));
 				folio_clear_uptodate(folio);
-- 
2.43.0


