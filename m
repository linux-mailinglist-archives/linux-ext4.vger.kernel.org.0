Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBEA3577D1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 00:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhDGWhD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhDGWhC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Apr 2021 18:37:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA253C061760
        for <linux-ext4@vger.kernel.org>; Wed,  7 Apr 2021 15:36:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m11so353928pfc.11
        for <linux-ext4@vger.kernel.org>; Wed, 07 Apr 2021 15:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=mtiLq11rvXOypKr5/WiEBWxlkOAL81cGhZEFuqMThGY=;
        b=fEx02NLgQrLsbvvpFvZkuvPMwHSGCv4XAOLIRTW9SIx5PQsOt8vKon1/lR7U1XRjD6
         stKDqSKs0coBrtFAbS2t+GemSZ6pKhYuZNM+3sir558bv6/9p1C7vZHmmpXRm6xe7Wwm
         viEuLl4qt+q3iKaj1GYkqsOtBKYbFBnmzi92UbNHIy0EAbpLv/WEUV5V1s/kQmBVGFeK
         Jz+KbJi0QnbAJFmFByCCt3n7CUcbpC5fN6M0AL/oakvwCS6L6nSQ76ejmByQObmUNujW
         KSw++qB8ANqobgVmH8QgKnEBBI76188Dma6Vsal1ivogvzrzHBFHvABBPxU79/2tBqwc
         4foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=mtiLq11rvXOypKr5/WiEBWxlkOAL81cGhZEFuqMThGY=;
        b=sFLRZEnWrxjWKKeKWj6NirizI82RfPdNdD0b+Uio3EDgfZQlXeM+Rb1odcEs3BFs4N
         QQtYuPuAKgYkiKXkdVFj7gLmwTXS/QoGNfkH2XnZgcvU5sEsmVscAkhnzExoa7/XG96Y
         Y//X8JtUsGKS2BRGh8zWubsSu0WgFJT8uhncDuR1ITWK7dj6XNs8ZBL/r8U7OZEKBDBn
         OSaYp8JPAF6V41Tkh2HbVUyQxfjsiPirTfHZ1RC6SmhYnDGwz8cj2ZWblU1IhCQ3hlNo
         Pki/1LqIsWkVsWnuKjhDDikI+zWcKlWZEAbYCmXMd1PyxUmE4gftgbO7WDCjWkNDK73C
         DGYA==
X-Gm-Message-State: AOAM53097EtH5bG6ixC7ep6iFw2kQIbKK/Q/Fdbh8YtJn8R3ermiIQ5A
        2T0emfiNa3dlZEylDkAy7lC/xg==
X-Google-Smtp-Source: ABdhPJwJEsHpQiF5VzHJ3GUQFSOtzzNCKVOnTRIlV5C/uuDmYzS34/kpl8mB4k83zOBxywYDgGwAMQ==
X-Received: by 2002:a62:7f45:0:b029:205:9617:a819 with SMTP id a66-20020a627f450000b02902059617a819mr4703232pfd.17.1617835012173;
        Wed, 07 Apr 2021 15:36:52 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id o13sm22637065pfp.26.2021.04.07.15.36.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 15:36:51 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F2742231-ADEB-4FDF-8A92-DD800AE2EDF1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E8BF602C-24E6-4AB1-92A3-E71AF129E7E0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: add a configurable parameter to prevent endless
 loop in ext4_mb_discard_group_preallocations
Date:   Wed, 7 Apr 2021 16:36:47 -0600
In-Reply-To: <20210407111647.5cmknwltwl2rfvmu@riteshh-domain>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        riteshh <riteshh@linux.ibm.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Baoyou Xie <baoyou.xie@alibaba-inc.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
To:     Wen Yang <simon.wy@alibaba-inc.com>
References: <20210407070141.49253-1-wenyang@linux.alibaba.com>
 <20210407111647.5cmknwltwl2rfvmu@riteshh-domain>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E8BF602C-24E6-4AB1-92A3-E71AF129E7E0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 7, 2021, at 5:16 AM, riteshh <riteshh@linux.ibm.com> wrote:
