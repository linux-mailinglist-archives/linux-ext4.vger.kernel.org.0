Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985616D9BB0
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbjDFPFf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Apr 2023 11:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239429AbjDFPF0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Apr 2023 11:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51919619F;
        Thu,  6 Apr 2023 08:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E004960EAE;
        Thu,  6 Apr 2023 15:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F340EC433D2;
        Thu,  6 Apr 2023 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680793517;
        bh=4XTqoOIzV1pxO6uiQBLvYXY23I2rTr+JdRE8YKQSOtw=;
        h=From:To:Cc:Subject:Date:From;
        b=oCiIggbXe3BgCKtrTHBwVF+8Hja3/ccC2vEhQsEal9BJRvZhGbwurz76UG6+dU+4/
         YHVTSseZitltDrfhBrE1vCsH+wrlB/GCrtOzz1NH7zd7VoTYmPC9F5xzc4VscpeDBc
         ncvRPXWn31GnWvyZo/TXSSRjYHxLV3BALR0LR3kX4Haz9MAsoF8KniOn2SAQI2w1QS
         2ZwvDNAqDE5gnEAamGuA6v9ebBMcQ4ZfzubKNAVXYLGYPaHbJNIqdmJJmE6HOojhZh
         MEQTDVMF2eRt713mKxqok4l/eIJHSVGenCoZg79J0fF6rDiREFKQVVhVHebPxSUUa7
         hrwZ1fHaV4p7g==
From:   Chao Yu <chao@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v2] ext4: fix to report fstrim.minlen back to userspace
Date:   Thu,  6 Apr 2023 23:04:10 +0800
Message-Id: <20230406150410.3853001-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Quoted from manual of fstrim(8):

"-m, --minimum minimum-size
	..., if it's smaller than the device's minimum, and report that
(fstrim_range.minlen) back to userspace."

So this patch tries to report adjusted fstrim_range.minlen back to
userspace via FITRIM interface, if the value is smaller than device's
minimum discard granularity.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix the wrong calculation of range->minlen.
 fs/ext4/mballoc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d8b9d6a83d1e..4af51a16fc64 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6491,6 +6491,10 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 				discard_granularity >> sb->s_blocksize_bits);
 		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
 			goto out;
+
+		/* Report adjusted minlen back to userspace */
+		range->minlen = EXT4_C2B(EXT4_SB(sb), minlen) <<
+						sb->s_blocksize_bits;
 	}
 	if (end >= max_blks - 1) {
 		end = max_blks - 1;
-- 
2.25.1

