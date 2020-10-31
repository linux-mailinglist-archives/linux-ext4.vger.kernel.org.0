Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC72A1A74
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgJaUFz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgJaUFx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A68C061A47
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 133so7819356pfx.11
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kN0bgsVSuQoMuR1Y4+Y61oz897QmYljIn8U6y9Kl2g=;
        b=VyKbS/BWfH8XwIg08N7U4oyhZ19qEuLzjEHVNy+aqgbKUldwdeaTwEcJ1ivsY3M76c
         qed0OEECNh4WiOD01W38PRPuaMgsZfUEgjx02oFMw8HTkWGDtPeLl2jynIuUHHW71bU7
         aG/MrcoX9EkE5t/q3y+qLhcnH3WFrmEKJRm0MSajp2990I8XrpqetpRbVfQZrBVamtYG
         7llvPV+9/HJ47j44sCTn9yIIDvgWhZ6Y60/sAr5AmPfqS+uer/1Pbtj3zVV+Qfp36JvP
         1OR0OgCJP8/oH3ac+3tqOVL2seN/X8VZaIQBJ4V0WRM6cYTrWVs6ty/zhBt50f1GYsyu
         UYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kN0bgsVSuQoMuR1Y4+Y61oz897QmYljIn8U6y9Kl2g=;
        b=MVVkg0hLU28HW2XJqdwuJd99fmsjwsQKyo+o0vfeVRCJr3esdhwtk1LyBo8xzfqL3R
         6ic2fgY3Db1ZPYqijaTKFt51tLgltoT8jjlsxP3xue4MSd6CZuS4k91Ca/gGDZSn6Cme
         mIfGUxy9JTrTqHECl9uTqsweSppaW8JRnPLqXc7dD+HOiDRRzY5/qfKTpkKlmXzS042A
         7whfmdzc2228ElrSu0XkuGKZgbYn2CMbXFxC91B8c9EfyshAWwGWUU5URrDyHYKJbbyL
         Wjch4Z8ggbwEu6B/YzWnu5cYUesvGWmuhRJePqO7TKuu89Z4esSQAU8eNLi56uFbvMg6
         3hjw==
X-Gm-Message-State: AOAM532wbOX02HDoKCAwgEczmYwLGzOO+Q3eZkbhvgmx9MnA48B+ANs2
        xd11RQOisEJEsme40TQte3hNu912QDQ=
X-Google-Smtp-Source: ABdhPJwfeO7g3UZ55aUJ+TuqNVrrYsCMtaCMd09FZFgQOPducvypbtY4XSRJvK/iHurZG86tRUXJ2Q==
X-Received: by 2002:a63:db53:: with SMTP id x19mr7282816pgi.39.1604174752502;
        Sat, 31 Oct 2020 13:05:52 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:51 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 10/10] ext4: issue fsdev cache flush before starting fast commit
Date:   Sat, 31 Oct 2020 13:05:18 -0700
Message-Id: <20201031200518.4178786-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the journal dev is different from fsdev, issue a cache flush before
committing fast commit blocks to disk.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 9ae8ba213961..facf2f59b895 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -996,6 +996,13 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	if (ret)
 		return ret;
 
+	/*
+	 * If file system device is different from journal device, issue a cache
+	 * flush before we start writing fast commit blocks.
+	 */
+	if (journal->j_fs_dev != journal->j_dev)
+		blkdev_issue_flush(journal->j_fs_dev, GFP_NOFS);
+
 	blk_start_plug(&plug);
 	if (sbi->s_fc_bytes == 0) {
 		/*
-- 
2.29.1.341.ge80a0c044ae-goog

