Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2727FF6E
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 14:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbgJAMqt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 08:46:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44972 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732183AbgJAMqt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 08:46:49 -0400
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kNxyw-0003Go-CE
        for linux-ext4@vger.kernel.org; Thu, 01 Oct 2020 12:46:46 +0000
Received: by mail-lj1-f198.google.com with SMTP id b17so1153739lji.10
        for <linux-ext4@vger.kernel.org>; Thu, 01 Oct 2020 05:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDbTYA6cuCDsandL3yHXKiYCxfqfIQD2FZxhex33qcU=;
        b=njNsjBUo1qO1QUD1GS9K96zI8Q1fA5yQP8PJe1WMJGujKx9ihR8QJfRs4C/x05Sa9B
         Db9O5HRVozj3vJ0BgUFjHMwnE/W+9+C86gzxrLIJcYxAzNfY4k8QdLird/CvcslR+urg
         t8sCReviPkC41C7VGKKWOprrnVJX/8+/R/BANdin1ARQ2TIVVUjG6Ki4Iqjws6uNC5qD
         mmtB7bbKwR4IvPaxizzUge/Ohjs/f5Kg59/AuFxCkvllxGm2Md5w3UI3KV8FRoYvrjf5
         imgCH6GhBlBYsRM29uRb2h59KcsDB3Ru4kLH7O0Y0xjyp7+eVM/ehTZcFgNu+VEBlqfM
         5eLQ==
X-Gm-Message-State: AOAM531fiM/lL6b1wkwGX5gVmxqmoqvKbnnz5ogi34mbKwL2bWwjPLYv
        FHo0fTE6BoFZSb/13vb/qztGsdQVFHj2fOND7z4lhGlhiQm9HQkZGocz2jGuxaaTiLtmxQ9oCx4
        /rxAxwIpJZvcnI+JqBCFKRwpziWKxGbeKkjNcYCMygJGZZk8qDP7XAv8=
X-Received: by 2002:a05:6512:534:: with SMTP id o20mr2401927lfc.397.1601556405127;
        Thu, 01 Oct 2020 05:46:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFn64ephKLAhPCqAk+JaJJefXwTL16YLZBW9N7lcmGxHhLUKmYP3MTYeq7fXN7E488uI3uFHPuErPMH3xlPRo=
X-Received: by 2002:a05:6512:534:: with SMTP id o20mr2401915lfc.397.1601556404788;
 Thu, 01 Oct 2020 05:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200928194103.244692-1-mfo@canonical.com> <20200929113727.GK10896@quack2.suse.cz>
 <CAO9xwp3fy1p7+J2ag8PbtTGb5R5-tNuko77j-w4yG=zp+QdkZQ@mail.gmail.com> <20201001073433.GB17860@quack2.suse.cz>
In-Reply-To: <20201001073433.GB17860@quack2.suse.cz>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Thu, 1 Oct 2020 09:46:32 -0300
Message-ID: <CAO9xwp3LqWy7tEEevfeuFTgi230q9jBhiVpAra=XAiP+wtCVGg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/4] ext4/jbd2: data=journal: write-protect pages
 on transaction commit
