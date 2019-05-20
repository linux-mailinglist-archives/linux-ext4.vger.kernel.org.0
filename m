Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E31FB22BFD
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2019 08:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfETGV7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 20 May 2019 02:21:59 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25413 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729731AbfETGV7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 May 2019 02:21:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558333310; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Qi8Ke3hXenm7mkIFnPEXRBcsqTRg63UtE+tU1UG8TeXo2S0YUE1g3hOd++ZY2DLWyfOyR0s2qUUMgMbMHr7gn/YzqC/0/qG5BMI2h35WxYLmffzJlBNkhJ/qXvhQWE3+DaxDrAiDBwKgzvgq3fRXDvpyKQBLGbPSLpoIw7CqD9w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558333310; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=CvNdAIFzJDVh9ev9Apw2K5bCI0w18YDmtc8wtTiOJwU=; 
        b=hPo5S0sJCuTnewIBVJpOHMYWWJX0n38YDpBv6/Z5DK8GWireWzLQ0vIDjqVeeueDLi9rbu4iqoOuqTQ9VhbimtvXeihagAXaLfK7lOLSH/7NLjxRrz9QtK/moeo+zJYORIqt42G+7FTalQdtdThBM7m70YtZ7I9Njtt+Ig2ojH0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1558333306062973.5440755672457; Mon, 20 May 2019 14:21:46 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com, corbet@lwn.net
Cc:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190520062116.28400-1-cgxu519@zoho.com.cn>
Subject: [PATCH] doc: ext2: update description of quota options for ext2
Date:   Mon, 20 May 2019 14:21:16 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext2 support user/group disk quota by specifying
usrquota/grpquota option on mount, so fix the
description in the doc properly.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 Documentation/filesystems/ext2.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext2.txt b/Documentation/filesystems/ext2.txt
index a19973a4dd1e..94c2cf0292f5 100644
--- a/Documentation/filesystems/ext2.txt
+++ b/Documentation/filesystems/ext2.txt
@@ -57,7 +57,13 @@ noacl				Don't support POSIX ACLs.
 
 nobh				Do not attach buffer_heads to file pagecache.
 
-grpquota,noquota,quota,usrquota	Quota options are silently ignored by ext2.
+quota, usrquota			Enable user disk quota support
+				(requires CONFIG_QUOTA).
+
+grpquota			Enable group disk quota support
+				(requires CONFIG_QUOTA).
+
+noquota option ls silently ignored by ext2.
 
 
 Specification
-- 
2.20.1



