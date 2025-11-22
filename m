Return-Path: <linux-ext4+bounces-12004-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB4C7C1FE
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Nov 2025 02:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56E2035F43B
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Nov 2025 01:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84C268C40;
	Sat, 22 Nov 2025 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYKjGeja"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07E189F43
	for <linux-ext4@vger.kernel.org>; Sat, 22 Nov 2025 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763776673; cv=none; b=N434OEwuMYIVGOlibt+Aa4n+PwOidQasrTVsrbH5wCI7+wzeG7oNHNzyl/RW0kRY3jmngjNCJFDjuFZYpRhOyP8stAnGiv3w0egH1cUpQ4knQ97IwsNh9Pnv8ZSlZ9FABzYc5HKJ3Ij72Em2za0YVK6FgQNqqbhY0z19GTcdUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763776673; c=relaxed/simple;
	bh=or5fkGeUuho+9cgKiVA6L69Itywqwi1cgjg/8vpEWDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWXYFmP5TOdslcPZJCJWQwgNIgLlxBO/ayFBkV6f2vq2BgkKymX/X2yRBloRRzeALyXyyoXi1kQ3AkhV0t2jl/llmp865QgMUe3qvDi9xN2vw81I5VRpAs6ZSr4SMfKZMg5yfcMgdXyDkbfq4tq0Q4wt5ncK5jZl19/f3OV9MwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYKjGeja; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso2075630a91.0
        for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 17:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763776671; x=1764381471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRFiigzAnXPWCUAfF7TMX13w9dqE7WROsRKqo4+OjQg=;
        b=YYKjGeja8tpPgGlJ+jz+9HLZUAWkiwikckFi7Y1xNGtWYKGNA4tYuN08Hp2MBYzkSe
         bzRkfSITIPa9olZHv5eM7ZC+wEVbTgzcHKXUy92U+ccnDQ9w2oCUnjjG66CbzeLxUc8k
         yuzRCJ05+2wXn7DotKILSRKviBXcj9WFO0BcpvyCkpZysBowwtuaY6polkmozRGfmuLq
         6LkbGBskOC0/Q3BP8vAWmDEMvEPgquCXUEIx0pr282iKe7WsX6+OCLrUAOefrhCYIXau
         N4+3oeEIVZnCpVdGR6ElEVjC12m8PFtlY4Vp5cVghOu19U7YBGaeP0Z1zeX9ViM0NOl8
         YWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763776671; x=1764381471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRFiigzAnXPWCUAfF7TMX13w9dqE7WROsRKqo4+OjQg=;
        b=Vqd034V/gLMWDi1g1AkEnqyse36qgJV5mgsAiMamJMEkiLt+n0x6sVzS9xGpsheMU8
         FuAkRkptpo+iALpsA4bM6KnCW2BHG2wooeAvv5Yvy4q5lEzbFdP3ppjszznbSR23+bX4
         r2ajbRY6uqiz4EDZk1EN8M/vtZo/tZlM6NgVNqGE2W9x9CBSvwDYaXaFxm4mcEteMe09
         qkyX5BC9WG+KDTXWPsASchFmKwKKCZ6alcVG0C00JLKhGld7ySuhz0CcFPzfTcBxaEVV
         tSlxSL66T8olpHEom0ufIg2KF4i4T9g7eXP3PalXB61dJoDNmJaqlP1dMVhJ8aC1NWTg
         AEUQ==
X-Gm-Message-State: AOJu0Yysmr+9WrIwTJMNAEc06csE39FR0NGY+NhWQUW3C8rrQGEqjFAg
	dEUBrdXlHhl7ud/aG8nnBOGKd/IOGQTUiS8vOXlWsnSQtBsMPUSKmTmA
