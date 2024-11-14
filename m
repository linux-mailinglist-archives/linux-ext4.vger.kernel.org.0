Return-Path: <linux-ext4+bounces-5167-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DBC9C8E05
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 16:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ADB2821ED
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C2B18A6DD;
	Thu, 14 Nov 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KoxCnn/F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3974183CA9
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598088; cv=none; b=m8x1kLsOxNpK0oBOqEw2yZOZd14ddZHl22PzI/dPweSUYWuTMHe9wiSTB8JSHeDQ5fSX10MSMWx4eh4hWywj0LaiZvr6lv9Y7qoZr2MGfFWpcbqRT7ZzsGHxKck19NYukJgNdbvD2qWxfgWlJJSdMTK0ueq5+VksU5iiOfkSG1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598088; c=relaxed/simple;
	bh=klEANlDo0QcivFe1NIYDNiOFa1lRCa2wf9JjLv/2My8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKsefGbFy3sxyWmhLpvoO/5hQVsjTCy8CL5kz81NCDuLyiEPjRxKY1/I5a+40kJBOoHaghtq7VK6BfdN+RpQdj1gFw+G3RJzcjUkm9pI9FBSJalO2nRE6cXZGkYClCtqJCMrA/rhmvtBbJ4jEvfSuWbcMcLUgN7LQaHXG17MJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KoxCnn/F; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ee58c5c2e3so364312eaf.2
        for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 07:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598086; x=1732202886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QDQ8u+XOjRX6rdX1KxWEpFxXqQ9HPCp5iTXnKjwIis=;
        b=KoxCnn/FfZycku2PMA2bkOnRGL+7wMjFuUNW399IDi7AkgoaONHvIcoqxIm4Mc618f
         n+G2NlDxEQyTBhHyTF1Q7icxPcS2tk6UMfe1IJ5BoLwNdx8zT+6d2TvipJAMQ91PT2by
         5PmpYJyfO790CzxMQMtRgHw0GKGF90BzFMMuLRj55vzXkeaXrCSz3NBUbHcIp6AMikoC
         wVcwvVgAfmZV/vOeQx+NFcy1y3JIBsqKElVuysSQV3shkBRrrmAGt3+SiD8d45XaAIAJ
         5xLmUmtMTlQWn8fnHj4rR4HIUCF4yCCKqzxBUy9N42SWgTb+nWXuaFowTV5FelV/QNKL
         6Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598086; x=1732202886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QDQ8u+XOjRX6rdX1KxWEpFxXqQ9HPCp5iTXnKjwIis=;
        b=YpGvF24AQrO12x/Q2xm+j2ltXxc9mrbOgrZRprYfIGSKlCZokv+KKpnHDrvjiCLg6P
         Nk6RZengTAG4WRv+RF0YeNqAQfD2MAGv2h3RekTtAokBf1GbaOfumaBFtT5BZ9k+L/6P
         O+MSJN9rkMxBRKHF5l92vIf2yu843AgqLiSK0rL5VMgDYndkiPWfv9HFUaFHZHPbaXw1
         hMYM/Qto5f1c0xAS8o1cjltkFfCg5MNYZzp4c9bbYIffQAWNpawrmM3gz95/KYJEI80H
         kdKHGb4jTpWEsovwzbCPWdzCWdHkqYlulz4xJW/9IBRxuHguuT+vT7BZM7nw2CubTFBf
         L/1A==
X-Forwarded-Encrypted: i=1; AJvYcCWjLIprpXAgDibSzKgeCSsqpxBx0KveIN8CHz0l2z0DLvSGYfE2br3WX7NhXNzbR90//qLp97rRsMve@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzV7GKFxkzVj8EmUCknUnf/Ax/5myGu8vINEgdWDNNPcG6TXv
	JoqdwU0P4EBJMiG6+iwqKa8hV2ufIoiFqygV/+w6ZaeaDnAi2dh0/OLTX7ib9Vc=
X-Google-Smtp-Source: AGHT+IHYfzNU9jsYZVqq6BubIUmPINzkrBJpOzUKZ5nbA/vQYGCWpQqOD4e90GxHDczr5rmeIPTulQ==
X-Received: by 2002:a05:6820:3088:b0:5e5:7086:ebe8 with SMTP id 006d021491bc7-5ee91feb02cmr6995384eaf.0.1731598085665;
        Thu, 14 Nov 2024 07:28:05 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:05 -0800 (PST)
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
Subject: [PATCH 03/17] mm: add PG_uncached page flag
Date: Thu, 14 Nov 2024 08:25:07 -0700
Message-ID: <20241114152743.2381672-5-axboe@kernel.dk>
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


