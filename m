Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E4EFFCED
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 02:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfKRBuR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Nov 2019 20:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfKRBuR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 17 Nov 2019 20:50:17 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E898206DB
        for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2019 01:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574041816;
        bh=Kg9I8kZdqPhYyGysdi2wGdJoHP91ZCrC4l45zYHw6yc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nSMEIXB1z5U0aZH4Uwk0I+YzRiJNCmsnagS8WOG2kK117YKSbumIKByNFDXa2oxdE
         LB2F6ECEq/ljkccycww+35pSxjKvW9xX39RQjOLREoqeJrl1erw2KhoDk217yGcXWx
         /Lbg5ywSLZLcBDELkMyPbVFD2Ox+JJcMVomobH38=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/6] chattr.1: adjust documentation for encryption attribute
Date:   Sun, 17 Nov 2019 17:48:48 -0800
Message-Id: <20191118014852.390686-3-ebiggers@kernel.org>
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

Adjust the documentation for the encryption attribute ('E') to clarify
that encryption isn't experimental anymore and isn't restricted to
regular files, and that the encryption is done by the filesystem.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/chattr.1.in | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/misc/chattr.1.in b/misc/chattr.1.in
index 2122a13e..18b316e3 100644
--- a/misc/chattr.1.in
+++ b/misc/chattr.1.in
@@ -114,9 +114,8 @@ The 'e' attribute indicates that the file is using extents for mapping
 the blocks on disk.  It may not be removed using
 .BR chattr (1).
 .PP
-The 'E' attribute is used by the experimental encryption patches to
-indicate that the file has been encrypted.  It may not be
-set or reset using
+A file, directory, or symlink with the 'E' attribute set is encrypted by the
+filesystem.  This attribute may not be set or reset using
 .BR chattr (1),
 although it can be displayed by
 .BR lsattr (1).
-- 
2.24.0

