Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F03F3B337A
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 04:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfIPCqF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 22:46:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37470 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfIPCqF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 22:46:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id r195so8361687wme.2;
        Sun, 15 Sep 2019 19:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5kEb1GKozkl890IucyU1VkOsWdEtrAKmCR508cfsxsw=;
        b=ULZDoqFySylO2ZDx0iyZRGRs4Yb3vQ5Pt2pCgXCY/wa105PIHAyCqlB3bdaq02iGEG
         VMJbTy74PclPhzRTCoVYyfx7b66pkJrVvM9Ds4CHq5nvoQKnhfky7dnML8mhVnh8nBX3
         w6Ce7QLMtiPiZxJRy9Xrb1liC7j/+FFAEuTEg9ErCYk4aiRGIhKqagkICDKIna/fJx3c
         VpmpQMWw8JglzT/wf+2rWWVfPwPCAn1e5FHTC/UcRVfnDLeeJ3JwH9+wFr4+DmHEogBP
         GZClQ9ahnVJYWGvpqSqXckUfbJANnenGN3YLIKVaqiu7vkR0Iu7TmWghWgLIj/cBwKBV
         m0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5kEb1GKozkl890IucyU1VkOsWdEtrAKmCR508cfsxsw=;
        b=jziqUpkH6n3IlOSacalQ978TATu3PT2dAu1MYUXxXtj0ifjSPYXYrXnG3xysjQC6Xi
         5GBR67uUnsPz11murGrVDZOUued3ixeUmCobunJMdG2kq/h+gidnd0fqy5OUoR1wm0Y3
         gD7ynyrTsSe96d15ltIoTOSrmwl32ltX4Jf3Jo7AHomvNxtrCcDD8uhWUd02h5R/QTV8
         s/g6X7PzqeGSKSN1GbAnJLMIzERFbtoCpwgkC4htzBu0FX7qNox/Xkr3Yi5nTcSNygrc
         IjwRxyDbnzz++kxu01sip7m6bzDPiq4+rwNK6r4040rxZjp+yEiFLD91ZsF9vYCkRe5H
         HshA==
X-Gm-Message-State: APjAAAUtekYDA2cTzbEU5eSZCkklKUCFk7cZCjkNwocwkbQEZiFFZXX5
        0UwQqV5S0W2j3DLk/9DA/xA=
X-Google-Smtp-Source: APXvYqzHtSOhP9IH3DJpJMOyHZKUQ9L3b9L7THxDGiMzkgaLBLz168weZqJVNs0miGtnPRCztv0zoA==
X-Received: by 2002:a1c:110:: with SMTP id 16mr12635821wmb.88.1568601962890;
        Sun, 15 Sep 2019 19:46:02 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D144910CD9D07D5336EC2.dip0.t-ipconnect.de. [2003:d0:6f2d:1449:10cd:9d07:d533:6ec2])
        by smtp.gmail.com with ESMTPSA id t13sm71116373wra.70.2019.09.15.19.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 19:46:02 -0700 (PDT)
Date:   Mon, 16 Sep 2019 04:45:50 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH RFC v2] random: optionally block in getrandom(2) when the
 CRNG is uninitialized
Message-ID: <20190916024550.GA1352@darwi-home-pc>
References: <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190915183240.GA23155@1wt.eu>
 <CAHk-=wi0tSUuxqaCDMtwqdVbwvTXw2ZH2k1URHz069RTznEfVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi0tSUuxqaCDMtwqdVbwvTXw2ZH2k1URHz069RTznEfVw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 11:59:41AM -0700, Linus Torvalds wrote:
> On Sun, Sep 15, 2019 at 11:32 AM Willy Tarreau <w@1wt.eu> wrote:
> >
> > I think that the exponential decay will either not be used or
> > be totally used, so in practice you'll always end up with 0 or
> > 30s depending on the entropy situation
> 
> According to the systemd random-seed source snippet that Ahmed posted,
> it actually just tries once (well, first once non-blocking, then once
> blocking) and then falls back to reading urandom if it fails.
> 
> So assuming there's just one of those "read much too early" cases, I
> think it actually matters.
>

Just a quick note, the snippest I posted:

    https://lkml.kernel.org/r/20190914150206.GA2270@darwi-home-pc

is not PID 1.

It's just a lowly process called "systemd-random-seed". Its main
reason of existence is to load/restore a random seed file from and to
disk across reboots (just like what sysv scripts did).

The reason I posted it was to show that if we change getrandom() to
silently return weak crypto instead of blocking or an error code,
systemd-random-seed will break: it will save the resulting data to
disk, then even _credit_ it (if asked to) in the next boot cycle
through RNDADDENTROPY.

> But while I tried to test this, on my F30 install, systemd seems to
> always just use urandom().
> 
> I can trigger the urandom read warning easily enough (turn of CPU
> rdrand trusting and increase the entropy requirement by a factor of
> ten, and turn of the ioctl to add entropy from user space), just not
> the getrandom() blocking case at all.
>

Yeah, because the problem was/is not with systemd :)

It is GDM/gnome-session which was blocking the graphical boot process.

Regarding reproducing the issue, through a quick trace_prink, all of
below processes are calling getrandom() on my Arch system at boot:

    https://lkml.kernel.org/r/20190912034421.GA2085@darwi-home-pc

The fatal call was gnome-session's one, because gnome didn't continue
_its own_ boot due to this blockage.

> So presumably that's because I have a systemd that doesn't use
> getrandom() at all, or perhaps uses the 'rdrand' instruction directly.
> Or maybe because Arch has some other oddity that just triggers the
> problem.
>

It seems Arch is good at triggering this. For example, here is a
another Arch user on a Thinkpad (different model than mine), also with
GDM getting blocked on entropy:

    https://bbs.archlinux.org/viewtopic.php?id=248035
    
    "As you can see, the system is literally waiting a half minute for
    something - up until crng init is done"

(The NetworkManager logs are just noise. I also had them, but completely
 disabling NetworkManager didn't do anything .. just made the logs
 cleaner)

thanks,

--
Ahmed Darwish
http://darwish.chasingpointers.com
