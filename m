Return-Path: <linux-ext4+bounces-5033-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C379C46A7
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 21:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66061F261F5
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838901C8306;
	Mon, 11 Nov 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SRh+pPmm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFE1C460B
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356377; cv=none; b=nuVfj/m+UO+GrqlFCh66ZvdbnugheiWAOYipJGlGKTC/MiGfikYnWBUDrPr2r2I7ZNTReW2Agclr1WG7pI1+iMPPAR9j79anaLfqUdXyOxifFKnUEZalCi+QuYPSZDt174L/sFf+vszVonByeos308I1Ogsve7EHuigwbwXADaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356377; c=relaxed/simple;
	bh=t7nvLm79BnbL0G55pVnNTkmA0duqgzyrwuSpS5La8ko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfbSseiBPNG2IBJBVMaChFtjMkd/q4O/3qolA7fmcaKcidrPK126mu56B20KtU1iqhcY4IoIsvbSi4/ZNnNo1eh8EetgBeCZu0ZnZsYuJbKLCVdFWXZFymtYxzoYxreYvZdEkh377UjjGDKjkLMN8j+9AtF8nltAwsMNfePfsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=SRh+pPmm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1601e853eso325312385a.2
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356373; x=1731961173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtBO4W7ojcvMiQeJDBijogkryb22CThmLCgaVfO4L7E=;
        b=SRh+pPmm8ixAsMoQrAPKciMNt87tnAODzM/E8MMC7uO8gmdqjFrKORPIeSF9D9T5dv
         d0XghpJQz/zSJki0hO4V+jpEmTp7VbU4a1MWuVVMn6FaqomXXAzHNDLGxCFVzT8dlqh2
         5yNau6tdDFGasfo16eMpgLL0MtymMfGjYZeClrZ1iHcEoD1Eb2J5EGeuwYDfBgTFIsGc
         C6nx4gj3d6LHiYQPQxEJ2EGsCQGrb/dwd/tYH0Ox7Leatukwrbgw70zoxmtI8rY8Lf9+
         vfko1iNdDGHfoxphYbjFiQ5Yx+xkE/HuCnaCfD6Yewlfa6i/tY4jqE8X9jdb0CwE9MxS
         LNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356373; x=1731961173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtBO4W7ojcvMiQeJDBijogkryb22CThmLCgaVfO4L7E=;
        b=ulkklzRui2CQEI2dVumTwhBh2lGcjU2my2wl/YcXjap24PbNBjoOTrGMKIncgD+TsU
         cAOyOCzxKRzci607XHK7cY/HdjqlYRNdJnJTGrsBKSuiji2qLn3Z04ZL83WII37RrZc8
         kliBNAxJBSApN0wIDNPqf7wR1X4zbVtssXN7f5HGoo+iUEZk1tOxYNqwpARFFMb95t0c
         1ojiJPW5IRiGut6y62XAu2Rzp1gyWqcHHU57VBNWAPztnzjHHwTeCquNCWzrK4HC8o1/
         ZkDEoGypVwOHpVevopbffWf9Wq59tCReu44opXK1hwrKRUPFmeV1BcqH6CSbhQOpKVuI
         vqaw==
X-Forwarded-Encrypted: i=1; AJvYcCXKENaz+xIC1XBGJNTYK1cPDi+ZMV+9zM1pGWfm/YXyDLdoQfZJU8w5HNFQmJYtrULmxHMi7uIyVyF4@vger.kernel.org
X-Gm-Message-State: AOJu0YwM4pm5JFdO2GIv5zI2Pf7+xKyV8rBwwhbHhKl8Bcp+pcevEVs5
	aI4VDMlK7B/HFs3VMKjI+Dx/8/KHDU4k0hsOZ3iN9/2u4EnRuzZFnIszSCajF+w=
X-Google-Smtp-Source: AGHT+IEVZ5vmyN/LZmrG/1kTbJ7T1FWoFz0xAw/6r2wr8/vwFJmdfm3sS2snhEtpIWxC1ONY/ffBRQ==
X-Received: by 2002:a05:620a:178b:b0:7b1:447f:d6f0 with SMTP id af79cd13be357-7b331eb87dbmr1968482385a.23.1731356371650;
        Mon, 11 Nov 2024 12:19:31 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acea072sm526763585a.114.2024.11.11.12.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:30 -0800 (PST)
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
Subject: [PATCH v6 13/17] mm: don't allow huge faults for files with pre content watches
Date: Mon, 11 Nov 2024 15:18:02 -0500
Message-ID: <5c64164cd1f16431edd1d468cb3204d29d86bbf4.1731355931.git.josef@toxicpanda.com>
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

There's nothing stopping us from supporting this, we could simply pass
the order into the helper and emit the proper length.  However currently
there's no tests to validate this works properly, so disable it until
there's a desire to support this along with the appropriate tests.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/memory.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index bdf77a3ec47b..dc16a0b171e3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -78,6 +78,7 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
+#include <linux/fsnotify.h>
 
 #include <trace/events/kmem.h>
 
@@ -5637,8 +5638,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	if (vma_is_anonymous(vma))
 		return do_huge_pmd_anonymous_page(vmf);
+	/*
+	 * Currently we just emit PAGE_SIZE for our fault events, so don't allow
+	 * a huge fault if we have a pre content watch on this file.  This would
+	 * be trivial to support, but there would need to be tests to ensure
+	 * this works properly and those don't exist currently.
+	 */
+	if (file && fsnotify_file_has_pre_content_watches(file))
+		return VM_FAULT_FALLBACK;
 	if (vma->vm_ops->huge_fault)
 		return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 	return VM_FAULT_FALLBACK;
@@ -5648,6 +5658,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	vm_fault_t ret;
 
@@ -5662,6 +5673,9 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 	}
 
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		/* See comment in create_huge_pmd. */
+		if (file && fsnotify_file_has_pre_content_watches(file))
+			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
@@ -5681,9 +5695,13 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		return VM_FAULT_FALLBACK;
+	/* See comment in create_huge_pmd. */
+	if (file && fsnotify_file_has_pre_content_watches(file))
+		return VM_FAULT_FALLBACK;
 	if (vma->vm_ops->huge_fault)
 		return vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -5695,12 +5713,16 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	vm_fault_t ret;
 
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		goto split;
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		/* See comment in create_huge_pmd. */
+		if (file && fsnotify_file_has_pre_content_watches(file))
+			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
-- 
2.43.0


