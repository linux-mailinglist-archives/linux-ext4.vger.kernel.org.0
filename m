Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EC2A8DE7
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKFD7w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFD7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:52 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58899C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:52 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w65so111693pfd.3
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGqyJKoHPFZ6D8548z0Pj4rGvVI+QhKznUCucjBN+T0=;
        b=UYkafArSFUZgGRzAYfUq3/tDCHG35YRiOUHWooks0iRWMpa/lrFbQfmh68R9Fc7AC9
         V0hx6YcV2nOBKzY/OyXYZ43IUpKo2F5aKYA3axjafR7TSkc/hi8sb7aiYoTPcXNqOB7R
         HljnqBpNToA/woyBE8C1D1SexoHeLKlxP8TFP2yPVsnZN+TTvfflkCHOxt29Aj+jl5cl
         rfWs/EnySzSN7wTHzl/e8duw6tvlJYKIgmBDWkAl/S7VAFL3CEbwDQuNr4PEKztXrNon
         qrlLjjKQvqYWG8OhaAEYqUOgzBlmxeBGqiQ/3B98TKQ/ibFE1/df7M5Qi2063P+ULcKl
         tJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGqyJKoHPFZ6D8548z0Pj4rGvVI+QhKznUCucjBN+T0=;
        b=JiKJ6iFWrrA1l0wuiQU9se8EeKExEvcAUUG7I0HPohyIYaQnUXGx/0BT4vTndsbxV2
         NJOdChzCZHQj8d0ET0W6AhZ+Jpx9bb8JYAALBsD4xNV/7IPBKgudFNNfBhYPUeKt6D3+
         IWwRj+s/CoOgjRpJ/qHzawObhWXJeNcDsPLTgR0HFbxy6LSW+eb0i+9uXo4sGI7pZ8+q
         aXyx0kYf0Ehd6KjmqV0HW8LisWD73zdNK9hKdGDmiJIb/85vU4/njdjW8LhfXYcOZXZD
         mryjkkWFRnquOt4jQtX8FJDErSjL4niLHDJdiA/90nQBqxoABTztGZg+4Qrvm/d/YPj/
         iruw==
X-Gm-Message-State: AOAM531sVklcnHaB6xwmhq2GHKOXt9cTKaKMpbThyFq4f9hLLDuhHyHL
        MTjsXnsc/PVpN2XmcuBOmhGwhIy3l38=
X-Google-Smtp-Source: ABdhPJyuZLGaTPV7xcfTp8mOd1SHHXXhxd/9lqeVoE/5wjPIxZruGxms8YmcSuVz/+mEohbGkB98mw==
X-Received: by 2002:a17:90a:160f:: with SMTP id n15mr259227pja.75.1604635191414;
        Thu, 05 Nov 2020 19:59:51 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:50 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 21/22] jbd2: don't start fast commit on aborted journal
Date:   Thu,  5 Nov 2020 19:59:10 -0800
Message-Id: <20201106035911.1942128-22-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fast commit should not be started if the journal is aborted.

Signed-off-by: Harshad Shirwadkar<harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index f7ebf6ef69af..0c3d5e3b24b2 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -727,6 +727,8 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
  */
 int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 {
+	if (unlikely(is_journal_aborted(journal)))
+		return -EIO;
 	/*
 	 * Fast commits only allowed if at least one full commit has
 	 * been processed.
-- 
2.29.1.341.ge80a0c044ae-goog

