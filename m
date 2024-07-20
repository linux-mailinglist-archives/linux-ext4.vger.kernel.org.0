Return-Path: <linux-ext4+bounces-3332-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD9A937F2D
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 08:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D672820E4
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2AD16419;
	Sat, 20 Jul 2024 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqKxPUIf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42094101E4;
	Sat, 20 Jul 2024 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721456645; cv=none; b=Sss7Ibwme6ZwX+Vq0M3kTett3/sXtwH739z064tPcx9COadKuO0q0CjkZs/jv0zQ2jtlHELCoxvFVb2pf7BvCLq56VfkQdcKKgwCVGUc3B/3wIZlxD8Pb89zPsd0Uf32yue2A0qSGEDqcAoMSkZTSKXG0dW2nQWu9xnjQgy3NCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721456645; c=relaxed/simple;
	bh=ABFFQyOvcAbcL/9vHAth0uUvpw04dcoWOHmYRhVX414=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mM7uvyib9zPNjsYTsiRk0+/TWJunvT5bRXtIhAMZ10rpxt07VNDznagnAT+pkgX+HhcyeG3nJcr+yGli5s/yGfZLVX1F4sCJEEiUagGn4jC4gEOhVvkUNck9wVY6Vygh4me+plTX0pmZDtuVX5uPbjcDyTMdUhissXacZicZm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqKxPUIf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-793a3a79a83so1852166a12.3;
        Fri, 19 Jul 2024 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721456643; x=1722061443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VpCn/mWH5TzSp63PGOtUfTbjWm1JkGA80503IC3g9Zg=;
        b=KqKxPUIfHhTxyUpZJzzRavyICyyfGefcxlIaxLHGDx645zicYwlhN+GMI+7zTxYMSv
         6CHSFEEaluAqEhZkTGiDK9TNgpQ++a9XzXetKs0KN46GbA7MGXwb68Z3LmaPFaXZwtSb
         GebvfMS40vRzizGNSQOXH/T8ISFOKZxnCXSdB+xFSiqV6TAMTlixgSBC/FEBDF2PWkoE
         o46GsdigHrhBqyqdDe4bjnhe7j5x9Ml8nh3AxkLoiu9riQlHmFig1U0T1HyxS75aU5fp
         09CKRd+yeQFVSFEnMKFvuLm5eujgrukq6Cfwl6FtZmEcA2ggysifVY7gr/dkzyi9fzSc
         rIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721456643; x=1722061443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpCn/mWH5TzSp63PGOtUfTbjWm1JkGA80503IC3g9Zg=;
        b=kaRM4SCvlmAVuVqIWWLkV08kxRLeHE4CKQf4JB/ThobJRi86dPsqe8vRseN56NveST
         SQROxodyo9FfdlTX/0AwxYkPzwNLevRrak3FE9VpEahnVNctUiiGLq2v7yVFFXSVGJwv
         /mUtjd4m8LCOxSKGLF2o9jDQtqiUF0d1PyjsI5Li3ZRTtvvdbCxCuGL/jUCNHuoD0wcK
         EId24tTCKUYrSLxBn283VeCKPKzTbyu9ngZv3AAzIAoy6MNgU7LnP/vftIOAbfJFHuhD
         8ElBX+E20OF9LadyWGamhjTQH9KpOQPUVJWqyGcehfPJXzVMEoY/02ijs6x07+vvfPIk
         Y3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGBYT+UIcIXstlHK4kuEvXkD1gOKNi12sDFcY4ZTkTuxHnLiH2qPKO9aZigkRctteQlYt8WUwQ/cGHt9NfhkONJanNnNi1f57gSmmJ
X-Gm-Message-State: AOJu0YyJ7aJm0W5LZNbDxjpdoN2yvCjyUweHW2Re23JT9EW+lvHo/hpY
	WfLTMtEziNLX8NGpGstQSGACORDJlJF09xLfNJBXHLMRs5D3slHosAfbD8fE
X-Google-Smtp-Source: AGHT+IH0OOURIiJkFea9+K5qVD9E5ZNSiXSN0Ez46BlB47ILGI5gGSeRROi6DL8ysbNUPqNwRi3qcA==
X-Received: by 2002:a05:6a21:3102:b0:1c0:f1cb:c4ad with SMTP id adf61e73a8af0-1c422857757mr2078581637.2.1721456643421;
        Fri, 19 Jul 2024 23:24:03 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c76fe7sm2755125a91.33.2024.07.19.23.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 23:24:03 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [RFC PATCH] jbd2: fix a potential assertion failure due to improperly dirtied buffer
Date: Sat, 20 Jul 2024 14:23:56 +0800
Message-Id: <20240720062356.2522658-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

On an old kernel version(4.19, ext3, journal=data, pagesize=64k),
an assertion failure will occasionally be triggered by the line below:

jbd2_journal_commit_transaction
{
...
J_ASSERT_BH(bh, !buffer_dirty(bh));
/*
* The buffer on BJ_Forget list and not jbddirty means
...
}

AFAIC, that's how the problem works:
--------
journal_unmap_buffer
jbd2_journal_invalidatepage
__ext4_journalled_invalidatepage
ext4_journalled_invalidatepage
do_invalidatepage
truncate_inode_pages_range
truncate_inode_pages
truncate_pagecache
ext4_setattr
--------
First try to truncate and invalidate the page.
Sometimes the buffer and the page won't be freed immediately.
the buffer will be sent to the BJ_Forget list of the currently
committing transaction. Maybe the transaction knows when and how
to free the buffer better.
The buffer's states now: !jbd_dirty !mapped !dirty

Then jbd2_journal_commit_transaction(）will try to iterate over the
BJ_Forget list:
--------
jbd2_journal_commit_transaction()
	while (commit_transaction->t_forget) {
	...
	}
--------

At this exact moment, another write comes:
--------
mark_buffer_dirty
__block_write_begin_int
__block_write_begin
ext4_write_begin
--------
it sees a unmapped new buffer, and marks it as dirty.

Finally, jbd2_journal_commit_transaction(）will trip over the assertion
during the BJ_Forget list iteration.

After an code analysis, it seems that nothing can prevent the
__block_write_begin() from dirtying the buffer at this very moment.

The same condition may also be applied to the lattest kernel version.

To fix it:
Add some checks to see if it is the case dirtied by __block_write_begin().
if yes, it's okay and just let it go. The one who dirtied it and the
jbd2_journal_commit_transaction() will know how to cooperate together and
deal with it in a proper manner.
if no, try to complain as we normally will do.

Reported-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/jbd2/commit.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 75ea4e9a5cab..2c13d0af92d8 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -1023,7 +1023,20 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 			if (is_journal_aborted(journal))
 				clear_buffer_jbddirty(bh);
 		} else {
-			J_ASSERT_BH(bh, !buffer_dirty(bh));
+			bool try_to_complain = 1;
+			struct folio *folio = NULL;
+
+			folio = bh->b_folio;
+			/*
+			 * Try not to complain about the dirty buffer marked dirty
+			 * by __block_write_begin().
+			 */
+			if (buffer_dirty(bh) && folio && folio->mapping
+			    && folio_test_locked(folio))
+				try_to_complain = 0;
+
+			if (try_to_complain)
+				J_ASSERT_BH(bh, !buffer_dirty(bh));
 			/*
 			 * The buffer on BJ_Forget list and not jbddirty means
 			 * it has been freed by this transaction and hence it
-- 
2.33.0


