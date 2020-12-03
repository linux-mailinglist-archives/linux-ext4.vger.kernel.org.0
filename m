Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4F82CD06B
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 08:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbgLCH3l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 02:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388171AbgLCH3l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 02:29:41 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F71AC061A4E
        for <linux-ext4@vger.kernel.org>; Wed,  2 Dec 2020 23:29:01 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n4so1049602iow.12
        for <linux-ext4@vger.kernel.org>; Wed, 02 Dec 2020 23:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9wkbZPjzyOfCyLzoHGFVn/e3nJKK+OU3qxhBxfL2pJ8=;
        b=WDXHXDh94IJrz6AbH3q5dbwGoO4T+XRh3+0os1tDEefK+gMWdF4G5ieGGzQrPkA1PC
         MUM5GsM4ZriWZ1e+MbuRMqvXsDZ1oa4w06+CIQ7Y8h2OTdlfchhAOp2/gr5LUdPsu+Hz
         0pkzzydEOKHYVo/Yojm+1VokKGxbNRT+osvWckSZS6TFIR8dKZBd94VUV4UM+sOSXNaR
         ansT9IMHyvFj/WsmmGaTyGILh7EbV1x7Vr+CHEwBmt4rnOosolInoonZzOI0olqvDLIF
         eAp5QS2UGfh2e/bVammCF2gZi/f+MwPP14nI8vLF13ACJwrsKOdWRuHwtnK1q7FqbVfn
         MZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9wkbZPjzyOfCyLzoHGFVn/e3nJKK+OU3qxhBxfL2pJ8=;
        b=hODf2LKnsk5bqzTitvi/Gc8gvBTrLJbTrHKhU34i6pitAJXCaGNn/BQIb0ld410Tsq
         bswKXYImcP52na4BQpGRAYH2XyisIWM5z899VlNyN2gNIL2WhQgxDoz0mMiyroRFXZMK
         4TBa1khuFFh/KNssZ+vfEU16We+EW3eRa5Gb5Akfii6GM2FoSmuVvCDjgoES2oop8feG
         NW0jMw+G/rC1JlZlDBC2UBJV5+gnMeOYxXxqJzjGa0lDPt1PBvdrO1wYK96vS6R4djv6
         UE3hPeMyN6BV2YIlSDwrJV8DoXRh5G/WWDpDqtMp4Yz/kyY7Zb6xaCJdCXdG9fjtJ/Un
         ANlg==
X-Gm-Message-State: AOAM532BXlauifClqFEBUuBBiir0Xmp53LpNwSsjs1tAti+LStXQ8TZJ
        blMA69OzOzdymSvAsUlF6zM1mx5vnAYXBDo2UqMUUH24SGr7gg==
X-Google-Smtp-Source: ABdhPJy2epKBg2tAvoDdkrEl1LgY7EVhG9q1VmLKvQ6lL6tmVTZ9S3sr3sF83ONBYC1R/ejveiVnpt/3wn7jlquFcfs=
X-Received: by 2002:a5d:8356:: with SMTP id q22mr2201663ior.50.1606980540339;
 Wed, 02 Dec 2020 23:29:00 -0800 (PST)
MIME-Version: 1.0
From:   lokesh jaliminche <lokesh.jaliminche@gmail.com>
Date:   Wed, 2 Dec 2020 23:28:49 -0800
Message-ID: <CAKJOkCoUGPctXEcJWZFo+d62CSBmYjxFr1D0j74OY2ijynMyUA@mail.gmail.com>
Subject: improved performance in case of data journaling
To:     linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello everyone,

I have been doing experiments to analyze the impact of data journaling
on IO latencies. Theoretically, data journaling should show long
latencies as compared to metadata journaling. However, I observed that
when I enable data journaling I see improved performance. Is there any
specific optimization for data journaling in the write path?

fio Logs:
------------
metadata journaling enabled
========================================================================

Actual data written (calculated using iostat): 5820352 bytes

writer_2: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B,
(T) 4096B-4096B, ioengine=sync, iodepth=1
fio-3.16
Starting 1 process
writer_2: Laying out IO file (1 file / 102400MiB)

