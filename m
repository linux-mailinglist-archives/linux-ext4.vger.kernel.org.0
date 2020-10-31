Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29AA2A1A6A
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgJaUFl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgJaUFl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4265AC0617A6
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g19so685376pji.0
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o5bljzUCNVJH27l4iRKZz07B9nzI0+7vnypubYcKy/Y=;
        b=H4wnGBRYxXAA4vlsScB67tJ0OpUgLzi7ezHfQGU7O7ziIpR5An4KIT1oP0McOzfZuP
         h8f+O84B0oQm8ri1t/ToYfeTWM+Zz0jXTS/HVO8WjjQQ4eH9+nZDizNMOP0B5OYLIoIv
         uVluOxvL+5+obZBINglFUztaWAyVJBfQIINrhgqzjskWh8+5S3KYm3+DPJpt5ZCTnQLc
         S90bb6XvHYzGGkUEYYDI6Am6uzbUFzHPNq+nb4psBIULHnq4DPA+2NxrDvPIUErxRrUl
         dzVrCKjyYnrwmNS45TLHztPos6cnLh2Lt3XvnzM9jFP80UCrQHRXEqzvI1bKcoUxGLMf
         e1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o5bljzUCNVJH27l4iRKZz07B9nzI0+7vnypubYcKy/Y=;
        b=BKf0EJyzLyxEVPWw1ZjznS85LMurphCU/kz+D/sDOE84yKqgdFIimWB7TgEJBWmN3g
         UjWjrLHza5SX+V8dwXDyrDOnIMIcqReI3ZrH1iDln7F+QZfgBMlMr/amRNEbNK7+c32N
         hVc60Rk9RXbNIAMORePiiEQgr+PQVB+X1bPhmyZkEjIUtLllaA5YTc2Apbpo3vN2SN9W
         W6y72OIxRLBp9lnXzSDUvSdXP9mUuHJVTWhsA/eaiaz6x2jp5E8yMgI05cp1kn5NqrwA
         VYTLuPMK7Sa+2LSBXFV01kDeAlC8EOfKf7X5T5r6UEePTaVztEV0liEdzw1z+wGmJW0g
         V1uA==
X-Gm-Message-State: AOAM5307FzwUm+dYlzmsgRv3kUUyiLMCIEDcDmpaPE+hB+F59ItDKZP9
        y9jzGWt5PgrqGIIgqhkYP1IsV6fhebo=
X-Google-Smtp-Source: ABdhPJxV6BIm0Qui/4MjSvjJhB4qkD56NDcnSOWMAKNDk1k9MbwteIyb4rNlUb147Y9qAnx3ynOKTw==
X-Received: by 2002:a17:90a:6901:: with SMTP id r1mr10006176pjj.178.1604174740380;
        Sat, 31 Oct 2020 13:05:40 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:39 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 01/10] ext4: describe fast_commit feature flags
Date:   Sat, 31 Oct 2020 13:05:09 -0700
Message-Id: <20201031200518.4178786-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fast commit feature has flags in the file system as well in JBD2. The
meaning of fast commit feature flags can get confusing. Update docs
and code to add more documentation about it.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 Documentation/filesystems/ext4/journal.rst | 6 ++++++
 Documentation/filesystems/ext4/super.rst   | 7 +++++++
 fs/ext4/ext4.h                             | 7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index 805a1e9ea3a5..849d5b119eb8 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -256,6 +256,10 @@ which is 1024 bytes long:
      - s\_padding2
      -
    * - 0x54
+     - \_\_be32
+     - s\_num\_fc\_blocks
+     - Number of fast commit blocks in the journal.
+   * - 0x58
      - \_\_u32
      - s\_padding[42]
      -
@@ -310,6 +314,8 @@ The journal incompat features are any combination of the following:
      - This journal uses v3 of the checksum on-disk format. This is the same as
        v2, but the journal block tag size is fixed regardless of the size of
        block numbers. (JBD2\_FEATURE\_INCOMPAT\_CSUM\_V3)
+   * - 0x20
+     - Journal has fast commit blocks. (JBD2\_FEATURE\_INCOMPAT\_FAST\_COMMIT)
 
 .. _jbd2_checksum_type:
 
diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index 93e55d7c1d40..2eb1ab20498d 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -596,6 +596,13 @@ following:
      - Sparse Super Block, v2. If this flag is set, the SB field s\_backup\_bgs
        points to the two block groups that contain backup superblocks
        (COMPAT\_SPARSE\_SUPER2).
+   * - 0x400
+     - Fast commits supported. Although fast commits blocks are
+       backward incompatible, fast commit blocks are not always
+       present in the journal. If fast commit blocks are present in
+       the journal, JBD2 incompat feature
+       (JBD2\_FEATURE\_INCOMPAT\_FAST\_COMMIT) gets
+       set (COMPAT\_FAST\_COMMIT).
 
 .. _super_incompat:
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2337e443fa30..12673f9ec880 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1875,6 +1875,13 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
 #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
 #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
+/*
+ * The reason why "FAST_COMMIT" is a compat feature is that, FS becomes
+ * incompatible only if fast commit blocks are present in the FS. Since we
+ * clear the journal (and thus the fast commit blocks), we don't mark FS as
+ * incompatible. We also have a JBD2 incompat feature, which gets set when
+ * there are fast commit blocks present in the journal.
+ */
 #define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
 #define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
 
-- 
2.29.1.341.ge80a0c044ae-goog

