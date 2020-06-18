Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6651FF6E4
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbgFRPaZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbgFRPaD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:30:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E721C0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 10so2935293pfx.8
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N22UmjmGFMtkx2MvI1gvrkMkMJ/2RB2GCj9TAw8GfaQ=;
        b=MTKsPZ8A9YpZ4LI1R8JHX2xTmK9gACCNgTSKkQGZrrkQXBWvJtZrv2Hl1TqKifQN6H
         BrG1mez8jh4SfLMNXpQgVOH123WqMAAseH0eGmki9DOFk98d+tRi7OY9oXzYEEW/zvcf
         jVPc8Kv0mQJjbRu4mlwRzu5Utbym/Rwp4GrtHTdSbONpbO0Oahja0OGTgM0ONLH62vh5
         6G9eQXEFsanGreEp2XadrYzbILNof8qxL3Fxt6zP1xkaiAwGPCbko4V8cqKqM9rJ5huc
         WD85hEvaIRNsm4I7+jPp36RXE5qY0LY6Vi/GgcgQwyBU15+pVJ2UnVJdk2930J0w63t6
         WdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N22UmjmGFMtkx2MvI1gvrkMkMJ/2RB2GCj9TAw8GfaQ=;
        b=Iph4IGccYBILDPs31NDN2SAoK6pnexA9hPvEvGY+phmYdXu4x7mid38JuIq1D+33bz
         mC8NNE4IQGQ7QEUrR5U+O8n3dC9wbBHzruYByQsJQXPUOIVefXNliyUQLzeqvaSfrNG9
         YUl+UT3MRGQd+Sly8z0aM10HJfsXYKsPz3Q8LsAtRm1boZ0RICrxpXkTN1sq8o13xE4G
         6NqUFLsYyPl5kkLOlRqyP9VW6UUdKQKxP5vGEHxvSBG4VZbgH5XCL1P4uBsUf4VFBgDQ
         MTDqYE6RCT0HDn3xbF5oSAbR5H75dhH0EGp1VdcKaWUs+hNJ5j8wXtheIXnm/Tmlghc4
         IfGg==
X-Gm-Message-State: AOAM531PhdI2XyS+ZLmdQOtRjnVhNujPwRaZJNWsgTZIwuoC//0FmuKl
        8Ex/3bjcJItZJzkdLnIPdk6cD/bXcaM=
X-Google-Smtp-Source: ABdhPJzaydkODg6PsRqd4HeFwhPSvMJyyZ1GAkCSPD65EpztDVoWcZauso5lpYSw6manuIJEuxy/7Q==
X-Received: by 2002:a63:1a42:: with SMTP id a2mr3800386pgm.269.1592494201261;
        Thu, 18 Jun 2020 08:30:01 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:30:00 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 45/51] e2fsck: reset lost_and_found after threads finish
Date:   Fri, 19 Jun 2020 00:27:48 +0900
Message-Id: <1592494074-28991-46-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

This should not be kept, the reaons is similar to what
e2fsck_pass1 has done before.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index b4adb8fa..3d6af9fb 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3012,6 +3012,12 @@ static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
 	global_ctx->flags |= thread_ctx->flags;
 	/* threads might enable E2F_OPT_YES */
 	global_ctx->options |= thread_ctx->options;
+	/*
+	 * The l+f inode may have been cleared, so zap it now and
+	 * later passes will recalculate it if necessary
+	 */
+	global_ctx->lost_and_found = 0;
+
  	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
  	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
 	retval = e2fsck_pass1_merge_fs(global_ctx->fs, thread_ctx->fs);
-- 
2.25.4

