Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79232B80E6
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgKRPli (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgKRPlh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:37 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697DEC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:37 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id z14so1659382qto.8
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sq/Wt/N6vZNBn3ie6Kd7N2wURpAwp2rrAhDC4aN8dBw=;
        b=O6haHNlOzhj1DRgwZioYmkBwY8/quVYgptj9yUSUl/3lqKhOw+1vtbsiSb06WNShGR
         Z7JZ6aVwoKZY328j77S92QsTrKeUBc65jGHkvGIJbTN2YLx0VdJTPTggTukBP6mOK98s
         3Tx5q/4wUL0dU9b75lyF/9yUd4sr3PBcua8BJl0Hpx351nqxEJv3o2g1zfrS0Vngmwc8
         Wdf51P6WsMZmtKZjfnoY2hlA3aPRVF7hDp2B2er/Q9uo82XOjIsoDsObECFMAJgdusmY
         UzSSzhlE/xxlm+4LXjAoI5fyGz0pLV/Cy6lJqyO4S7kZJjDh0shWT64zlX6RpyHPuAtV
         3pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sq/Wt/N6vZNBn3ie6Kd7N2wURpAwp2rrAhDC4aN8dBw=;
        b=WbaT5f9Ew8sH0ADwDL0RWiydvB/7H4IYncJyKkAmacGKWv8Qhp/r0RVfhoaH99+LCQ
         BvPtDqGgq6twF9JYt6GSMfYsAsz2gur/dHeqsrq1L8RGFX78sOBddhr6Acmf6ZiVO+Kf
         M590uavMYrQUGIPDBP9oT9O0tqG44eaiMP75yDKUMZKi8R7Rj6utLSBY5cJ+8AD16d1J
         QlJ/RDc8VgHqTDQ8BpOd1cOTcr0ZrpfXcyPBGwnSx+7L6xT1Tnnnvb99VPi9H0SLQTHC
         60l6S9cBy7I7pJqn24ZsaXmsDyPc8s5qb26EBOdvubQrmMhu74knXXTyqcPx6vxWdxJi
         z+Ag==
X-Gm-Message-State: AOAM533AqqfZ3+u/m2GXamv7FxDkZbkgsvHLp/8iC/ERZbSlQomBXJuG
        LHABXTocRQoZo9ZvvfMnQAD3rBg+hfJe48q8nZFjqJXjqLExndPagX40dVNEOaY63rrovgluQge
        ahSPTWJVtm7Ah8xksGzWNgUv95lPaSWuPvRJ/4ZonHaf+AcXYaMnrpe24ovYaLmG2lxItBA+wWG
        ZyLPNFzaI=
X-Google-Smtp-Source: ABdhPJymAya9IYyoW2ZE6fX3KEASj3dZyV5UNK+Zttos1qcvGGA3ePAfbLqEgCJ2bjcGG3RdpuTcOEFXKaSWediu6MY=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:ad4:548b:: with SMTP id
 q11mr4911153qvy.44.1605714096518; Wed, 18 Nov 2020 07:41:36 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:24 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-39-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 38/61] e2fsck: reset lost_and_found after threads finish
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

This should not be kept, the reaons is similar to what
e2fsck_pass1 has done before.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 1a68a2fb..09bfef44 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2991,6 +2991,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	/* threads might enable E2F_OPT_YES */
 	global_ctx->options |= options;
 	global_ctx->flags |= flags;
+	/*
+	 * The l+f inode may have been cleared, so zap it now and
+	 * later passes will recalculate it if necessary
+	 */
+	global_ctx->lost_and_found = 0;
 
 	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
 	if (retval) {
-- 
2.29.2.299.gdc1121823c-goog

