Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2F4566B1
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 00:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhKSAA7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Nov 2021 19:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhKSAA6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Nov 2021 19:00:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA37C061748
        for <linux-ext4@vger.kernel.org>; Thu, 18 Nov 2021 15:57:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 40C031F4709C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637279876; bh=NcVyMlBPKgXYpOVhQDPfsPDkKy9i3A0eWmNha6N06ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZNaO+bKd35Q5w0KbNyDPh2TvukDLxZrrGWMq1S37lT71mhCeiKwONECH0u7/srdn
         6RdirCmTD4VNg47Z486ATCPZlmQy45Q0TeUZy3TQG6f/s6fMUoySY+4o7amINIyN1E
         1r7IcAZBGVN5NqIXr7trgObPNoN07mfhHG4FWGg5pnF1uPZkIW2IE32mTNBwQhShwj
         8yC5QjY6drgVV1pUmlwfgdvmzV3uGBLyr2W+W3jrhQ3WtRq64SWZKpx/vNImAFvdA4
         lK4nufJnKO5B8o159CzsvYExO9Ga9IqtX34EZKf6S6p5L87luntIc+dacYMD06OVh1
         4wdFpQOLTfb+A==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     pvorel@suse.cz, jack@suse.com, amir73il@gmail.com,
        repnop@google.com
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com, ltp@lists.linux.it,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v4 1/9] syscalls: fanotify: Add macro to require specific mark types
Date:   Thu, 18 Nov 2021 18:57:36 -0500
Message-Id: <20211118235744.802584-2-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
References: <20211118235744.802584-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Like done for init flags and event types, and a macro to require a
specific mark type.

Reviewed-by: Matthew Bobrowski <repnop@google.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index c91162d97a89..b9f430fe0c35 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -399,4 +399,9 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
 	return rval;
 }
 
+#define REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL(mark_type) do { \
+	fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
+				    fanotify_mark_supported_by_kernel(mark_type)); \
+} while (0)
+
 #endif /* __FANOTIFY_H__ */
-- 
2.33.0

