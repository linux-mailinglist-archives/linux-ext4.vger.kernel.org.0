Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2F2E0C4B
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 16:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgLVPAr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 10:00:47 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36950 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgLVPAr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Dec 2020 10:00:47 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by linux.microsoft.com (Postfix) with ESMTPSA id 178F320B83F2
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 07:00:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 178F320B83F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608649206;
        bh=g2nqEd4zB/hia2SJ/pN+xDzNDNvXoQaBzRotn2NR0KM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f09XEQCav3Dr/yGa4NwdeUYq+OHS6J8zus/uYtCNVLzW+S12LpdGorHUWZZzdk49T
         Q2bZo4YjoXyGEX587pO7618dYgeRF+DRiBS9F9AAuq7/GAGH3R2mESYG8EGx9GizvV
         SyeeFIhg7YkE588+B9wNXnhhgTvhJreybmiq/pWo=
Received: by mail-pj1-f46.google.com with SMTP id m5so1471572pjv.5
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 07:00:05 -0800 (PST)
X-Gm-Message-State: AOAM533qOb/RdSiHUcwtjxFpyaZUf3txoUAV8ntjEWvgu4uo+dA9Aa9Z
        +CGx0pxynFy4rtgerVzS3VCtsZsOz97ErClU/JQ=
X-Google-Smtp-Source: ABdhPJxXTurWCUjnV8uTqbKZrrUcCXpInu0NNhB4mPb9lF26EUIAzYqBWIo0xkHGV9iUexNzaHqDCbn+ik1rOme0z3w=
X-Received: by 2002:a17:902:7d84:b029:db:feae:425e with SMTP id
 a4-20020a1709027d84b02900dbfeae425emr21488714plm.43.1608649205620; Tue, 22
 Dec 2020 07:00:05 -0800 (PST)
MIME-Version: 1.0
References: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
 <X+AQxkC9MbuxNVRm@mit.edu>
In-Reply-To: <X+AQxkC9MbuxNVRm@mit.edu>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 15:59:29 +0100
X-Gmail-Original-Message-ID: <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
Message-ID: <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
Subject: Re: discard and data=writeback
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 21, 2020 at 4:04 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> So that implies that your experiment may not be repeatable; did you
> make sure the file system was freshly reformatted before you wrote out
> the files in the directory you are deleting?  And was the directory
> written out in exactly the same way?  And did you make sure all of the
> writes were flushed out to disk before you tried timing the "rm -rf"
> command?  And did you make sure that there weren't any other processes
> running that might be issuing other file system operations (either
> data or metadata heavy) that might be interfering with the "rm -rf"
> operation?  What kind of storage device were you using?  (An SSD; a
> USB thumb drive; some kind of Cloud emulated block device?)
>

I got another machine with a faster NVME disk. I discarded the whole
drive before partitioning it, this drive is very fast in discarding
blocks:
# time blkdiscard -f /dev/nvme0n1p1

real    0m1.356s
user    0m0.003s
sys     0m0.000s

Also, the drive is pretty big compared to the dataset size, so it's
unlikely to be fragmented:

# lsblk /dev/nvme0n1
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
nvme0n1     259:0    0  1.7T  0 disk
=E2=94=94=E2=94=80nvme0n1p1 259:1    0  1.7T  0 part /media
# df -h /media
Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme0n1p1  1.8T  1.2G  1.7T   1% /media
# du -sh /media/linux-5.10/
1.1G    /media/linux-5.10/

I'm issuing sync + sleep(10) after the extraction, so the writes
should all be flushed.
Also, I repeated the test three times, with very similar results:

# dmesg |grep EXT4-fs
[12807.847559] EXT4-fs (nvme0n1p1): mounted filesystem with ordered
data mode. Opts: data=3Dordered,discard

# tar xf ~/linux-5.10.tar ; sync ; sleep 10
# time rm -rf linux-5.10/

real    0m1.607s
user    0m0.048s
sys     0m1.559s
# tar xf ~/linux-5.10.tar ; sync ; sleep 10
# time rm -rf linux-5.10/

real    0m1.634s
user    0m0.080s
sys     0m1.553s
# tar xf ~/linux-5.10.tar ; sync ; sleep 10
# time rm -rf linux-5.10/

real    0m1.604s
user    0m0.052s
sys     0m1.552s


# dmesg |grep EXT4-fs
[13133.953978] EXT4-fs (nvme0n1p1): mounted filesystem with writeback
data mode. Opts: data=3Dwriteback,discard

# tar xf ~/linux-5.10.tar ; sync ; sleep 10
# time rm -rf linux-5.10/

real    1m29.443s
user    0m0.073s
sys     0m2.520s
# tar xf ~/linux-5.10.tar ; sync ; sleep 10
# time rm -rf linux-5.10/

real    1m29.409s
user    0m0.081s
sys     0m2.518s
# tar xf ~/linux-5.10.tar ; sync ; sleep 10
# time rm -rf linux-5.10/

real    1m19.283s
user    0m0.068s
sys     0m2.505s

> Note that benchmarking the file system operations is *hard*.  When I
> worked with a graduate student working on a paper describing a
> prototype of a file system enhancement to ext4 to optimize ext4 for
> drive-managed SMR drives[1], the graduate student spent *way* more
> time getting reliable, repeatable benchmarks than making changes to
> ext4 for the prototype.  (It turns out the SMR GC operations caused
> variations in write speeds, which meant the writeback throughput
> measurements would fluctuate wildly, which then influenced the
> writeback cache ratio, which in turn massively influenced the how
> aggressively the writeback threads would behave, which in turn
> massively influenced the filebench and postmark numbers.)
>
> [1] https://www.usenix.org/conference/fast17/technical-sessions/presentat=
ion/aghayev
>

Interesting!

Cheers,
--=20
per aspera ad upstream
