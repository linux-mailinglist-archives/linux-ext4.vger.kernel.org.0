Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A45A2E33FC
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Dec 2020 05:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgL1EHa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Dec 2020 23:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgL1EH3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 27 Dec 2020 23:07:29 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D2C061794
        for <linux-ext4@vger.kernel.org>; Sun, 27 Dec 2020 20:06:49 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q1so8469910ilt.6
        for <linux-ext4@vger.kernel.org>; Sun, 27 Dec 2020 20:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bGhJOGLJdZrxQBR5CfXYY1s07Uy7BpAhWqw7Zeie6H8=;
        b=kizhbo9Xh9rWQgnfvtj24seL4ISvo8dBKXQ2f7+lPSj4TM2uOEQ2kVIEHxfF2MljLV
         NP3xBMfgnN6fB/vcBkpG/qHNniaPvm394Bmym6pYLp0ZRvb0bF97sSV9YwzGzUYhqN1V
         2DYnLQZ4FZbmQl1Dz/qmHh0z0h+op0Ij2xlVACGl+QN2WVNhkGarj2LM+1MsvDmUdVMC
         T8O0ZnqpHHOkVxzzb9YfLdMQpfivbEj02wnXrkWigqPCaINGPsXcG6MIFb7T1L//+XSE
         TsYIu4WWQSdEBGwYCDCd496VUsbPwI1HM0kxiIlBysLQejH9uNMu6SK86udWUrf9hZRH
         28xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bGhJOGLJdZrxQBR5CfXYY1s07Uy7BpAhWqw7Zeie6H8=;
        b=tzZoVqSyEVyUo5uGiWzqbKPbwcFixCQovE7ObaF/zThMjWk4hWDa5cRichoixReSAt
         MUfWJsw2WVGh78f8FlS4Rb702SZjtXhCuUGPlXmtGaBtte39qIJlAkMz4VFuZx0dVfdS
         BhMuH8r/p1MOU4dr8b7SbElHIfeMkmreU7ROmWuivjwtg/f1u4MwOx0eePzFgiETXCom
         xnMG4VNnIBEDRuaTNlmyv0Ip/sBzsmgalpsg73uXXhzGjIlI05L84TaBZVXujhamWNYC
         A20sHbCTzRofap30MimvHHyFGFzm36+bH3IDPz84F07Ik4BHbXcXkGPzO4lwt0X27ahS
         Wfog==
X-Gm-Message-State: AOAM533CkGWXrlpJPK3nX5mFOUU1VZOoKbWf1zWxtmAsMN2A3zFh6w/j
        gNl25d3zXzoVEwDQy4zxP2w37/JXrFcfNAPCYJhGlXnR2YE=
X-Google-Smtp-Source: ABdhPJx6YVa0OKOuwj9EB9le2dK5Lw35yfj7AJlVDYls3VBxGx+KzHh3+Phpjz+kf7pbgZ+JlVYAGcDk2+uSv8XEIG8=
X-Received: by 2002:a05:6e02:14ce:: with SMTP id o14mr42578753ilk.9.1609128408549;
 Sun, 27 Dec 2020 20:06:48 -0800 (PST)
MIME-Version: 1.0
References: <CAKJOkCoUGPctXEcJWZFo+d62CSBmYjxFr1D0j74OY2ijynMyUA@mail.gmail.com>
 <1870131.usQuhbGJ8B@merkaba> <CAKJOkCrBMhLKZjp4=1KJv3uY+xFBN0KEjDx_ix=88xr0oegD+w@mail.gmail.com>
 <20201222174729.GD22832@quack2.suse.cz> <0D219223-7CE9-4441-9F14-0125023ED969@dilger.ca>
