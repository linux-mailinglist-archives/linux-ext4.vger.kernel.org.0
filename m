Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E7E2CD22C
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 10:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgLCJIr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 04:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbgLCJIn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 04:08:43 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413DFC061A4F
        for <linux-ext4@vger.kernel.org>; Thu,  3 Dec 2020 01:08:03 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 81so1275326ioc.13
        for <linux-ext4@vger.kernel.org>; Thu, 03 Dec 2020 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=74uO1/t37YPwzY2IgX0iwzNHyHsHeMRe/OnM5c1rYkk=;
        b=eBGAu01BJ7pLj83+gnLYKzxbwx0GGpfO42EPDHHQqiKy+l+zICwZDdpgDUou58g4d0
         VTdt5vmYaLsLVc2CuyiM19A4r+8Z3x96sQ23HVYfkQYl4jPxvuGSjdCrk1pB5Ydz0uNL
         jgQCIV1z5k8/FZzjhOlHq0x5vUOarXdxt+MMfjmxWSxnJvNHLSt6xHZj8a+xEyZ006K/
         TZSuh3cLRDWAqykPWD803quDrPG+uicR+bB7SA848sVFXcLV6uiBk0K9+IND1i/L0vqK
         rvzansy8jZr4kP8G2WOw0O2qZ2GWSwZRJnYfie+ijeBREu/lt0ERL5QcENIm0WPrEksO
         f7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=74uO1/t37YPwzY2IgX0iwzNHyHsHeMRe/OnM5c1rYkk=;
        b=sy65+z6tN4LnmlkCdAjCtXGac2Ds+f5URdFOr3cJMOu5O/9I0uORTWflZ/1La/gYKZ
         dds9zUK9LPqyH41LQWZQqfkmBb22369xDhtWBnoi1KOiVDVdBrPvpJe6rVGjk4gEfhuL
         21kc4OI1QpGuf0pf7/A7B16ViN3huD42fWx+g47P1VvN6ma7i7j3BhzCvHjsxERy/N7i
         hSXPfd3trT1ueYr+a/zlfux6I5+PvctjKgrjqP5xXgepXi8HDKLsMGumMnF5jLL7hnEu
         8NizuL7vyLr48lQnrFFL4FsD19evpsmt0FJX+nSgdm6ZjHDBJ/VNQTV271phWLKvDN21
         k+EQ==
X-Gm-Message-State: AOAM530Vw85kh0nTp7alm7iKMZniB1MPEqbXreNAzW0ISlORN2D5cDl1
        PWONKDGqIZdloLExG0ge45M9spi/cWXhhkCxcDw=
X-Google-Smtp-Source: ABdhPJz+HlmQQq3FD9QhMfmNxXK+QNO7QQl6eQlnVn5WE6OMGR2nWetQOGcsV4/Ges3TTKCNATT8YuSG8TJ1PLedfhQ=
X-Received: by 2002:a5d:8356:: with SMTP id q22mr2436261ior.50.1606986482518;
 Thu, 03 Dec 2020 01:08:02 -0800 (PST)
MIME-Version: 1.0
References: <CAKJOkCoUGPctXEcJWZFo+d62CSBmYjxFr1D0j74OY2ijynMyUA@mail.gmail.com>
 <1870131.usQuhbGJ8B@merkaba>
In-Reply-To: <1870131.usQuhbGJ8B@merkaba>
From:   lokesh jaliminche <lokesh.jaliminche@gmail.com>
Date:   Thu, 3 Dec 2020 01:07:51 -0800
Message-ID: <CAKJOkCrBMhLKZjp4=1KJv3uY+xFBN0KEjDx_ix=88xr0oegD+w@mail.gmail.com>
Subject: Re: improved performance in case of data journaling
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Ext4 <linux-ext4@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Martin,

thanks for the quick response,

Apologies from my side, I should have posted my fio job description
with the fio logs
Anyway here is my fio workload.

[global]
filename=3D/mnt/ext4/test
direct=3D1
runtime=3D30s
time_based
size=3D100G
group_reporting

[writer]
new_group
rate_iops=3D250000
bs=3D4k
iodepth=3D1
ioengine=3Dsync
rw=3Drandomwrite
numjobs=3D1

I am using Intel Optane SSD so it's certainly very fast.

I agree that delayed logging could help to hide the performance
degradation due to actual writes to SSD. However as per the iostat
output data is definitely crossing the block layer and since
data journaling logs both data and metadata I am wondering why
or how IO requests see reduced latencies compared to metadata
journaling or even no journaling.

Also, I am using direct IO mode so ideally, it should not be using any type
of caching. I am not sure if it's applicable to journal writes but the whol=
e
point of journaling is to prevent data loss in case of abrupt failures. So
caching journal writes may result in data loss unless we are using NVRAM.

So questions come to my mind are
1. why writes without journaling are having long latencies as compared to
    writes requests with metadata and data journaling?
2. Since metadata journaling have relatively fewer journal writes than data
    journaling why writes with data journaling is faster than no journaling=
 and
    metadata journaling mode?
3. If there is an optimization that allows data journaling to be so fast wi=
thout
   any risk of data loss, why the same optimization is not used in
case of metadata
   journaling?

On Thu, Dec 3, 2020 at 12:20 AM Martin Steigerwald <martin@lichtvoll.de> wr=
ote:
>
> lokesh jaliminche - 03.12.20, 08:28:49 CET:
> > I have been doing experiments to analyze the impact of data journaling
> > on IO latencies. Theoretically, data journaling should show long
> > latencies as compared to metadata journaling. However, I observed
> > that when I enable data journaling I see improved performance. Is
> > there any specific optimization for data journaling in the write
> > path?
>
> This has been discussed before as Andrew Morton found that data
> journalling would be surprisingly fast with interactive write workloads.
> I would need to look it up in my performance training slides or use
> internet search to find the reference to that discussion again.
>
> AFAIR even Andrew had no explanation for that. So I thought why would I
> have one? However an idea came to my mind: The journal is a sequential
> area on the disk. This could help with harddisks I thought at least if
> if it I/O mostly to the same not too big location/file =E2=80=93 as you d=
id not
> post it, I don't know exactly what your fio job file is doing. However th=
e
> latencies you posted as well as the device name certainly point to fast
> flash storage :).
>
> Another idea that just came to my mind is: AFAIK ext4 uses quite some
> delayed logging and relogging. That means if a block in the journal is
> changed another time within a certain time frame Ext4 changes it in
> memory before the journal block is written out to disk. Thus if the same
> block if overwritten again and again in short time, at least some of the
> updates would only happen in RAM. That might help latencies even with
> NVMe flash as RAM usually still is faster.
>
> Of course I bet that Ext4 maintainers have a more accurate or detailed
> explanation than I do. But that was at least my idea about this.
>
> Best,
> --
> Martin
>
>
