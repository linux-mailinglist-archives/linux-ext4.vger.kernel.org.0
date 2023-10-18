Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1340B7CE50C
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjJRRmX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Oct 2023 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjJRRmC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Oct 2023 13:42:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6298B129;
        Wed, 18 Oct 2023 10:41:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6728C43395;
        Wed, 18 Oct 2023 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697650909;
        bh=4p7KAc4dsK8dQOeLACIwEbavFhpYUlO+UH4AD1OreDY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YYfoYs3OV3OwOoWHJrW77sJgKOC9d7+Xq2vmQwl+Dj5UFhipFADNwQ3Z5KsSsLnjj
         UVCEUAP+RmDftyHzLhd05wa4Wr9JjLoXLiMNGfHoXxPtQw6AiZe1Lab31EqC9nkk+X
         SLlEIufv3uKJdxWt2FX2w4ro0YBLs4r3yGGJ2HiiiEmoFU5P7wRsFwR78QI3BZcJKQ
         JrJadB8JAr5Za++uEa/DHUlvVAmSgMmyDqMs/P/f1w9aWxEst8sifhkZCulFbhCaER
         HIdZH+kCXuPghYLEvCgDz0lXzMwGopN027mxaYxLLXwTEd1iaD7Uf5TKOI7ecwuiA6
         nO8L4XBZg8rPA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 18 Oct 2023 13:41:14 -0400
Subject: [PATCH RFC 7/9] ext4: switch to multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-7-4a7a97b1f482@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4p7KAc4dsK8dQOeLACIwEbavFhpYUlO+UH4AD1OreDY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjJsAbzUTfA1QPqzg0MuGg3swqrFXt6uvW1m
 bGS00EFnDmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyQAKCRAADmhBGVaC
 FfeYD/98fNSYqHhHFEvbqhES3uKXfBN7CAx91j661F9ZNuvn2CUIquUaA+FfPt5NpL/7OW1KiHo
 hcxzhv+n0ws5nkme7kVxjI1jfLKkHNNOrue4gPlc1uU8+6SJ/oW//BRSV+nVkhZJtmIBtz7FJh9
 yHdA4QbXq2qZwMBMlh3eRQTV913fwSRViLHiYkQYST4FOCORzm2QDfAeQNTscPvOI4ewlnaD/ep
 9OIszxsNlLeabXq5eTdHb+tAWYRAcLzGpRDDB+mmxJsTBYPx60lODA9tFAUBrGmwxlDIHNmYx+P
 TornDYcILN2sWjoW0bqNmlRzp6iY037toqRYrQ7JjWhqpujus+aarDdugYY+r4CECwvRypVhGxK
 uWz3jjn1nlJmmBZmavbScjo3jReAgwtwxuTgmQQrYqPxwZS0ts3pBhvgk2atABZVejYvtAmZw93
 QlP8V1GdxhdElp/hHiUK+LBRy0pKGK0lUt4yzOM5udaB7LCwRCIClVUhQ/IygAEikJXhCqX1de9
 ogvCF5Orn0HR0YUZ4mKJ3WD3Oc2V7bfeDJ3zo6hBvWjbiSr6ZXixhXHy03d0TlCIyP+pPfmib9O
 Hzz0pNgcBzA4WTTYeDb6RhPTqh9IfJli9Ntp5lFmYh+Juwu/yH1cI4E5jnLXa4TO/ziZvclczEQ
 7oglGUSvni3TcVQ==
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

For ext4, we only need to enable the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c642adf54599..1b111cf4ebe7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7314,7 +7314,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.41.0

