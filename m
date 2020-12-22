Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38102E1027
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 23:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgLVWZN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 17:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgLVWZN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Dec 2020 17:25:13 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51406C061793
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 14:24:33 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z21so9298012pgj.4
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 14:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=g6heK/OyqEMPDWZQSKHHTBg8zTvegaPfuv+fBDhTlIA=;
        b=Y8dg4MNp6eKuCCsICytsW6muIbjkqUI/sBhTM0B2Cp0N73p7RH1mpjqvgsmN65LlxG
         cj+mil5whfDljDt8XcVIW2wRZDKTKFHqlNtJmqnttjWB38yYU4Gh6f7znbppxfbU4RaM
         Yz8iAMm+wJGwKENY0TE/bzCDtUgr0BnxBnvwHBUwj+CbcU6p1KZGB6/+//SxlrAHxFca
         FQI8fZlF5aIuxputVjjHsuiqyzCfS7wdGUU06Ay7aqg0ha6lXDNSa27X1Q5kZQzHA2FG
         E4ncjbrOXtnuLQ+C71TMuxI+/uAVgFci5TVKWV3ue8FqyIkwikeQTjzbb+FkuNv3Qn9l
         YmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=g6heK/OyqEMPDWZQSKHHTBg8zTvegaPfuv+fBDhTlIA=;
        b=TDXwPEleAkk3QsckYABbnEvR8o+x7y/ko8FMm4cjh7neAeafSrzW35XDjOqF6Zu8hU
         Qt+I+LAOPYt7KTDKxnkG4+oblkFyPvPbiG920Pa/s/QZgTP/8l6WfYv70+89sX+r1UNo
         SV5XIgvRbbXN7hiehGJ1yKP6miYUYEc6b8a/QvSrvd+c0vWy47bQQnOA2IaFtqFoU3pe
         HCloR0a/GBKi5sIfGqT29XmR2yL+RhJG0r8kBcDbtaxAUyP0qBXhTGyLPQ9E3/WseLPt
         KCpslwfxGno2oxc9seMcAfeSzCJnkWXdQS6OBBnV5JOC75o30da9mnUsN09ZVvZxWxbE
         qkkA==
X-Gm-Message-State: AOAM530+9+3RSR+NMEUWXwiQEJ5CDN4gbdOdvcf5rTofOWUdxxAwD4HZ
        jQ4C+kLyIlyuj83C6rZkT/Fm3BXFQ2ryYCDj
X-Google-Smtp-Source: ABdhPJyq/Bl14eFHB1EukMnUZnANVhyxWpmSVw8SIyCCdOWiLi2p56YKry7jA6UyAQEKqlzdO+bcOg==
X-Received: by 2002:a65:5547:: with SMTP id t7mr21873077pgr.50.1608675872750;
        Tue, 22 Dec 2020 14:24:32 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id b129sm19477988pgc.52.2020.12.22.14.24.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 14:24:31 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <0D219223-7CE9-4441-9F14-0125023ED969@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_252EE0FA-539C-4807-BA38-045700D85A1D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: improved performance in case of data journaling
Date:   Tue, 22 Dec 2020 15:24:29 -0700
In-Reply-To: <20201222174729.GD22832@quack2.suse.cz>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>,
        lokesh jaliminche <lokesh.jaliminche@gmail.com>
References: <CAKJOkCoUGPctXEcJWZFo+d62CSBmYjxFr1D0j74OY2ijynMyUA@mail.gmail.com>
 <1870131.usQuhbGJ8B@merkaba>
 <CAKJOkCrBMhLKZjp4=1KJv3uY+xFBN0KEjDx_ix=88xr0oegD+w@mail.gmail.com>
 <20201222174729.GD22832@quack2.suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_252EE0FA-539C-4807-BA38-045700D85A1D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Dec 22, 2020, at 10:47 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Hi!
