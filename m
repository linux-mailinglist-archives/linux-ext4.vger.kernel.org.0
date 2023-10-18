Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B257CE50B
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 19:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjJRRmm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Oct 2023 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjJRRmX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Oct 2023 13:42:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58085184;
        Wed, 18 Oct 2023 10:41:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A73C43391;
        Wed, 18 Oct 2023 17:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697650914;
        bh=mMRFKHsg6CFW9vRC+qvje6I3FWhEbLE4To87FsaWYy0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=G9KeDhGIB9FCmXVvdb8/9fxs0Vl7HqKSxTG2hqRqWmfQABwQW7pdvKOVOXxt1vp/X
         7jm9YEVYObd5mwPlrFkNtvsuTXR6xH5Pn13g+WIqWBU+hHOt+fTXPEXY0anLihyfPV
         N2lpWFc95eFiACPuWlr29oqQ7V4JvOv6Ls07DXNTG3JlEkbj2ZQ7xBoy5SYsS5A2bb
         DmhFjFozl3Zi+x494NzrmMrPjsGESKGON+RztxqNbwrZ3B7HJddhjWUFBZ8L06ONWC
         IAqsNdWapv9wZ06yAp7DwcwusRk/S8Fxe9ZUEw3SHPP3VJfZmT69ZHuZptBuaFgOVO
         uN/SIWObsbWYQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 18 Oct 2023 13:41:16 -0400
Subject: [PATCH RFC 9/9] tmpfs: add support for multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-9-4a7a97b1f482@kernel.org>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mMRFKHsg6CFW9vRC+qvje6I3FWhEbLE4To87FsaWYy0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjJAuF/mn4fUKEE3uiFdGeHeVKOJDDMsX28Q
 t9B3mGYu2WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyQAKCRAADmhBGVaC
 FXeLEADGWL+XVQBwiyFQFHvIPzldy2L8awb0YKPCr28SYeSR50oiPbqPzalc6MzF1KFc+NOvzOa
 94PHr4jh1Zd5l44XOHvzRAdilY0BBloRQ6qVfnKJd5JmSQGB02a23Qs3Omp8vBldt+xaHk4I3+B
 PmOCDiBni6Dq8zr1G3M1S/Yu8FVgigl1nkDKRhaEJsogQyoid0JLsND7c43MLWfLm9RL8sEoiFQ
 13PHXmfhUTbvhvCwucMjvlifITgBbUzgSxLMSUBINjfVazbERk48Dg/clacnw/Lxm9g0a/H8Dqi
 gf66uPXr54fnkhwrasliLB1kNNLISNBLVfOfLILNoHn5eDBcWVStIXYRT1dyX9qsbEUbwYpvIog
 6k4DE3M+ZiqgvUilXZB1Yd4yiFTjZeMu3E3i3F4XS9ehA2ABL0L5Auyy4/JicO9FStbE5AUqREX
 u9ySpUplJrMTQ6yGu2XcHasRW703qajO8DORPB8u9DVDkVnoAto6RSwi2W3oGVoMMU7wpt5nhlo
 rwZLb5irBLYI25FjYy9jsDgdWSE818ID2KYoV9Dt/zjZj0akGxwQBs8aalDIMiw1aD+bQU8e5Qs
 t8fdVfGjIcSYqpBPVMMkbPB82S9hiajclrg18YKi7sr5wd0+90jWiGZf00jbQvf+BfnSXbG9aE4
 IVTP54zf3BOAL2A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c48239bfa646..6f5941bffa45 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4586,7 +4586,7 @@ static struct file_system_type shmem_fs_type = {
 #endif
 	.kill_sb	= kill_litter_super,
 #ifdef CONFIG_SHMEM
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 #else
 	.fs_flags	= FS_USERNS_MOUNT,
 #endif

-- 
2.41.0

