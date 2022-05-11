Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C56522C41
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 08:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbiEKGZS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 02:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241359AbiEKGZP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 02:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0953C227808
        for <linux-ext4@vger.kernel.org>; Tue, 10 May 2022 23:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652250313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3abCV31hEIagI/Cf2hwMAxBja66bv5qyGLhg7RJLWc=;
        b=eGZx7RL4IH10HlDBPFg5K7FGmA71OdE4jXh3DBaWoNQDN4I/PCaWM1LYbyO09IeGHURHiv
        0xsPimy9sqIeoncbLjlfqjRA4BRmo0q3p51tUlf4VJBnhAPylqsh5qd3WkCdtCykMMyQf5
        rOAARruYqpIW6UJZSQIfAf1PDRZRIsM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-nLMKRiw4NUqwYOKrJvGLzw-1; Wed, 11 May 2022 02:25:11 -0400
X-MC-Unique: nLMKRiw4NUqwYOKrJvGLzw-1
Received: by mail-qv1-f71.google.com with SMTP id bu6-20020ad455e6000000b004563a74e3f9so1232767qvb.9
        for <linux-ext4@vger.kernel.org>; Tue, 10 May 2022 23:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=o3abCV31hEIagI/Cf2hwMAxBja66bv5qyGLhg7RJLWc=;
        b=fZeuwW+S/gVTdhJPZBHQS3lVhzGjqpA4GrJc70WDSS9j34tRS5+7SNiKMuY4boMwJb
         q+x8bd6IcRDepyvijewrh9ktYSNQNsmbM1H1g6AYUG2pzXWr7QwD7yrMDfwzAxH0Tjcc
         2henSmzszSZtVDx5u+QJ6405+18tifNGisAYm5T+NFxRsVPgL/LMgPw7iXeVzZ/roVak
         Y1EWmbJm/mDBVOsyMZFq9CP8yXzBPuINtgPKG+yY8bG54NF+RURR2kzf1G8DQdtZVq8/
         lzKcGnd70j9m6bNhatf49GBZPqoMCAlP0fTaDE1L4AN81kwpBm4vXOuH0e176uMyk8OI
         Oj4Q==
X-Gm-Message-State: AOAM530UdZZlmLSmpbUY0AdXqFQ5AwuwzfRqaZhkjq7k1H5vI9ccXsRY
        J7KVVN4pAr5pzzjAdbXu5DXm8aW9eox7Bl5Xgy17BneQ8UHadapvOUCnTzwkERWPkP3/3fAvK5C
        F1YpuhpzmNRwdeqtiSsgtqA==
X-Received: by 2002:a05:620a:40c8:b0:6a0:922b:2d82 with SMTP id g8-20020a05620a40c800b006a0922b2d82mr9969597qko.252.1652250311106;
        Tue, 10 May 2022 23:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykqVcKNhhyYS6Y76lvSPlfcHxP/l7/GoT5qBFEzzRZOvzT2VGfolaTnc8xcziW6QWY+55cQA==
X-Received: by 2002:a05:620a:40c8:b0:6a0:922b:2d82 with SMTP id g8-20020a05620a40c800b006a0922b2d82mr9969586qko.252.1652250310816;
        Tue, 10 May 2022 23:25:10 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b002f3ef928fbbsm626311qtn.72.2022.05.10.23.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:25:10 -0700 (PDT)
Date:   Wed, 11 May 2022 14:25:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lukas Czerner <lczerner@redhat.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH] ext4/053: fix the rejected mount option testing
Message-ID: <20220511062504.c4ed7rhdyqfe54y6@zlang-mailbox>
Mail-Followup-To: Eric Biggers <ebiggers@kernel.org>,
        Lukas Czerner <lczerner@redhat.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20220430192130.131842-1-ebiggers@kernel.org>
 <Ynmmy+bWp0Q1/747@sol.localdomain>
 <20220510094308.mhzvcgq5wrat5qao@fedora>
 <20220510154359.xfhmumcmb4o37qdy@zlang-mailbox>
 <Ynqwotv9lQvt3TV3@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynqwotv9lQvt3TV3@sol.localdomain>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 10, 2022 at 11:36:18AM -0700, Eric Biggers wrote:
> On Tue, May 10, 2022 at 11:43:59PM +0800, Zorro Lang wrote:
> > On Tue, May 10, 2022 at 11:43:08AM +0200, Lukas Czerner wrote:
> > > On Mon, May 09, 2022 at 04:42:03PM -0700, Eric Biggers wrote:
> > > > On Sat, Apr 30, 2022 at 12:21:30PM -0700, Eric Biggers wrote:
> > > > > From: Eric Biggers <ebiggers@google.com>
> > > > > 
> > > > > 'not_mnt OPTIONS' seems to have been intended to test that the
> > > > > filesystem cannot be mounted at all with the given OPTIONS, meaning that
> > > > > the mount fails as opposed to the options being ignored.  However, this
> > > > > doesn't actually work, as shown by the fact that the test case 'not_mnt
> > > > > test_dummy_encryption=v3' is passing in the !CONFIG_FS_ENCRYPTION case.
> > > > > Actually ext4 ignores this mount option when !CONFIG_FS_ENCRYPTION.
> > > > > (The ext4 behavior might be changed, but that is besides the point.)
> > > > > 
> > > > > The problem is that the do_mnt() helper function is being misused in a
> > > > > context where a mount failure is expected, and it does some additional
> > > > > remount tests that don't make sense in that context.  So if the mount
> > > > > unexpectedly succeeds, then one of these later tests can still "fail",
> > > > > causing the unexpected success to be shadowed by a later failure, which
> > > > > causes the overall test case to pass since it expects a failure.
> > > > > 
> > > > > Fix this by reworking not_mnt() and not_remount_noumount() to use
> > > > > simple_mount() in cases where they are expecting a failure.  Also fix
> > > > > up some of the naming and calling conventions to be less confusing.
> > > > > Finally, make sure to test that remounting fails too, not just mounting.
> > > > > 
> > > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > > ---
> > > > >  tests/ext4/053 | 148 ++++++++++++++++++++++++++-----------------------
> > > > >  1 file changed, 78 insertions(+), 70 deletions(-)
> > > > 
> > > > Lukas, any thoughts on this patch?  You're the author of this test.
> > > > 
> > > > - Eric
> > > 
> > > Haven't tested it myself but the change looks fine, thanks.
> > 
> > Thanks for you help to review this patch. There's an new failure[1] after we
> > merged this patch:
> >   "SHOULD FAIL remounting ext2 "commit=7" (remount unexpectedly succeeded) FAILED"
> > 
> > As this test generally passed, so before I give "Oops" to others, I hope to
> > check with you that if this's an expected failure we need to fix in kernel
> > or in this case itself?
> > 
> 
> This appears to be a kernel bug, so to fix it I've sent the patch
> "ext4: reject the 'commit' option on ext2 filesystems"
> (https://lore.kernel.org/r/20220510183232.172615-1-ebiggers@kernel.org).

Thanks, great to know that.

> 
> I didn't notice this earlier because it's not reproducible with
> CONFIG_EXT2_FS=y.  But it is reproducible with CONFIG_EXT2_FS=n and
> CONFIG_EXT4_USE_FOR_EXT2=y.

Yes, I tested with this config. I'll remind this failure in next fstests
announcement, Thanks a lot!

Thanks,
Zorro

> 
> - Eric
> 

