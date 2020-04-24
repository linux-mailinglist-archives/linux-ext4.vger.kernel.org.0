Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61051B81B0
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 23:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDXVnR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Apr 2020 17:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgDXVnR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Apr 2020 17:43:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81716C09B049
        for <linux-ext4@vger.kernel.org>; Fri, 24 Apr 2020 14:43:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k18so4236238pll.6
        for <linux-ext4@vger.kernel.org>; Fri, 24 Apr 2020 14:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=IkFo3nL7y/n/MNYQxUxtDVtMmA8yPYWDQky4aW4hVsY=;
        b=OomnYWLh3KxSwN9oXSHlMLyvCrESAVo+E2DOKdLLAp5oBp2l/6+dvzO4jQEiVyi7hJ
         ALh5XOvc9xRFyS6nSanN/kjABBNiy8kjAzc93BaP6zOPkc+2PmoHV8sDA3IB8ohEcDBW
         gx6tS5GQ6bK6eZXZMznHvn2Fh8uzdxH7dE3Z6UnuDoRcGc8mNhEvChbw4Kq0uV2nZoYS
         NK8ZdlBO9ZDRE0G1T+yCOf4y1tj+nQYNdLUEZMfIjVqzY7YJoRxSHabntKRM8d6rEG+4
         ws+JnZST0ghma9z/2gECrha7wID7dLGHf/Z1bCeTUPrjSxG7iP5XGkW4DvuK0lgY98Ci
         FmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=IkFo3nL7y/n/MNYQxUxtDVtMmA8yPYWDQky4aW4hVsY=;
        b=W6EPUzl2hFuBr70ST7frcEIgU8NkAo99tTEEOPPBcpTKVZV24Lxmcr/vRIDz9lLcGN
         zbhKSGDKM3Fb/BmqGK31TlVGjkJt53zUuupeJCji0CtgeKO5CIL9cjY8NPw03OUHiFzV
         KSGYurMWX3y5LWb7WAuC0V7rWphbevGDTte3a8PtyJhJx5xJgPNs4Sb5oLZeHftRC3K9
         3SGsd2nIVv+VPs75h0Wkq0EsYV8TkZl+QC6L4IOm6P8sMnSM/dQzPlHgfhF54vboSdHK
         23dfVILYJl4+lzU+wyW+r4bDkUzr4wMQBH+jy9n1vsNGwwOp7StRmOUEPgs5oT3pggSL
         GaJA==
X-Gm-Message-State: AGi0PubnxcXCVQDfjd5BYFpv69hL2WIapmLCaDkRIm8st/7aEybkPaIc
        rvRYS1BTTjFkJzEL9pNZjyc0LNc+U74=
X-Google-Smtp-Source: APiQypJeETr7tw8OmWQZdOPYbgT03biRRxArL6+k+I1hQsroByyDzepIrchmR3gwDd27MkL1g9GP2Q==
X-Received: by 2002:a17:90a:3327:: with SMTP id m36mr8594704pjb.116.1587764596854;
        Fri, 24 Apr 2020 14:43:16 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f2sm5366952pju.32.2020.04.24.14.43.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 14:43:15 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3F735CCE-F9A8-4743-A6BF-DC2945FBB4B2@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5A02F767-63AB-47E2-880E-B13E3981E8D1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Need help to understand Ext4 message in /var/log/message file
Date:   Fri, 24 Apr 2020 15:43:11 -0600
In-Reply-To: <CAG-6nk-Q16UBbUkWoogut0fYP9s78x0OMf946Dg-tJk1nd+kzA@mail.gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Alok Jain <jain.alok103@gmail.com>
References: <CAG-6nk-Q16UBbUkWoogut0fYP9s78x0OMf946Dg-tJk1nd+kzA@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5A02F767-63AB-47E2-880E-B13E3981E8D1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Apr 24, 2020, at 12:56 PM, Alok Jain <jain.alok103@gmail.com> wrote:
> 
> Hi Guys,
> 
> I need an help to understand the following messages printed in
> /var/log/message file
> 
> Apr 20 17:42:44 mylinux audispd: node=mylinux type=EXECVE
> msg=audit(1587404564.745:5901346): argc=4 a0="mount" a1="-v"
> a2="UUID=b1d54239-2b18-44b3-a4bf-5e0ca32b8f78" a3="/tmp/aj/m1"
> Apr 20 17:42:45 mylinux kernel: [4633324.069180] EXT4-fs (sde1):
> recovery complete
> Apr 20 17:42:45 mylinux kernel: [4633324.070157] EXT4-fs (sde1):
> mounted filesystem with ordered data mode. Opts: (null)
> 
> 
> Actualy one of the iSCSI device is mounted to /tmp/aj/m1 with UUID
> (U1) I unmounted this device and mounted new device (UUID
> b1d54239-2b18-44b3-a4bf-5e0ca32b8f78) after mount I see the UUID of
> newly mounted device changed to U1 and new device got corrupted. I ran
> fsck to fix the device but UUID was changed to U1.

It sounds like the iSCSI device is not flushing the block device
cache between unmounting the old filesystem and mounting the new one?

The new filesystem has a dirty journal, and when it is replayed it
reads a stale superblock from the old filesystem and overwrites the
new filesystem.

Cheers, Andreas






--Apple-Mail=_5A02F767-63AB-47E2-880E-B13E3981E8D1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6jXW8ACgkQcqXauRfM
H+A6bA//dai5w5C4Nxsq1QuvNA7yqDhkLWEb49Iyb4KpV+81bF5fAk7F0KXM8hr7
L0iARsHPjuFIyDTowiKNuipN5DyEIzpk7c80C9UVUMahNPTls9STnqiBIa2gIAmc
OQu4r9oEvxvxOueEnizcn5ikt3aJIddNe1maI3N8EAoPe8cqC7J6M+RnO6ZwZGix
PJT0xX/HDz7IWOfvv6HRGuw5U7WrYXg416lyGXh0nUslm7q66rQ0NCCyFsVBjRXE
MxjMvPCux473puidAafp5fsmOLArVAS3a7zIh6v7P4hrSq2o4HxMsprUIajOj5F3
fk9R4qSImp0/J/PR5M3aUHfGhmyD0BWEM8StJ0rAHyiVBfxOlqBirtkOuYsvhmNK
RcpWGvMBqnLCFoFsaSfKDtEs0AQjefdm66hZlLMfmbRtWU/bWs9sDc58ePwa779N
AqAhmU3aQZE+ohO/JQJTKyfPpHGRXeXR9bcaI0SRAWto0YS//44n2FXIUZPjOW0b
SxUiJeAAdIzr5WMNV3V2vxEgWAzCfh41GWk0WxGI3lFXpljjo5loVUwFS9k05X1c
UmbuP4sJAZiBXUD1eglxQWY8UechzifuvxJ1ubR7rP1Cbz5XWMIIS98X3155rZCN
GuhAS44IB9QV+i+kYvSbetsyToNPzgbbj9ylshNeV4aC4QNcakM=
=t+0T
-----END PGP SIGNATURE-----

--Apple-Mail=_5A02F767-63AB-47E2-880E-B13E3981E8D1--
