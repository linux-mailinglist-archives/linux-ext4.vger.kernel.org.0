Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E208B34BF1F
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Mar 2021 22:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC1U4U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Mar 2021 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhC1Uz5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Mar 2021 16:55:57 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2971AC061756;
        Sun, 28 Mar 2021 13:55:57 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i9so10665515qka.2;
        Sun, 28 Mar 2021 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yJ5S+USBP2vVgDvlKar9mVJbzsSlFsC9GfgbN2QhChU=;
        b=u+wsXHYTN3Aub//8loKCjf+K+7GuHFugcRUB56wmtOFqcaD6SgTPN3IY/FcTSSRh1p
         vbUKFSVkwAeG59BD0Iv7Ken+8BOsLhNrZ7CSJB//+BlWw2OgxAmZVOkOOgCkRENveOc5
         mMZxSIPTTCfBICjMR2CXlelTo9bkZX/3594J8hTtVN3tHH1VB2DQkJFU8LDvoNuuw8YK
         Rrj9eVQrhK/J7MzY0Ccq/u2q0Cgh69+3hwjY++f+jBDu8J0g0qMOXAWd/wxdFiJaUzR8
         2z3815+lfhd8RrenT+8VUaeCULgO8fOb4XL+/WPztexb6avPnVWh5ENBVBWEqtnr7omf
         aZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yJ5S+USBP2vVgDvlKar9mVJbzsSlFsC9GfgbN2QhChU=;
        b=V7/0uVVJUQkP5d5FGCKaRpYngQWyE1iwM7k4SMPuv5m21xBXnHf6NNVl5n53ki32vP
         rehNZB1RJ4rSp1xCsov+QZsPMheEcdA8VH/nWblPkZaNdZteSo7E6n6kImIUtboiEknW
         BMiRjMV0k9ry5JRS/WOqdAn7JL0TuYAARFVkC43GOXCCx0/BGDPKGpucoeVIk2jzSKrG
         71XfPbP2+OfnbdteEJGtFtMydw02xZhTpGiEXyTrvpQoX9OBOH6YtPBF3/Cm50yV6Cxm
         g1c852BuIyFAXCMux61njxwgs7+eM/H5kPCW5dHpRxDeetM8DGr+Jg+uTw6nNaSc7fJx
         YEuA==
X-Gm-Message-State: AOAM533DOZ9VFhsPhuls8Nl3/6uCXRTWC+XMc2TDjMigFCqH16WJWMrB
        dN4+0MVjyC3LLsWkBHeVYsrJuQyZo0MbG8Kd
X-Google-Smtp-Source: ABdhPJxoP079NltjPbZ0gOV9AxLGKopJXki+HSrYE9ze+ad3hKVpOznBOMQVZO43pjqIT+mcuAOdJQ==
X-Received: by 2002:a37:886:: with SMTP id 128mr23632276qki.430.1616964956387;
        Sun, 28 Mar 2021 13:55:56 -0700 (PDT)
Received: from Gentoo ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id g4sm9796979qtg.86.2021.03.28.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 13:55:55 -0700 (PDT)
Date:   Mon, 29 Mar 2021 02:25:42 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] EXT4: Trivial typo fixes
Message-ID: <YGDtTgTqrsxbNRkA@Gentoo>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
References: <cover.1616840203.git.unixbhaskar@gmail.com>
 <20210328193718.coakxjy7vns5iu64@riteshh-domain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="esi1JymLSRiunTWF"
Content-Disposition: inline
In-Reply-To: <20210328193718.coakxjy7vns5iu64@riteshh-domain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--esi1JymLSRiunTWF
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 01:07 Mon 29 Mar 2021, Ritesh Harjani wrote:
>On 21/03/27 04:00PM, Bhaskar Chowdhury wrote:
>> This patch series fixed few mundane typos in the below specific files.
>>
>> Bhaskar Chowdhury (8):
>>   EXT4: migrate.c: Fixed few typos
>>   EXT4: namei.c: Fixed a typo
>>   EXT4: inline.c: A typo fixed
>>   Fix a typo
>>   EXT4: indirect.c: A trivial typo fix
>>   EXT4: xattr.c: Mundane typo fix
>>   EXT4: fast_commit.c: A mere typo fix
>>   EXT4: mballoc.h: Single typo fix
>>
>>  fs/ext4/fast_commit.c | 2 +-
>>  fs/ext4/indirect.c    | 2 +-
>>  fs/ext4/inline.c      | 2 +-
>>  fs/ext4/inode.c       | 2 +-
>>  fs/ext4/mballoc.h     | 2 +-
>>  fs/ext4/migrate.c     | 6 +++---
>>  fs/ext4/namei.c       | 8 ++++----
>>  fs/ext4/xattr.c       | 2 +-
>>  8 files changed, 13 insertions(+), 13 deletions(-)
>
>Thanks,
>since these are trivial typo fixes, why not just 1 patch for fs/ext4/
>IMO, that way it is easier for sender, reviewer and maintainer.
>

I have got the other vibes too ..hence the decision to send it like this way..

~Bhaskar
>-ritesh

--esi1JymLSRiunTWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBg7UoACgkQsjqdtxFL
KRXTygf9HslHprVgHTDi818iZa/il806MOz+/WYt3J5juax5IxSE0H5rqA6+JwOk
gvdhuHT8H1u3iTiQrzOz0FdlcrE1SjM6PG2I83xWok9JGnvtK0oVOIicoxdj4u2h
P8JyCCbFVATyj9v0yYfbUJ7tcmN/zCVVVnRkU+jhMUOAaTIbJGiByl/kGdyqE82o
QW8EwPYSnvYOCv9fd/hxnfBxxzTC4ztNVNR8EoENJEGUjwXr9fo/mtJDl0PpbMzW
N5q66ry6zBaBfJRSdPuRCtxf0X75nIimGtolV9B4a8fJJRTXscPoa5e1LT7ImpZq
/eecXQnZOveltZFj/UPa41EWOdlnsQ==
=HoKC
-----END PGP SIGNATURE-----

--esi1JymLSRiunTWF--
