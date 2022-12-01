Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F963F9D2
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiLAVaM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 16:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiLAVaD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 16:30:03 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7CC358F
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 13:30:01 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 130so3091916pfu.8
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 13:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4h80UNUS79jX4Y4VHbk2odBURDMrNuryh2RN0FwTUs=;
        b=MHbyO0KzWqWDcko/HpBbj01/JqUdQ4Gd7GFAQ3FgQ8FeZ/Z+rOs+HvIG4gWSk9aKAi
         /3OHhS/ZI0i4WbNx6hXU6y9Fn9FGFOweLBc0w6UwiWZ4nFNCtkPjktlQ/GvA+wn+Sd3P
         2R+YOkZE806/ATQA4zDbkPZRYtT05axZHAiBLs5oNplSt/W/HgMlgLEYOW0Y6w1qqAlw
         R75OhgJl/fvapTvLOkfXunrX03V83nhRXQ5GjMFsu6v2M7xvDObqVBlcoV35NByWxaC6
         revzZnMUwFo6mvToOpVS8bRbbuaIq4arZbZegCJrCF6h2ESqzAblJ32JsFo93Yta5Fxp
         n+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4h80UNUS79jX4Y4VHbk2odBURDMrNuryh2RN0FwTUs=;
        b=JDE+VpJyqMwYJpw0Tk8TDnboAGQhXCLL+M/Rq2f4DrOIvBRE6nvj7Q5sltVQb2lMUD
         5HZkeSU7c0YMTU/Vrd9d+xYkh3RWWf05cPq5ns9/whMCgG18oi+dUbL26o1zYMCQqcFv
         B3LoQrmv6hua/d099HspDKZxF5xG8svgB5dQx9w1uMYharuA7viJOGJYLIVAftO1Cl4r
         Nv2ozhq8ckzjmtmtX1sXjjDG0ZSG3j9cw9trsJ0n68+gR/Z2b13vRlHijVWOq/lVdFa2
         OFLJpWuZGNJ9JAg5H3A3zQlvqM6rponWHFbgMOriWbcNjfO1/zyKo3dbskpqvlwnIKaj
         1qDw==
X-Gm-Message-State: ANoB5pnnhn27CyhP5EQsyM1DO0bForGiFSjvbN0Tilg6WBxEn/Sk+g52
        29P/fsarkfaJA+c+/5DkSuRkYg==
X-Google-Smtp-Source: AA0mqf5jBMwE7VJtXdUtb9MV4o9tCdBmLTQr+bzOQc7ZjJ/ZjrEiVNzds8k8js/z73QdAqb5M76IJw==
X-Received: by 2002:a62:79cc:0:b0:575:bd04:504c with SMTP id u195-20020a6279cc000000b00575bd04504cmr12486711pfc.72.1669930200568;
        Thu, 01 Dec 2022 13:30:00 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id d33-20020a631d21000000b00477e0f7ab89sm2949537pgd.38.2022.12.01.13.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:30:00 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p0r80-003N0l-GZ; Fri, 02 Dec 2022 08:29:56 +1100
Date:   Fri, 2 Dec 2022 08:29:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v2 0/3] Turn iomap_page_ops into iomap_folio_ops
Message-ID: <20221201212956.GO3600936@dread.disaster.area>
References: <20221201160619.1247788-1-agruenba@redhat.com>
 <20221201180957.1268079-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201180957.1268079-1-agruenba@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 01, 2022 at 07:09:54PM +0100, Andreas Gruenbacher wrote:
> Hi again,
> 
> [Same thing, but with the patches split correctly this time.]
> 
> we're seeing a race between journaled data writes and the shrinker on
> gfs2.  What's happening is that gfs2_iomap_page_done() is called after
> the page has been unlocked, so try_to_free_buffers() can come in and
> free the buffers while gfs2_iomap_page_done() is trying to add them to
> the transaction.  Not good.
> 
> This is a proposal to change iomap_page_ops so that page_prepare()
> prepares the write and grabs the locked page, and page_done() unlocks
> and puts that page again.  While at it, this also converts the hooks
> from pages to folios.
> 
> To move the pagecache_isize_extended() call in iomap_write_end() out of
> the way, a new folio_may_straddle_isize() helper is introduced that
> takes a locked folio.  That is then used when the inode size is updated,
> before the folio is unlocked.
> 
> I've also converted the other applicable folio_may_straddle_isize()
> users, namely generic_write_end(), ext4_write_end(), and
> ext4_journalled_write_end().
> 
> Any thoughts?

I doubt that moving page cache operations from the iomap core to
filesystem specific callouts will be acceptible. I recently proposed
patches that added page cache walking to an XFS iomap callout to fix
a data corruption, but they were NAKd on the basis that iomap is
supposed to completely abstract away the folio and page cache
manipulations from the filesystem.

This patchset seems to be doing the same thing - moving page cache
and folio management directly in filesystem specific callouts. Hence
I'm going to assume that the same architectural demarcation is
going to apply here, too...

FYI, there is already significant change committed to the iomap
write path in the current XFS tree as a result of the changes I
mention - there is stale IOMAP detection which adds a new page ops
method and adds new error paths with a locked folio in
iomap_write_begin(). 

And this other data corruption (and performance) fix for handling
zeroing over unwritten extents properly:

https://lore.kernel.org/linux-xfs/20221201005214.3836105-1-david@fromorbit.com/

changes the way folios are looked up and instantiated in the page
cache in iomap_write_begin(). It also adds new error conditions that
need to be returned to callers so to implement conditional "folio
must be present and dirty" page cache zeroing from
iomap_zero_iter(). Those semantics would also have to be supported
by gfs2, and that greatly complicates modifying and testing iomap
core changes.

To avoid all this, can we simple move the ->page_done() callout in
the error path and iomap_write_end() to before we unlock the folio?
You've already done that for pagecache_isize_extended(), and I can't
see anything obvious in the gfs2 ->page_done callout that
would cause issues if it is called with a locked dirty folio...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
