Return-Path: <linux-ext4+bounces-6731-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAAA57AC3
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08115163D5F
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A901B0F26;
	Sat,  8 Mar 2025 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYH71tXM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D112EAE4;
	Sat,  8 Mar 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441913; cv=none; b=j2j9HNdsA6edluzU8OUBILsP3s3CkgLfZoHsIeseZKaNbPlwdRSt4hH7wdyplvAaZNLPWVJym4JJ8IyrNXxblS8zmAsImZa3HMYo4PivChEhQbfAPzo5bUZWRMIhN/DNdyVeotFZ7JbtFnkaWbuZF0HIbi31phIBUISoZOhsJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441913; c=relaxed/simple;
	bh=cL5RxX5L5EdP4FR8cTWxkBojFQLZJNsAilddeOnoND8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=qwIPLqZBHiuBdXScqq5v1ZYDOVJYCZlVdvnZ0OMUwSKOfgiFNcX9aNXJuiN2qUTdZlNu7EL/HesjEDp4ca427PrVBanmkAP67fTXcwJ/+I5G6OpSEaJz473aWifyW1xRK+dXc6VqCgWUyxGJlyfaPvYxfkQid4ruJb2aOi6Q3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYH71tXM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22435603572so18699605ad.1;
        Sat, 08 Mar 2025 05:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741441911; x=1742046711; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=izxwKf3mvCu3B8NG8cXY6B+JHqHpvXGBwVkODqPj+q0=;
        b=RYH71tXMkXN+qEXKAZ6oPNQhQJWtJYcK48GGpQWVVXU02QPwcpGnXdQCrPvaJCzdVO
         /No+2Y/oTmXoIwK0/Gc3OtZ8HKzvu0CrU7iY1pr7j9UfxF6vQtVmdG0HYkHr//qnsMr+
         CvT4d44Bb7LC/VohC62rUCARpV5D2SeoczJNUZB0Y/4dub43fHCeYhqndu/upGtfn4mb
         42AStFZ5ewpLcbDoG8nk7Toe5uSvrksTlgGZ3FeLwL1pVLvEAhKtjh3bwLXT3fbStj9K
         KgAa6ge70k+bkcz1RU8msM6hpPvW7jrm8k5sRTfa5pYx0Ae7/m3xO6aFP9fRMFMQDaHG
         ok4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741441911; x=1742046711;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izxwKf3mvCu3B8NG8cXY6B+JHqHpvXGBwVkODqPj+q0=;
        b=c3DwLql+cMjuWOfQEwfvzuHDtH8wo4b13+PZ7VMnIDTUtdt2bVJVHsuu4oh2m/mCE+
         /zdvcJ9WbNg86zXhZQDtX/pJcLsQyR4oO5IrPCvsFlJ+5pTHHV9FmOKdhLDuf4HFIsCS
         gE+GBWmMz8wjklYgz3HEfLuu2Qz+FxolSy7gtJCcSqg6S6mg6bPXvLYID/gcMMxB6bdE
         9dP/NuFINgq/zuk1haIAhQOBXsOC4yl5U/AcMpGIkDQ9FfYLQowhMV3QxeH4zofPzUcF
         fFCz8H/cHFvehPhI/SQnv4lbiuTRXdTrMw/c0o6FaZfLCWD0UFdm9epmLe7oi3FWKQQ1
         LOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMmpexTgRlnN16I71oUwREiW65zCUF/iQHKC7GA8ENrj4XKTWpLJo9a3mX4Ed8ij/msJUVV0oB25xit6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlO4gQEjxvuetfwj9d0/JZsKFTnZZbPjiAAF3ZSP5SYeyC8+Y
	mMpkWb/WO4Ql3w5L56LFUwd9A1KfJtpjbIk4m6tiJYOVpqpVGsyI