In-Reply-To: <0D219223-7CE9-4441-9F14-0125023ED969@dilger.ca>
From:   lokesh jaliminche <lokesh.jaliminche@gmail.com>
Date:   Sun, 27 Dec 2020 20:06:36 -0800
Message-ID: <CAKJOkCpXWfcPwjj8j_NehiTVSdR+C4nh0aELOiwR0EeH9=VFDg@mail.gmail.com>
Subject: Re: improved performance in case of data journaling
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Martin Steigerwald <martin@lichtvoll.de>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Mauricio Faria de Oliveira <mfo@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 22, 2020 at 2:24 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Dec 22, 2020, at 10:47 AM, Jan Kara <jack@suse.cz> wrote:
> >
> > Hi!
> >
> > On Thu 03-12-20 01:07:51, lokesh jaliminche wrote:
> >> Hi Martin,
> >>
> >> thanks for the quick response,
> >>
> >> Apologies from my side, I should have posted my fio job description
> >> with the fio logs
> >> Anyway here is my fio workload.
> >>
> >> [global]
> >> filename=3D/mnt/ext4/test
> >> direct=3D1
> >> runtime=3D30s
> >> time_based
> >> size=3D100G
> >> group_reporting
> >>
> >> [writer]
> >> new_group
> >> rate_iops=3D250000
> >> bs=3D4k
> >> iodepth=3D1
> >> ioengine=3Dsync
> >> rw=3Drandomwrite
> >> numjobs=3D1
> >>
> >> I am using Intel Optane SSD so it's certainly very fast.
> >>
> >> I agree that delayed logging could help to hide the performance
> >> degradation due to actual writes to SSD. However as per the iostat
> >> output data is definitely crossing the block layer and since
> >> data journaling logs both data and metadata I am wondering why
> >> or how IO requests see reduced latencies compared to metadata
> >> journaling or even no journaling.
> >>
> >> Also, I am using direct IO mode so ideally, it should not be using any=
 type
> >> of caching. I am not sure if it's applicable to journal writes but the=
 whole
> >> point of journaling is to prevent data loss in case of abrupt failures=
. So
> >> caching journal writes may result in data loss unless we are using NVR=
AM.
> >
> > Well, first bear in mind that in data=3Djournal mode, ext4 does not sup=
port
> > direct IO so all the IO is in fact buffered. So your random-write workl=
oad
> > will be transformed to semilinear writeback of the page cache pages. No=
w
> > I think given your SSD storage this performs much better because the
> > journalling thread commiting data will drive large IOs (IO to the journ=
al
> > will be sequential) and even when the journal is filled and we have to
> > checkpoint, we will run many IOs in parallel which is beneficial for SS=
Ds.
> > Whereas without data journalling your fio job will just run one IO at a
> > time which is far from utilizing full SSD bandwidth.
> >
> > So to summarize you see better results with data journalling because yo=
u in
> > fact do buffered IO under the hood :).

That makes sense thank you!!
>
> IMHO that is one of the benefits of data=3Djournal in the first place, re=
gardless
> of whether the journal is NVMe or HDD - that it linearizes what would oth=
erwise
> be a random small-block IO workload to be much friendlier to the storage.=
  As
> long as it maintains the "written to stable storage" semantic for O_DIREC=
T, I
> don't think it is a problem that the data is copied or not.  Even without=
 the
> use of data=3Djournal, there are still some code paths that copy O_DIRECT=
 writes.
>
> Ideally, being able to dynamically/automatically change between data=3Djo=
urnal
> and data=3Dordered depending on the IO workload (e.g. large writes go str=
aight
> to their allocated blocks, small writes go into the journal) would be the=
 best
