Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AD3375575
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhEFOQx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 10:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhEFOQw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 10:16:52 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B633C061574
        for <linux-ext4@vger.kernel.org>; Thu,  6 May 2021 07:15:54 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o27so5002073qkj.9
        for <linux-ext4@vger.kernel.org>; Thu, 06 May 2021 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d9V7UoNeJmkr0DkA51CcwHSZWLCT+LfLjwpOXO7jVV8=;
        b=ATy03JguVzgXVPQUNZvXhFkA9b8FeOCuj4G20B9npUQL8sAUks5bG+Tr6Od6q2WGd6
         sBMdfLJQPyxlWXv1aWXHX4PFp+slESTz36dujVTT6V6UH2P/KoafV29m/ePU3ghb14Mj
         anO5rqt80ywcGzWaN/mwPV+ICaaJXgV6YXrcClRbJCTvzjrZhPqIH1YCLMpe3Y/MWXMa
         X/Pe5EpNDwJRGmBGn6QnVtS2MJPXzRtGTKkWnfJyhSgElqV7QTAJnturWd8DSQU+CrJh
         KoGMpuACyAAh1WYQ0HAF8oazU6o+/EC2Zhw7hZBcVjUh69+isBRVVjpcNqOIA/IG6T98
         wdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d9V7UoNeJmkr0DkA51CcwHSZWLCT+LfLjwpOXO7jVV8=;
        b=I+U9mdZeNR7tQSWeibpgRPb/FGUzfqv759gVRPGb1LupDw6U0QA2EF72lWG2akj4vY
         yndH+NgqFz8V57scV2C5ilwTcfnQ6iXApTKD9vIMrtoWza1yiH7AAq4+zuqeuvdjONNR
         2tWHdF1NeCUuIARkW18R7wxs5CqVEtF3uZGnc5sZxlmI3ftGt0BrDHMF9l4qyPn0cXzF
         v40P7Ixaw65fo6Q7JHk0IYQIYLrnQUursUCcMghSaEEHQZbLof6bvjeP4uvmff63FGdu
         md7J4dAy0ij63vs0NDW850yG2B4RSaG72LnTDHHAVU/C/yPa085y/LmIiAj+vCT22mKF
         JPAg==
X-Gm-Message-State: AOAM532HwRMx8Laq/JE9aeY/PLk+XttGAEUKWsBQsuTzqwkdrRO4Xrp+
        tHcfuYwLblw5MfV4drUqmDM=
X-Google-Smtp-Source: ABdhPJy9atJXivTZpkcftkR2gW2aEzsGkQFrfvKEyTJehfrtE9708NUrY+V22oF60bzkDBqepWJDtA==
X-Received: by 2002:a37:7b41:: with SMTP id w62mr4179803qkc.256.1620310553386;
        Thu, 06 May 2021 07:15:53 -0700 (PDT)
Received: from google.com ([2601:4c3:201:ed00:1ee1:2ff9:ee25:64a6])
        by smtp.gmail.com with ESMTPSA id x18sm1893460qkx.118.2021.05.06.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:15:52 -0700 (PDT)
Date:   Thu, 6 May 2021 10:15:51 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v3 1/3] ext4: add flags argument to jbd2_journal_flush
Message-ID: <YJP6F2gSju92kMaU@google.com>
References: <20210504163550.1486337-1-leah.rumancik@gmail.com>
 <20210505213717.GC8532@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505213717.GC8532@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 05, 2021 at 02:37:17PM -0700, Darrick J. Wong wrote:
> On Tue, May 04, 2021 at 04:35:48PM +0000, Leah Rumancik wrote:
> > This patch will allow the following commit to pass a discard flag,
> > enabling discarding the journal blocks while flushing the journal.
> > 
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > ---
> >  fs/ext4/inode.c      | 4 ++--
> >  fs/ext4/ioctl.c      | 6 +++---
> >  fs/ext4/super.c      | 6 +++---
> >  fs/jbd2/journal.c    | 3 +--
> >  fs/ocfs2/alloc.c     | 2 +-
> >  fs/ocfs2/journal.c   | 8 ++++----
> >  include/linux/jbd2.h | 2 +-
> >  7 files changed, 15 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 0948a43f1b3d..d308c57559e3 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3225,7 +3225,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
> >  		ext4_clear_inode_state(inode, EXT4_STATE_JDATA);
> >  		journal = EXT4_JOURNAL(inode);
> >  		jbd2_journal_lock_updates(journal);
> > -		err = jbd2_journal_flush(journal);
> > +		err = jbd2_journal_flush(journal, false);
> >  		jbd2_journal_unlock_updates(journal);
> >  
> >  		if (err)
> > @@ -6007,7 +6007,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
> >  	if (val)
> >  		ext4_set_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
> >  	else {
> > -		err = jbd2_journal_flush(journal);
> > +		err = jbd2_journal_flush(journal, false);
> >  		if (err < 0) {
> >  			jbd2_journal_unlock_updates(journal);
> >  			percpu_up_write(&sbi->s_writepages_rwsem);
> > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > index e9b0a1fa2ba8..ef809feb7e77 100644
> > --- a/fs/ext4/ioctl.c
> > +++ b/fs/ext4/ioctl.c
> > @@ -701,7 +701,7 @@ static long ext4_ioctl_group_add(struct file *file,
> >  	err = ext4_group_add(sb, input);
> >  	if (EXT4_SB(sb)->s_journal) {
> >  		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> > -		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> > +		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, false);
> >  		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
> >  	}
> >  	if (err == 0)
> > @@ -879,7 +879,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  		err = ext4_group_extend(sb, EXT4_SB(sb)->s_es, n_blocks_count);
> >  		if (EXT4_SB(sb)->s_journal) {
> >  			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> > -			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> > +			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, false);
> >  			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
> >  		}
> >  		if (err == 0)
> > @@ -1022,7 +1022,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  		if (EXT4_SB(sb)->s_journal) {
> >  			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE);
> >  			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> > -			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> > +			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, false);
> >  			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
> >  		}
> >  		if (err == 0)
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 3868377dec2d..449ed222cdf8 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -5613,7 +5613,7 @@ static int ext4_mark_recovery_complete(struct super_block *sb,
> >  		return 0;
> >  	}
> >  	jbd2_journal_lock_updates(journal);
> > -	err = jbd2_journal_flush(journal);
> > +	err = jbd2_journal_flush(journal, false);
> >  	if (err < 0)
> >  		goto out;
> >  
> > @@ -5755,7 +5755,7 @@ static int ext4_freeze(struct super_block *sb)
> >  		 * Don't clear the needs_recovery flag if we failed to
> >  		 * flush the journal.
> >  		 */
> > -		error = jbd2_journal_flush(journal);
> > +		error = jbd2_journal_flush(journal, false);
> >  		if (error < 0)
> >  			goto out;
> >  
> > @@ -6346,7 +6346,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
> >  		 * otherwise be livelocked...
> >  		 */
> >  		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> > -		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> > +		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal, false);
> >  		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
> >  		if (err)
> >  			return err;
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 2dc944442802..4b7953934c82 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -2251,8 +2251,7 @@ EXPORT_SYMBOL(jbd2_journal_clear_features);
> >   * Filesystems can use this when remounting readonly to ensure that
> >   * recovery does not need to happen on remount.
> >   */
> > -
> > -int jbd2_journal_flush(journal_t *journal)
> > +int jbd2_journal_flush(journal_t *journal, bool discard)
> >  {
> >  	int err = 0;
> >  	transaction_t *transaction = NULL;
> 
> The division of code between patches 1 and 2 is a bit ... unusual?
> 
> I would have had patch 1 actually wire up this parameter, and put the
> userspace ioctl additions in patch 2.
> 
> At any rate, I defer to Ted; if he told you to do it this way, then it's
> fine with me, no need to churn your series for the same end-result.
> 
> --D

I knew they needed to be split but wasn't sure how. Felt weird to
include the __jbd2_issue_discard function when no one is using it, but I
do agree it is even weirder to have a parameter that isn't attached to
anything. I'm reworking the patches anyways so I'll reorganize this,
thanks!

-Leah

> 
> > diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> > index 78710788c237..5ff2c42cb46c 100644
> > --- a/fs/ocfs2/alloc.c
> > +++ b/fs/ocfs2/alloc.c
> > @@ -6020,7 +6020,7 @@ int __ocfs2_flush_truncate_log(struct ocfs2_super *osb)
> >  	 * Then truncate log will be replayed resulting in cluster double free.
> >  	 */
> >  	jbd2_journal_lock_updates(journal->j_journal);
> > -	status = jbd2_journal_flush(journal->j_journal);
> > +	status = jbd2_journal_flush(journal->j_journal, false);
> >  	jbd2_journal_unlock_updates(journal->j_journal);
> >  	if (status < 0) {
> >  		mlog_errno(status);
> > diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> > index db52e843002a..1c356b29c66d 100644
> > --- a/fs/ocfs2/journal.c
> > +++ b/fs/ocfs2/journal.c
> > @@ -310,7 +310,7 @@ static int ocfs2_commit_cache(struct ocfs2_super *osb)
> >  	}
> >  
> >  	jbd2_journal_lock_updates(journal->j_journal);
> > -	status = jbd2_journal_flush(journal->j_journal);
> > +	status = jbd2_journal_flush(journal->j_journal, false);
> >  	jbd2_journal_unlock_updates(journal->j_journal);
> >  	if (status < 0) {
> >  		up_write(&journal->j_trans_barrier);
> > @@ -1002,7 +1002,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
> >  
> >  	if (ocfs2_mount_local(osb)) {
> >  		jbd2_journal_lock_updates(journal->j_journal);
> > -		status = jbd2_journal_flush(journal->j_journal);
> > +		status = jbd2_journal_flush(journal->j_journal, false);
> >  		jbd2_journal_unlock_updates(journal->j_journal);
> >  		if (status < 0)
> >  			mlog_errno(status);
> > @@ -1072,7 +1072,7 @@ int ocfs2_journal_load(struct ocfs2_journal *journal, int local, int replayed)
> >  
> >  	if (replayed) {
> >  		jbd2_journal_lock_updates(journal->j_journal);
> > -		status = jbd2_journal_flush(journal->j_journal);
> > +		status = jbd2_journal_flush(journal->j_journal, false);
> >  		jbd2_journal_unlock_updates(journal->j_journal);
> >  		if (status < 0)
> >  			mlog_errno(status);
> > @@ -1668,7 +1668,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
> >  
> >  	/* wipe the journal */
> >  	jbd2_journal_lock_updates(journal);
> > -	status = jbd2_journal_flush(journal);
> > +	status = jbd2_journal_flush(journal, false);
> >  	jbd2_journal_unlock_updates(journal);
> >  	if (status < 0)
> >  		mlog_errno(status);
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index 99d3cd051ac3..5e4349b76997 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -1491,7 +1491,7 @@ extern int	 jbd2_journal_invalidatepage(journal_t *,
> >  				struct page *, unsigned int, unsigned int);
> >  extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
> >  extern int	 jbd2_journal_stop(handle_t *);
> > -extern int	 jbd2_journal_flush (journal_t *);
> > +extern int	 jbd2_journal_flush(journal_t *journal, bool discard);
> >  extern void	 jbd2_journal_lock_updates (journal_t *);
> >  extern void	 jbd2_journal_unlock_updates (journal_t *);
> >  
> > -- 
> > 2.31.1.527.g47e6f16901-goog
> > 
