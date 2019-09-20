Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30FE9B9915
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 23:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390860AbfITVbW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 17:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729997AbfITVbV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 17:31:21 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79822080F
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569015080;
        bh=mxcbvMl1GDdVaogVkLdFb9r/c6Cl4P3ePKpgjIVY704=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bGnv8qGR348b4tZjasOsPIge7AK3/Y/jytiClGxdPWCvNPse7JJbTjas64Ux32yGH
         4m94yHQcOO0T2zZDRHM2a7UfR6JpWQHfI3sm0NeEzmcNm6ifO0fmfSK/AkeTX0orjH
         tJ2w6f37wgQI2Yqd1cfCaeo4kh47xYmf3ASGkw6A=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 4/6] ext4.5: tweak the documentation for the encrypt feature
Date:   Fri, 20 Sep 2019 14:29:52 -0700
Message-Id: <20190920212954.205789-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190920212954.205789-1-ebiggers@kernel.org>
References: <20190920212954.205789-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Try to make it clearer that enabling 'encrypt' just enables *support*
for encryption; it doesn't actually encrypt anything by itself.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/ext4.5.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc/ext4.5.in b/misc/ext4.5.in
index 627c0dad..1db61a5f 100644
--- a/misc/ext4.5.in
+++ b/misc/ext4.5.in
@@ -96,9 +96,9 @@ extended attributes per file.
 .TP
 .B encrypt
 .br
-This ext4 feature provides file-system level encryption of data blocks
-and file names.  The inode metadata (timestamps, file size, user/group
-ownership, etc.) is
+Enables support for file-system level encryption of data blocks and file
+names.  The inode metadata (timestamps, file size, user/group ownership,
+etc.) is
 .I not
 encrypted.
 .IP
-- 
2.23.0.351.gc4317032e6-goog

