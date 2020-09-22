Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25892747A6
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Sep 2020 19:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgIVRmp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Sep 2020 13:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVRmp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Sep 2020 13:42:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D1AC061755
        for <linux-ext4@vger.kernel.org>; Tue, 22 Sep 2020 10:42:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id bw23so1840965pjb.2
        for <linux-ext4@vger.kernel.org>; Tue, 22 Sep 2020 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=a0Nqv9WUdZu/JHXlQPhOLlwRMwlvLZkLZtv9leHItsw=;
        b=OiRYoXk1OfDHvOI4KO9uCU9NMzHeEycWCzgnaQ2sRSQv8lDvGh1l/ng2cEILUFRTcR
         Rq+IlD+tq62WHqJE1OrVmVkhMl6ln8svfdTh6LtyJyvNepDLO911FgIpj5GURpDPkzwd
         ouzf7Hsct6QWK2Re9Wp3UzH6TzXRYRU1maZOIK1IeW4YjmJ/+52qejRyjMiQWT/uWnzy
         TYJl0v+uy9lVTV/FPrVUYEf+hqo5FE5rr2mE8Kwo1Bf3BduynI3TZF3pbVVBY60PYzSv
         rhxk3e50EX5HGyUQ+vDJhu4+ZvgSKgJt7meSlPWrVLcn2gUI0Bxkh6PWxBfU+vyXqC2W
         ErDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=a0Nqv9WUdZu/JHXlQPhOLlwRMwlvLZkLZtv9leHItsw=;
        b=KizswfVLfbaRJsELxAfbdzTvzFLysFsn1ttp7LV9QgPjw0mIWveZLkhcqbDYL78YS1
         vgnO21MvtzThjja5NYAOE+5Zgh1zS9ezyXfg7xaIpUFar7xhps69df/Ewp1vlaALWBBr
         SWT7242/a3APnxXdaFtMRoYkol97lgHmDOG3S8SdK86P0rTKeoDQ2ghmQNMajR0ABrQw
         0YNFIRRuFX1jI9jFZVVS3Bsf/EXv+yr/5k3ZANctgJj4Vnv8bj85WDSx53P9cbb20TBb
         W4/T/+MfM6r/aI6T+ubLb89k1wDG4+9vPlK+FVI7QuO7vXD7++tzDn+mFnkqX1BnjlDB
         Hs4w==
X-Gm-Message-State: AOAM532u9vdPAW+pV9fmvkkNSTCUK2P2SJmMIJeTMm2bZuYT3kOhhnDx
        asX82xgXpCTINbTVwwjAecRBhQ==
X-Google-Smtp-Source: ABdhPJygw3DQzGzUjT2aosmQkN4f6H8FMrISsI0pl0RXMULF2pCF79hVZIBFoShmjwWJl1MfAwmcHg==
X-Received: by 2002:a17:90b:3cb:: with SMTP id go11mr4318083pjb.152.1600796564467;
        Tue, 22 Sep 2020 10:42:44 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s66sm15716394pfc.159.2020.09.22.10.42.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 10:42:43 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7CFD0AAF-CE38-4DFC-AF1C-3B3BA671C3BE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DFFF35F3-FCC3-440A-ABB7-6A5CB3F99471";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: skip extent optimization by default
Date:   Tue, 22 Sep 2020 11:42:40 -0600
In-Reply-To: <20200922102600.5asdjvarnh5znhf2@work>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
References: <1600726562-9567-1-git-send-email-adilger@whamcloud.com>
 <20200922102600.5asdjvarnh5znhf2@work>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_DFFF35F3-FCC3-440A-ABB7-6A5CB3F99471
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 22, 2020, at 4:26 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> On Mon, Sep 21, 2020 at 04:16:02PM -0600, adilger@whamcloud.com wrote:
>> From: Andreas Dilger <adilger@whamcloud.com>
>>=20
>> The e2fsck error message:
>>=20
>>    inode nnn extent tree (at level 1) could be narrower. Optimize<y>?
>>=20
>> can be fairly verbose at times, and leads users to think that there
>> may be something wrong with the filesystem.  Basically, almost any
>> message printed by e2fsck makes users nervous when they are facing
>> other corruption, and a few thousand of these printed may hide other
>> errors.  It also isn't clear that saving a few blocks optimizing the
>> extent tree noticeably improves performance.
>>=20
>> This message has previously been annoying enough for Ted to add the
>> "-E no_optimize_extents" option to disable it.  Just enable this
>> option by default, similar to the "-D" directory optimization option.
>=20
> it seem counterproductive to me that we would disable usefull (even if
> just a little) optimization just because the way it is presented to =
the
> user is inconvenient. I agree that messages during e2fsck often raise
> alarms, as they should, but perfeps instead of disabling the feature =
we
> can figure out a way to make the messaging better ?
>=20
> Can we just not print the every message if the answer is going to be =
yes
> anyway, either because of -y, -p, <a> or whatever when the user is not
> involved in the decision anymore ? Maybe a log file can be created
> for the purpose of storing the full log of changes. Or perhaps we can
> print out a summary for each type of the problem and how many of the
> instaces of a particular problem have been optimized/fixed after the
> e2fsck is done pointing to that full log for details ?

