Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE6427F599
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 01:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbgI3XAD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Sep 2020 19:00:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56802 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgI3XAA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Sep 2020 19:00:00 -0400
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kNl4n-00081V-Ms
        for linux-ext4@vger.kernel.org; Wed, 30 Sep 2020 22:59:57 +0000
Received: by mail-lf1-f71.google.com with SMTP id 134so1029483lfm.6
        for <linux-ext4@vger.kernel.org>; Wed, 30 Sep 2020 15:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcvJhvn9UY0YhMKUnHywa4IJSmBX/YNTsxRuwRKyCvc=;
        b=YPWwYYBvlR8jSCEM4ie6KLMdwUSY82JWpo9ZPMt0tDZYtjdqJg0ULCuei7caERh3Vy
         RhMQatkcbovJvEPrVXWmBjyY5799l2kg3vxj+xiQYN+g20250kqAC51LOYRDDJA86qaL
         +qXuOIOMsjEfUEVVbkhW30PRcDVGFez2n375hr802Yg3Qk3irU4jp3kcQZxu9Yqr0F0m
         iabiPX3Bx3VgbVlpNgYe5TCDsNRjG5EnS5upLSVBhptD8HNlwv6KbvSCPAuvqoedA0oI
         a5UxeYjufqDGBeLVsAhKKlF8iEhdECpM24UypJ1UKTsIQYOZ2AJpCxtEkAIQ18J6BUFJ
         HDDQ==
X-Gm-Message-State: AOAM533jRwuT44szggr9+5YxBjNmF8ZreskrFAulVibiN7LcLaTcRNwj
        QiZYOT26bZJPpuREieBGhhbb01LsT9VECRadxzhZmveq0u6Z+zPXUL8CqmU7r9fFDWRDKIG3Dax
        NhGiGqwSzIHQBiZ5f6nBx3gmc/nczVnRJAH672XUBtWXTBjmRFA05kSQ=
X-Received: by 2002:a19:4251:: with SMTP id p78mr1775239lfa.154.1601506796963;
        Wed, 30 Sep 2020 15:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb0/xGDybLhVC37g5xHzofb7vk03vRy3epdK860axrrfxQIV9LRi8jSj/7NYGoSemB2quMSzKbp28W/Z+DiMA=
X-Received: by 2002:a19:4251:: with SMTP id p78mr1775222lfa.154.1601506796624;
 Wed, 30 Sep 2020 15:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200928194103.244692-1-mfo@canonical.com> <20200929113727.GK10896@quack2.suse.cz>
In-Reply-To: <20200929113727.GK10896@quack2.suse.cz>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 30 Sep 2020 19:59:44 -0300
Message-ID: <CAO9xwp3fy1p7+J2ag8PbtTGb5R5-tNuko77j-w4yG=zp+QdkZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/4] ext4/jbd2: data=journal: write-protect pages
 on transaction commit
To:     Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 29, 2020 at 8:37 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 28-09-20 16:40:59, Mauricio Faria de Oliveira wrote:
> > Hey Jan,
> >
> > This series implements your suggestions for the RFC PATCH v3 set [1].
> >
> > That addressed the issue you confirmed with block_page_mkwrite() [2].
> > There's no "JBD2: Spotted dirty metadata buffer" message in over 72h
> > runs across 3 VMs (it used to happen within a few hours.) *Thanks!*
> >
> > I added Reviewed-by: tags for the patches/changes you mentioned.
> > The only changes from v3 are patch 3 which is new, and contains
> > the 2 fixes to ext4_page_mkwrite(); and patch 4 changed 'struct
> > writeback_control.nr_to_write' from ~0ULL to LONG_MAX, since it
> > is signed long (~0ULL overflows to -1; kudos, kernel test robot!)
> >
> > It looks almost good on fstests: zero regressions on data=ordered,
> > and two apparently flaky tests data=journal (generic/347 _passed_
> > 1/6 times with the patch, and generic/547 failed 1/6 times.)
>
> Cool. Neither of these tests has anything to do with mmap. The first test
> checks what happens when thin provisioned storage runs out of space (and
> that fs remains consistent), the second tests that fsync flushed properly
> all data and that it can be seen after a crash. So I'm reasonably confident
> that it isn't caused by your patches. It still might be a bug in
> data=journal implementation though but that would be something for another
> patch series :).
>

Hey Jan,

That's good to hear! Now that the patchset seems to be in good shape,
I worked on testing it these last 2 days. Good and mixed-feelings news. :-)

1) For ext4 first, I have put 2 VMs to run fstests in a loop overnight,
(original and patched kernels, ~20 runs each). It looks like the patched VM
has more variance of failed/flaky tests, but the "average failure set" holds.

I think some of the failures were flaky or timing related, because when I ran
some tests, e.g. generic/371 a hundred times (./check -i 100 generic/371)
then it only failed 6 out of 100 times. So I didn't look much more into it, but
should you feel like recommending a more careful look, I'll be happy to do it.

For documentation purposes, the results on v5.9-rc7 and next-20200930,
showing no "permanent" regressions. Good news :)

    data=ordered:
    Failures: ext4/045 generic/044 generic/045 generic/046 generic/051
generic/223 generic/388 generic/465 generic/475 generic/553
generic/554 generic/555 generic/565 generic/611

    data=journal:
    Failures: ext4/045 generic/051 generic/223 generic/347 generic/388
generic/441 generic/475 generic/553 generic/554 generic/555
generic/565 generic/611

2) For OCFS2, I just had to change where we set the callbacks in (patch 2.)
(I'll include that in the next, hopefully non-RFC patchset, with
Andreas suggestions.)

Then a local mount also has no regressions on "stress-ng --class filesystem,io".
Good news too :)  For reference, the steps:

    # mkfs.ocfs2 --mount local $DEV
    # mount $DEV $MNT
    # cd $MNT
    # stress-ng --sequential 0 --class filesystem,io

3) Now, the mixed-feelings news.

The synthetic test-case/patches I had written clearly show that the
patchset works:
- In the original kernel, userspace can write to buffers during
commit; and it moves on.
- In the patched kernel, userspace cannot write to buffers during
commit; it blocks.

However, the heavy-hammer testing with 'stress-ng --mmap 4xNCPUs --mmap-file'
then crashing the kernel via sysrq-trigger, and trying to mount the
filesystem again,
sometimes still can find invalid checksums, thus journal recovery/mount fails.

    [   98.194809] JBD2: Invalid checksum recovering data block 109704 in log
    [   98.201853] JBD2: Invalid checksum recovering data block 69959 in log
    [   98.339859] JBD2: recovery failed
    [   98.340581] EXT4-fs (vdc): error loading journal

So, despite the test exercising mmap() and the patchset being for mmap(),
apparently there is more happening that also needs changes. (Weird; but
I will try to debug that test-case behavior deeper, to find what's going on.)

This patchset does address a problem, so should we move on with this one,
and as you mentioned, "that would be something for another patch series :)" ?

Thank you,
Mauricio



> I'll have a look at the remaining patches.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



-- 
Mauricio Faria de Oliveira
