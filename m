Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CEB2A8DDE
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgKFD7k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKFD7k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:40 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC6C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:40 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id g12so2925799pgm.8
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJY3WKGp9OTdpkNgdRqrVZrXPonjAKm68Wiz5CNPD5Y=;
        b=ikzFqZ67HRe1udZrt3dgsYACa87Fb9mytvsZCxjp8Hr4RqfmrNK5+GPneWmkznwsNM
         xxTMkd/TtWOGBBA+nCPG6H2RzhwbNYeG6/f8ghxIzxxjz7vR72dOptBmgsZliT0f3D4j
         2SXNEQMPLpk62GJxEWifHilh9PkC7BZLcGRHCWv4ZaKY7VxlLOBKaIrGB/mieb3FBdal
         DMmgh/oqzFTE6lJ04kWRa5dMZrj5ENyaJqzwBfHwXg1HKOqFq20RlhhlKfBC6Et4ysyx
         ewXWJprGDdXAdKiRWlFEIPtHiKV3hLSHI8zkhX5y+ZhJXSssU8Cpn+R2Lh2TNx7HXfSl
         sQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJY3WKGp9OTdpkNgdRqrVZrXPonjAKm68Wiz5CNPD5Y=;
        b=BcicNOyvqRvarbZWXiIPmtaWgE/gEWrs/Z0s3e2pZyCt6TKJbL4bWSmCURKsBCDmJp
         siOTuvRkrh4B2xzMJvC9XhBwev0unDVsh24LWFf9QVapuGfxQOGGoe3bIIPrKpvz95NA
         KCLkb2DVMWNQ8qwTxHBsACduo5cHCM0qG3bd5kU5X54vt1KLJQHxkHpL0FEIITGDgF+C
         7G79ZZIDP4lTkVy6uZm3nJAob8nb+4kK45O05qTaho8+SebMZTPkDbFTGnOOfJGy9voc
         Y6Bj8QhwQkOMIlhr+dcWnqBvg5r88m/tSvwii/sHAPSe1FfHWd+qM3k/gKGqG++2LEhM
         P71g==
X-Gm-Message-State: AOAM532fo9F0LrPTDFywJohI2Sq5UKtei4Y9WYEErPFpVtNBH/S3VOX+
        jaWFx5wQS6CvR4PwvZjgQmFOexcxaaY=
X-Google-Smtp-Source: ABdhPJwQjgUvzWQNqNzhgZRX83+CzHlmBc/h5z2T/b5zUUykylgeqWfZrLyQTn+psVXhEWuR/nmRiw==
X-Received: by 2002:a17:90a:c257:: with SMTP id d23mr293131pjx.46.1604635179036;
        Thu, 05 Nov 2020 19:59:39 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:37 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 12/22] jbd2: don't read journal->j_commit_sequence without taking a lock
Date:   Thu,  5 Nov 2020 19:59:01 -0800
Message-Id: <20201106035911.1942128-13-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Take journal state lock before reading journal->j_commit_sequence.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b5fbcd1b444c..f7ebf6ef69af 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -734,10 +734,12 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	if (!journal->j_stats.ts_tid)
 		return -EINVAL;
 
-	if (tid <= journal->j_commit_sequence)
+	write_lock(&journal->j_state_lock);
+	if (tid <= journal->j_commit_sequence) {
+		write_unlock(&journal->j_state_lock);
 		return -EALREADY;
+	}
 
-	write_lock(&journal->j_state_lock);
 	if (journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 	    (journal->j_flags & JBD2_FAST_COMMIT_ONGOING)) {
 		DEFINE_WAIT(wait);
-- 
2.29.1.341.ge80a0c044ae-goog