>=20
> On Thu 03-12-20 01:07:51, lokesh jaliminche wrote:
>> Hi Martin,
>>=20
>> thanks for the quick response,
>>=20
>> Apologies from my side, I should have posted my fio job description
>> with the fio logs
>> Anyway here is my fio workload.
>>=20
>> [global]
>> filename=3D/mnt/ext4/test
>> direct=3D1
>> runtime=3D30s
>> time_based
>> size=3D100G
>> group_reporting
>>=20
>> [writer]
>> new_group
>> rate_iops=3D250000
>> bs=3D4k
>> iodepth=3D1
>> ioengine=3Dsync
>> rw=3Drandomwrite
>> numjobs=3D1
>>=20
>> I am using Intel Optane SSD so it's certainly very fast.
>>=20
>> I agree that delayed logging could help to hide the performance
>> degradation due to actual writes to SSD. However as per the iostat
>> output data is definitely crossing the block layer and since
>> data journaling logs both data and metadata I am wondering why
>> or how IO requests see reduced latencies compared to metadata
>> journaling or even no journaling.
>>=20
>> Also, I am using direct IO mode so ideally, it should not be using =
any type
>> of caching. I am not sure if it's applicable to journal writes but =
the whole
>> point of journaling is to prevent data loss in case of abrupt =
failures. So
>> caching journal writes may result in data loss unless we are using =
NVRAM.
>=20
> Well, first bear in mind that in data=3Djournal mode, ext4 does not =
support
> direct IO so all the IO is in fact buffered. So your random-write =
workload
> will be transformed to semilinear writeback of the page cache pages. =
Now
> I think given your SSD storage this performs much better because the
> journalling thread commiting data will drive large IOs (IO to the =
journal
> will be sequential) and even when the journal is filled and we have to
> checkpoint, we will run many IOs in parallel which is beneficial for =
SSDs.
> Whereas without data journalling your fio job will just run one IO at =
a
> time which is far from utilizing full SSD bandwidth.
>=20
> So to summarize you see better results with data journalling because =
you in
> fact do buffered IO under the hood :).

IMHO that is one of the benefits of data=3Djournal in the first place, =
regardless
of whether the journal is NVMe or HDD - that it linearizes what would =
otherwise
be a random small-block IO workload to be much friendlier to the =
storage.  As
long as it maintains the "written to stable storage" semantic for =
O_DIRECT, I
don't think it is a problem that the data is copied or not.  Even =
without the
use of data=3Djournal, there are still some code paths that copy =
O_DIRECT writes.

Ideally, being able to dynamically/automatically change between =
data=3Djournal
and data=3Dordered depending on the IO workload (e.g. large writes go =
straight
to their allocated blocks, small writes go into the journal) would be =
the best
of both worlds.  High "IOPS" for workloads that need it (even on HDD), =
without
overwhelming the journal device bandwidth with large streaming writes.

This would tie in well with the proposed SMR patches, which allow a very =
large
journal device to (essentially) transform ext4 into a log-structured =
filesystem
by allowing journal shadow buffers to be dropped from memory rather than =
being
pinned in RAM:

https://github.com/tytso/ext4-patch-queue/blob/master/series
=
https://github.com/tytso/ext4-patch-queue/blob/master/jbd2-dont-double-bum=
p-transaction-number
=
https://github.com/tytso/ext4-patch-queue/blob/master/journal-superblock-c=
hanges
=
https://github.com/tytso/ext4-patch-queue/blob/master/add-journal-no-clean=
up-option
=
https://github.com/tytso/ext4-patch-queue/blob/master/add-support-for-log-=
metadata-block-tracking-in-log
=
https://github.com/tytso/ext4-patch-queue/blob/master/add-indirection-to-m=
etadata-block-read-paths
https://github.com/tytso/ext4-patch-queue/blob/master/cleaner
=
https://github.com/tytso/ext4-patch-queue/blob/master/load-jmap-from-journ=
al
https://github.com/tytso/ext4-patch-queue/blob/master/disable-writeback
=
https://github.com/tytso/ext4-patch-queue/blob/master/add-ext4-journal-laz=
y-mount-option


Having a 64GB-256GB NVMe device for the journal and handling most of the =
small
IO directly to the journal, and only periodically flushing to the =
filesystem to
HDD would really make those SMR disks more usable, since they are =
starting to
creep into consumer/NAS devices, even when users aren't really aware of =
it:

=
https://blocksandfiles.com/2020/04/14/wd-red-nas-drives-shingled-magnetic-=
recording/

