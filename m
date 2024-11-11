Return-Path: <linux-ext4+bounces-5047-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57EB9C4A82
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 01:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7478B2C78D
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B461C8FA2;
	Mon, 11 Nov 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XyRfUh6B"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69F1C245C
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368933; cv=none; b=qchRWQbmVrww3G8Ywrz2/xooCE8cstB8m/xAL/8X1ajw1A0rq0D4qqH9BBy+ECyA99p8taoQu0Z6bavT+30tYfFn5P/x2lH4ooqSKWXu4xLJ3L8YuA+9uGAxJmM+x48sPRDkrSptx7+Cv8YlQTng7Grk8BJzCracDFEgU+uZPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368933; c=relaxed/simple;
	bh=klEANlDo0QcivFe1NIYDNiOFa1lRCa2wf9JjLv/2My8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C43zazE0Wp7vSnBXFvYxgg6+2YrrhTPebU6R1oQvzWCc8S9cJfkDpKI36WbtwuuNP1YhEY0JVLR/qXhzPeArH2IHlX9AKt7Xf/Wn3sEfTuUdDvPXcA8pqzt1nP4xqH68awY3whonwq4/WTPcAyu3m9gqQ0fLjvQE3PBzRhbgxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XyRfUh6B; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720d01caa66so4744381b3a.2
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368932; x=1731973732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QDQ8u+XOjRX6rdX1KxWEpFxXqQ9HPCp5iTXnKjwIis=;
        b=XyRfUh6BYtZ2g14d7GAGy9wrJQ5P9sCjQKhoDrSVSCjvCANbFguvc/B9iUzDuFcGSZ
         0y1w5OnNvFsV7kTfG3zQFD9LNW8T1CKqN0UAzcSDyo4LFB/a6uXK7MDRih87Dp6LFIoW
         L0bjq0y7i6QPyIEpJ2hI/kzFkLJv8rz8l8V7WzWZqC+W9ecB0XKyA0Tj0UR303WAe2bu
         IXPnq/ZSCQHjNr+zuA7INYMMu7ZQH8x0/DZgB633RbzUNJAuJhQ1nRA3jeq0OtevjsSJ
         kpmSt6FHnrVV5DpS+nMnvASBxUrrZPwasuVxZgayILUGIUnXHVHYECS0QrLntiGFmcBN
         H9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368932; x=1731973732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QDQ8u+XOjRX6rdX1KxWEpFxXqQ9HPCp5iTXnKjwIis=;
        b=l/6oEW0in02AuKRHRz1dO6KAnu12/1ID/4oDVq8X5rPkRBx4ZcSiNel+Z43T1Y+nuh
         MYJmryZb92QTZGvtUJnsar9R28jI/tF9MTSldpIze2Uz1koGUulcCtU6A4u5qiB93X3X
         yMdNpJb4MKjTlMw3dtZJTi9zVtGDCGf6seMI717isHoRjkjKbHiZkfnL+JbJWQLXmS4a
         YVmv/KMMnsHFEaeCfHWeSFbf75c1syg3ehOu54pE6kD7D35HxhqKaYK0dLLdAo4zH7LZ
         PeqaRN/AXb6KXVTfX0Duiws/qA4/MBaw1QFyUmPiX4Ggq8Z0LEQ67ZNQowdm/uSD5Umj
         HMSg==
X-Forwarded-Encrypted: i=1; AJvYcCUHD6hmYoWB2K/5cwl5EMmEywN3g1o+fq3DsvVX3+U/N5j+TzJTlZgtArMqcbvI/9E/Qfjr++oPQ85X@vger.kernel.org
X-Gm-Message-State: AOJu0YxovVuVp/N8lilx72+yOs7hYs5pK4qFbsP4Zs0t0yOACPVLwfyE
	Pjfn5O4xixmGWxJdM2FOqlQgGr6bB+cokTZNCFNEvZB+PiwDkfgo9paph7JOaH4=
X-Google-Smtp-Source: AGHT+IH9/1Olbxn3KTdIUuB7+y6iPc85Xc8pyUcg5cMVAU1yzHvt71d7cxX7HqTkOKWntgPA3yDsaw==
X-Received: by 2002:a05:6a00:2e99:b0:71e:4ee1:6d79 with SMTP id d2e1a72fcca58-724132749f9mr20118106b3a.2.1731368931568;
        Mon, 11 Nov 2024 15:48:51 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:48:50 -0800 (PST)
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
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/16] mm: add PG_uncached page flag
Date: Mon, 11 Nov 2024 16:37:30 -0700
Message-ID: <20241111234842.2024180-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a page flag that file IO can use to indicate that the IO being done
is uncached, as in it should not persist in the page cache after the IO
has been completed.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/page-flags.h     | 5 +++++
 include/trace/events/mmflags.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index cc839e4365c1..3c4003495929 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -110,6 +110,7 @@ enum pageflags {
 	PG_reclaim,		/* To be reclaimed asap */
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
+	PG_uncached,		/* uncached read/write IO */
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -562,6 +563,10 @@ PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 FOLIO_FLAG(readahead, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(readahead, FOLIO_HEAD_PAGE)
 
+FOLIO_FLAG(uncached, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(uncached, FOLIO_HEAD_PAGE)
+	__FOLIO_SET_FLAG(uncached, FOLIO_HEAD_PAGE)
+
 #ifdef CONFIG_HIGHMEM
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa2..b60057284102 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -116,7 +116,8 @@
 	DEF_PAGEFLAG_NAME(head),					\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
-	DEF_PAGEFLAG_NAME(unevictable)					\
+	DEF_PAGEFLAG_NAME(unevictable),					\
+	DEF_PAGEFLAG_NAME(uncached)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
-- 
2.45.2


