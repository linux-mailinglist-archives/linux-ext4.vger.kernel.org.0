Return-Path: <linux-ext4+bounces-3978-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECA5965701
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 07:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D955280CAB
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 05:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF091547C1;
	Fri, 30 Aug 2024 05:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE4f94JZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58131531FA;
	Fri, 30 Aug 2024 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996278; cv=none; b=L9IeuXd0D3Fp7+L7yWJi3g6B1h1eEFUphuwofRm38x21jbqu7ZeRffRvze/s65zcAY5S0JOPmq6w1mtXuyuVtgOcaAhILBRM1qUq3ul3Hw2ml+zUmUJzV/jzYO+R5E1Jzv9gFU43CiqDn4ucMMZGJXtKoXSQjz3fgOy8eu4xHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996278; c=relaxed/simple;
	bh=jacIqIDAkBs2UQ8mkVzFuVyqYc1Wu3C41rsKkRp86oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ElzwpHMQONdT7RNsqCh4vGDvW75cq/6xGovxVZxVEXfhAeUAKaWh0Bk4QhD0cYuIz4bkkZ9DzsLmOl1MwrdaBL1ZODVem2h0D1Z4biohXEPI2G8Y2GvQp9AzAXKtfZT173vII5cY13DUR14bJNZiwoUk+X6CB3UksglXxSkepq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE4f94JZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so1223459b3a.3;
        Thu, 29 Aug 2024 22:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724996276; x=1725601076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbWYJDjhX3IfCHXHqjD1zEsVDG4teXMTYrTd6zW/Kz8=;
        b=UE4f94JZg+qJN5sved0TGDHlb3iVHZwfqZGXHFkOJ6Fm/QcPTPKya1od4aB+/FernZ
         kSfvoKFvZ1Be5SgCY4fMeXW6JYcsiKyF4awY8SwCXCHyBBk9urkKo3+nU/Y4OEN5MpAy
         3ZgVrsww3cFOZqayDtU+vL7EZz/bp+YgGC8wKrpFBaDj+GrrEgQCmeYYm0sd6RRW5tC8
         i/WOH2CJxThjHGAfCHveH31I855PtNbHJDvbqdIWpMoVa8kiDE+96ln+qFkSTHgKt1Mt
         6zbnZQWf775+8hkX3El0Y8zwWuR/lzaHUtgCaaDbj2yXx13G1g/wpG1rpskReiQgCOBT
         7BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724996276; x=1725601076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbWYJDjhX3IfCHXHqjD1zEsVDG4teXMTYrTd6zW/Kz8=;
        b=vEoBtiLl6r9Yas7Z7rodQaoadZXeLPWbnVd38ShhHN+Jc1Rjf8eGgITOedfE+7qkXh
         CrQOaTvSFUapY1lYQiPmdpVj3hcUuZdZiG0jly3jk3IfiQzDYWm7nW41M6bpKvO6V84Y
         Ti7gNYlZ+qNQ91T9cTtOgBsdu4zV9idAjpjQ628ypb/3F/ej+BZMI3NOrjnPDx1mQ4Vo
         5cilnLCCKyS5LbziiWttg56GAk+Fc2sV4/F/Em0CWpfuX4qRA6CpttPSLB4FAq/4gXjE
         owK36413bH3cNM4K3l2SyCFenIbrxANHXk25brhIEuZNxSlUmXkzTKC40SBQBKYLf1ud
         L5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXuS1TCgCGcqwqwj0L9RFPYbxCq//S5FS5tHixqvFHJZ5yI5UQLY0IZ9wrkYrpOLQoYHojvqWMyQOtYP74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSKoTD2NSyJNdMKiIqIz8JOkOa0j3tw/bufHLYN0LdErrW3iWJ
	VxCGYF+Tn1sfCVpYz30cyI+A8z/4K7NHw2e5MNIf/8iFo+Sgl+kq
X-Google-Smtp-Source: AGHT+IH3OlfqR5/+QqgNBUDnmzafAo5QJb9yjWI6aNRjz+2dn4fgQProfDobalZmqy9vFvVFRP41sA==
X-Received: by 2002:a05:6a21:920a:b0:1c0:e69f:f237 with SMTP id adf61e73a8af0-1cce100ef98mr5424726637.21.1724996275818;
        Thu, 29 Aug 2024 22:37:55 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534801sm19784075ad.154.2024.08.29.22.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 22:37:55 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com,
	ebiggers@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4/4] ext4: remove the special buffer dirty handling in do_journal_get_write_access
Date: Fri, 30 Aug 2024 13:37:39 +0800
Message-Id: <20240830053739.3588573-5-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830053739.3588573-1-zhangshida@kylinos.cn>
References: <20240830053739.3588573-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

This kinda revert the commit 56d35a4cd13e("ext4: Fix dirtying of
journalled buffers in data=journal mode") made by Jan 14 years ago,
since the do_get_write_access() itself can deal with the extra
unexpected buf dirting things in a proper way now.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/inode.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a28f279fd02f..2687bf451a25 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1023,27 +1023,11 @@ static int ext4_dirty_journalled_data(handle_t *handle, struct buffer_head *bh)
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh)
 {
-	int dirty = buffer_dirty(bh);
-	int ret;
-
 	if (!buffer_mapped(bh) || buffer_freed(bh))
 		return 0;
-	/*
-	 * ext4_block_write_begin() could have dirtied some buffers. Clean
-	 * the dirty bit as jbd2_journal_get_write_access() could complain
-	 * otherwise about fs integrity issues. Setting of the dirty bit
-	 * by ext4_block_write_begin() isn't a real problem here as we clear
-	 * the bit before releasing a page lock and thus writeback cannot
-	 * ever write the buffer.
-	 */
-	if (dirty)
-		clear_buffer_dirty(bh);
 	BUFFER_TRACE(bh, "get write access");
-	ret = ext4_journal_get_write_access(handle, inode->i_sb, bh,
+	return ext4_journal_get_write_access(handle, inode->i_sb, bh,
 					    EXT4_JTR_NONE);
-	if (!ret && dirty)
-		ret = ext4_dirty_journalled_data(handle, bh);
-	return ret;
 }
 
 int ext4_block_write_begin(handle_t *handle, struct folio *folio,
-- 
2.33.0


