Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3529D643
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfHZTKZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 15:10:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42353 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfHZTKY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Aug 2019 15:10:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so10457408plp.9
        for <linux-ext4@vger.kernel.org>; Mon, 26 Aug 2019 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=qrmH+smt4VAf9NhinKHxsxJtrJ1HsQlOtGxg68SZvRg=;
        b=Ki5Ogtk/3tO2nqWoNPYkAGwTGC83D04Zs8nz1GqLguwK7WYEBMcyMP+NZX2NnXPOL3
         sUHgzJ/VQoEJZEYbhSWXkr8lc0gxkRZkMTGGFPSG1wgvpoBly9zGc2hKWX7cYApQz7mE
         rO4jyha+NW6vCL4qybXEL2LiLQL7UXsJsGK/w1vp2iPE2Zzy7jmaOz0xuMhT/r4+0EhF
         3JDolRCflqIODFc7CUJW6hh6LZAOxx5xJYrI931P9tWW6+dzj+2MhpS50sgwO/XaNT2V
         IF89/KpvawYvCp60boRG+7P0oIAwE5dtifDRCSWvB5Axhyvpdxglw7RRDfo9EhgVF9FZ
         7doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=qrmH+smt4VAf9NhinKHxsxJtrJ1HsQlOtGxg68SZvRg=;
        b=M5PscHdUELMZy0jsVnq+dRqUI0s75gz+yaXbcrGKLF8xSrtuyakww/Jzub4D02zb/i
         rC2nuXbM7JI2WAuJIXqvbgcpimyQG13D45KLAK39JE1KYNPAdTZiLayKTtMqXpc8APOS
         4dQXRxCXED+nkC7gmSAoMGsqs4BpFfO5leiEoIwV0rDbuhpet1NwSM212yZZD1Wlmy6p
         N9rmEA5SCMTSq5MqzXIW7tkvJE0QXwMaF5l/XtZwPR0yJafXplnR7tH2Oh7r/AAduE5Y
         QQ4VqoyIQP8aWyUI7Ypn+1XjJib91VbJS+9TKFr2/69jaV/QLRl/BOwT0OMkYM3cmND1
         SsqA==
X-Gm-Message-State: APjAAAV2T8/rpnFiCdDU+J/5u6oHhXz8MVAbC8OUx/20/l41rl7yLzxO
        z5fPxWV/Gzu7dcxVveHIt2EvEQ==
X-Google-Smtp-Source: APXvYqwl9YBPCO1EwyAul2aHnvalS0Hw3R+/kSTvqp0omSZYr5GzJJMvLiYgz64WGCdLR4+AgfdErQ==
X-Received: by 2002:a17:902:8492:: with SMTP id c18mr20943186plo.279.1566846623790;
        Mon, 26 Aug 2019 12:10:23 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id o24sm27642174pfp.135.2019.08.26.12.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 12:10:20 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <94515D9C-045C-46EA-9F3C-E13CB2DAA1F9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_67190BBE-7632-492C-82B5-EEB2FFB17048";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
