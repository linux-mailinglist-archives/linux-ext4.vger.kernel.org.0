Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8C1B1C5E
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 05:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgDUDDA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 23:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgDUDC7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 23:02:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB571C061A0E
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 20:02:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z6so4716083plk.10
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 20:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJUT+t9Ctf+9ZLECZK9t9dQ3IYXSC4R9UadcYe9hlCE=;
        b=CRP9hfG1OCm7oMJQCLNayOGrembbnA/0Y09v8R+UCSikyoUF2xa7C5ECCaIFVNIFH4
         jwFL3xk9e686Ye7UGxPTPPsvpY8H8f1/5tHOjRXwI/e/qezxYuQ4xHctYDMldzRxtZZK
         sdntJIM+ul59z/ZSit5ZMWXbe38yHN+f+nkaft2SKYxZvDOdtv0ZC8qh14nE+FN3JiHI
         wQCVPkdnfgsjhKY5vTh6E3g+Q6YhY4jXUyrVhrHo5Q1iCD7zcEKlEZc/KvF8L+tmIoOz
         bjVlJEz5JoW6aa2RMoI3CfRspGle4HZEVALVN9V4aaGzB12B3Qc44kW5jd/Hx4xWh540
         ZkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJUT+t9Ctf+9ZLECZK9t9dQ3IYXSC4R9UadcYe9hlCE=;
        b=kDrgaNX9J8w+iah1LeM9GirQvWZ8uK6QRJnbCTTQkRWGtzRcKDUGw8djbXqczhkOmw
         c0QI/fqzJtwpRs8SkGKGj/EcjVkf5JbpFBGFm7oq2CMlvy5r8tBMmb01G9/K7NsIoiDY
         NL7xaM/68lDBXcuzAhf3J/16BCB/R+klm4rD4/hDtN+pbKxWKzYEMPzrrq2ySs0/ZQU5
         8G8WheK9gvsgI0XBEUEqQ3w+MbRVGa5ZOEqO8wylPbaJ6chOhMI2Iyg0i2PhdMTrDHB7
         ft/+1Oyr6n6Dy81w6F6JqWiwcdpjU5ut67oyCBuDnPVg78OJ24FjxSsa73zUkhf64eA9
         Trfg==
X-Gm-Message-State: AGi0PuYSqBj8p5btwUGYSThYBxmGho9ma3W1QkeUtOfXDf5giPcI3AOC
        sJUuKnPTFDJHY+w0l6QVBJ8g60ps
X-Google-Smtp-Source: APiQypLpOWlC4Puo3x+BMwb5E/cHzN4769+HZnSB2o6nn6gTryCYZnc+oFbSpM54Ic5TIj4NRRlKBA==
X-Received: by 2002:a17:902:262:: with SMTP id 89mr19611629plc.131.1587438178759;
        Mon, 20 Apr 2020 20:02:58 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id e4sm773090pjv.30.2020.04.20.20.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 20:02:58 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2] ext4: don't ignore return values from ext4_ext_dirty()
Date:   Mon, 20 Apr 2020 20:02:47 -0700
Message-Id: <20200421030247.34306-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Don't ignore return values from ext4_ext_dirty, since the errors
indicate valid failures below Ext4.  In all of the other instances of
ext4_ext_dirty calls, the error return value is handled in some
way. This patch makes those remaining couple of places to handle
ext4_ext_dirty errors as well. In case of ext4_split_extent_at(), the
ignorance of return value is intentional. The reason is that we are
already in error path and there isn't much we can do if ext4_ext_dirty
returns error. This patch adds a comment for that case explaining why
we ignore the return value.

In the longer run, we probably should
make sure that errors from other mark_dirty routines are handled as
well.

Ran gce-xfstests smoke tests and verified that there were no
regressions.

Changes since V1:
Fixed incorrect return value handling in ext4_split_extent_at()

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/extents.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2b577b315a0..6425f4f9a197 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3244,6 +3244,10 @@ static int ext4_split_extent_at(handle_t *handle,
 
 fix_extent_len:
 	ex->ee_len = orig_ex.ee_len;
+	/*
+	 * Ignore ext4_ext_dirty return value since we are already in error path
+	 * and err is a non-zero error code.
+	 */
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
 }
@@ -3503,7 +3507,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	}
 	if (allocated) {
 		/* Mark the block containing both extents as dirty */
-		ext4_ext_dirty(handle, inode, path + depth);
+		err = ext4_ext_dirty(handle, inode, path + depth);
 
 		/* Update path to point to the right extent */
 		path[depth].p_ext = abut_ex;
-- 
2.26.1.301.g55bc3eb7cb9-goog