> of both worlds.  High "IOPS" for workloads that need it (even on HDD), wi=
thout
> overwhelming the journal device bandwidth with large streaming writes.
>
> This would tie in well with the proposed SMR patches, which allow a very =
large
> journal device to (essentially) transform ext4 into a log-structured file=
system
> by allowing journal shadow buffers to be dropped from memory rather than =
being
> pinned in RAM:
>
> https://github.com/tytso/ext4-patch-queue/blob/master/series
> https://github.com/tytso/ext4-patch-queue/blob/master/jbd2-dont-double-bu=
mp-transaction-number
> https://github.com/tytso/ext4-patch-queue/blob/master/journal-superblock-=
changes
> https://github.com/tytso/ext4-patch-queue/blob/master/add-journal-no-clea=
nup-option
> https://github.com/tytso/ext4-patch-queue/blob/master/add-support-for-log=
-metadata-block-tracking-in-log
> https://github.com/tytso/ext4-patch-queue/blob/master/add-indirection-to-=
metadata-block-read-paths
> https://github.com/tytso/ext4-patch-queue/blob/master/cleaner
> https://github.com/tytso/ext4-patch-queue/blob/master/load-jmap-from-jour=
nal
> https://github.com/tytso/ext4-patch-queue/blob/master/disable-writeback
> https://github.com/tytso/ext4-patch-queue/blob/master/add-ext4-journal-la=
zy-mount-option
>
>
> Having a 64GB-256GB NVMe device for the journal and handling most of the =
small
> IO directly to the journal, and only periodically flushing to the filesys=
tem to
> HDD would really make those SMR disks more usable, since they are startin=
g to
> creep into consumer/NAS devices, even when users aren't really aware of i=
t:
>
> https://blocksandfiles.com/2020/04/14/wd-red-nas-drives-shingled-magnetic=
-recording/
>
> >> So questions come to my mind are
> >> 1. why writes without journaling are having long latencies as compared=
 to
> >>    writes requests with metadata and data journaling?
> >> 2. Since metadata journaling have relatively fewer journal writes than=
 data
> >>    journaling why writes with data journaling is faster than no journa=
ling and
> >>    metadata journaling mode?
> >> 3. If there is an optimization that allows data journaling to be so fa=
st
> >>    without any risk of data loss, why the same optimization is not use=
d in case
> >>    of metadata journaling?
> >>
> >> On Thu, Dec 3, 2020 at 12:20 AM Martin Steigerwald <martin@lichtvoll.d=
e> wrote:
> >>>
> >>> lokesh jaliminche - 03.12.20, 08:28:49 CET:
> >>>> I have been doing experiments to analyze the impact of data journali=
ng
> >>>> on IO latencies. Theoretically, data journaling should show long
> >>>> latencies as compared to metadata journaling. However, I observed
> >>>> that when I enable data journaling I see improved performance. Is
> >>>> there any specific optimization for data journaling in the write
> >>>> path?
> >>>
> >>> This has been discussed before as Andrew Morton found that data
> >>> journalling would be surprisingly fast with interactive write workloa=
ds.
> >>> I would need to look it up in my performance training slides or use
> >>> internet search to find the reference to that discussion again.
> >>>
> >>> AFAIR even Andrew had no explanation for that. So I thought why would=
 I
> >>> have one? However an idea came to my mind: The journal is a sequentia=
l
> >>> area on the disk. This could help with harddisks I thought at least i=
f
> >>> if it I/O mostly to the same not too big location/file =E2=80=93 as y=
ou did not
> >>> post it, I don't know exactly what your fio job file is doing. Howeve=
r the
> >>> latencies you posted as well as the device name certainly point to fa=
st
> >>> flash storage :).
> >>>
> >>> Another idea that just came to my mind is: AFAIK ext4 uses quite some
> >>> delayed logging and relogging. That means if a block in the journal i=
s
> >>> changed another time within a certain time frame Ext4 changes it in
> >>> memory before the journal block is written out to disk. Thus if the s=
ame
> >>> block if overwritten again and again in short time, at least some of =
the
> >>> updates would only happen in RAM. That might help latencies even with
> >>> NVMe flash as RAM usually still is faster.
> >>>
> >>> Of course I bet that Ext4 maintainers have a more accurate or detaile=
d
> >>> explanation than I do. But that was at least my idea about this.
> >>>
> >>> Best,
> >>> --
> >>> Martin
> >>>
> >>>
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
>
>
> Cheers, Andreas
>
>
>
>
>
