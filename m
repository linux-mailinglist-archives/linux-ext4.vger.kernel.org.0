Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26074FFCF0
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 02:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfKRBuR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Nov 2019 20:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfKRBuQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 17 Nov 2019 20:50:16 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB9F206D9
        for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2019 01:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574041816;
        bh=h48JF6zC+RuEcmC4Ygb5lgOa96+itviuBLBIaj8mdmI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P7bcsPObAnwYlInXSmYj41wZkAiE87TxucEPskNdPyNZs8afAHJlRPPKTyD7uzcGa
         EmE1spAt47b5VQi+tSL04BqlDSt3Ffepn79SUNycBNohd5BNmYvooY2RyjHip2EuKa
         h99957yk9TdMWP9kdizhefWAbNBD8yac9vxsvZZk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/6] chattr.1: document the verity attribute
Date:   Sun, 17 Nov 2019 17:48:47 -0800
Message-Id: <20191118014852.390686-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191118014852.390686-1-ebiggers@kernel.org>
References: <20191118014852.390686-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document the verity file attribute ('V').

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/chattr.1.in | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/misc/chattr.1.in b/misc/chattr.1.in
index 1c9e8964..2122a13e 100644
--- a/misc/chattr.1.in
+++ b/misc/chattr.1.in
@@ -52,7 +52,8 @@ The following attributes are read-only, and may be listed by
 but not modified by chattr:
 encrypted (E),
 indexed directory (I),
-and inline data (N).
+inline data (N),
+and verity (V).
 .PP
 Not all flags are supported or utilized by all filesystems; refer to
 filesystem-specific man pages such as
@@ -189,6 +190,15 @@ saved.  This allows the user to ask for its undeletion.  Note: please
 make sure to read the bugs and limitations section at the end of this
 document.
 .PP
+A file with the 'V' attribute set has fs-verity enabled.  It cannot be
+written to, and the filesystem will automatically verify all data read
+from it against a cryptographic hash that covers the entire file's
+contents, e.g. via a Merkle tree.  This makes it possible to efficiently
+authenticate the file.  This attribute may not be set or reset using
+.BR chattr (1),
+although it can be displayed by
+.BR lsattr (1).
+.PP
 .SH AUTHOR
 .B chattr
 was written by Remy Card <Remy.Card@linux.org>.  It is currently being
-- 
2.24.0

