Return-Path: <linux-ext4+bounces-6739-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9ADA58B47
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 05:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A343A56DC
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 04:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A821BDA97;
	Mon, 10 Mar 2025 04:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWj4s5Tg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517222F19;
	Mon, 10 Mar 2025 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741582336; cv=none; b=OM6cWFE1T9Zl0HdCkcSwzzW1pOmPEF6QMLuDrxbl5RJr/d67unDuiXwWbHcBSmu78EGlzcy9ZWxVdE8VBWoGF9x5hIQHiva2ZU5uoXK6JsfDSdz+E4DtEvTxXLCp0wmicyytKBjFBKVPv+MKp4XAMshDyQcALnKGzVSA0lHxK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741582336; c=relaxed/simple;
	bh=c2Kb6GBTy1FNaZha5z5DlQW5jEUjKvvg42tkxZoyw/c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=JMRCQMZi5+9b9XjqwUURNi77Idw7DLsl6FK0bU3JQHDrO7HBhbPLljSK4jitcF7lTDSsjpBU3YUnLFJJy6BQ9Gw3Xdydtzvx+BKUlIcKxshoPBQmk7CutnnyHzAA7cIeH4yRCSH8aZg71r8J/6LHIfe9l8gukFuRypVstZeN9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWj4s5Tg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22401f4d35aso65216405ad.2;
        Sun, 09 Mar 2025 21:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741582334; x=1742187134; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hPZPoRjcyOE0kbrctulab7lfdybsIPALCBgsQ7KETJ4=;
        b=RWj4s5TgimPwEt1z/LIzS1fFKm1EMm2XWGhrEDgxENm0SPFsbqtQTxIKZxeofhWfdh
         IE+E+s03wDU8pi2yXTGUrGKg90Bkh6oGXhM3yZpwv3ArtjQ1NWjAwV1GdiBCgJtVMJ0l
         ByAjsnVjnJMuGejrv6ZN78YLxVXmJCNXjMIv1YF5KJJqg6mjvytl8h0Gtlk/IkLSdmpG
         AEYpmlxvoZOwih744Rkbvrxb5MHdo7db50h1I8zUjw3yj9wdK9VIr3Y76ZT8MA2wPoR1
         tLVltlLCvUxyd4aYvafYUVEAjyFalNE3AK+pX1uCqypauan61K6ZN13xIq+ufNlmGdA2
         3vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741582334; x=1742187134;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPZPoRjcyOE0kbrctulab7lfdybsIPALCBgsQ7KETJ4=;
        b=j4PXDdE2eCDHIxw8az8IlKnzP+tqDQ9T21B8j6QKEU3UrcObDsYkxzBcJXrS4mbk7j
         /C7eRqFK0N4umLJrxw2AjIzkN7wu5RjHbBQi9ZTpMbo3Tqse0QrPWhT1w1M3geio1gfR
         U9zi7rO4Z7VGzGtkySfwic6i7NxcXXY43nGOHs8GWNioEy0OpLZ8Dmrk2odqmx3RcCqh
         HbxtONJpwub7e7MsllYyfVPjXUNXY3nfqZiVWPlf5Qsx1jhxOGqtvkB1797v60eONpxG
         p4R3PlrpCUmS1LDTadODWv9TX+CrE2vLeFPwprMIGiOw6fHI7+aBEnCZO5Y8O64gvDkn
         cdIw==
X-Forwarded-Encrypted: i=1; AJvYcCXRD/H1zTbgynWhoPLde6THxIFC/C3mArXFrLYct4hXwkqS+dMcMN4qdxC1P8PxXULcuKAvZyUjRGJwmH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQbWITBEQ12LtXqqYW8ra+TJFUNWOvoJkF42HeMcRSiaJYsLCp
	8nnNKDbN8Pim92niMfyX6PHi68rXbf39UtF04I18/zZSqqDwcUBI
