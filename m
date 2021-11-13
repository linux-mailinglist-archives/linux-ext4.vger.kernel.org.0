Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9544F452
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Nov 2021 18:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhKMRWx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Nov 2021 12:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbhKMRWx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 Nov 2021 12:22:53 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B67C061766
        for <linux-ext4@vger.kernel.org>; Sat, 13 Nov 2021 09:20:00 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q17so10935260plr.11
        for <linux-ext4@vger.kernel.org>; Sat, 13 Nov 2021 09:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=h/QInmT6ydgjdxPy8gcqMkWtLJXamLTP0sUvBews3fU=;
        b=F12OellKIdWm8fMA/DqihdtCAlnm3nmz1RX1Pby5JWup9wTKA6+l33GMlMRbQ/ZTUZ
         5z+EEcwPyhnZ86xgwjZ0xqoG6kQ/El1KdffNZYCsVduHdRSTndPGItHci9+AUGMaFnpE
         Ynn9osjz5ovXDE7GTdOR6MFEtq0DaOtHQkib8VA/qDEjeF8spUAO8ckSK87RlPY/8XP5
         B5IW/cxrlkLTPQFN2uuiuFLXbZxqds9FmNLwF/GEtzTJBq/dtj7PDIu3X6VjwYWg0OEk
         xVrRCeeTJDGK0A8bwWXZjmdV1vEEfMMUtBsa+QVjDzjSFf1d3CCsb4ZHtSMQeGiv6y2A
         kO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=h/QInmT6ydgjdxPy8gcqMkWtLJXamLTP0sUvBews3fU=;
        b=qLAdEdaD7J8dpgFOs9lP31cBzgu/3jLt70BjpHOdvQo05r3yVNpE29CB2oCeEOiUq6
         Cqm85ktFU9eGtmMS2phCISjgJADCzvAsaHCEffyyJWWqO6BabWAa/R9bjikCXfY9hjvz
         ccc0Jm3KOhbN0SeFoM6slfA0qSwnYBmBHmxcIN4bLqDb/NlwXBMy3V/cj+tKKadF+6+E
         shpBQeKz97OTFWRqetLWvKIeqLKtuKW8IxIxoGAcgwTgL9aAakpk+Ia4jANnhqRT6PcV
         CYchfo4zadkrEyR7TPtN1srBkLRl58GZLTBbYigho5yBcpzuoM6dbcBoxBOFerCwMg5f
         Ll3Q==
X-Gm-Message-State: AOAM532FqGHuzbWXDlxxLIbrKHGNixwuGfn7BMOCA/kTCPUBnz8phA/3
        Vt1ssXpnoVU6+vcWZUlhVujVIHj6Sb1X8orD
X-Google-Smtp-Source: ABdhPJxv0/HyZDPtH0kvGZ3Sjb17HAk/+ta3K1RpGHTX/7DKWdk+CG4HWfENsMDs3icXls1wGaHM0g==
X-Received: by 2002:a17:902:a717:b0:142:76bc:da69 with SMTP id w23-20020a170902a71700b0014276bcda69mr19225880plq.12.1636823999949;
        Sat, 13 Nov 2021 09:19:59 -0800 (PST)
Received: from smtpclient.apple (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id u2sm9633367pfi.120.2021.11.13.09.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 09:19:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: Maildir quickly hitting max htree
Date:   Sat, 13 Nov 2021 09:19:58 -0800
Message-Id: <82C9B126-527B-4D41-8E01-84C560E06A3F@dilger.ca>
References: <d1f5c468-4afa-accc-7843-83b484dc081@xwax.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
In-Reply-To: <d1f5c468-4afa-accc-7843-83b484dc081@xwax.org>
To:     Mark Hills <mark@xwax.org>
X-Mailer: iPhone Mail (19B74)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Nov 13, 2021, at 04:05, Mark Hills <mark@xwax.org> wrote:
>=20
> =EF=BB=BFAndreas, thanks for such a prompt reply.
>=20
>> On Fri, 12 Nov 2021, Andreas Dilger wrote:
>>=20
>>> On Nov 12, 2021, at 11:37, Mark Hills <mark@xwax.org> wrote:
>>>=20
>>> =EF=BB=BFSurprised to hit a limit when handling a modest Maildir case; d=
oes=20
>>> this reflect a bug?
>>>=20
>>> rsync'ing to a new mail server, after fewer than 100,000 files there=20
>>> are intermittent failures:
>>=20
>> This is probably because you are using 1KB blocksize instead of 4KB,=20
>> which reduces the size of each tree level by the cube of the ratio, so=20=

>> 64x. I guess that was selected because of very small files in the=20
>> maildir?
>=20
> Interesting! The 1Kb block size was not explicitly chosen. There was no=20=

> plan other than using the defaults.
>=20
> However I did forget that this is a VM installed from a base image. The=20=

> root cause is likely to be that the /home partition has been enlarged from=
=20
> a small size to 32Gb.
>=20
> Is block size the only factor? If so, a patch like below (untested) could=20=

> make it clear it's relevant, and saved the question in this case.

The patch looks reasonable, but should be submitted separately with
[patch] in the subject so that it will not be lost. =20

You can also add on your patch:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>


Cheers, Andreas

>=20
> [...]
>> If you have a relatively recent kernel, you can enable the "large_dir"=20=

>> feature to allow 3-level htree, which would be enough for another factor=20=

>> of 1024/8 =3D 128 more entries than now (~12M).
>=20
> The system is not yet in use, so I think it's better we reformat here, and=
=20
> get a block size chosen by the experts :)
>=20
> These days I think VMs make it more common to enlarge a filesystem from a=20=

> small size. We could have picked this up earlier with a warning from=20
> resize2fs; eg. if the block size will no longer match the one that would=20=

> be chosen by default. That would pick it up before anyone puts 1Kb block=20=

> size into production.
>=20
> Thanks for identifying the issue.
>=20
> --=20
> Mark
>=20
>=20
> =46rom 8604c50be77a4bc56a91099598c409d5a3c1fdbe Mon Sep 17 00:00:00 2001
> From: Mark Hills <mark@xwax.org>
> Date: Sat, 13 Nov 2021 11:46:50 +0000
> Subject: [PATCH] Block size has an effect on the index size
>=20
> ---
> fs/ext4/namei.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index f3bbcd4efb56..8965bed4d7ff 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2454,8 +2454,9 @@ static int ext4_dx_add_entry(handle_t *handle, struc=
t ext4_filename *fname,
>        }
>        if (add_level && levels =3D=3D ext4_dir_htree_level(sb)) {
>            ext4_warning(sb, "Directory (ino: %lu) index full, "
> -                     "reach max htree level :%d",
> -                     dir->i_ino, levels);
> +                     "reach max htree level :%d"
> +                     "with block size %lu",
> +                     dir->i_ino, levels, sb->s_blocksize);
>            if (ext4_dir_htree_level(sb) < EXT4_HTREE_LEVEL) {
>                ext4_warning(sb, "Large directory feature is "
>                         "not enabled on this "
> --=20
> 2.33.1
