Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822322EB5D8
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 00:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbhAEXHJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 18:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbhAEXHH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 18:07:07 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02D8C061574
        for <linux-ext4@vger.kernel.org>; Tue,  5 Jan 2021 15:06:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b9so2799384ejy.0
        for <linux-ext4@vger.kernel.org>; Tue, 05 Jan 2021 15:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+U8aMnwFCkbmZqPrpu/zfMxBJ1EtdY/NdbRNwEA+R8=;
        b=aTPSU4DTgzypSwk8syyKfS3rFzuI3pyIAdT4wnpcp3EoavT6Yy49nC4SjRD2YbBsSn
         sGKCf6WdhJtzKRoi4osI3/x1rG54Do4VUAy2ktc1V1beYbNj63amXY0KiLuu85K5m0g4
         4sLHNJQd24dKUeUnzum8Z0q4z9HJJu8XFFfYvP+PddL5auILJlGs5iz5UZ0nl1aE759a
         AYr/DNE1bPLFjB6qJoi7H+e/hLNnVEW2wg69vqXdc9mYsxexjB5lyhf8HimtyBmD3IZ2
         dkxiqCMKFC3KgkquRUU/P1L9XdX+hvRshP87uNVFcs1fLm75RJ3+3vpvK3dbK2ZLYtMd
         nWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+U8aMnwFCkbmZqPrpu/zfMxBJ1EtdY/NdbRNwEA+R8=;
        b=OvAKpN6fkQ925HcD6FuCrM0kumFqe2082EpbVp6KOkEZoV6f1qT9mHe/Ddu6iDIium
         s2TkLLc4btP4QT/eQqkF3dOC6vv6PL/DaIn3YiyMK+mJb/6Cn/OWYsUa2LPDPQDJr6F6
         8qR8+rZ2IsnWZNn/YIGhQlC+tRa6IWngV7pwkBl88AB8PqiH5E7mJWQoP13I/5kFtbZv
         G6qZ/uWjuphvwtpscJK/ZezK3ScV1qE79O7r6WB8PaTwwaLd8fM/cO9hmcWddCv1AYYS
         4ZR6aZcltxEmP2ZJvyoXtsmM03KOTYHa3MfHoL8soaOgMY0XhXdXBVBVlYENJMsCmDrR
         NnvQ==
X-Gm-Message-State: AOAM532/NRlrhY5K6bUV4TGzLu6GAtGoEsLzHImKLhZgwj+nvGhX1ghB
        1jETNnPcvMtRSkmufW7wgQPGEawABa+VOl5tmguBdmHdqo8=
X-Google-Smtp-Source: ABdhPJyFOqR+GAGsz5QBIlRPr06OVhTHXvlCP9Sc3XgieFUP4MW2nN6LS2PWxaWOMjcn/v2/QiZTCWRbqum1rfNhrNA=
X-Received: by 2002:a17:906:a115:: with SMTP id t21mr1063018ejy.549.1609887985420;
 Tue, 05 Jan 2021 15:06:25 -0800 (PST)
MIME-Version: 1.0
References: <1bb3c556-4635-061b-c2dc-df10c15e6398@huawei.com>
 <CAD+ocbxAyyFqoD6AYQVjQyqFzZde3+QOnUhC-VikAq4A3_t8JA@mail.gmail.com>
 <3e3c18f6-9f45-da04-9e81-ebf1ae16747e@huawei.com> <CAD+ocbz=mp8k2Ruqiagq7ZDfhGui29X8Wz-_7698zaghzH4BXA@mail.gmail.com>
 <20201214202701.GI575698@mit.edu> <1384512f-9c8b-d8d7-cb38-824a76b742fc@huawei.com>
 <52e7ad7b-0411-8b6d-35f9-696f9dd75c31@huawei.com>
In-Reply-To: <52e7ad7b-0411-8b6d-35f9-696f9dd75c31@huawei.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 5 Jan 2021 15:06:13 -0800
Message-ID: <CAD+ocbz4Z54GHKoLH8hWEEH9CoVGLu8KHtYUe+-8yFszz7fn5A@mail.gmail.com>
Subject: Re: [PATCH] e2fsck: Avoid changes on recovery flags when
 jbd2_journal_recover() failed
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Haotian Li <lihaotian9@huawei.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>, liangyun2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry for the delay. Thanks for providing more information, Haotian.
So this is happening due to IO errors experienced due to a flaky
network connection. I can imagine that this is perhaps a situation
which is recoverable but I guess when running on physical hardware,
it's less likely for such IO errors to be recoverable. I wonder if
this means we need an e2fsck.conf option - something like
"recovery_error_behavior" with default value of "continue". For
usecases such as this, we can set it to "exit" or perhaps "retry"?

