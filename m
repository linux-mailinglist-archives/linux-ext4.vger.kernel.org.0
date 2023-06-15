Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF57732315
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 01:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjFOXHk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 19:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjFOXHk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 19:07:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3F5272C
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 16:07:37 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b512309c86so1536865ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 16:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686870456; x=1689462456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPv4fbHe7J+eAL9Nmh6sjLcdVOBe69VQf0iTOrC71Yc=;
        b=F1wUuYVVR2j9n9/nCFqETna6uJ4/EAXcQGDAaTiHcsBG2HhKhsXXt2WZWg35Aq6EOd
         XsCTG2WRBt3AJBnpsJOfdrC9TfasW1ANGOk6VaLrN4fZ8RYqsPsA1GpgtSuGxqaUDMnI
         6Na+cuc5cIZEjansQvyQqk5n0L+SzV/iVg2M+lCGqoXXK5xSk5YhId2VCbbk9io6trHN
         drX9NsDF6V8Ax6znUXaF9QInFabqOp9Mivc42fOTTfR6VHoDA2TkQKbipbQZLYjjdGpm
         if5chhDyumICFJirJ450geIqvfACiwLYc4R9E4pYBYu/opQ37+0ZGuXdJ93DlSABu/y0
         0ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686870456; x=1689462456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPv4fbHe7J+eAL9Nmh6sjLcdVOBe69VQf0iTOrC71Yc=;
        b=N9qQPlKUOLhfXNX/DF7b6XXMEbeO5ub7+funsp+HgIbEfLZd40oaTgeoOPy5o2++L7
         O/VsC+wl9tv+hOUZnTwfdttejl4wsYV18Y3JX7N0Pw/v4wycsKZhNI7eg+X++8eRGwG6
         CNhp2XhHslmPu22Ew++vsDJEyWJYYu6UDpVVuZYvEdqfEcKlIhd9HowVXhCanxQkF9Jr
         iRuWZNJi+bjN7lA3tT6stUaUKK7PM57ANTwM44t0RAURAW+OGzlOKZIdi8QW0AL4o6dR
         +pLvD8uVicm3uw8TXvppzYSdp+dWm88ZeNNJdn8HWQL6WbLjjoCq6Jl7HEMyy9ZBhgzC
         vaaw==
X-Gm-Message-State: AC+VfDw2fWRyme7XfG4G22TEcjs8qWMUScMAtE+MfZ4COtlvI9gXj6pW
        R3Ozd/6fnYy64MNLgwP4H7mLrA==
X-Google-Smtp-Source: ACHHUZ6Rd2Y9gQSkogQeX1TMGEvvCehKiRYGqJWHFIXaSSSeR/C2ip04Q7NDkBb9deO2xNhWgjkm0A==
X-Received: by 2002:a17:902:f68a:b0:1b4:5699:aac8 with SMTP id l10-20020a170902f68a00b001b45699aac8mr7610606plg.21.1686870456517;
        Thu, 15 Jun 2023 16:07:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id u16-20020a63f650000000b00502f4c62fd3sm13360868pgj.33.2023.06.15.16.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:07:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9w3w-00CFXl-2H;
        Fri, 16 Jun 2023 09:07:32 +1000
Date:   Fri, 16 Jun 2023 09:07:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH] ext4: enable nowait async buffered writes
Message-ID: <ZIuZtP7uxRKAOMmB@dread.disaster.area>
References: <20230614083105.20663-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614083105.20663-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 14, 2023 at 04:31:04PM +0800, Lu Hongfei wrote:
> This adds the async buffered write support to ext4,
> the following is the relevant test data.
> 
>     iodepth      | 1    | 2    | 4    | 8    | 16   | 32   |
>     before(M/s)  | 842  | 1047 | 1098 | 1167 | 1172 | 1247 |
>     after(M/s)   | 1293 | 1674 | 1794 | 1862 | 1897 | 1833 |
> 
> The following is the fio configuration:
> 
> [global]
> ioengine=io_uring
> sqthread_poll=1
> threads=1
> iodepth=16
> hipri=0
> direct=0
> fixedbufs=0
> uncached=0
> nowait=0
> force_async=0
> randrepeat=0
> time_based=0
> size=256M
> filename=/data/test/local/io_uring_test
> group_reporting
> [read256B-rand]
> bs=4096
> rw=randwrite
> numjobs=1
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/ext4/file.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 6a16d07965f9..5da7c5612324
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -288,9 +288,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>  	ssize_t ret;
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  
> -	if (iocb->ki_flags & IOCB_NOWAIT)
> -		return -EOPNOTSUPP;
> -
>  	inode_lock(inode);

Ah, no, that's not how we enable IOCB_NOWAIT functionality. Just
because removing the check makes it go a little bit faster, it
doesn't mean that it is actually doing the right thing.

i.e. before remove IOCB_NOWAIT checks like this, we actually have to
make the functionality operate in a non-blocking manner when
IOCB_NOWAIT is set.  Clearly, this patch does not do that, because
the very first thing that occurs after the removed NOWAIT check is a
blocking inode_lock() call....

Please go and look at the series that added NOWAIT buffered write
support to XFS for io_uring an example of sorts of changes that need
to be made to ext4 to support IOCB_NOWAIT buffered writes.

https://lore.kernel.org/linux-xfs/20220608171741.3875418-1-shr@fb.com/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
