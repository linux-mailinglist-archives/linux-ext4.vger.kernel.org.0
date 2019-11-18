Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB556FFCF1
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 02:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfKRBuS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Nov 2019 20:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfKRBuR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 17 Nov 2019 20:50:17 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18980206D9
        for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2019 01:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574041817;
        bh=l+xL4RuRZUr/qi6KpRTmvEftCVSHa1g/fAE74XJ5VwI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=zrykNCDHBSnW62g4EeCHR6vNnFzK6salSEEezEvFZuJpU4Rk+MrGKUTUmCVIbjIfm
         h3aAq4gBn5pj22IXJn7g0DLbG1DrbFLm9HRE0k2k+3a/+fFTqAYwdQw1CqBGjiXqlo
         zOAbMBre86ZCC7NOfKNaUc23ARi8/oppxeyiskg8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 5/6] chattr.1: clarify that ext4 doesn't support tail-merging either
Date:   Sun, 17 Nov 2019 17:48:51 -0800
Message-Id: <20191118014852.390686-6-ebiggers@kernel.org>
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

This old text was never updated to mention ext4 in addition to ext2 and
ext3.  Do so now.  Also don't bother to mention old unmerged patches.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/chattr.1.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc/chattr.1.in b/misc/chattr.1.in
index cc751fe8..870397ae 100644
--- a/misc/chattr.1.in
+++ b/misc/chattr.1.in
@@ -171,8 +171,8 @@ A file with the 't' attribute will not have a partial block fragment at
 the end of the file merged with other files (for those filesystems which
 support tail-merging).  This is necessary for applications such as LILO
 which read the filesystem directly, and which don't understand tail-merged
-files.  Note: As of this writing, the ext2 or ext3 filesystems do not
-(yet, except in very experimental patches) support tail-merging.
+files.  Note: As of this writing, the ext2, ext3, and ext4 filesystems do
+not support tail-merging.
 .PP
 A directory with the 'T' attribute will be deemed to be the top of
 directory hierarchies for the purposes of the Orlov block allocator.
-- 
2.24.0