>> So questions come to my mind are
>> 1. why writes without journaling are having long latencies as =
compared to
>>    writes requests with metadata and data journaling?
>> 2. Since metadata journaling have relatively fewer journal writes =
than data
>>    journaling why writes with data journaling is faster than no =
journaling and
>>    metadata journaling mode?
>> 3. If there is an optimization that allows data journaling to be so =
fast
>>    without any risk of data loss, why the same optimization is not =
used in case
>>    of metadata journaling?
>>=20
>> On Thu, Dec 3, 2020 at 12:20 AM Martin Steigerwald =
<martin@lichtvoll.de> wrote:
>>>=20
>>> lokesh jaliminche - 03.12.20, 08:28:49 CET:
>>>> I have been doing experiments to analyze the impact of data =
journaling
>>>> on IO latencies. Theoretically, data journaling should show long
>>>> latencies as compared to metadata journaling. However, I observed
>>>> that when I enable data journaling I see improved performance. Is
>>>> there any specific optimization for data journaling in the write
>>>> path?
>>>=20
>>> This has been discussed before as Andrew Morton found that data
>>> journalling would be surprisingly fast with interactive write =
workloads.
>>> I would need to look it up in my performance training slides or use
>>> internet search to find the reference to that discussion again.
>>>=20
>>> AFAIR even Andrew had no explanation for that. So I thought why =
would I
>>> have one? However an idea came to my mind: The journal is a =
sequential
>>> area on the disk. This could help with harddisks I thought at least =
if
>>> if it I/O mostly to the same not too big location/file =E2=80=93 as =
you did not
>>> post it, I don't know exactly what your fio job file is doing. =
However the
>>> latencies you posted as well as the device name certainly point to =
fast
>>> flash storage :).
>>>=20
>>> Another idea that just came to my mind is: AFAIK ext4 uses quite =
some
>>> delayed logging and relogging. That means if a block in the journal =
is
>>> changed another time within a certain time frame Ext4 changes it in
>>> memory before the journal block is written out to disk. Thus if the =
same
>>> block if overwritten again and again in short time, at least some of =
the
>>> updates would only happen in RAM. That might help latencies even =
with
>>> NVMe flash as RAM usually still is faster.
>>>=20
>>> Of course I bet that Ext4 maintainers have a more accurate or =
detailed
>>> explanation than I do. But that was at least my idea about this.
>>>=20
>>> Best,
>>> --
>>> Martin
>>>=20
>>>=20
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Cheers, Andreas






--Apple-Mail=_252EE0FA-539C-4807-BA38-045700D85A1D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/ich4ACgkQcqXauRfM
H+A6OxAAnuzXn+erv38wxhJNupub5upcQopUbxPNLGIX+/ocIYyl9oasfTSjxc7s
maXlbAUCfv2DiRRQTfCEzpbPD/XCpFSVhiH6cwEwvOtR5Xt5G1sHlnz/W+C4Ezvj
Dx2oejTiLQ3XVkv/5J3ZCuCRY30zbuhLIV3CydBRoU3tJ0DqHaTGb88UvNLMdlmt
Ub8cAUu4lIJK9pi4CwTpeAParWFOWWgZX7LAWFsUdFpra3HZUHNEPMZ5lo4jY0i5
iQg3n3uZnjBZSswg1uZbgRXGCkjBEV/FRSNi5bNZ1MmL6RSg6A5VBowUKW9d0pdH
XoFrQAG8aM7Au/3Ee3dincZfFqZDw+Pp8q+rk6svRdOrdWDvbuo93qK8pUbnqnKQ
ADscdAae5IcqkxpF5sSFZdoTKp3u1a6rRr7svkbTbsf1W1smyQAFf9PBVN+jzAXj
HO+cltlCl/vKThdI3XF0InpcNr3j89AktWl7DhVwgkEh9o1l+ApoXzwyURFMg0jH
eTd3Y/Voo9JJx7PUN1yJ+1xZOFqTNSTroE4uESKOEc3IieFjBI2tiRT52q6eqcHd
DtshyiWeIQzGFUg/3YASNXPdzDhPV1Ve9TS80N8mzeRwgXB4E1TzEC/dPW40VmK+
wyZQPlotYXNtA0heAcCT2zlFW2dbYvUY1KYRlaILmhlYjeXEf24=
=8uQl
-----END PGP SIGNATURE-----

--Apple-Mail=_252EE0FA-539C-4807-BA38-045700D85A1D--
