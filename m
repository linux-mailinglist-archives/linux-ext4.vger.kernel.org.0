Return-Path: <linux-ext4+bounces-5179-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC39C8E51
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 16:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A1B1F264CE
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0C1B21AE;
	Thu, 14 Nov 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WoVpXnI4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248581AC427
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598106; cv=none; b=iAR++58CXBq1lOfg1P8fcsZNUM/OHcoV5wIBhg5YDQxFhXqy4rnYYU/zabkJEgE712IMxOb9C9Av4O6dflM7/QT7AXldPyI1ZS5esmFCKmoFbABIYER06xgg2QDDF+He/eFHu3JyGMyW3CFa7xz0OY2wZMUE5x+rR+eZ5iFzUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598106; c=relaxed/simple;
	bh=JN6ziuaz3h3w93syhui0sSuROUWYBUO3x3xlg3f4CsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bW6uoHgfaEI+kxYYIz1XDT71fXNc+xnjb9XucYO9za0TLBwGonnc4Wd7IEx4+dL6lmef+XSriR4qA/+tgqYeQW4co14n5B1IXhLYtQPRNXeGoJb/auox09NKyZVROlBQ+omh2DQakS0g0qxz1uk16sQrpeINVOWjjdDZRAZRAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WoVpXnI4; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ebc1af8f10so334988eaf.2
        for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598103; x=1732202903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=WoVpXnI4R1Ju0TIEnacr+++McpiDpZpH9Q7rsPYH9SpUn9vMZESA2hvlpzAFb9slK5
         kHIWPHr2fDItNhMzgknehqNQK8tLhPA9JEvW6hM73LhaRRy6P1wbF/oxMPPvvikdQ/Zo
         3sMPrcD5h4Ji5j8LgRvmBHgma4Qs8y09MMpZ9DnC2FgWelnCb80ECIqLDA7SbF6FwbPl
         5mw+If/NSXb+vofSMxXaNJ078D5LfKDV2JciLksbXBrH3M8HL0sYiVrD35w7uu0bImjQ
         QiWj0Z+1VD54U37NAz28/FTSm3TmZ4IaXCvolffB+k3C6WtLklSP3aDYWTWP1lxSYnA9
         eOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598103; x=1732202903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=u97XHgcGSrPQDcsiJyrSBLB8TBu87h17yB/O4aD/KqJNLQvQVdXwPRuWrI0InACuqc
         7PE9YRO57wPDCcxq2tEHnXQlL0/bQdmoIfx+9dahEbKQjVe0zYadyD1krQNawxT8ZznS
         vqisWIhc7wFkI1IrCPPrtMtiwhsF/zI9oEP/VgAfiv6pxVawfnta6bYA9xJNnMVWxBMP
         aR2T4XAlI4Q3qR7122Vy+3Xj2D34KSN0GeaVLEcF17R7ESHJAe8fxfCvt5Pejbshyo48
         Dti5q64lYHFrWhjJCr+N6SLHYi8WU4qCOeX8GI+P8BNgwl7oSxCS5W2jEjBW2RlKjCNR
         wnPg==
X-Forwarded-Encrypted: i=1; AJvYcCU4SqsV9jVLYzZKuzu5NveBwYhjJO55z4ZLrRmkm+pqmmnFir9t0gY80HVtMg313FPZDFF2ZkQhD2Rl@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfCohnjajnstMmVbwXrx5sgg/Hk4Pmbcrmhb5JSH605+HgGPI
	Ds5bqPlYcJdx2xHdIRGppXeGW5ykQ1oDKXtkANx3pToyoORkIzE8WUcsL070wsM=
X-Google-Smtp-Source: AGHT+IGxBOidvnNn2woru7d3dY6RKyVHYMtr7QGUJGpSzdzZfL3L6KYNggyKAJszR8sQZicyWvWugQ==
X-Received: by 2002:a4a:e90e:0:b0:5eb:88a5:20e8 with SMTP id 006d021491bc7-5ee9ecc2c38mr2597677eaf.1.1731598103136;
        Thu, 14 Nov 2024 07:28:23 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/17] xfs: punt uncached write completions to the completion wq
Date: Thu, 14 Nov 2024 08:25:19 -0700
Message-ID: <20241114152743.2381672-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They need non-irq context guaranteed, to be able to prune ranges from
the page cache. Treat them like unwritten extents and punt them to the
completion workqueue.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_aops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 559a3a577097..c86fc2b8f344 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -416,9 +416,12 @@ xfs_prepare_ioend(
 
 	memalloc_nofs_restore(nofs_flag);
 
-	/* send ioends that might require a transaction to the completion wq */
+	/*
+	 * Send ioends that might require a transaction or need blocking
+	 * context to the completion wq
+	 */
 	if (xfs_ioend_is_append(ioend) || ioend->io_type == IOMAP_UNWRITTEN ||
-	    (ioend->io_flags & IOMAP_F_SHARED))
+	    (ioend->io_flags & (IOMAP_F_SHARED|IOMAP_F_UNCACHED)))
 		ioend->io_bio.bi_end_io = xfs_end_bio;
 	return status;
 }
-- 
2.45.2


