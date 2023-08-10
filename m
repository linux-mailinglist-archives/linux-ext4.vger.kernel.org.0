Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10107777A94
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 16:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjHJOYR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjHJOYI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 10:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC97D2737
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691677395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCAzgmjDF875IiK3PPkH+kpjKiT/+HkJrnVXtDnRrNM=;
        b=P18SJNLhv5qDNhyndLxrnEOrg/s0/eRAQyK2VKSRp6ikJPK3tYurFSoouQE+Gq7BWXJiFT
        LDmbfCfGA6XjO6D20ySFdhf6grSPGFBQdhQYWZ5Tf4InS0qMjcU7+S9L45Dv33NjzEXyT/
        31tuNsgIwIHAmo4jSxNnC+jr4D4k5WM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-OoXiq8GRPCKkzSftr9q3_A-1; Thu, 10 Aug 2023 10:23:14 -0400
X-MC-Unique: OoXiq8GRPCKkzSftr9q3_A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76c93466e4cso111091385a.3
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 07:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691677394; x=1692282194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCAzgmjDF875IiK3PPkH+kpjKiT/+HkJrnVXtDnRrNM=;
        b=YKqo0MNwNQIl+PrpC9R0wikNWjP24j3CYwHS+ynJziQ07yOvnQOdlngs/U2pSEGNYi
         69zSAlFJoeysbUDvGJptjOcUCqKpmoP6mkl4tpfO6R3hPmBXOjvdgPSRTUvAM4ROHNTR
         CUwZgold9Z8e3g0bccEnLCZUhS/p6u1Npp3bgaH/9fDLH+Gp/j/yADTLoidN5rBKlXp+
         WWckD4aLl1qSMpusfRz+oLakNuz9+GWhHvmEKx7q/C8WlZs0aXR92bKwR68CmetOOhqn
         4pDp6eTx3kFq34zO8XlEn4EKF+xzHdhKYzjS9XRYB8QEF1oiRlotboTUf7Wm/CNDziaj
         HuMA==
X-Gm-Message-State: AOJu0YxkYrdL5lxr2L8K6zOvfybaYF5YNn2K+uQqmKD1FAw2ukfG5QGO
        +zB8EE20GwB3/nNCsZ77s9eFctydACBkgy1DnDs52sbQq9+YeIS6XHLuFeIqUvBti3c5k7T/1lP
        CbEAUp5683C6QmM3SVSTSjA==
X-Received: by 2002:a05:620a:4415:b0:76c:5715:b45f with SMTP id v21-20020a05620a441500b0076c5715b45fmr2400515qkp.14.1691677394009;
        Thu, 10 Aug 2023 07:23:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9sujMxZ0oyhjhBo+BnsxRxHvKe1zJHYiQY1FZbpNFgQ/CefTWqQ2cbWAN3VzC4889CiZUDQ==
X-Received: by 2002:a05:620a:4415:b0:76c:5715:b45f with SMTP id v21-20020a05620a441500b0076c5715b45fmr2400496qkp.14.1691677393698;
        Thu, 10 Aug 2023 07:23:13 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id m12-20020ae9e00c000000b0076ccf1a0da3sm514123qkk.75.2023.08.10.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:23:13 -0700 (PDT)
Date:   Thu, 10 Aug 2023 10:26:17 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH] ext4: drop dio overwrite only flag and associated warning
Message-ID: <ZNTziahrkoivEBdp@bfoster>
References: <20230804182952.477247-1-bfoster@redhat.com>
 <20230807105906.teovthvnwrpbmx7n@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807105906.teovthvnwrpbmx7n@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 07, 2023 at 12:59:06PM +0200, Jan Kara wrote:
> On Fri 04-08-23 14:29:52, Brian Foster wrote:
> > The commit referenced below opened up concurrent unaligned dio under
> > shared locking for pure overwrites. In doing so, it enabled use of
> > the IOMAP_DIO_OVERWRITE_ONLY flag and added a warning on unexpected
> > -EAGAIN returns as an extra precaution, since ext4 does not retry
> > writes in such cases. The flag itself is advisory in this case since
> > ext4 checks for unaligned I/Os and uses appropriate locking up
> > front, rather than on a retry in response to -EAGAIN.
> > 
> > As it turns out, the warning check is susceptible to false positives
> > because there are scenarios where -EAGAIN is expected from the
> > storage layer without necessarily having IOCB_NOWAIT set on the
> > iocb. For example, io_uring can set IOCB_HIPRI, which the iomap/dio
> > layer turns into REQ_POLLED|REQ_NOWAIT on the bio, which then can
> > result in an -EAGAIN result if the block layer is unable to allocate
> > a request, etc. syzbot has also reported an instance of this warning
> > and while the source of the -EAGAIN in that case is not currently
> > known, it is confirmed that the iomap dio overwrite flag is also not
> > set.
> > 
> > Since this flag is precautionary, avoid the false positive warning
> > and future whack-a-mole games with -EAGAIN returns by removing it
> > and the associated warning. Update the comments to document when
> > concurrent unaligned dio writes are allowed and why the associated
> > flag is not used.
> > 
> > Reported-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com
> > Fixes: 310ee0902b8d ("ext4: allow concurrent unaligned dio overwrites")
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> 
> So if I understand right, you're trying to say that if iomap_dio_rw()
> returns -EAGAIN, the caller of ext4_file_write_iter() and not
> ext4_file_write_iter() itself is expected to deal with it (like with
> IOCB_NOWAIT or other ways that can trigger similar behavior). That sounds
> good to me and the patch looks also fine. Feel free to add:
> 

