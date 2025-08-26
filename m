Return-Path: <linux-ext4+bounces-9672-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C55B36EEB
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6253E984178
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A3E350D44;
	Tue, 26 Aug 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="krFGrNjK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4F372893
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222921; cv=none; b=DOY1ylATKdZuP/LmbemnoahRPB/eE3gPod+6fbWEJVWEO/NqFrjyStxz9o+5Capa6ZMmjVgREMCge2rm/QC6kRz7m2gsgZfLdBA/ZEf+JXcy75pTaCVZT9bFYDxQQ4wYKKNoj/53D8TSzFCXf6eYzkKWPyX3cQcPXxqhLM1fe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222921; c=relaxed/simple;
	bh=AyaIgaj6Jud8JERDUR0C4MqVOxuTwvj6iC1ttg70Qqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMMC/Okf817Rjp/1AtKVxjqB2XlE1vzjAbvtUmYTQpOkVjcpLUVfBBWYu4ySPuSG8EG6AnpYaCiACt1g0+XwsArNT+Qrx2hOH5ZgGqqROfAf1m+e8Qtr4PcvziEZbjYcC4GU7iaQ7BBGqiMNIvTkPpyAtFjmAypieeBy1rn+xs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=krFGrNjK; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d71bcab69so46143587b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222918; x=1756827718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVq4Dudny0hs/Tg3SlCX7d6XKt3AfTMDJTBRxWNfvY0=;
        b=krFGrNjKM96R1p83X+oky4JLk2HFtPk+A8wMnnPefNfgzgmLK1KsUYQ05LdDwTjCGi
         ySQ/JOfyr+l8gXbljhhPr4cBIKcmh1lUOceV+UD2cCglX6KjOCO8AaDl97HLP1fjEdVk
         wO4BbBwfT9NSA6n4L8s0NzUjQuUEgV6Frr4SD8jLbIJ/gwj3olWfX4kY9ZvChT0zI5BA
         sNJeidPgJ4WdH7N21w3zUOmlh6a1Z7/v93WA8aRJK3LoXECzYR3SDknZYLp5rxGp9SPd
         srbz+OcP8CitgIZCu4CTJLaq01fG6al4BDbbBtXLv6ZIHmATERoVNeJLbRlpdosdGVD6
         7xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222918; x=1756827718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVq4Dudny0hs/Tg3SlCX7d6XKt3AfTMDJTBRxWNfvY0=;
        b=vxl/7+6NTTDj7X0syRSst9/Mya3rVNCqHM9Ss2EOfjjBFiMQBhf4utNU/aUASgw2n8
         +QejE+vDuVrnZ/Eaj3rLlmqo7DEkLOHTRcBFZrUi6Y7WFPQg1iHhVMqbwrgIyq9WZHgf
         0yEk9Jx0Vh8ab1OVc/xmPLYLU/v2sKx84nIpsfgJFwH8P2GAzztpQ8lnwanxFBa8Sx3K
         I7hyu1NVuzbmJCqu6UQuwMT9LMg4guZ58/Q58Vs7p12Tws2h/YCXbWWt2GbcCjPmG4jf
         /Z1fElqBnwsQVGmJKYxrNxUGDLSGdO+mwDPN5ZA1hfRmkHGQXcWbMWQ34SIVGrZQV2GC
         fRVg==
X-Forwarded-Encrypted: i=1; AJvYcCUA3XrxkiKlo7T+ydDlcieLUt6Uh0ZxwGsMtp9CHhOXFdwMKlij+EKB51xzHlrTg4U6sDWCHDVISgCV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6uns97h40VqOsyOvToP+c0iNndU4LqzLt1Xf1gZTLV9ZjBRw
	5eIWVjtsLS5nufDNTgkmPbEkyruvdLdiyQy8akoW6OEvllnYHN+gcsTspC3nBKw5+f0=
X-Gm-Gg: ASbGncuqKgK09Wrukxlu6urZUSseH2X3qMbSL0xhgorcNJ8i9WZFBNyLh5SJKK0jhnM
	lTO3d9mMMGgFfrvANg9X5vuwseHLgW/sx39LbRGl3EaxhYY2I/6L7frFaBHXamWnmEyFOxXPbUK
	NipZx2oiwr6rTBh3rrnyGxVr5MYrYSm8JbK5DIN6OvZT0/ttgbSKNSf5RmrkZEIBxLeRJEz3boe
	8JHY0DUFS+xnU7HXXGSp/NzYIVzE0vAUFflFAzGHLjToU+18wTXeMOICSSTWj+nCf3fWcRJcDVd
	5YBPdqSjJix6ZIeIFeqcsyxTfwgr5ojGrxd/K4POUntsE0MAGQNLlMtgEYGSG/2/n7Z3KtDtYGC
	PnLWp2jspzFZWJ2HFQxG9xXDWgtCYw3VpFHg4sutPf3H/p2wpn90xB2ma0CvSp/z08vz0OWkzJr
	8Hb8Ow
X-Google-Smtp-Source: AGHT+IHLsg04WEluK1oVuZpp+6T+vzscvTqme64BMq5PmNGW6Hbr2OoPh7UrrVnEqIvcPfOFGZSMjw==
X-Received: by 2002:a05:690c:3507:b0:719:f7ed:3211 with SMTP id 00721157ae682-71fdc2b0312mr166349697b3.7.1756222917584;
        Tue, 26 Aug 2025 08:41:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17339fdsm25186297b3.21.2025.08.26.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 47/54] pnfs: use i_count refcount to determine if the inode is going away
Date: Tue, 26 Aug 2025 11:39:47 -0400
Message-ID: <1d54ccfdd1e49bdb270e1cf1f6482b809f037d73.1756222465.git.josef@toxicpanda.com>
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

Remove the I_FREEING and I_CLEAR check in PNFS and replace it with a
i_count reference check, which will indicate that the inode is going
away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..e400e3334c75 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -317,7 +317,7 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
 		pnfs_detach_layout_hdr(lo);
 		/* Notify pnfs_destroy_layout_final() that we're done */
-		if (inode->i_state & (I_FREEING | I_CLEAR))
+		if (icount_read(inode) == 0)
 			wake_up_var_locked(lo, &inode->i_lock);
 		spin_unlock(&inode->i_lock);
 		pnfs_free_layout_hdr(lo);
-- 
2.49.0


