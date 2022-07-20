Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9407C57B928
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jul 2022 17:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiGTPGu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiGTPGs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 11:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC6B7237D6
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658329607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UK9YreiLbpLF37if8b/b/eB7SmLDxp2g20abdpAcisg=;
        b=NjgkuYOZFDHeERwArAPp+guQNfUh9ggfYvN+Ot2vQWXBRLOC/h7j/SEnkftisbAfxJV2W+
        79I2cg8a4qxae3qcIWfUTuunutLhdPhGzW390NtPylN87IK/oEhp1qIyIo50Eu4jLeUnKR
        5pNY9obTsSJ9DQzphEr5Zseixg7AJj4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-amT_m92ANomeSshAxK2PfA-1; Wed, 20 Jul 2022 11:06:44 -0400
X-MC-Unique: amT_m92ANomeSshAxK2PfA-1
Received: by mail-qt1-f198.google.com with SMTP id x16-20020ac85f10000000b0031d3262f264so12451565qta.22
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 08:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UK9YreiLbpLF37if8b/b/eB7SmLDxp2g20abdpAcisg=;
        b=kHD64VQXqP6ILWqtvg1prOJ3OvRSgoyXotZY50XNx0SnNzXMkYz7PnhR8XSjGfddo5
         n3IJfbYjHkb5vwwQnV44hsYwBQxxZCoTmmRykR38Z1Bh5c0nDJsW58I15G5fylqmgWAz
         /ye/9rHcSFEuZtlqbzoelx/yNihkT+e6UekH/mUY+VkKZaJ6FtZzTDvFT4K87ii6CVOS
         Szd2q7e0NqmOwuo8sUYCS2TuP04dbqTRhneobFOkh9i0tavHlyTjIqp1k1fQ7onTK+Il
         2nXbIkHC7Cvi3/NPEUJjXIm5G5kECPJVBkiS2tocNW9jIW4hkcH44Xrb8EmuHB5b7K9C
         GG6g==
X-Gm-Message-State: AJIora+kZtUddSBXmuYaWcZNQXODnqRkQp8lMGyvYL3e30pg7R8Dm2uK
        83dKuD1tmHSVNuJ/qbVLqrCpNqgbQ1jb9/aJc/3DTe9WLaVeZ7k7ngoHPfi6FPy3oorBnizOhVr
        mCjDIwZPXWdDSmzk+yvL3Tg==
X-Received: by 2002:a05:620a:4507:b0:6af:348b:85fe with SMTP id t7-20020a05620a450700b006af348b85femr25276561qkp.629.1658329603310;
        Wed, 20 Jul 2022 08:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ustt5FtcBl8NwGhEpSo84ymHFf3R1zFX2DaJ5uPRciTbzM+xwaMrpZ2Xqo5Dtj9icbCLj6Ng==
X-Received: by 2002:a05:620a:4507:b0:6af:348b:85fe with SMTP id t7-20020a05620a450700b006af348b85femr25276545qkp.629.1658329603024;
        Wed, 20 Jul 2022 08:06:43 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bi24-20020a05620a319800b006b5d8eb2414sm11627968qkb.120.2022.07.20.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:06:42 -0700 (PDT)
Date:   Wed, 20 Jul 2022 23:06:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jeremy Bongio <bongiojp@gmail.com>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v5] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
Message-ID: <20220720150636.cvd3ls2mbxbows27@zlang-mailbox>
References: <20220720000256.239531-1-bongiojp@gmail.com>
 <20220720100949.dttc5qbmy4qziz65@zlang-mailbox>
 <YtfqIVEi7g4fFpqU@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtfqIVEi7g4fFpqU@mit.edu>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 20, 2022 at 07:42:25AM -0400, Theodore Ts'o wrote:
> On Wed, Jul 20, 2022 at 06:09:49PM +0800, Zorro Lang wrote:
> > On Tue, Jul 19, 2022 at 05:02:56PM -0700, Jeremy Bongio wrote:
> > > +# Override the default cleanup function.
> > > +_cleanup()
> > > +{
> > > +        cd /
> > > +        rm -r -f $tmp.*
> > > +        kill -9 $fsstress_pid 2>/dev/null;
> > > +        wait $fsstress_pid > /dev/null 2>&1
> > 
> > I think "wait" is enough. With this change, it's good to me.
> 
> The kill -9 is needed, because otherwise the test will run for a
> **very** long time.  The reason for it is because of the -n 999999 in

Sure, I mean:

  kill -9 $fsstress_pid 2>/dev/null
  wait

Not remove the "kill" line :)

> fstress_args:
> 
> > > +# Begin fsstress while modifying UUID
> > > +fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
> > > +$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
> > > +fsstress_pid=$!
> 
> We could adjust the number of loops to a more reasonable number, but
> then test becomes less reliable, since depending on the storage device
> (e.g., cheap USB thumb drive found in the checkout counter at a
> convenience store, vs. a high-end NVMe SSD) and the overall speed of
> the system, a different number of loops will be needed.
> 
> Given that we're *only* using the fsstress as an antogonist while we
> are changing the UUID of the file system 20 times, killing the
> fsstress once we're done with the UUID runs is sufficient, I would
> argue.
> 
> Also, Jeremy, it looks like you haven't updated your xfstests-dev
> repository in a few weeks.  Since you started this project, ext4/056
> has been assigned, and there has been some new helper programs added
> which caused patch conflicts in src/Makefile and in .gitignore.  They
> were pretty trivial to fix up the patch conflicts (which I've done in
> my xfstests-dev tree), but it's best practice to rebase on top of
> origin/for-next and re-test just to make sure there haven't been some
> major change in the fstests common scripts that might catch your test
> out.

Thanks for pointing out that, yes, better to rebase to latest fstests
for-next branch.

> 
> Also, feel free to add my:
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Sure,

Thanks,
Zorro

> 
> Cheers,
> 
> 						- Ted
> 

