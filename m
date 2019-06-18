Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1D24A410
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jun 2019 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfFROb1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Jun 2019 10:31:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34295 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFROb1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Jun 2019 10:31:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so7817232pgn.1
        for <linux-ext4@vger.kernel.org>; Tue, 18 Jun 2019 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7vNl+QpgeqILPU7ttqIKXZfgU4Hj37fGfAcLb0DSlhs=;
        b=IEqwOE6n3Ae8lWXZfTcctbK+gaRj2opo7ah3sklQd5Wn9GTnfJFM2JbDnORwZEoq48
         qhR5or/O/xr2LDwwW5CpItVAAlRBETsENe5tg6NI1whgL+5oW07A53cP1SEYng1M9dW3
         0BT9F9rZH/jHFbxndD3dhhkn0Xk9bKCQCXP1StnrSgX7XQ8NVSUCoZtcYOSEzgd1VhSN
         495nWwghd+eFwNAgj+s+ixHiNPrKQAhhMGS4ubR1XU3w7R5ZrivL81oxUIKxOH2IKRWx
         Dyx/c5g327qOo0B/YQsEq/iZ/6MuNgr17j1IMTpR17sWHIC6E6Nl9s1DMcyZxuEZEgDB
         Pe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7vNl+QpgeqILPU7ttqIKXZfgU4Hj37fGfAcLb0DSlhs=;
        b=gJVU2y1ipNHl21bjF6x1uRBtoF7XzwdPjDzJhNxCypXZXpNZQbGz+Kva6ul0bTVMPP
         QUcqahi8ngvAzoWD/HAKNvpd60NkOUwyjBryVXqd6371QKnTjhcIDFaJMoJsdNbSlH2n
         6yEbklqQCPvJX/b6NTZ9JdsvUP+bVz6CjABco23boJnwMYIr/72Up18vSZqzBj/xgZoU
         RxdxXsUgflwvwPyuBy408Miaf553vvpoTJAtIH2mKYPyALbQgQD/KlbWM1VR20Rg9u9g
         1KYOFh+K4t17m/ajURTqn9zqsWcoE8l+CyU3HgD6DbgJg1L2HuPe5E2VrLTqNnXHTd57
         byYA==
X-Gm-Message-State: APjAAAWyK+iGf2mW9k2nYvRKc0BZB1iRdEFke/xvxidx7MU+XzPd8toL
        oO5qjhjwxf49gJ3pOY+sT/nf8wwT
X-Google-Smtp-Source: APXvYqxVpskqjyuS9q0VWqTyqZe3BAkMNqoX52Eqz+8+TuR8582drwQ955SdvC3T6RNe5v8K0TPRVw==
X-Received: by 2002:a63:1d53:: with SMTP id d19mr2997544pgm.152.1560868286661;
        Tue, 18 Jun 2019 07:31:26 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id g13sm14957637pfi.93.2019.06.18.07.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:31:26 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     arnd@arndb.de
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: [PATCH 08/16] ext4: Initialize timestamps limits
Date:   Tue, 18 Jun 2019 07:31:02 -0700
Message-Id: <20190618143110.6720-8-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618143110.6720-1-deepa.kernel@gmail.com>
References: <20190618143110.6720-1-deepa.kernel@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4 has different overflow limits for max filesystem
timestamps based on the extra bytes available.

The timestamp limits are calculated according to the
encoding table in
a4dad1ae24f85i(ext4: Fix handling of extended tv_sec):

* extra  msb of                         adjust for signed
* epoch  32-bit                         32-bit tv_sec to
* bits   time    decoded 64-bit tv_sec  64-bit tv_sec      valid time range
* 0 0    1    -0x80000000..-0x00000001  0x000000000   1901-12-13..1969-12-31
* 0 0    0    0x000000000..0x07fffffff  0x000000000   1970-01-01..2038-01-19
* 0 1    1    0x080000000..0x0ffffffff  0x100000000   2038-01-19..2106-02-07
* 0 1    0    0x100000000..0x17fffffff  0x100000000   2106-02-07..2174-02-25
* 1 0    1    0x180000000..0x1ffffffff  0x200000000   2174-02-25..2242-03-16
* 1 0    0    0x200000000..0x27fffffff  0x200000000   2242-03-16..2310-04-04
* 1 1    1    0x280000000..0x2ffffffff  0x300000000   2310-04-04..2378-04-22
* 1 1    0    0x300000000..0x37fffffff  0x300000000   2378-04-22..2446-05-10

Note that the time limits are not correct for deletion times.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
---
 fs/ext4/ext4.h  |  4 ++++
 fs/ext4/super.c | 16 ++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1cb67859e051..3f13cf12ae7f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1631,6 +1631,10 @@ static inline void ext4_clear_state_flags(struct ext4_inode_info *ei)
 
 #define EXT4_GOOD_OLD_INODE_SIZE 128
 
+#define EXT4_EXTRA_TIMESTAMP_MAX	(((s64)1 << 34) - 1  + S32_MIN)
+#define EXT4_NON_EXTRA_TIMESTAMP_MAX	S32_MAX
+#define EXT4_TIMESTAMP_MIN		S32_MIN
+
 /*
  * Feature set definitions
  */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4079605d437a..0357acdeb6d3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4035,8 +4035,20 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			       sbi->s_inode_size);
 			goto failed_mount;
 		}
-		if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE)
-			sb->s_time_gran = 1 << (EXT4_EPOCH_BITS - 2);
+		/* i_atime_extra is the last extra field available for [acm]times in
+		 * struct ext4_inode. Checking for that field should suffice to ensure
+		 * we have extra spaces for all three.
+		 */
+		if (sbi->s_inode_size >= offsetof(struct ext4_inode, i_atime_extra) +
+			sizeof(((struct ext4_inode *)0)->i_atime_extra)) {
+			sb->s_time_gran = 1;
+			sb->s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
+		} else {
+			sb->s_time_gran = 0;
+			sb->s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
+		}
+
+		sb->s_time_min = EXT4_TIMESTAMP_MIN;
 	}
 
 	sbi->s_desc_size = le16_to_cpu(es->s_desc_size);
-- 
2.17.1

