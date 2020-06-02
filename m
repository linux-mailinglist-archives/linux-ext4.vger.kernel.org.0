Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249981EBE0A
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jun 2020 16:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgFBOWx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jun 2020 10:22:53 -0400
Received: from forward106o.mail.yandex.net ([37.140.190.187]:48095 "EHLO
        forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbgFBOWx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jun 2020 10:22:53 -0400
Received: from mxback16o.mail.yandex.net (mxback16o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::67])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id B03145061F9F
        for <linux-ext4@vger.kernel.org>; Tue,  2 Jun 2020 17:22:45 +0300 (MSK)
Received: from iva8-6403930b9beb.qloud-c.yandex.net (iva8-6403930b9beb.qloud-c.yandex.net [2a02:6b8:c0c:2c9a:0:640:6403:930b])
        by mxback16o.mail.yandex.net (mxback/Yandex) with ESMTP id Df64CKSNGe-MjROulW3;
        Tue, 02 Jun 2020 17:22:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1591107765;
        bh=+6sBjw1zV10Pxi8GHizsig3uYEXOXcPn/f3EkvIe+ho=;
        h=In-Reply-To:To:From:Subject:References:Date:Message-ID;
        b=BHaUnomyqY8LvooXPUimq2YD7yMQthZu/cQMvuq3ICjxxFlwtQipUnqaXSNvdToV+
         fQ4KHHWJFl2IV8DJpf1xB0XIQvOpk2bddWBzW9ZQx15HH4uAFVzjzdYY0hFbi5tyiD
         o1Oh6qGVKIop6wiJDe1oPfPzErnaTavxqyyL+YV0=
Authentication-Results: mxback16o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva8-6403930b9beb.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id eUOQPVBxOL-MjWegx0I;
        Tue, 02 Jun 2020 17:22:45 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <0c296eebe57543724ada627f396385601495baf2.camel@yandex.ru>
Subject: Re: Changing a workload results in performance drop
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     linux-ext4@vger.kernel.org
Date:   Tue, 02 Jun 2020 17:22:39 +0300
In-Reply-To: <73a3416a-67d2-c494-1f3f-7d7789bdf61d@yandex.ru>
References: <73a3416a-67d2-c494-1f3f-7d7789bdf61d@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

So, FTR, I found on kernelnewbies that in linux 5.7 ext4 migrated to
iomap. Out of curiousity I rerun the tests on 5.7. The problem is still
reproducible.

On Fri, 2020-04-24 at 17:56 +0300, Konstantin Kharlamov wrote:
> * SSDs are used in testing, so random access is not a concern. But I
> tried the
>    "steps to reproduce" with raw block device, and IOPS always holds
> 9k for me.
> * "Direct" IO is used to bypass file-system cache.
> * The issue is way less visible on XFS, so it looks specific to file
> systems.
> * The biggest difference I've seen is on 70% reads/30% writes
> workload. But for
>    simplicity in "steps to reproduce" I'm using 100% write.
> * it seems over time (perhaps a day) performance gets improved, so
> for best
>    results when testing that you need to re-create ext4 anew.
> * in "steps to reproduce" I grep fio stdout. That suppresses
> interactive
>    output. Interactive output may be interesting though, I've often
> seen workload
>    drops to 600-700 IOPS while average was 5-6k
> * Original problem I worked with 
> https://github.com/openzfs/zfs/issues/10231
> 
> # Steps to reproduce (in terms of terminal commands)
> 
>      $ cat fio_jobfile
>      [job-section]
>      name=temp-fio
>      bs=8k
>      ioengine=libaio
>      rw=randrw
>      rwmixread=0
>      rwmixwrite=100
>      filename=/mnt/test/file1
>      iodepth=1
>      numjobs=1
>      group_reporting
>      time_based
>      runtime=1m
>      direct=1
>      filesize=4G
>      $ mkfs.ext4 /dev/sdw1
>      $ mount /dev/sdw1 /mnt/test
>      $ truncate -s 100G /mnt/test/file1
>      $ fio fio_jobfile | grep -i IOPS
>        write: IOPS=12.5k, BW=97.0MiB/s (103MB/s)(5879MiB/60001msec)
>         iops        : min=10966, max=14730, avg=12524.20,
> stdev=1240.27, samples=119
>      $ sed -i 's/4G/100G/' fio_jobfile
>      $ fio fio_jobfile | grep -i IOPS
>        write: IOPS=5880, BW=45.9MiB/s (48.2MB/s)(2756MiB/60001msec)
>         iops        : min= 4084, max= 6976, avg=5879.31,
> stdev=567.58, samples=119
> 
> ## Expected
> 
> Performance should be more or less the same
> 
> ## Actual
> 
> The second test is twice as slow
> 
> # Versions
> 
> * Kernel version: 5.6.2-050602-generic
> 
> It seems however that the problem is present at least in 4.19 and
> 5.4. as well, so not a regression.