>=20
> On 21/04/07 03:01PM, Wen Yang wrote:
>> From: Wen Yang <simon.wy@alibaba-inc.com>
>>=20
>> The kworker has occupied 100% of the CPU for several days:
>> PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
>> 68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11
>>=20
>> And the stack obtained through sysrq is as follows:
>> [20613144.850426] task: ffff8800b5e08000 task.stack: ffffc9001342c000
>> [20613144.850438] Call Trace:
>> [20613144.850439]  [<ffffffffa0244209>] =
ext4_mb_new_blocks+0x429/0x550 [ext4]
>> [20613144.850439]  [<ffffffffa02389ae>] =
ext4_ext_map_blocks+0xb5e/0xf30 [ext4]
>> [20613144.850441]  [<ffffffffa0204b52>] ext4_map_blocks+0x172/0x620 =
[ext4]
>> [20613144.850442]  [<ffffffffa0208675>] ext4_writepages+0x7e5/0xf00 =
[ext4]
>> [20613144.850443]  [<ffffffff811c487e>] do_writepages+0x1e/0x30
>> [20613144.850444]  [<ffffffff81280265>] =
__writeback_single_inode+0x45/0x320
>> [20613144.850444]  [<ffffffff81280ab2>] =
writeback_sb_inodes+0x272/0x600
>> [20613144.850445]  [<ffffffff81280ed2>] =
__writeback_inodes_wb+0x92/0xc0
>> [20613144.850445]  [<ffffffff81281238>] wb_writeback+0x268/0x300
>> [20613144.850446]  [<ffffffff812819f4>] wb_workfn+0xb4/0x380
>> [20613144.850447]  [<ffffffff810a5dc9>] process_one_work+0x189/0x420
>> [20613144.850447]  [<ffffffff810a60ae>] worker_thread+0x4e/0x4b0
>>=20
>> The cpu resources of the cloud server are precious, and the server
>> cannot be restarted after running for a long time, so a configuration
>> parameter is added to prevent this endless loop.
>=20
> Strange, if there is a endless loop here. Then I would definitely see
> if there is any accounting problem in pa->pa_count. Otherwise busy=3D1
> should not be set everytime. ext4_mb_show_pa() function may help debug =
this.
>=20
> If yes, then that means there always exists either a file =
preallocation
> or a group preallocation. Maybe it is possible, in some use case.
> Others may know of such use case, if any.

If this code is broken, then it doesn't make sense to me that we would
leave it in the "run forever" state after the patch, and require a sysfs
tunable to be set to have a properly working system?

Is there anything particularly strange about the workload/system that
might cause this?  Filesystem is very full, memory is very low, etc?


Cheers, Andreas






--Apple-Mail=_E8BF602C-24E6-4AB1-92A3-E71AF129E7E0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBuNAAACgkQcqXauRfM
H+BlWQ//VA+WPUb9mnx0PLVODhTyol/AXVQsqOIDXVNLquC9QEHFhJAK/kX/oN/7
Mc46bS621YgVogJy6dpTUj08GuOpgW1gN7oqxrzIyw0crFYAX3S1D0808uRdwRLF
6NE/Yq/uRvk1rCSypSM1E/ZNtLaIGt6JkVOGIlUoW5IQ3saoBYdmGEGw0ZAaEywF
84DGHt5/9gKD6UA405H72mvlF7Dg0s6DOLiIKVAb/uaccPb/qSJ55+HEiTpeQgIL
n09MAI+qfuKlShaMM5BAM2WvScZlIqtC8G7W1/4ogrfdx5s6W4F5tgj9oSQHUtc+
jWFiQYwrC/M785xR7usMUCx10KW3f7hDOuyo5KEXHVWSEPnQYJy1WG+XCGrEH0aL
L7Vivk6PEDC1YIS0qCS2lQXzY7GnbYjLhC8Tl8QVxrUJq9Aa/+0Xr2r6F3rtmQ7H
ZN3cC8EZYLkO0u8mgt4o9jcWtUL5VcrrU6o0ZQQPUXjxLG1hePlXoIwd+RGSyQlg
S5RiZVMenRFN5EG2qlrV4mO3NBpqPe0mODpNQ6H/4M17Fd8VOCSta3Q6X9MORpCz
ycB0KpB/nBWi1P0PmRq8upDwmYrmMlYqtIWQKq/A8vMroFAkdb1cnVrnv3hmR73v
DHLZvBTJXlLCYF2kNq6PQ3GS/T+CaWg9uFjRSmNOLJWatBc3+hs=
=jAQi
-----END PGP SIGNATURE-----

--Apple-Mail=_E8BF602C-24E6-4AB1-92A3-E71AF129E7E0--
