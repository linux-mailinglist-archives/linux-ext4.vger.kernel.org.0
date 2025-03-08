Return-Path: <linux-ext4+bounces-6724-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD48A579A9
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 11:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728E83AF2B5
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D71B2EFB;
	Sat,  8 Mar 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUonHkhv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F71B0409;
	Sat,  8 Mar 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741428044; cv=none; b=VOxeQ4i/IBwxyZFg/bQc2ahbcUa0Unzdl94FwH4qFNdqsja2yTkgcZkC7X/GJRWnNobvsVyJJ1LTbLbFUd3J9Fb4Yf6mmSAELUUT2a89vha7l1ckfOjHrBjFy1mxqstSvZgYT+DlW8PGF8moCuPDVF0bDUNI5YEiIk7UiXohat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741428044; c=relaxed/simple;
	bh=hOfMBWl0HtY7p6i1BIV62u5V/ut0F3W96lyz5vF72NQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NlWrW08jFhOGtGFn0n2wraqovfBamZwcIOpXBm54hJCRxjhimERHGw8z2ONVMLhUNb0Q4EDG+roxHeXMTirH5UQJXsPBIy1HnbPBElnsEvZXGvzBZZO2taoUlyKR0OvhMjr6Lqw4gPSoBAMH7AC02q30PRbPN6fBBrqXuE8uojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUonHkhv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so5771734a91.1;
        Sat, 08 Mar 2025 02:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741428042; x=1742032842; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qmuWU+ABDEM7eRP+mmuPtmIx9zAefsZ3TrrNc1V03XM=;
        b=hUonHkhvg031wVe/GYESFiAW160DehUQuZCBQgNM0apkF7JVfveW03F1r+tknNPjZ+
         6W5cXYpCxK44Cs6VFR9ubgaRv1C4Rb4q9U8bKlGvLPiffmq9QEeTGobxmNPgONCzbxSL
         ZizhjAa8L4qjkl4NCuqxpzk5A/RoE+jw7Cm9rp/be/qgS7aURSsmtof63uA/toj02TeL
         mUKj7cmkRXbUUbLa6rSy9wH5lCZcdml3o/N3PI2wavsW1lFOc5BOdAsBk1KWLsVSJoO1
         Mlz7VggmPx90TPymEg6S25wj0unQ6s3mijv3IoKb/ry2PHu+DyStzeIELwR2UaVPiXMj
         I6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741428042; x=1742032842;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmuWU+ABDEM7eRP+mmuPtmIx9zAefsZ3TrrNc1V03XM=;
        b=VKxKhgA6Vxm2ZLQRc5TErm4GyhBfMzt9kl5FlIZxrTdpyG6Co2w5JNDNhZQF6AfWQC
         OPboAV/Jn9TdC9x4Ti7/uSQYikCjcuDtEYMgYVvBcT2i67UGfVQA/joHgm/o8vkk7S/h
         DTGsqly2Pw9wb5PE/C8A7rIMO9KmenOwzzLZAhxJsTAPua/mkNR4wJna4+dJduIT6iTX
         Lo3AD9hhxAtZ2j+H1MlOJYvr5vzCNUulUarEkXrRlHLiuGqRNCOJGSZoXjf0i1svAqGP
         lHE52ho5jwFsNwJoWowZ4+r4AH3NvXh3ZfjuRlu+MlSvzv5cNIRX/OJEAxXU8xc+Qc/1
         9jug==
X-Forwarded-Encrypted: i=1; AJvYcCUEvU69I0pZMGZLp2hV18+fm+2u5BEk/Hw9GBsZJW0ay4a5Q7QkHezqaXCUFJypFvHYFdQog/+BxILk@vger.kernel.org, AJvYcCUrLJ4xyyEWKi95/R+yVki6oO32CRZtaZ2G+0fICQGNH36jlgftTTNk8djiGBGOuVQD3dz1zJVI19MSbfT1@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnf697w7Q/BIeUVOLe0uql9mjxXXVCu2dudXAqz293vER1fqw
	cqGgbtcGaM5i4giUGXGdRukXupZ8aX2E95fvaKgGJSMiFc19G3VbwKfNcA==
X-Gm-Gg: ASbGnctf5W59+0lISGsraiSjtqw77wDTZNgJqiW70dfmr4eVgoRzCL8Oc0IUYsu+QDw
	A5U4tJLRRCAblwKtKyZtZRHTlW72w1hPti/CrIx+CHS7o/4UFgB0zzrWJTskjV9I+x6zQ7FaUM1
	nqlCmbIcg0OALjRlCDAfyLA0mXY+yUWSuEaQWzFNCTuukMGJfS9NmuEfHnlk0xOGPi6yOUEzF97
	egTHm4Q+XfBKzmMRpdV55cUrIar00smIeC17vRDw4/2MH83eMz3Dvl2IxAKHdfqji3IcCzxpNB2
	v5/4yrZbTHx2IgzKPS6Oj0nWqS90V4OLH1c=
