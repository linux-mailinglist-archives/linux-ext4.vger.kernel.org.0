Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C85C697F17
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Feb 2023 16:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBOPFJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Feb 2023 10:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBOPFG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Feb 2023 10:05:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E193D13DDE
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 07:05:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d2so18385944pjd.5
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 07:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FoT1pidjjVCYuujcZNAGkLgKKA1h7iduDhqR4tDkjpY=;
        b=cRDFueCh54niVv1/mnEcGkTkE+Hp4OjVOndqePLC2yRczZsGa7srByLwBuqYgLk045
         LDXEp7P1TxEbbzeft/Vm5FaZJilb5P+k7re3sanc7x1gKNtz7/UG+lnRNQwdsE2xxIjg
         uhxBG1sJ2hRddcHR5255CpYbP1m0TQuPPhzat6J/nV6EWAKVTd8IwWpHIPIKxOIgH0gp
         5t9rZQmA2cmMW5N7wG3BdppHdpMEApvhME0976BluhUnO6qgdXNinY3+CwbKJgnLSpVs
         68Ht8CB6H3TwPJgyj9fHsxSUx8V0dpVjTAZWGedLEautmvPzolAZkKZ5uAaUvMT2WkaP
         6Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoT1pidjjVCYuujcZNAGkLgKKA1h7iduDhqR4tDkjpY=;
        b=NAb8cnZNTVe2CQcPuQxQxGwVRk0quc4jz9JdCX7NpE0yw6E6f3luVNJjsJ51HTAvYD
         kTvH43tTKK7Y0QYn6EfgqqGlvo6fXYQGqugppOm2mwseOXevaQc4FQafHu0MW8SddRLh
         bKLFICTSIgqRnspTLrRYFoZRZjXfIN0mHRsuUGWNmsuaq0lgQxum7yMHShAUi9UzhjDw
         Lhn3Wt9NEnjDlKS4vdbcqXAt7HptJFRyXmR+Fmq97tgGhoUiqZd9dO0FDPYo7MLmLijm
         xR5NspBtWfXoUaUqoNpQ0i5MUsW4/LskFWZQ14IsarrYjiaNsVz5i73QpYcR/LVDKfOe
         AZ2Q==
X-Gm-Message-State: AO0yUKXwnYTohoFGsSzw3KnrRnLsSoEeox9BMsKpRexSr9yAqGYoTAQT
        cK3syL7YNKTS6ak5WOVyH3c=
X-Google-Smtp-Source: AK7set/MzCiiTIbna3vdOvu7djUmQ3PPWc591ywupo5QumZGzqjc2r5nSp7xC1Ii/9kt0+lOJ79nYg==
X-Received: by 2002:a17:903:244f:b0:19a:8316:6b51 with SMTP id l15-20020a170903244f00b0019a83166b51mr3541855pls.4.1676473502364;
        Wed, 15 Feb 2023 07:05:02 -0800 (PST)
Received: from rh-tp ([2406:7400:63:5056:148f:873b:4bc8:1e77])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b0019a8468cbe7sm8401871pld.224.2023.02.15.07.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:05:01 -0800 (PST)
Date:   Wed, 15 Feb 2023 20:34:46 +0530
Message-Id: <87zg9fq8a9.fsf@doe.com>
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Brian Foster <bfoster@redhat.com>, linux-ext4@vger.kernel.org
Cc:     Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH RFC] ext4: allow concurrent unaligned dio overwrites
In-Reply-To: <20230210145954.277611-1-bfoster@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Brian Foster <bfoster@redhat.com> writes:

Thanks for the patch.

> Hi all,
>
> We've had a customer report a significant performance regression of
> sub-block (unaligned) direct writes between a couple distro kernels
> (that span a large range of upstream releases). I've not bisected
> upstream to narrow down to specific commit(s), but the regression
> appears to correspond with added concurrency restrictions of
> unaligned dio in ext4. Obviously this user should ideally move to a
> configuration that minimizes unaligned I/O, but while looking into
> this we also observed that XFS performs noticeably better with the
> same workload, even though it has the same general unaligned dio
> constraints.
>
> The difference appears to be the use of IOMAP_DIO_OVERWRITE_ONLY in
> XFS, which allows optimistic concurrent submission of unaligned
> direct I/O under shared locking. I.e., if the dio turns out to be
> something other than a pure overwrite that may require block
> zeroing, iomap kicks the request back with -EAGAIN so it can be
> resubmitted with appropriate exclusivity.
>
> I initially prototyped this same sort of logic on ext4, but on
> further inspection realized that ext4 seems to already check for dio
> overwrites in ext4_dio_write_checks(). Therefore ISTM that since
> ext4 already knows when a dio is purely overwrite, it can safely
> submit unaligned dios concurrently where it knows zeroing is not
> required, and then fall back to exclusive submission otherwise.

