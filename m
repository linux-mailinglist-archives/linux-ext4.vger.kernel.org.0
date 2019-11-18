Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475C3FFCEE
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 02:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfKRBuR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Nov 2019 20:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfKRBuR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 17 Nov 2019 20:50:17 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACCC3206DC
        for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2019 01:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574041816;
        bh=neMjL0YcChRriEwaM1kJ1O/RsihT5jHROrkyG7J2wNg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lAhPuMxv2fa6wwFOyJOUD3vJw8quWt7/QP4796ijROhJy2POFuPSzLH0lJ3B0bQMD
         U8HUf9pXyrOA6Bq8AKA+gTsHd9nhQayK+km6xzbzd9ZI6LRDIraUXybcdnJkcAkOvX
         vEiexhPyssnv+rtRDxx8GAQ9g9jrL4PB7aJ0GCUM=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 3/6] chattr.1: add casefold attribute to mode string
Date:   Sun, 17 Nov 2019 17:48:49 -0800
Message-Id: <20191118014852.390686-4-ebiggers@kernel.org>
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

When the casefold attribute ('F') was added to the chattr man page, it
was forgotten to add it to the mode string.  Add it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/chattr.1.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/chattr.1.in b/misc/chattr.1.in
index 18b316e3..1baacf17 100644
--- a/misc/chattr.1.in
+++ b/misc/chattr.1.in
@@ -23,7 +23,7 @@ chattr \- change file attributes on a Linux file system
 .B chattr
 changes the file attributes on a Linux file system.
 .PP
-The format of a symbolic mode is +-=[aAcCdDeijPsStTu].
+The format of a symbolic mode is +-=[aAcCdDeFijPsStTu].
 .PP
 The operator '+' causes the selected attributes to be added to the
 existing attributes of the files; '-' causes them to be removed; and '='
-- 
2.24.0

