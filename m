Return-Path: <linux-ext4+bounces-5175-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B029C8E3B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 16:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415A61F24D19
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB81AE006;
	Thu, 14 Nov 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FD0BMbPu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFCA1AB503
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598100; cv=none; b=dhskn/kUPKU1ccAzcNsKwsYYS96fABVJ3rKwERRNfAjaK7FXkeu4xsgNt6Ld5wu/d6lhrSiPbv1ip0ntFQ7FBEtn1Gm0y6/i8pRKEziNY1Fmyzr57KXS/nlAtH5h571h3oFnmq1oa+KiCz6RQok9GaEZKoDDpfbSc7Br2WaM3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598100; c=relaxed/simple;
	bh=Cprr5Wztuokl5alQc44L4Bz+weZZLTHr6zOlAD5+Dc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuiGeeyOIdKuTJY5+nYwZZLepuc48/EQec/j5kPZvQE0erMTLlApz7d18uERh+gmdg2dnN6UZwSi4etLWJlU3TQBl+X6w2J+UPZPA0/km7Db1Yv6EDrlwJ8rBjW7IlFndO+w6FMvP3M8YxwFGe8WRKxntoj1bShD8B2jAmh6XDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FD0BMbPu; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5eb67d926c4so322167eaf.0
        for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 07:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598097; x=1732202897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wvrv44z8Apd8qqgxqZBS6Do0FSmkBjZMAMWmq/c36cU=;
        b=FD0BMbPuTuxr0syAkrOqgbeVJ3V1KdUfTA6rPfo3c4tK6Xus72+a2OHKSE1lgXyCmX
         2DDppcK7C5D7w39z8m4Lvoy77ByuELQBlYoBLDtmlzEOZy1nLCR6zrg6gnm49AaEQdnL
         6OAJRAJCDHhGXePHms7IiKttN36ZhLmru1Mbc4AAZUFBrn7OaFD+ePREa+gIMhk5zd/l
         tq5C96H4cl8sJml5vZNE/34IhvhzaEAFObLQCL+QNThkViFGRXDGQ3Df3Gam6FU7T3B2
         mw3J1ORn9FkMY1S9nHVRb6nsd14/Egb5HPjsu3AYAkDO/ldpeio+5hgXjlU0R3dyBqhT
         eltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598097; x=1732202897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wvrv44z8Apd8qqgxqZBS6Do0FSmkBjZMAMWmq/c36cU=;
        b=N+aSxS+0I2vi0hXIfnyTfUliRtO67htbUVf8D6UR3mlzWg0FtV1/YWa9IDUPboiwnC
         br7Qh1TPBy7gGEzVnboJElhODNNGbdjUUjZPbQm0XEpqDgw4EYxnmoQgHthmL3A3myeK
         P3airRI60mKOKGxqtYQ4N8KUoYeOSDVjulZVAt1DuTtEKShZJrmLFvfpqh62eKjEAQmg
         fUISeD7qBi3gDeapUJseeCA2dS3CEqwvoCyM2EH1XxcSomEKgkWS42UCA4nsqTDxiJXa
         ZdJWb6aHZrtuS53k448uPLzjl4GDE3VTmeujjdaWldrTvYcUAY+Th7tOwc8pfjoKQV9F
         fb4w==
X-Forwarded-Encrypted: i=1; AJvYcCXBacbc99hFeWWSGwy7HDteGRgSEy6NXwZSxwDU8I1pAQkD8SLA0sxcRrnaVA8X/qV9+xtSzMQZ5o2m@vger.kernel.org
X-Gm-Message-State: AOJu0YzsVwPZj8ZzXK4Mp1/1T3y86DzJsW7ZWHMGr+d62oJQbEig6NaR
	1m82f1Gj6zEV9b0+K449WsjX60Pp1Uskxf5k0r8fFQCRQqICYLU+Jm4LOe/QdhY=
X-Google-Smtp-Source: AGHT+IEaTjdnOMAkEmoEcJnRXLnfxDNshZw+Ax439RAi/pKdYn0q0me9qe1oslEKsbvc7WBkYDa4cA==
X-Received: by 2002:a4a:e906:0:b0:5eb:6b3e:ce7f with SMTP id 006d021491bc7-5ee9c6c80d1mr2431138eaf.0.1731598097161;
        Thu, 14 Nov 2024 07:28:17 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:16 -0800 (PST)
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
Subject: [PATCH 11/17] mm/filemap: add filemap_fdatawrite_range_kick() helper
Date: Thu, 14 Nov 2024 08:25:15 -0700
Message-ID: <20241114152743.2381672-13-axboe@kernel.dk>
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

Works like filemap_fdatawrite_range(), except it's a non-integrity data
writeback and hence only starts writeback on the specified range. Will
help facilitate generically starting uncached writeback from
generic_write_sync(), as header dependencies preclude doing this inline
from fs.h.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 122ae821989f..560d3ee1bb8a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2845,6 +2845,8 @@ extern int __must_check file_fdatawait_range(struct file *file, loff_t lstart,
 extern int __must_check file_check_and_advance_wb_err(struct file *file);
 extern int __must_check file_write_and_wait_range(struct file *file,
 						loff_t start, loff_t end);
+int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
+		loff_t end);
 
 static inline int file_write_and_wait(struct file *file)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 297cb53332ff..a8a9fb986d2d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -450,6 +450,24 @@ int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 }
 EXPORT_SYMBOL(filemap_fdatawrite_range);
 
+/**
+ * filemap_fdatawrite_range_kick - start writeback on a range
+ * @mapping:	target address_space
+ * @start:	index to start writeback on
+ * @end:	last (non-inclusive) index for writeback
+ *
+ * This is a non-integrity writeback helper, to start writing back folios
+ * for the indicated range.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
+				  loff_t end)
+{
+	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
+}
+EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
+
 /**
  * filemap_flush - mostly a non-blocking flush
  * @mapping:	target address_space
-- 
2.45.2