X-Gm-Gg: ASbGncsokyZINAJO3+TZBvDHQVwAfHKXVr60IZSdU35n5ppbGOfwsZ2qJfuZWexlXc6
	zQO4v+92lZDckARi9SgX3NXamU7cPiP8DahSE/KuwYFMHcy2vdaxHuQkGMQU6QHVN0sB99k3ABd
	CQuQXrxK2IneBaBBfh+UqU3WQsj8Ql0KsiWChfdwBB2fe3qFrffDPQBepWijqPdkY7Gg57LOm9B
	PHzOeZJZC2ERXFJe1eQpX3iJVJn3Hy0HAvuXJTUn01HzvVzLTA5aNPqYybDbSUHVBh7emWvVdlt
	RcErPGEkqGB/KUDwcNMTyOdB1oSGmiUT1Ek=
X-Google-Smtp-Source: AGHT+IGdJtJPhQbQvU0vPoeEuEDvXo0gYQ1xfj6VFcQ36XoMhCkuoNkIDRwOm9zNbumIKWfRazCtEA==
X-Received: by 2002:a05:6a00:4b4a:b0:736:6ac4:d1ff with SMTP id d2e1a72fcca58-736aa9e7154mr12598445b3a.3.1741441910784;
        Sat, 08 Mar 2025 05:51:50 -0800 (PST)
