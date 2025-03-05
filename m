Return-Path: <linux-ext4+bounces-6669-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E43A4F607
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Mar 2025 05:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D532B188F495
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Mar 2025 04:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706AF1B4248;
	Wed,  5 Mar 2025 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDqIJiBT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7920519258E;
	Wed,  5 Mar 2025 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741148511; cv=none; b=BpKtxzlMGcN/Vn3FSQxHdD04tMr6S/YaCeGuynOyRUnUAXyrkaNSoI6P6mj9wLPJf6xZzPTEZMFUs64pIeQbyYoAojp89V4JlSZ9QAq/ltKtbFrW4CpyzdbkzXjpPFiybXmsiUgs1jynNGNHWGHAxa8D3wlGHE8lbOesu445V/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741148511; c=relaxed/simple;
	bh=r39igoZl7dgIk8L4GFCd6S0dc7M/x4ffj5p5QjTfUF4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GmWzc66O+Sa8OCCrBZmX7vynV4rGU/qMNaRHpA3uY3d4xRXwq+RMojHBzCnpZVfTTo05cUD2spoeFmM12AjxN8WqWmOZhJDM98uFNMLUwsy/yrSfCUffEDg9PEu/pwZz0zEgTf1RfoJZ3OA3yf6a1nGCj7Qk/swnT/S9oGUAV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDqIJiBT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22328dca22fso95343565ad.1;
        Tue, 04 Mar 2025 20:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741148509; x=1741753309; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UAh53tm7x5vjG0oU8skw4hzinBeRfI2F4BZXkPhkiXk=;
        b=CDqIJiBTVhkGpz/E9qeX8d07Iiw6i0IH54q+deXERLqIkcYWWYlgdjEYJ54YdJbD4g
         a6dBcJvaSfCMlVPOY1M/9BC0eU9XyttXv9TFkI2/lKVJC4UvLc9dPRn98leDUg2QdQes
         S6Hpsx+HerpbTNXjDB2i/v8BnfWwCz0QRqVotV/v+Q4seOt2VN5M/Phl/y064400Y4a7
         NFAD8R1FLfI+F2V+o+aCNZwFvUJZd2ivLxeZv+AfDiIrjOmPJS6spCiuqgCzKbq3hS4B
         7MZ0zkPCkPdjShoVQjgzY+xPDxR2Q5NlQKHJsNWPxiGly6RFROUlz/dwp5dwMP9wwQrm
         KYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741148509; x=1741753309;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAh53tm7x5vjG0oU8skw4hzinBeRfI2F4BZXkPhkiXk=;
        b=hC5AlkpfGRkrO+DPjLnE0H+AB86sNm3LxxDrWVfOaAnq6fO5SlbkFsTEVuv/3y+ztD
         KUHP/Ty/LDtbGT7Qtp1c3ORxNM+SUpXu0FqihLMuuoy17CyH/wxzRjvVPA9vf/slXmv+
         5mNpD8v7zuqPXzBBGrPB+Sb6kxPw7EbuSsA6nfl7gBHpoKp5nc79t+JGcJAzUThLrX82
         18uRS4wfJQBjfggECeT4PW2fS3buq8Bgts/c7/2h7uWM4KRtAc74frEQgRGbbd1SIY+R
         x0oIM9GZkkoFYK3AmuVY1QJh36qlwyi1tTloJAizw+nKtLNi6IxL5Z4ExxlxjSQEZ0iO
         dSCA==
X-Forwarded-Encrypted: i=1; AJvYcCUowd9ltnSVymET3XFCtZ7fdRpuF9S4XE2+IrN2Mr1wIB65l3BbI73r5JNcDd+mfZDxRx61tbmzmgmK@vger.kernel.org, AJvYcCX+gF0Ua3yHb6z6yaXYZkAUTdOoi/yw1IMNDkEdat9iFGkS8YAJdgdJlQ8b1KXQMpjQB5XtvVbg1g21H9nc@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNivlLNgNAQCD4kMeBlhbMzEFobd3I2K/ypPYANWjkDB9l5S+
	dKkvCll367l7k1uRdO0seQiFCrSgwMU4mVJfsD8t+/i4EXXI0gTs