Yes, so in case of ext4, we start with a shared inode lock and check for
extent mapping. If the entire length of the write is already mapped then
we continue with ilock_shared. Otherwise we switch to exclusive locking.

So I think what you are proposing is that, in case of a unaligned write
to a part which is already allocated and mapped, we don't need exclusive
locking. That is because we don't need any allocation and neither
partial blocks zeroing because it is not an unwritten extent.

Quick qn - what happens when two processes are writing to the same 4k
block with 1k writes in parallel? Oh ok so inode_dio_wait() will protect
this case.

Then yes, this does seems like it should work. Although I am not sure
whether ext4 needs to use IOMAP_DIO_OVERWRITE_ONLY flag really?

This flag ends up setting IOMAP_OVERWRITE_ONLY flag again for lower
layers of filesystem to make sure no block allocation/partial zeroing
happens. XFS handles this, but ext4 as you mentioned does not require
it. Hence I think we can drop the use of IOMAP_DIO_OVERWRITE_ONLY flag
from ext4.

>
> This RFC prototypes something along those lines using ilock_shared
> as a proxy for non-overwrite (since non-overwrite always means
> non-shared locking). Based on the following fio test against a
> prewritten (i.e. no unwritten extents) file, on an 8xcpu kvm guest,
> using default ext4 options:
>
> fio --name=test --ioengine=libaio --direct=1 --group_reporting
>   --overwrite=1 --thread --size=10G --filename=/mnt/fio
>   --readwrite=write --ramp_time=10s --runtime=60s --numjobs=8
>   --blocksize=2k --iodepth=256 --allow_file_create=0
>
> ... performance goes from something like ~1350 iops / 2.7 MB/s on a
> v6.1 kernel to +350k iops / +700MB/s on a patched v6.2.0-rc7 kernel.
> The latter is much more closely aligned to what I see from the same
> test against XFS.
>
> This also survives an initial fstests regression run, though it does
> leave at least a couple open questions I can think of:
>
> 1. Do we care to be explicit about overwrites and perhaps plumb
>    through an 'overwrite' flag from ext4_dio_write_checks()?
> 2. Do we want to use DIO_OVERWRITE_ONLY and assume iomap will never
>    kick back an overwrite only I/O, or perhaps include retry logic
>    similar to XFS? That may be superfluous, but it's not much
>    additional  code either.
>
> Thoughts on any of this? If there's consensus I can followup with a v1
> with a proper implementation, commit log, code comment updates, etc.
>
> Not-Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/ext4/file.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7ac0a81bd371..bb41520f89d0 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -493,15 +493,14 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>  	bool extend = false, unaligned_io = false;
>  	bool ilock_shared = true;
> +	unsigned int dio_flags = 0;
>
>  	/*
>  	 * We initially start with shared inode lock unless it is
>  	 * unaligned IO which needs exclusive lock anyways.
>  	 */
> -	if (ext4_unaligned_io(inode, from, offset)) {
> +	if (ext4_unaligned_io(inode, from, offset))
>  		unaligned_io = true;
> -		ilock_shared = false;
> -	}
>  	/*
>  	 * Quick check here without any i_rwsem lock to see if it is extending
>  	 * IO. A more reliable check is done in ext4_dio_write_checks() with
> @@ -563,9 +562,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	 * below inode_dio_wait() may anyway become a no-op, since we start
>  	 * with exclusive lock.
>  	 */
> -	if (unaligned_io)
> -		inode_dio_wait(inode);
> -
>  	if (extend) {
>  		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>  		if (IS_ERR(handle)) {
> @@ -582,11 +578,18 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ext4_journal_stop(handle);
>  	}
>
> -	if (ilock_shared)
> +	if (ilock_shared) {
>  		iomap_ops = &ext4_iomap_overwrite_ops;
> +		if (unaligned_io)
> +			dio_flags = IOMAP_DIO_OVERWRITE_ONLY;
> +	} else if (unaligned_io || extend) {
> +		dio_flags = IOMAP_DIO_FORCE_WAIT;
> +		if (unaligned_io)
> +			inode_dio_wait(inode);
> +	}

This nested if logic has now become confusing, but I couldn't find
anything easier either. It will be good though it this could be
improved. Maybe if we add the unaligned_io logic in
ext4_dio_write_checks(), it might make it easier to read?

-ritesh


>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> -			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
> -			   NULL, 0);
> +			   dio_flags, NULL, 0);
> +	WARN_ON_ONCE(ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT));
>  	if (ret == -ENOTBLK)
>  		ret = 0;
>
> --
> 2.39.1
