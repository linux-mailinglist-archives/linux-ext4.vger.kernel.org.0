Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7430E2A8DD3
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgKFD70 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKFD7Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:25 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A7C0613D2
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 10so103339pfp.5
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGYMhXubDnTSMiVCcmAEDBpCZMGqDU2RYbjNdOd1vmw=;
        b=dKXVnW3PTTStwwwm7pyLhH8zvMjd4wJfV/KCWKnZwpnH2dVRmG7aeWf3oDAZ5Q1dvB
         lfpbnv/YlPScxWCeFYGZl766sunNIQXSVtiGtJvu/wnfV6Virf7VG6mcGGWE3r7IBzUN
         IHVLJh20X9qho6nihNW1XErDtpWwUVZ2zRv6uWmET5PqNwcfXpo0IUhKvFAq6hsiYUJ6
         GJFtf9vLa8r+ZHewFbXv+9kYpMw8QAUBTa7KjrP/DE+sndhIfc5WcEs/xO2ynaeO4jGP
         R41Dbl3Pg9nR42zjYkegyWgxD11jzjHbzJKCukHx+X1CWZUuz6ZcKVPLLPheKPrOMjcz
         7bkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGYMhXubDnTSMiVCcmAEDBpCZMGqDU2RYbjNdOd1vmw=;
        b=A571s8WBkSSQbONM20fEjZLyeU7nC6Cr4GvLzx162PAB+oVPzVh6MMcH9sVVE8TG80
         /Qq1DlIbN/kKCTTii0WkE0/eyLhRt6bJyAoC2xixakxD744M3GgS8MPDI32rJbQwpzYh
         0q5O3kQpmayY8J5BSVGLpRu6e7cY1E1zNwHoENlp6rAf4kOqUIKH4TTzjm3y9V0c52Rb
         QZ4/o/x0Gnm4ln8jxZSYLaudlLKnfugyFsTK2vLiwQuAsxmDIu5Tli5gbjVPGuK2L2Mv
         O2cnQ9qzhhq9VnjRpN/+aO9nEypXiMuKVQ5D0VocvXX7FT2OzkVSGcZF074gYv7arg4/
         Ss9g==
X-Gm-Message-State: AOAM531RmHpq7lZ7WXUMpRx+zzqrK13Ab03uUL52QwgEIKbBRs7hko7M
        ftenlXq0JPD2irXPWT7Qa1kHRvY/UKw=
X-Google-Smtp-Source: ABdhPJxnPYa6xEem40gmQR+ahzYbJ8qfJxrrK/2nO/zncV4FX8xtMg7hPPubPdUczu1NLAp8r9SHig==
X-Received: by 2002:a17:90a:ef8b:: with SMTP id m11mr240982pjy.161.1604635163504;
        Thu, 05 Nov 2020 19:59:23 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:22 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 01/22] ext4: describe fast_commit feature flags
Date:   Thu,  5 Nov 2020 19:58:50 -0800
Message-Id: <20201106035911.1942128-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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

