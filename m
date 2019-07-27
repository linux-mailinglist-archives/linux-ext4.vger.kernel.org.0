Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E263775C7
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2019 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfG0B5c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Jul 2019 21:57:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40750 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfG0B5c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Jul 2019 21:57:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so25327620pla.7
        for <linux-ext4@vger.kernel.org>; Fri, 26 Jul 2019 18:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x4iGfMpkuoKC1OzN+Z0YIPxldZuXMXQG63cSgAToPlI=;
        b=Ml9PKHfV+zPW9QkmovWfil6GsdtCPW1yCedtLfaQNKB+sTxs3nXdMrHGeay5JZBcR+
         HQnX70C87syTFAgkq4aBbi9txcaFRM319UijFdtuVb+LF4EV40/M9/aAAI0t9UxqDJeG
         oLFm/UzcZWbWDmS9w5fvtt0qmNUnO/t8AzY0YxOnZA0frIchQ0M5mSGVyHzi3p7SHME8
         Ad4+/rHeVnMgupWXa7IWvTkJb3U8tBk+Stic6zqK564SmjFojfOgD7C9ZyL1rCWt+YTp
         Oy+lk17juwPtNE1aFnAF3xmP/cWMM+eNczajq+R+Hea2rljgltqOUExZLfCgSby4OC9J
         5g1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x4iGfMpkuoKC1OzN+Z0YIPxldZuXMXQG63cSgAToPlI=;
        b=pKjx3GeKHgtEO1anWAYi8uL+TeprllpTjOk/ZRDS+Eo4+qhcJPvn2WWBiqSuVhcGre
         aCwMJDEiR9q2KsgVLk30gIwuCvvoldtYuTxg2SyJBTKCWMcPvkYnPehkoCA8lETSd8H7
         zE6JbWFtmKEHHIyGz1N+HghzBz+qoi5DAIAEm4FMdBiZICTfPjD3jLThM89/uA2fe318
         H+uwF7jTfMFC/pXTnrsBh9SO1dhwcIMwqINsB3ZMHGWEWH8d+TMh8RQw18WO2YUX6ieq
         rnUSeUjsiFctVbxE0JiXN6MHaI8sEqD3tzMvTM5Qa8Zj3Geq/w5hAdXrNacwZjKcVAqp
         E0dg==
X-Gm-Message-State: APjAAAU5NYg6KJFEHmic1yoSe3KGdTlblyw98H/74/8EVXxI4TgrRFFK
        J9QB+FAUf+XW04dQvsHm+NMrI5XRFrw=
X-Google-Smtp-Source: APXvYqz5p6hKsct0BBZVdczMFF3EEn/IovRNFuMKFeNMfvSM1P30tiIOsWNHYxKaHXXoUpduWlV5Ew==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr99488989plq.127.1564192651645;
        Fri, 26 Jul 2019 18:57:31 -0700 (PDT)
Received: from ?IPv6:2605:8d80:403:498a:85bb:86a3:3e9e:4e96? ([2605:8d80:403:498a:85bb:86a3:3e9e:4e96])
        by smtp.gmail.com with ESMTPSA id t26sm42207740pgu.43.2019.07.26.18.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 18:57:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO reads"
From:   Andreas Dilger <adilger@dilger.ca>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <15112e38-94fe-39d6-a8e2-064ff47187d5@linux.alibaba.com>
Date:   Fri, 26 Jul 2019 19:57:29 -0600
Cc:     Joseph Qi <jiangqi903@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7FF6ED7-D480-4B01-A812-E100D595C515@dilger.ca>
References: <ab7cf51b-6b52-d151-e22c-6f4400a14589@linux.alibaba.com> <29d50d24-f8e7-5ef4-d4d8-3ea6fb1c6ed3@gmail.com> <6DADA28C-542F-45F6-ADB0-870A81ABED23@dilger.ca> <15112e38-94fe-39d6-a8e2-064ff47187d5@linux.alibaba.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It would be useful to post some details about your test hardware
(eg. HDD vs. SSD, CPU cores+speed, RAM), so that it is possible to make
a good comparison of someone sees different results.=20

Cheers, Andreas

> On Jul 25, 2019, at 19:12, Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
>=20
>=20
>=20
>> On 19/7/26 05:20, Andreas Dilger wrote:
>>=20
>>> On Jul 23, 2019, at 5:17 AM, Joseph Qi <jiangqi903@gmail.com> wrote:
>>>=20
>>> Hi Ted & Jan,
>>> Could you please give your valuable comments?
>>=20
>> It seems like the original patches should be reverted?  There is no data
>=20
> =46rom my test result, yes.
> I've also tested libaio with iodepth 16, it behaves the same. Here is the t=
est
> data for libaio 4k randrw:
>=20
> --------------------------------------------------------------------------=
-----------------
> w/ parallel dio reads | READ 78313KB/s, 19578, 1698.70us  | WRITE 78313KB/=
s, 19578, 4837.60us
> --------------------------------------------------------------------------=
-----------------
> w/o parallel dio reads| READ 387774KB/s, 96943, 1009.73us | WRITE 387656KB=
/s=EF=BC=8C96914, 308.87us
> --------------------------------------------------------------------------=
-----------------
>=20
> Since this commit went into upstream long time ago=EF=BC=8Cto be precise, L=
inux
> 4.9, I wonder if someone else has also observed this regression, or
> anything I missed?
>=20
> Thanks,
> Joseph
>=20
>> in the original commit message that indicates there is an actual performa=
nce
>> improvement from that patch, but there is data here showing it hurts both=

