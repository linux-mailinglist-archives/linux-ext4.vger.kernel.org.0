Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078894866F6
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbiAFPps (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jan 2022 10:45:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50314 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiAFPpr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jan 2022 10:45:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C7166212B8;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641483945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hCnxgXNlc+hA/hBIb33Q07o6OGeUNCNtDgyikwrRKkc=;
        b=JlYBvnUHwwfEm3g4gZsmn8n8+1kZn23vrzlOrTlEbyJUkHIkHdB8nHeX3Bv8no/eC/m6tN
        yutRKtWwuXhcU0EE+onPLrZwBw6qsIUIaeinpR9DDnMCo3GpKWyf5e5XfZ0MIV1IWLlD+A
        JpaGEkzIH/jl0tvO8APpIGu/tOhUEK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641483945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hCnxgXNlc+hA/hBIb33Q07o6OGeUNCNtDgyikwrRKkc=;
        b=l55rYlEQ0gNFUR/I7Feeytd6h5rMUpKGQpfWQcT9tiHqmCEYcPhir7G11OHU9PdLMHIEVh
        njzFfYNZnmICjnDg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AC694A3B83;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
Received: by localhost (Postfix, from userid 1000)
        id 4ADB8A05AF; Mon,  3 Jan 2022 14:30:56 +0100 (CET)
Date:   Mon, 3 Jan 2022 14:30:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: Fix null-ptr-deref in
 '__ext4_journal_ensure_credits'
Message-ID: <20220103133056.3gwhjt72lkdio6cy@quack3>
References: <20211224100341.3299128-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224100341.3299128-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 24-12-21 18:03:41, Ye Bin wrote:
> We got issue as follows when run syzkaller test:
> [ 1901.130043] EXT4-fs error (device vda): ext4_remount:5624: comm syz-executor.5: Abort forced by user
> [ 1901.130901] Aborting journal on device vda-8.
> [ 1901.131437] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.16: Detected aborted journal
> [ 1901.131566] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.11: Detected aborted journal
> [ 1901.132586] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.18: Detected aborted journal
> [ 1901.132751] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.9: Detected aborted journal
> [ 1901.136149] EXT4-fs error (device vda) in ext4_reserve_inode_write:6035: Journal has aborted
> [ 1901.136837] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-fuzzer: Detected aborted journal
> [ 1901.136915] ==================================================================
> [ 1901.138175] BUG: KASAN: null-ptr-deref in __ext4_journal_ensure_credits+0x74/0x140 [ext4]
> [ 1901.138343] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.13: Detected aborted journal
> [ 1901.138398] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.1: Detected aborted journal
> [ 1901.138808] Read of size 8 at addr 0000000000000000 by task syz-executor.17/968
> [ 1901.138817]
> [ 1901.138852] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.30: Detected aborted journal
> [ 1901.144779] CPU: 1 PID: 968 Comm: syz-executor.17 Not tainted 4.19.90-vhulk2111.1.0.h893.eulerosv2r10.aarch64+ #1
> [ 1901.146479] Hardware name: linux,dummy-virt (DT)
> [ 1901.147317] Call trace:
> [ 1901.147552]  dump_backtrace+0x0/0x2d8
> [ 1901.147898]  show_stack+0x28/0x38
> [ 1901.148215]  dump_stack+0xec/0x15c
> [ 1901.148746]  kasan_report+0x108/0x338
> [ 1901.149207]  __asan_load8+0x58/0xb0
> [ 1901.149753]  __ext4_journal_ensure_credits+0x74/0x140 [ext4]
> [ 1901.150579]  ext4_xattr_delete_inode+0xe4/0x700 [ext4]
> [ 1901.151316]  ext4_evict_inode+0x524/0xba8 [ext4]
> [ 1901.151985]  evict+0x1a4/0x378
> [ 1901.152353]  iput+0x310/0x428
> [ 1901.152733]  do_unlinkat+0x260/0x428
> [ 1901.153056]  __arm64_sys_unlinkat+0x6c/0xc0
> [ 1901.153455]  el0_svc_common+0xc8/0x320
> [ 1901.153799]  el0_svc_handler+0xf8/0x160
> [ 1901.154265]  el0_svc+0x10/0x218
> [ 1901.154682] ==================================================================
> 
> This issue may happens like this:
> 	Process1                               Process2
> ext4_evict_inode
>   ext4_journal_start
>    ext4_truncate
>      ext4_ind_truncate
>        ext4_free_branches
>          ext4_ind_truncate_ensure_credits
> 	   ext4_journal_ensure_credits_fn
> 	     ext4_journal_restart
> 	       handle->h_transaction = NULL;
>                                            mount -o remount,abort  /mnt
> 					   -> trigger JBD abort
>                start_this_handle -> will return failed
>   ext4_xattr_delete_inode
>     ext4_journal_ensure_credits
>       ext4_journal_ensure_credits_fn
>         __ext4_journal_ensure_credits
> 	  jbd2_handle_buffer_credits
> 	    journal = handle->h_transaction->t_journal; ->null-ptr-deref
> 
> Now, indirect truncate process didn't handle error. To solve this issue
> maybe simply add check handle is abort in '__ext4_journal_ensure_credits'
> is enough, and i also think this is necessary.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the report and the analysis! The fix looks good. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 6def7339056d..3477a16d08ae 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -162,6 +162,8 @@ int __ext4_journal_ensure_credits(handle_t *handle, int check_cred,
>  {
>  	if (!ext4_handle_valid(handle))
>  		return 0;
> +	if (is_handle_aborted(handle))
> +		return -EROFS;
>  	if (jbd2_handle_buffer_credits(handle) >= check_cred &&
>  	    handle->h_revoke_credits >= revoke_cred)
>  		return 0;


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
