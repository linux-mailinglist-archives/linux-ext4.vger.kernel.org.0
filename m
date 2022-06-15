Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6589054CD03
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbiFOPby (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jun 2022 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiFOPba (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jun 2022 11:31:30 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4DF12AC3;
        Wed, 15 Jun 2022 08:31:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s135so11677481pgs.10;
        Wed, 15 Jun 2022 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d+jcg+yQkcd4AGPUxYLrsPCSzfjF9FdPwsOM6g8sZGs=;
        b=PU4FEktVQQ69fhiR8mld02ZkLi3ZfKd/3pEPa9FjJeSdkdMG2IamU6PVK4g/bzuART
         DSAHxd5dRMzQ9gymQgjGAuvTv2nbR5bbN9LTVKc2es7FMKC/AKZNU/4M7nd1sDvfK15K
         R/FiCaBnd6t6HDQmEd0prI/eoeFH/z4GdobJWhlDSmG1Xms5NkWG9SnWD3QMGvJWhR5A
         k5GyMO4eTRjYXPoib9EB3jlhn51jCkym3qqqW0a43eLLiP24W+ZpCvTqe5BUM80coHcX
         FzDad8SLoC0FnSSql8ol+RXpAV+QZuXQRxhcX/2bh+4tvU5yKiDUBDk7JFOUP5SHnm/n
         2zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d+jcg+yQkcd4AGPUxYLrsPCSzfjF9FdPwsOM6g8sZGs=;
        b=ea6u/AXJkTSl4AFUL7hRMOTeUp7JG9d6H7siNEK9Vmgt5339062U4jkCok1vxz1TXI
         qjpw+pcLSoZkT5He4KcL9mramzFJI5SbFJoE/yIUgWvkzE27JuL1m3Y1d/h/QB5mVMEt
         41t28TOehgCbunvzcVaSBi650vIoQtPLMNSZhYSBSqDNSmARliEFG4bVTxLIN0eilZ2h
         1y3lwovezYB4uK9/ciLWAsSMsE6wgfy70JQ/D7bUoJqHWkLwi1fBij6mVE7he7y3VI1X
         ebZNBFBioGnK3OiOTHVPIpui7VH5o5gzVbfacQl+Qdhzt4pKR2mhL9p5XA8Ss3mmMBjy
         7JCQ==
X-Gm-Message-State: AJIora/N8yWMRUYzxonwnfrkVckyxTYZyK8Yd6C3dKSy/XykKAhc0uEY
        4Rt4gm3FHKizy3Gwa2UeH1A=
X-Google-Smtp-Source: AGRyM1tlW73seD5ob9qWb4lvQw81CBNamFfcz8HzIWN8fF3E6YS7xWhQNOzLJdnxNQh7zQ8a0DOuyg==
X-Received: by 2002:a63:f156:0:b0:3ab:ada6:b463 with SMTP id o22-20020a63f156000000b003abada6b463mr324159pgk.462.1655307087744;
        Wed, 15 Jun 2022 08:31:27 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id p5-20020a170903248500b0015e8d4eb1c8sm5810122plw.18.2022.06.15.08.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:31:27 -0700 (PDT)
Date:   Wed, 15 Jun 2022 21:01:23 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: fix bug_on in ext4_iomap_begin as race
 between bmap and write
Message-ID: <20220615153123.ab32zt75q7yn7jc5@riteshh-domain>
References: <20220615135850.1961759-1-yebin10@huawei.com>
 <20220615152139.vp64tnv46enwnfcs@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615152139.vp64tnv46enwnfcs@riteshh-domain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/06/15 08:51PM, Ritesh Harjani wrote:
> On 22/06/15 09:58PM, Ye Bin wrote:
> > We got issue as follows:
> > ------------[ cut here ]------------
> > WARNING: CPU: 3 PID: 9310 at fs/ext4/inode.c:3441 ext4_iomap_begin+0x182/0x5d0
> > RIP: 0010:ext4_iomap_begin+0x182/0x5d0
> > RSP: 0018:ffff88812460fa08 EFLAGS: 00010293
> > RAX: ffff88811f168000 RBX: 0000000000000000 RCX: ffffffff97793c12
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > RBP: ffff88812c669160 R08: ffff88811f168000 R09: ffffed10258cd20f
> > R10: ffff88812c669077 R11: ffffed10258cd20e R12: 0000000000000001
> > R13: 00000000000000a4 R14: 000000000000000c R15: ffff88812c6691ee
> > FS:  00007fd0d6ff3740(0000) GS:ffff8883af180000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fd0d6dda290 CR3: 0000000104a62000 CR4: 00000000000006e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  iomap_apply+0x119/0x570
> >  iomap_bmap+0x124/0x150
> >  ext4_bmap+0x14f/0x250
> >  bmap+0x55/0x80
> >  do_vfs_ioctl+0x952/0xbd0
> >  __x64_sys_ioctl+0xc6/0x170
> >  do_syscall_64+0x33/0x40
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Above issue may happen as follows:
> >           bmap                    write
> > bmap
> >   ext4_bmap
> >     iomap_bmap
> >       ext4_iomap_begin
> >                             ext4_file_write_iter
> > 			      ext4_buffered_write_iter
> > 			        generic_perform_write
> > 				  ext4_da_write_begin
> > 				    ext4_da_write_inline_data_begin
> > 				      ext4_prepare_inline_data
> > 				        ext4_create_inline_data
> > 					  ext4_set_inode_flag(inode,
> > 						EXT4_INODE_INLINE_DATA);
> >       if (WARN_ON_ONCE(ext4_has_inline_data(inode))) ->trigger bug_on
> >
> > To solved above issue hold inode lock in ext4_bamp.
> 											^^^ ext4_bmap()
>
> I checked the paths where bmap() kernel api can be called i.e. from jbd2/fc and
> generic_swapfile_activate() (apart from ioctl())
> For jbd2, it will be called with j_inode within bmap(), hence taking a inode lock
> of the inode passed within ext4_bmap() (j_inode in this case) should be safe here.
> Same goes with swapfile path as well.
>
> However I feel maybe we should hold inode_lock_shared() since there is no
> block/extent map layout changes that can happen via ext4_bmap().
> Hence read lock is what IMO should be used here.

On second thoughts, shoudn't we use ext4_iomap_report_ops here?
Can't recollect why we didn't use ext4_iomap_report_ops for iomap_bmap() in the
first place. Should be good to verify it once.

-ritesh


>
> -ritesh
>
>
> >
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ---
> >  fs/ext4/inode.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 53877ffe3c41..f4a95c80f644 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3142,13 +3142,15 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
> >  {
> >  	struct inode *inode = mapping->host;
> >  	journal_t *journal;
> > +	sector_t ret = 0;
> >  	int err;
> >
> > +	inode_lock(inode);
> >  	/*
> >  	 * We can get here for an inline file via the FIBMAP ioctl
> >  	 */
> >  	if (ext4_has_inline_data(inode))
> > -		return 0;
> > +		goto out;
> >
> >  	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
> >  			test_opt(inode->i_sb, DELALLOC)) {
> > @@ -3187,10 +3189,14 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
> >  		jbd2_journal_unlock_updates(journal);
> >
> >  		if (err)
> > -			return 0;
> > +			goto out;
> >  	}
> >
> > -	return iomap_bmap(mapping, block, &ext4_iomap_ops);
> > +	ret = iomap_bmap(mapping, block, &ext4_iomap_ops);
> > +
> > +out:
> > +	inode_unlock(inode);
> > +	return ret;
> >  }
> >
> >  static int ext4_read_folio(struct file *file, struct folio *folio)
> > --
> > 2.31.1
> >