Yeah.. the TLDR is basically that there were other paths that could set
REQ_NOWAIT on the bio (i.e. bio_set_polled()) that were unrelated to
IOCB_NOWAIT, hence the warning was spurious.

I recently noticed this patch [1], however, that seems to untangle some
of this logic. This patch looks like it wants to enforce IOCB_NOWAIT ->
REQ_NOWAIT for the particular case described in the commit log (i.e.
REQ_POLLED), which I also think would avoid the warning.

I was also finally able to reproduce the syzbot variant of the warning
and confirmed that it is different from the io_uring/HIPRI variant, but
still spurious wrt to IOCB_NOWAIT [2]. That one relates to GUP and doing
a killable wait on the mmap lock. I think I'll post a v2 of this patch
just to update the commit log with some of these details and I'll add
your R-b as well. Thanks for the review!

Brian

[1] https://lore.kernel.org/linux-block/b655aa3a-17f6-d25a-38b1-4a02e87e2c98@kernel.dk/
[2] https://lore.kernel.org/linux-ext4/ZNTxfQ0StiqKbvWj@bfoster/

> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> > ---
> > 
> > Hi all,
> > 
> > This addresses some false positives associated with the warning for the
> > recently merged patch. I considered leaving the flag and more tightly
> > associating the warning to it (instead of IOCB_NOWAIT), but ISTM that is
> > still flakey and I'd rather not play whack-a-mole when the assumption is
> > shown to be wrong.
> > 
> > I'm still waiting on a syzbot test of this patch, but local tests look
> > Ok and I'm away for a few days after today so wanted to get this on the
> > list. Thoughts, reviews, flames appreciated.
> > 
> > Brian
> > 
> >  fs/ext4/file.c | 25 ++++++++++---------------
> >  1 file changed, 10 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index c457c8517f0f..73a4b711be02 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -476,6 +476,11 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
> >  	 * required to change security info in file_modified(), for extending
> >  	 * I/O, any form of non-overwrite I/O, and unaligned I/O to unwritten
> >  	 * extents (as partial block zeroing may be required).
> > +	 *
> > +	 * Note that unaligned writes are allowed under shared lock so long as
> > +	 * they are pure overwrites. Otherwise, concurrent unaligned writes risk
> > +	 * data corruption due to partial block zeroing in the dio layer, and so
> > +	 * the I/O must occur exclusively.
> >  	 */
> >  	if (*ilock_shared &&
> >  	    ((!IS_NOSEC(inode) || *extend || !overwrite ||
> > @@ -492,21 +497,12 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
> >  
> >  	/*
> >  	 * Now that locking is settled, determine dio flags and exclusivity
> > -	 * requirements. Unaligned writes are allowed under shared lock so long
> > -	 * as they are pure overwrites. Set the iomap overwrite only flag as an
> > -	 * added precaution in this case. Even though this is unnecessary, we
> > -	 * can detect and warn on unexpected -EAGAIN if an unsafe unaligned
> > -	 * write is ever submitted.
> > -	 *
> > -	 * Otherwise, concurrent unaligned writes risk data corruption due to
> > -	 * partial block zeroing in the dio layer, and so the I/O must occur
> > -	 * exclusively. The inode lock is already held exclusive if the write is
> > -	 * non-overwrite or extending, so drain all outstanding dio and set the
> > -	 * force wait dio flag.
> > +	 * requirements. We don't use DIO_OVERWRITE_ONLY because we enforce
> > +	 * behavior already. The inode lock is already held exclusive if the
> > +	 * write is non-overwrite or extending, so drain all outstanding dio and
> > +	 * set the force wait dio flag.
> >  	 */
> > -	if (*ilock_shared && unaligned_io) {
> > -		*dio_flags = IOMAP_DIO_OVERWRITE_ONLY;
> > -	} else if (!*ilock_shared && (unaligned_io || *extend)) {
> > +	if (!*ilock_shared && (unaligned_io || *extend)) {
> >  		if (iocb->ki_flags & IOCB_NOWAIT) {
> >  			ret = -EAGAIN;
> >  			goto out;
> > @@ -608,7 +604,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  		iomap_ops = &ext4_iomap_overwrite_ops;
> >  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> >  			   dio_flags, NULL, 0);
> > -	WARN_ON_ONCE(ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT));
> >  	if (ret == -ENOTBLK)
> >  		ret = 0;
> >  
> > -- 
> > 2.41.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

