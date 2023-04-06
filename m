Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7E86D9BB4
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 17:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbjDFPGc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Apr 2023 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239455AbjDFPGb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Apr 2023 11:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1E31AB;
        Thu,  6 Apr 2023 08:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF2C618D3;
        Thu,  6 Apr 2023 15:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A743C433D2;
        Thu,  6 Apr 2023 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680793589;
        bh=/Qnxu3y/b9dYJicRMfW3kfoy3najo7T//JwcFvG+lLE=;
        h=From:To:Cc:Subject:Date:From;
        b=TZNcy5xBFCrr2jp9YctQlD+Z2BrBKdv6vudCxvkz8cJuGXr+3031ZlwTHdz2lS9Wo
         GegbTIGxoJi2BBvRgbmYlw1XUaWsQ1k8hc47ySkxYQWe0X3v2Lt2U+8vof5LrnKTio
         Nk356Yic+9tkc68SYCfKG77yHhfa9T+4Bx0aTH07lhO66blM4LLCZ1ExuqPT/n1qDf
         8FaBV6MkK96K0/HoKnPGcq9HTdRt0PUdPK4hJqLv07SSdUI2xfpEIbyU+LNrWdieEm
         Q4yz+KqlhHfsOGz5gF/XtBJfFzADqr2D0FdRtZe9HaYFa+oRXW+58dVozhu77XGvLO
         vn6gSnGqYFi4w==
From:   Chao Yu <chao@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] ext4: fix wrong calculation of minlen in ext4_trim_fs()
Date:   Thu,  6 Apr 2023 23:06:21 +0800
Message-Id: <20230406150621.3854298-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As Ted pointed out as below:

"
However the minlen variable in ext4_trim_fs is in units of *clusters*.
And so it gets rounded up two places.  The first time is when it is
converted into units of a cluster:

	minlen = EXT4_NUM_B2C(EXT4_SB(sb),
			      range->minlen >> sb->s_blocksize_bits);

Oh, and by the way, that first conversion is not correct as currently
written in ext4_fs_trim().   It should be

	minlen = (range->minlen + EXT4_CLUSTER_SIZE(sb) - 1) >>
		(sb->s_blocksize_bits + EXT4_CLUSTER_BITS(sb));
"

The reason is if range->minlen is smaller than block size of ext4,
original calculation "range->minlen >> sb->s_blocksize_bits" may
return zero, but since EXT4_NUM_B2C() expects a non-zero in-parameter,
so it needs to round up range->minlen to cluster size directly as above.

Link: https://lore.kernel.org/lkml/20230311031843.GF860405@mit.edu/
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/ext4/mballoc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b2ae37a8b80..d8b9d6a83d1e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6478,8 +6478,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 
 	start = range->start >> sb->s_blocksize_bits;
 	end = start + (range->len >> sb->s_blocksize_bits) - 1;
-	minlen = EXT4_NUM_B2C(EXT4_SB(sb),
-			      range->minlen >> sb->s_blocksize_bits);
+	minlen = (range->minlen + EXT4_CLUSTER_SIZE(sb) - 1) >>
+			(sb->s_blocksize_bits + EXT4_CLUSTER_BITS(sb));
 
 	if (minlen > EXT4_CLUSTERS_PER_GROUP(sb) ||
 	    start >= max_blks ||
-- 
2.25.1

