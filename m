Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAF43B1659
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jun 2021 10:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFWJBW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Jun 2021 05:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhFWJBV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Jun 2021 05:01:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B31C061574
        for <linux-ext4@vger.kernel.org>; Wed, 23 Jun 2021 01:59:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w71so1809304pfd.4
        for <linux-ext4@vger.kernel.org>; Wed, 23 Jun 2021 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/NfJMuWUrWDoT67EPRbUvQvXR0T9bdEK5Kyt2sjyVw=;
        b=rbbTjt+iVsWPgIvSKvR7lzN78YLZ5/WeVxL7iFpQbv3yqRJFmx/P1U1Kw8YvSpN5Py
         tP20D64kutbKqm0AfZkv86thDmJAIs1KHiojPA+w+ig0EVao4HSUC1QTSvLf4HYpDkrX
         w4zWm4CCIXyJF/xjO/h4X93BKh9An+QDQMmWyUENUJuBs5dRKxkzybx7pJMfVT4h/QUG
         2zveeGNsi6spE9CuNqdQVban8jLS3DaUxmAm6rLsKG+MIjfVzN0PSQ9W+UoM2qxoSno+
         3P1sW/LZ7gsZOKDRYowSdirKs1y8JWxy3zaqL/XWFOP6nCS4hwCQHr6YEeW3lGDtBvim
         uQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/NfJMuWUrWDoT67EPRbUvQvXR0T9bdEK5Kyt2sjyVw=;
        b=If393nHiYOlfKSVConPSl+mryQtUL404etve+iKEmXvsWwTErKJbA/Bd1E4JWRVjh6
         CqusX90bQHpLr+JPX6D0//9XrqzpSOFDmKM48ZC1sEwdvnkUQvYDZauUFVtr4JwFfD65
         zPVXE93v4taMI/4rKzhL5Pwxt+OYH2+EZiS9xOM192Xwuj9+dCd2Q8q7fRYfcZIsNXNk
         BlR0tW59AqIYMMINunBMcVxexKRtkYzfukTFcADWWq1pqX08YRKnM30XP3K7ZC9U1Yh3
         MNWGJecw+03kRCgQr6nSbMdgISHHZx6diVMqYYbkqTVVjqEqho1CU7U7VlSpnmroIo6Q
         4wpw==
X-Gm-Message-State: AOAM531/vBOWWgaQqeRZDrFlNJHlE8fAKlucpbnr67wHY0/aX3+4qFZG
        YFRpcoWsIgwQL3YvbjE0CEafJT6LM/c7Ku1t
X-Google-Smtp-Source: ABdhPJzp4BuMlMDT7qlaBy/b6ElMyhVVf1UzbMJhmRb9AzFdgRuxiugOqg7VMQQsb977G6AvHSnmXQ==
X-Received: by 2002:a63:1601:: with SMTP id w1mr2953121pgl.116.1624438742324;
        Wed, 23 Jun 2021 01:59:02 -0700 (PDT)
Received: from localhost.localdomain ([89.187.161.160])
        by smtp.gmail.com with ESMTPSA id z23sm4689564pjn.2.2021.06.23.01.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 01:59:01 -0700 (PDT)
From:   Guoqing Jiang <jgq516@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [RFC PATCH] ext4: remove conflict comment from __ext4_forget
Date:   Wed, 23 Jun 2021 16:58:46 +0800
Message-Id: <20210623085846.1059647-1-jgq516@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Guoqing Jiang <jiangguoqing@kylinos.cn>

We do a bforget and return for no journal case, so let's remove this
conflict comment.

Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
---
Not sure if my understanding is correct, so this is RFC.

Thanks,
Guoqing

 fs/ext4/ext4_jbd2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index be799040a415..6e224b19eae7 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -244,9 +244,6 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
  * "bh" may be NULL: a metadata block may have been freed from memory
  * but there may still be a record of it in the journal, and that record
  * still needs to be revoked.
- *
- * If the handle isn't valid we're not journaling, but we still need to
- * call into ext4_journal_revoke() to put the buffer head.
  */
 int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 		  int is_metadata, struct inode *inode,
-- 
2.25.1

