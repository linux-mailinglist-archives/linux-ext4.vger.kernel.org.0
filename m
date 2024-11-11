Return-Path: <linux-ext4+bounces-5031-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF9F9C46A0
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 21:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A161F25D67
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 20:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD4F1C7603;
	Mon, 11 Nov 2024 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gFeTXSrI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513A1C460B
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356371; cv=none; b=DVOuWSuyN84NZP4n1T/qg0dlCCWtSN6JxXpxP5o8A3N8tiMh7MwlWJ5aXHK0f6nt8hJaEpW8jH8gQLAe530iI8LoMlSoHv+uJ1hO06wlYhcHzQLDQ724F5r5nsv1OkGuUXBWhYrmzQEzWQcOj8mnJKYjL7YKvAO/qQ7Fi19mbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356371; c=relaxed/simple;
	bh=ERxzpPq6+BTFpJlaeLsF9b18iaASUw1kO5vY91SqSo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScGxXrsd/eWxayUy9cpEV3Ta29IT6eGMHhcM6iYt4VxOSkyeLGsG9h3Mej1cNYVGHXiuFI32Niu3RneVyZNBAmrdNh0ZxmQuJTcjMrnVv1vVq2pxSLCUfyFrI3niZm9JmEBenjZiME6380Gnf4eyOJT9i0lsvB/8FRXX+SFVxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gFeTXSrI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b14554468fso344841185a.1
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 12:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356369; x=1731961169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+z+eQ7oJzdE2umju6Fr1kTV7qg6yn6q+3nb8dNkk/ko=;
        b=gFeTXSrIycX/TFRcG9ot3CIMqEwBusTzJfJ5IlbIaBWNxo73ZSRDM6BY9CvvyPoZyM
         eLAFXVyKBRD3b0+qOVtLI13a8dkOqfedmLl3sAiOdQsEZwGWQJSETT39rFNTeSbzHpqp
         0N2Gt3eQVJg5Br68idRqR7xojEwpK3qSyCdlI3TeoybosHon6M4V3iPCjf+UJ/VU79L2
         OWXdRJ+iEsU+YMGxmjjOFG/vyOV/soHJ9lxJK11qd1EpI50x8fHAmQ+QE06XBLbKy0Bz
         hhrlKYdYhuQrrIqxFWhhQ6u2LSjHkrsrkvKnVCwdj8lkl+W83wJIlghgvPcSdelSDHVI
         MCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356369; x=1731961169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+z+eQ7oJzdE2umju6Fr1kTV7qg6yn6q+3nb8dNkk/ko=;
        b=J0z/9Kzrm3ECpNUkZ8OXUe9O6GViDsUeHaF+1bhBXw984nKCW6+ghOrTx4BNgVCkR+
         G8LzeuXPbW+OA8upc2RKK4FN5qlLtUmsTPpjvfutdd3KNeQ6e2tYEQrt3uw1EDhl474J
         Lxm9yxCOUMqYFLkrMW4gPaxblg1Z5FxJhqtI+WaV6cnwtrOhZMfK8oQn2B2faFNqYJea
         1/9U/6etgw3ZvZI7DLko6b1LQ5K+fKOo97WidLJscUhKLK0nIAsuNk+ameoXpzi7xbVe
         YCqqh5MjkKXrhSUgh5B4ePd+YdDcuud8BQQwvF1dFeF0G3saK4hIsMLnhWLN3tDwb9On
         0szw==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZsmxLOqeX0wprqlYDpOOkgsazf90OSjkEuLp7FMTXTQIW33Pot2v/efH9DR12MkmJ8w63s/kQs2y@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWoP3swaEvLIhJ1HGDKT3mSeGluwY4n/7XbEHYZiujsSNTwmf
	jN1z+nlp2CXIGU1XCNizfN50e88Ql5L/L62dltbzXbC6CbBawWSe+MQQq7V7HmM=
X-Google-Smtp-Source: AGHT+IGms12DOLEJdB5bkW0IvqVA392HkoYhkn4Pg1bvSAHP7u5Zdmd/IqhCvTQbHrBd1gwbJKpdcw==
X-Received: by 2002:a05:620a:179e:b0:7ac:9b5e:baf3 with SMTP id af79cd13be357-7b331eb4c7cmr2112662485a.26.1731356369095;
        Mon, 11 Nov 2024 12:19:29 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf7f31sm524104585a.129.2024.11.11.12.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:28 -0800 (PST)
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
Subject: [PATCH v6 12/17] fanotify: disable readahead if we have pre-content watches
Date: Mon, 11 Nov 2024 15:18:01 -0500
Message-ID: <983e7415c8d083c7bee0d77e81c87b630f093170.1731355931.git.josef@toxicpanda.com>
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

With page faults we can trigger readahead on the file, and then
subsequent faults can find these pages and insert them into the file
without emitting an fanotify event.  To avoid this case, disable
readahead if we have pre-content watches on the file.  This way we are
guaranteed to get an event for every range we attempt to access on a
pre-content watched file.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/filemap.c   | 12 ++++++++++++
 mm/readahead.c | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 56fa431c52af..fc36a00fa014 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3149,6 +3149,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
 
+	/*
+	 * If we have pre-content watches we need to disable readahead to make
+	 * sure that we don't populate our mapping with 0 filled pages that we
+	 * never emitted an event for.
+	 */
+	if (fsnotify_file_has_pre_content_watches(file))
+		return fpin;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
 	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
@@ -3217,6 +3225,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
+	/* See comment in do_sync_mmap_readahead. */
+	if (fsnotify_file_has_pre_content_watches(file))
+		return fpin;
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..9fe678cceba8 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,6 +128,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
+#include <linux/fsnotify.h>
 
 #include "internal.h"
 
@@ -544,6 +545,14 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	unsigned long max_pages, contig_count;
 	pgoff_t prev_index, miss;
 
+	/*
+	 * If we have pre-content watches we need to disable readahead to make
+	 * sure that we don't find 0 filled pages in cache that we never emitted
+	 * events for.
+	 */
+	if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->file))
+		return;
+
 	/*
 	 * Even if readahead is disabled, issue this request as readahead
 	 * as we'll need it to satisfy the requested range. The forced
@@ -622,6 +631,10 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (!ra->ra_pages)
 		return;
 
+	/* See the comment in page_cache_sync_ra. */
+	if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->file))
+		return;
+
 	/*
 	 * Same bit is used for PG_readahead and PG_reclaim.
 	 */
-- 
2.43.0


