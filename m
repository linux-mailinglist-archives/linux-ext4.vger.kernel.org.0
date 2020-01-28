Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65C14AEC4
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2020 05:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgA1EzP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jan 2020 23:55:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35521 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1EzP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jan 2020 23:55:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so6328008pgk.2
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jan 2020 20:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3pUoO19qF3rsFtg7c97tmuv8pSV62hA+D9okmxsIy9M=;
        b=k/wzA7da0OcBuMYI1PpOo+oDKRxMzpSErmczS42Rdp2aWKlhN8bBQfpSy9MgtSUNSW
         gPWzlqBlKuYQ1/yQiGeNnFRk6VRHS1J1kntSe15A4c6uGp69duppr93SnmhQkvNRlrBp
         ESrqxPNjQ8V+DMnJk+yoGKiD4afG2ajk1XH/UjAWxrf3Tp8EU+FEZf6mLU5tF2Xd4al+
         BN+JUNpJaGebVUe0R46vEWNlty8aDx9+j0zrEaKN0UUVHYG649gtJoFkGAyQEzZ8qtat
         wl1xMjJT1cmSdA8HXLIbKyYxrPX3J02lkI34PxiV8S7ppA6y/3I0Nfm++d/2w21iR5yL
         DVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pUoO19qF3rsFtg7c97tmuv8pSV62hA+D9okmxsIy9M=;
        b=SgMgAELvsI6WP50m+3huO69CxyhiZ8p4hJZNoaGRzpwCRueLcp86nJFKE4GL9Zf418
         f6gSW57mGb07U8DasLR6swsoZ5YgfZg+T4gze5zMm2PdoViaZ8R30M8/bJMk1QdTTTPO
         +AfT7cxJih1fYS0SUqpAOfOUAsSCopUA3quQTqe4wYp25iBgjf0cG6xJagYMHGiTekkb
         uUTOaJvaQ0GZvVXehp+xfIPNN0IpMpBDk57l48yHIX4Sef4PChd8hRxy8Wm7mlROJgHB
         ikTb4Wlu89zsje7HswXZ7XZBdrHLkX7trhNTAx3qiVk1qKh26PQjSqaiEdXPN2lAdkYc
         6s2A==
X-Gm-Message-State: APjAAAXywMvZT4q8P1KuS4oO3BM5ftShyH0NoBWfayiffiFtv/3pSrqk
        IidpxI8yDD+JScmYWZOmqeOptX5J29VOZU9q81znK1MP
X-Google-Smtp-Source: APXvYqxjL5PsedrffhUmnynaaI3hQu5cHGG4R6IklRSAsfRgh54zjcVtnlNWIBKgP1vVkamkNq0YZXMlrehUI4EWNfI=
X-Received: by 2002:aa7:9796:: with SMTP id o22mr2096814pfp.101.1580187314317;
 Mon, 27 Jan 2020 20:55:14 -0800 (PST)
MIME-Version: 1.0
References: <CACZyaBsCb7KxQce27C79WhD5BKekq4Gi4z_P4h_xYvQ8_zv26A@mail.gmail.com>
 <20200125015720.GJ147870@mit.edu>
In-Reply-To: <20200125015720.GJ147870@mit.edu>
From:   Colin Zou <colin.zou@gmail.com>
Date:   Mon, 27 Jan 2020 20:55:04 -0800
Message-ID: <CACZyaBvcMqZosWfvNwWJt2+dihRJGybe4O0_Q67a+wxn3ci4cA@mail.gmail.com>
Subject: Re: Help: ext4 jbd2 IO requests slow down fsync
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the information and analysis. I then did more tests. My app
runs random 4KB workloads on SSD device, one write followed by one
fsync. Here are the FIO test simulating the workload and the test
results. Please help to take a look and let me know what you think.

=================
Ext3 (Kernel 3.2)
=================
# ./fio  --rw=randwrite --bs=4k --direct=0 --filesize=1G --numjobs=32
--runtime=240 --group_reporting --filename=/db/test.benchmark
--name=randomwrite --fsync=3 --invalidate=1

randomwrite: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K,
ioengine=psync, iodepth=1

...

fio-2.16-5-g915ca

Starting 32 processes

randomwrite: Laying out IO file(s) (1 file(s) / 1024MB)

Jobs: 31 (f=31): [w(9),_(1),w(22)] [100.0% done] [0KB/294.4MB/0KB /s]
[0/75.4K/0 iops] [eta 00m:00s]