X-Gm-Gg: ASbGnctApFnA3Y7KyzcgW1Tadnh+9Qmo6crAxEC+7uNAo/KFOv55fDgngeM2hdnc+m3
	48xEu/wo/Y59JoHs8uOy/omzkYFfMQFPPfTIJjHWzmVlXIeI6GyS/iqXBzhf4uO8uU8+ezMq/Uz
	MdvSO2ZMSTWCBJOZB7sGJO03XWtTVw+9e2U//oZ+9GXL8N0Sliio7xRgIxQjo1GnpEdM6eLTR1Y
	gplyMCM1FaZ2wvsMduA0CiWafmY+JXzvukvEhFXLITMov3zNZzofa1dL1xLMDK68X+q1ZoSLR1Y
	0Av0k1GjLfVhVh5pAMDi0Q9fXOoB2cO4H/C7EV0a25vJA88f+ed9p+qosTWKBlgPKYQze2UCaS+
	liFkPbdkwoNo0zep2B93iRgbkmnXtCHyIT/FHNmParuFLzEMkt6cBN1gIcsAh3x8DI8pOi/p5G9
	6uV7tCeuo6Qs41+LGwGYXGbJB4VRL4HyAxqdorYVM349w=
X-Google-Smtp-Source: AGHT+IFDvnDexWq3NMClg3rlwVRmX4OYTyPq0boMqZIijVApm3aAPsHh8DJ4Fr2wGFGp//jq9F/FKg==
X-Received: by 2002:a17:90b:4f42:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-34733e937bdmr5124446a91.15.1763776671299;
        Fri, 21 Nov 2025 17:57:51 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:bc95:32fa:5cbc:5c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b04d7305sm5271192a91.11.2025.11.21.17.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 17:57:50 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	djwong@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
Subject: [PATCH v2] ext4: check folio uptodate state in ext4_page_mkwrite()
Date: Sat, 22 Nov 2025 07:27:42 +0530
Message-ID: <20251122015742.362444-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When delayed block allocation fails due to filesystem corruption,
ext4's writeback error handling invalidates affected folios by calling
mpage_release_unused_pages() with invalidate=true, which explicitly
clears the uptodate flag:

    static void mpage_release_unused_pages(..., bool invalidate)
    {
        ...
        if (invalidate) {
            block_invalidate_folio(folio, 0, folio_size(folio));
            folio_clear_uptodate(folio);
        }
    }

If ext4_page_mkwrite() is subsequently called on such a non-uptodate
folio, it can proceed to mark the folio dirty without checking its
state. This triggers a warning in __folio_mark_dirty():

    WARNING: CPU: 0 PID: 5 at mm/page-writeback.c:2960
    __folio_mark_dirty+0x578/0x880

    Call Trace:
     fault_dirty_shared_page+0x16e/0x2d0
     do_wp_page+0x38b/0xd20
     handle_pte_fault+0x1da/0x450
     __handle_mm_fault+0x652/0x13b0
     handle_mm_fault+0x22a/0x6f0
     do_user_addr_fault+0x200/0x8a0
     exc_page_fault+0x81/0x1b0

This scenario occurs when:
1. A write with delayed allocation marks a folio dirty (uptodate=1)
2. Writeback attempts block allocation but detects filesystem corruption
3. Error handling calls mpage_release_unused_pages(invalidate=true),
   which clears the uptodate flag via folio_clear_uptodate()
4. A subsequent ftruncate() triggers ext4_truncate()
5. ext4_block_truncate_page() attempts to zero the page tail
6. This triggers a write fault on the mmap'd page
7. ext4_page_mkwrite() is called with the non-uptodate folio
8. Without checking uptodate, it proceeds to mark the folio dirty
9. __folio_mark_dirty() triggers: WARN_ON_ONCE(!folio_test_uptodate())

Fix this by checking folio_test_uptodate() early in ext4_page_mkwrite()
and returning VM_FAULT_SIGBUS if the folio is not uptodate. This prevents
attempting to write to invalidated folios and properly signals the error
to userspace.

The check is placed early, before the delalloc/journal/normal code paths,
as none of these paths should proceed with a non-uptodate folio.

Reported-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
Tested-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
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


