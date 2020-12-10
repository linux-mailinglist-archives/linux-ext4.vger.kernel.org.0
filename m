Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CFA2D5EF7
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 16:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbgLJPFX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 10:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388977AbgLJPFS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 10:05:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF1C0617A7
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 07:04:05 -0800 (PST)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:1626:c942:e0f1:c77c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6FE601F458F9;
        Thu, 10 Dec 2020 15:04:03 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     drosen@google.com, krisman@collabora.com, ebiggers@kernel.org,
        tytso@mit.edu, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH RESEND v2 05/12] e2fsck: add new problem for casefolded name check
Date:   Thu, 10 Dec 2020 16:03:46 +0100
Message-Id: <20201210150353.91843-6-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210150353.91843-1-arnaud.ferraris@collabora.com>
References: <20201210150353.91843-1-arnaud.ferraris@collabora.com>
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
2.29.2