writer_2: (groupid=0, jobs=1): err= 0: pid=26021: Thu Dec  3 06:51:23 2020
  write: IOPS=24.0k, BW=97.7MiB/s (102MB/s)(2930MiB/30001msec); 0 zone resets
    clat (usec): min=12, max=3144, avg=16.63, stdev=22.33
     lat (usec): min=12, max=3144, avg=16.70, stdev=22.33
    clat percentiles (usec):
     |  1.00th=[   14],  5.00th=[   15], 10.00th=[   15], 20.00th=[   15],
     | 30.00th=[   16], 40.00th=[   16], 50.00th=[   16], 60.00th=[   16],
     | 70.00th=[   16], 80.00th=[   17], 90.00th=[   17], 95.00th=[   18],
     | 99.00th=[   34], 99.50th=[   44], 99.90th=[  424], 99.95th=[  562],
     | 99.99th=[  791]
   bw (  KiB/s): min=99856, max=100168, per=100.00%, avg=99992.14,
stdev=99.10, samples=59
   iops        : min=24964, max=25042, avg=24998.03, stdev=24.78, samples=59
  lat (usec)   : 20=96.72%, 50=2.95%, 100=0.16%, 250=0.02%, 500=0.08%
  lat (usec)   : 750=0.06%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%
  cpu          : usr=34.96%, sys=44.69%, ctx=750093, majf=0, minf=11
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,750001,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
  WRITE: bw=97.7MiB/s (102MB/s), 97.7MiB/s-97.7MiB/s
(102MB/s-102MB/s), io=2930MiB (3072MB), run=30001-30001msec

Disk stats (read/write):
  nvme0n1: ios=0/757110, merge=0/23753, ticks=0/12769, in_queue=116, util=99.74%
-------------------------------------------------------------------------------------------


data journaling enabled
========================================================================
Actual data written (calculated using iostat): 10070880 bytes

writer_2: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B,
(T) 4096B-4096B, ioengine=sync, iodepth=1
fio-3.16
Starting 1 process
writer_2: Laying out IO file (1 file / 102400MiB)

writer_2: (groupid=0, jobs=1): err= 0: pid=26103: Thu Dec  3 06:52:15 2020
  write: IOPS=24.0k, BW=97.7MiB/s (102MB/s)(2930MiB/30001msec); 0 zone resets
    clat (usec): min=3, max=283709, avg=15.16, stdev=946.43
     lat (usec): min=3, max=283709, avg=15.21, stdev=946.43
    clat percentiles (usec):
     |  1.00th=[    6],  5.00th=[    7], 10.00th=[    7], 20.00th=[    8],
     | 30.00th=[    8], 40.00th=[    8], 50.00th=[    9], 60.00th=[    9],
     | 70.00th=[    9], 80.00th=[   11], 90.00th=[   24], 95.00th=[   28],
     | 99.00th=[   34], 99.50th=[   44], 99.90th=[   81], 99.95th=[  676],
     | 99.99th=[  947]
   bw (  KiB/s): min=48488, max=151408, per=99.87%, avg=99861.02,
stdev=13105.09, samples=59
   iops        : min=12122, max=37852, avg=24965.25, stdev=3276.27, samples=59
  lat (usec)   : 4=0.02%, 10=79.65%, 20=5.92%, 50=14.15%, 100=0.17%
  lat (usec)   : 250=0.01%, 500=0.02%, 750=0.03%, 1000=0.03%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
  lat (msec)   : 250=0.01%, 500=0.01%
  cpu          : usr=61.73%, sys=22.41%, ctx=115437, majf=0, minf=11
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,750001,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
  WRITE: bw=97.7MiB/s (102MB/s), 97.7MiB/s-97.7MiB/s
(102MB/s-102MB/s), io=2930MiB (3072MB), run=30001-30001msec

Disk stats (read/write):
  nvme0n1: ios=0/766273, merge=0/766195, ticks=0/941966,
in_queue=407464, util=95.92%

Thanks & Regards,
Lokesh
