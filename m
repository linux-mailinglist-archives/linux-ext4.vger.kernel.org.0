Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB52C6A58
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 18:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbgK0RBj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 12:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731882AbgK0RBj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Nov 2020 12:01:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14193C0613D1
        for <linux-ext4@vger.kernel.org>; Fri, 27 Nov 2020 09:01:39 -0800 (PST)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:5a64:74b8:f3be:d972])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6D4C71F46500;
        Fri, 27 Nov 2020 17:01:37 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 05/12] e2fsck: add new problem for casefolded name check
Date:   Fri, 27 Nov 2020 18:01:09 +0100
Message-Id: <20201127170116.197901-6-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
References: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

---
Changes in v2:
  - added in this version

 e2fsck/problem.c | 5 +++++
 e2fsck/problem.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index e79c853b..2b596303 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -1805,6 +1805,11 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("Encrypted @E references @i %Di, which has a different encryption policy.\n"),
 	  PROMPT_CLEAR, 0, 0, 0, 0 },
 
+	/* Casefolded directory entry has illegal characters in its name */
+	{ PR_2_BAD_CASEFOLDED_NAME,
+	  N_("@E has illegal UTF-8 characters in its name.\n"),
+	  PROMPT_FIX, 0, 0, 0, 0 },
+
 	/* Pass 3 errors */
 
 	/* Pass 3: Checking directory connectivity */
diff --git a/e2fsck/problem.h b/e2fsck/problem.h
index 4185e517..a8806fd4 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -1028,6 +1028,9 @@ struct problem_context {
 /* Encrypted directory contains file with different encryption policy */
 #define PR_2_INCONSISTENT_ENCRYPTION_POLICY	0x020052
 
+/* Casefolded directory entry has illegal characters in its name */
+#define PR_2_BAD_CASEFOLDED_NAME		0x0200053
+
 /*
  * Pass 3 errors
  */
-- 
2.28.0

