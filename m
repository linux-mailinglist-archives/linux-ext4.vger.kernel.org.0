Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9803B2A8D50
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKFDC5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDC5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:02:57 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A739C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:02:57 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t11so3722842edj.13
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0jHwgIn3R01ZaZZvKt/hhPp73QLZszrkd+u2baXwAo=;
        b=sq0h7feQJAzlrkieiVSIZaA3KRpNw4Ey0QrzDbIRb3FcT8fjQ0VQD9JLRJ+dkJm5I5
         wwXgoryyffZXjCzJ5k6WXxjtF+cv75RdgAjlTgoxyWjZ43WEvcY6c9wdF7UCscGf0Hac
         I61G7vm8xeyI0hLSTJGYWZnQUe/GLfIGLEecltQGP1vL4kaPiW6+CCCDp87yJ54MAknC
         z9nlZlohhPYQKMGZjRpCjOrLxoONGJIglWaYHnUPeH0T+HrGhz3Oy4A4tKrV5euADW0o
         wP2GjQUVtM8WsqXyHgLfRSl+RJkiBN9HS8/yPk4qyjUL8+wuenm6X8IHs7GRQLYzYi/N
         bA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0jHwgIn3R01ZaZZvKt/hhPp73QLZszrkd+u2baXwAo=;
        b=pwCg80O5TJ7/Q32UJPOVy6fJ6vpQ4gEa9ieqxw9w1cn03cgevTpx5iW86L89VcGhCP
         L/fJlwFWDuNSouUbwdgdlGJl4j3EwWIKRmA8ILynaDx3T6H3qHap6+djwzZJSW9OfNhq
         6YzvUE0mWtcRCfC/rNMItqu589dngJ7XhzK522MWKUxZFQNUUrPZyB5X2dI6/PIRrdm+
         MmpZaz/78kaPaempsOos3cz5oFDRFfdZFYBkNw26QC1Uv0z2/CxMppqwmIVoih4oAnA0
         Iwwrk2waa5h3mBFn3cJtiIqEKRkeSzL26T9Q4xfryBvFzPp2CxTYc7llj9aeCd5wPJW2
         rChw==
X-Gm-Message-State: AOAM532LD1k1KL0z3fKcdF9HPwqYOBG6IYke7ALF/Y49f/XWwvTfndlh
        sD6Ba/AInKJ1LW8q/jnuwbkcmCip61n/zhOZ/fMlQ23S0eg=
X-Google-Smtp-Source: ABdhPJztGbmw8sbcp2WZALtkF/qIf0GBoNsElaSXtFNd0QkJVWrhJEq8G8Lm7wMQvZ9oz9VGQLgdJvd6w+PuxF2WLv0=
X-Received: by 2002:aa7:ce8d:: with SMTP id y13mr6116129edv.65.1604631775814;
 Thu, 05 Nov 2020 19:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-5-harshadshirwadkar@gmail.com> <20201103162943.GH3440@quack2.suse.cz>
 <CAD+ocbykJ61MmkLqq78p=AOT0f_6j066J3ivNHjXJVbtLEvNag@mail.gmail.com>
 <20201105103024.GA32718@quack2.suse.cz> <20201105124422.GC32718@quack2.suse.cz>
 <CAE1WUT6oxiKtrdF6vzLv5vYFxPjefRhzDE2xfQGF6CqQQdPv1Q@mail.gmail.com>
In-Reply-To: <CAE1WUT6oxiKtrdF6vzLv5vYFxPjefRhzDE2xfQGF6CqQQdPv1Q@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 5 Nov 2020 19:02:44 -0800
Message-ID: <CAD+ocby223TW2_kSzB6PnDMO+0qUD2zoTANPV3gt3dSqoc0fZw@mail.gmail.com>
Subject: Re: [PATCH 04/10] ext4: clean up the JBD2 API that initializes fast commits
To:     Amy Parker <enbyamy@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Jan and Amy for the feedback. In V2, I'll drop "no_fc" mount
option which was very confusing. Also, we have a mount option called
"fc_debug_force" that forcefully turns fast commits on even if it was
not enabled by mke2fs. It's handy for running performance tests
without relying on e2fsprogs. But I understand that this option could
also be confusing. There's "debug" in its name and I will also move it
inside #ifdef CONFIG_EXT4_DEBUG so that for production, this gets
compiled out.

