Return-Path: <linux-ext4+bounces-6734-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B93A57D91
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 19:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F131892E80
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51A17A2FC;
	Sat,  8 Mar 2025 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUbQm7Ee"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699DC8BFF;
	Sat,  8 Mar 2025 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741460271; cv=none; b=HtD0vxyKbkNv2ed/mASzC7RH22EMjfqzsuo05RzI+7lnNuqSj2T70lVMzhMbTn1HszSXR9lsHKjmOtrIXtNsguvajJFP4FRQeMTI+6ikJNSViojXuSIqnkzW5XopdB4EnUbKQ6br9hQffcfjPfbLHIOo6s0yTFF9NkPSNFXMzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741460271; c=relaxed/simple;
	bh=XmNTWLJqsIjerW9NiA+27YBuZq9mjNlrLg5Xxj8WVLQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=lnbZWXdlot4tFSqNiMtc7GgzsGKXwscucQCaiiI3kXU3/HaW6H0VUgsArpKLKGnxfGmUSAIxsweovIr52g4MP4O3bYlJzboHk0n0qn8v+Q9jY4xNtXt/aZQROymtzrRT1xhDcaOvfwuGrdY2Y7WY0APSiqzEZhMCdnEza6XgylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUbQm7Ee; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso4181769a91.0;
        Sat, 08 Mar 2025 10:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741460269; x=1742065069; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5GgQebRpaI8tg+e2D2WplA5dGl2hw8xIsKdL5v3sIfw=;
        b=nUbQm7EeziTh3rfHjsuHV1fhQXFVYESsDB4ARYfk6OjMTTF07gxs2WV/jWRLiutWXY
         mk890adELhfjPDwBwJPBwETJHAyPbG8p/C3CC66v7ofrt729VBydxMn/r4zD7EHU4VnX
         OTUfhkhJdDnPfqwd3tHOkCOXhVrncStGjkos+ap68Z0WBqNlDd8kB64gIOa7vRz4SPT0
         AxnapHhSeqZefZZ9RLknCT8V9XSZD2P/CT0C6soV0w8E0VkqJdOkJZ1xFCLONUJya/Om
         OpILABs5hBRsfOzfB/920BUBDcJ2Bmvb8s23lQ+p6eTMrArieZzHiVsTq/D1O4o0cr1x
         GI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741460269; x=1742065069;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GgQebRpaI8tg+e2D2WplA5dGl2hw8xIsKdL5v3sIfw=;
        b=btDCHWmqstgFg+vcnwTvnt7VSromuYPt21ULs2PM0V2UGpsAxdZ5yRYmFQSUDILyiY
         lh6JSnufgJgrxEsiwYFDMMIJIFmGANlBAn4GJGsdKuyxlfZ+PXNmF+28NCIbiOFDNP2P
         PMtdtxrMobVFMWwjC3Mg0+bWlYz4ZZf0tVY10kAD48zHLeWcirl4vTxubhz66oJEkesY
         F99h0w4iU0POIINDgcGtCrfT1Q5Q5KUuXzZsyAwJoh8jA6d23JXZGNDjLsE+l/q8e/1J
         ZMQZ+aqnGs8Nwux3B7OEsD0plhJn7sfSMlbhuxRukgXSrQve5VPZDgTUzYRdmZ0WVOBo
         +2VA==
X-Forwarded-Encrypted: i=1; AJvYcCXGQcuBmEzv8ogG+lexYRLTxwwbap7YIQZXScOwtgf1cthpaf0GgrpTaUO5Y3PvX/ClfMQYaCvHdPJgSWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyivAydErXP65xsPX5jOOOa0R16BH1QRY6bktvRj+Co0sYwEV5G
	nRedUQIMgHvT47oin8/Ac0T82YuBz+1ogBy4z5eF8jXwSrx4CBXU
X-Gm-Gg: ASbGncvlNBOakqIWAkqMl8vqYyvJw3epC++muhk5z6IRwOnoBMi8MfS8lNL/76hA30x
	Yc/A39T0rF9I8T/EuH7JRFaVCNDUgS2ljcchinRHcu6ZAmhRvEhvk1Uwfcrn5HD8O3RQbGCN7uJ
	d7sMMpWeQtUjH3SeKLzIt4RNg68ifR8sBr1+6TUV1ueSIzEzwlQ4FDxLZjIqPecZXdeWKvHXY+n
	I1q5EK7plyBc2e38hlFaBteFMfhLIySsrUgxcl9OzPzx8Js7s8o2M0KrdpZZkUbpviSX0FT2kYZ
	WAnbgQIQFL7yFQJLvfkP1Nu0YD+K4VSwNZ4=