X-Gm-Gg: ASbGncu53JRAEfNSgCpaBSHxbdT40GMgD4WkG1v97lKcGm+3n3XomzHwvNJU7Y6chiL
	Xo0qgQ163Fx1VMUOaee/YWKfs49Uul+2pIorbng4UWV++dkEOAGcBmzKXyP/lW8zONwna0bpmCB
	Hr77+0QQ0mtjfeYdFgVbQX+eVY+I9U6K/lTZBmOQPttdfTGqVCT2amufkZEiM/vqVqSFFQDh1Po
	xkE8Y/NfmPqOLM9GO3ZRdj39TnE78Oyf2zrlKaAPb0b6fdgVeHa9NK9J8q+rTMXWKy+e4B7FqyI
	2SN6I5V1gD+XzHFk56y9LDrmUZ9/xsuPeQ4=
X-Google-Smtp-Source: AGHT+IFRtkC/DBfRCvqYBXy5Q8Qy7y8OJI4ja/YusGuNdRdfzfjhOo4bdDCGs3xuzorPAKe2zbXwhQ==
X-Received: by 2002:a05:6a21:6e4c:b0:1f5:790c:947 with SMTP id adf61e73a8af0-1f5790c0c79mr4641673637.19.1741582333458;
        Sun, 09 Mar 2025 21:52:13 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d47f9da3sm1502444b3a.137.2025.03.09.21.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 21:52:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if journal is destroying