X-Gm-Gg: ASbGncuuOvg1bjqWp7wUmiB/July+q+kuyibaN38nOckViZeSMNJnX0R4xCgb8MCSua
	cdWNTUdlv3FvSIimSOTW2bMktI+kIu31Hsl1nfdgxwxSanSwe6Set1CTTiOYoeMAb+5EmNZEQe4
	11n7EuHV+xTAi6Y75XtCWvNcK8PilKiGP2slVmH1KTbKSRkTr5AEJBTDs2omYdTRcvD3yWW1N13
	MecBTcCHI3UO4IlPBXkmUngFb1L5bLHPPKnAN2hZpbpmd+R39mFa1/2VGjtXdH2eNvgnCkD8jwK
	BKeD+jV6c/iO4VlYJw5xtFUhgDgUDTc+WIk8bg==
X-Google-Smtp-Source: AGHT+IGoBkcH/43EbZ0MvtYc8TWxOHbWCha9H3ge0TtLf882lJlPh2lYjS+JuhCtecXTELqXJbjQJA==
X-Received: by 2002:a05:6a00:244f:b0:736:5c8e:bab8 with SMTP id d2e1a72fcca58-73682b5510amr2833593b3a.3.1741148508594;
        Tue, 04 Mar 2025 20:21:48 -0800 (PST)
Received: from dw-tp ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ebe7sm12244010b3a.134.2025.03.04.20.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:21:47 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
In-Reply-To: <mpm3x7uonxoc73lgva72vaiydc76cmr5niapm45ipk6ts5voab@e7zundhoui6i>
Date: Wed, 05 Mar 2025 09:44:54 +0530
Message-ID: <87eczc6rlt.fsf@gmail.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com> <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com> <jnxpphuradrsf73cxfmohfu7wwwckihtulw6ovsitddgt5pqkg@2uoejkr66qnl> <Z8BKdo5IAHJRdMkp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <mpm3x7uonxoc73lgva72vaiydc76cmr5niapm45ipk6ts5voab@e7zundhoui6i>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Jan Kara <jack@suse.cz> writes:

