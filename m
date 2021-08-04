Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0C3E0220
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbhHDNfr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 09:35:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44402 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238344AbhHDNfq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 09:35:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5723D1FDF1;
        Wed,  4 Aug 2021 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628084132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PkxlMrOm/aelLkpRglJYly4BoJS7WEoW4pzhmOhsBok=;
        b=ChCYnfrmBjub5RsGhIKlHT3aEaTKRlcUq8uxKicaaM93P6dM0qmJTW9nSjA9VsErTN1cqJ
        qWIFEfHpw/rr3N+xs2cQgH5MhJB0Gmw03DwKu4CTrJsNmW6hjFmmSh0sCKqOj+77Jh98Aj
        Ayrfvxmahe9MvIqSL4UOGkrSi9LjNTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628084132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PkxlMrOm/aelLkpRglJYly4BoJS7WEoW4pzhmOhsBok=;
        b=0zaxFQkFMRkT5gldHJGlfMQHC4uiq36S0b08OgksnZy3EGomMOlhDkMKv6LPL8hV8b8V56
        iyzBx226XzACPhCg==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 9DE0CA3B8D;
        Wed,  4 Aug 2021 13:35:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D4D61E62D6; Wed,  4 Aug 2021 15:35:29 +0200 (CEST)
Date:   Wed, 4 Aug 2021 15:35:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: stop return ENOSPC from ext4_issue_zeroout
Message-ID: <20210804133529.GE4578@quack2.suse.cz>
References: <20210804125044.2480435-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804125044.2480435-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 04-08-21 20:50:44, yangerkun wrote:
> Our testcase(briefly described as fsstress on dm thin-provisioning which
> ext4 see volume size with 100G but actual size 10G) trigger a hungtask
> bug since ext4_writepages fall into a infinite loop:
> 
> static int ext4_writepages(xxx)
> {
>     ...
>    while (!done && mpd.first_page <= mpd.last_page) {
>        ...
>        ret = mpage_prepare_extent_to_map(&mpd);
>        if (!ret) {
>            ...
>            ret = mpage_map_and_submit_extent(handle,
> &mpd,&give_up_on_write);
>            <----- will return -ENOSPC
>            ...
>        }
>        ...
>        if (ret == -ENOSPC && sbi->s_journal) {
>            <------ we cannot break since we will get ENOSPC forever
>            jbd2_journal_force_commit_nested(sbi->s_journal);
>            ret = 0;
>            continue;
>        }
>        ...
>    }
> }
> 
> Got ENOSPC with follow stack:
> ...
> ext4_ext_map_blocks
>   ext4_ext_convert_to_initialized
>     ext4_ext_zeroout
>       ext4_issue_zeroout
>         ...
>         submit_bio_wait <-- bio to thinpool will return ENOSPC
> 
> 'df22291ff0fd ("ext4: Retry block allocation if we have free blocks
> left")' add the logic to retry block allcate since we may get free block
> after we commit a transaction. But the ENOSPC from thin-provisioning
> will confuse ext4, and lead the upper infinite loop. Fix it by convert
> the err to EIO.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Thanks for the patch. As a quick fix for the problem this is probably fine.
But longer term we might need to implement a configurable behavior for this
because just dropping data on the floor (which is what would happen here)
need not be what sysadmin wants and blocking until space is provisioned may be
actually a preferable behavior. Anyway for now feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 038aebd7eb2f..d9ded699a88c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -428,6 +428,9 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
>  	if (ret > 0)
>  		ret = 0;
>  
> +	if (ret == -ENOSPC)
> +		ret = -EIO;
> +
>  	return ret;
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
