Return-Path: <linux-ext4+bounces-9613-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5146B3401B
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 14:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1987A42A8
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 12:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC8229B2E;
	Mon, 25 Aug 2025 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lPPUD4x4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72291FDE31
	for <linux-ext4@vger.kernel.org>; Mon, 25 Aug 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126425; cv=none; b=F75OtY6M2glsb3Gsmn9wX1hTJ9hG9aMg2RPCxejH5/+GLBtpUMDqm8b+DTEvXoCsBgZznYTVz/8gyETCQrG/dJuuF+PFf7SVj0s0dTEwJmBZXEWRIJemf6PNhkHTK1SqGHN8FRiS6+tSoXKhQNYsKaz8muozMOYy1yWebBa5mBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126425; c=relaxed/simple;
	bh=1zEgsVLb/FGQHrq3v6SLH3vg3+ajNAPVXVrSXj58b+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bQeKAwC04Rn83S7cwuyLSdqb2NTl0sGwCl8tBph1rh1gqCDNBhnVt6o4hF4NXxF9DI3rCAnMQa8AnpXbiNxtVRZb3mo/kgUzXm2htUnAFMup0QFzeXZOZaY83XokthsTleTeauLMsz5/vNH6spb/C9mf6lo9TwUnqaZfqsQf8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lPPUD4x4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77057266cb8so877359b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 25 Aug 2025 05:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756126423; x=1756731223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dkkm1mMFJIJqyLv5AyqoMgolEEmduVMkh7MIx8PmexA=;
        b=lPPUD4x4m9e7jXwu1LtivNjSBIxkUIRQjIf/g4WjHPc3hG1jP3YdpDaZc8nglL7n3O
         Vb26uCkiUnZvTzfTyO776nQ4evpr3KBySkihDVJzVZBx9UnDYoUX8DSYmKyMgOiq8FJh
         jU3VxCesy+R99IxT/l9QCn6L6zWv7fyhq1emxhGQLulI4ywZa/wC58j5Rrs2krd67j/p
         XUC4SlQJ4f/sAByI9UehLjyUkEXLrDcLFMsQDuVOvwcAatC3si2Ml1ORUy/uJ2gZyOmC
         ycac+8VdOfmtAC13It6lVuPeoutUSR8qVzIBoMrZXQJ4riLfgQg9iDSaOjjBtG2o5Duq
         hF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126423; x=1756731223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkkm1mMFJIJqyLv5AyqoMgolEEmduVMkh7MIx8PmexA=;
        b=rwyaqzwGTl7/+Z8Pt9l8vN5WRCEz7f1gHhc3d8J1BB1rOZ4SVecG3x5DPI2ivn2yCA
         oK7XVqbr5WSra/ae27SWskzk4S4EPPmkkomMXOE0uhOMw4438Cy92wLksGAKQcRVjK6F
         GW2s9KT3t0Tg8l4Be5bIJHLNv/MWImZHqCWlR1HgUayUshAXxOFnUT5Bbu5hJvDXEaZN
         s37lFYVXJcbL/EINWdxQT0bMhC1FPFXc3S1fCMEaz7LQSSGu/I9I62xIFVO+aO+IPBLE
         myWabB2oE+QKDp4KKp6aBM99lwp0q4R4nWYPbDeN0zrCs6C54lRIrCZvYwCwHhPCPHK9
         CdAw==
X-Gm-Message-State: AOJu0Yw4tZsI6htROmXcFql0sn/AEYVCa+lYe/SdJsl7gdYtEz2SYkoP
	H01RVS9FsUmW7lwf4d1HURA0u4nevdhxuWot8yhmJCsVqEyGYAcEvcby9dt7e7shk3tyr62cov3
	YkGE/8oE=
X-Gm-Gg: ASbGncuEpY5X0OD3XRTnpMnWpm/HTn9zr7ZoNsnlKt0ax4RO1mbCFcgaVg6ISlNJvh0
	5ka0hefVFDxeVP3ZamONadmtkxzjnIs2Yh4dc2Bu7QrvH9w6nUAQcf6GXL9KXbkoHnJtV6JNlj4
	4ak95Da45aF2BKYSaTZBsJh4GBOvebxjSqBkwUIFPEjSugE3TlU1wG99cFsLm/dlHuauMBJVLhL
	wIgRbBsoOA2m8HS9EZMWe4SQH6OYFwNB3fZaz96nsBVJ/yZocax4UUSwwPW6Mg8uwIrn/fd4P9S
	7kL+BV8rbQfZqt+m8pFDe3D9zbKg8CSL8++IL6vvOjP2QpgmqSQD0GODrrCmG+tq1Ing9gspjZ9
	8VBhgRDCwzdW/bhr1/hdmDZoF5rzuzktNmo76AodSng==
X-Google-Smtp-Source: AGHT+IGtSTE++/4XtvzJaYlE0CqH+6g3Jp1FCsz09V/n7jA2I7ankwRr6luvRGzRklsqwUXkYtW5OA==
X-Received: by 2002:a05:6a20:4e28:b0:243:5744:b2e0 with SMTP id adf61e73a8af0-2435744c04emr7990048637.26.1756126422707;
        Mon, 25 Aug 2025 05:53:42 -0700 (PDT)
Received: from localhost ([106.38.226.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040021393sm7438920b3a.49.2025.08.25.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:53:42 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huawei.com
Subject: [PATCH] jbd2: Increase IO priority of checkpoint.
Date: Mon, 25 Aug 2025 20:53:39 +0800
Message-Id: <20250825125339.1368799-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 6a3afb6ac6df ("jbd2: increase the journal IO's priority"),
the priority of IOs initiated by jbd2 has been raised, exempting them
from WBT throttling.
Checkpoint is also a crucial operation of jbd2. While no serious issues
have been observed so far, it should still be reasonable to exempt
checkpoint from WBT throttling.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/jbd2/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 38861ca04899..2d0719bf6d87 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -131,7 +131,7 @@ __flush_batch(journal_t *journal, int *batch_count)
 
 	blk_start_plug(&plug);
 	for (i = 0; i < *batch_count; i++)
-		write_dirty_buffer(journal->j_chkpt_bhs[i], REQ_SYNC);
+		write_dirty_buffer(journal->j_chkpt_bhs[i], JBD2_JOURNAL_REQ_FLAGS);
 	blk_finish_plug(&plug);
 
 	for (i = 0; i < *batch_count; i++) {
-- 
2.20.1