> On Thu 27-02-25 16:50:22, Ojaswin Mujoo wrote:
>> On Mon, Feb 24, 2025 at 03:52:00PM +0100, Jan Kara wrote:
>> > On Sat 22-02-25 14:10:22, Ojaswin Mujoo wrote:
>> > > Presently we always BUG_ON if trying to start a transaction on a journal
>> > > marked with JBD2_UNMOUNT, since this should never happen. However while
>> > > running stress tests it was observed that in case of some error handling
>> > > paths, it is possible for update_super_work to start a transaction after
>> > > the journal is destroyed eg:
>> > > 
>> > > (umount)
>> > > ext4_kill_sb
>> > >   kill_block_super
>> > >     generic_shutdown_super
>> > >       sync_filesystem /* commits all txns */
>> > >       evict_inodes
>> > >         /* might start a new txn */
>> > >       ext4_put_super
>> > > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>> > >         jbd2_journal_destroy
>> > >           journal_kill_thread
>> > >             journal->j_flags |= JBD2_UNMOUNT;
>> > >           jbd2_journal_commit_transaction
>> > >             jbd2_journal_get_descriptor_buffer
>> > >               jbd2_journal_bmap
>> > >                 ext4_journal_bmap
>> > >                   ext4_map_blocks
>> > >                     ...
>> > >                     ext4_inode_error
>> > >                       ext4_handle_error
>> > >                         schedule_work(&sbi->s_sb_upd_work)
>> > > 
>> > >                                                /* work queue kicks in */
>> > >                                                update_super_work
>> > >                                                  jbd2_journal_start
>> > >                                                    start_this_handle
>> > >                                                      BUG_ON(journal->j_flags &
>> > >                                                             JBD2_UNMOUNT)
>> > > 
>> > > Hence, make sure we only defer the update of ext4 sb if the sb is still
>> > > active.  Otherwise, just fallback to an un-journaled commit.
>> > > 
>> > > The important thing to note here is that we must only defer sb update if
>> > > we have not yet flushed the s_sb_update_work queue in umount path else
>> > > this race can be hit (point 1 below). Since we don't have a direct way
>> > > to check for that we use SB_ACTIVE instead. The SB_ACTIVE check is a bit
>> > > subtle so adding some notes below for future reference:
>> > > 
>> > > 1. Ideally we would want to have a something like (flags & JBD2_UNMOUNT
>> > > == 0) however this is not correct since we could end up scheduling work
>> > > after it has been flushed:
>> > > 
>> > >  ext4_put_super
>> > >   flush_work(&sbi->s_sb_upd_work)
>> > > 
>> > >                            **kjournald2**
>> > >                            jbd2_journal_commit_transaction
>> > >                            ...
>> > >                            ext4_inode_error
>> > >                              /* JBD2_UNMOUNT not set */
>> > >                              schedule_work(s_sb_upd_work)
>> > > 
>> > >    jbd2_journal_destroy
>> > >     journal->j_flags |= JBD2_UNMOUNT;
>> > > 
>> > >                                       **workqueue**
>> > >                                       update_super_work
>> > >                                        jbd2_journal_start
>> > >                                         start_this_handle
>> > >                                           BUG_ON(JBD2_UNMOUNT)
>> > > 
>> > > Something like the above doesn't happen with SB_ACTIVE check because we
>> > > are sure that the workqueue would be flushed at a later point if we are
>> > > in the umount path.
>> > > 
>> > > 2. We don't need a similar check in ext4_grp_locked_error since it is
>> > > only called from mballoc and AFAICT it would be always valid to schedule
>> > > work here.
>> > > 
>> > > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
>> > > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
>> > > Suggested-by: Ritesh Harjani <ritesh.list@gmail.com>
>> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> > 
>> > Good catch! But I think the solution will have to be slightly different.
>> > Basing the check on SB_ACTIVE has the problem that you can have racing
>> > updates of the sb in the still running transaction and in your direct
>> > update leading to inconsistencies after a crash (that was the reason why
>> > we've created the s_sb_upd_work in the first place).
>> > 
>> > I would solve this by implementing something like
>> > ext4_update_sb_destroy_journal() which will set a flag in sbi, flush the
>> > workqueue, and then destroy the journal. And ext4_handle_error() will check
>> > for the sbi flag.
>> > 
>> > 								Honza
>> 
>> Hey Jan,
>> 
>> Thanks for the review. So earlier I did go through different code paths to see
>> if we will have a direct sb write clash with a journalled one it wouldn't but,
>> relooking at it, seems like we might have a scenario as follows:
>> 
>> generic_super_shutdown
>>  sync_filesytems
>>   /* running txns committed. executing ext4_journal_commit_callback */
>>   ext4_maybe_update_superblock
>>    /* schedules work */
>>    schedule_work(&sbi->s_sb_upd_work)
>>                                           update_super_work
>>                                           /* start a txn and add sb to it */
>>  sb->s_flags &= ~SB_ACTIVE;
>>  evict_inode
>>    ext4_evict_inode
>>     ext4_std_error
>>      ext4_handle_error
>>       /* direct commit of sb (Not good!) */
>> 

Ohk. So even after clearing SB_ACTIVE flag, we still have FS operations
running like ext4_evict_inode which can race with the super block update
work starting a txn. 

Thanks for catching that scenario.


>> 
>> Now with the 'setting the flag in sbi' approach, I'm not sure if that will be
>> enough to handle this as well. For example, if we add a flag like
>> sbi->s_journal_destroying, then:
>> 
>> ext4_put_super
>>  sbi->s_journal_destroying = true
>>  flush_workqueue()
>>   /* sb is now journalled */
>>  jbd2_journal_destory
>>   jbd2_journal_commit_transaction
>>    /* add tag for sb in descriptor and add buffer to wbufs[] */
>>    /* Later from some other buffer in the txn: */
>>    jbd2_journal_next_log_block
>>     /* hits error in ext4_journal_bmap */
>>     ext4_handle_error
>>       sbi->s_journal_destroying == true
>>       /* update and commit sb directly causing a checksum mismatch b/w entry in descriptor */
>>    jbd2_journal_abort
>>    /* after abort everything in wbufs[] is written to journal */
>> 
>> In the above we will have a checksum mismatch but then maybe its not really
>> an issue. Maybe since we never commit the txn it is understood that the contents
>> can't be trusted and it should be fine to have a mismatch b/w the decriptor tag
>> and the actual super block contents? In which case the sbi flag approach should
>> be fine.
>> 
>> Does my understanding sound correct?
>
> Yes. Since the transaction does not get committed, its contents will be
> (and must be) ignored. So although you are correct that the superblock
> content in the transaction need to match the content we write directly, it
> does not matter because whatever is in the uncommitted transaction must
> never be written to the final position on disk.
>
> 								Honza

Thanks Jan for the suggestion. I now see what you meant by having an sbi
flag. Since that is local to ext4, we can set it just before flushing
the workqueue and we know that there won't be any update super block
work which can start a txn after flushing is complete. This flag can
then be used to check in any of the error handling paths to decide on
whether to schedule a new update work or not for updating sb.

This makes sense. Thanks for the review!

-ritesh

