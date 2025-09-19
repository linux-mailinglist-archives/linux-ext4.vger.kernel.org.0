Return-Path: <linux-ext4+bounces-10248-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81576B879CB
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 03:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 070497BC113
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 01:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E17215789;
	Fri, 19 Sep 2025 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHtg/c3V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851801A3178
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245544; cv=none; b=DyWR19qUs224FYoCRl19gc68lPkI5U8c2GaXnMjGMex2vrEGd/wgAJuzYtoxMo2fn4Qw9DIR0Z/3a4ovcKAbzYgeBTZ+xnHPP5/D0RE6hZwROONT/Cm+wXF0K7rit6yCKyZD/+voolSDbAkt4T5ArmHyDH9bG9apX7ZByHiFA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245544; c=relaxed/simple;
	bh=IMwoAO7D+k6VZYnvugxeLytkP3tWMysR/ujQGFHc5D8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOEipF+9UbH1Dt6cQAMv7YATY6Dyr73WZQbXjBxgnt5Y2w+y14DBlvYX1Y3JjsnIrf/3KaakZbXoRE4khGl9cURmxCAPyxr63v6iNftf0lRFRNJlvFTszCkWf5MNyNZ0E50orj2QUuvFUlvMy9XiRGk0eQTuGXjvnvDc/qS+aK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHtg/c3V; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32e1c8223d3so1312559a91.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Sep 2025 18:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758245542; x=1758850342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5lgqi2Rlwi0JZixE2amZJ0mVbQUOl+bXRlyLMTuGWg=;
        b=GHtg/c3VMc/gfA/A96adJeQKDLZdgj0Sr+8tsgQGzHRaWeCgZiJLH/4c8V9+2h8P35
         A8tb5uFxRo/rLg29QFKHs1wf3lmhDITO3lXTJgBNkY2z7Na44TL/0YYlR7b1oYOtWXmn
         S5A/ZhcQg6puj7uN2m+YekdPhqsA0wTBPKk9A6/EYaGbry5vHM5n08xZc8XiYKREzbWX
         JBn1+aUn7oU15/GlFWItRYIefVqSbx0Iue7g47R3qpAqQegwvb2RgCeryp8hR9XRgDVF
         P2AzJ04X0mZXTyS2xDPxCr7aIqtxBxU290ue4HpyFJqicymMO+jwadK9sykTaSPB0MlJ
         tbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758245542; x=1758850342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5lgqi2Rlwi0JZixE2amZJ0mVbQUOl+bXRlyLMTuGWg=;
        b=MwhdFZo9vUnARbiIIfWz3q1D1HSlzMskP4NlQfOeOhkx+QRUGk0zPgURR3tQVmPpk/
         MQVGEWNA+98hA4PcDHQKtdRJoZwmy/yvZsMZyRUFPlWih75IdoWDbxT4gGW3h+ZBTMUA
         Vp/kf4xa7CBEmZvpxidGUPoL19R3hzQ1KgV5z+jovxRpYSJHBkdhsDtASoO1ad7tRaB/
         lfSDSsNn658ZSY2kMJ/8JRP9WvXmk61NwIMlZX5jbnsOIyVmPMDIzgEeN+gnlU+93EiE
         bTcl/NRZKckGSJuueVGxJIqTTAUG/EvrcJ2eHh0r2syodNI6zfYRF+EULGZZePSBsl2u
         pLMw==
X-Forwarded-Encrypted: i=1; AJvYcCVZxzNvnKCEvOC0obiqn9qwmc7TvwcE8dK4vhup9nFt8ZTWXgAY2/qL9qpdvAmegDqHgIu+gfCvKL7U@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/XfU7bAG9aiTEJxSmkGyDqlVog0ozNwi9pFhvyQ8pR6hRf3x6
	ZAT7BiQo8BeXVmUESL3OF8HZdjXZiFoKO+woACE/YfV5ca7zSGL7URZFNaPmpd5JJTw=
X-Gm-Gg: ASbGncvVQlLonn9u3K2kLRj/L01Xn3+zMYHuo7ImHCqN0Za5UD63QnMrzCt4XDLHbek
	APogmVZ16CF3UyGVuqqO1RG1XH0vO8CpbVXub1zbri5TFX1NFq6skrA0IC4pCw5mEdj3DSEdH5h
	pIZ9zACWD1ZUntaLzeKCnKd1vUOGJgZ14RJdkJ400pFWDqcfjWpNS70/5FXm2xtcaTXybYqh+ed
	iOT2L8YrpXaZhhxtNakPjAHaTFwInsTL3bBBxld2IF+NoGujyjvc1B/7Nx5yqMlMuQwP64wtIby
	W2BMRc/qHEktnz+KIqkmerI9y1Q5D2QTS1Be+WjFPXj2bjoJlGLKqI0O/fzIdl1VHsPL2l0ie90
	+piBJPTi+oU8O7AKAIsDN1Y3qwL5O1rExknnA9R8SSom4d50PqNtTo7q6UzAQKYC3TifH5gEmo5
	sVgf0=
X-Google-Smtp-Source: AGHT+IGJgX5n1noXy/69tl/3Wn1T+x/aINUA9lmm8EE5vmE4tqsUUzX7uMkA6LH65iw5D+cuHCtTKQ==
X-Received: by 2002:a17:90a:dc08:b0:32e:87fa:d975 with SMTP id 98e67ed59e1d1-33098386c09mr1380659a91.34.1758245541760;
        Thu, 18 Sep 2025 18:32:21 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:9a89:926e:b413:48d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306db47817sm1512006a91.4.2025.09.18.18.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 18:32:20 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-ext4@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Fri, 19 Sep 2025 07:02:14 +0530
Message-ID: <20250919013214.472874-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Fix WARNING in __alloc_pages_slowpath() when ext4_discard_preallocations()
is called during memory pressure.

The issue occurs when __GFP_NOFAIL is used during memory reclaim context,
which can lead to allocation warnings. Avoid using __GFP_NOFAIL when
the current process is already in memory allocation context to prevent
potential deadlocks and warnings.

Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5898d92ba19f..61ee009717f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5656,9 +5656,11 @@ void ext4_discard_preallocations(struct inode *inode)
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 		BUG_ON(pa->pa_type != MB_INODE_PA);
 		group = ext4_get_group_number(sb, pa->pa_pstart);
+		gfp_t flags = GFP_NOFS;
+		if (!(current->flags & PF_MEMALLOC))
+			flags |= __GFP_NOFAIL;
 
-		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+		err = ext4_mb_load_buddy_gfp(sb, group, &e4b, flags);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
-- 
2.43.0