To:     Jan Kara <jack@suse.cz>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 1, 2020 at 4:34 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 30-09-20 19:59:44, Mauricio Faria de Oliveira wrote:
> > On Tue, Sep 29, 2020 at 8:37 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 28-09-20 16:40:59, Mauricio Faria de Oliveira wrote:
> > > > Hey Jan,
> > > >
> > > > This series implements your suggestions for the RFC PATCH v3 set [1].
> > > >
> > > > That addressed the issue you confirmed with block_page_mkwrite() [2].
> > > > There's no "JBD2: Spotted dirty metadata buffer" message in over 72h
> > > > runs across 3 VMs (it used to happen within a few hours.) *Thanks!*
> > > >
> > > > I added Reviewed-by: tags for the patches/changes you mentioned.
> > > > The only changes from v3 are patch 3 which is new, and contains
> > > > the 2 fixes to ext4_page_mkwrite(); and patch 4 changed 'struct
> > > > writeback_control.nr_to_write' from ~0ULL to LONG_MAX, since it
> > > > is signed long (~0ULL overflows to -1; kudos, kernel test robot!)
> > > >
> > > > It looks almost good on fstests: zero regressions on data=ordered,
> > > > and two apparently flaky tests data=journal (generic/347 _passed_
> > > > 1/6 times with the patch, and generic/547 failed 1/6 times.)
> > >
> > > Cool. Neither of these tests has anything to do with mmap. The first test
> > > checks what happens when thin provisioned storage runs out of space (and
> > > that fs remains consistent), the second tests that fsync flushed properly
> > > all data and that it can be seen after a crash. So I'm reasonably confident
> > > that it isn't caused by your patches. It still might be a bug in
> > > data=journal implementation though but that would be something for another
> > > patch series :).
> > >
> >
> > Hey Jan,
> >
> > That's good to hear! Now that the patchset seems to be in good shape,
> > I worked on testing it these last 2 days. Good and mixed-feelings news. :-)
> >
> > 1) For ext4 first, I have put 2 VMs to run fstests in a loop overnight,
> > (original and patched kernels, ~20 runs each). It looks like the patched VM
> > has more variance of failed/flaky tests, but the "average failure set" holds.
> >
> > I think some of the failures were flaky or timing related, because when I ran
> > some tests, e.g. generic/371 a hundred times (./check -i 100 generic/371)
> > then it only failed 6 out of 100 times. So I didn't look much more into it, but
> > should you feel like recommending a more careful look, I'll be happy to do it.
> >
> > For documentation purposes, the results on v5.9-rc7 and next-20200930,
> > showing no "permanent" regressions. Good news :)
> >
> >     data=ordered:
> >     Failures: ext4/045 generic/044 generic/045 generic/046 generic/051
> > generic/223 generic/388 generic/465 generic/475 generic/553
> > generic/554 generic/555 generic/565 generic/611
> >
> >     data=journal:
> >     Failures: ext4/045 generic/051 generic/223 generic/347 generic/388
> > generic/441 generic/475 generic/553 generic/554 generic/555
> > generic/565 generic/611
> >
> > 2) For OCFS2, I just had to change where we set the callbacks in (patch 2.)
> > (I'll include that in the next, hopefully non-RFC patchset, with
> > Andreas suggestions.)
> >
> > Then a local mount also has no regressions on "stress-ng --class filesystem,io".
> > Good news too :)  For reference, the steps:
> >
> >     # mkfs.ocfs2 --mount local $DEV
> >     # mount $DEV $MNT
> >     # cd $MNT
> >     # stress-ng --sequential 0 --class filesystem,io
>
> OK, these look sane. Nothing that would particularly worry me wrt this
> patch set although some of those errors (e.g. the flaky generic/371 test
> or generic/441 failure) would warrant closer look.
>

Sure, I'll check the flaky ones and follow up w/ a more detailed report.

Just to clarify on generic/441, it's not a regression or flaky; it fails
consistently on original/patched kernels (above lists apply to both.)

But absolutely generic/371 failing randomly on pwrite() _is_ interesting.

> > 3) Now, the mixed-feelings news.
> >
> > The synthetic test-case/patches I had written clearly show that the
> > patchset works:
> > - In the original kernel, userspace can write to buffers during
> > commit; and it moves on.
> > - In the patched kernel, userspace cannot write to buffers during
> > commit; it blocks.
> >
> > However, the heavy-hammer testing with 'stress-ng --mmap 4xNCPUs --mmap-file'
> > then crashing the kernel via sysrq-trigger, and trying to mount the
> > filesystem again,
> > sometimes still can find invalid checksums, thus journal recovery/mount fails.
> >
> >     [   98.194809] JBD2: Invalid checksum recovering data block 109704 in log
> >     [   98.201853] JBD2: Invalid checksum recovering data block 69959 in log
> >     [   98.339859] JBD2: recovery failed
> >     [   98.340581] EXT4-fs (vdc): error loading journal
> >
> > So, despite the test exercising mmap() and the patchset being for mmap(),
> > apparently there is more happening that also needs changes. (Weird; but
> > I will try to debug that test-case behavior deeper, to find what's going on.)
> >
> > This patchset does address a problem, so should we move on with this one,
> > and as you mentioned, "that would be something for another patch series :)" ?
>
> Thanks for the really throughout testing! If you can debug where the
> problem is still lurking fast, then cool, we can still fix it in this patch
> series. If not, then I'm fine with just pushing what we have because
> conceptually that seems like a sane thing to do anyway and we can fix the
> remaining problem afterwards.

Understood. I'll be able to look at this next week, which should be rc8 [1].
Would it be good enough, timing wise, to send a non-RFC series with
what we have (this other issue fixed or not) by the end of next week?

Thanks!
Mauricio

[1] https://lore.kernel.org/linux-ext4/CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com/


>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--
Mauricio Faria de Oliveira