>> read and write performance quite significantly.
>>> Cheers, Andreas
>>=20
>>>> On 19/7/19 17:22, Joseph Qi wrote:
>>>> Hi Ted & Jan,
>>>> I've observed an significant performance regression with the following
>>>> commit in my Intel P3600 NVMe SSD.
>>>> 16c54688592c ext4: Allow parallel DIO reads
>>>>=20
>>>> =46rom my initial investigation, it may be because of the
>>>> inode_lock_shared (down_read) consumes more than inode_lock (down_write=
)
>>>> in mixed random read write workload.
>>>>=20
>>>> Here is my test result.
>>>>=20
>>>> ioengine=3Dpsync
>>>> direct=3D1
>>>> rw=3Drandrw
>>>> iodepth=3D1
>>>> numjobs=3D8
>>>> size=3D20G
>>>> runtime=3D600
>>>>=20
>>>> w/ parallel dio reads : kernel 5.2.0
>>>> w/o parallel dio reads: kernel 5.2.0, then revert the following commits=
:
>>>> 1d39834fba99 ext4: remove EXT4_STATE_DIOREAD_LOCK flag (related)
>>>> e5465795cac4 ext4: fix off-by-one error when writing back pages before d=
io read (related)
>>>> 16c54688592c ext4: Allow parallel DIO reads
>>>>=20
>>>> bs=3D4k:
>>>> -----------------------------------------------------------------------=
--------------------
>>>> w/ parallel dio reads | READ 30898KB/s, 7724, 555.00us   | WRITE 30875K=
B/s, 7718, 479.70us
>>>> -----------------------------------------------------------------------=
--------------------
>>>> w/o parallel dio reads| READ 117915KB/s, 29478, 248.18us | WRITE 117854=
KB/s=EF=BC=8C29463, 21.91us
>>>> -----------------------------------------------------------------------=
--------------------
>>>>=20
>>>> bs=3D16k:
>>>> -----------------------------------------------------------------------=
--------------------
>>>> w/ parallel dio reads | READ 58961KB/s, 3685, 835.28us   | WRITE 58877K=
B/s, 3679, 1335.98us
>>>> -----------------------------------------------------------------------=
--------------------
>>>> w/o parallel dio reads| READ 218409KB/s, 13650, 554.46us | WRITE 218257=
KB/s=EF=BC=8C13641, 29.22us
>>>> -----------------------------------------------------------------------=
--------------------
>>>>=20
>>>> bs=3D64k:
>>>> -----------------------------------------------------------------------=
--------------------
>>>> w/ parallel dio reads | READ 119396KB/s, 1865, 1759.38us | WRITE 119159=
KB/s, 1861, 2532.26us
>>>> -----------------------------------------------------------------------=
--------------------
>>>> w/o parallel dio reads| READ 422815KB/s, 6606, 1146.05us | WRITE 421619=
KB/s, 6587, 60.72us
>>>> -----------------------------------------------------------------------=
--------------------
>>>>=20
>>>> bs=3D512k:
>>>> -----------------------------------------------------------------------=
--------------------
>>>> w/ parallel dio reads | READ 392973KB/s, 767, 5046.35us  | WRITE 393165=
KB/s, 767, 5359.86us
>>>> -----------------------------------------------------------------------=
--------------------
>>>> w/o parallel dio reads| READ 590266KB/s, 1152, 4312.01us | WRITE 590554=
KB/s, 1153, 2606.82us
>>>> -----------------------------------------------------------------------=
--------------------
>>>>=20
>>>> bs=3D1M:
>>>> -----------------------------------------------------------------------=
--------------------
>>>> w/ parallel dio reads | READ 487779KB/s, 476, 8058.55us  | WRITE 485592=
KB/s, 474, 8630.51us
>>>> -----------------------------------------------------------------------=
--------------------
>>>> w/o parallel dio reads| READ 593927KB/s, 580, 7623.63us  | WRITE 591265=
KB/s, 577, 6163.42us
>>>> -----------------------------------------------------------------------=
--------------------
>>>>=20
>>>> Thanks,
>>>> Joseph
>>>>=20
>>=20
>>=20
>> Cheers, Andreas
>>=20
>>=20
>>=20
>>=20
>>=20
