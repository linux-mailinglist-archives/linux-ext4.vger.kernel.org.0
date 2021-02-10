Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F12316312
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Feb 2021 11:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhBJKBR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Feb 2021 05:01:17 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:41548 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhBJJ64 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Feb 2021 04:58:56 -0500
Received: from ios.cs.uni-dortmund.de (ios.cs.uni-dortmund.de [129.217.43.100])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 11A9vewk028502
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 10:57:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1612951063;
        bh=HPi4PR1X2ZJY9+JjYLzNxyQAsDi3SUIOPqfv2OzAdSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EPp/sQQti/wmW19ZH1/F9Nf5L5Ny4s2ZvcsbizTdVHmUmoFKAbUR/ynwKEbrKi1hR
         jq4QpWdBFNj5IqmvjEXLN6/85RWMX70aL5q+ol4kb1rmE8H9eEHFOAGvgMdO9XWXAG
         D3rSbVcVIxfQI4CrPfBoyisdSG1plOYdH1Zj8JQU=
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Updated locking documentation for transaction_t
Date:   Wed, 10 Feb 2021 10:57:39 +0100
Message-Id: <20210210095740.54881-2-alexander.lochmann@tu-dortmund.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Some members of transaction_t are allowed to be read without
any lock being held if consistency doesn't matter.
Based on LockDoc's findings, we extended the locking
documentation of those members.
Each one of them is marked with a short comment:
"no lock for quick racy checks".

Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
---
 include/linux/jbd2.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 99d3cd051ac3..18f77d9b1745 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -594,18 +594,18 @@ struct transaction_s
 	 */
 	unsigned long		t_log_start;
 
-	/* Number of buffers on the t_buffers list [j_list_lock] */
+	/* Number of buffers on the t_buffers list [j_list_lock, no lock for quick racy checks] */
 	int			t_nr_buffers;
 
 	/*
 	 * Doubly-linked circular list of all buffers reserved but not yet
-	 * modified by this transaction [j_list_lock]
+	 * modified by this transaction [j_list_lock, no lock for quick racy checks]
 	 */
 	struct journal_head	*t_reserved_list;
 
 	/*
 	 * Doubly-linked circular list of all metadata buffers owned by this
-	 * transaction [j_list_lock]
+	 * transaction [j_list_lock, no lock for quick racy checks]
 	 */
 	struct journal_head	*t_buffers;
 
@@ -631,7 +631,7 @@ struct transaction_s
 	/*
 	 * Doubly-linked circular list of metadata buffers being shadowed by log
 	 * IO.  The IO buffers on the iobuf list and the shadow buffers on this
-	 * list match each other one for one at all times. [j_list_lock]
+	 * list match each other one for one at all times. [j_list_lock, no lock for quick racy checks]
 	 */
 	struct journal_head	*t_shadow_list;
 
-- 
2.20.1

