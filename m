Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB423282C0
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Mar 2021 16:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbhCAPns (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Mar 2021 10:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbhCAPnq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Mar 2021 10:43:46 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAD7C061756
        for <linux-ext4@vger.kernel.org>; Mon,  1 Mar 2021 07:43:03 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id i8so18208907iog.7
        for <linux-ext4@vger.kernel.org>; Mon, 01 Mar 2021 07:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/CXsaDOInfSq/tqDLIhMEYjHuaEfW1KMJQIHwxlBgfM=;
        b=TIciGjsrfrhEeFp06gukyaV+rF6mU4sgnAbo1CslxF8V+EtuvjcGxC+jfKkcVDiURY
         nczWjdGHnB2XKeQacpTOl61CLYEr0HRYlM6anTheXQUmgKwzKnmxnK2bRJ2ayg2twIIG
         lpBhQbuJF2SEol8cWdVvEnpLdSzm+gupSLzcQ1uDCjmTx5yb2m7xvA2tAReGG2RJ7Ixo
         vtCu47/AnAayxBkvhE8ZEGrLvJAaCosbNiYrIVyW4EsTr2G6/hHyLqa50JliacJXPGCS
         n7+yJkVvLPVCMRyacAYC0D6V2RkXrAHmSMvVljskP6LZ2otWwTK9nGLwvwQom5VhlBff
         Eyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/CXsaDOInfSq/tqDLIhMEYjHuaEfW1KMJQIHwxlBgfM=;
        b=XpUjLjCBHpM3+HR4S72gXCTeeh99tLRBsFflLe6plI3wkhdvhT4Zn+KymqQpsduBi/
         smzDiODbMkb3sQ1AkSnhRrVrsHl2KGFYUaa8VLjQA3sfV+G2i4Zy3z9xMQdLoofySGTs
         2z6il87HhlRZ5ZAzi89yhN+UHLmsNY/mJNJIyCtiVgHddHzsJUhhIdC/yaHxR64u2Gsx
         yg6OA1ACtSQevg1y5wcA5t5xPCMfKRumu6Fh0izkGpkG2DDkRTCCG0XMSFcL+ro7SKXX
         CAXXaoG950CWcBPNIcHMIyCL3V+sYaa/QEEUGG7sNWgPgU1NNuxOiz8PzcX0jU0Q9Qo1
         WnTQ==
X-Gm-Message-State: AOAM530qFgV9pysnQQ5H0jBUloQxZMtgZst2cn4VPnS0I8iXG5kmOLa7
        HbccozLzCyMOMf5dx6kWxkyeQHcybqyobUd5Bg7JQJpRDaPTJA==
X-Google-Smtp-Source: ABdhPJxPm1xOrnobCKOtClMxGtkDJ5j+qhZz4xKQUSw5EkGnr/mhJq3V72VUQYihcIQq0W6rOX6vmCRNwGvh9UI9bjY=
X-Received: by 2002:a05:6638:635:: with SMTP id h21mr5602551jar.97.1614613382942;
 Mon, 01 Mar 2021 07:43:02 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUXzjAniVZMzS5ePNa6HrjWL6ZrpAgzWufy74zHSyN+urQ@mail.gmail.com>
 <YD0DaqIbAf0T2tw2@mit.edu> <CA+icZUXJpEEO4GS1fy9ANXCXJ2BtD_rd1tAtXLun++i0taZwSA@mail.gmail.com>
 <YD0JfjnMtXzGguZ6@mit.edu>
In-Reply-To: <YD0JfjnMtXzGguZ6@mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 1 Mar 2021 16:42:26 +0100
Message-ID: <CA+icZUUruS8h=CiUwuSsbL9NmCXCvdfV-XFfV=Z=qOpR9b83XA@mail.gmail.com>
Subject: Re: badblocks from e2fsprogs
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 1, 2021 at 4:34 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Mar 01, 2021 at 04:12:03PM +0100, Sedat Dilek wrote:
> >
> > OK, I see.
> > So I misunderstood the -o option.
>
> It was clearly documented in the man page:
>
>        -o output_file
>               Write the list of bad blocks to the specified file.
>               Without this option, badblocks displays the list on
>               its standard output.  The format of this file is
>               suitable for use by the -l option in e2fsck(8) or
>               mke2fs(8).
>

RTFM.

> I will say that for modern disks, the usefulness of badblocks has
> decreased significantly over time.  That's because for modern-sized
> disks, it can often take more than 24 hours to do a full read on the
> entire disk surface --- and the factory testing done by HDD
> manufacturers is far more comprehensive.
>
> In addition, SMART (see the smartctl package) is a much more reliable
> and efficient way of judging disk health.
>
> The badblocks program was written over two decades ago, before the
> days of SATA, and even IDE disks, when disk controlls and HDD's were
> far more primitive.  These days, modern HDD and SSD will do their own
> bad block redirection from a built-in bad block sparing pool, and the
> usefulness of using badblocks has been significantly decreased.
>

Thanks for the clarification on badblocks usage and usefulness.

OK, I ran before badblocks:

1. smartctl -a /dev/sdc (shell)
2. gsmartcontrol (GUI)

The results showed me "this disk is healthy".
As you said: Both gave a very quick overview.

- Sedat -

[1] https://superuser.com/questions/171195/how-to-check-the-health-of-a-hard-drive
