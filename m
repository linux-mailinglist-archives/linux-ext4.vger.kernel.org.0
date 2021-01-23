Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0EC30140E
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Jan 2021 09:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbhAWI6O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 23 Jan 2021 03:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbhAWI6M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 23 Jan 2021 03:58:12 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B32DC06174A
        for <linux-ext4@vger.kernel.org>; Sat, 23 Jan 2021 00:57:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so5388067pfm.6
        for <linux-ext4@vger.kernel.org>; Sat, 23 Jan 2021 00:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FHtOphut8LFOKRBKGCx7H0Bn12FAY4dvY3x6cqKFgn4=;
        b=T/vFU0IUlif7edYM+BXKIOyhcpLVfWqlH7WyvVB9dDTv2noPv27iltEYHOW/f0vEJ5
         K6Gbq3ACmSnPl8JKmzT20lrmvORkIuglJ+4xEMVT/RV9XTqzBd5HgB574qIxtDRg/SaC
         UmXaNh9rOxV8ByVvIPf30ItA6XDIPwjxRc2oRu0tnPtbMgSYGoTXvQEucw3y7IPvKXgh
         TwSZYqM4W4tedFh0EZlI0sj94jihN+Y1TyAcuuFFu94OClm5ZgkVWUBFkR3GJrk/fBR2
         POpsrtwDdh7BWKpd8FkpoviHBM5rmCzPE//1ayBsSbNUI1wtkP4VkMKpSaiWG13Q9lbW
         MJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FHtOphut8LFOKRBKGCx7H0Bn12FAY4dvY3x6cqKFgn4=;
        b=AmOzERiNkx4VI0Ag0kYXStclDjlUO/jAIjcXkt/EGbkULCrBGEObrWTFZ3Q3bgMaWO
         qTV59suA1sPDVcHUB4HfIwHGqjwKtxlhf82jEpvbQQWjPw44vCVFvULYgQdpvaweFboM
         m2ulw+oWc9Gp6SVA/dqyCEJXJUoWsBb9NcLs+RrqfhwRiy17ZVnmSdVIaA027tSPm8Vd
         AjKIv8PyUw1c4Ix8OEW0hTk7niSuWeeBUymC/JSgIM8BWJ6P+/8ZndvlBgh33PDMlJxa
         cjM6VXcAI2l4bAsVdImgPNkgt5G4jd5tB9Ri/2P2SAdhaDH19vMyoqUjR4bAHc92dgBr
         voCA==
X-Gm-Message-State: AOAM531XTHRP1yCBJS7N3r3ls+MFJnoJ6DvACqePgu+g6OMsK+7cz9pf
        /UUTFo2e8oSlOjH9ZycZF4A=
X-Google-Smtp-Source: ABdhPJwb2cSqHo0Yvpnd2gPFJOsyW6W2Xsd/pdZG99g+ZSZnmvePRZ0aWExHYM8AuFuQEdx7tEYzGQ==
X-Received: by 2002:a05:6a00:2353:b029:1ba:d824:f1dc with SMTP id j19-20020a056a002353b02901bad824f1dcmr8957344pfj.9.1611392251542;
        Sat, 23 Jan 2021 00:57:31 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b65sm11701731pga.54.2021.01.23.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 00:57:30 -0800 (PST)
Date:   Sat, 23 Jan 2021 16:57:23 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression panic
Message-ID: <20210123085723.zobwxf6aik6jgfbn@xzhoux.usersys.redhat.com>
References: <20210121101547.fwh35hov3hshogbz@xzhoux.usersys.redhat.com>
 <YAm8qH/0oo2ofSMR@mit.edu>
 <20210121210949.GH24063@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121210949.GH24063@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 21, 2021 at 10:09:49PM +0100, Jan Kara wrote:
> On Thu 21-01-21 12:40:56, Theodore Ts'o wrote:
> > On Thu, Jan 21, 2021 at 06:15:47PM +0800, Murphy Zhou wrote:
> > > Hi Jack,
> > > 
> > > A panic was introduced by this commit. It's easy and reliable to
> > > reproduce.
> > > 
> > > commit 2d01ddc86606564fb08c56e3bc93a0693895f710
> > > Author: Jan Kara <jack@suse.cz>
> > > Date:   Wed Dec 16 11:18:40 2020 +0100
> > > 
> > >     ext4: save error info to sb through journal if available
> > 
> > Hi Murphy,
> > 
> > Thanks for the bug report.  What's happening is that we haven't yet
> > initialized mballoc yet --- that happens in line 4943 of
> > fs/ext4/super.c, in ext4_fill_super().
> > 
> > But in line 4903 (in the case of the BZ #199275 reproducer), we
> > attempt to fetch the root inode, which is fails because it is
> > unallocated.  That then triggers a call to ext4_error(), which now
> > results in a journalled change, since the journal is initialized
> > starting in line 4793, and in line 4838, we set up the
> > j_commit_callback, which is what ends up calling
> > ext4_process_freed_data(), but since the multiblock allocator hasn't
> > been set up yet, that causes the NULL pointer dereference.
> > 
> > So what we need to do is to *not* set up the callback until after the
> > call to ext4_mb_init().
> > 
> > We should probably create an ext4-specific test in xfstests which
> > tries mounting a small, deliberately corrupted file system, to make
> > sure we handle this case correctly in the future.
> > 
> > 						- Ted
> 
> Thanks for looking into this. You beat me to my fix (which was slightly
> different - I moved ext4_mb_init() somewhat earlier during mount). But this
> should work fine as well. So feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza

Hi Jack and Ted,

This patch fixed it. Thanks for the quick fix!

Murphy

> 
> > 
> > commit 6c2f9a8247273cf1108ff71c99680b7457f48318
> > Author: Theodore Ts'o <tytso@mit.edu>
> > Date:   Thu Jan 21 12:33:20 2021 -0500
> > 
> >     ext4: don't try to processed freed blocks until mballoc is initialized
> >     
> >     If we try to make any changes via the journal between when the journal
> >     is initialized, but before the multi-block allocated is initialized,
> >     we will end up deferencing a NULL pointer when the journal commit
> >     callback function calls ext4_process_freed_data().
> >     
> >     The proximate cause of this failure was commit 2d01ddc86606 ("ext4:
> >     save error info to sb through journal if available") since file system
> >     corruption problems detected before the call to ext4_mb_init() would
> >     result in a journal commit before we aborted the mount of the file
> >     system.... and we would then trigger the NULL pointer deref.
> >     
> >     Cc: Jan Kara <jack@suse.cz>
> >     Reported by: Murphy Zhou <jencce.kernel@gmail.com>
> >     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 0f0db49031dc..802ef55f0a55 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -4876,7 +4876,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> >  
> >  	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
> >  
> > -	sbi->s_journal->j_commit_callback = ext4_journal_commit_callback;
> >  	sbi->s_journal->j_submit_inode_data_buffers =
> >  		ext4_journal_submit_inode_data_buffers;
> >  	sbi->s_journal->j_finish_inode_data_buffers =
> > @@ -4993,6 +4992,14 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> >  		goto failed_mount5;
> >  	}
> >  
> > +	/*
> > +	 * We can only set up the journal commit callback once
> > +	 * mballoc is initialized
> > +	 */
> > +	if (sbi->s_journal)
> > +		sbi->s_journal->j_commit_callback =
> > +			ext4_journal_commit_callback;
> > +
> >  	block = ext4_count_free_clusters(sb);
> >  	ext4_free_blocks_count_set(sbi->s_es, 
> >  				   EXT4_C2B(sbi, block));
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Murphy
