Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C4C3E09E9
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 23:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhHDVQC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 17:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHDVQC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 17:16:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4185C0613D5
        for <linux-ext4@vger.kernel.org>; Wed,  4 Aug 2021 14:15:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c16so6838641lfc.2
        for <linux-ext4@vger.kernel.org>; Wed, 04 Aug 2021 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m061UtWKXw9gHO4jAR+Wk6NhmM0CVjE24PxUNOnO1Vg=;
        b=qd0CBKxdvzB+w5FuxJXLe5+8SnV1wDc/R1sidsb5K6l6C7nTUaWQmTqxS3saOug0sJ
         al+LgWW9ygJWqyQF1O6sRkm9rUFS8svZNuemoVDGrByYOLue1L1ClLpxBX1ogW7ZVRLO
         DHNkRVxqTpfbXOPmSrqLJ+2KZzROFq/joYZo1dKkkwaOvJQZkE72T36TRMu3y0irLrk/
         qJX8tSVvMOqRQv3Vu76jbH1JBz3Gk3EJQsxvgPcRfnA4Zt+pdsBVM9UM0zyE66BmV03P
         FCnBJITirupZfWFuxqDdN2Wr1UETZzVwZBC9devFRrCRZytScw++bXjK6tbnix8bVBd0
         rEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m061UtWKXw9gHO4jAR+Wk6NhmM0CVjE24PxUNOnO1Vg=;
        b=lJ+VRy+TOGO0vJiIwNpgzFFbXNYN/rSDM6aNG/yA7yhj49RMXS+c8svxGmAmgUJWGg
         FFE/EVoOaExGyGVymx7wDGFHtM9iepzZtoVvQGJhlD+0hwYuAaeTDy9lKFrIM69nbdkl
         xEdgNylzD+N2cUK8aM1c/iPGyejOAv5+SxIfq6VpEi09t9mGgcZoyTNq4wm6jXlWlJEW
         8KjfMJXR1pBUo0TrcQ/4KRs62tlmygQFbJdzDicd8WXwgWmzIVTpGrjUtWHaDSc3T6bS
         ILLv+4pCykLqwEyto6fdlE2wkbxlc2z6tqVVZnE5nujwd3HvDDdVZ7l+VJVh4xhqAzax
         O4HQ==
X-Gm-Message-State: AOAM530gpOs9iJ4CGIPAuiwzPCe48dQ3ZlPryymMDoCzWxiod0SKs73c
        ESbxa/LbYzLbP9QpRGdDCrA=
X-Google-Smtp-Source: ABdhPJyeeljMCgnvuy3DPkkw+TkoqLUXt/sBle8w7iwFK6TLqj0CQkKq7FnMYzj5ZoPXWojSa3JDJQ==
X-Received: by 2002:ac2:531c:: with SMTP id c28mr944566lfh.74.1628111746078;
        Wed, 04 Aug 2021 14:15:46 -0700 (PDT)
Received: from [192.168.2.192] ([62.33.81.195])
        by smtp.gmail.com with ESMTPSA id b4sm301719lfv.86.2021.08.04.14.15.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Aug 2021 14:15:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: bug with large_dir in 5.12.17
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <YQrpmUq/y3T/L2E6@mit.edu>
Date:   Thu, 5 Aug 2021 00:15:41 +0300
Cc:     Carlos Carvalho <carlos@fisica.ufpr.br>,
        linux-ext4@vger.kernel.org, Theodore Tso <tytso@google.com>,
        Andreas Dilger <adilger@dilger.ca>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B24E01FD-F436-4BA5-BDB3-E1CDB2E07EF3@gmail.com>
References: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
 <5FE9762B-6C6B-4A44-AC99-22192B76C060@gmail.com> <YQrpmUq/y3T/L2E6@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Teodore,

Your one-line fix looks good.

I have tested it. 1560000 names created successfully.

But the patch with refactoring doesn=E2=80=99t work. I got this messages

1480000 names created
1520000 names created
ln: failed to access =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001520519': Bad message
ln: failed to access =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001520520': Bad message

[ 7699.212018] EXT4-fs error (device loop0): dx_probe:887: inode #2: =
block 144843: comm ln: Directory index failed checksum
[ 7699.216001] EXT4-fs error (device loop0): dx_probe:887: inode #2: =
block 144843: comm ln: Directory index failed checksum

I have no objections to send your one-line fix, but we need to double =
check refactoring.

Best regards,
Artem Blagodarenko



> On 4 Aug 2021, at 22:25, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Thu, Jul 29, 2021 at 10:23:35PM +0300, =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=
=D0=B4=D0=B0=D1=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC =
wrote:
>> Hello,
>>=20
>> It looks like the fix b5776e7524afbd4569978ff790864755c438bba7 "ext4: =
fix potential htree index checksum corruption=E2=80=9D introduced this =
regression.
>> I reverted it and my test from previous message passed the dangerous =
level of 1570000 names count.
>> Now test is still in progress. 2520000 names are already created.
>>=20
>> I am searching the way to fix this.
>>=20
>> Best regards,
>> Artem Blagodarenko.
>=20
> Hi Artem, did you have a chance to take a look at some of the possible
> fixes which I floated on this thread?
>=20
> Do you have any objections if I take this and send it to Linus?
>=20
> Thanks,
>=20
> 					- Ted
>=20
> =46rom fa8db30806b4e83981c65f18f98de33f804012d9 Mon Sep 17 00:00:00 =
2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Wed, 4 Aug 2021 14:23:55 -0400
> Subject: [PATCH] ext4: fix potential htree correuption when growing =
large_dir
> directories
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Commit b5776e7524af ("ext4: fix potential htree index checksum
> corruption) removed a required restart when multiple levels of index
> nodes need to be split.  Fix this to avoid directory htree corruptions
> when using the large_dir feature.
>=20
> Cc: stable@kernel.org # v5.11
> Cc: =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=D1=80=D0=B5=D0=BD=D0=BA=D0=
=BE =D0=90=D1=80=D1=82=D1=91=D0=BC <artem.blagodarenko@gmail.com>
> Fixes: b5776e7524af ("ext4: fix potential htree index checksum =
corruption)
> Reported-by: Denis <denis@voxelsoft.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> fs/ext4/namei.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 5fd56f616cf0..f3bbcd4efb56 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2517,7 +2517,7 @@ static int ext4_dx_add_entry(handle_t *handle, =
struct ext4_filename *fname,
> 				goto journal_error;
> 			err =3D ext4_handle_dirty_dx_node(handle, dir,
> 							frame->bh);
> -			if (err)
> +			if (restart || err)
> 				goto journal_error;
> 		} else {
> 			struct dx_root *dxroot;
> --=20
> 2.31.0
>=20

