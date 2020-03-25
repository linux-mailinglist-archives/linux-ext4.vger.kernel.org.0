Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1319327F
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 22:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCYVS5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 17:18:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39606 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVS4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 17:18:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7056A292B0F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH e2fsprogs 10/11] e2fsck.8.in: Document check_encoding extended option
Date:   Wed, 25 Mar 2020 17:18:10 -0400
Message-Id: <20200325211812.2971787-11-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200325211812.2971787-1-krisman@collabora.com>
References: <20200325211812.2971787-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 e2fsck/e2fsck.8.in | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/e2fsck/e2fsck.8.in b/e2fsck/e2fsck.8.in
index 4e3890b2d3e1..019a34ecdff6 100644
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
2.25.0

