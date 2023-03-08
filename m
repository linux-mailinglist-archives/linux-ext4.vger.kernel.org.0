Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF106AFC0E
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 02:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCHBS4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 20:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCHBSz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 20:18:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B66827D5D;
        Tue,  7 Mar 2023 17:18:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2A74B81B4F;
        Wed,  8 Mar 2023 01:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E29C433D2;
        Wed,  8 Mar 2023 01:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678238331;
        bh=2NmP/pkRo9go4O+zCA7/qKRxq8rwrCPelZOe2MuMEGs=;
        h=From:To:Cc:Subject:Date:From;
        b=vBqtIc2DVqTgPrqbfXobMPXj8RPeKNRlqjg0XgytMQ0MrFy18E+2tDo8nig0aqaYv
         8wLj97E6+RUJjzUz30U9aHXrzEb5HYJd+FUzDPq/ZGSUq8V2nf0VaOgBDy7xrub41/
         J1aUV2mj9/w6xZYL/7YqoQM7wfGVbObW9E6/ruqbzERYwhcp2MWVutsKz1FPsZL3+t
         w2b1cG3WB8F7oDVpfttf/NtTULr6gs0Nig7bVQRmXce3AbOwQmU8DuQA1nysiFSBIL
         gLFIAulfPbKEgbOkGF8hh9WKnacszewvbalgXrSl996x0SrGgI3L3EfbUVUPoKijZl
         dYGwiSWHv39Bg==
From:   Chao Yu <chao@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] ext4: fix to report fstrim.minlen back to userspace
Date:   Wed,  8 Mar 2023 09:18:07 +0800
Message-Id: <20230308011807.411478-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Quoted from manual of fstrim:

"-m, --minimum minimum-size
	..., if it's smaller than the device's minimum, and report that
(fstrim_range.minlen) back to userspace."

So this patch tries to report adjusted fstrim_range.minlen back to
userspace via FITRIM interface, if the value is smaller than device's
minimum discard granularity.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/ext4/mballoc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b2ae37a8b80..bd3ef29cf8a6 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6491,6 +6491,9 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 				discard_granularity >> sb->s_blocksize_bits);
 		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
 			goto out;
+
+		/* Report adjusted minlen back to userspace */
+		range->minlen = minlen;
 	}
 	if (end >= max_blks - 1) {
 		end = max_blks - 1;
-- 
2.25.1

