Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2FA2E9714
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jan 2021 15:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbhADOUf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jan 2021 09:20:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:42808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbhADOUf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 4 Jan 2021 09:20:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1E05ACAF;
        Mon,  4 Jan 2021 14:19:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A63521E07FD; Mon,  4 Jan 2021 15:19:53 +0100 (CET)
Date:   Mon, 4 Jan 2021 15:19:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        lihaotian9@huawei.com, lutianxiong@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH v2] ext4: fix bug for rename with RENAME_WHITEOUT
Message-ID: <20210104141953.GF4018@quack2.suse.cz>
References: <20201229090208.1113218-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229090208.1113218-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 29-12-20 17:02:08, yangerkun wrote:
> ext4_rename will create a special inode for whiteout and use this 'ino'
> to replace the source file's dir entry 'ino'. Once error happens
> latter(small ext4 img, and consume all space, so the rename with dst
> path not exist will fail due to the ENOSPC return from ext4_add_entry in
> ext4_rename), the cleanup do drop the nlink for whiteout, but forget to
> restore 'ino' with source file. This will lead to "deleted inode
> referenced".
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Thanks for the patch! It looks mostly good, just one comment below:

>  end_rename:
> -	brelse(old.dir_bh);
> -	brelse(old.bh);
> -	brelse(new.bh);
>  	if (whiteout) {
> +		ext4_setent(handle, &old,
> +			    old.inode->i_ino, old_file_type);

I'm wondering here - how is it correct to reset the 'old' entry whenever
whiteout != NULL? I'd expect this to be guarded by the if (retval) check...

									Honza

>  		if (retval)
>  			drop_nlink(whiteout);
>  		unlock_new_inode(whiteout);
>  		iput(whiteout);
>  	}
> +	brelse(old.dir_bh);
> +	brelse(old.bh);
> +	brelse(new.bh);
>  	if (handle)
>  		ext4_journal_stop(handle);
>  	return retval;
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
