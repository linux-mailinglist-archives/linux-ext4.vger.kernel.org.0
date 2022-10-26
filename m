Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A6660E270
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiJZNrB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Oct 2022 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiJZNq2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Oct 2022 09:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0147E838
        for <linux-ext4@vger.kernel.org>; Wed, 26 Oct 2022 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666791973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bruAT5FN5UzkvBgHAVJeHTZnXfRT2vJaSunCwR3GLy0=;
        b=CAuIXGhRrUJSlZFpP+OLd4K/dzKXi6pXDIGW5wy4YC1WmwiOwM7IIg5gnTIEz2muIwMmQd
        ElKvSTNMxuUSrHLzbVahZezNwH4FVxU+5mSLlzDI86p3N09/tksAVY4YY26B7rJ0C8pCJY
        rli2k4d7UG0IGojAEjCm8HbEob6mw3c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-gje19RlbNXSpdBuUNx05rg-1; Wed, 26 Oct 2022 09:46:11 -0400
X-MC-Unique: gje19RlbNXSpdBuUNx05rg-1
Received: by mail-pg1-f200.google.com with SMTP id q63-20020a632a42000000b0045724b1dfb9so7962493pgq.3
        for <linux-ext4@vger.kernel.org>; Wed, 26 Oct 2022 06:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bruAT5FN5UzkvBgHAVJeHTZnXfRT2vJaSunCwR3GLy0=;
        b=wtn81vNk9ih+CS4OKumPrxCNFVBa7A01HCmdO/1lP7dpga8vjVkuw4Lro2vsE3Z/Ye
         kkUkpisz1IyTgbW0F2CmfKkYYfkDD2UEbNIymLZ1bSruJlbpzOlwIEr4H1a1/Pj2cRp0
         sjFgXz+IEf1/OH/Kx9YAPFHCLcNIRiK5EO9v/2ObH7kC/iwvIQ7TcdArYJ8omidPUeKu
         09+EqX1rAOLu2cBTUgmUKalyg0/fJp6yVQQwmZjim1qn/L5+celc64tt0CghaIGnV93e
         ScSFu7c6JdbQD1SmHNoO9RWCAn3+1D4UtcR/RSE6KJghkE8SyWZC7MNWdX3YRoBwQusT
         9uIQ==
X-Gm-Message-State: ACrzQf3IQpfn74GPo/38gFPxDZJ0ewFsIturApj0hQ84sQye9hF9rFBy
        /ZqaimTu20ywAbjSrIdZmMpZLbwdT0k20g9EZktzrcUWugMpaJazLEQqH9EB6gE3LV5bTkwAZc8
        CKCACgk+J0/w7v65XZx4x8Q==
X-Received: by 2002:a63:dc54:0:b0:44c:ce26:fa35 with SMTP id f20-20020a63dc54000000b0044cce26fa35mr38559241pgj.374.1666791970298;
        Wed, 26 Oct 2022 06:46:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4BZAQADVkqt6gsC3mjYWhVJkJMQZXggkbquaa0yqbxe5S/0fYvhYvldFm2KPuwoMP2f2INQQ==
X-Received: by 2002:a63:dc54:0:b0:44c:ce26:fa35 with SMTP id f20-20020a63dc54000000b0044cce26fa35mr38559227pgj.374.1666791970007;
        Wed, 26 Oct 2022 06:46:10 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a187-20020a621ac4000000b0056bcc744bdbsm3005438pfa.203.2022.10.26.06.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:46:09 -0700 (PDT)
Date:   Wed, 26 Oct 2022 21:46:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] generic/455: add $FSX_AVOID
Message-ID: <20221026134604.ks5pview6j6ly4t4@zlang-mailbox>
References: <20221021211950.510006-1-enwlinux@gmail.com>
 <20221026030827.GT2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026030827.GT2703033@dread.disaster.area>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 26, 2022 at 02:08:27PM +1100, Dave Chinner wrote:
> On Fri, Oct 21, 2022 at 05:19:50PM -0400, Eric Whitney wrote:
> > generic/455 fails when run on an ext4 bigalloc file system.  Its
> > fsx invocations can make insert range and collapse range calls whose
> > arguments are not cluster aligned, and ext4 will fail those calls for
> > bigalloc.  They can be suppressed by adding the FSX_AVOID environment
> > variable to the fsx invocation and setting its value appropriately in
> > the test environment, as is done for other fsx-based tests.  This
> > avoids the need to exclude the test to avoid failures and makes it
> > possible to take advantage of the remainder of its coverage.
> > 
> > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> > ---
> >  tests/generic/455 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/455 b/tests/generic/455
> > index 649b5410..c13d872c 100755
> > --- a/tests/generic/455
> > +++ b/tests/generic/455
> > @@ -77,7 +77,7 @@ FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV"
> >  seeds=(0 0 0 0)
> >  # Run fsx for a while
> >  for j in `seq 0 $((NUM_FILES-1))`; do
> > -	run_check $here/ltp/fsx $FSX_OPTS -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
> > +	run_check $here/ltp/fsx $FSX_OPTS $FSX_AVOID -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
> 
> generic/457 needs this fix as well.

Yes,
$ grep -rsn here/ltp/fsx tests/|grep -Ev "FSX_AVOID|replay-ops"
tests/generic/457:86:   run_check $here/ltp/fsx $FSX_OPTS -S 0 -j $j $SCRATCH_MNT/testfile$j &
tests/generic/455:80:   run_check $here/ltp/fsx $FSX_OPTS -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &

Hi Eric,

May you resend this patch? And you can keep Darrick's RVB in V2.

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

