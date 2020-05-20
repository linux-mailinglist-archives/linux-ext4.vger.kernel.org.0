Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8211DBE08
	for <lists+linux-ext4@lfdr.de>; Wed, 20 May 2020 21:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgETTeH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 May 2020 15:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgETTeG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 May 2020 15:34:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31FCC061A0E
        for <linux-ext4@vger.kernel.org>; Wed, 20 May 2020 12:34:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b12so1750850plz.13
        for <linux-ext4@vger.kernel.org>; Wed, 20 May 2020 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=3J3GfHbBFmnPT/9taTW9f0GGTHZjP68EiNjYN8sQPqM=;
        b=GKvOWCioaH0iZAUPKT1xXJPaKViVYDka6ecUqYHi9IEZU4K162ZGBj4diV9/1mmCqO
         Fcfs3Eniw5QfX9VUWViiXCj84IW69TVn2supBUxPHmHd1RWYo57/KmplJ6eUC3DIU909
         972koKiu0h8Ngkga/g9u9Gk91StQs82td6Sbo9XHr2liqzcKVpjGI/dy//plTMxcmTGd
         rT6IBZyBafSnOAeQCaisjjLu/Bd/60bjCa86nhoubieKfK4biizQpCQNVs4q/wX5wUms
         mh2pRk8sydGHui8ZEykEoZYYOiHF7CHAbBOsfx8qJsLsQoewdMslmIpLI4PugJgxbLGV
         ABrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=3J3GfHbBFmnPT/9taTW9f0GGTHZjP68EiNjYN8sQPqM=;
        b=fsUa3cJ2XZqgJoWx1e3ZQaRPXuzHISspcHUaav9sKxnmhk+W1G4m8DGl5SmtRNtWge
         /m7M/I8s4i9+TzLu3f/3+NDXs5LhTllsVAkyKS2HDS6vB6TR1jXsCKM5CWG83cckFDgn
         J/Ke7dRZ/RH+iOulQ+d9bxTvjgblHDs9mNcUp9lDb0XBTwlRM+5PCE60V941MDq+kEm7
         LnPOlzysHQ1RQBBNbJPiYyu4Z0xWUg8oKoX/ymPpUw/dze/iOWKlhsb7V3EEqQ00vsW5
         f+aRSmVzXVz/9LS0OmhlLg6tbdyNThs1mKhG63taVluyKM/vUb8L9+vRTirURBszKp3U
         Vvtg==
X-Gm-Message-State: AOAM530nfCLqw8d07/pfAbZ3YK+CgkWeCfVGlEVYzepJaQItpIlz0PLE
        VnKNktvVzEkTTUzV1LpV6Rg6VO/ySorA6w==
X-Google-Smtp-Source: ABdhPJwqinQH+N/5DNzYa7Zqak1uFzG+xT+Au5rWTPpzX14bZ7ROW3SLtc1at6s52fwhNBsJxQwh5Q==
X-Received: by 2002:a17:90b:e0f:: with SMTP id ge15mr7105105pjb.140.1590003245918;
        Wed, 20 May 2020 12:34:05 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id r2sm2829989pfq.194.2020.05.20.12.34.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 12:34:05 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <DDB9F79B-55A9-4667-AE03-60D575CAD77A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8C771D9C-CB62-45D8-A6D3-BD59C1E1BAC8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
Date:   Wed, 20 May 2020 13:34:03 -0600
In-Reply-To: <3158FFEB-D9F7-450B-85C5-38B1C218321F@whamcloud.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>
References: <0B6BF408-EDF7-4363-80CD-BDA0136BF62C@whamcloud.com>
 <20200514100411.D1A15A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
 <914597DA-395A-47A5-A8D6-DFCE2D674289@whamcloud.com>
 <3BA1CBB1-77DB-43C8-A9CD-A3B85223F86F@dilger.ca>
 <3158FFEB-D9F7-450B-85C5-38B1C218321F@whamcloud.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_8C771D9C-CB62-45D8-A6D3-BD59C1E1BAC8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On May 20, 2020, at 2:40 AM, Alex Zhuravlev <azhuravlev@whamcloud.com> =
wrote:
>=20
>=20
>=20
>> On 17 May 2020, at 10:55, Andreas Dilger <adilger@dilger.ca> wrote:
>>=20
>> The question is whether this is situation is affecting only a few =
inode
>> allocations for a short time after mount, or does this persist for a =
long
>> time?  I think that it _should_ be only a short time, because these =
other
>> threads should all start prefetch on their preferred groups, so even =
if a
>> few inodes have their blocks allocated in the "wrong" group, it =
shouldn't
>> be a long term problem since the prefetched bitmaps will finish =
loading
>> and allow the blocks to be allocated, or skipped if group is =
fragmented.
>=20
> Yes, that=E2=80=99s the idea - there is a short window when buddy data =
is being
> populated. And for each =E2=80=9Ccluster=E2=80=9D (not just a single =
group) prefetching
> will be initiated by allocation.
> It=E2=80=99s possible that some number of inodes will get =E2=80=9Cbad=E2=
=80=9D blocks right after
> after mount.
> If you think this is a bad scenario I can introduce couple more =
things:
> 1) few times discussed prefetching thread
> 2) let mballoc wait for the goal group to get ready - this essentials =
one
>    more check in ext4_mb_good_group()

IMHO, this is an acceptable "cache warmup" behavior, not really =
different
than mballoc doing limited scanning when looking for any other =
allocation.
Since we already separate inode table blocks and data blocks into =
separate
groups due to flex_bg, I don't think any group is "better" than another,
so long as the allocations are avoiding worst-case fragmentation (i.e. a
series of one-block allocations).

Cheers, Andreas






--Apple-Mail=_8C771D9C-CB62-45D8-A6D3-BD59C1E1BAC8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7FhisACgkQcqXauRfM
H+AO9Q/9FzfLeFFXTgs0LB5d49mldVY8/aeuqshI1P07XOeUmkHGltQR8Y1FS7Az
fGeoqugxNBKJRz4jJSG6lNWSwSwdsWHYuFXH59rJvH7WZy9nUbBcc8O0RXp8PpFN
TKCgQDERZ3jiYyjSV7uEinYjzuhLmUJk734eA7Nt9j3ghaPEMw5ZGS6cK/tNccav
F5VLyR61IhqKU9hKgSOCNu8z/WRQBBlX/BFVXB166Nm/esX8QsftI2mJvQQmvEOH
vGxc8OOjgiRHbpj03AeJg5lRUGIt9JObSTyn2ECgTDY5bEPf1Je8PceNlbaOppg1
NCNK90uEOhscrLzmYIBcasBzMV2t3MbbivzsH4Y2ZDxeb7XFnuNdqAgsH5wkUuto
Cb6iPYIzgVF35PGhy6+Ts+t2uYbhM6HevyVFlAvsPBfaznbIGwyfRvvlQGt2Iowm
pr7t+UIBaBiZ9XJZBcX6qvkirpFynrtkcWGjjHlDW8wV4n4m7AAfS8DNg4PaENHa
MzZl7kUCj9FA8uca8ZF/VXxsnYc1np83U9KUMBnAKdWnE6mVGlTUnhk90b7y1zQu
EywV4S4CGQm/pVqL2dbjIypuTwkPPEEjG9k1eqz8OXJfYpKZn6ip0RJm1r0LRkSR
oA3GY+Ck+kpnvMzIMBuSQcVpSvkmtbTM99mnxJftQziIN72jLE0=
=fD+P
-----END PGP SIGNATURE-----

--Apple-Mail=_8C771D9C-CB62-45D8-A6D3-BD59C1E1BAC8--
