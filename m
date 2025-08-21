Return-Path: <linux-ext4+bounces-9507-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BEFB3063C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC641886EF3
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26A4372172;
	Thu, 21 Aug 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QLV2iSSm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6A3705A4
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807627; cv=none; b=i7IjhN0O8ev9Tl8tpHe3RxERbrhLVmcGL/50Us/6QaK4ORPM/UYQB+PLLaVfkHJYbp++JEGgLIZegtSO23aDIbve5KuT4zR0Yw8b10oQDni+FwHeMOB9EmdlTBe8JuUhPRIwAeilUql98Fv3+YPxsGGBtWW4W1DgCe+gnUqnXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807627; c=relaxed/simple;
	bh=e38a2bYY0lM4/uSU3RFlA30kOVHJrvftHkiNhtmHm5E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ph6CQMTEwIRqVWpIqrap2kgdd1h3xgsIsuAsU9wpJ7GaccLe6pG1fpA0+jB8d3xaCiWRg2lptFZDWLVjkW2FuK83FFVMfqVOuq/a1r1QRAKeuBH6xQhokPHZttWlzuoirLGK4r7PVz/Zne/CKB2gwLA0zZu1sqwsjdchxkE5seE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QLV2iSSm; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d5fe46572so15100127b3.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807623; x=1756412423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bl7HAVQW2PqCGkoEm3mgP9Mxk0xiyNkVqbY/OCBbbh4=;
        b=QLV2iSSmzG4kIX9KzkrXSuHLU6UfXLPwgbugTnQsKA1YAcLlj8kxApKZHnCzPWND4M
         sQuApksz7rKNuvj1YGgW1XOyMISVOc/F72jgwg+SMnvDIoNtimQjpGPXSEwuoDLRCIRb
         C8tdngzHoOpH7ZSJT2s4P2DfEl5yxo2AnSRzcHEnsZWzK8Lrkd180irNVmjCc2L1dUcp
         vuxWTh40zY9D9DmWM+9ag7xGpKRHdJZkqzUVZxQ8mBORj/PE8nJd2v7rcClqS391dPd9
         UlVsaEyE2BOqGnCF4QHA1o9Fmqwy0O2Kdpk501qP/ddVJ1sHQu5PG/qOCq52SODHpjY/
         68IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807623; x=1756412423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl7HAVQW2PqCGkoEm3mgP9Mxk0xiyNkVqbY/OCBbbh4=;
        b=r7FfhyfzTSPWBMdG0FFT3G20iI9M404TH1pVGFyTUiMrzPkDTFIIO3ln4x9LGE8xiN
         w7dIT0O6mCC+ZyLQeFe99NyUHKa1H65V6VIYoNTsnnQD4z3/BhipdIHVuQGkX5caTcpr
         n+Ajp7PisGLBOr6FeI+kAkrQgNBi+0YH162MLr/RmYSzf7An+u0pg+IwOlXgyIRkRDRM
         2sHMKdTuM5E25nD4Gig1HU1hyfmqVaw8KmyaM+Z3cW0CqdMwNr4iDROQTJF4iABmoPff
         fsgX/usonBLYl7ldYr2rxrVPQOvwJL6uXN9Apbm/bJUS5IZeFssMnUTq56+b0Jfuw/W9
         m4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpyuAGhCcJ74IGpcDfvsJoU4SDmMLQZRNzPF1VK0ph0g7piHACJEZQoXQYJxQOybkRKSWYRLAEmyz9@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvcRcIlgFAo96GPaMpV3EZT2Ma14QHbiJ+fqYGyQ22INgdJsw
	5xUPzzCbSWnSmOH9nwl3s/pGW2t1u89YLEWEz+eWDX2SRyIku5CeFllkqc1qygI06om4ICrnHzG
	B32AEJN7qdA==
