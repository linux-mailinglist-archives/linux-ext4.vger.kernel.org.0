Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3574202E6
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Oct 2021 18:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhJCQpI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Oct 2021 12:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhJCQpI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Oct 2021 12:45:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81908C0613EC
        for <linux-ext4@vger.kernel.org>; Sun,  3 Oct 2021 09:43:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 66so13908255pgc.9
        for <linux-ext4@vger.kernel.org>; Sun, 03 Oct 2021 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=c86y2TcEt5lRLKTBD3cNnD4d3pQuaIO813Ihd8ReWHg=;
        b=VGwG7hay19F8YjELWOeoWhypnZXSvKa86Tb1Kk8vHbwsy8wPx5Daax5c3kMPOJ31UT
         LiU4L7qb7VKWW4vClZeJ51n+6lp748uZKdum8VmRdY46SS+RL/5T+nI8TdiBHrMPe1MC
         rHhEuMIZ/Zst+/fZOVZ8VHJdRK4EJWUagsH+WykaJAtxQ1jYxi90sJSOL16F+xfbpAvM
         P+ZsBkpYMZwdXrxMHQO1irmmQGKCkCAjRTymEtxxCn11jl4uq/+7olG7lCTC23UhGNRz
         95zcUQrEs+XRYB8FgGqwzF7IIFFSw2X8GWNN7ntyAhtL60GSjVRgnbr6uOHLwyHdy+rL
         +bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=c86y2TcEt5lRLKTBD3cNnD4d3pQuaIO813Ihd8ReWHg=;
        b=kPF8kH3Lg1XVs7iv4V1rXZslY30rrJlEsBhPdyvQyTJdkmoX3YV2B4hkWjTbpP3hTV
         fhl3dAn4qy5sfFdEN5PDZNwhtc7TBbtrh0lscDhviK7bCUWxtZmEy+eHxUwnniQdEU7o
         W+rG/Eg6OWD1QEJJtE8jhGOyDE46ScfkR+g9s+mT8SNI66+ot5C/Q3n9lVWmTa+UbobU
         eHrjumR77ayv6Lqa2NBi/Iq+tb1C20L/CCRKPLNLogvQK+15PnKi2H9ij7PXtV53LyfY
         RZCiKgv1X/CZs/9coeC70FkU9rCQ3xvbQQ9CDe3EaEx00aiGQGEFoPSB5Yk5DVDxJFuU
         ALbQ==
X-Gm-Message-State: AOAM533+MOdjTb/kZEfXr4N4gTAPLEJ91Yp81ZP2Ki3rsasjwJC1ak4z
        XmzH0CX3jg1jEEu2+FIvs0qSI3tYxK1gpNFK
X-Google-Smtp-Source: ABdhPJwAS2+9MSprDlIete22FW1drHpqfezfI1cu+1rSB/r20QT28B9hLb1hoLgIOeqgI22qnXIpAw==
X-Received: by 2002:a63:ab06:: with SMTP id p6mr2419598pgf.112.1633279399775;
        Sun, 03 Oct 2021 09:43:19 -0700 (PDT)
Received: from smtpclient.apple (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k127sm11958010pfd.1.2021.10.03.09.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 09:43:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: algorithm for half-md4 used in htree directories
Date:   Sun, 3 Oct 2021 10:43:17 -0600
Message-Id: <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca>
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
Cc:     linux-ext4@vger.kernel.org
In-Reply-To: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
To:     Avi Deitcher <avi@deitcher.net>
X-Mailer: iPhone Mail (18H17)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Oct 3, 2021, at 06:47, Avi Deitcher <avi@deitcher.net> wrote:
>=20
> =EF=BB=BFI can narrow down the question further. In my live sample, one of=
 the
> entries in the tree is for a directory named "dir155".
>=20
> If I run "dx_hash dir155", I get:
>=20
> # debugfs -R "dx_hash dir155" /var/lib/file.img
> debugfs 1.46.2 (28-Feb-2021)
> Hash of dir155 is 0x16279534 (minor 0x0)
>=20
> If I look in the tree with "htree_dump", I get:
>=20
> # debugfs -R "htree_dump /testdir" /var/lib/file.img
> debugfs 1.46.2 (28-Feb-2021)
> ....
> Entry #0: Hash 0x00000000, block 1
> Reading directory block 1, phys 6459
> 168 0x00d11d98-b9b6b16b (16) dir155   332 0x009edafe-77de7d72 (16) dir319
>=20
> That hash for dir155 does not match what dx_hash gave. If I try to
> take the code from fs/ext4/hash.c and build a small program to
> calculate the hash, I get:
>=20
> $ ./md4 dir155
> MD4: d90278a1 25182ac7 a02e56be c3f30f04
> hash: 0x25182ac6
> minor: 0xa02e56be
>=20
> Clearly that isn't what is in the tree. What basic am I missing?

One important factor is that the directory hash has an initial seed
to prevent pathological cases where the user can construct thousands
of directory entries that have a hash collision.

Looking at the code explains this in the comment for __ext4fs_dirhash().
The seed itself comes from sbi->s_hash_seed and is stored in the
per-directory hinfo.seed to be used when counting the filename hash.
In theory there could be a per-directory hash, but it appears to be a
constant for the whole filesystem. =20

Cheers, Andreas

>=20
>> On Fri, Oct 1, 2021 at 2:49 PM Avi Deitcher <avi@deitcher.net> wrote:
>>=20
>> Hi,
>>=20
>> I have been trying to understand the algorithm used for the "half-md4"
>> in htree-structured directories. Going through the code (and trying
>> not to get into reverse engineering), it looks like it is part of md4
>> but not entirely? Yet any subset I take doesn't quite line up with
>> what I see in an actual sample.
>>=20
>> What is the algorithm it is using to turn an entry of, e.g., "file125"
>> into the appropriate hash. I did run a live sample, and try to get
>> some form of correlation between the actual md4 hash (16 bytes) of the
>> above to the actual entry (4 bytes) shown by debugfs, without much
>> luck.
>>=20
>> What basic thing am I missing?
>>=20
>> Separately, how does the seed play into it?
>>=20
>> Thanks
>> Avi
>=20
>=20
>=20
> --=20
> Avi Deitcher
> avi@deitcher.net
> Follow me http://twitter.com/avideitcher
> Read me http://blog.atomicinc.com