On Thu, Nov 5, 2020 at 5:30 AM Amy Parker <enbyamy@gmail.com> wrote:
>
> On Thu, Nov 5, 2020, 4:45 AM Jan Kara <jack@suse.cz> wrote:
>>
>> On Thu 05-11-20 11:30:24, Jan Kara wrote:
>> > On Wed 04-11-20 11:52:24, harshad shirwadkar wrote:
>> > > On Tue, Nov 3, 2020 at 8:29 AM Jan Kara <jack@suse.cz> wrote:
>> > > > > -int jbd2_fc_init(journal_t *journal, int num_fc_blks)
>> > > > > +int jbd2_fc_init(journal_t *journal)
>> > > > >  {
>> > > > > -     journal->j_fc_wbufsize = num_fc_blks;
>> > > > > -     journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
>> > > > > -                             sizeof(struct buffer_head *), GFP_KERNEL);
>> > > > > -     if (!journal->j_fc_wbuf)
>> > > > > -             return -ENOMEM;
>> > > > > +     /*
>> > > > > +      * Only set j_fc_wbufsize here to indicate that the client file
>> > > > > +      * system is interested in using fast commits. The actual number of
>> > > > > +      * fast commit blocks is found inside jbd2_superblock and is only
>> > > > > +      * valid if j_fc_wbufsize is non-zero. The real value of j_fc_wbufsize
>> > > > > +      * gets set in journal_reset().
>> > > > > +      */
>> > > > > +     journal->j_fc_wbufsize = JBD2_MIN_FC_BLOCKS;
>> > > > >       return 0;
>> > > > >  }
>> > > >
>> > > > When looking at this, is there a reason why jbd2_fc_init() still exists?  I
>> > > > mean why not just make the rule that the journal has FC block number set
>> > > > iff FC gets enabled? Anything else seems a bit confusing to me and also
>> > > > dangerous - imagine we have fs with FC running, we write some FCs and then
>> > > > crash. Then on system recovery we mount with no_fc mount option. We have
>> > > > just lost data on the filesystem AFAIU... So I'd just remove all the mount
>> > > > options related to fastcommits and leave everything to the journal setup
>> > > > (which can be modified with e2fsprogs if needed) to keep things simple.
>> > > The problem is whether or not to use fast commits is the file system's
>> > > call. The JBD2 feature flag will be cleared on a clean unmount and if
>> > > we rely solely on the JBD2 feature flag, fast commit will be turned
>> > > off after a clean unmount. Whereas the FS compat flag is the source of
>> > > truth about whether fast commit needs to be used or not. That's why we
>> > > need an API for the file system to tell JBD2 to still do fast commits.
>> >
>> > Yes, I meant the API could be just that the filesystem either calls
>> > jbd2_journal_set_features() with FASTCOMMIT feature or it won't. Similarly
>> > to how e.g. JBD2_FEATURE_INCOMPAT_64BIT is handled. No need for
>> > jbd2_fc_init() function AFAICT.
Sounds good, I'll drop it.

Thanks,
Harshad
>> >
>> > > Mount options that override the feature flag in Ext4 were mainly meant
>> > > for debugging purposes. So, perhaps there should be a clear warning
>> > > message in the kernel if any of these options are used? Even if we get
>> > > rid of the mount options, we still need the jbd2_fc_init() API for the
>> > > FS to tell JBD2 that it wants to use fast commit. Note that even if
>> > > jbd2_fc_init() is not called, JBD2 will still try to replay fast
>> > > commit blocks.
>>
>> I forgot to add here: I don't like "debug-only" mount options in production
>> kernels because users tend to try them out and:
>> a) occasionally get burnt by unexpected behavior
>
>
> Seen that happen enough times myself, there's a
> reason I always leave notes to users of systems I
> set up to never turn on debug-only mode in day to
>
>> b) the options become hard to get rid of because someone starts to depend
>> on them.
>
>
> This occurs not just with kernel things but with all
> software in general. Leaving options in long-term
> that then need to be removed gets problematic
> pretty quickly.
>
>>
>> So I'd prefer that the options are removed unless they are really essential
>> for debugging the feature
>
>
> Yeah - remove them if we can, if they aren't essential
> then no need to keep them.
>
>> and if they are essential, they should be clearly
>> marked as debug aid... (e.g. with debug in the name or so).
>
>
> At *least* that if not more.
>
>>
>>                                                                 Honza
>>
>> --
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
>
>
> Best regards,
> Amy Parker
> (they/them)
