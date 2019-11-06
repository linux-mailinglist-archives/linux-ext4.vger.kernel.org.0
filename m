Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531AFF12B9
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 10:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfKFJt1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 04:49:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:47664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731379AbfKFJt0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 6 Nov 2019 04:49:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14C48B46C;
        Wed,  6 Nov 2019 09:49:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8165C1E47E5; Wed,  6 Nov 2019 10:49:24 +0100 (CET)
Date:   Wed, 6 Nov 2019 10:49:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>,
        "adilger.kernel" <adilger.kernel@dilger.ca>, tytso <tytso@mit.edu>,
        Jan Kara <jack@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] ext4: choose hardlimit when softlimit is larger than
 hardlimit in ext4_statfs_project()
Message-ID: <20191106094924.GA16085@quack2.suse.cz>
References: <20191015102327.5333-1-cgxu519@mykernel.net>
 <20191015112523.GB29554@quack2.suse.cz>
 <16e3f00ed3d.da5d5acd1285.2289879597060795256@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e3f00ed3d.da5d5acd1285.2289879597060795256@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 06-11-19 12:37:35, Chengguang Xu wrote:
>  ---- 在 星期二, 2019-10-15 19:25:23 Jan Kara <jack@suse.cz> 撰写 ----
>  > On Tue 15-10-19 18:23:27, Chengguang Xu wrote:
>  > > Setting softlimit larger than hardlimit seems meaningless
>  > > for disk quota but currently it is allowed. In this case,
>  > > there may be a bit of comfusion for users when they run
>  > > df comamnd to directory which has project quota.
>  > > 
>  > > For example, we set 20M softlimit and 10M hardlimit of
>  > > block usage limit for project quota of test_dir(project id 123).
>  > > 
>  > > [root@hades mnt_ext4]# repquota -P -a
>  > > *** Report for project quotas on device /dev/loop0
>  > > Block grace time: 7days; Inode grace time: 7days
>  > >                         Block limits                File limits
>  > > Project         used    soft    hard  grace    used  soft  hard  grace
>  > > ----------------------------------------------------------------------
>  > >  0        --      13       0       0              2     0     0
>  > >  123      --   10237   20480   10240              5   200   100
>  > > 
>  > > The result of df command as below:
>  > > 
>  > > [root@hades mnt_ext4]# df -h test_dir
>  > > Filesystem      Size  Used Avail Use% Mounted on
>  > > /dev/loop0       20M   10M   10M  50% /home/cgxu/test/mnt_ext4
>  > > 
>  > > Even though it looks like there is another 10M free space to use,
>  > > if we write new data to diretory test_dir(inherit project id),
>  > > the write will fail with errno(-EDQUOT).
>  > > 
>  > > After this patch, the df result looks like below.
>  > > 
>  > > [root@hades mnt_ext4]# df -h test_dir
>  > > Filesystem      Size  Used Avail Use% Mounted on
>  > > /dev/loop0       10M   10M  3.0K 100% /home/cgxu/test/mnt_ext4
>  > > 
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > > ---
>  > > - Fix a bug in the limit setting logic.
>  > 
>  > Thanks for the patch! It looks good to me. You can add:
>  > 
>  > Reviewed-by: Jan Kara <jack@suse.cz>
>  > 
> 
> Hi Jan,
> 
> I have a proposal for another direction.
> Could we add a check for soft limit  in quota layer when setting the value?
> So that we could not bother with  specific file systems on statfs(). 

What do you mean exactly? To not allow softlimit to be larger than
hardlimit? That would make some sense but I don't think the risk of
breaking some user that accidentally depends on current behavior is worth
the few checks we can save...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
