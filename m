Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB5322FC8
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 18:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhBWRnH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Feb 2021 12:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBWRnD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Feb 2021 12:43:03 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBA1C06178B
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:42:23 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c11so9228781pfp.10
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnzL5gDkqRbD3IsFGdU42evoXK07lViYsNp8FnGdHwo=;
        b=N54EV6uoywr+Y3NSoNcs5M2+oV6uO/8K4yrEuM+xmVksJjD7eTptk0EL0Y8UIIdodq
         9RcRpxoT0Az/4XkXoAFjJ4iETAGdQlv58TWwSZUKTPi0OC1XMp5B5G3dXRd+ZzdYjxIP
         ceh34W5kW5lWU6aUq3Bjp4cMmf09Iv5j6FEbLll1zk/JFVCLFf3q+k/ae/+Bn9InRXUm
         zFtLI/lXAQNb0cHz+qsuMePGOH7BlBLN43D74kynwE9JcDyBz1Lfh6kRhObrhXtyHXiV
         VAWN0S3L1H9JHCwzGCG19ZwPf+uDVN56jeIjr8hgozDYI5dE3baG6ebfbAonqapXBkbP
         bGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnzL5gDkqRbD3IsFGdU42evoXK07lViYsNp8FnGdHwo=;
        b=EF64K997QO1IFb87aJRFy7hzB+0xCHyCTgdYg559dwodDHEzMT5a38BaLrkSVh5pDt
         D7rNtq8VvRbhyJZCMeWrFP1vucgBHyhlDVDZQG+sysTH9URDQ0SnPXkVQhOewZUnc9Dp
         ZPKEM5Bkez+9qD/8MJAfXSjNC/LFgl+FF2knt7+H2GmAYiMl2IsGetgLrlp3/hSFcOWO
         MTWAk+/WXrncm4BQOePZRvG5mZsgKv7napC3PYIdwcFRGdA5uCoHSFibTLFzG6jE/pPu
         Jn8SE35A+a03b5AOxglicn2LjS59YRqVnMckm+vpFxEQq7uMetZzJkpos8VxU4r03EBs
         XnCw==
X-Gm-Message-State: AOAM530mAnU9awhbpA34tX1vU0+kmeFOtUn2KEIgaqklxGMjDAIawvQR
        +/45nl55yziurzlGauhmr0v/AIlgNGE=
X-Google-Smtp-Source: ABdhPJxxFzpJvXicDI5eB625u/yCX0fe7GMHyaRLd4EZwP3CuFFYl7Zy5cV2d+Aa+RyU3jeAgUqKRg==
X-Received: by 2002:a62:187:0:b029:1da:e323:a96b with SMTP id 129-20020a6201870000b02901dae323a96bmr28465258pfb.28.1614102142568;
        Tue, 23 Feb 2021 09:42:22 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:9c60:903e:f56e:8b80])
        by smtp.googlemail.com with ESMTPSA id gk14sm5527408pjb.2.2021.02.23.09.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:42:21 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 3/4] e2fsck: add fallthrough comment in fc replay switch case
Date:   Tue, 23 Feb 2021 09:41:55 -0800
Message-Id: <20210223174156.308507-3-harshads@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210223174156.308507-1-harshads@google.com>
References: <20210223174156.308507-1-harshads@google.com>
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

