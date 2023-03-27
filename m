Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6836C9EE4
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjC0JGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Mar 2023 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjC0JFi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Mar 2023 05:05:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049F12699;
        Mon, 27 Mar 2023 02:05:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B5A871F8A8;
        Mon, 27 Mar 2023 09:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679907906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1m+GqVM8V9jjiHtBYZoDupeKxHqRy0t5O4/7/X/MgNA=;
        b=pg7rxZhS2SGjJ5gfDsHVHfoqwYwfa2DicX9BYVJXv5YKGPo0PAK7T5HfShZuhMxw4mjEte
        t0OsgyMz11NtsQyuVok8jqHpuuPo9UaKjbNYv84Kxkg8CSiyfjEvbqjp7CF7GZubdigP3L
        DLWoMIlYL6/+5tKYhh4R/wMDZkkyacg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679907906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1m+GqVM8V9jjiHtBYZoDupeKxHqRy0t5O4/7/X/MgNA=;
        b=XAWTmPnQ7fhRzWMGR9UknLUXa/nz2WGywo4sbJb0IA3YIVrhaIikUxtINl9QpqloA0epP7
        HIoU7V64K+HWA5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A66E013329;
        Mon, 27 Mar 2023 09:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HmWaKEJcIWSlWQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Mar 2023 09:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 344A1A071C; Mon, 27 Mar 2023 11:05:06 +0200 (CEST)
Date:   Mon, 27 Mar 2023 11:05:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com, stable@kernel.org
Subject: Re: [PATCH v2 1/2] ext4: turning quotas off if mount failed after
 enable quotas
Message-ID: <20230327090506.a3notb7a2zgz4hue@quack3>
References: <20230327022703.576857-1-libaokun1@huawei.com>
 <20230327022703.576857-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327022703.576857-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 27-03-23 10:27:02, Baokun Li wrote:
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

Looks good. Just one comment:

> +failed_mount10:
> +#ifdef CONFIG_QUOTA
> +	ext4_quota_off_umount(sb);
>  failed_mount9:
> +#endif  /* CONFIG_QUOTA */

How about dealing with this using __maybe_unused attribute instead. Like:

failed_mount9: __maybe_unused

That would be much easier to read...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
