Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B121A320015
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 22:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBSVEc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 16:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhBSVE3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 16:04:29 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01EC06178A
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 13:03:48 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p21so5720621pgl.12
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 13:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnzL5gDkqRbD3IsFGdU42evoXK07lViYsNp8FnGdHwo=;
        b=L/ewALtITUyk9u5XGWUsnSyjySe5CYpjQZq4a9bpTOHmY55S3/r0j5wvKsEJBHgipZ
         iGs+hheTaJwVy9KK6nHAbq1lw9DCcrtFN/mA/mrFtoqomuSLJg5iZsFsaHipJArKdBJB
         hrzj0zdZEcziC07mCubwBy650f/Xe9tunFvpvCt1+CFV6qEdTi0pGcNSMil7U6+DSEFI
         CQZAfiASM+yCWmOuXQStqlHQI0S2KPaMvx5hagXZE5AxH/e1FAyCrqY6spwU6pHwnvsW
         v/v9cxWmB47OMyWDG99e1PHJS9W8VpnrTdhs/sLojCxEvzYqh7OjkviAGRE0hZFxQScr
         zJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnzL5gDkqRbD3IsFGdU42evoXK07lViYsNp8FnGdHwo=;
        b=XCRMY/1kJ00ZN4YsBjTfSo3jT9QIx5/FY+9t7awuNKVFtWybMryowP9rKmNaRjxOYy
         mLY5qDJRjciBa9oiIStBmJZ1f8wLlSLHoTDKcLeWOwT/ulphYdUWSujw3wzBqG+1Oquc
         WpKBfFJNDY6SI58joBiyy7/leEWoMz0GrLzVn43aqPVjNvZgjxXgjkxDhPnaPXUPbyh+
         frJvcbMIAl9uM457F4Iwwg5Kcf3vd43mcHdeBN+ejlsAMIhQZlSTcQK3QqtKF8TMTJ4h
         yKqa7kZRfc/tQ7iIVap3Fmt50xIOWWNJ4juC9HC66AAHGaJWt02tT/s+3MLA94yTn8OX
         vWaQ==
X-Gm-Message-State: AOAM532F2mu9BoFZ3AXL712awhv8c6069BErGWw8UGVJJmz4en8sxNAf
        QS3NunWyGwITrwiZfXhQSUt0gd1IKVY=
X-Google-Smtp-Source: ABdhPJyLCgicG9y2cjeIUgiajHZzZ7EnhXlJVxvw+s5K0sG2+Sieg6vLRxQw+pqlRpNsuMNpoZ+8Hg==
X-Received: by 2002:aa7:8ad5:0:b029:1df:5a5a:80e1 with SMTP id b21-20020aa78ad50000b02901df5a5a80e1mr11281481pfd.52.1613768628153;
        Fri, 19 Feb 2021 13:03:48 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:48e6:60ce:73b8:bccd])
        by smtp.googlemail.com with ESMTPSA id 30sm10318756pgl.77.2021.02.19.13.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 13:03:47 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 3/4] e2fsck: add fallthrough comment in fc replay switch case
Date:   Fri, 19 Feb 2021 13:03:32 -0800
Message-Id: <20210219210333.1439525-3-harshads@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210219210333.1439525-1-harshads@google.com>
References: <20210219210333.1439525-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

During fast commit replay scan phase, in ext4_fc_replay_scan(), we
want to fallthrough in switch case for EXT4_FC_TAG_ADD_RANGE case. Add
a comment for that.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 2708942a..a67ef745 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -325,6 +325,7 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 				ret = JBD2_FC_REPLAY_STOP;
 			else
 				ret = JBD2_FC_REPLAY_CONTINUE;
+			/* fallthrough */
 		case EXT4_FC_TAG_DEL_RANGE:
 		case EXT4_FC_TAG_LINK:
 		case EXT4_FC_TAG_UNLINK:
-- 
2.30.0.617.g56c4b15f3c-goog

