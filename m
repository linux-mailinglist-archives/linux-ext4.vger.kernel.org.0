Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7703942B293
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Oct 2021 04:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhJMCWq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 22:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhJMCWp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Oct 2021 22:22:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E859FC061570
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 19:20:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t16so3583466eds.9
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 19:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deitcher-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVb8uzOEJl/dvmfXFPAbbPAo09twHNWLDn/FZoojfhA=;
        b=ZZH1YgQmunHzo/dcoDe9nC3CJTL9JlG7Zy0qWLiTSMVFkIFsyFOfMwf7DD6ZF1pGgF
         hOAxkvaVSS1chixUvlQNbi08mH44+OIF6LLUm7pZ//+3g3lrnWEa0EUOZeCglnc9sKud
         OP0Pp9ugGf9hsJ2b8gxUdaDbPDxBAKme0UAOEdcE4alsBTmAQIvNWr3wkOMzkbYEG91d
         6cuGcpu3pgK5Gx4HWvZYZeWiQREpz0OyUDDJ8lNrfG5/nSWFmNg3qU1d7obn4SUvxF8N
         VArrObDYi8ruR3jBCBTyvedSp0wcMbkm2WROMxqYEz5SgFlT23/ZmnlLiUy2hQDjzIgu
         jutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVb8uzOEJl/dvmfXFPAbbPAo09twHNWLDn/FZoojfhA=;
        b=DGS4UhpwK62a/f6lzsRXyxzqAKC97Zo64b6tuffDJVIVga2Nd82zW1fzQLeeUpncsz
         nQVNlVVk8/K7iFngukV5CWvOb6rydgO+oUFNKQEGvzXo9BVQrAxg3NVEhwkwVENKos9P
         b2OXThhO8EZs/679K3qC80WXTd98LbwncN4DpOAoDtiLz6E30DcQGKFCQLVnhRE7TGiD
         hko1KtswEFV5d8P14iVhFM/ep42nUNtbHgumJbetnkTd39Ryo7SOjYALlwlfAd54pkBX
         NrTyw7pf1oFIxzSH4JIDVAQaTVRMNcmQKzPGPeKrpKc3WxvB295O2DvdI0qmEIWU6eey
         u8Pw==
X-Gm-Message-State: AOAM531mVX++NCOKgU0/66o1xanan5SSJRLLoNqEyfE98hLPLHEloC1Q
        jA8F27FA49jVLEd09qpWKlonDKQ7wfX4cz2UQYYYe+5rdDJ7wg==
X-Google-Smtp-Source: ABdhPJwjd4A7gt06fL6QEJ9qjqmMNk8+mZwRcxemMNDn6jztOxjgcJJX5HhxqlnBSF+kTf8AwDyO9g0kPRQLSN4KS3c=
X-Received: by 2002:a17:906:684e:: with SMTP id a14mr32432040ejs.142.1634091638338;
 Tue, 12 Oct 2021 19:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca> <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
 <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com>
 <YWSck57bsX/LqAKr@mit.edu> <CAF1vpkiKx3jArgjNBrid9-MSHBweGsFL0zu0UgDX_dq_hrkUgw@mail.gmail.com>
 <YWXGRgfxJZMe9iut@mit.edu>
In-Reply-To: <YWXGRgfxJZMe9iut@mit.edu>
From:   Avi Deitcher <avi@deitcher.net>
Date:   Tue, 12 Oct 2021 19:20:26 -0700
Message-ID: <CAF1vpkidOGm0OmRac+OqaXcnJptn1O22OLHXJZoPfEbhxb3Ttw@mail.gmail.com>
Subject: Re: algorithm for half-md4 used in htree directories
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Yep, right here
https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/lib/ext2fs/dirhash.c

Hey, that's your name on it, Ted!

I am close, must be messing it up somehow. I literally copied the
majority of that (actually, some slight variant, but basically the
same) into a standalone main.c, removed any library dependencies by
copying those in so I can get a standalone, and I still am not quite
getting it. Maybe I am messing up the seed?

dump2fs of the superblock shows:

Default directory hash:   half_md4
Directory Hash Seed:      d64563bc-ea93-4aaf-a943-4657711ed153

and debugfs of the hash tree shows:

Root node dump:
         Reserved zero: 0
         Hash Version: 1
         Info length: 8
         Indirect levels: 1
         Flags: 0
Number of entries (count): 2
Number of entries (limit): 123
Checksum: 0x49f0afdc
Entry #0: Hash 0x00000000, block 124
Entry #1: Hash 0x78b6e3b8, block 128

Entry #0: Hash 0x00000000, block 124
Number of entries (count): 113
Number of entries (limit): 126
Checksum: 0x78407270
Entry #0: Hash 0x00000000, block 1
Entry #1: Hash 0x00f48688, block 193
...

So it has the hash version correct (I also gdb-ed through my little
program. Maybe I am getting the u32 order wrong in the seed? Or the
endianness?

I should just create a gist with this, shouldn't I?

On Tue, Oct 12, 2021 at 10:30 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Oct 11, 2021 at 07:58:00PM -0700, Avi Deitcher wrote:
> > Aha. I missed that the seed is injected into buf before passing it
> > into half_md4_transform. I was looking at it as just the empty buffer
> > before the first iteration of the loop (or, in my case, since I was
> > testing with a 6 char filename, the only iteration).
> >
> > I will repeat my experiment with that and see if I can tease it out.
>
> BTW, if you are looking for a userspace implementation of the hash,
> it's available in libext2fs in e2fsprogs.
>
> Cheers,
>
>                                         - Ted



-- 
Avi Deitcher
avi@deitcher.net
Follow me http://twitter.com/avideitcher
Read me http://blog.atomicinc.com
