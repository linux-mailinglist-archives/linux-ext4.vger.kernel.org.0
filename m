Return-Path: <linux-ext4+bounces-1423-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127DD86C092
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 07:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1080289AC7
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 06:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6FF3C463;
	Thu, 29 Feb 2024 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgqGxR8x"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0D3C460
	for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187026; cv=none; b=bgtO4CAujM30CZNTccNi5cX0CE2SeNbKZ7BAf5HaZv4QFnvEelliXN7IYmeWuKjtIKObeKyCszVhTuM+fGMFVHw/9Ij4f+MKXkyjocL1tXXraZqep1o1zrm5B2ngVjsb5ywN5Y+5OHzNEpt4VGTSy0I+B0/beEHjne/+rrWaKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187026; c=relaxed/simple;
	bh=DA5WdiM8ZRvQEhZnLVTdgjNusGo7/jHQEtqlalujZbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJkqhL9quh3sfDuVXSZqrh1mq77e7SLQBPAx4T+TJfCsHW0Dai2Lnhd/K/nO0RizIBABRGSdoiWGNY7+/hmI/jtcBu8/E9fgIDQfia+gf4nseommn8ubmPrxK8FsWVCVoUh9cPK8ZqdLq1TsPpDNRk7C87WORKzYcThUhG9KtsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgqGxR8x; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e57a3bf411so317199b3a.0
        for <linux-ext4@vger.kernel.org>; Wed, 28 Feb 2024 22:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709187023; x=1709791823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10b0aqwZV7A1WQecO+FEcQ0s2q0Z9fMjf242h06tF/A=;
        b=WgqGxR8xRjGRu35JL1xjLltLnCuufmXvJU9bOhqJKbpbbUexCI93SYqHFbF0xkI3We
         YGy1+kwkqatt//QgAgFOKWNTVUnPeeriaH/XVa5Va9W71YgLiam8vBlY5e0wkXE3Jc4W
         nM73b4YBagagvAdQsk9yU44AlQdn1TqDggcjaxi+FiQlUYoZCLyIA7QC4veCusuQbkx5
         gOFqHeC27ZAFcTl+07RyIrdlmiBrcX3/yp7GTSDxPn219Gp5FziLlBF4tqMiCzOCcTEW
         5bv/xiBroLswN3SUJqS9o/w3QyjYHwD6CG8YpSgpvQnrwgPDYub7h98mEfUkol+M8YsI
         nSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709187023; x=1709791823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10b0aqwZV7A1WQecO+FEcQ0s2q0Z9fMjf242h06tF/A=;
        b=jVy6cSUy/1w02BBZX2ieJJkWsVq/6rqCCRqm9p6CBwMbXeOfx0R4XU5m5hLFHBqQ/D
         Oi/e0Fo+rTXbh6dgCw05ghxanbZpx7tZkCtq5yAz5ofIoH1rlwX1/f7UfQaGKYrQu5g1
         yFrrsng2irvG6lwqWX7yRL4tzyrMpLFjwQZ1u/5txnjwRZBsHjhx4myKOWMaiwSI0KGc
         x2p7Qt4/XbRwSQKEnEzPmYrDXJCF/5tUf4eVGmaRMyk2iHbShqhyCNkjUWr9MDRkGG9j
         /9BijNRoVz6RYSCqZgANO0HNDq08SmfnKP36D4wfUb76Y1JwPvgtTHpx8UA6fFjDISFV
         m9bw==
X-Gm-Message-State: AOJu0Yxj9wN2rBASL/JlEag0Bg3EUKkgrro/48tjma9uWI8t1NLVtbuN
	0ok2S6fKnCAkrwf/CsTTybTX3H4B5gVKihSxwbQNn8LhNCZz+d2XbEPvpFTVZGU=
X-Google-Smtp-Source: AGHT+IH6Pkztg1wJtfh3X6LzsfmDptdJVhhNBuRERGcxrsVNIfOA3eut0DCOZihhFAVf4y1mNjX53Q==
X-Received: by 2002:aa7:9f0b:0:b0:6e5:696d:9eb8 with SMTP id g11-20020aa79f0b000000b006e5696d9eb8mr1250804pfr.3.1709187023487;
        Wed, 28 Feb 2024 22:10:23 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id c25-20020a62e819000000b006e506ff670fsm448996pfi.147.2024.02.28.22.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 22:10:22 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 2/2] ext4: Remove PAGE_MASK dependency on mpage_submit_folio
Date: Thu, 29 Feb 2024 11:40:14 +0530
Message-ID: <d6eadb090334ea49ceef4e643b371fabfcea328f.1709182251.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cff4953b5c9306aba71e944ab176a5d396b9a1b7.1709182250.git.ritesh.list@gmail.com>
References: <cff4953b5c9306aba71e944ab176a5d396b9a1b7.1709182250.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch simply removes the PAGE_MASK dependency since
mpage_submit_folio() is already converted to work with folio.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bab9223d94ac..e8b0773e5d2d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1865,7 +1865,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	len = folio_size(folio);
 	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(mpd->inode))
-		len = size & ~PAGE_MASK;
+		len = size & (len - 1);
 	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
 	if (!err)
 		mpd->wbc->nr_to_write--;
-- 
2.39.2


