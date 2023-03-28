Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D56CBA36
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Mar 2023 11:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjC1JPQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Mar 2023 05:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjC1JPO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Mar 2023 05:15:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06205FC3;
        Tue, 28 Mar 2023 02:15:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 87E051FD6A;
        Tue, 28 Mar 2023 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679994902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3PY4kAmdN+G4LKEzbQiBUxXWfapjGR4y3Y+c4QLJFE=;
        b=2/x+U4R7qqP+59Noj8UT5qLT6YBLSdNNO5wbMKW+dorYuJpNMvYwB/6rVUq3UwWkDl1o/3
        lYL9BUpOObcbbaMYZ5fWsXHepA04B9BYh2KjAEZLsx2CxdS9esUa2QBSokD4Y5BP0Zhr8S
        moxZIItpN8HWEQi+0kuwnrdJ7FAMgyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679994902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3PY4kAmdN+G4LKEzbQiBUxXWfapjGR4y3Y+c4QLJFE=;
        b=yaK7nTFXoeCKjoidyd5uUSiAA+mKW7ilMdRveXZkMGvpA8dq6oIXbtHiVDKgOgbG5b1zJz
        4RtjTok0IuvDLwDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77E161390B;
        Tue, 28 Mar 2023 09:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uAw7HRawImRcQAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 28 Mar 2023 09:15:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F150CA071C; Tue, 28 Mar 2023 11:15:01 +0200 (CEST)
Date:   Tue, 28 Mar 2023 11:15:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com, stable@kernel.org
Subject: Re: [PATCH v3 1/2] ext4: turning quotas off if mount failed after
 enable quotas
Message-ID: <20230328091501.o27zc5yjnrotgyfl@quack3>
References: <20230327141630.156875-1-libaokun1@huawei.com>
 <20230327141630.156875-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327141630.156875-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 27-03-23 22:16:29, Baokun Li wrote:
> Yi found during a review of the patch "ext4: don't BUG on inconsistent
> journal feature" that when ext4_mark_recovery_complete() returns an error
> value, the error handling path does not turn off the enabled quotas,
> which triggers the following kmemleak:
> 
> ================================================================
> unreferenced object 0xffff8cf68678e7c0 (size 64):
> comm "mount", pid 746, jiffies 4294871231 (age 11.540s)
> hex dump (first 32 bytes):
> 00 90 ef 82 f6 8c ff ff 00 00 00 00 41 01 00 00  ............A...
> c7 00 00 00 bd 00 00 00 0a 00 00 00 48 00 00 00  ............H...
> backtrace:
> [<00000000c561ef24>] __kmem_cache_alloc_node+0x4d4/0x880
> [<00000000d4e621d7>] kmalloc_trace+0x39/0x140
> [<00000000837eee74>] v2_read_file_info+0x18a/0x3a0
> [<0000000088f6c877>] dquot_load_quota_sb+0x2ed/0x770
> [<00000000340a4782>] dquot_load_quota_inode+0xc6/0x1c0
> [<0000000089a18bd5>] ext4_enable_quotas+0x17e/0x3a0 [ext4]
> [<000000003a0268fa>] __ext4_fill_super+0x3448/0x3910 [ext4]
> [<00000000b0f2a8a8>] ext4_fill_super+0x13d/0x340 [ext4]
> [<000000004a9489c4>] get_tree_bdev+0x1dc/0x370
> [<000000006e723bf1>] ext4_get_tree+0x1d/0x30 [ext4]
> [<00000000c7cb663d>] vfs_get_tree+0x31/0x160
> [<00000000320e1bed>] do_new_mount+0x1d5/0x480
> [<00000000c074654c>] path_mount+0x22e/0xbe0
> [<0000000003e97a8e>] do_mount+0x95/0xc0
> [<000000002f3d3736>] __x64_sys_mount+0xc4/0x160
> [<0000000027d2140c>] do_syscall_64+0x3f/0x90
> ================================================================
> 
> To solve this problem, we add a "failed_mount10" tag, and call
> ext4_quota_off_umount() in this tag to release the enabled qoutas.
> 
> Fixes: 11215630aada ("ext4: don't BUG on inconsistent journal feature")
> Cc: stable@kernel.org
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V1->V2:
>         Add judgment for CONFIG_QUOTA to avoid warning
>         "label 'failed_mount9' defined but not used".
>         (Reported-by: kernel test robot <lkp@intel.com>)
> V2->V3:
>         By adding __maybe_unused to silence possible compilation
>         complain in patch one, instead of adding the judgment.
>         (Suggested by Jan Kara).
> 
>  fs/ext4/super.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index e6d84c1e34a4..97addf5fd642 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5520,7 +5520,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		ext4_msg(sb, KERN_INFO, "recovery complete");
>  		err = ext4_mark_recovery_complete(sb, es);
>  		if (err)
> -			goto failed_mount9;
> +			goto failed_mount10;
>  	}
>  
>  	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
> @@ -5539,7 +5539,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	return 0;
>  
> -failed_mount9:
> +failed_mount10:
> +	ext4_quota_off_umount(sb);
> +failed_mount9: __maybe_unused
>  	ext4_release_orphan_info(sb);
>  failed_mount8:
>  	ext4_unregister_sysfs(sb);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
