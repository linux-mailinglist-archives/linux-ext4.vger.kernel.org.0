Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D123BDE2E
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 21:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhGFTvv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 15:51:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59224 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFTvv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 15:51:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3AB99222A9;
        Tue,  6 Jul 2021 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625600951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UWBB6sfgBNgo8f42RVzTS7Pe3efTD5jv2aJov1fuEC4=;
        b=gs01kOkk3HEw0mPVPAZ+9VsCB5/lgtJ/3p7AzxkLsB3LWbLZIE9CF26gUXM1biZpCHGc5W
        lA5voCcfVezH2gEJC/qhxFzZPNAV/s2KZAaeqwAPgCxvwXkPcsOK80ZrcCqdl/WJVUBNMj
        TLOrfuZHrVCP+ajM0jdu+gCLLPGEJGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625600951;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UWBB6sfgBNgo8f42RVzTS7Pe3efTD5jv2aJov1fuEC4=;
        b=s8a4ypGe9QhXvXTth8VdqAXa06xHMspTuNVdEohAHZY4xYK8xi1ZxWqLRKObzvkN1R8ROI
        RFMJgFPzTNZgd2DA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 2AAFBA3B8A;
        Tue,  6 Jul 2021 19:49:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F32791E62D5; Tue,  6 Jul 2021 21:49:10 +0200 (CEST)
Date:   Tue, 6 Jul 2021 21:49:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH -v3] ext4: fix possible UAF when remounting r/o a
 mmp-protected file system
Message-ID: <20210706194910.GC17149@quack2.suse.cz>
References: <YOR+5AY2owcnhrgy@mit.edu>
 <20210706171208.3540887-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706171208.3540887-1-tytso@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-07-21 13:12:08, Theodore Ts'o wrote:
> After commit 618f003199c6 ("ext4: fix memory leak in
> ext4_fill_super"), after the file system is remounted read-only, there
> is a race where the kmmpd thread can exit, causing sbi->s_mmp_tsk to
> point at freed memory, which the call to ext4_stop_mmpd() can trip
> over.
> 
> Fix this by only allowing kmmpd() to exit when it is stopped via
> ext4_stop_mmpd().
> 
> Link: https://lore.kernel.org/r/YONtEGojq7LcXnuC@mit.edu
> Reported-by: Ye Bin <yebin10@huawei.com>
> Bug-Report-Link: <20210629143603.2166962-1-yebin10@huawei.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

The patch looks mostly fine. Two comments below.

> @@ -242,9 +237,13 @@ static int kmmpd(void *data)
>  	mmp->mmp_seq = cpu_to_le32(EXT4_MMP_SEQ_CLEAN);
>  	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
>  
> -	retval = write_mmp_block(sb, bh);
> +	return write_mmp_block(sb, bh);

I think we need to keep retval = write_mmp_block() here. Otherwise we could
exit early in sb_rdonly() case and still have potential use-after-free.

>  
> -exit_thread:
> +wait_to_exit:
> +	set_current_state(TASK_INTERRUPTIBLE);
> +	while (!kthread_should_stop())
> +		schedule();
> +	set_current_state(TASK_RUNNING);
>  	return retval;
>  }

This is more or less fine but if we get a spurious wakeup for whatever
reason (which sets task to TASK_RUNNING state) we would still be
potentially looping in that loop burning cpu...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