On Thu, Dec 24, 2020 at 5:49 PM Zhiqiang Liu <liuzhiqiang26@huawei.com> wro=
te:
>
> friendly ping...
>
> On 2020/12/15 15:43, Haotian Li wrote:
> > Thanks for your review. I agree with you that it's more important
> > to understand the errors found by e2fsck. we'll decribe the case
> > below about this problem.
> >
> > The probelm we find actually in a remote storage case. It means
> > e2fsck's read or write may fail because of the network packet loss.
> > At first time, some packet loss errors happen during e2fsck's journal
> > recovery (using fsck -a), then recover failed. At second time, we
> > fix the network problem and run e2fsck again, but it still has errors
> > when we try to mount. Then we set jsb->s_start journal flags and retry
> > e2fsck, the problem is fixed. So we suspect something wrong on e2fsck's
> > journal recovery, probably the bug we've described on the patch.
> >
> > Certainly, directly exit is not a good way to fix this problem.
> > just like what Harshad said, we need tell user what happen and listen
> > user's decision, continue e2fsck or not. If we want to safely use
> > e2fsck without human intervention (using fsck -a), I wonder if we need
> > provide a safe mechanism to complate the fast check but avoid changes
> > on journal or something else which may be fixed in feature (such
> > as jsb->s_start flag)?
> >
> > Thanks
> > Haotian
> >
> > =E5=9C=A8 2020/12/15 4:27, Theodore Y. Ts'o =E5=86=99=E9=81=93:
> >> On Mon, Dec 14, 2020 at 10:44:29AM -0800, harshad shirwadkar wrote:
> >>> Hi Haotian,
> >>>
> >>> Yeah perhaps these are the only recoverable errors. I also think that
> >>> we can't surely say that these errors are recoverable always. That's
> >>> because in some setups, these errors may still be unrecoverable (for
> >>> example, if the machine is running under low memory). I still feel
> >>> that we should ask the user about whether they want to continue or
> >>> not. The reason is that firstly if we don't allow running e2fsck in
> >>> these cases, I wonder what would the user do with their file system -
> >>> they can't mount / can't run fsck, right? Secondly, not doing that
> >>> would be a regression. I wonder if some setups would have chosen to
> >>> ignore journal recovery if there are errors during journal recovery
> >>> and with this fix they may start seeing that their file systems aren'=
t
> >>> getting repaired.
> >>
> >> It may very well be that there are corrupted file system structures
> >> that could lead to ENOMEM.  If so, I'd consider that someone we should
> >> be explicitly checking for in e2fsck, and it's actually relatively
> >> unlikely in the jbd2 recovery code, since that's fairly straight
> >> forward --- except I'd be concerned about potential cases in your Fast
> >> Commit code, since there's quite a bit more complexity when parsing
> >> the fast commit journal.
> >>
> >> This isn't a new concern; we've already talked a about the fact the
> >> fast commit needs to have a lot more sanity checks to look for
> >> maliciously --- or syzbot generated, which may be the same thing :-)
> >> --- inconsistent fields causing the e2fsck reply code to behave in
> >> unexpected way, which might include trying to allocate insane amounts
> >> of memory, array buffer overruns, etc.
> >>
> >> But assuming that ENOMEM is always due to operational concerns, as
> >> opposed to file system corruption, may not always be a safe
> >> assumption.
> >>
> >> Something else to consider is from the perspective of a naive system
> >> administrator, if there is an bad media sector in the journal, simply
> >> always aborting the e2fsck run may not allow them an easy way to
> >> recover.  Simply ignoring the journal and allowing the next write to
> >> occur, at which point the HDD or SSD will redirect the write to a bad
> >> sector spare spool, will allow for an automatic recovery.  Simply
> >> always causing e2fsck to fail, would actually result in a worse
> >> outcome in this particular case.
> >>
> >> (This is especially true for a mobile device, where the owner is not
> >> likely to have access to the serial console to manually run e2fsck,
> >> and where if they can't automatically recover, they will have to take
> >> their phone to the local cell phone carrier store for repairs ---
> >> which is *not* something that a cellular provider will enjoy, and they
> >> will tend to choose other cell phone models to feature as
> >> supported/featured devices.  So an increased number of failures which
> >> cann't be automatically recovered cause the carrier to choose to
> >> feature, say, a Xiaomi phone over a ZTE phone.)
> >>
> >>> I'm wondering if you saw any a situation in your setup where exiting
> >>> e2fsck helped? If possible, could you share what kind of errors were
> >>> seen in journal recovery and what was the expected behavior? Maybe
> >>> that would help us decide on the right behavior.
> >>
> >> Seconded; I think we should try to understand why it is that e2fsck is
> >> failing with these sorts of errors.  It may be that there are better
> >> ways of solving the high-level problem.
> >>
> >> For example, the new libext2fs bitmap backends were something that I
> >> added because when running a large number of e2fsck processes in
> >> parallel on a server machine with dozens of HDD spindles was causing
> >> e2fsck processes to run slowly due to memory contention.  We fixed it
> >> by making e2fsck more memory efficient, by improving the bitmap
> >> implementations --- but if that hadn't been sufficient, I had also
> >> considered adding support to make /sbin/fsck "smarter" by limiting the
> >> number of fsck.XXX processes that would get started simultaneously,
> >> since that could actually cause the file system check to run faster by
> >> reducing memory thrashing.  (The trick would have been how to make
> >> fsck smart enough to automatically tune the number of parallel fsck
> >> processes to allow, since asking the system administrator to manually
> >> tune the max number of processes would be annoying to the sysadmin,
> >> and would mean that the feature would never get used outside of $WORK
> >> in practice.)
> >>
> >> So is the actual underlying problem that e2fsck is running out of
> >> memory?  If so, is it because there simply isn't enough physical
> >> memory available?  Is it being run in a cgroup container which is too
> >> small?  Or is it because too many file systems are being checked in
> >> parallel at the same time?
> >>
> >> Or is it I/O errors that you are concerned with?  And how do you know
> >> that they are not permanent errors; is thie caused by something like
> >> fibre channel connections being flaky?
> >>
> >> Or is this a hypotethical worry, as opposed to something which is
> >> causing operational problems right now?
> >>
> >> Cheers,
> >>
> >>                                      - Ted
> >>
> >> .
> >>
> >
> > .
> >
>
