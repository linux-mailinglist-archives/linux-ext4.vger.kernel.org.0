Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD5E502C5F
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Apr 2022 17:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353922AbiDOPMm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Apr 2022 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbiDOPMm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Apr 2022 11:12:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B13D85BF3;
        Fri, 15 Apr 2022 08:10:10 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r25so6100734qtp.8;
        Fri, 15 Apr 2022 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SBjy86iuVh8fFOP01G4Xo2Z7vyppTHMdZeNJghULRH8=;
        b=QQnoITYHIwvLmdni4JXE8DQDurcuBVf+FKEU3k5/Dac1DZ3juYc4TLWJnY3ZgfstcN
         5eQ0zoVW5zOx69uj4+wNhR/zenJ34WPDngvetanIIarIjNRk0t9b8PnwZuVjX6LYO/9S
         +z6EM4HGgzyjldg1ktqf+qstxfJdZXa8LBcZ2egSWtUe4LNI2eBdKvrav3qU8/6CsN/U
         hsiWcb/l1M7iLgNoOlTLr4ydUTz96b6WdtrzQc0uM3ZuUfhtCir+aVqSqxVTcM6aCn1Z
         dN6Y4uFgwHG3DQvQUIOG00MFfduyfe7dEFCHWg7v2Oywd9vyB2da4+3I+ZY4nitxAC/i
         m7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SBjy86iuVh8fFOP01G4Xo2Z7vyppTHMdZeNJghULRH8=;
        b=efeqIjuKxlc27f9lGHVyiZCcXGd0uu7t/gdSpzBzcrqyyFo2W2TpEuIAlA2SmCpYMP
         i8qPM2ip2tz47miFKxtpCXamtCi9y7p4n2LlzWdGcDXi8dDnwGAlUeC7uyAENLhk8jNe
         fZNXa4vJy/cbtSuGhq05JocNVFcrmaQKM6nkDg13iimO5KAW6urCz5l5LsKethtTGKOw
         92H94HTIIqDBy9Ivu0zYEvQryl0VOcQJ0BrUhsH5sQJRAKpzVoLhEHvrcpBQ0mXIrOA6
         UFSfmunZWOEfy6PWFJL6Qox3+X0VXh4T4jVGTX/EpReBfL9LMDJ51NL+BaaNKAG7TkKl
         WN6A==
X-Gm-Message-State: AOAM5328bSsBIMXNf1Tl9UWBtzAwW9NvSHjifZLRdeqRmc986BLdtd4s
        QoSIUcoAUC9EIG4wGIiGEBg=
X-Google-Smtp-Source: ABdhPJzTJJSYmVmn+qcF1PGV/6IqqwCaf1NHTwY2erfwmzhq0DIxwvJkB7ZWvLivzi3dkhgR9awdXg==
X-Received: by 2002:a05:622a:64b:b0:2e1:cbc3:c9ff with SMTP id a11-20020a05622a064b00b002e1cbc3c9ffmr5667138qtb.226.1650035409586;
        Fri, 15 Apr 2022 08:10:09 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id b126-20020a37b284000000b0069a11927e57sm2491007qkf.101.2022.04.15.08.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:10:09 -0700 (PDT)
Date:   Fri, 15 Apr 2022 11:10:07 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eric Whitney <enwlinux@gmail.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] common/filter: extend _filter_xfs_io to match -nan
Message-ID: <YlmKz6i8YXR0yk9P@debian-BULLSEYE-live-builder-AMD64>
References: <20220414142258.761835-1-enwlinux@gmail.com>
 <20220414152949.GA17014@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414152949.GA17014@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Darrick J. Wong <djwong@kernel.org>:
> On Thu, Apr 14, 2022 at 10:22:58AM -0400, Eric Whitney wrote:
> > When run on ext4 with sufficiently fast x86_64 hardware, generic/130
> > sometimes fails because xfs_io can report rate values as -nan:
> > 0.000000 bytes, 0 ops; 0.0000 sec (-nan bytes/sec and -nan ops/sec)
> > 
> > _filter_xfs_io matches the strings 'inf' or 'nan', but not '-nan'.  In
> > that case it fails to convert the actual output to a normalized form
> > matching generic/130's golden output.  Extend the regular expression
> > used to match xfs_io's output to fix this.
> > 
> > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> > ---
> >  common/filter | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/common/filter b/common/filter
> > index 5fe86756..5b20e848 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -168,9 +168,9 @@ common_line_filter()
> >  
> >  _filter_xfs_io()
> >  {
> > -    # Apart from standard numeric values, we also filter out 'inf' and 'nan'
> > -    # which can result from division in some cases
> > -    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infa0-9/.]* [EPGMKiBbytes]*\/sec and [infa0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
> > +    # Apart from standard numeric values, we also filter out 'inf', 'nan', and
> > +    # '-nan' which can result from division in some cases
> > +    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infa0-9/.-]* [EPGMKiBbytes]*\/sec and [infa0-9/.-]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
> 
> /me squints at this regular expression and /thinks/ its ok.
> 
> Took me a while to figure out "infa" tho. :P

Hi Darrick:

Yeah, me too.  I initially thought that string would not match 'nan', but
then discovered bracket expressions after having not used sed in a very long
time.  It's a sloppy match - it'll recognize fan0 as well as 'inf' or 'nan',
etc. - and I guess the idea is that's good enough for filtering expected output
from xfs_io while being concise.  The sed documentation suggests that a '-' on
the beginning or end of the bracket expression will be treated literally, and
not as a metacharacter (part of a range), so we should be good there.

> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks very much for your review!

Eric

> 
> --D
> 
> >  }
> >  
> >  # Also filter out the offset part of xfs_io output
> > -- 
> > 2.30.2
> > 