X-Google-Smtp-Source: AGHT+IGPAJzUf9siyzmCmgkTC9kLKvlPxR154Kyh6/tNf5D6nZlFWTCUZP6hIDD9iyrGuUOK4JT+yQ==
X-Received: by 2002:a17:90b:2f8f:b0:2ea:7cd5:4ad6 with SMTP id 98e67ed59e1d1-2ff7cf4dde5mr9395444a91.32.1741428042385;
        Sat, 08 Mar 2025 02:00:42 -0800 (PST)
Received: from dw-tp ([171.76.82.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e78939dsm6315453a91.29.2025.03.08.02.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 02:00:41 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if journal is destroying
In-Reply-To: <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
Date: Sat, 08 Mar 2025 15:25:04 +0530
Message-ID: <87ldtfhmo7.fsf@gmail.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com> <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> Presently we always BUG_ON if trying to start a transaction on a journal marked
> with JBD2_UNMOUNT, since this should never happen. However, while ltp running
> stress tests, it was observed that in case of some error handling paths, it is
> possible for update_super_work to start a transaction after the journal is
> destroyed eg:
>
> (umount)
> ext4_kill_sb
>   kill_block_super
>     generic_shutdown_super
>       sync_filesystem /* commits all txns */
>       evict_inodes
>         /* might start a new txn */
>       ext4_put_super
> 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>         jbd2_journal_destroy
>           journal_kill_thread
>             journal->j_flags |= JBD2_UNMOUNT;
>           jbd2_journal_commit_transaction
>             jbd2_journal_get_descriptor_buffer
>               jbd2_journal_bmap
>                 ext4_journal_bmap
>                   ext4_map_blocks
>                     ...
>                     ext4_inode_error
>                       ext4_handle_error
>                         schedule_work(&sbi->s_sb_upd_work)
>
>                                                /* work queue kicks in */
>                                                update_super_work
>                                                  jbd2_journal_start
>                                                    start_this_handle
>                                                      BUG_ON(journal->j_flags &
>                                                             JBD2_UNMOUNT)
>
> Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
> destroying only do a journaled (and deferred) update of sb if this flag is not
> set. Otherwise, just fallback to an un-journaled commit.
>
> We set sbi->s_journal_destroying = true only after all the FS updates are done
> during ext4_put_super() (except a running transaction that will get commited
> during jbd2_journal_destroy()). After this point, it is safe to commit the sb
> outside the journal as it won't race with a journaled update (refer
> 2d01ddc86606).
>
> Also, we don't need a similar check in ext4_grp_locked_error since it is only
> called from mballoc and AFAICT it would be always valid to schedule work here.
>
> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/ext4.h      | 2 ++
>  fs/ext4/ext4_jbd2.h | 8 ++++++++
>  fs/ext4/super.c     | 4 +++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2b7d781bfcad..d48e93bd5690 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
>  	 */
>  	struct work_struct s_sb_upd_work;
>  
> +	bool s_journal_destorying;
> +
>  	/* Atomic write unit values in bytes */
>  	unsigned int s_awu_min;
>  	unsigned int s_awu_max;
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 9b3c9df02a39..6bd3ca84410d 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
>  {
>  	int err = 0;
>  
> +	/*
> +	 * At this point all pending FS updates should be done except a possible
> +	 * running transaction (which will commit in jbd2_journal_destroy). It
> +	 * is now safe for any new errors to directly commit superblock rather
> +	 * than going via journal.
> +	 */
> +	sbi->s_journal_destorying = true;

This is not correct right. I think what we decided to set this flag
before we flush the workqueue. So that we don't schedule any new
work after this flag has been set. At least that is what I understood.

[1]: https://lore.kernel.org/all/87eczc6rlt.fsf@gmail.com/

-ritesh


> +
>  	err = jbd2_journal_destroy(journal);
>  	sbi->s_journal = NULL;
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8ad664d47806..31552cf0519a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  		 * constraints, it may not be safe to do it right here so we
>  		 * defer superblock flushing to a workqueue.
>  		 */
> -		if (continue_fs && journal)
> +		if (continue_fs && journal && !EXT4_SB(sb)->s_journal_destorying)
>  			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
>  		else
>  			ext4_commit_super(sb);
> @@ -5311,6 +5311,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	spin_lock_init(&sbi->s_error_lock);
>  	INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
>  
> +	sbi->s_journal_destorying = false;
> +
>  	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
>  	if (err)
>  		goto failed_mount3;
> -- 
> 2.48.1

