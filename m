Return-Path: <linux-ext4+bounces-9540-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59021B306EB
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86913628174
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CCF39193B;
	Thu, 21 Aug 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="axh3S8PB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A0F3743FD
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807677; cv=none; b=Ub8IUm6DhcHNGOkfbIyoGscBlPYQ4N41aQ+1XtCoa6K6XNiN49ehY5w8unst5UTKpDv+0hC3G0RlyXENfOkk9dqDOJMiVflEghF9yCsMPp7jeNmM8RvQujR9RCO9fj6bnMSIDJ4IzGq2wRp3QUy+xhGaBwStLLue1QV8DqWZm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807677; c=relaxed/simple;
	bh=EA31L9PrmSa4mzObQI8v1C5H7seTrIKkp2OpM8ds5og=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6RvdJeLQK6w58v0VUx/DaDp5GuIr7QZu1sC/BIM3LOdk4XMyvHrhyofvsNWxDrocEL5worTpSStzkkrSB4K+4PUqjlgzpyTD0b0mc/zMypWlYQkzDb/viLmZq6tRydZshe2BVNU+TxAnDH6AiuQnO1E1nKaRG5rqR6nAGlwMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=axh3S8PB; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71e6eb6494eso13049877b3.3
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807675; x=1756412475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fttr/Czssr2JLi9HILzKnlPA1YaQWhLNKR3od2b6IE4=;
        b=axh3S8PBmyjMa2pbeNgVzJkbFjsSqOPDKGpRbNdMxXclTkWl1pJmXC4ZIXyxfDD+sG
         Ovbgm9SD1UPt5XbKiTgPIRLUY6RHIvzyHY67/gExLrv3G93aHesRJto5m/oQ9G9sNYx4
         RoFU/eiotc25vyarCJqEm5alADklkOq6oSOfYKAiZ3HOE2ingdyBBf56aXAf9tFx3ZmD
         HFRnJwyBVjmr+g60SEeA5QilWn/5JSiiXWC9VpBQF6MNCJ/pXdHC2rESaIMQdyGTJkX2
         pwc9RHLW8N8KOrCLl9SYs8O5O4xs/H8haxUd6aMGDK/cuDTUE/Xy2Mfemw1u/KxVdGEw
         cjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807675; x=1756412475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fttr/Czssr2JLi9HILzKnlPA1YaQWhLNKR3od2b6IE4=;
        b=hKtKYtbN6TWv12qk8ePrqQ+QoMFDZiH/GJ72vWR5Q+F/UP0sUXftcqQHZt08v6u8c6
         GxCAg/2tgY2M0IfiOTphFsMliibyEhRyM+fKFrxHaW0H/gFURNhhsTrZWRezLClCNPYW
         3YxRhADibTiCkb5iKiE3Brc8rtjAlaCudz+5NIaBXZP6BiZDrCVMm65EJFQVML0jqmFN
         T5kV+5Otatw+67n2vZj+/OPkBUtQlZq0PRxQkOHVfCPoVRS5pR/Nmrq+3b5f6v1KyOUN
         u3pBP235rnCF71P7HGAiUE9q0snBIZ1nSQgTTdBZVdswCv7AjgOAkbyBTJ6FepiRQunX
         33Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUUGAu1IiFWy/QrsjX4hEaiyTiaZzVLdSR43oD6qfbRrYvaHa43ar+YRQZjNuNMxG5Gpzbo5DWodbQ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hcBR6ExXIt+TvmgUrcCA5TCO+T9bdXn+4pXQv8v4tI9AOdEN
	dxe9cqQVpPsPaDSrFRul1rlPNutl5zT5pyhmxj51TacxziN4Z3bNIUPFnefHGGb6aAefsM6OE5B
	qasq4U8vVuw==
X-Gm-Gg: ASbGncu473FYcQuV5W/UmweCwOTBOC8c/ww4IsJL2Nwl9G/lfZCaNGRZALX4BymNwMo
	hJLZvi08MmL/TfjmD9qVJjPtRyt4yp1Kvatw7xkNS98B29eOTeo5GBwJiCWl5Nfbe+KSuditwku
	5D5th3YqEb7h4s+1bNtoUHj7GabTjIVvPW5aL/D8Q8tZyvk1aFvnhc14Q1IH3BKcRWwroZbRz91
	etoa65O/c93aIKbcqw7j+T/z5zajtpnqcAxPnN3VXoiS2BcJxdLFl82aFBUGXjblhxMPgHVyaOW
	pkkqPmw/eRl5x8/nifUiJhirr/rMALIilZry0rcwR3RluguLeydjyXN1NJES15mDVpPyx1/BXoB
	4REftHQJZdME+vrsjGtR9aDKHKOr1E5rb/OI+E5wgbvzh7ys76Yfuy06Wtv0=
X-Google-Smtp-Source: AGHT+IGjxSgFZ9mWOECEHAMCC7m5i7vQzRMSl3lQEW4CVdSnSyB58BReHuV0rWkHihu4WR2jiQXucA==
X-Received: by 2002:a05:690c:968f:b0:71f:b944:1027 with SMTP id 00721157ae682-71fdc530cccmr6134537b3.48.1755807675427;
        Thu, 21 Aug 2025 13:21:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fae034dc0sm17871677b3.74.2025.08.21.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 39/50] xfs: remove I_FREEING check
Date: Thu, 21 Aug 2025 16:18:50 -0400
Message-ID: <1cc3d9429aa4aa8b5b54d5cd54f7aa27a1364b78.1755806649.git.josef@toxicpanda.com>
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

We can simply use the reference count to see if this inode is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_bmap_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..a32b5e9f0183 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -514,7 +514,7 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	if (!(VFS_I(ip)->i_state & I_FREEING))
+	if (refcount_read(&VFS_I(ip)->i_count))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
-- 
2.49.0


