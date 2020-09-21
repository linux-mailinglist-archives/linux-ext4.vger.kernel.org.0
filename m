Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F842735B4
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Sep 2020 00:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgIUWYM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Sep 2020 18:24:12 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.13]:55891 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUWYL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Sep 2020 18:24:11 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 18:24:11 EDT
Received: from cabot.adilger.int ([70.77.221.9])
        by shaw.ca with ESMTP
        id KU6Mk41TeTWWpKU6NkHcFo; Mon, 21 Sep 2020 16:16:04 -0600
X-Authority-Analysis: v=2.4 cv=EcV2/NqC c=1 sm=1 tr=0 ts=5f692624
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=RPJ6JBhKAAAA:8 a=hh885-vwC2pzhxx2BCkA:9 a=ZUkhVnNHqyo2at-WnAgH:22
 a=fa_un-3J20JGBB2Tu-mn:22
From:   adilger@whamcloud.com
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] e2fsck: skip extent optimization by default
Date:   Mon, 21 Sep 2020 16:16:02 -0600
Message-Id: <1600726562-9567-1-git-send-email-adilger@whamcloud.com>
X-Mailer: git-send-email 1.7.12.4
X-CMAE-Envelope: MS4xfFiC7UGaTWUWgf8jJAgyI62QAggGdZckIPLp8R0MdWCRNl36fKTHL9hYjnhfHIfHCLbTFyUaJmsZhGP6fPpn8Oh/plPjIR+QcwzJqEvvfA9escev306m
 TmPZ/MdBMKjCUtjVdMY4oMmwMK8nzlF41EleEW46o9aPgoXfbCCWXcP5v2jjinesw1aTkjbAIbiPinTs0XAXxQyPFAwKp24dGaexJSHNjLBUzeLsHnuT9clf
 mQjhHIVLAjdCLMUwyODTAIzkZRuOo6VMfx/6VNh8jUwi1wfVHaewhjm6XcG9+0k8
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Andreas Dilger <adilger@whamcloud.com>

The e2fsck error message:

    inode nnn extent tree (at level 1) could be narrower. Optimize<y>?

can be fairly verbose at times, and leads users to think that there
may be something wrong with the filesystem.  Basically, almost any
message printed by e2fsck makes users nervous when they are facing
other corruption, and a few thousand of these printed may hide other
errors.  It also isn't clear that saving a few blocks optimizing the
extent tree noticeably improves performance.

This message has previously been annoying enough for Ted to add the
"-E no_optimize_extents" option to disable it.  Just enable this
option by default, similar to the "-D" directory optimization option.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 e2fsck/e2fsck.8.in | 4 ++--
 e2fsck/unix.c      | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/e2fsck/e2fsck.8.in b/e2fsck/e2fsck.8.in
index 4e3890b..4f5086a 100644
--- a/e2fsck/e2fsck.8.in
+++ b/e2fsck/e2fsck.8.in
@@ -228,12 +228,12 @@ exactly the opposite of discard option. This is set as default.
 .TP
 .BI no_optimize_extents
 Do not offer to optimize the extent tree by eliminating unnecessary
-width or depth.  This can also be enabled in the options section of
+width or depth.  This is the default unless otherwise specified in
 .BR /etc/e2fsck.conf .
 .TP
 .BI optimize_extents
 Offer to optimize the extent tree by eliminating unnecessary
-width or depth.  This is the default unless otherwise specified in
+width or depth.  This can also be enabled in the options section of
 .BR /etc/e2fsck.conf .
 .TP
 .BI inode_count_fullmap
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 1b7ccea..445f806 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -840,6 +840,8 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	else
 		ctx->program_name = "e2fsck";
 
+	ctx->options |= E2F_OPT_NOOPT_EXTENTS;
+
 	phys_mem_kb = get_memory_size() / 1024;
 	ctx->readahead_kb = ~0ULL;
 	while ((c = getopt(argc, argv, "panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
@@ -1051,6 +1053,11 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	if (c)
 		ctx->options |= E2F_OPT_NOOPT_EXTENTS;
 
+	profile_get_boolean(ctx->profile, "options", "optimize_extents",
+			    0, 0, &c);
+	if (c)
+		ctx->options &= ~E2F_OPT_NOOPT_EXTENTS;
+
 	profile_get_boolean(ctx->profile, "options", "inode_count_fullmap",
 			    0, 0, &c);
 	if (c)
-- 
1.7.12.4

