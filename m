Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3238A0F4
	for <lists+linux-ext4@lfdr.de>; Thu, 20 May 2021 11:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhETJ1U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 May 2021 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhETJ0q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 May 2021 05:26:46 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23CBC0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 20 May 2021 02:25:23 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s12so3059063qta.3
        for <linux-ext4@vger.kernel.org>; Thu, 20 May 2021 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=glRWrb4ToTcP1k28gY9aKPK6RXkFSPiLNaZiYR+SNA8=;
        b=BaE2Y7XYi396kb34xH8kXsMDMjx0DwYuXprm83STishn6o5c20E2O3JeURN16LBe9I
         N89Pd1xi4+6tjn+9up/bSf6CMfPccx0RzyFIIduXXP55Cxn21Cqa3u78Pp5+MWSaOPD8
         WMwoVcXapJt47oBK9rdBluPHi6uSZT8qOBz1bncws/i9/+rb4ilUdvJ1sM13HoPTF0VV
         REy/YzNgjnD39gHBIAE30w5IaFpRiThuaidWxuNLF/k8sHAlT5TyFbSWNlOHu1IH896M
         fUB9/8r/kzOpnhhLlXPG/ThGqJwDMsq8dRSzz8ms0hi0ECE1uvt5bUeUMmBRfYWKJukM
         XyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=glRWrb4ToTcP1k28gY9aKPK6RXkFSPiLNaZiYR+SNA8=;
        b=BbTcuD5KjTnSiYObUFH+XvXKHhN/Q/wVnF8KxxnIwpLb0BrQmKdFu+qc1Pcoq0Z0pv
         gEA8s7E6vb2vbj4cCHhIwfheak9XK8aPxDvjM9bdEjACdyoNIiUEu0n90isZxyYB9PGz
         ZdsHkyXCB/BntaYCsKCx0aTf7ynX8IN3mzSnoOQQigSFnGjBqkltwPpkAwdUsQyXF2LD
         bMHLIA4R+0nEwKc/EbNAoCsMXOsgyrmAW6PyNlmdW7ZnBe0nSucYblv0yECcdteYEtuX
         CH7ES70omVN/wHQ/q762oYEN345ZCyooLPvJ9vU0xqbJUuK+7fZIL5v/gxwh06Hqc15b
         TT4Q==
X-Gm-Message-State: AOAM532cHhRkM+mfTCHKo9tadlb9V4cJJT40PmpL3oUFwwVLSrhKlEuD
        rnJKzewpdsniza//db/hL90=
X-Google-Smtp-Source: ABdhPJyNNWRUOYdQS8PpukHbcfy68TXNWQFKj2wDYRGm2bmsbsmdQkJN1bMhFBV8DnWYiEcPx+KTRw==
X-Received: by 2002:a05:622a:1d4:: with SMTP id t20mr4024480qtw.110.1621502723034;
        Thu, 20 May 2021 02:25:23 -0700 (PDT)
Received: from [172.25.65.226] ([136.162.34.1])
        by smtp.gmail.com with ESMTPSA id g4sm1463015qtg.86.2021.05.20.02.25.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 May 2021 02:25:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.20\))
Subject: Re: [PATCH v5] e2image: add option to ignore fs errors
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <4972D70F-1765-413B-971B-CE4147993B29@dilger.ca>
Date:   Thu, 20 May 2021 12:25:10 +0300
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2177370F-B771-49A7-B59B-2820B73499CC@gmail.com>
References: <20210422041347.29039-1-artem.blagodarenko@gmail.com>
 <4972D70F-1765-413B-971B-CE4147993B29@dilger.ca>
To:     Andreas Dilger <adilger@dilger.ca>
X-Mailer: Apple Mail (2.3445.104.20)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello.

Andreas, thank you for the review.=20
It looks like remarks don=E2=80=99t require v6 and can be fixed during a =
merge.

Does anybody has other any objections/ideas?

Thanks.
Artem Blagodarenko.

> On 23 Apr 2021, at 19:25, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> On Apr 23, 2021, at 07:30, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>>=20
>> =EF=BB=BFAdd extended "-E ignore_error" option to be more tolerant
>> to fs errors while scanning inode extents.
>=20
> Not to be pedantic, but should this allow "ignore_errors", since it =
will
> presumably ignore more than one error.  If already using =
"ignore_error"
> in the field you could accept both for some time until able to change =
over,
> as we've done with "ea_inode" vs. "large_xattr" in the Lustre =
e2fsprogs
> for years.=20
>=20
>> Changes since preveious version:
>> - rebased on top of the master
>=20
> This should go after the "---" so that it isn't in the final commit =
message.=20
>=20
>> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
>> Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
>> Cray-bug-id: LUS-1922
>> Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
>> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>> ---
>=20
> One typo in the man page below:
>=20
>> diff --git a/misc/e2image.8.in b/misc/e2image.8.in
>> index cb176f5d..45a06d3b 100644
>> --- a/misc/e2image.8.in
>> +++ b/misc/e2image.8.in
>> @@ -137,6 +144,16 @@ useful if the file system is being cloned to a =
flash-based storage device
>> (where reads are very fast and where it is desirable to avoid =
unnecessary
>> writes to reduce write wear on the device).
>> .TP
>> +.BI \-E " extended_options"
>> +Set e2iamge extended options.
>=20
> "e2image"
>=20
> Ted could fix this in the final commit
> Cheers, Andreas
>=20
>> Extended options are comma separated, and
>> +may take an argument using the equals ('=3D') sign.  The following =
options
>> +are supported:
>> +.RS 1.2i
>> +.TP
>> +.BI ignore_error
>> +Grab an image from a corrupted FS and ignore fs errors.
>> +.RE
>> +.TP
>> .B \-f
>> Override the read-only requirement for the source filesystem when =
saving
>> the image file using the