X-Gm-Gg: ASbGncvQ0BXrUGL2uRn3zVqZ3/TfF+6HDaM9VTCjDKWXmS0rwsc52bPS85WXIxHk4Ce
	ZNDRssPJG/m+TAu8TrRYuW6tJqTpVUu0x32wvVJC93Prnh5YuQXPRvF5hOR/WgrOVvXEJXloNaD
	KpNCOThK19+Xa08JVZTsK8vGoR2VDmmbIXAfDtPm9vNBIwnf8roAr8xc3/5ps6vnB2pypRJD+dL
	KGz0k7ph8KGNEvZ7goIr5m4/J2j961jUUBH9ofbQajBqgfCNH2rwo9VNxJsw8JDkuDUglD9Mr2t
	r2tXZS329S0duPVWDGVtXVvkEdRFdTU14UFsJjY9hGeYp/W0t9fFEtKmsSq/hxzPcjQ2Udz6XD3
	kLwlV/azgtNx7jWeAXfQMCpB28wW8a6yHdiCpTE7UGzo931kJUB+aOevmMB7sy13ZwvwkXg==
X-Google-Smtp-Source: AGHT+IFeKizBXDJc5pIG9FJnnkzcDqSnRQGSN5j9TvFFLqP7JmojNQv4eCzXdTFdSpkonYNXzZ8ybg==
X-Received: by 2002:a05:690c:3606:b0:71e:7a40:7efb with SMTP id 00721157ae682-71fc9ddcc47mr44340717b3.11.1755807623198;
        Thu, 21 Aug 2025 13:20:23 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fd7432ffdsm2981327b3.21.2025.08.21.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 05/50] fs: hold an i_obj_count reference for the i_io_list
Date: Thu, 21 Aug 2025 16:18:16 -0400
Message-ID: <50a0e1a914673759079507c22fed039def0c4bfd.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the inode is attached to a list with its i_io_list member we need
to hold a reference on the object.

The put is under the i_lock in some cases which could potentially be
unsafe. It isn't currently because we're holding the i_obj_count
throughout the entire lifetime of the inode, so it won't be the last
currently. Subsequent patches will make sure we're holding an
i_obj_count reference while we're manipulating this list to ensure this
continues to be safe.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index c2437e3d320a..24fccb299de4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -72,6 +72,14 @@ static inline struct inode *wb_inode(struct list_head *head)
 	return list_entry(head, struct inode, i_io_list);
 }
 
+static inline void inode_delete_from_io_list(struct inode *inode)
+{
+	if (!list_empty(&inode->i_io_list)) {
+		list_del_init(&inode->i_io_list);
+		iobj_put(inode);
+	}
+}
+
 /*
  * Include the creation of the trace points after defining the
  * wb_writeback_work structure and inline functions so that the definition
@@ -123,6 +131,8 @@ static bool inode_io_list_move_locked(struct inode *inode,
 	assert_spin_locked(&inode->i_lock);
 	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
+	if (list_empty(&inode->i_io_list))
+		iobj_get(inode);
 	list_move(&inode->i_io_list, head);
 
 	/* dirty_time doesn't count as dirty_io until expiration */
@@ -310,7 +320,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 	if (wb != &wb->bdi->wb)
 		list_move(&inode->i_io_list, &wb->b_attached);
 	else
-		list_del_init(&inode->i_io_list);
+		inode_delete_from_io_list(inode);
 	wb_io_lists_depopulated(wb);
 }
 
@@ -1200,7 +1210,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
-	list_del_init(&inode->i_io_list);
+	inode_delete_from_io_list(inode);
 	wb_io_lists_depopulated(wb);
 }
 
@@ -1308,16 +1318,23 @@ void wb_start_background_writeback(struct bdi_writeback *wb)
 void inode_io_list_del(struct inode *inode)
 {
 	struct bdi_writeback *wb;
+	bool drop = false;
 
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
-	list_del_init(&inode->i_io_list);
+	if (!list_empty(&inode->i_io_list)) {
+		drop = true;
+		list_del_init(&inode->i_io_list);
+	}
 	wb_io_lists_depopulated(wb);
 
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&wb->list_lock);
+
+	if (drop)
+		iobj_put(inode);
 }
 EXPORT_SYMBOL(inode_io_list_del);
 
@@ -1389,7 +1406,7 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 	 * trigger assertions in inode_io_list_move_locked().
 	 */
 	if (inode->i_state & I_FREEING) {
-		list_del_init(&inode->i_io_list);
+		inode_delete_from_io_list(inode);
 		wb_io_lists_depopulated(wb);
 		return;
 	}
-- 
2.49.0


