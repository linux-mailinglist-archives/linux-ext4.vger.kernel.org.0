Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256DE526F70
	for <lists+linux-ext4@lfdr.de>; Sat, 14 May 2022 09:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiENDht (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 May 2022 23:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiENDhs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 May 2022 23:37:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D46057995
        for <linux-ext4@vger.kernel.org>; Fri, 13 May 2022 20:37:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24E3be03031120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 23:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652499462; bh=9r9Oag9qMJS5d8Wu2qxoPjfVImpOuyYcCj1VUaDcA0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BEkc/XPI0wdUF/xDZweHc+avlXjVjBjcdiwlw+djDsfXtPNgm1LTqCDarK1AHFKjH
         7vjwGDXrD6akSZai/f3/zc6T8XzCiY971xxljly6zvwa8TtrBf6iuLXmtmVRmHG0Jf
         PpIKQAVs5gjFidBAh+d+IG+GXfWh8X+cpv8MDbwPN4N397pT6ic+D0hSN8QzwKN3a/
         eK8W9uiapIMitNZlMuAeOcwsKPYZnrHnVjWpBJ6LhW/Mdn323I4cBsW0rTySMI5hIF
         cXGe9JwpU0b3UDbXiS46ByFL81tcYkskKb/gWg7LqwSoVAnZorYpF5M3jpZhJRtfGi
         DEfOm9IRl4cYg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3457F15C3F2A; Fri, 13 May 2022 23:37:40 -0400 (EDT)
Date:   Fri, 13 May 2022 23:37:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Nguyen Dinh Phi <phind.uet@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com,
        linux-ext4@vger.kernel.org, harshadshirwadkar@gmail.com
Subject: Re: [PATCH] ext4: Fix block validation on non-journal fs in
 __ext4_iget()
Message-ID: <Yn8kBKV7bZXCIDsB@mit.edu>
References: <20220420192312.1655305-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420192312.1655305-1-phind.uet@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 21, 2022 at 03:23:12AM +0800, Nguyen Dinh Phi wrote:
> Syzbot report following KERNEL BUG:
> 	kernel BUG at fs/ext4/extents_status.c:899!
> 	....
> 
> The reason is fast commit recovery path will skip block validation in
> __ext4_iget(), it allows syzbot be able to mount a corrupted non-journal
> filesystem and cause kernel BUG when accessing it.
> 
> Fix it by adding a condition checking.

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 560e56b42829..66c86d85081e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4951,7 +4951,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		goto bad_inode;
>  	} else if (!ext4_has_inline_data(inode)) {
>  		/* validate the block references in the inode */
> -		if (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
> +		if (!(journal && EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&

This isn't the right fix.  It papers over the problem and fixes the
specific syzkaller fuzzed image, but there are other corrupted file
system images which will cause problems.

What the syzkaller fuzzed file system image did was to set the
EXT4_FC_REPLAY_BIT bit the on_disk superblock field s_state, which
then gets copied to sbi->s_mount_state:

	sbi->s_mount_state = le16_to_cpu(es->s_state);

... and then hilarity ensues.

The root cause is that we are using EXT4_FC_REPLAY bit in
sbi->s_mount_state to indicate whether we are in the middle of a fast
commit replay.  This *should* have been done using a bit in
s_mount_flags (e.g., EXT4_MF_FC_REPLAY) via the
ext4_{set,clear,test}_mount_flag() inline functions.

The previous paragraph describes the correct long-term fix, but the
trivial/hacky fix which is easy to backport to LTS stable kernels is
something like this:

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4b0ea8df1f5c..f7ae53d986f1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4889,7 +4889,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 					sbi->s_inodes_per_block;
 	sbi->s_desc_per_block = blocksize / EXT4_DESC_SIZE(sb);
 	sbi->s_sbh = bh;
-	sbi->s_mount_state = le16_to_cpu(es->s_state);
+	sbi->s_mount_state = le16_to_cpu(es->s_state) & ~EXT4_FC_REPLAY;
 	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
 
@@ -6452,7 +6452,8 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 				if (err)
 					goto restore_opts;
 			}
-			sbi->s_mount_state = le16_to_cpu(es->s_state);
+			sbi->s_mount_state = (le16_to_cpu(es->s_state) &
+					      ~EXT4_FC_REPLAY);
 
 			err = ext4_setup_super(sb, es, 0);
 			if (err)

(The first hunk is sufficient to suppress the syzkaller failure, but
for completeness sake we need catch the case where the journal
contains a maliciously modified superblock, which then is copied to
the active superblock, after which hilarity once again ensues.)

    	   	       	     	   	    	 - Ted
