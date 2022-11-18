Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8A62F3D5
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 12:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiKRLha (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 06:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbiKRLhT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 06:37:19 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A6DAE7B
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 03:37:18 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 130so4611346pfu.8
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 03:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZiBNoLPXRvZ1XJ2KYx48+OW7RzX0huNQG++aDplHYA=;
        b=QzIVc7Oym3luFQjnd1GTwO6kPWsKc84wdqmHuU1dftL1HjS2Rxf5rPeg/vw9gEW1Sc
         BLclygHAIknxKfi1w6bXGRL/OB8XjmxT9i4lcwLDTsADfKYF+5sI0bvEJQmQoZn3n/PX
         WvwMsBQvtWJS3zeZBW4vE2Rx2IM1kKARaINAGxUyJ682G7nlBLcCUcCWMd34XJ+IZeRj
         R0LFrT2GW5JIoE1ArQjzWHFwEzybQietrSJnbuhTFagePd+jOElK/bY+LMaCeI9OQavG
         yjCKA321Sp52xcdTXR54N9E1QmZtr2EE5UmhZoTuSEamh+VFGJ+qFbpZ8vbHy6hWWuKL
         CbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZiBNoLPXRvZ1XJ2KYx48+OW7RzX0huNQG++aDplHYA=;
        b=yil6rkKYSomkJ9YIrYKCAFo1tvPNfgoL4YqcJ/lA1G6rDg6YKmL4GwoJcFABJNEgOR
         RGhTKqaw5wFuUrNc5KsRODrKtcP9vpLWhWCWwwlItclvZRz8JYhTrxzS1A8yJyeurIWK
         POZIWi9B+WzuqbV6ixtc3GduNXIRpZ76N8HlGXc2YSpHva0kr4ELCXU2jCYuXiI8aDOh
         MKKYxqFoZMfX5MNPyLn8dSRVGy2cM8i0qCfKdLRrm8gsfnNyPkzczOK00R01hxs8QvPS
         znTF07tp2+rvJg2dZ46IN9GVAhzNxzbGA7C2cgUolsEZ7wFAhJcICEnesO6hqrPt0cDC
         Hs4Q==
X-Gm-Message-State: ANoB5pnc7r9GF9BwsFahbhj/I8f8n8ysPT3ptOavfkI8PjzIJGrCGfCb
        STfFnMM99L91YuRSx71b7Qf8Vp2I1h0=
X-Google-Smtp-Source: AA0mqf7Q04aTXk3/pxi8LGOBwBRtgZX4YWAfkC7yDAAInLYjZf4OqWlpC+yqvOSNAaM/W9YxA83VUQ==
X-Received: by 2002:a05:6a00:1893:b0:56b:8282:b165 with SMTP id x19-20020a056a00189300b0056b8282b165mr7483751pfh.69.1668771438069;
        Fri, 18 Nov 2022 03:37:18 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id f197-20020a6238ce000000b005629b6a8b53sm3070458pfa.15.2022.11.18.03.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:37:17 -0800 (PST)
Date:   Fri, 18 Nov 2022 17:07:11 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
Subject: Re: [RFCv1 01/72] e2fsck: Fix unbalanced mutex unlock for BOUNCE_MTX
Message-ID: <20221118113711.qby7gtky5k36f7vd@riteshh-domain>
References: <febbbd17b3cf4201aaae24e4adb61e4f8a80e9c9.1667822611.git.ritesh.list@gmail.com>
 <0F4372E0-A232-4DC8-81CE-54D8C0921D1C@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0F4372E0-A232-4DC8-81CE-54D8C0921D1C@dilger.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/18 04:34AM, Andreas Dilger wrote:
> On Nov 7, 2022, at 06:22, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> > 
> > f_crashdisk test failed with UNIX_IO_FORCE_BOUNCE=yes due to unbalanced
> > mutex unlock in below path.
> > 
> > This patch fixes it.
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > ---
> > lib/ext2fs/unix_io.c | 1 -
> > 1 file changed, 1 deletion(-)
> > 
> > diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
> > index e53db333..5b894826 100644
> > --- a/lib/ext2fs/unix_io.c
> > +++ b/lib/ext2fs/unix_io.c
> > @@ -305,7 +305,6 @@ bounce_read:
> >    while (size > 0) {
> >        actual = read(data->dev, data->bounce, align_size);
> >        if (actual != align_size) {
> > -            mutex_unlock(data, BOUNCE_MTX);
> 
> This patch doesn't show enough context, but AFAIK this is jumping before mutex_down()
> is called, so this *should* be correct as is?

Thanks for the review, Andreas.

Yeah, the patch diff above is not sufficient since it doesn't share enuf
context.
But essentially when "actual" is not equal to "align_size", then in this if
condition it goes to label "short_read:", which always goto error_unlock,
where we anyways call mutex_unlock()

Looking at a lot of labels in this function, this definitely looks like 
something which can be cleaned up ("raw_read_blk()"). 
I will add that to my list of todos. 

I have also shared the threadsan warning which detects the unbalanced mutex 
unlock here [1]

[1]: https://lore.kernel.org/linux-ext4/cover.1667822611.git.ritesh.list@gmail.com/T/#md75b3ccb146e4433653bc2d7dd01329a9757ea26

-ritesh