Date:   Mon, 26 Aug 2019 13:10:17 -0600
In-Reply-To: <20190826083958.GA10614@quack2.suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Joseph Qi <jiangqi903@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
To:     Jan Kara <jack@suse.cz>
References: <075fd06f-b0b4-4122-81c6-e49200d5bd17@linux.alibaba.com>
 <20190816145719.GA3041@quack2.suse.cz>
 <a8ddec64-d87c-ae7a-9b02-2f24da2396e9@linux.alibaba.com>
 <20190820160805.GB10232@mit.edu>
 <f89131c9-6f84-ac3c-b53c-d3d55887ea89@linux.alibaba.com>
 <20190822054001.GT7777@dread.disaster.area>
 <f0eb766f-3c04-2a53-1669-4088e09d8f73@linux.alibaba.com>
 <20190823101623.GV7777@dread.disaster.area>
 <707b1a60-00f0-847e-02f9-e63d20eab47e@linux.alibaba.com>
 <20190824021840.GW7777@dread.disaster.area>
 <20190826083958.GA10614@quack2.suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_67190BBE-7632-492C-82B5-EEB2FFB17048
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Aug 26, 2019, at 2:39 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Sat 24-08-19 12:18:40, Dave Chinner wrote:
>> On Fri, Aug 23, 2019 at 09:08:53PM +0800, Joseph Qi wrote:
>>>=20
>>>=20
>>> On 19/8/23 18:16, Dave Chinner wrote:
>>>> On Fri, Aug 23, 2019 at 03:57:02PM +0800, Joseph Qi wrote:
>>>>> Hi Dave,
>>>>>=20
>>>>> On 19/8/22 13:40, Dave Chinner wrote:
>>>>>> On Wed, Aug 21, 2019 at 09:04:57AM +0800, Joseph Qi wrote:
>>>>>>> Hi Ted=EF=BC=8C
>>>>>>>=20
>>>>>>> On 19/8/21 00:08, Theodore Y. Ts'o wrote:
>>>>>>>> On Tue, Aug 20, 2019 at 11:00:39AM +0800, Joseph Qi wrote:
>>>>>>>>>=20
>>>>>>>>> I've tested parallel dio reads with dioread_nolock, it
>>>>>>>>> doesn't have significant performance improvement and still
>>>>>>>>> poor compared with reverting parallel dio reads. IMO, this
>>>>>>>>> is because with parallel dio reads, it take inode shared
>>>>>>>>> lock at the very beginning in ext4_direct_IO_read().
>>>>>>>>=20
>>>>>>>> Why is that a problem?  It's a shared lock, so parallel
>>>>>>>> threads should be able to issue reads without getting
>>>>>>>> serialized?
>>>>>>>>=20
>>>>>>> The above just tells the result that even mounting with
>>>>>>> dioread_nolock, parallel dio reads still has poor performance
>>>>>>> than before (w/o parallel dio reads).
>>>>>>>=20
>>>>>>>> Are you using sufficiently fast storage devices that you're
>>>>>>>> worried about cache line bouncing of the shared lock?  Or do
>>>>>>>> you have some other concern, such as some other thread
>>>>>>>> taking an exclusive lock?
>>>>>>>>=20
>>>>>>> The test case is random read/write described in my first
>>>>>>> mail. And
>>>>>>=20
>>>>>> Regardless of dioread_nolock, ext4_direct_IO_read() is taking
>>>>>> inode_lock_shared() across the direct IO call.  And writes in
>>>>>> ext4 _always_ take the inode_lock() in ext4_file_write_iter(),
>>>>>> even though it gets dropped quite early when overwrite &&
>>>>>> dioread_nolock is set.  But just taking the lock exclusively
>>>>>> in write fro a short while is enough to kill all shared
>>>>>> locking concurrency...
>>>>>>=20
>>>>>>> from my preliminary investigation, shared lock consumes more
>>>>>>> in such scenario.
>>>>>>=20
>>>>>> If the write lock is also shared, then there should not be a
>>>>>> scalability issue. The shared dio locking is only half-done in
>>>>>> ext4, so perhaps comparing your workload against XFS would be
>>>>>> an informative exercise...
>>>>>=20
>>>>> I've done the same test workload on xfs, it behaves the same as
>>>>> ext4 after reverting parallel dio reads and mounting with
>>>>> dioread_lock.
>>>>=20
>>>> Ok, so the problem is not shared locking scalability ('cause
>>>> that's what XFS does and it scaled fine), the problem is almost
>>>> certainly that ext4 is using exclusive locking during
>>>> writes...
>>>>=20
>>>=20
>>> Agree. Maybe I've misled you in my previous mails.I meant shared
>>> lock makes worse in case of mixed random read/write, since we
>>> would always take inode lock during write.  And it also conflicts
>>> with dioread_nolock. It won't take any inode lock before with
>>> dioread_nolock during read, but now it always takes a shared
>>> lock.
>>=20
>> No, you didn't mislead me. IIUC, the shared locking was added to the
>> direct IO read path so that it can't run concurrently with
>> operations like hole punch that free the blocks the dio read might
>> currently be operating on (use after free).
>>=20
>> i.e. the shared locking fixes an actual bug, but the performance
>> regression is a result of only partially converting the direct IO
>> path to use shared locking. Only half the job was done from a
>> performance perspective. Seems to me that the two options here to
>> fix the performance regression are to either finish the shared
>> locking conversion, or remove the shared locking on read and re-open
>> a potential data exposure issue...
>=20
> We actually had a separate locking mechanism in ext4 code to avoid =
stale
> data exposure during hole punch when unlocked DIO reads were running. =
But
> it was kind of ugly and making things complex. I agree we need to move =
ext4
> DIO path conversion further to avoid taking exclusive lock when we =
won't
> actually need it.

It seems to me that the right solution for the short term is to revert
the patch in question, since that appears to be incomplete, and =
reverting
it will restore the performance.  I haven't seen any comments posted =
with
a counter-example that the original patch actually improved performance,
or that reverting it will cause some other performance regression.

We can then leave implementing a more complete solution to a later =
kernel.

Cheers, Andreas






--Apple-Mail=_67190BBE-7632-492C-82B5-EEB2FFB17048
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1kLpkACgkQcqXauRfM
H+AqdRAAvZIM+JsxB7hX8P/f5WPRVLdNRfvizD55k8JsOmpN/i2PTlPG0fX3Neu5
P5QSoAd1tUGSou+q1+OOFgVVbe+IyjYDgbPGY3BCTN2BQqypCrD1Pz8ApFMEVb5j
WOYV0VScwiQi4YfS3M4lUGUsBt436r0HzK0hPdQq7+LqwDW3s+3QHKJ+E/V6/YQl
nFPIWSNcUjDt8pUI/4f16OVH1BtUefqor/XxcxJTql3shqQ4DQr67oXpSMqiJCmd
DcwDA75sMgMcifZidLSw3gjNIrnn4iVQ7ogTefLIXtu+5vefBilgC8bGZPtNx4DU
J3v4olAZx2msD8LDCmi6dxfiiIg+Xf45UVYa2H0ZpsaTD5/P1eIeqKAOEgYzHtYu
xVJWbw+mdq6MgMnlQlBoeBujO8hPj91CW5f6WcoPKPydmyIseK2TrH4Fw1dihP66
9SmREcWd+IXSZIrvRVMZRaSCFsA6yXUu7RVUe649dl12r9lyfaiweD8YEaZ225ar
yFuBEGCAu3BX3/FEmuTRrYIdlNNANB90OAMuexp6M8eUzoMMep6vi5MCqxs4YhWF
tAMEqLK2UO1LtwFBBqlb8cIe2PvVaPcEL6DBrMVwJpGcuE9fzZvzfU9s4dRkEIgT
tMyiOqtiQ6fskbTsT3RZC8qslDJCoGjNGw40d2jT3A6sW4zIT3c=
=FCnE
-----END PGP SIGNATURE-----

--Apple-Mail=_67190BBE-7632-492C-82B5-EEB2FFB17048--
