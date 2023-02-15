Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696A2697FFB
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Feb 2023 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBOPzp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Feb 2023 10:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjBOPzj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Feb 2023 10:55:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32FC1AE
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 07:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676476493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C10Gub8szWjgr3MHw+E21u9Jl7NsBtxoC06rcuHMWlY=;
        b=RihWCewDa7ZLmKBUV12i6tKBYCNUPtPp34YCfariLGc5hcPxFNjym1kVgeKCAT5LWiLAqO
        ovavBo2iftbuDryHXXG/h4GQJn3mGBOwALc8I1T/f7wuNyCZaKM7wTfHuwmZRSQYudYTVZ
        4Vdn53MxiDFiqJP/fOOdcPlpPF6FdY8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-Uk9VbJEwNVe2fFGIjz33DQ-1; Wed, 15 Feb 2023 10:54:52 -0500
X-MC-Unique: Uk9VbJEwNVe2fFGIjz33DQ-1
Received: by mail-qt1-f199.google.com with SMTP id g26-20020ac8481a000000b003bd01832685so788060qtq.3
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 07:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C10Gub8szWjgr3MHw+E21u9Jl7NsBtxoC06rcuHMWlY=;
        b=SNAHuCvCjiF64uFomJeLmufUDP4k6AyQmxs5xsqYhdRhJsNA/lw8U/Y6vwM4nHE9ti
         cB8V3Xt+Hbs+Woi232JXIpYubedPQmsykgF2TVob5z0tZ0e45FgU6+X6hxsJhYkc9WnZ
         dfzBBtWiTzfVral+qUxxWVRz/2pUO0zpStXdHTfXq35EqlLgFfZVIDWFI7Qo1m9Nc3fv
         xzHHphyy/3TDOw9G55n7YF1zwH/YwWVE0THrdqZSdunBEI1d+J0iHg+3wnM5atlrS5hn
         wDiAlZ3ZVfDrSmYa+/v28AxUMYptWDasdk59ULobBnDdPKGGEZpmu7vKOgE7aHTrF4BZ
         stMg==
X-Gm-Message-State: AO0yUKVZrT+K/y3Lkk5Je1k5IYhFFzNWtgyJtP0U64xnNkFc44Cdt6lD
        6oDig8ddGwXRL9axn72MX/Fn6oPGMNDgqZ8DrUVRpviG+8hf6GvoeQUXDqRe61yaU+IPjpsWLad
        wF67PBnPClxBo5PBy3Za9mXa/LLM=
X-Received: by 2002:a05:622a:104c:b0:3bb:995c:424c with SMTP id f12-20020a05622a104c00b003bb995c424cmr5547527qte.22.1676476491253;
        Wed, 15 Feb 2023 07:54:51 -0800 (PST)
X-Google-Smtp-Source: AK7set9i2WzVGPZTZlUycou6PHuwBGY3QUbzPpP6Bd3CyBrfQ7xYckbvQs14QjqaZn4tdtGWk7ekzw==
X-Received: by 2002:a05:622a:104c:b0:3bb:995c:424c with SMTP id f12-20020a05622a104c00b003bb995c424cmr5547498qte.22.1676476490919;
        Wed, 15 Feb 2023 07:54:50 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id ca16-20020a05622a1f1000b003a7e38055c9sm13323949qtb.63.2023.02.15.07.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:54:50 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:56:14 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH RFC] ext4: allow concurrent unaligned dio overwrites
Message-ID: <Y+0Anv/RQhZEA5SF@bfoster>
References: <20230210145954.277611-1-bfoster@redhat.com>
 <87zg9fq8a9.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg9fq8a9.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 15, 2023 at 08:34:46PM +0530, Ritesh Harjani wrote:
> Brian Foster <bfoster@redhat.com> writes:
> 
> Thanks for the patch.
> 

Thanks for the feedback!

> > Hi all,
> >
> > We've had a customer report a significant performance regression of
> > sub-block (unaligned) direct writes between a couple distro kernels
> > (that span a large range of upstream releases). I've not bisected
> > upstream to narrow down to specific commit(s), but the regression
> > appears to correspond with added concurrency restrictions of
> > unaligned dio in ext4. Obviously this user should ideally move to a
> > configuration that minimizes unaligned I/O, but while looking into
> > this we also observed that XFS performs noticeably better with the
> > same workload, even though it has the same general unaligned dio
> > constraints.
> >
> > The difference appears to be the use of IOMAP_DIO_OVERWRITE_ONLY in
> > XFS, which allows optimistic concurrent submission of unaligned
> > direct I/O under shared locking. I.e., if the dio turns out to be
> > something other than a pure overwrite that may require block
> > zeroing, iomap kicks the request back with -EAGAIN so it can be
> > resubmitted with appropriate exclusivity.
> >
> > I initially prototyped this same sort of logic on ext4, but on
> > further inspection realized that ext4 seems to already check for dio
> > overwrites in ext4_dio_write_checks(). Therefore ISTM that since
> > ext4 already knows when a dio is purely overwrite, it can safely
> > submit unaligned dios concurrently where it knows zeroing is not
> > required, and then fall back to exclusive submission otherwise.
> 
> Yes, so in case of ext4, we start with a shared inode lock and check for
> extent mapping. If the entire length of the write is already mapped then
> we continue with ilock_shared. Otherwise we switch to exclusive locking.
> 
> So I think what you are proposing is that, in case of a unaligned write
> to a part which is already allocated and mapped, we don't need exclusive
> locking. That is because we don't need any allocation and neither
> partial blocks zeroing because it is not an unwritten extent.
> 

Right.

