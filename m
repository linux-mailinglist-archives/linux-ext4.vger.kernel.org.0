Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D719624B80
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 21:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiKJUQc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Nov 2022 15:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiKJUQb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Nov 2022 15:16:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A225F4D5DD
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 12:16:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3795E61CAD
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 20:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4E2C43142;
        Thu, 10 Nov 2022 20:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668111389;
        bh=wc22eyHGw2b/YPLdii2igwaFo5ZDgn6bjvKlINXaGZk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qWEXo2c/QllZY9OqMa2VPH0/kof6QtIEW+I7j30uG/gZkn/9E21Cp0PWAELadEmN4
         dKI/0JpSCgYZY6s2K8bcXcG6KS1ynA2uSqwHiCbI7Zs1jGH0pOOlUn3phnBKlN/ZfV
         msHi0NMCh8OacPxrvm4rBBEG6ghGrgGEgSoa3Ff8DeYI+qAn1bIzQ51RynzMf5l8ZN
         HzOaHuQuxL4idkbLSG6Menl569p7f3nIyf/X0bt3tNoFW8fhNKo7of/DpjSUNwntJg
         d50d/qxdOFl8CxHcK4yD3jC3gEDBj/FxgMchS91QVp6ROyj1iCE3Tp5i+2SGV+vE1K
         2JBT6xvwC2uxQ==
Subject: [PATCH 1/2] ext4: dont return EINVAL from GETFSUUID when reporting
 UUID length
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, tytso@mit.edu
Cc:     catherine.hoang@oracle.com, linux-ext4@vger.kernel.org
Date:   Thu, 10 Nov 2022 12:16:29 -0800
Message-ID: <166811138914.327006.9241306894437166566.stgit@magnolia>
In-Reply-To: <166811138334.327006.2601737065307668866.stgit@magnolia>
References: <166811138334.327006.2601737065307668866.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

If userspace calls this ioctl with fsu_length (the length of the
fsuuid.fsu_uuid array) set to zero, ext4 copies the desired uuid length
out to userspace.  The kernel call returned a result from a valid input,
so the return value here should be zero, not EINVAL.

While we're at it, fix the copy_to_user call to make it clear that we're
only copying out fsu_len.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/ext4/ioctl.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 95dfea28bf4e..5f91f3ad3e50 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1153,9 +1153,10 @@ static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
 
 	if (fsuuid.fsu_len == 0) {
 		fsuuid.fsu_len = UUID_SIZE;
-		if (copy_to_user(ufsuuid, &fsuuid, sizeof(fsuuid.fsu_len)))
+		if (copy_to_user(&ufsuuid->fsu_len, &fsuuid.fsu_len,
+					sizeof(fsuuid.fsu_len)))
 			return -EFAULT;
-		return -EINVAL;
+		return 0;
 	}
 
 	if (fsuuid.fsu_len != UUID_SIZE || fsuuid.fsu_flags != 0)

