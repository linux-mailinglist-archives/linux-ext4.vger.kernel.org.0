Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D6E2B80ED
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgKRPlv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgKRPlu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD82C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w8so2923730ybj.14
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DgnEoMuEidHu66jEvK6JXNOLWM5hp9t9dmgKJbWHLrI=;
        b=n1QBNlOxqeQgsE47DwPhyk00F3IKYVP7EoNUfNFHUiKuNLNq88etkqUYaf5EvnxQim
         46bNYwAsct7u0kvPIBDN7fj+PSKgNniF391iumnEAmQkf/o3w20WjtePSJJvmRMrpBhd
         wZPOoe96kdxqT5wLaQ/ynPY6JswgbLzajOoG2pX6qg/69iFn1QN6A62rcfCnbbRFzBth
         56iZ4WZrC8zZPG/B42vXPLVKu3gSTchryHUdZYBruCrPtGoes1pt7eh8RjMdWBvfcHKq
         ZKzt/4hfrPIqTgOUdRAgdS+U/pELwSapc9FaGebYE1iIhc5dxpc1YrNWF9pLiA0qPZ3r
         Wjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DgnEoMuEidHu66jEvK6JXNOLWM5hp9t9dmgKJbWHLrI=;
        b=H0AElu01TjQIikqoEUbMQqLTFr1Uj/09LzuYtq3nZNxn+oESC0SwlOW819tqZsxtAj
         UiICgpSJArLOc3sD5uUzSRKD9DuH52zm01WuKNYBRHKR+NDN91Bjvh+RDJwpoY7VzJvu
         0ElkzV309bglA4idGp5yT5GILcSELVoUNPIYlZW947btw/1j1gKtwp0aaxwIEmQZugFH
         4JcuN5l/QzaHw9MjpKEhJEjNoVpRFeEd2dHwDHlG6TjgxOpkzBXEcIjUQgTy1e1TTjVS
         xn/NnNtM5BTP60d2kbZoEkDTdWn3lJydlWQUlzgY3fWKiPvPo9qsfA0UsMiMFvfwcuwT
         QxEQ==
X-Gm-Message-State: AOAM531GovnerJbDLb7LrhYu16mS7yOtZhC86oZToQEuHJEV72gci77r
        abF9h+bd9jEstFPBN9ownWk0ulYcA2RaqBf9EPRZu11wmA4GnFhQivDoZnZi7Wjcsj9aiwLriss
        yBixF9moif1K57KNt2Ko9gWjDURagMcRbh2W9MJ/V8+XXLv7AtjUY9LprUa7PJjNLjgVpirvqSQ
        RacHYjdNE=
X-Google-Smtp-Source: ABdhPJxb8iZYvr6BQt8Axgnc0mL16S9wNbVO0E8sfSR+Im0kXoGT51HocAQCK4hWd4QqX6/jMX1Cpndx7FEHcDXBZz0=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:2c3:: with SMTP id
 186mr7560017ybc.205.1605714109799; Wed, 18 Nov 2020 07:41:49 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:31 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-46-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 45/61] e2fsck: make default smallest RA size to 1M
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

If we have a smaller inodes per group, default ra size could
be very small(etc 128KiB), this hurts performances.

Tune above 128K to 1M, i see pass1 time drop down from
677.12 seconds to 246 secons with 32 threads.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/readahead.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/e2fsck/readahead.c b/e2fsck/readahead.c
index 38d4ec42..40b73664 100644
--- a/e2fsck/readahead.c
+++ b/e2fsck/readahead.c
@@ -234,6 +234,8 @@ int e2fsck_can_readahead(ext2_filsys fs)
 	return err != EXT2_ET_OP_NOT_SUPPORTED;
 }
 
+#define MIN_DEFAULT_RA	(1024 * 1024)
+
 unsigned long long e2fsck_guess_readahead(ext2_filsys fs)
 {
 	unsigned long long guess;
@@ -245,6 +247,8 @@ unsigned long long e2fsck_guess_readahead(ext2_filsys fs)
 	 * in e2fsck runtime.
 	 */
 	guess = 2ULL * fs->blocksize * fs->inode_blocks_per_group;
+	if (guess < MIN_DEFAULT_RA)
+		guess = MIN_DEFAULT_RA;
 
 	/* Disable RA if it'd use more 1/50th of RAM. */
 	if (get_memory_size() > (guess * 50))
-- 
2.29.2.299.gdc1121823c-goog