> Quick qn - what happens when two processes are writing to the same 4k
> block with 1k writes in parallel? Oh ok so inode_dio_wait() will protect
> this case.
> 

My understanding is that should work as normal so long as the blocks are
mapped..? The key problem wrt to the locking/exclusivity is that for
non-overwrite I/Os, any/all of the requests could do zeroing on the rest
of the block and lead to corruption. This shouldn't happen if the writes
are overwrites to mapped blocks, even if unaligned.

> Then yes, this does seems like it should work. Although I am not sure
> whether ext4 needs to use IOMAP_DIO_OVERWRITE_ONLY flag really?
> 

Technically no I don't think it's needed. I originally thought the same
sort of submit/retry logic that XFS uses would be necessary, then
realized that the overwrite checking is already done before submission
in ext4.

> This flag ends up setting IOMAP_OVERWRITE_ONLY flag again for lower
> layers of filesystem to make sure no block allocation/partial zeroing
> happens. XFS handles this, but ext4 as you mentioned does not require
> it. Hence I think we can drop the use of IOMAP_DIO_OVERWRITE_ONLY flag
> from ext4.
> 

Personally I think I would prefer to keep it out of caution, because it
does instruct the iomap/dio layer that zeroing is unsafe if something
happens to be wrong. The tradeoff is that if something unexpected
happens, we'd see a spurious -EAGAIN failure from the dio rather than a
submission that silently performs unsafe (but perhaps not corrupting)
zeroing.

That said, I don't insist and defer to maintainers or whoever knows this
code better. I'll keep the flag around prospectively until I get through
more testing and review and drop it as a last step if that is ultimately
preferred.

> >
> > This RFC prototypes something along those lines using ilock_shared
> > as a proxy for non-overwrite (since non-overwrite always means
> > non-shared locking). Based on the following fio test against a
> > prewritten (i.e. no unwritten extents) file, on an 8xcpu kvm guest,
> > using default ext4 options:
> >
> > fio --name=test --ioengine=libaio --direct=1 --group_reporting
> >   --overwrite=1 --thread --size=10G --filename=/mnt/fio
> >   --readwrite=write --ramp_time=10s --runtime=60s --numjobs=8
> >   --blocksize=2k --iodepth=256 --allow_file_create=0
> >
> > ... performance goes from something like ~1350 iops / 2.7 MB/s on a
> > v6.1 kernel to +350k iops / +700MB/s on a patched v6.2.0-rc7 kernel.
> > The latter is much more closely aligned to what I see from the same
> > test against XFS.
> >
> > This also survives an initial fstests regression run, though it does
> > leave at least a couple open questions I can think of:
> >
> > 1. Do we care to be explicit about overwrites and perhaps plumb
> >    through an 'overwrite' flag from ext4_dio_write_checks()?
> > 2. Do we want to use DIO_OVERWRITE_ONLY and assume iomap will never
> >    kick back an overwrite only I/O, or perhaps include retry logic
> >    similar to XFS? That may be superfluous, but it's not much
> >    additional  code either.
> >
> > Thoughts on any of this? If there's consensus I can followup with a v1
> > with a proper implementation, commit log, code comment updates, etc.
> >
> > Not-Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/ext4/file.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index 7ac0a81bd371..bb41520f89d0 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -493,15 +493,14 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
> >  	bool extend = false, unaligned_io = false;
> >  	bool ilock_shared = true;
> > +	unsigned int dio_flags = 0;
> >
> >  	/*
> >  	 * We initially start with shared inode lock unless it is
> >  	 * unaligned IO which needs exclusive lock anyways.
> >  	 */
> > -	if (ext4_unaligned_io(inode, from, offset)) {
> > +	if (ext4_unaligned_io(inode, from, offset))
> >  		unaligned_io = true;
> > -		ilock_shared = false;
> > -	}
> >  	/*
> >  	 * Quick check here without any i_rwsem lock to see if it is extending
> >  	 * IO. A more reliable check is done in ext4_dio_write_checks() with
> > @@ -563,9 +562,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  	 * below inode_dio_wait() may anyway become a no-op, since we start
> >  	 * with exclusive lock.
> >  	 */
> > -	if (unaligned_io)
> > -		inode_dio_wait(inode);
> > -
> >  	if (extend) {
> >  		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> >  		if (IS_ERR(handle)) {
> > @@ -582,11 +578,18 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  		ext4_journal_stop(handle);
> >  	}
> >
> > -	if (ilock_shared)
> > +	if (ilock_shared) {
> >  		iomap_ops = &ext4_iomap_overwrite_ops;
> > +		if (unaligned_io)
> > +			dio_flags = IOMAP_DIO_OVERWRITE_ONLY;
> > +	} else if (unaligned_io || extend) {
> > +		dio_flags = IOMAP_DIO_FORCE_WAIT;
> > +		if (unaligned_io)
> > +			inode_dio_wait(inode);
> > +	}
> 
> This nested if logic has now become confusing, but I couldn't find
> anything easier either. It will be good though it this could be
> improved. Maybe if we add the unaligned_io logic in
> ext4_dio_write_checks(), it might make it easier to read?
> 

Yeah, I reshuffled the logic around a couple different ways that
ultimately didn't look much different. I was thinking about adding an
overwrite flag, but I can also try relocating the unaligned check and
see if that brings about ideas for anything nicer..

Brian

> -ritesh
> 
> 
> >  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> > -			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
> > -			   NULL, 0);
> > +			   dio_flags, NULL, 0);
> > +	WARN_ON_ONCE(ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT));
> >  	if (ret == -ENOTBLK)
> >  		ret = 0;
> >
> > --
> > 2.39.1
> 

