Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C147812B
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Dec 2021 01:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhLQARc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Dec 2021 19:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhLQARc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Dec 2021 19:17:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE463C061574
        for <linux-ext4@vger.kernel.org>; Thu, 16 Dec 2021 16:17:31 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so490332pjp.0
        for <linux-ext4@vger.kernel.org>; Thu, 16 Dec 2021 16:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Ib4eiWDJ6+c4sjpMK1wlIgOcjZJJ4Mrctb7LGuZassU=;
        b=CpTP0HxEomTgkgY3FijgdWHPgf2ookNFW/VBH0JPERNdelQfCY8z0Fn0K9Ihxmy4Xk
         uc+gmZ6CNMSPSMixXNPjHUpccA32jGvrw27fwuSjAXJv3w1vZCYeMqKm1yDBLVLO+/2L
         56VVdc6Rg7RLyYlWqmJc+CVULq7EDRaiDLdE5arKBR/T6FXva3FbgAROnyZVJoH+y/j8
         UXzQzkgiUpK0rRG7QDwqigJXHe6w+EzM0DI+suAmeB1Kr0LBQ1C8rr3kCUl8D7BSlZ8g
         +ld7oCalBupww0pAAQJEbHvItJyGaEkoHJWGiOCX/jKdkJyH6lZW/dwmAIW3cyyN7SX4
         3fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Ib4eiWDJ6+c4sjpMK1wlIgOcjZJJ4Mrctb7LGuZassU=;
        b=oBaggphk9GTKjkrghLCin+fA1tdtaMaREfXgQTTToyimWu5sbStt5tSFsWcC2Oxjb5
         19CfsvUC5UdCGiQJbi8TfosQGdnWW1+ksMt57joqkcwGWfVuUMY/hEmrodIVcSIW5GEM
         CFHMPoF6noRd0fJLc/GJPhsNDGYWxB4DkbwoXOMbfT+KavFww2FYVXpGwoLpJniPaiVG
         LjnJxl3/N3BB8JVSmIw0m/Xgo0aTdyZ1h1Pn2AMI8f4gosZfGEKzGpDTgk5NDthSa3Pe
         ICov3cfrMcWOxQZc64lzrNSaA9lycCfMacEjYv29L4lda+ntkxyYJpbHBvGyhEsv9u+h
         rLWg==
X-Gm-Message-State: AOAM533P/bBUb633IsDTd+ygO8lS+0cPA5yim2lPzhS3u6oBSR3tc7Iv
        D21BJKyv2MNeJG9en/6HO8ZnCA==
X-Google-Smtp-Source: ABdhPJxvJL6mPIYQpA+/Tb41rzxEYHJM9t7GznDaHhRR8NsWrVzx/3wCDu5mfuFg5dd2BngMPfYNLA==
X-Received: by 2002:a17:902:6b05:b0:142:83f9:6e29 with SMTP id o5-20020a1709026b0500b0014283f96e29mr526749plk.32.1639700251181;
        Thu, 16 Dec 2021 16:17:31 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j127sm7453600pfg.14.2021.12.16.16.17.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 16:17:30 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A5DD4B7A-A3AE-4A00-943A-A35D98204764@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_373B4ECC-B75A-4064-9573-2ADA909BD5DF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID
 rather than check EXT4_INODE_PROJINHERIT flag
Date:   Thu, 16 Dec 2021 17:17:28 -0700
In-Reply-To: <20211214050636.GE279368@dread.disaster.area>
Cc:     Roman Anufriev <dotdot@yandex-team.ru>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        wshilong@ddn.com, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
References: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru>
 <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx>
 <Ya+3L3gBFCeWZki7@mit.edu>
 <alpine.OSX.2.23.453.2112102232440.94559@dotdot-osx>
 <20211214050636.GE279368@dread.disaster.area>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_373B4ECC-B75A-4064-9573-2ADA909BD5DF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 13, 2021, at 10:06 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Fri, Dec 10, 2021 at 10:55:10PM +0300, Roman Anufriev wrote:
