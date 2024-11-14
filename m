Return-Path: <linux-ext4+bounces-5164-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168F89C8DFB
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D101B28737B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BF517C21C;
	Thu, 14 Nov 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nvnVM+7l"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7E1632C5
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598085; cv=none; b=cFTY5VFZ+HVq7HJnX2GtKkqpTMuxs7bSJwejQ3boFDvArkfEL5J6AZygxBP5tuJ/SFl9BYPhtxqRfz4X5Jgg+ZEl1V26TWOsEZdgXTpbkhuMLDUVG0F819RkRewmtDFDsCuWhE7Y4M9nzgc3DQBEpqPbGq7D9iz1E4wMS2awSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598085; c=relaxed/simple;
	bh=8sfKwyActgC+UFgrCv8AbW1Vz+K4ykiNjF4V6I33E+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS0CWPZVXv2oOkjQPV46pCo89gcqXcG8tGqy8n8cQ0x3lujq2RVgkOznqhGKt1O+gfaVm2TEfAXeadan4VotzLP/imS+1HOup90otl06GVe7LWlzJDVleSyVRE+xPSXOi2GYh7kd+FZqu/PoOTF86BxVwPZuN+EriSO4nLXttv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nvnVM+7l; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc349204cso382953eaf.3
        for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 07:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598083; x=1732202883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzX2IvmAROGBANn6HEgih/p/Joy2MXPhit7EzvqeXZU=;
        b=nvnVM+7lRPjxgUobjcY29KJyrT1BRlFyRd1jjNUjZlCdoUW/FrYmPGYqQ2yhomt746
         53/sbldwX6FjbV+u0r6hLjGtYQrlnKXLFBmIDDZjJQy5ywl7rRb8B6AkUIJQlO/7/N3v
         uNIcTAwj1jOJ9X9MR8Q0Y2afUODEuhc1Q2bElJxM0SiEQ/BJEErZc15QmDuGCcJTCfU+
         fB1Vr39IPGPLJrYKtSr1bZFHZsIh7ff1m/ti5v4tJ9SdxwZEUk2LSWyx6WVHU3myK1Mb
         IwYw8yaazQ6AKYLAhJPhEUmyblI7oUUhlzYYfoH3mIn6Vp1R6OCtQhSzAtHnjW72EGx1
         TO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598083; x=1732202883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzX2IvmAROGBANn6HEgih/p/Joy2MXPhit7EzvqeXZU=;
        b=K+AfGthqxmbtzJ1Wx0EPYlAa2UU09spQth78YyPXd08VOfJyPgw1zFi1qvEkMn97Zn
         dJeYJbEr9aM9J/YLVil+1yUSdyNllOVbMn41j61LP9UUZdTaEn37c+J6qbwjjPwHWXfO
         KS2QmuNSnF5JB1JjO2ACnN6mIswYJw5yMeDIf2rgEGFIOQ2qLcBf8yxwfXVRmhK+0q1L
         l01un1tQ9Er5DUBkzdlheC6UZcItWQMRhfYbThGKH55yeo4MtarKwBG4CQL5jBsASk3z
         Wi7p0z+u6YEiDMPCloPTZIUUJAvMcysmD0fTbTejl/79nc1eJCBgvs1FMtO1wmS72gsJ
         vl/w==
X-Forwarded-Encrypted: i=1; AJvYcCUajX46rJEDYDomKxkvv3uGO7xoc+Mt4vpQIAFVMxqHHKHYAoV0LNuLMN9nd5dGFxNPsXWZAD47OYL0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Gy6tGHCYFmRezdHSvcp9j7RQBjbsRzNiHMEiZB8fXYqjQgSN
	t1NMJBDhVLhS2IWN82uh//OWh9n9Kz9B6nVp3pkPDSNCM8sjYmMA39XybNGgX50=
X-Google-Smtp-Source: AGHT+IFRnE0ztQRJK93idhhgrf7Bc5KUMDNOKjdutZVsJeSEeh/0aaiCxUu41HRdHQkrlLeWeSTtMA==
X-Received: by 2002:a05:6820:8cc:b0:5eb:6a67:6255 with SMTP id 006d021491bc7-5ee9ec3bae1mr2680975eaf.1.1731598082894;
        Thu, 14 Nov 2024 07:28:02 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:02 -0800 (PST)
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
Subject: [PATCH 01/17] mm/filemap: change filemap_create_folio() to take a struct kiocb
Date: Thu, 14 Nov 2024 08:25:05 -0700
Message-ID: <20241114152743.2381672-3-axboe@kernel.dk>
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

Rather than pass in both the file and position directly from the kiocb,
just take a struct kiocb instead. While doing so, move the ki_flags
checking into filemap_create_folio() as well. In preparation for actually
needing the kiocb in the function.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 56fa431c52af..91974308e9bf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2460,15 +2460,17 @@ static int filemap_update_page(struct kiocb *iocb,
 	return error;
 }
 
-static int filemap_create_folio(struct file *file,
-		struct address_space *mapping, loff_t pos,
-		struct folio_batch *fbatch)
+static int filemap_create_folio(struct kiocb *iocb,
+		struct address_space *mapping, struct folio_batch *fbatch)
 {
 	struct folio *folio;
 	int error;
 	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t index;
 
+	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
+		return -EAGAIN;
+
 	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
 	if (!folio)
 		return -ENOMEM;
@@ -2487,7 +2489,7 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
-	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
+	index = (iocb->ki_pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2495,7 +2497,8 @@ static int filemap_create_folio(struct file *file,
 	if (error)
 		goto error;
 
-	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
+	error = filemap_read_folio(iocb->ki_filp, mapping->a_ops->read_folio,
+					folio);
 	if (error)
 		goto error;
 
@@ -2551,9 +2554,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	}
 	if (!folio_batch_count(fbatch)) {
-		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
-			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
+		err = filemap_create_folio(iocb, mapping, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
-- 
2.45.2


