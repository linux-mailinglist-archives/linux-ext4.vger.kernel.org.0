Return-Path: <linux-ext4+bounces-5032-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E89C46A6
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 21:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C571F261C5
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5AB1C9B6D;
	Mon, 11 Nov 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XJchjYSf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCE1BBBC1
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356377; cv=none; b=rFmZfNzK6++gxkpWshho3lXKbPVh+f99BAF4A4FKZlowX+uumV2NATEMvD9PkoVWYO2DNUZVcyBQX4imLMeNqAVnldtpV1KpHac3xJ5jr5YV//W5RihVeVVyzWSEnoy/SdgK+XY182tlifBCGO3U6ENWTEOFAa71jOXrsYXt3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356377; c=relaxed/simple;
	bh=rBlo9msfCryQ8ECMKKeQafDSRsCFz5AQABc5DmNyuNU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McT51sJRSpGdSvdjpc7vTRu4Xuj5Y7bryeRDUpbObJzLjHlxB83E9aDsNQqSjSAPKKiS40Lccu5jGw6a9LwUMB0MCER+kEi/gZZgr7V6IF8PzKcqQD2xPlhIjXcP0IvV/JSK07NGJY0U90g83t1iwjD2g2ChFqtFkYuqJco1AP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XJchjYSf; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5fbc40239so2509346b6e.3
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 12:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356374; x=1731961174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nXKwcxfUzOePvYnZ4Bb/p4hYsf8sSP8uIyFDoaTPjc=;
        b=XJchjYSfa/9PowqW3RlMTawvBnROQlaDWJU20vVRgXq2beysOhaYvcdTzqpbi14eFA
         z0d0OV/DKoXz3LVc2CljEqrsiBB5ycM7QYq63lvQKXdofacLIBXBA51hZfGXCB7Y0t6Q
         P3M+sie4FfoH0wMzYdLrk+MR1Q8+EvAXMCOQ470XfkRAr1lbcT83QU2wtyrfD6vBCHJb
         t2/weZJ8rlVEi2KdP9mwM3foad0rMfQp+bx8TXI6vxDRRSgVp0EvD6Ek7LKdwUYjiDC1
         1xSZtZzN4hbJhPoHCR6Iiig6YdIsw7VhjXkzypHMwlrCCc02b6kjvaURppQY9LBa4wdw
         G0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356374; x=1731961174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nXKwcxfUzOePvYnZ4Bb/p4hYsf8sSP8uIyFDoaTPjc=;
        b=qgtbVEr/e+ZOcHnOuCETPdjKBbxhDukGBMpx5VH/NjSOx4L7eJVmuRmfnbZdhwIlfM
         75tD1adgFfhAozNzn8heOxSTlfqyZ5KSIPadn7lc7AjBTiFUxK9IHqcjYZKw4GRe/ccS
         z5qR7OROEXxbRjLcm8g5KWhiMeo1cDmcMi0znclFjl24nzMRtYESlshlaVnFiQhTbFHZ
         7E9SqqsNqssTr75d+0Q0O7PNSS6rTBufCObUpnuAxgqYeFhZ1a1QlI29GG29faVmKsCB
         8d40E8bv7RrSKTjG4BL/AwwQuQigzD59ty+nswA19/X/8cRBb4uI2GiT3+bFiJZtKzda
         S6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXacenMveAIkHD9shha5AX8WYjs1owHqlrlehaPYeBJWzGByz4EdRbjRDwe+zTh4RKfLJW/JkpjFUKt@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIPj5W8Zcfxbwu7rXHaKru3I11tt/ohh3aFT4GERzuJ5Wi4rS
	R0fWLUf2uZH4qMOguzexFShjM0qVpjQ4YuxUKzL5vk064nrXw9fOMIau+cYKk9E=
X-Google-Smtp-Source: AGHT+IHAntmNSKHnJiD7mii22aSouugOuv2LnJCY83E+/C/49mfb6yy9irDZkbJmhglaB0kAus4AaA==
X-Received: by 2002:a05:6808:3a15:b0:3e6:943:63c9 with SMTP id 5614622812f47-3e79470a33cmr12285250b6e.33.1731356373743;
        Mon, 11 Nov 2024 12:19:33 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3962089fesm63519156d6.61.2024.11.11.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v6 14/17] fsnotify: generate pre-content permission event on page fault