randomwrite: (groupid=0, jobs=32): err= 0: pid=9050: Tue Jan  7 18:00:16 2020

  write: io=32768MB, bw=272130KB/s, iops=68032, runt=123303msec
     <<<<<<<<<<<  iops is much higher than 4.4 kernel test below.

    clat (usec): min=1, max=21783, avg=35.40, stdev=137.63

     lat (usec): min=1, max=21783, avg=35.51, stdev=137.74

    clat percentiles (usec):

     |  1.00th=[    1],  5.00th=[    2], 10.00th=[    2], 20.00th=[    3],

     | 30.00th=[    4], 40.00th=[    6], 50.00th=[    7], 60.00th=[   10],

     | 70.00th=[   14], 80.00th=[   23], 90.00th=[   94], 95.00th=[  211],

     | 99.00th=[  354], 99.50th=[  580], 99.90th=[ 1144], 99.95th=[ 1336],

     | 99.99th=[ 1816]

    lat (usec) : 2=2.18%, 4=19.43%, 10=36.36%, 20=19.23%, 50=10.43%

    lat (usec) : 100=2.60%, 250=6.43%, 500=2.75%, 750=0.23%, 1000=0.19%

    lat (msec) : 2=0.16%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%

  cpu          : usr=0.35%, sys=8.89%, ctx=27987466, majf=0, minf=1120

  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%

     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%

     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%

     issued    : total=r=0/w=8388608/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0

     latency   : target=0, window=0, percentile=100.00%, depth=1



Run status group 0 (all jobs):

  WRITE: io=32768MB, aggrb=272129KB/s, minb=272129KB/s,
maxb=272129KB/s, mint=123303msec, maxt=123303msec



Disk stats (read/write):

    dm-4: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%,
aggrios=1/8378314, aggrmerge=0/10665, aggrticks=0/3661470,
aggrin_queue=3661970, aggrutil=97.88%

  sdb: ios=1/8378314, merge=0/10665, ticks=0/3661470,
in_queue=3661970, util=97.88%


===================
Kernel 4.4
===================
# ./fio  --rw=randwrite --bs=4k --direct=0 --filesize=1G --numjobs=32
--runtime=240 --group_reporting --filename=/db/test.benchmark
--name=randomwrite --fsync=3 --invalidate=1

randomwrite: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K,
ioengine=psync, iodepth=1

...

fio-2.16-5-g915ca

Starting 32 processes

Jobs: 32 (f=32): [w(32)] [100.0% done] [0KB/219.3MB/0KB /s] [0/56.2K/0
iops] [eta 00m:00s]

randomwrite: (groupid=0, jobs=32): err= 0: pid=27703: Tue Jan  7 17:42:03 2020

  write: io=32768MB, bw=228297KB/s, iops=57074, runt=146977msec

    clat (usec): min=1, max=1647, avg=22.88, stdev=27.19

     lat (usec): min=1, max=1647, avg=22.96, stdev=27.22

    clat percentiles (usec):

     |  1.00th=[    2],  5.00th=[    3], 10.00th=[    5], 20.00th=[    8],

     | 30.00th=[   11], 40.00th=[   13], 50.00th=[   15], 60.00th=[   17],

     | 70.00th=[   22], 80.00th=[   33], 90.00th=[   52], 95.00th=[   72],

     | 99.00th=[  103], 99.50th=[  131], 99.90th=[  241], 99.95th=[  326],

     | 99.99th=[  852]

    lat (usec) : 2=0.68%, 4=5.79%, 10=18.95%, 20=40.42%, 50=22.92%

    lat (usec) : 100=9.96%, 250=1.19%, 500=0.06%, 750=0.01%, 1000=0.01%

    lat (msec) : 2=0.01%

  cpu          : usr=0.30%, sys=10.26%, ctx=24443801, majf=0, minf=295

  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%

     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%

     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%

     issued    : total=r=0/w=8388608/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0

     latency   : target=0, window=0, percentile=100.00%, depth=1



Run status group 0 (all jobs):

  WRITE: io=32768MB, aggrb=228297KB/s, minb=228297KB/s,
maxb=228297KB/s, mint=146977msec, maxt=146977msec



Disk stats (read/write):

    dm-3: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%,
aggrios=0/8555222, aggrmerge=0/88454, aggrticks=0/4851095,
aggrin_queue=4858514, aggrutil=91.66%

  sdb: ios=0/8555222, merge=0/88454, ticks=0/4851095,
in_queue=4858514, util=91.66%



On Fri, Jan 24, 2020 at 5:57 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Jan 23, 2020 at 10:28:47PM -0800, Colin Zou wrote:
> >
> > I used to run my application on ext3 on SSD and recently switched to
> > ext4. However, my application sees performance regression. The root
> > cause is, iosnoop shows that the workload includes a lot of fsync and
> > every fsync does data IO and also jbd2 IO. While on ext3, it seldom
> > does journal IO. Is there a way to tune ext4 to increase fsync
> > performance? Say, by reducing jbd2 IO requests?
>
> If you're not seeing journal I/O from ext3 after an fsync, you're not
> looking at things correctly.  At the very *least* there will be
> journal I/O for the commit block, unless all of the work was done
> earlier in a previous journal commit.
>
> In general, ext4 and ext3 will be doing roughly the same amount of I/O
> to the journal.  In some cases, depending on the workload, ext4
> *might* need to do more data I/O for the file being synced.  That's
> because with ext3, if there is an intervening periodic 5 second
> journal commit, some or all of the data I/O may have been forced out
> to disk earlier due to said 5 second sync.
>
> What sort of workload does your application do?  How much data blocks
> are you writing before each fsync(), and how often are the fsync()
> operations?
>
>                                                 - Ted
