Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6B42C6A5B
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 18:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbgK0RBk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 12:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732117AbgK0RBk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Nov 2020 12:01:40 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3766C0613D1
        for <linux-ext4@vger.kernel.org>; Fri, 27 Nov 2020 09:01:39 -0800 (PST)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:5a64:74b8:f3be:d972])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 666D51F4462E;
        Fri, 27 Nov 2020 17:01:38 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 11/12] e2fsck.8.in: Document check_encoding extended option
Date:   Fri, 27 Nov 2020 18:01:15 +0100
Message-Id: <20201127170116.197901-12-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
References: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
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