>>=20
>> On Tue, 7 Dec 2021, Theodore Y. Ts'o wrote:
>>=20
>>> On Tue, Dec 07, 2021 at 05:05:19PM +0300, Roman Anufriev wrote:
>>>>> Commit 7ddf79a10395 ("ext4: only set project inherit bit for =
directory")
>>>>> removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
>>>>> ext4_statfs() output incorrect (function does not apply quota =
limits
>>>>> on used/available space, etc) when called on dentry of regular =
file
>>>>> with project quota enabled.
>>>=20
>>> Under what circumstance is userspace trying to call statfs on a file
>>> descriptor?
>>>=20
>>> Removing the test for EXT4_INODE_PROJINHERIT will cause
>>> incorrect/misleading results being returned in the case where we =
have
>>> a directory where a directory hierarchy is using project id's, but
>>> which is *not* using PROJINHERIT.
>>=20
>> I'm not sure I quite understood what will be wrong in that case, =
because
>> as Dave mentioned:
>>=20
>>> PROJINHERIT just indicates the default projid that an inode is
>>> created with; ...
>=20
> Directory inodes can have a project ID set without PROJINHERIT, it
> just means they are accounted to that specific project and have no
> special behaviour w.r.t. newly created children in the directory.
> i.e. without PROJINHERIT, all children will be created with a
> proj ID of zero rather than the projid of the parent directory.
>=20
> i.e. I can do `xfs_io -c "chproj -R 42" /mnt/test` and it will set
> all filesystem and directories to have a projid =3D 42, but
> PROJINHERIT is not set on any directory. The tree gets accounted to
> project 42, but it isn't a directory tree quota - it's just a user
> controlled aggregation of random files associated with the same
> project ID.
>=20
> Hence the statfs behaviour of "report project quota limits for
> directory tree" should only be triggered if PROJINHERIT is set on
> the directory, because that's the only viable indicator that
> directory tree quotas *may* be in use on the filesystem.

Sure, I think the question is if statfs() is called on a regular
file in a parent directory with PROJINHERIT set (which is easily
checked) should it return the project limits in the same way as
if statfs() is called on the directory itself?

It seems inconsistent for that statfs("/home/adilger/file") returns
full-filesystem information, but statfs("/home/adilger") and
statfs("/home/adilger/dir") would return project information, if
PROJINHERIT are set on "adilger/" and "dir/".  It kind of ruins
the "tree" aspect, especially for processes that are in a container
that has limits on the subdirectory it is mounting.

Cheers, Andreas






--Apple-Mail=_373B4ECC-B75A-4064-9573-2ADA909BD5DF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIyBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmG71xgACgkQcqXauRfM
H+DAwA/4ndb0wtMjoRty4GP3UNmL/IAAmdt5cOpHbbgJ7kbVczo6fZ7T06GProjD
TGjA40UXjepVEIvEjd8fCPnu4YvWaNWmMbtGHZQBkQrf5aTLb91+Pmv7nQy+CV9l
gd85rbCrtpXwQkiUgwRiQYzIQA+6Vnc5oKtYIOi3ZdKSi4KreFdmUT1y904XVA8b
Fr902hWPz89tuODZY+ABRL8jS6ybOpLYbJSxxeaqPeXZBxDje1xXrIzg/5GMpGhE
8taYmp7RGjx64jbNGIN8XEqTBmWI/GFoMRMGuJkbkEgQdy/PzvLoTSJuZC2FTaoB
Xlm2mCpQXwfRNoMN/Tr1SftoxLedqh/Ijd51oyizOlZagFbfOD1dtQJbItR9nvTC
kPdSgdu1oXkvHCA23+vYvBCBVFQYCqg7408TERWkB2jZpp1we9XPcljgUFi1YYlv
sTpXZUaO1WqSdBEpJk3J1atCDhaxcIpJ3autGegTxM16xP+Ol7X+ZZQfEI4tSfMD
Vn/e5jWOKH2Enz468+7QEeXDzmtndYwNSQ7tGuLzuHK9rhqb8Sr/by0nGb6yFRcK
qtTM4xN2LyNZ3n1xlRclBa6gmMAOJh64RUF3UAdvAUF1cIZfokpf7XsgY+nl+PFS
bfgOOILBUjFNce1Tl/kd90pqjWgzNeBdqpHn9qKu0k3EupWhkg==
=hBxc
-----END PGP SIGNATURE-----

--Apple-Mail=_373B4ECC-B75A-4064-9573-2ADA909BD5DF--
