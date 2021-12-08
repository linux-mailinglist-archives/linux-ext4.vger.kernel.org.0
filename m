Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B009C46CE84
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Dec 2021 08:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbhLHHy4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Dec 2021 02:54:56 -0500
Received: from omta001.cacentral1.a.cloudfilter.net ([3.97.99.32]:56508 "EHLO
        omta001.cacentral1.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231739AbhLHHyz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Dec 2021 02:54:55 -0500
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id ubGWmS58QlW5qurjYm43H2; Wed, 08 Dec 2021 07:51:24 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id urjWmyM4flt4QurjXmHmJK; Wed, 08 Dec 2021 07:51:24 +0000
X-Authority-Analysis: v=2.4 cv=F+dEy4tN c=1 sm=1 tr=0 ts=61b063fc
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=FKBdsoCbyCQ-z-6tLEAA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] e2fsck: map PROMPT_* values to prompt messages
Date:   Wed,  8 Dec 2021 00:51:12 -0700
Message-Id: <20211208075112.85649-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLyDCPKFf/L13tfpfi9E3K1HzbZ8Rdm78BHr7o8noXHX5VXa3SzZvTdUqUWpNU0WnvGINKDf4KI+668lNUitZ32ftD/i39O/CBVeJju7/KaIPBK8ohHU
 Mf/NJ0Ar8882RLvVxGqSPHeo+Q1zGqLGvy1oR6agEMKmqehaYDf7p/r4dS6MGmHheHpMnpJaUICqesjq4dfcY6B3UMt3MK/igEzWpSE3luq63Rv/N+trl0Fe
 CSuvAi//Mr89FJjVuD76Cw==
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It isn't totally clear when searching the code for PROMPT_*
constants from problem codes where these messages come from.
Similarly, there isn't a direct mapping from the prompt string
to the constant.

Add comments that make this mapping more clear.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 e2fsck/problem.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index 757b5d56..2d02468c 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -50,29 +50,29 @@
  * to fix a problem.
  */
 static const char *prompt[] = {
-	N_("(no prompt)"),	/* 0 */
-	N_("Fix"),		/* 1 */
-	N_("Clear"),		/* 2 */
-	N_("Relocate"),		/* 3 */
-	N_("Allocate"),		/* 4 */
-	N_("Expand"),		/* 5 */
-	N_("Connect to /lost+found"), /* 6 */
-	N_("Create"),		/* 7 */
-	N_("Salvage"),		/* 8 */
-	N_("Truncate"),		/* 9 */
-	N_("Clear inode"),	/* 10 */
-	N_("Abort"),		/* 11 */
-	N_("Split"),		/* 12 */
-	N_("Continue"),		/* 13 */
-	N_("Clone multiply-claimed blocks"), /* 14 */
-	N_("Delete file"),	/* 15 */
-	N_("Suppress messages"),/* 16 */
-	N_("Unlink"),		/* 17 */
-	N_("Clear HTree index"),/* 18 */
-	N_("Recreate"),		/* 19 */
-	N_("Optimize"),		/* 20 */
-	N_("Clear flag"),	/* 21 */
-	"",			/* 22 */
+	N_("(no prompt)"),			/* PROMPT_NONE		=  0 */
+	N_("Fix"),				/* PROMPT_FIX		=  1 */
+	N_("Clear"),				/* PROMPT_CLEAR		=  2 */
+	N_("Relocate"),				/* PROMPT_RELOCATE	=  3 */
+	N_("Allocate"),				/* PROMPT_CREATE	=  4 */
+	N_("Expand"),				/* PROMPT_EXPAND	=  5 */
+	N_("Connect to /lost+found"),		/* PROMPT_CONNECT	=  6 */
+	N_("Create"),				/* PROMPT_CREATE	=  7 */
+	N_("Salvage"),				/* PROMPT_SALVAGE	=  8 */
+	N_("Truncate"),				/* PROMPT_TRUNCATE	=  9 */
+	N_("Clear inode"),			/* PROMPT_CLEAR_INODE	= 10 */
+	N_("Abort"),				/* PROMPT_ABORT		= 11 */
+	N_("Split"),				/* PROMPT_SPLIT		= 12 */
+	N_("Continue"),				/* PROMPT_CONTINUE	= 13 */
+	N_("Clone multiply-claimed blocks"),	/* PROMPT_CLONE		= 14 */
+	N_("Delete file"),			/* PROMPT_DELETE	= 15 */
+	N_("Suppress messages"),		/* PROMPT_SUPPRESS	= 16 */
+	N_("Unlink"),				/* PROMPT_UNLINK	= 17 */
+	N_("Clear HTree index"),		/* PROMPT_CLEAR_HTREE	= 18 */
+	N_("Recreate"),				/* PROMPT_RECREATE	= 19 */
+	N_("Optimize"),				/* PROMPT_OPTIMIZE	= 20 */
+	N_("Clear flag"),			/* PROMPT_CLEAR_FLAG	= 21 */
+	"",					/* PROMPT_NULL		= 22 */
 };
 
 /*
-- 
2.25.1

