Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A8D70DB
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Oct 2019 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfJOIUE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Oct 2019 04:20:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:38194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbfJOIUE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Oct 2019 04:20:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4948AAE92;
        Tue, 15 Oct 2019 08:20:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 773F11E4A8A; Tue, 15 Oct 2019 10:20:01 +0200 (CEST)
Date:   Tue, 15 Oct 2019 10:20:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: choose hardlimit when softlimit is larger than
 hardlimit in ext4_statfs_project()
Message-ID: <20191015082001.GD21550@quack2.suse.cz>
References: <20191010051426.1087-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010051426.1087-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-10-19 13:14:26, Chengguang Xu wrote:
> Setting softlimit larger than hardlimit seems meaningless
> for disk quota but currently it is allowed. In this case,
> there may be a bit of comfusion for users when they run
> df comamnd to directory which has project quota.
> 
> For example, we set 20M softlimit and 10M hardlimit of
> block usage limit for project quota of test_dir(project id 123).
> 
> [root@hades mnt_ext4]# repquota -P -a
> *** Report for project quotas on device /dev/loop0
> Block grace time: 7days; Inode grace time: 7days
>                         Block limits                File limits
> Project         used    soft    hard  grace    used  soft  hard  grace
> ----------------------------------------------------------------------
>  0        --      13       0       0              2     0     0
>  123      --   10237   20480   10240              5   200   100
> 
> The result of df command as below:
> 
> [root@hades mnt_ext4]# df -h test_dir
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0       20M   10M   10M  50% /home/cgxu/test/mnt_ext4
> 
> Even though it looks like there is another 10M free space to use,
> if we write new data to diretory test_dir(inherit project id),
> the write will fail with errno(-EDQUOT).
> 
> After this patch, the df result looks like below.
> 
> [root@hades mnt_ext4]# df -h test_dir
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0       10M   10M  3.0K 100% /home/cgxu/test/mnt_ext4
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Good spotting! But the patch has a bug:

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dd654e53ba3d..08d4f993b365 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5546,9 +5546,11 @@ static int ext4_statfs_project(struct super_block *sb,
>  		return PTR_ERR(dquot);
>  	spin_lock(&dquot->dq_dqb_lock);
>  
> -	limit = (dquot->dq_dqb.dqb_bsoftlimit ?
> -		 dquot->dq_dqb.dqb_bsoftlimit :
> -		 dquot->dq_dqb.dqb_bhardlimit) >> sb->s_blocksize_bits;
> +	limit = ((dquot->dq_dqb.dqb_bhardlimit &&
> +		(dquot->dq_dqb.dqb_bhardlimit < dquot->dq_dqb.dqb_bsoftlimit)) ?
> +		dquot->dq_dqb.dqb_bhardlimit :
> +		dquot->dq_dqb.dqb_bsoftlimit) >> sb->s_blocksize_bits;
> +

This is wrong in case softlimit isn't set and hardlimit is. In that case
you'd have 'limit' equal to 0, which is wrong. Also the formula is rather
hard to parse already. So I'd rather go with something like:

	limit = 0;
	if (dquot->dq_dqb.dqb_bsoftlimit &&
	    (!limit || dquot->dq_dqb.dqb_bsoftlimit < limit))
		limit = dquot->dq_dqb.dqb_bsoftlimit;
	if (dquot->dq_dqb.dqb_bhardlimit &&
	    (!limit || dquot->dq_dqb.dqb_bhardlimit < limit))
		limit = dquot->dq_dqb.dqb_bhardlimit;
	limit >>= sb->s_blocksize_bits;

and similarly for inode limit...

								Honza

>  	if (limit && buf->f_blocks > limit) {
>  		curblock = (dquot->dq_dqb.dqb_curspace +
>  			    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
> @@ -5558,9 +5560,11 @@ static int ext4_statfs_project(struct super_block *sb,
>  			 (buf->f_blocks - curblock) : 0;
>  	}
>  
> -	limit = dquot->dq_dqb.dqb_isoftlimit ?
> -		dquot->dq_dqb.dqb_isoftlimit :
> -		dquot->dq_dqb.dqb_ihardlimit;
> +	limit = (dquot->dq_dqb.dqb_ihardlimit &&
> +		(dquot->dq_dqb.dqb_ihardlimit < dquot->dq_dqb.dqb_isoftlimit)) ?
> +		dquot->dq_dqb.dqb_ihardlimit :
> +		dquot->dq_dqb.dqb_isoftlimit;
> +
>  	if (limit && buf->f_files > limit) {
>  		buf->f_files = limit;
>  		buf->f_ffree =
> -- 
> 2.20.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