Received: from dw-tp ([171.76.82.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b3f2412csm2662283b3a.175.2025.03.08.05.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 05:51:50 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if journal is destroying
In-Reply-To: <Z8xAmyICsNlln4Y3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Date: Sat, 08 Mar 2025 18:56:23 +0530
Message-ID: <87ecz7hcw0.fsf@gmail.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com> <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com> <87ldtfhmo7.fsf@gmail.com> <Z8xAmyICsNlln4Y3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> On Sat, Mar 08, 2025 at 03:25:04PM +0530, Ritesh Harjani (IBM) wrote:
>> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>> 
>> > Presently we always BUG_ON if trying to start a transaction on a journal marked
>> > with JBD2_UNMOUNT, since this should never happen. However, while ltp running
>> > stress tests, it was observed that in case of some error handling paths, it is
>> > possible for update_super_work to start a transaction after the journal is
>> > destroyed eg:
>> >
>> > (umount)
>> > ext4_kill_sb
>> >   kill_block_super
>> >     generic_shutdown_super
>> >       sync_filesystem /* commits all txns */
>> >       evict_inodes
>> >         /* might start a new txn */
>> >       ext4_put_super
>> > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>> >         jbd2_journal_destroy
>> >           journal_kill_thread
>> >             journal->j_flags |= JBD2_UNMOUNT;
>> >           jbd2_journal_commit_transaction
>> >             jbd2_journal_get_descriptor_buffer
>> >               jbd2_journal_bmap
>> >                 ext4_journal_bmap
>> >                   ext4_map_blocks
>> >                     ...
>> >                     ext4_inode_error
>> >                       ext4_handle_error
>> >                         schedule_work(&sbi->s_sb_upd_work)
>> >
>> >                                                /* work queue kicks in */
>> >                                                update_super_work
>> >                                                  jbd2_journal_start
>> >                                                    start_this_handle
>> >                                                      BUG_ON(journal->j_flags &
>> >                                                             JBD2_UNMOUNT)
>> >
>> > Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
>> > destroying only do a journaled (and deferred) update of sb if this flag is not
>> > set. Otherwise, just fallback to an un-journaled commit.
>> >
>> > We set sbi->s_journal_destroying = true only after all the FS updates are done
>> > during ext4_put_super() (except a running transaction that will get commited
>> > during jbd2_journal_destroy()). After this point, it is safe to commit the sb
>> > outside the journal as it won't race with a journaled update (refer
>> > 2d01ddc86606).
>> >
>> > Also, we don't need a similar check in ext4_grp_locked_error since it is only
>> > called from mballoc and AFAICT it would be always valid to schedule work here.
>> >
>> > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
>> > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
>> > Suggested-by: Jan Kara <jack@suse.cz>
>> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> > ---
>> >  fs/ext4/ext4.h      | 2 ++
>> >  fs/ext4/ext4_jbd2.h | 8 ++++++++
>> >  fs/ext4/super.c     | 4 +++-
>> >  3 files changed, 13 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> > index 2b7d781bfcad..d48e93bd5690 100644
>> > --- a/fs/ext4/ext4.h
>> > +++ b/fs/ext4/ext4.h
>> > @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
>> >  	 */
>> >  	struct work_struct s_sb_upd_work;
>> >  
>> > +	bool s_journal_destorying;
>> > +
>> >  	/* Atomic write unit values in bytes */
>> >  	unsigned int s_awu_min;
>> >  	unsigned int s_awu_max;
>> > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
>> > index 9b3c9df02a39..6bd3ca84410d 100644
>> > --- a/fs/ext4/ext4_jbd2.h
>> > +++ b/fs/ext4/ext4_jbd2.h
>> > @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
>> >  {
>> >  	int err = 0;
>> >  
>> > +	/*
>> > +	 * At this point all pending FS updates should be done except a possible
>> > +	 * running transaction (which will commit in jbd2_journal_destroy). It
>> > +	 * is now safe for any new errors to directly commit superblock rather
>> > +	 * than going via journal.
>> > +	 */
>> > +	sbi->s_journal_destorying = true;
>> 
>> This is not correct right. I think what we decided to set this flag
>> before we flush the workqueue. So that we don't schedule any new
>> work after this flag has been set. At least that is what I understood.
>> 
>> [1]: https://lore.kernel.org/all/87eczc6rlt.fsf@gmail.com/
>> 
>> -ritesh
>
> Hey Ritesh,
>
> Yes that is not correct, I missed that in my patch however we realised
> that adding it before flush_work() also has issues [1]. More
> specifically:

Ohk. right. 

>
>                      **kjournald2**
>                      jbd2_journal_commit_transaction()
>                      ...
>                      ext4_handle_error()
>                         /* s_journal_destorying is not set */
>                         if (journal && !s_journal_destorying)

Then maybe we should not schedule another work to update the superblock
via journalling, it the error itself occurred while were trying to
commit the journal txn? 


-ritesh


>   ext4_put_super()
>     sbi->s_journal_destorying = true;
>     flush_work(&sbi->s_sb_upd_work)
>                                       schedule_work()
>     jbd2_journal_destroy()
>      journal->j_flags |= JBD2_UNMOUNT;
>
>                                         jbd2_journal_start()
>                                          start_this_handle()
>                                            BUG_ON(JBD2_UNMOUNT)
>
> So the right thing to do seems to be that we need to force a journal
> commit before the final flush as well. [1] Has more info on this and
> some followup discussion as well.
>
> [1] https://lore.kernel.org/all/cover.1741270780.git.ojaswin@linux.ibm.com/T/#mc8046d47b357665bdbd2878c91e51eb660f94b3e
>
> Regards,
> ojaswin
>> 
>> 
>> > +
>> >  	err = jbd2_journal_destroy(journal);
>> >  	sbi->s_journal = NULL;
>> >  
>> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> > index 8ad664d47806..31552cf0519a 100644
>> > --- a/fs/ext4/super.c
>> > +++ b/fs/ext4/super.c
>> > @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>> >  		 * constraints, it may not be safe to do it right here so we
>> >  		 * defer superblock flushing to a workqueue.
>> >  		 */
>> > -		if (continue_fs && journal)
>> > +		if (continue_fs && journal && !EXT4_SB(sb)->s_journal_destorying)
>> >  			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
>> >  		else
>> >  			ext4_commit_super(sb);
>> > @@ -5311,6 +5311,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>> >  	spin_lock_init(&sbi->s_error_lock);
>> >  	INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
>> >  
>> > +	sbi->s_journal_destorying = false;
>> > +
>> >  	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
>> >  	if (err)
>> >  		goto failed_mount3;
>> > -- 
>> > 2.48.1

