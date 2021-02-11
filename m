Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD10A318CCA
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 15:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhBKN5t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 08:57:49 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:61956 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhBKNzw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 08:55:52 -0500
Received: from ios.cs.uni-dortmund.de (ios.cs.uni-dortmund.de [129.217.43.100])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 11BDsTww027233
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:54:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1613051672;
        bh=gjOUwmU1t+wKdLBsPCfx+1FQK3F1VEP+faTt8VFJuks=;
        h=From:To:Cc:Subject:Date;
        b=J2kc+h7IwBue0pyKD5g3D5fOhDM3drVXAeknfJBJsPIwLtFm12gnG/OqTQ02vRLh2
         lx4+bWZ0Ldcevm/UIYZUn5Yun6oQ+jY0nprMUdI7wo3cTc0PlTjcs0AF1VXXjtxSKS
         s5wrg25DgIr4Dtasm/nYrrvhSgd7PkRyiMM6QpvE=
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Updated locking documentation for transaction_t
Date:   Thu, 11 Feb 2021 14:54:23 +0100
Message-Id: <20210211135424.42826-1-alexander.lochmann@tu-dortmund.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Some members of transaction_t are allowed to be read without
any lock being held if accessed from the correct context.
We used LockDoc's findings to determine those members.
Each member of them is marked with a short comment:
"no lock needed for jbd2 thread".

Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
---
 include/linux/jbd2.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 99d3cd051ac3..1f19d19f6435 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -594,18 +594,18 @@ struct transaction_s
 	 */
 	unsigned long		t_log_start;
 
-	/* Number of buffers on the t_buffers list [j_list_lock] */
+	/* Number of buffers on the t_buffers list [j_list_lock, no locks needed for jbd2 thread] */
 	int			t_nr_buffers;
 
 	/*
 	 * Doubly-linked circular list of all buffers reserved but not yet
-	 * modified by this transaction [j_list_lock]
+	 * modified by this transaction [j_list_lock, no locks needed for jbd2 thread]
 	 */
 	struct journal_head	*t_reserved_list;
 
 	/*
 	 * Doubly-linked circular list of all metadata buffers owned by this
-	 * transaction [j_list_lock]
+	 * transaction [j_list_lock, no locks needed for jbd2 thread]
 	 */
 	struct journal_head	*t_buffers;
 
@@ -631,7 +631,7 @@ struct transaction_s
 	/*
 	 * Doubly-linked circular list of metadata buffers being shadowed by log
 	 * IO.  The IO buffers on the iobuf list and the shadow buffers on this
-	 * list match each other one for one at all times. [j_list_lock]
+	 * list match each other one for one at all times. [j_list_lock, no locks needed for jbd2 thread]
 	 */
 	struct journal_head	*t_shadow_list;
 
-- 
2.20.1

