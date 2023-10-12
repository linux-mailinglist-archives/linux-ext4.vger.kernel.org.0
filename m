Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8F7C7A75
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Oct 2023 01:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjJLXdQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Oct 2023 19:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjJLXdP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Oct 2023 19:33:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F3CA
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 16:33:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d0a173e61so1114982a91.0
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1697153592; x=1697758392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxLOHHGovdX27lGGxxcApANr8EgO0q6WC7e2DC1RSww=;
        b=lcMRSIpYP3UeKGNl2EEx/zjnWUkvbjD6nBFEeVFv7lzFhrXWw8qUFZHtGYWjpUClMA
         SXrDNOPJRERkOwF39Z44Gd4IaXXGdw4nflt3WZ4iuZGBgfxk511bev3KB7lwm7CBTBU/
         I6nBh+aIvYSOZAjdeKSOnmuSpZQEf51lUdVhZru3Pi2Jc1DGPBbUDiEPPDx7nNkY2Rk5
         hNj69AYooL2f/gW/IWZN9Nle9UhpuvFyXmrgOfkC3lEbBDbFFba6kRZIFjXhoLetOxM/
         efmvqwj/QSgXSf4DYYJe5bIVQukrAojXIVcqljch07ctPoaanqX57Zia6+jqRTP+WPlI
         FHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697153592; x=1697758392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxLOHHGovdX27lGGxxcApANr8EgO0q6WC7e2DC1RSww=;
        b=EE4hOucuzcC0ZYFBlYq/BqCdHYcfQ0VlNumbDg6aOgm5KKzzaAX52qXaL218fL9L8I
         HFbtPU8x0I5O2XaN39/2LROwKgERIuOFRwL9xceZiIBfpZNB/mlGaA9wDCGqlr92IS2z
         0ex0x9lSOyqwdbd2f1FkbnOeyqea52JDVNQZRcSPtrytmv9Fl2zKUWLbcAwEWftwhJhL
         /8e+kf1WwnIapzcpCGa2Hn/wm3RJCKH65NG48yB+uneJRlwb+j+z36xOFR4/OtDSPh2c
         SbwdC9miNyhyFDyGXWNh/2Qjv4ygfvp6lDo/4pFbaF177JZipzriFmk54ZaTXws57sMb
         dQhg==
X-Gm-Message-State: AOJu0YzW1zNeZe4xsz1/0ByheFtN6fSfVmJA2E1yka3yGJkHEKDx8qCJ
        wPmI9YtB2KsmHnt4QQYueDQnXg==
X-Google-Smtp-Source: AGHT+IGQyhXXo5mKSnyJqMQv2xACx1vuKyUTVopz+GwS/8/zVCIdPUbiU4pE1L+ov8QNQU2ABavhhg==
X-Received: by 2002:a17:90a:8e82:b0:263:1f1c:ef4d with SMTP id f2-20020a17090a8e8200b002631f1cef4dmr21563441pjo.10.1697153591715;
        Thu, 12 Oct 2023 16:33:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a001c00b0027d0af2e9c3sm2580680pja.40.2023.10.12.16.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:33:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qr5Ay-00D2yP-24;
        Fri, 13 Oct 2023 10:33:08 +1100
Date:   Fri, 13 Oct 2023 10:33:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] ext4: Properly sync file size update after O_SYNC direct
 IO
Message-ID: <ZSiCNPAFuKZbmFPg@dread.disaster.area>
References: <20231011142155.19328-1-jack@suse.cz>
 <ZSc9J9zFChyxl1U2@dread.disaster.area>
 <20231012085937.pzfsttumi6q4g3tm@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012085937.pzfsttumi6q4g3tm@quack3>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 12, 2023 at 10:59:37AM +0200, Jan Kara wrote:
> On Thu 12-10-23 11:26:15, Dave Chinner wrote:
> > On Wed, Oct 11, 2023 at 04:21:55PM +0200, Jan Kara wrote:
> > > Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
> > > sync file size update and thus if we crash at unfortunate moment, the
> > > file can have smaller size although O_SYNC IO has reported successful
> > > completion. The problem happens because update of on-disk inode size is
> > > handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
> > > dio_complete() in particular) has returned and generic_file_sync() gets
> > > called by dio_complete(). Fix the problem by handling on-disk inode size
> > > update directly in our ->end_io completion handler.
> > > 
> > > References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
> > > Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/ext4/file.c | 139 ++++++++++++++++++-------------------------------
> > >  1 file changed, 52 insertions(+), 87 deletions(-)
> > .....
> > > @@ -388,9 +342,28 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> > >  		 */
> > >  		if (inode->i_nlink)
> > >  			ext4_orphan_del(NULL, inode);
> > > +		return;
> > >  	}
> > > +	/*
> > > +	 * If i_disksize got extended due to writeback of delalloc blocks while
> > > +	 * the DIO was running we could fail to cleanup the orphan list in
> > > +	 * ext4_handle_inode_extension(). Do it now.
> > > +	 */
> > > +	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> > > +		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > 
> > So this has to be called after the DIO write completes and calls
> > ext4_handle_inode_extension()?
> 
> Yes, if the write was setup as extending one ('extend' is set to true in
> ext4_dio_write_iter()).

Then that is worth a comment to document the constraint for anyone
that is trying to understand how ext4 is using the iomap DIO code.

> > > @@ -606,9 +570,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > >  			   dio_flags, NULL, 0);
> > >  	if (ret == -ENOTBLK)
> > >  		ret = 0;
> > > -
> > >  	if (extend)
> > > -		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> > > +		ext4_inode_extension_cleanup(inode, ret);
> > 
> > Because this doesn't wait for AIO DIO to complete and actually
> > extend the file before running the cleanup code...
> 
> As Gao wrote, ext4 sets IOMAP_DIO_FORCE_WAIT if 'extend' is set (see
> ext4_dio_write_checks()) so if we get to calling
> ext4_inode_extension_cleanup() we are guaranteed the IO has already
> completed.

Ugh. That's a pretty nasty undocumented landmine. It definitely
needs a comment (or better, a WARN_ON_ONCE()) to document that this
code -only- works if AIO is disabled. This isn't for ext4
developers, it's for people working on the iomap code to understand
that ext4 has some really non-obvious constraints in it's DIO code
paths and that's why the landmine is not being stepped on....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
