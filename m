Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E625112DACE
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 19:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfLaSGE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Dec 2019 13:06:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfLaSGD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 31 Dec 2019 13:06:03 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F178C206E6
        for <linux-ext4@vger.kernel.org>; Tue, 31 Dec 2019 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577815563;
        bh=5UURX5NMJixnuBVv9SIwM/xs8xOKxaUpusObUdOSWSk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mYI5lhgg+mL81vC1o7eGgMxfa/HK+61U+Y+Rk9FguyXYTbNClgvl/aFRneY12ByHz
         dvayy4Q1MQhsHURyG7egqUOO7hHCFfH5K8+H46NF8+cyn5fUH1x28fz8zZA4elbipH
         XXS3Gj9gTS+HtQYQd+yeyezKGqNaMg171q+5kSN0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 6/8] ext4: remove obsolete comment from ext4_can_extents_be_merged()
Date:   Tue, 31 Dec 2019 12:04:42 -0600
Message-Id: <20191231180444.46586-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231180444.46586-1-ebiggers@kernel.org>
References: <20191231180444.46586-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Support for unwritten extents was added to ext4 a long time ago, so
remove a misleading comment that says they're a future feature.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/extents.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b2dee02ed238..25e6e83cdeca 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1715,11 +1715,6 @@ static int ext4_can_extents_be_merged(struct inode *inode,
 			le32_to_cpu(ex2->ee_block))
 		return 0;
 
-	/*
-	 * To allow future support for preallocated extents to be added
-	 * as an RO_COMPAT feature, refuse to merge to extents if
-	 * this can result in the top bit of ee_len being set.
-	 */
 	if (ext1_ee_len + ext2_ee_len > EXT_INIT_MAX_LEN)
 		return 0;
 
-- 
2.24.1