Date: Mon, 11 Nov 2024 15:18:03 -0500
Message-ID: <4046b63f054f5896c9c4c715180664eca1366ac1.1731355931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
References: <cover.1731355931.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
on the faulting method.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill in the file content on first read access.

Export a simple helper that file systems that have their own ->fault()
will use, and have a more complicated helper to be do fancy things with
in filemap_fault.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/mm.h |  1 +
 mm/filemap.c       | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 61fff5d34ed5..bce9e2f5dfa4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3405,6 +3405,7 @@ extern vm_fault_t filemap_fault(struct vm_fault *vmf);
 extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff);
 extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
+extern vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf);
 
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
diff --git a/mm/filemap.c b/mm/filemap.c
index fc36a00fa014..aa3c92d605b4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -47,6 +47,7 @@
 #include <linux/splice.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/mm.h>
+#include <linux/fsnotify.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -3287,6 +3288,52 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	return ret;
 }
 
+/**
+ * filemap_fsnotify_fault - maybe emit a pre-content event.
+ * @vmf:	struct vm_fault containing details of the fault.
+ * @folio:	the folio we're faulting in.
+ *
+ * If we have a pre-content watch on this file we will emit an event for this
+ * range.  If we return anything the fault caller should return immediately, we
+ * will return VM_FAULT_RETRY if we had to emit an event, which will trigger the
+ * fault again and then the fault handler will run the second time through.
+ *
+ * This is meant to be called with the folio that we will be filling in to make
+ * sure the event is emitted for the correct range.
+ *
+ * Return: a bitwise-OR of %VM_FAULT_ codes, 0 if nothing happened.
+ */
+vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
+{
+	struct file *fpin = NULL;
+	int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_ACCESS;
+	loff_t pos = vmf->pgoff >> PAGE_SHIFT;
+	size_t count = PAGE_SIZE;
+	vm_fault_t ret;
+
+	/*
+	 * We already did this and now we're retrying with everything locked,
+	 * don't emit the event and continue.
+	 */
+	if (vmf->flags & FAULT_FLAG_TRIED)
+		return 0;
+
+	/* No watches, we're done. */
+	if (!fsnotify_file_has_pre_content_watches(vmf->vma->vm_file))
+		return 0;
+
+	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+	if (!fpin)
+		return VM_FAULT_SIGBUS;
+
+	ret = fsnotify_file_area_perm(fpin, mask, &pos, count);
+	fput(fpin);
+	if (ret)
+		return VM_FAULT_SIGBUS;
+	return VM_FAULT_RETRY;
+}
+EXPORT_SYMBOL_GPL(filemap_fsnotify_fault);
+
 /**
  * filemap_fault - read in file data for page fault handling
  * @vmf:	struct vm_fault containing details of the fault
@@ -3390,6 +3437,37 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * or because readahead was otherwise unable to retrieve it.
 	 */
 	if (unlikely(!folio_test_uptodate(folio))) {
+		/*
+		 * If this is a precontent file we have can now emit an event to
+		 * try and populate the folio.
+		 */
+		if (!(vmf->flags & FAULT_FLAG_TRIED) &&
+		    fsnotify_file_has_pre_content_watches(file)) {
+			loff_t pos = folio_pos(folio);
+			size_t count = folio_size(folio);
+
+			/* We're NOWAIT, we have to retry. */
+			if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
+				folio_unlock(folio);
+				goto out_retry;
+			}
+
+			if (mapping_locked)
+				filemap_invalidate_unlock_shared(mapping);
+			mapping_locked = false;
+
+			folio_unlock(folio);
+			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+			if (!fpin)
+				goto out_retry;
+
+			error = fsnotify_file_area_perm(fpin, MAY_ACCESS, &pos,
+							count);
+			if (error)
+				ret = VM_FAULT_SIGBUS;
+			goto out_retry;
+		}
+
 		/*
 		 * If the invalidate lock is not held, the folio was in cache
 		 * and uptodate and now it is not. Strange but possible since we
-- 
2.43.0


