Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E8C2DD652
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 18:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgLQRgf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 12:36:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54742 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgLQRgf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 12:36:35 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:779a:3a80:1322:d34a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3C0D41F45D13;
        Thu, 17 Dec 2020 17:35:53 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     drosen@google.com, krisman@collabora.com, ebiggers@kernel.org,
        tytso@mit.edu, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v3 05/12] e2fsck: Add new problem for encoded name check
Date:   Thu, 17 Dec 2020 18:35:37 +0100
Message-Id: <20201217173544.52953-6-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
References: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

---
Changes in v3:
  - renamed problem identifier
  - fixed problem value

Changes in v2:
  - added in this version

 e2fsck/problem.c | 5 +++++
 e2fsck/problem.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index e79c853b..99522342 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -1805,6 +1805,11 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("Encrypted @E references @i %Di, which has a different encryption policy.\n"),
 	  PROMPT_CLEAR, 0, 0, 0, 0 },
 
+	/* Casefolded directory entry has illegal characters in its name */
+	{ PR_2_BAD_ENCODED_NAME,
+	  N_("@E has illegal UTF-8 characters in its name.\n"),
+	  PROMPT_FIX, 0, 0, 0, 0 },
+
 	/* Pass 3 errors */
 
 	/* Pass 3: Checking directory connectivity */
diff --git a/e2fsck/problem.h b/e2fsck/problem.h
index 4185e517..e2fbb597 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -1028,6 +1028,9 @@ struct problem_context {
 /* Encrypted directory contains file with different encryption policy */
 #define PR_2_INCONSISTENT_ENCRYPTION_POLICY	0x020052
 
+/* Encoded directory entry has illegal characters in its name */
+#define PR_2_BAD_ENCODED_NAME		0x020053
+
 /*
  * Pass 3 errors
  */
-- 
2.29.2

