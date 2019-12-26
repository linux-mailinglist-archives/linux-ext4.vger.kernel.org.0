Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D219A12AD41
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfLZPkX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 10:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfLZPkX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 26 Dec 2019 10:40:23 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985F8206A4
        for <linux-ext4@vger.kernel.org>; Thu, 26 Dec 2019 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577374822;
        bh=U52JRgNxFt6kzbBceCrmFR55pAOS2KvvO+IkEw+2shY=;
        h=From:To:Subject:Date:From;
        b=JBY2Y1KiPR7Y6mn1cILHY34OqK/gEIyjxPoBz5yCTYYi+xhGjn6KFDNDtwHcGWUzM
         eOlfjpCZKXk0+I/iybyX40iCbFGPxPgcGuMTVzunCnj7ESOG1KDuU8fXtU+pszKqiV
         tON0Smg/wwC6Fq2FQ5zkjjtAeqwYtCgkdW67/YNg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] docs: ext4.rst: add encryption and verity to features list
Date:   Thu, 26 Dec 2019 09:40:07 -0600
Message-Id: <20191226154007.4569-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Mention encryption and verity in the ext4 features list.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/admin-guide/ext4.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
index 9bc93f0ce0c9..9443fcef1876 100644
--- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -92,6 +92,8 @@ Currently Available
 * efficient new ordered mode in JBD2 and ext4 (avoid using buffer head to force
   the ordering)
 * Case-insensitive file name lookups
+* file-based encryption support (fscrypt)
+* file-based verity support (fsverity)
 
 [1] Filesystems with a block size of 1k may see a limit imposed by the
 directory hash tree having a maximum depth of two.
-- 
2.24.1