X-Google-Smtp-Source: AGHT+IFQNfbGhuNdv9bcKfedwM9w7GN5xsLluOGAk7ccw7yHuc5arby2ETjSD+scF+gJMKUEEBMOoQ==
X-Received: by 2002:a17:90b:3c0d:b0:2fa:228d:5b03 with SMTP id 98e67ed59e1d1-2ff7ce93e84mr11804304a91.19.1741460268510;
        Sat, 08 Mar 2025 10:57:48 -0800 (PST)
Received: from dw-tp ([171.76.82.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ffdd3sm6942707a91.39.2025.03.08.10.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 10:57:47 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if journal is destroying
In-Reply-To: <Z8xbLrdN3L1E50-G@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Date: Sun, 09 Mar 2025 00:11:22 +0530
Message-ID: <87cyergyb1.fsf@gmail.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com> <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com> <87ldtfhmo7.fsf@gmail.com> <Z8xAmyICsNlln4Y3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <87ecz7hcw0.fsf@gmail.com> <Z8xbLrdN3L1E50-G@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> On Sat, Mar 08, 2025 at 06:56:23PM +0530, Ritesh Harjani wrote:
>> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>> 
>> > On Sat, Mar 08, 2025 at 03:25:04PM +0530, Ritesh Harjani (IBM) wrote:
>> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>> >> 
>> >> > Presently we always BUG_ON if trying to start a transaction on a journal marked
>> >> > with JBD2_UNMOUNT, since this should never happen. However, while ltp running
>> >> > stress tests, it was observed that in case of some error handling paths, it is
>> >> > possible for update_super_work to start a transaction after the journal is
>> >> > destroyed eg:
>> >> >
>> >> > (umount)
>> >> > ext4_kill_sb
>> >> >   kill_block_super
>> >> >     generic_shutdown_super
>> >> >       sync_filesystem /* commits all txns */
>> >> >       evict_inodes
>> >> >         /* might start a new txn */
>> >> >       ext4_put_super
>> >> > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>> >> >         jbd2_journal_destroy
>> >> >           journal_kill_thread
>> >> >             journal->j_flags |= JBD2_UNMOUNT;
>> >> >           jbd2_journal_commit_transaction
>> >> >             jbd2_journal_get_descriptor_buffer
>> >> >               jbd2_journal_bmap
>> >> >                 ext4_journal_bmap
>> >> >                   ext4_map_blocks
>> >> >                     ...
>> >> >                     ext4_inode_error
>> >> >                       ext4_handle_error
>> >> >                         schedule_work(&sbi->s_sb_upd_work)
>> >> >
>> >> >                                                /* work queue kicks in */
>> >> >                                                update_super_work
>> >> >                                                  jbd2_journal_start
>> >> >                                                    start_this_handle
>> >> >                                                      BUG_ON(journal->j_flags &
>> >> >                                                             JBD2_UNMOUNT)
>> >> >
>> >> > Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
>> >> > destroying only do a journaled (and deferred) update of sb if this flag is not
>> >> > set. Otherwise, just fallback to an un-journaled commit.
>> >> >
>> >> > We set sbi->s_journal_destroying = true only after all the FS updates are done
>> >> > during ext4_put_super() (except a running transaction that will get commited
>> >> > during jbd2_journal_destroy()). After this point, it is safe to commit the sb
>> >> > outside the journal as it won't race with a journaled update (refer
>> >> > 2d01ddc86606).
>> >> >
>> >> > Also, we don't need a similar check in ext4_grp_locked_error since it is only
>> >> > called from mballoc and AFAICT it would be always valid to schedule work here.
>> >> >
>> >> > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
>> >> > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
>> >> > Suggested-by: Jan Kara <jack@suse.cz>
>> >> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> >> > ---
>> >> >  fs/ext4/ext4.h      | 2 ++
>> >> >  fs/ext4/ext4_jbd2.h | 8 ++++++++
>> >> >  fs/ext4/super.c     | 4 +++-
>> >> >  3 files changed, 13 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> >> > index 2b7d781bfcad..d48e93bd5690 100644
>> >> > --- a/fs/ext4/ext4.h
>> >> > +++ b/fs/ext4/ext4.h
>> >> > @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
>> >> >  	 */
>> >> >  	struct work_struct s_sb_upd_work;
>> >> >  
>> >> > +	bool s_journal_destorying;
>> >> > +
>> >> >  	/* Atomic write unit values in bytes */
>> >> >  	unsigned int s_awu_min;
>> >> >  	unsigned int s_awu_max;
>> >> > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
>> >> > index 9b3c9df02a39..6bd3ca84410d 100644
>> >> > --- a/fs/ext4/ext4_jbd2.h
>> >> > +++ b/fs/ext4/ext4_jbd2.h
>> >> > @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
>> >> >  {
>> >> >  	int err = 0;
>> >> >  
>> >> > +	/*
>> >> > +	 * At this point all pending FS updates should be done except a possible
>> >> > +	 * running transaction (which will commit in jbd2_journal_destroy). It
>> >> > +	 * is now safe for any new errors to directly commit superblock rather
>> >> > +	 * than going via journal.
>> >> > +	 */
>> >> > +	sbi->s_journal_destorying = true;
>> >> 
>> >> This is not correct right. I think what we decided to set this flag
>> >> before we flush the workqueue. So that we don't schedule any new
>> >> work after this flag has been set. At least that is what I understood.
>> >> 
>> >> [1]: https://lore.kernel.org/all/87eczc6rlt.fsf@gmail.com/
>> >> 
>> >> -ritesh
>> >
>> > Hey Ritesh,
>> >
>> > Yes that is not correct, I missed that in my patch however we realised
>> > that adding it before flush_work() also has issues [1]. More
>> > specifically:
>> 
>> Ohk. right. 
>> 
>> >
>> >                      **kjournald2**
>> >                      jbd2_journal_commit_transaction()
>> >                      ...
>> >                      ext4_handle_error()
>> >                         /* s_journal_destorying is not set */
>> >                         if (journal && !s_journal_destorying)
>> 
>> Then maybe we should not schedule another work to update the superblock
>> via journalling, it the error itself occurred while were trying to
>> commit the journal txn? 
>> 
>> 
>> -ritesh
>
> Hmm, ideally yes that should not happen, but how can we achieve that?
> For example with the trace we saw:
>
>    **kjournald2**
>    jbd2_journal_commit_transaction()
>      jbd2_journal_get_descriptor_buffer
>        jbd2_journal_bmap
>          ext4_journal_bmap
>            ext4_map_blocks
>              ...
>              ext4_inode_error
>                ext4_handle_error
>                  schedule_work(&sbi->s_sb_upd_work)
>
> How do we tell ext4_handle_error that it is in the context of a
> committing txn.

So even if we identify that the current
jbd2_journal_commit_transaction() is coming from kjournald2(), that is
sufficient right? Because the only other place where we call
jbd2_journal_commit_transaction() is jbd2_journal_destroy() and that
happens after we can set few things from ext4_put_super() and flush work
is completed, correct? 


> We can't pass down an argument all the way down 
> cause that is not feasible. An sb level flag will also not work
> I think. Any thoughts on this?

I was thinking if we should have a per task flag? Something like
PF_KJOURNALD?  (Similar to how we have PF_KSWAPD or PF_KCOMPACTD)? This
can help us identify if we are a kjournald2() kthread.

That will help prevent scheduling another work item to start a new
transaction in case an error occurs while committing the currently
running transaction. Correct?

Now I don't know if we have any free bit available in current->flags. If
not shall we use current->journal_info pointer to have 0th bit as a
flag? Basically override current->journal_info to also store a flag.  We
can create a wrapper to get the journal_info from current by masking
this flag bit and use it to dereference journal_info.

But before going down that road, it's better to know what others think?

-ritesh


>
> regards,
> ojaswin
>
>> 
>> 
>> >   ext4_put_super()
>> >     sbi->s_journal_destorying = true;
>> >     flush_work(&sbi->s_sb_upd_work)
>> >                                       schedule_work()
>> >     jbd2_journal_destroy()
>> >      journal->j_flags |= JBD2_UNMOUNT;
>> >
>> >                                         jbd2_journal_start()
>> >                                          start_this_handle()
>> >                                            BUG_ON(JBD2_UNMOUNT)
>> >
>> > So the right thing to do seems to be that we need to force a journal
>> > commit before the final flush as well. [1] Has more info on this and
>> > some followup discussion as well.
>> >
>> > [1] https://lore.kernel.org/all/cover.1741270780.git.ojaswin@linux.ibm.com/T/#mc8046d47b357665bdbd2878c91e51eb660f94b3e
>> >
>> > Regards,
>> > ojaswin
>> >> 
>> >> 
>> >> > +
>> >> >  	err = jbd2_journal_destroy(journal);
>> >> >  	sbi->s_journal = NULL;
>> >> >  
>> >> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> >> > index 8ad664d47806..31552cf0519a 100644
>> >> > --- a/fs/ext4/super.c
>> >> > +++ b/fs/ext4/super.c
>> >> > @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>> >> >  		 * constraints, it may not be safe to do it right here so we
>> >> >  		 * defer superblock flushing to a workqueue.
>> >> >  		 */
>> >> > -		if (continue_fs && journal)
>> >> > +		if (continue_fs && journal && !EXT4_SB(sb)->s_journal_destorying)
>> >> >  			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
>> >> >  		else
>> >> >  			ext4_commit_super(sb);
>> >> > @@ -5311,6 +5311,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>> >> >  	spin_lock_init(&sbi->s_error_lock);
>> >> >  	INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
>> >> >  
>> >> > +	sbi->s_journal_destorying = false;
>> >> > +
>> >> >  	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
>> >> >  	if (err)
>> >> >  		goto failed_mount3;
>> >> > -- 
>> >> > 2.48.1

