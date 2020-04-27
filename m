Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2341B94FA
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Apr 2020 03:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgD0Bep (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Apr 2020 21:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726327AbgD0Beo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 26 Apr 2020 21:34:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB1FC061A10
        for <linux-ext4@vger.kernel.org>; Sun, 26 Apr 2020 18:34:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so8180897pfn.5
        for <linux-ext4@vger.kernel.org>; Sun, 26 Apr 2020 18:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ApY71GV24xgG9hyj18t7ETunrHn4njw09UQGn+OtWvs=;
        b=HVVL50XGFdafZjM4+UjTbNoHYQclR+skPlGtaM0tSYlsp5WHUd24ihbV4UqTPWssq2
         Yhn95MC/0dIWA/H6eJ90pCMHu6+HyS1dH3HZcpmbELkjpjc4hR0opQyTqcV3ZAkN5WLc
         BuDYMKjmdmGOUdPTU1wxn4PU/QXTyP421lgZmhmM5fRkszIht2YVfQzpmExj8VFYAvwb
         m3NhPs5KccqJ6Kq+gGNDbeAGcim3y0X2zIB641sN7A6dtAWTDMgikQmlK0ZGfw1bGbuz
         0JQclt29tEOCQRpYu+a7WDgWjh9stU8MKGYP7fYN36L0jGaR6qq/6LuP5SvzNUxKWVfM
         wvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ApY71GV24xgG9hyj18t7ETunrHn4njw09UQGn+OtWvs=;
        b=igS0kXiJoG0B7yqo8odwET9acpcsVrEyfPPCZ54YaUEIcBPW1Ls3t8fyO1sUZPfQNA
         rzmMqMUIahcAxjJtyDEJ4jyX8wkdK6MCiQGDEUgSrctdXFnlNXhIHcS5t88bCuffCbis
         UIn43tE10tiEcghseHYc18nj5r96BSmRA67Yfaq+27xWtfCE9iCe1jC6Ppxvjl3u+aZ/
         uDRBXdLxGBSvHoeZC1if1HMDZwXnqw7L7kY5q28eU02SBXs37NmtRkRVyg4Iec0Uqi1E
         MU2MEPFkCFD+VzGg4jWckqPBMLqDIOzT4Nx5jOpJfHVCC/QmpK/s9uW9L5TMfWmnLgzF
         eCWw==
X-Gm-Message-State: AGi0Pua25ykSQ+0PZnlemvT6ePbVCbJuFf9jXcYAcf0tDH2VucERUKUT
        tWEv/JVRojUceox99ZLdy4JC3ZOj
X-Google-Smtp-Source: APiQypKDIDVB5lU9x3ZPKD4Vl7U5+FrfZkpqBj0m1Pch9bQMEeLxOnj9XUsdu2L3Pravl4GS4tKo9g==
X-Received: by 2002:a62:81c6:: with SMTP id t189mr21315030pfd.174.1587951283830;
        Sun, 26 Apr 2020 18:34:43 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id o198sm10913790pfg.183.2020.04.26.18.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 18:34:43 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3] ext4: don't ignore return values from ext4_ext_dirty()
Date:   Sun, 26 Apr 2020 18:34:38 -0700
Message-Id: <20200427013438.219117-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200427013438.219117-1-harshadshirwadkar@gmail.com>
References: <20200427013438.219117-1-harshadshirwadkar@gmail.com>
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

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 Changes since V2:
 * Reorganized commit message

 Changes since V1:
 * Fixed incorrect return value handling in ext4_split_extent_at()

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
2.26.2.303.gf8c07b1a785-goog

