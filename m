Return-Path: <linux-ext4+bounces-5050-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE309C4A64
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 01:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5415B2C23F
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 23:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5AA1BDA89;
	Mon, 11 Nov 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R4aiaU9j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD451BD9EB
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368938; cv=none; b=Yrfzp94sLXC/NwDj1CA0RltFKDDcdgzHgKtDpPIonX+AZzWGdhUD3fyuWrRGl0SIptfydxHXTuL1z5sc5blk0QyquTRh/e8l7FHlVjul7nRxaciuZjbqB6ZeNxErSo53mCFGC4uoq70V3wxBayU/cmUkuSHrRr+/khbO8fkQjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368938; c=relaxed/simple;
	bh=9Ma4XXKwKrbfCmk8++0FMznuxKmPjzqiFxHZUZ9JUvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6WkUhzF/v5N/pEei0rFgvhZZMRvmiNLh0/U2oR8d0EUswOFD0Caj3I4EQAJsB5l0S5u/AQJMpkPPzqkOiffn4HAdbHsZwQJ3PB+FSonkG8stiBmVdPh1wLpUHlAhPqX6a1VSo0c58lq+ktLdlFJLqbkMkpnEQS8poh+EhjOsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R4aiaU9j; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7240d93fffdso4129833b3a.2
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368936; x=1731973736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL+fLnGK0BaMmMKm57rghb0D3nDN7TOwfaAxP5ktg80=;
        b=R4aiaU9jMdoXAa5LmgNMxyvFc/Uw4BX0xojgO8xFzGRanykKRWYDUDxa5zSd2FP+da
         2/d03PDDT7mnhyzNolWF8mXaubonK+n7vPkCmjhw5Q5nTBMgqWqKJpLSFITxoFofw7Km
         5bkWpUBbRX0UnN4AcqdLVnOCqscDu88xVBX/kYbwyfpp+nGwVyp3DuORQwedYFsxuAxf
         tJ76CARYeBEC+/KVXnkWi8pMKzdVicNjxFhmwbo6OPJgCa3gHhMLpQ87VKaS+rEuHMhB
         lToEni2gTX8sH3PRBY2+gSwr/RdQhyxPOogh4+g1caIeORHHruxmpnlqR3kSbFAW5Coy
         wRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368936; x=1731973736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL+fLnGK0BaMmMKm57rghb0D3nDN7TOwfaAxP5ktg80=;
        b=A4WGBKvnR80FPGBNbPkX6WMZvoGG+LbVp+nbZO1esN2t2pw8qM/a0paGalbhtMpwJs
         S+4aT1+H4b5BsRPiOQelMq/ukrI6pO08hhS1IeL/qAVnYCYPOYW7v7QJPfBZkyQbWCaD
         emss7vU9ERI2cfmUcKEL7Ca8KA/xYka0txfpcvBoCEFZ+IypaPDnQ1j7PG5VyVaVraJ5
         EBglHd83rKwe0elHI/FP3q0ryLt8Sl/ATrY+GBs4FQm/qJhtNpLrdh1yaOzNVwC7XhaA
         4nuAAymr6qIpiDHvCXYMQVm6qc3mI49pR7oBpAFiOe0JKbI9Eo2mj5zFxyx8rk+zzFqP
         QYeg==
X-Forwarded-Encrypted: i=1; AJvYcCVovkUBNHlk0Y848Guj6NxFRoUrYjAIPaQC5hGWjSpse8z0sRrMdbmlcP1O9QEDPlMi0aqhbZALSlSV@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWkdUG9iOJ1FihsMRfq7+vJmPzcC8GAIXkK1tjD7K2zzCXLaV
	J694Rf3ObE1aQ45lTuZym+IMpOX4hpm3Pt40TmmpguJi8IhEEAtbj1iajIZcj1s=
X-Google-Smtp-Source: AGHT+IGkT/vleDHQ8M3Hw8Ha2+EPGBpXcHS4Q/PdXfOEbEN6KEGRSFgIDbBBEJ7VgYq4tyZ3FLhGBg==
X-Received: by 2002:a05:6a00:3cd1:b0:71e:64fe:965f with SMTP id d2e1a72fcca58-72413350e9cmr19827356b3a.20.1731368936369;
        Mon, 11 Nov 2024 15:48:56 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:48:55 -0800 (PST)
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
Subject: [PATCH 06/16] mm/truncate: add folio_unmap_invalidate() helper
Date: Mon, 11 Nov 2024 16:37:33 -0700
Message-ID: <20241111234842.2024180-7-axboe@kernel.dk>
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

Add a folio_unmap_invalidate() helper, which unmaps and invalidates a
given folio. The caller must already have locked the folio. Use this
new helper in invalidate_inode_pages2_range(), rather than duplicate
the code there.

In preparation for using this elsewhere as well, have it take a gfp_t
mask rather than assume GFP_KERNEL is the right choice. This bubbles
back to invalidate_complete_folio2() as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h |  2 ++
 mm/truncate.c           | 33 ++++++++++++++++++++-------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8afacb7520d4..d55bf995bd9e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -34,6 +34,8 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count);
 void kiocb_invalidate_post_direct_write(struct kiocb *iocb, size_t count);
 int filemap_invalidate_pages(struct address_space *mapping,
 			     loff_t pos, loff_t end, bool nowait);
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp);
 
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
diff --git a/mm/truncate.c b/mm/truncate.c
index 0668cd340a46..5663c3f1d548 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -547,12 +547,12 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * sitting in the folio_add_lru() caches.
  */
 static int invalidate_complete_folio2(struct address_space *mapping,
-					struct folio *folio)
+				      struct folio *folio, gfp_t gfp_mask)
 {
 	if (folio->mapping != mapping)
 		return 0;
 
-	if (!filemap_release_folio(folio, GFP_KERNEL))
+	if (!filemap_release_folio(folio, gfp_mask))
 		return 0;
 
 	spin_lock(&mapping->host->i_lock);
@@ -584,6 +584,23 @@ static int folio_launder(struct address_space *mapping, struct folio *folio)
 	return mapping->a_ops->launder_folio(folio);
 }
 
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp)
+{
+	int ret;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (folio_mapped(folio))
+		unmap_mapping_folio(folio);
+	BUG_ON(folio_mapped(folio));
+
+	ret = folio_launder(mapping, folio);
+	if (!ret && !invalidate_complete_folio2(mapping, folio, gfp))
+		return -EBUSY;
+	return ret;
+}
+
 /**
  * invalidate_inode_pages2_range - remove range of pages from an address_space
  * @mapping: the address_space
@@ -641,18 +658,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				folio_unlock(folio);
 				continue;
 			}
-			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);
-
-			if (folio_mapped(folio))
-				unmap_mapping_folio(folio);
-			BUG_ON(folio_mapped(folio));
-
-			ret2 = folio_launder(mapping, folio);
-			if (ret2 == 0) {
-				if (!invalidate_complete_folio2(mapping, folio))
-					ret2 = -EBUSY;
-			}
+			ret2 = folio_unmap_invalidate(mapping, folio, GFP_KERNEL);
 			if (ret2 < 0)
 				ret = ret2;
 			folio_unlock(folio);
-- 
2.45.2


