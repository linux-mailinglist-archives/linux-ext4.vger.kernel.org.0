Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E035EAC73
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2019 10:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfJaJQu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Oct 2019 05:16:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45010 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfJaJQu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Oct 2019 05:16:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id e10so3633922pgd.11
        for <linux-ext4@vger.kernel.org>; Thu, 31 Oct 2019 02:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xg/b4iDjx3u9hVd0I5Hyu2JBDES8904lj46RjDSYPdg=;
        b=qCQus62hLg0ZsnirnsDBZzhB/PcwAe9LuCthO3P3ciRwf0s+1rDIv/hXc9/5liU514
         /XqMuoHh8hYgvIvgJQcjL0N1tfc2r/9PMPDkJpn/VennbK/ZeWp7fQIKhUjWDIjyQDLq
         ckbbR7jChqtbXCB3x37HwSpPBYhgCu5l42djFH8v2+mkbal7KtsscLTtA9C5pAaUoHHy
         sQ+SvoP6gkn2MOWgX/jqRlaZkyg2tmSBu3HZSO4DeNqAOHws9Hjqy851hd+2OxxtrC67
         /hL9kMIFUc1+9cW2qMLmL/CHe+ZdJBRaU0JyWwUg3DisGCvSVJFqgbNBcuMaNXOI/fWK
         U/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xg/b4iDjx3u9hVd0I5Hyu2JBDES8904lj46RjDSYPdg=;
        b=onl6aEw8Jm0iHzHNvjGLey77z05+SFvtxpDFcTHv2kJ/5LGdRzjiIK121s3LmOkoLc
         C0t+1AS22PWrhuLA7fw8dZI5U6VsmenFP2Qu9nY2pVoxCbCEcrTaJNy1FvVpcLnOpogr
         td6GEdusZnqOpufOfl6GVP/1rzm+ZU/1A5+RRqYAd/n/YgN6kmKPuHJW/8mj52Z8BDxO
         O9rCLQZQd0HOxJ90OLG+8WA0xGtTd2CJ7K4hNFwfhx+4rjzeYe0YhASetlDgCCrzQSv+
         yU9li7jHd1FZVFBrvN/BmJmfm/ZcBGxSIriKauZbTnM2YloVU1XVvati2LheG1kFyZuo
         JfGw==
X-Gm-Message-State: APjAAAUQtze9C8JC91bAQrVgTGZN1Nl2Xm9RAf8Nu1AlzbGlrd/iT5mS
        2UFOXvOyhH28YdRZpM809eVL
X-Google-Smtp-Source: APXvYqz67EYIlIsW0+qxccoAVUkIZa1rJsSaJq0oMvbZbUnR+Sh0Vs+VbU61vCQkX9oqc2Qy5gEVVQ==
X-Received: by 2002:a62:5258:: with SMTP id g85mr5035665pfb.180.1572513408845;
        Thu, 31 Oct 2019 02:16:48 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id d9sm2121040pgc.80.2019.10.31.02.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 02:16:48 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:16:41 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v6 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191031091639.GB28679@bobrowski>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <20191029233159.GA8537@mit.edu>
 <20191029233401.GB8537@mit.edu>
 <20191030020022.GA7392@bobrowski>
 <20191030112652.GF28525@quack2.suse.cz>
 <20191030113918.GG28525@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030113918.GG28525@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 30, 2019 at 12:39:18PM +0100, Jan Kara wrote:
> On Wed 30-10-19 12:26:52, Jan Kara wrote:
> > On Wed 30-10-19 13:00:24, Matthew Bobrowski wrote:
> > > On Tue, Oct 29, 2019 at 07:34:01PM -0400, Theodore Y. Ts'o wrote:
> > > > On Tue, Oct 29, 2019 at 07:31:59PM -0400, Theodore Y. Ts'o wrote:
> > > > > Hi Matthew, it looks like there are a number of problems with this
> > > > > patch series when using the ext3 backwards compatibility mode (e.g.,
> > > > > no extents enabled).
> > > > > 
> > > > > So the following configurations are failing:
> > > > > 
> > > > > kvm-xfstests -c ext3   generic/091 generic/240 generic/263
> > > 
> > > This is one mode that I didn't get around to testing. Let me take a
> > > look at the above and get back to you.
> > 
> > If I should guess, I'd start looking at what that -ENOTBLK fallback from
> > direct IO ends up doing as we seem to be hitting that path...
> 
> Hum, actually no. This write from fsx output:
> 
> 24( 24 mod 256): WRITE    0x23000 thru 0x285ff  (0x5600 bytes)
> 
> should have allocated blocks to where the failed write was going (0x24000).
> But still I'd expect some interaction between how buffered writes to holes
> interact with following direct IO writes... One of the subtle differences
> we have introduced with iomap conversion is that the old code in
> __generic_file_write_iter() did fsync & invalidate written range after
> buffered write fallback and we don't seem to do that now (probably should
> be fixed regardless of relation to this bug).

After performing some debugging this afternoon, I quickly realised
that the fix for this is rather trivial. Within the previous direct
I/O implementation, we passed EXT4_GET_BLOCKS_CREATE to
ext4_map_blocks() for any writes to inodes without extents. I seem to
have missed that here and consequently block allocation for a write
wasn't performing correctly in such cases.

Also, I agree, the fsync + page cache invalidation bits need to be
implemented. I'm just thinking to branch out within
ext4_buffered_write_iter() and implement those bits there i.e.

	...
	ret = generic_perform_write();

	if (ret > 0 && iocb->ki_flags & IOCB_DIRECT) {
	   	err = filemap_write_and_wait_range();

		if (!err)
			invalidate_mapping_pages();
	...

AFAICT, this would be the most appropriate place to put it? Or, did
you have something else in mind?

--<M>--

