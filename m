Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D12521F53
	for <lists+linux-ext4@lfdr.de>; Tue, 10 May 2022 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346236AbiEJPsQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 May 2022 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346237AbiEJPsM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 May 2022 11:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 037AF281343
        for <linux-ext4@vger.kernel.org>; Tue, 10 May 2022 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652197447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QAS1avXWgT/iTNldK5a2r3A+R8xrqOB9hbTmJ0/08G4=;
        b=ZHFo7DYx+Vq7V3BqfeN+7wlZK6tkFxRB664mI7+9XwdU0k3EGs45MppZGtVuPe4qFn4AQ3
        KCsjajr3ZP/QKlxecrfFObl+nywTsYlwj1mgD3m+Kp0HXD1KZPuIOCjVcvRdKdRbzARCdZ
        KD/tUFvzcQ/Ccunkt2HYlgva3vS0R8k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-Dno2jYjGNSW_fFVvPwhAIA-1; Tue, 10 May 2022 11:44:06 -0400
X-MC-Unique: Dno2jYjGNSW_fFVvPwhAIA-1
Received: by mail-qv1-f70.google.com with SMTP id j1-20020a0cf9c1000000b0045abd139f01so13956102qvo.23
        for <linux-ext4@vger.kernel.org>; Tue, 10 May 2022 08:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=QAS1avXWgT/iTNldK5a2r3A+R8xrqOB9hbTmJ0/08G4=;
        b=Pdg9rk47tIdFlKphR78d5kLjtxkLke9+rNxss2+hfaitcjK26iYi5GWpOKzsieq4Xy
         Nz7Dn092+e2L9nBkZR5Wf2/Nj6jB61j1Z8ML1/y28VA2P1+zC0h9khVd+zzFowzcVul1
         x2c1luJM2LXeVdvCnvh1FSMHEr6pO0jos1ovkPi/1i3q8iSypZB0hIvvyUlfNDbfhm2W
         b1Q8RVYXdZ4zijyQEfugnhB1rpYJSMQGX6/mpIxfC05Ddoxtg7tLQ3Flc6xcLBQGy+sm
         1mBgGhZTq5dRb7xgIEbKo98jgn/Ecd4Tod0pMElWFJf09JOEdHVQi+2UKzLr4EcVF9Ar
         TZBA==
X-Gm-Message-State: AOAM533nqhhZKJAcInEXDtysXxn5hxurEbO6V0xtATP5zJA2qwOndBKm
        K13mcRIDmVhfDT2PuC81GwexSEnDaLNi5hf7mGQFfq6jebEel6TvG9vOF+o5vDKl87QCrVYlezW
        ZAs1JC421Rb0NVjeoOcKxzA==
X-Received: by 2002:a05:622a:549:b0:2f3:e1cb:408f with SMTP id m9-20020a05622a054900b002f3e1cb408fmr5116965qtx.445.1652197445907;
        Tue, 10 May 2022 08:44:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQuGtFstNmojqM8gViCc1xi6AXUEr+Z6/xDpP+R/Hx6VUnSdhyPlb7wtker7kZeRlLrGnnbA==
X-Received: by 2002:a05:622a:549:b0:2f3:e1cb:408f with SMTP id m9-20020a05622a054900b002f3e1cb408fmr5116951qtx.445.1652197445632;
        Tue, 10 May 2022 08:44:05 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a150600b0069ff8ebec64sm8364562qkk.103.2022.05.10.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:44:05 -0700 (PDT)
Date:   Tue, 10 May 2022 23:43:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH] ext4/053: fix the rejected mount option testing
Message-ID: <20220510154359.xfhmumcmb4o37qdy@zlang-mailbox>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20220430192130.131842-1-ebiggers@kernel.org>
 <Ynmmy+bWp0Q1/747@sol.localdomain>
 <20220510094308.mhzvcgq5wrat5qao@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510094308.mhzvcgq5wrat5qao@fedora>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 10, 2022 at 11:43:08AM +0200, Lukas Czerner wrote:
> On Mon, May 09, 2022 at 04:42:03PM -0700, Eric Biggers wrote:
> > On Sat, Apr 30, 2022 at 12:21:30PM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > 'not_mnt OPTIONS' seems to have been intended to test that the
> > > filesystem cannot be mounted at all with the given OPTIONS, meaning that
> > > the mount fails as opposed to the options being ignored.  However, this
> > > doesn't actually work, as shown by the fact that the test case 'not_mnt
> > > test_dummy_encryption=v3' is passing in the !CONFIG_FS_ENCRYPTION case.
> > > Actually ext4 ignores this mount option when !CONFIG_FS_ENCRYPTION.
> > > (The ext4 behavior might be changed, but that is besides the point.)
> > > 
> > > The problem is that the do_mnt() helper function is being misused in a
> > > context where a mount failure is expected, and it does some additional
> > > remount tests that don't make sense in that context.  So if the mount
> > > unexpectedly succeeds, then one of these later tests can still "fail",
> > > causing the unexpected success to be shadowed by a later failure, which
> > > causes the overall test case to pass since it expects a failure.
> > > 
> > > Fix this by reworking not_mnt() and not_remount_noumount() to use
> > > simple_mount() in cases where they are expecting a failure.  Also fix
> > > up some of the naming and calling conventions to be less confusing.
> > > Finally, make sure to test that remounting fails too, not just mounting.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > >  tests/ext4/053 | 148 ++++++++++++++++++++++++++-----------------------
> > >  1 file changed, 78 insertions(+), 70 deletions(-)
> > 
> > Lukas, any thoughts on this patch?  You're the author of this test.
> > 
> > - Eric
> 
> Haven't tested it myself but the change looks fine, thanks.

Thanks for you help to review this patch. There's an new failure[1] after we
merged this patch:
  "SHOULD FAIL remounting ext2 "commit=7" (remount unexpectedly succeeded) FAILED"

As this test generally passed, so before I give "Oops" to others, I hope to
check with you that if this's an expected failure we need to fix in kernel
or in this case itself?

Thanks,
Zorro

> 
> You can add
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> 

