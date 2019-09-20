Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF607B9912
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 23:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389932AbfITVbV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 17:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389460AbfITVbV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 17:31:21 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32ED2208C3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569015081;
        bh=oTUYbLrG6Vu8sjSve+NxU8IwPYokjqHXVSHgKbyi51k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=d1dJQJ7fInPHthnJkEFkqizCIAPIyCYtjMZesOQPDcRWJoz5Se9aPm7drw0iA1yX5
         Rf87bDhD2dTro7KIylAXNOx4DzIPeLJhU73IN19uY84iXWphbsCryzcsgPjueDRnIX
         8E7EQPiZiVd/x2Ty+UQGIfFqqysMIEAI3gBsRHZg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 6/6] tune2fs.8: tweak the documentation for the encrypt feature
Date:   Fri, 20 Sep 2019 14:29:54 -0700
Message-Id: <20190920212954.205789-7-ebiggers@kernel.org>
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
 misc/tune2fs.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index f7c7d42d..74eebb6a 100644
--- a/misc/tune2fs.8.in
+++ b/misc/tune2fs.8.in
@@ -550,7 +550,7 @@ extended attributes per file.
 currently only supports setting this filesystem feature.
 .TP
 .B encrypt
-Enable file system level encryption.
+Enable support for file system level encryption.
 .B Tune2fs
 currently only supports setting this filesystem feature.
 .TP
-- 
2.23.0.351.gc4317032e6-goog

