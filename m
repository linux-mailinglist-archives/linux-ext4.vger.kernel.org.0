Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2998FFCF2
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 02:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKRBuU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Nov 2019 20:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfKRBuR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 17 Nov 2019 20:50:17 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49593206DB
        for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2019 01:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574041817;
        bh=LZlDGm5uvJGSNyiT4adb691+9iEkzuYU+UsDDFCXi8U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=e8PCtwsY68F4qr3WmDyYmzNwSFQoa3nFH233emmZtebX+8Lx7uU+W2OkKnaqtLG1S
         aXCtqvxSeIGQCkvk9Qw72bdX9gqP1nxpL9jpbFTI9PihmVR/VImUKYdyk+qzV4lVgR
         PKb5I+rX7moAi75ciiU9S2nCdoq/6bf2LHsp62eY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 6/6] chattr.1: say "cleared" instead of "reset"
Date:   Sun, 17 Nov 2019 17:48:52 -0800
Message-Id: <20191118014852.390686-7-ebiggers@kernel.org>
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

Setting a bit to 0 is normally called "clearing", not "resetting"; and
chattr.1 already says "clear" in some places.  Use "clear" consistently.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/chattr.1.in | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/misc/chattr.1.in b/misc/chattr.1.in
index 870397ae..66e791db 100644
--- a/misc/chattr.1.in
+++ b/misc/chattr.1.in
@@ -115,7 +115,7 @@ the blocks on disk.  It may not be removed using
 .BR chattr (1).
 .PP
 A file, directory, or symlink with the 'E' attribute set is encrypted by the
-filesystem.  This attribute may not be set or reset using
+filesystem.  This attribute may not be set or cleared using
 .BR chattr (1),
 although it can be displayed by
 .BR lsattr (1).
@@ -132,7 +132,7 @@ Only the superuser or a process possessing the CAP_LINUX_IMMUTABLE
 capability can set or clear this attribute.
 .PP
 The 'I' attribute is used by the htree code to indicate that a directory
-is being indexed using hashed trees.  It may not be set or reset using
+is being indexed using hashed trees.  It may not be set or cleared using
 .BR chattr (1),
 although it can be displayed by
 .BR lsattr (1).
@@ -146,7 +146,8 @@ attribute has no effect.  Only the superuser or a process possessing the
 CAP_SYS_RESOURCE capability can set or clear this attribute.
 .PP
 A file with the 'N' attribute set indicates that the file has data
-stored inline, within the inode itself. It may not be set or reset using
+stored inline, within the inode itself. It may not be set or cleared
+using
 .BR chattr (1),
 although it can be displayed by
 .BR lsattr (1).
@@ -193,7 +194,7 @@ A file with the 'V' attribute set has fs-verity enabled.  It cannot be
 written to, and the filesystem will automatically verify all data read
 from it against a cryptographic hash that covers the entire file's
 contents, e.g. via a Merkle tree.  This makes it possible to efficiently
-authenticate the file.  This attribute may not be set or reset using
+authenticate the file.  This attribute may not be set or cleared using
 .BR chattr (1),
 although it can be displayed by
 .BR lsattr (1).
-- 
2.24.0

