Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2BD2E0DFA
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 18:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgLVRsL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 12:48:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:35356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbgLVRsL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 22 Dec 2020 12:48:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E18B8ABA1;
        Tue, 22 Dec 2020 17:47:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 95C5F1E1364; Tue, 22 Dec 2020 18:47:29 +0100 (CET)
Date:   Tue, 22 Dec 2020 18:47:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     lokesh jaliminche <lokesh.jaliminche@gmail.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>
Subject: Re: improved performance in case of data journaling
Message-ID: <20201222174729.GD22832@quack2.suse.cz>
References: <CAKJOkCoUGPctXEcJWZFo+d62CSBmYjxFr1D0j74OY2ijynMyUA@mail.gmail.com>
 <1870131.usQuhbGJ8B@merkaba>
 <CAKJOkCrBMhLKZjp4=1KJv3uY+xFBN0KEjDx_ix=88xr0oegD+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKJOkCrBMhLKZjp4=1KJv3uY+xFBN0KEjDx_ix=88xr0oegD+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Thu 03-12-20 01:07:51, lokesh jaliminche wrote:
> Hi Martin,
> 
> thanks for the quick response,
> 
> Apologies from my side, I should have posted my fio job description
> with the fio logs
> Anyway here is my fio workload.
> 
> [global]
> filename=/mnt/ext4/test
> direct=1
> runtime=30s
> time_based
> size=100G
> group_reporting
> 
> [writer]
> new_group
> rate_iops=250000
> bs=4k
> iodepth=1
> ioengine=sync
> rw=randomwrite
> numjobs=1
> 
> I am using Intel Optane SSD so it's certainly very fast.
> 
> I agree that delayed logging could help to hide the performance
> degradation due to actual writes to SSD. However as per the iostat
> output data is definitely crossing the block layer and since
> data journaling logs both data and metadata I am wondering why
> or how IO requests see reduced latencies compared to metadata
> journaling or even no journaling.
> 
> Also, I am using direct IO mode so ideally, it should not be using any type
> of caching. I am not sure if it's applicable to journal writes but the whole
> point of journaling is to prevent data loss in case of abrupt failures. So
> caching journal writes may result in data loss unless we are using NVRAM.

Well, first bear in mind that in data=journal mode, ext4 does not support
direct IO so all the IO is in fact buffered. So your random-write workload
will be transformed to semilinear writeback of the page cache pages. Now 
I think given your SSD storage this performs much better because the
journalling thread commiting data will drive large IOs (IO to the journal
will be sequential) and even when the journal is filled and we have to
checkpoint, we will run many IOs in parallel which is beneficial for SSDs.
Whereas without data journalling your fio job will just run one IO at a
time which is far from utilizing full SSD bandwidth.

So to summarize you see better results with data journalling because you in
fact do buffered IO under the hood :).

								Honza

> So questions come to my mind are
> 1. why writes without journaling are having long latencies as compared to
>     writes requests with metadata and data journaling?
> 2. Since metadata journaling have relatively fewer journal writes than data
>     journaling why writes with data journaling is faster than no journaling and
>     metadata journaling mode?
> 3. If there is an optimization that allows data journaling to be so fast without
>    any risk of data loss, why the same optimization is not used in
> case of metadata
>    journaling?
> 
> On Thu, Dec 3, 2020 at 12:20 AM Martin Steigerwald <martin@lichtvoll.de> wrote:
> >
> > lokesh jaliminche - 03.12.20, 08:28:49 CET:
> > > I have been doing experiments to analyze the impact of data journaling
> > > on IO latencies. Theoretically, data journaling should show long
> > > latencies as compared to metadata journaling. However, I observed
> > > that when I enable data journaling I see improved performance. Is
> > > there any specific optimization for data journaling in the write
> > > path?
> >
> > This has been discussed before as Andrew Morton found that data
> > journalling would be surprisingly fast with interactive write workloads.
> > I would need to look it up in my performance training slides or use
> > internet search to find the reference to that discussion again.
> >
> > AFAIR even Andrew had no explanation for that. So I thought why would I
> > have one? However an idea came to my mind: The journal is a sequential
> > area on the disk. This could help with harddisks I thought at least if
> > if it I/O mostly to the same not too big location/file – as you did not
> > post it, I don't know exactly what your fio job file is doing. However the
> > latencies you posted as well as the device name certainly point to fast
> > flash storage :).
> >
> > Another idea that just came to my mind is: AFAIK ext4 uses quite some
> > delayed logging and relogging. That means if a block in the journal is
> > changed another time within a certain time frame Ext4 changes it in
> > memory before the journal block is written out to disk. Thus if the same
> > block if overwritten again and again in short time, at least some of the
> > updates would only happen in RAM. That might help latencies even with
> > NVMe flash as RAM usually still is faster.
> >
> > Of course I bet that Ext4 maintainers have a more accurate or detailed
> > explanation than I do. But that was at least my idea about this.
> >
> > Best,
> > --
> > Martin
> >
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