In-Reply-To: <Z82EjcExRMc8nz2v@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Date: Mon, 10 Mar 2025 10:13:36 +0530
Message-ID: <871pv5cx6v.fsf@gmail.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com> <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com> <87ldtfhmo7.fsf@gmail.com> <Z8xAmyICsNlln4Y3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <87ecz7hcw0.fsf@gmail.com> <Z8xbLrdN3L1E50-G@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <87cyergyb1.fsf@gmail.com> <Z82EjcExRMc8nz2v@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> On Sun, Mar 09, 2025 at 12:11:22AM +0530, Ritesh Harjani wrote:
>> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>> 
>> > On Sat, Mar 08, 2025 at 06:56:23PM +0530, Ritesh Harjani wrote:
>> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>> >> 
>> >> > On Sat, Mar 08, 2025 at 03:25:04PM +0530, Ritesh Harjani (IBM) wrote:
>> >> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>> >> >> 
>> >> >> > Presently we always BUG_ON if trying to start a transaction on a journal marked
>> >> >> > with JBD2_UNMOUNT, since this should never happen. However, while ltp running
>> >> >> > stress tests, it was observed that in case of some error handling paths, it is
>> >> >> > possible for update_super_work to start a transaction after the journal is
>> >> >> > destroyed eg:
>> >> >> >
>> >> >> > (umount)
>> >> >> > ext4_kill_sb
>> >> >> >   kill_block_super
>> >> >> >     generic_shutdown_super
>> >> >> >       sync_filesystem /* commits all txns */
>> >> >> >       evict_inodes
>> >> >> >         /* might start a new txn */
>> >> >> >       ext4_put_super
>> >> >> > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>> >> >> >         jbd2_journal_destroy
>> >> >> >           journal_kill_thread
>> >> >> >             journal->j_flags |= JBD2_UNMOUNT;
>> >> >> >           jbd2_journal_commit_transaction
>> >> >> >             jbd2_journal_get_descriptor_buffer
>> >> >> >               jbd2_journal_bmap
>> >> >> >                 ext4_journal_bmap
>> >> >> >                   ext4_map_blocks
>> >> >> >                     ...
>> >> >> >                     ext4_inode_error
>> >> >> >                       ext4_handle_error
>> >> >> >                         schedule_work(&sbi->s_sb_upd_work)
>> >> >> >
>> >> >> >                                                /* work queue kicks in */
>> >> >> >                                                update_super_work
>> >> >> >                                                  jbd2_journal_start
>> >> >> >                                                    start_this_handle
>> >> >> >                                                      BUG_ON(journal->j_flags &
>> >> >> >                                                             JBD2_UNMOUNT)
>> >> >> >
>> >> >> > Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
>> >> >> > destroying only do a journaled (and deferred) update of sb if this flag is not
>> >> >> > set. Otherwise, just fallback to an un-journaled commit.
>> >> >> >
>> >> >> > We set sbi->s_journal_destroying = true only after all the FS updates are done
>> >> >> > during ext4_put_super() (except a running transaction that will get commited
>> >> >> > during jbd2_journal_destroy()). After this point, it is safe to commit the sb
>> >> >> > outside the journal as it won't race with a journaled update (refer
>> >> >> > 2d01ddc86606).
>> >> >> >
>> >> >> > Also, we don't need a similar check in ext4_grp_locked_error since it is only
>> >> >> > called from mballoc and AFAICT it would be always valid to schedule work here.
>> >> >> >
>> >> >> > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
>> >> >> > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
>> >> >> > Suggested-by: Jan Kara <jack@suse.cz>
>> >> >> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> >> >> > ---
>> >> >> >  fs/ext4/ext4.h      | 2 ++
>> >> >> >  fs/ext4/ext4_jbd2.h | 8 ++++++++
>> >> >> >  fs/ext4/super.c     | 4 +++-
>> >> >> >  3 files changed, 13 insertions(+), 1 deletion(-)
>> >> >> >
>> >> >> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> >> >> > index 2b7d781bfcad..d48e93bd5690 100644
>> >> >> > --- a/fs/ext4/ext4.h
>> >> >> > +++ b/fs/ext4/ext4.h
>> >> >> > @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
>> >> >> >  	 */
>> >> >> >  	struct work_struct s_sb_upd_work;
>> >> >> >  
>> >> >> > +	bool s_journal_destorying;
>> >> >> > +
>> >> >> >  	/* Atomic write unit values in bytes */
>> >> >> >  	unsigned int s_awu_min;
>> >> >> >  	unsigned int s_awu_max;
>> >> >> > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
>> >> >> > index 9b3c9df02a39..6bd3ca84410d 100644
>> >> >> > --- a/fs/ext4/ext4_jbd2.h
>> >> >> > +++ b/fs/ext4/ext4_jbd2.h
>> >> >> > @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
>> >> >> >  {
>> >> >> >  	int err = 0;
>> >> >> >  
>> >> >> > +	/*
>> >> >> > +	 * At this point all pending FS updates should be done except a possible
>> >> >> > +	 * running transaction (which will commit in jbd2_journal_destroy). It
>> >> >> > +	 * is now safe for any new errors to directly commit superblock rather
>> >> >> > +	 * than going via journal.
>> >> >> > +	 */
>> >> >> > +	sbi->s_journal_destorying = true;
>> >> >> 
>> >> >> This is not correct right. I think what we decided to set this flag
>> >> >> before we flush the workqueue. So that we don't schedule any new
>> >> >> work after this flag has been set. At least that is what I understood.
>> >> >> 
>> >> >> [1]: https://lore.kernel.org/all/87eczc6rlt.fsf@gmail.com/
>> >> >> 
>> >> >> -ritesh
>> >> >
>> >> > Hey Ritesh,
>> >> >
>> >> > Yes that is not correct, I missed that in my patch however we realised
>> >> > that adding it before flush_work() also has issues [1]. More
>> >> > specifically:
>> >> 
>> >> Ohk. right. 
>> >> 
>> >> >
>> >> >                      **kjournald2**
>> >> >                      jbd2_journal_commit_transaction()
>> >> >                      ...
>> >> >                      ext4_handle_error()
>> >> >                         /* s_journal_destorying is not set */
>> >> >                         if (journal && !s_journal_destorying)
>> >> 
>> >> Then maybe we should not schedule another work to update the superblock
>> >> via journalling, it the error itself occurred while were trying to
>> >> commit the journal txn? 
>> >> 
>> >> 
>> >> -ritesh
>> >
>> > Hmm, ideally yes that should not happen, but how can we achieve that?
>> > For example with the trace we saw:
>> >
>> >    **kjournald2**
>> >    jbd2_journal_commit_transaction()
>> >      jbd2_journal_get_descriptor_buffer
>> >        jbd2_journal_bmap
>> >          ext4_journal_bmap
>> >            ext4_map_blocks
>> >              ...
>> >              ext4_inode_error
>> >                ext4_handle_error
>> >                  schedule_work(&sbi->s_sb_upd_work)
>> >
>> > How do we tell ext4_handle_error that it is in the context of a
>> > committing txn.
>> 
>> So even if we identify that the current
>> jbd2_journal_commit_transaction() is coming from kjournald2(), that is
>> sufficient right? Because the only other place where we call
>> jbd2_journal_commit_transaction() is jbd2_journal_destroy() and that
>> happens after we can set few things from ext4_put_super() and flush work
>> is completed, correct? 
>> 
>> 
>> > We can't pass down an argument all the way down 
>> > cause that is not feasible. An sb level flag will also not work
>> > I think. Any thoughts on this?
>> 
>> I was thinking if we should have a per task flag? Something like
>> PF_KJOURNALD?  (Similar to how we have PF_KSWAPD or PF_KCOMPACTD)? This
>> can help us identify if we are a kjournald2() kthread.
>> 
>> That will help prevent scheduling another work item to start a new
>> transaction in case an error occurs while committing the currently
>> running transaction. Correct?
>
> Yes, I like this approach. I think this will also help us avoid the
> extra checks in ext4_journal_destroy() since the journal will no longer
> schecule work for updating the sb. Hence we can be sure that after the
> final flush_work() noone will try to schedule more work or start a new
> transaction.
>
> I'll try to spin up a poc and test it. Does seem like we are out of flags in 
> task struct though.
>
> Regards,
> ojaswin
>
>> 
>> Now I don't know if we have any free bit available in current->flags. If
>> not shall we use current->journal_info pointer to have 0th bit as a
>> flag? Basically override current->journal_info to also store a flag.  We
>> can create a wrapper to get the journal_info from current by masking
>> this flag bit and use it to dereference journal_info.
>
> Hmm so journal_info will be holding a kernel address of the handle. Is
> it possible to have it share a flag as well? I thought the address would
> utilize the full 64bits?


What I meant here was - 
In general I assume we should be able to play some tricks with a pointer
which at least should be 4 byte aligned. So we can save some flag bits in
the lower bits of a pointer.  For e.g. check struct address_space &
PAGE_MAPPING_FLAGS. There maybe few other examples too.


-ritesh


>
> Regards,
> ojaswin
>
>> 
>> But before going down that road, it's better to know what others think?
>> 
>> -ritesh
>> 
>> 
>> >
>> > regards,
>> > ojaswin
>> >
>> >> 
>> >> 
>> >> >   ext4_put_super()
>> >> >     sbi->s_journal_destorying = true;
>> >> >     flush_work(&sbi->s_sb_upd_work)
>> >> >                                       schedule_work()
>> >> >     jbd2_journal_destroy()
>> >> >      journal->j_flags |= JBD2_UNMOUNT;
>> >> >
>> >> >                                         jbd2_journal_start()
>> >> >                                          start_this_handle()
>> >> >                                            BUG_ON(JBD2_UNMOUNT)
>> >> >
>> >> > So the right thing to do seems to be that we need to force a journal
>> >> > commit before the final flush as well. [1] Has more info on this and
>> >> > some followup discussion as well.
>> >> >
>> >> > [1] https://lore.kernel.org/all/cover.1741270780.git.ojaswin@linux.ibm.com/T/#mc8046d47b357665bdbd2878c91e51eb660f94b3e
>> >> >
>> >> > Regards,
>> >> > ojaswin
>> >> >> 
>> >> >> 
>> >> >> > +
>> >> >> >  	err = jbd2_journal_destroy(journal);
>> >> >> >  	sbi->s_journal = NULL;
>> >> >> >  
>> >> >> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> >> >> > index 8ad664d47806..31552cf0519a 100644
>> >> >> > --- a/fs/ext4/super.c
>> >> >> > +++ b/fs/ext4/super.c
>> >> >> > @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>> >> >> >  		 * constraints, it may not be safe to do it right here so we
>> >> >> >  		 * defer superblock flushing to a workqueue.
>> >> >> >  		 */
>> >> >> > -		if (continue_fs && journal)
>> >> >> > +		if (continue_fs && journal && !EXT4_SB(sb)->s_journal_destorying)
>> >> >> >  			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
>> >> >> >  		else
>> >> >> >  			ext4_commit_super(sb);
>> >> >> > @@ -5311,6 +5311,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>> >> >> >  	spin_lock_init(&sbi->s_error_lock);
>> >> >> >  	INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
>> >> >> >  
>> >> >> > +	sbi->s_journal_destorying = false;
>> >> >> > +
>> >> >> >  	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
>> >> >> >  	if (err)
>> >> >> >  		goto failed_mount3;
>> >> >> > -- 
>> >> >> > 2.48.1

