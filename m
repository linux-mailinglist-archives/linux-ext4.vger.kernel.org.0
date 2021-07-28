Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F73D92C3
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jul 2021 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbhG1QIH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jul 2021 12:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbhG1QHk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jul 2021 12:07:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBA4C061757
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jul 2021 09:07:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f18so4901444lfu.10
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jul 2021 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uiPX0KQzYE/RZZavis3qWN300Nc1awcYoAihAwuRnSY=;
        b=GRnwYzG5hWnuM0kMZTgbpsFcfTslSbjK6AZju6m6W9O9nNCktJdoKn/5efi4+B7VnV
         MhfQNlWWXrAptNgpGIvoX4RY+0El/uV1OBQZ8ZzzVyqy8ga2HkAuenLlRNBwHs1Q3DOD
         OnJWCXZnxjrzOAac61dinT6uPNrOh35uPGthhbNln9xEytbYJTtqC4jKW0h/GylBYllQ
         r3OJFl4fpOYga/bC5TRYSuKYUEODMyyrOvsc31sjMOLNh+agZgg+01+rTMDhcTAYR5kB
         WiR5la/UjBetWkKn60l1QKVc0ZBtMM6q4SPYzV4ua9EZPEuikaucrDBd0JnYPZRs5wuu
         jnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uiPX0KQzYE/RZZavis3qWN300Nc1awcYoAihAwuRnSY=;
        b=A0R61Dn0ER0n0QYnu94JliJrirpaUndZdB4tcetzAONwYSya7fPIVtF+sThZSOHdoB
         nbwhmeS+nHkP3cuz1pMZqpxxceBq0ycoxrrS9iaGhAreimNpZKoXCOZIGicefu1nHvaB
         rsZsNu5hqSSRO7YNRC7H4pOKlDSMxB+D5FKcgGLVfeqELQFkWLlYrytfoVOm7oCbkhvw
         6Z8DEBeclvMYJ7O0kuR7KZGT3dtE/69v4AaW4WG4iR107vJYaCJygZfiSGlU57WDUpbd
         hqbZa/WBX+tcCviaDBiY14NyzAg8dXQ5uzkwulDpIoAUBPxjtBX//O1CgilBpZKE548P
         r+Kg==
X-Gm-Message-State: AOAM533u4nBDxbWYq/fbawSd7L5bCdE5dybc0ZOGcfr/HUhYWUiSJQ9D
        7Agn9cyzOTrcFep1qr2K8JM=
X-Google-Smtp-Source: ABdhPJw+MbmSsWcwTmYHiwH9ORENXn7jdsDNDH4981eh12Je+4WsL9EFRbo612e1Vue/nrcf5RhuMA==
X-Received: by 2002:ac2:46f5:: with SMTP id q21mr253014lfo.624.1627488455526;
        Wed, 28 Jul 2021 09:07:35 -0700 (PDT)
Received: from [192.168.2.192] ([62.33.81.195])
        by smtp.gmail.com with ESMTPSA id j22sm40330lfr.46.2021.07.28.09.07.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:07:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: bug with large_dir in 5.12.17
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <0FA2DF8F-8F8D-4A54-B21E-73B318C73F4C@dilger.ca>
Date:   Wed, 28 Jul 2021 19:07:33 +0300
Cc:     Carlos Carvalho <carlos@fisica.ufpr.br>, linux-ext4@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <96227CA3-E641-45BF-8063-50C7D7561DF1@gmail.com>
References: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
 <0FA2DF8F-8F8D-4A54-B21E-73B318C73F4C@dilger.ca>
To:     Andreas Dilger <adilger@dilger.ca>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Andreas,

This issue is reproducible in case the =E2=80=9Clarge_dir=E2=80=9D =
option is set initially. The partition is fresh, created just before the =
test started.

1560000 names created
ln: failed to create hard link =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001571063': File exists
ln: failed to access =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001571384': Structure needs cleaning
ln: failed to access =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001572335': Structure needs cleaning
ln: failed to access =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001573095': Structure needs cleaning
ln: failed to access =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001574809': Structure needs cleaning
ln: failed to access =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001576070': Structure needs cleaning

Best regards,
Artem Blagodarenko


> On 27 Jul 2021, at 09:22, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> On Jul 22, 2021, at 8:23 AM, Carlos Carvalho <carlos@fisica.ufpr.br> =
wrote:
>>=20
>> There is a bug when enabling large_dir in 5.12.17. I got this during =
a backup:
>>=20
>> index full, reach max htree level :2
>> Large directory feature is not enabled on this filesystem
>>=20
>> So I unmounted, ran tune2fs -O large_dir /dev/device and mounted =
again. However
>> this error appeared:
>>=20
>> dx_probe:864: inode #576594294: block 144245: comm rsync: directory =
leaf block found instead of index block
>>=20
>> I unmounted, ran fsck and it "salvaged" a bunch of directories. =
However at the
>> next backup run the same errors appeared again.
>>=20
>> This is with vanilla 5.2.17.
>=20
> Hi Carlos,
> are you able to reproduce this error on a new directory that did not =
hit
> the 2-level htree limit before enabling large_dir, or did you only see =
this
> with directories that hit the 2-level htree limit before the update?
> Did you test on any newer kernels than 5.2.17?
>=20
> Cheers, Andreas
>=20
>=20
>=20
>=20
>=20

