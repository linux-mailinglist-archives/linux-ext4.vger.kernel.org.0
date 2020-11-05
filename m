Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A582A834B
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Nov 2020 17:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgKEQSC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 11:18:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49742 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbgKEQSB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 11:18:01 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:4a7e:bc14:686e:75db])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 604E51F460D7;
        Thu,  5 Nov 2020 16:17:59 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH 10/11] e2fsck.8.in: Document check_encoding extended option
Date:   Thu,  5 Nov 2020 17:16:42 +0100
Message-Id: <20201105161642.87488-11-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105161642.87488-1-arnaud.ferraris@collabora.com>
References: <20201105161642.87488-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 e2fsck/e2fsck.8.in | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/e2fsck/e2fsck.8.in b/e2fsck/e2fsck.8.in
index 4e3890b2..019a34ec 100644
--- a/e2fsck/e2fsck.8.in
+++ b/e2fsck/e2fsck.8.in
@@ -267,6 +267,10 @@ Only fix damaged metadata; do not optimize htree directories or compress
 extent trees.  This option is incompatible with the -D and -E bmap2extent
 options.
 .TP
+.BI check_encoding
+Force verification of encoded filenames in case-insensitive directories.
+This is the default mode if the filesystem has the strict flag enabled.
+.TP
 .BI unshare_blocks
 If the filesystem has shared blocks, with the shared blocks read-only feature
 enabled, then this will unshare all shared blocks and unset the read-only
-- 
2.28.0