I think the standard way to handle this in e2fsck is with a "latch =
question",
so that after the first or second 'y' with "answer 'y' to all =
questions".
This will quiet most of the messages without disabling the optimization.

The other question is whether the "optimization" is worthwhile or not?
Since e2fsck is rarely run, a number of unoptimized files will exist in
the filesystem all the time.  In our case at least, files have a =
turnover
rate, so optimizing the current set of inodes doesn't help much, since
they would likely be deleted in a few weeks and new files will replace =
them.

Cheers, Andreas

>>=20
>> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
>> ---
>> e2fsck/e2fsck.8.in | 4 ++--
>> e2fsck/unix.c      | 7 +++++++
>> 2 files changed, 9 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/e2fsck/e2fsck.8.in b/e2fsck/e2fsck.8.in
>> index 4e3890b..4f5086a 100644
>> --- a/e2fsck/e2fsck.8.in
>> +++ b/e2fsck/e2fsck.8.in
>> @@ -228,12 +228,12 @@ exactly the opposite of discard option. This is =
set as default.
>> .TP
>> .BI no_optimize_extents
>> Do not offer to optimize the extent tree by eliminating unnecessary
>> -width or depth.  This can also be enabled in the options section of
>> +width or depth.  This is the default unless otherwise specified in
>> .BR /etc/e2fsck.conf .
>> .TP
>> .BI optimize_extents
>> Offer to optimize the extent tree by eliminating unnecessary
>> -width or depth.  This is the default unless otherwise specified in
>> +width or depth.  This can also be enabled in the options section of
>> .BR /etc/e2fsck.conf .
>> .TP
>> .BI inode_count_fullmap
>> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
>> index 1b7ccea..445f806 100644
>> --- a/e2fsck/unix.c
>> +++ b/e2fsck/unix.c
>> @@ -840,6 +840,8 @@ static errcode_t PRS(int argc, char *argv[], =
e2fsck_t *ret_ctx)
>> 	else
>> 		ctx->program_name =3D "e2fsck";
>>=20
>> +	ctx->options |=3D E2F_OPT_NOOPT_EXTENTS;
>> +
>> 	phys_mem_kb =3D get_memory_size() / 1024;
>> 	ctx->readahead_kb =3D ~0ULL;
>> 	while ((c =3D getopt(argc, argv, =
"panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) !=3D EOF)
>> @@ -1051,6 +1053,11 @@ static errcode_t PRS(int argc, char *argv[], =
e2fsck_t *ret_ctx)
>> 	if (c)
>> 		ctx->options |=3D E2F_OPT_NOOPT_EXTENTS;
>>=20
>> +	profile_get_boolean(ctx->profile, "options", "optimize_extents",
>> +			    0, 0, &c);
>> +	if (c)
>> +		ctx->options &=3D ~E2F_OPT_NOOPT_EXTENTS;
>> +
>> 	profile_get_boolean(ctx->profile, "options", =
"inode_count_fullmap",
>> 			    0, 0, &c);
>> 	if (c)
>> --
>> 1.7.12.4
>>=20
>=20


Cheers, Andreas






--Apple-Mail=_DFFF35F3-FCC3-440A-ABB7-6A5CB3F99471
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9qN5AACgkQcqXauRfM
H+CaFBAAvL3X3hNBLTLq0M9HA4u/nKgBGqoN7ZpJ76tP+jvvLFSy0/FuNgJmY3Pn
5rynH/tyoKi2oyjukFffyEcbYCW9EvOwexHoYa2RB4cjEvuW4D4H2HK+7xcW8ZSf
wc1RRDKHom+rclZd5OZSzI859cWFemvYQFk99MwOeaShpF7XQ5gAaSB4O7SJabyC
WM+y2A0zDbYEYDF7WwiJkzDbDN0yLn8ZxSw/w2rt78te/FzEm1yIftmIC1KVNANN
RPtY3zIZGrMcVGOxiiREt5ChxxGrPJipuPiNLXe7lFfLiEU+ZD+IGpztRLwmyFRC
58hFzDmkoUQnMa9nrftEqgdX5vxujcIwkHZJ9ENk/pCWCSafZAP6B/9VWb04lgtS
+lVWhgOhFLqCI99SD9ZdCKSCiJZbrgc//SQRYCuC76ZvnfvZPXRA3PnXKqJd0UIC
MGdyAyAgXDHSY4LTykrqb8ao7XXvRNr2Fkn7qyWGhmJorxhzf8sQk9IT+efSyf0n
ULWUWVdH79MDlgExJPtYcZAVjovPsNtwJtsnhCyHXOLG9HbGg/KHfSBRDVtpmcjB
iXj22A2bnX/Zc4FsxkyNBnUw1AjK71MTM/Aj4FcfsTrks6sOajE1BKteRO6tDLVx
jN7D2J5+MgbCRt99Pevk0oztxBMIDDAffS30zKylJHq9mYwsWMw=
=HLk3
-----END PGP SIGNATURE-----

--Apple-Mail=_DFFF35F3-FCC3-440A-ABB7-6A5CB3F99471--
