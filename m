Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB834206E1
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Oct 2021 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhJDH7W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Oct 2021 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhJDH7V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Oct 2021 03:59:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B54C061745
        for <linux-ext4@vger.kernel.org>; Mon,  4 Oct 2021 00:57:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x7so60023576edd.6
        for <linux-ext4@vger.kernel.org>; Mon, 04 Oct 2021 00:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deitcher-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8nD2EFGPAy2d4pXz9DdwM1H/I2QNDvYMy4Vhu71KqTw=;
        b=SPZPfBsvmrz+Wf79YmvGw6Vu2vIMQVMLfvvV7+129aLVQ167ixSGx10FZgV/G+CtMe
         ZYTD+zgiS0g5npIVwD2mrA7fbokNjhMOClq1YX/VdBdR/J2hymJ6JPCtNL56Uv2J16ok
         6FMTRHuzTmKrcjtgHfqD/y9yeekTqfiXBt2ICep5K54m1QGllAJ/VK26IliKQszrqgSJ
         nNWZ17XofFZXJ6ysdlp2PqHpQMVo2iGA/d+tNOCZfVnGHW1mNOVyNcsnTe7OpNdxbfmz
         uzeTfGqpZvdNOuysLr3d/oUi+7p1r1c2nsESIGIEGbP/axHSbm33hoI39E+XmxrVvJes
         MSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8nD2EFGPAy2d4pXz9DdwM1H/I2QNDvYMy4Vhu71KqTw=;
        b=E8vgzpECQdh1lpI0/Acl6UV9LNRU1uJImFg2G5Ki7coWEECBK2WJw5SilQNomTtSj7
         7UheXE3jQDmHRJyFefc9cMIUHZArrnAx15wm5kEhejR13yv7cotRcXJ7DeluLEmbmd6i
         u566KfILnz9SNQe1KVrWq7VmZ5M62iDv3Gx/k5v/ftwaDyvSFKBlDnCdb0zSGNlHXENb
         A3XJesoV7hGgM6JCgSVb++FbsmOnUGnBD+j7ntNRksNBn7w+5E1osna9kpYpkF7ZmZ7o
         KHAzMz3TpDLLzpL6mhC9EwMuGiGMNiKlutFeFx5zYUFlKLWtOhC+uHCiQIxlWaGGSokj
         8+VQ==
X-Gm-Message-State: AOAM533iwYFaHo0BFde5g77ONG5looK4djNkv2ICUUFIm05ruFSAtu7o
        nBLPWMbWFNManMnZuDy81sBFLwnNfeMGTqKvtSNZ5BQOFfU=
X-Google-Smtp-Source: ABdhPJzboKtFQpKuNLWxzrYf1imFl/TfuxFmT51QRI6cN+ICfcOydHrwAgI9IyYEp/KjjZ7w+ic0lt1FStJdxRyXiWM=
X-Received: by 2002:a17:906:6c84:: with SMTP id s4mr16030963ejr.121.1633334250239;
 Mon, 04 Oct 2021 00:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca>
In-Reply-To: <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca>
From:   Avi Deitcher <avi@deitcher.net>
Date:   Mon, 4 Oct 2021 10:57:19 +0300
Message-ID: <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
Subject: Re: algorithm for half-md4 used in htree directories
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Andreas,

I had looked in __ext4fs_dirhash(). Yes, it does reference the seed -
and create a default if none is there at the filesystem level - but it
doesn't appear to use it, in that function. hinfo is populated in the
function - hash, minor-hash, seed - but it never uses the seed to
manipulate the hash.

Are you saying that it is at a higher level? i.e. __ext4fs_dirhash()
is the *first* step, and there is further processing to get the actual
hash? I did walk up the stack, but couldn't figure out.

Thanks for stepping in
Avi

On Sun, Oct 3, 2021 at 7:43 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Oct 3, 2021, at 06:47, Avi Deitcher <avi@deitcher.net> wrote:
> >
> > =EF=BB=BFI can narrow down the question further. In my live sample, one=
 of the
> > entries in the tree is for a directory named "dir155".
> >
> > If I run "dx_hash dir155", I get:
> >
> > # debugfs -R "dx_hash dir155" /var/lib/file.img
> > debugfs 1.46.2 (28-Feb-2021)
> > Hash of dir155 is 0x16279534 (minor 0x0)
> >
> > If I look in the tree with "htree_dump", I get:
> >
> > # debugfs -R "htree_dump /testdir" /var/lib/file.img
> > debugfs 1.46.2 (28-Feb-2021)
> > ....
> > Entry #0: Hash 0x00000000, block 1
> > Reading directory block 1, phys 6459
> > 168 0x00d11d98-b9b6b16b (16) dir155   332 0x009edafe-77de7d72 (16) dir3=
19
> >
> > That hash for dir155 does not match what dx_hash gave. If I try to
> > take the code from fs/ext4/hash.c and build a small program to
> > calculate the hash, I get:
> >
> > $ ./md4 dir155
> > MD4: d90278a1 25182ac7 a02e56be c3f30f04
> > hash: 0x25182ac6
> > minor: 0xa02e56be
> >
> > Clearly that isn't what is in the tree. What basic am I missing?
>
> One important factor is that the directory hash has an initial seed
> to prevent pathological cases where the user can construct thousands
> of directory entries that have a hash collision.
>
> Looking at the code explains this in the comment for __ext4fs_dirhash().
> The seed itself comes from sbi->s_hash_seed and is stored in the
> per-directory hinfo.seed to be used when counting the filename hash.
> In theory there could be a per-directory hash, but it appears to be a
> constant for the whole filesystem.
>
> Cheers, Andreas
>
> >
> >> On Fri, Oct 1, 2021 at 2:49 PM Avi Deitcher <avi@deitcher.net> wrote:
> >>
> >> Hi,
> >>
> >> I have been trying to understand the algorithm used for the "half-md4"
> >> in htree-structured directories. Going through the code (and trying
> >> not to get into reverse engineering), it looks like it is part of md4
> >> but not entirely? Yet any subset I take doesn't quite line up with
> >> what I see in an actual sample.
> >>
> >> What is the algorithm it is using to turn an entry of, e.g., "file125"
> >> into the appropriate hash. I did run a live sample, and try to get
> >> some form of correlation between the actual md4 hash (16 bytes) of the
> >> above to the actual entry (4 bytes) shown by debugfs, without much
> >> luck.
> >>
> >> What basic thing am I missing?
> >>
> >> Separately, how does the seed play into it?
> >>
> >> Thanks
> >> Avi
> >
> >
> >
> > --
> > Avi Deitcher
> > avi@deitcher.net
> > Follow me http://twitter.com/avideitcher
> > Read me http://blog.atomicinc.com



--=20
Avi Deitcher
avi@deitcher.net
Follow me http://twitter.com/avideitcher
Read me http://blog.atomicinc.com
