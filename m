Return-Path: <linux-ext4+bounces-11996-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E14C7925F
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 14:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1424B28E87
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EF12FFFAD;
	Fri, 21 Nov 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auw7qQLz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9852D1932
	for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730796; cv=none; b=B0fb6hVCjNAJZP8ZwcZxP5aGkD300OCUfu5lB9HuRzjNbiWsMOI1tRbQzso3G0q+YX4RGDVDDG2TwekE4IuCv7apmaaOkED+zSmhBI6J3t4EF4MZuMb2jSJ8gcLiPFj7vjV9DgicARTlz70WrxG8tZhs5cfoBIt30YuQGn8uMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730796; c=relaxed/simple;
	bh=rE/SarrQIWideNXRyOgnbkN6JjxjL9SMadfP3/CRCOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qr22p6WH89LWsjXLvI2l5xHuQkPzoU0UnKiaPQSE6xaQdsj07WdFzHizgG74PbR2TMk6QZdBk6c01hLYpnxnREgKvjaAB+vbS+COUuwsqVFSr1PXpwW7TixNrvQQBigZFVuaGcIYf6wSrq1CdccnLN8izz/5BHSnJ0v7Dxkhm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auw7qQLz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so1744014b3a.0
        for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 05:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763730794; x=1764335594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcwG/NJzFAcxhEUfrYRg693RnY+JUPTamI6o974/FU4=;
        b=auw7qQLzjWwPMfuJ38W5UHPaGINKPeK97bZWMEqWNlgVwNI40PLcotitUgfFmq3tUG
         QaOoG0eaneX7jLXJlzuLA1Bo4oWg60fotIsDIASB07X6hOBjHwVuyALM5XVTEwK6F0tY
         a9hNaXaeoFksnsxWDzGP7luEbOPvI+bcdF4aQR3PtNjAyosT83yX3h7G4hVG6qtT/zko
         poHCQunNPyUZUggaXQcR44xePuFwwJEpAdBuG7Vw7eDbAfy5EfRpAaQUlmibUgStdcWM
         c2SQLy17jVUus5Bx+iG+LJgVUo5VKWobmwsFo2LFDXG2tekn4P1Abj4UYQHKf7SXtOhB
         QkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763730794; x=1764335594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcwG/NJzFAcxhEUfrYRg693RnY+JUPTamI6o974/FU4=;
        b=SbMFX4qiQIGA8tpGCKPwHWMmuq6hHFW3K46i9bvVIk5GRnu1KDYpFMTlWjL/Okv4Lt
         LthIE0agf+HVfxAkWeCSS7Sgub8lqMJp8PZ1bCglWZ3exRV8qFB/DsL8WA9rmnyrKD2a
         gJu+s9IjFnreVHVMivnaOVsayQvWhqbModK+e9JfGychAoZGHWzdjxjcSsyCCiYeK6XI
         iKytRoFfvvaDcJ7pk0ycrgfTvQaXVuAqlrgRCo8uH1HmOqEDaQKSAChIO6yOospSEORb
         wyCA8vHaGzV+uAkWpqc3bzYnd4C6y5eqvF+cOhqsjqzKf/3MuPHz0KffOuDKRg7eWAcX
         e6eg==
X-Gm-Message-State: AOJu0YwvWGGUCsiyhiydEt8G8AFFqXVrlteCjdHOj2DhDpDBKE6267A4
	/R/DsKLlt4W6DPrHxaPZVA1B0bwmz5SxV0fTAadsZvm84aeoAWbd/hDd
X-Gm-Gg: ASbGncsCr4Ws/wr3d3yyU9dPvJjhndSNDHdISRgpon0fDoLt/bVGivsWlgJqc5bER3z
	AJVcyy1toQPxJF96qQ8Jzg2eqX3Hkilo2iZ1Kps9WKMRCNOiGtmHwI/3ydcXxJOm3hkZYVqCASx
	kMvawMnTQGPehj/jTwMY8Zw9hbAuRHdp0Sr81vxbNw98k/7F4yB9P75c779Hqm17M9dEm/HtYT3
	nqXLSeLaQSAMlPKbTD2scQiYqSRRhRWr1j70m1jqQZfjZzzJxyPBBmLd5My3209p+fast1uge5m
	zxA93Z85es9IrQFAnJpb6mzhAW7hv+FyUddbD/qqcozld2vLWidfgnSEinHftF9O2CLBmWpoxRo
	4d1GjNp4Cv25bdaRtwFwGCJ445yxH5+mvLwDk/DiDHjx70RJG+BJAIBuTHIhCTR62Sng262KYUV
	5vfMEwGj26ov0BrGIcdymL/nkuwMtQoHJh7Ck=
X-Google-Smtp-Source: AGHT+IHVq8m64LagXR7W/MUGL/n3aZK2syb3kGs3Kx9En4d48IXWK5IXTgV1/krruozFO/ncHQl7hw==
X-Received: by 2002:a05:6a21:e081:b0:35d:1bcd:6887 with SMTP id adf61e73a8af0-3614ebc1b71mr2998609637.16.1763730794094;
        Fri, 21 Nov 2025 05:13:14 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:4240:d7dd:15df:5810])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed37b0c7sm6069280b3a.20.2025.11.21.05.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:13:12 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
Subject: [PATCH] ext4: check folio uptodate state in ext4_page_mkwrite()
Date: Fri, 21 Nov 2025 18:43:05 +0530
Message-ID: <20251121131305.332698-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a write fault occurs on a memory-mapped ext4 file, ext4_page_mkwrite()
is called to prepare the folio for writing. However, if the folio could
not be read successfully due to filesystem corruption or I/O errors, it
will not be marked uptodate.

Attempting to write to a non-uptodate folio is problematic because:
1. We don't have valid data from the backing store to preserve
2. A subsequent writeback could write uninitialized data to disk
3. It triggers a warning in __folio_mark_dirty():
   WARN_ON_ONCE(warn && !folio_test_uptodate(folio))

This issue can be reproduced by:
1. Creating a corrupted ext4 filesystem with invalid extent entries
2. Memory-mapping a file on that filesystem
3. Attempting to write to the mapped region

The sequence of events is:
- User accesses mmap region -> page fault
- ext4_filemap_fault() -> ext4_map_blocks() detects corruption
- Returns error, folio allocated but NOT marked uptodate
- User writes to same region -> ext4_page_mkwrite() called
- Without check: folio marked dirty -> WARNING
- With check: return VM_FAULT_SIGBUS immediately

Fix this by checking folio_test_uptodate() early in ext4_page_mkwrite(),
before any code paths (delalloc, journal data, or normal). This ensures
all paths are protected. If the folio is not uptodate, unlock it and
return VM_FAULT_SIGBUS to signal the error to userspace.

Reported-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0a0670332b6b3230a0a
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47c..18a029362c1f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6688,6 +6688,14 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	if (err)
 		goto out_ret;
 
+	folio_lock(folio);
+	if (!folio_test_uptodate(folio)) {
+		folio_unlock(folio);
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+	folio_unlock(folio);
+
 	/*
 	 * On data journalling we skip straight to the transaction handle:
 	 * there's no delalloc; page truncated will be checked later; the
-- 
2.43.0


