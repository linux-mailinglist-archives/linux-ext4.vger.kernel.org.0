Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07441552437
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Jun 2022 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343557AbiFTSug (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Jun 2022 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiFTSuf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Jun 2022 14:50:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24086559
        for <linux-ext4@vger.kernel.org>; Mon, 20 Jun 2022 11:50:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so6437812pjg.3
        for <linux-ext4@vger.kernel.org>; Mon, 20 Jun 2022 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=N7DPFV5t7axTYYuOVVs8C+HbHaM0eXTf3d4X3HWnGPU=;
        b=TaIaUUFjgqMng3VhTy7i5yBNW6BkhaQqfR7QYCDqWNfJCQTWHwSN47d4xYw13BhDFC
         KnZL3xObhoWvzLqdn5XyCU7QEo1A1JeYcYTdqHP9NSTGO2TmsMGlccjUdruy4KByMFlW
         l2xrts/nRE6EFtY/gKe6vHF0r6tq/XHdjcUWaBZ6+ShVYLgCtSRutuBYJJmxHxDBT6K3
         4OP3xtL4Lv6f9W9c47qM9LttiHFnnz5paTtChYHWI4OxSQ+L0iE6XtUzdZgnW8fwgqN4
         Ja91ZRsEkFNczoIZVzzqs1iPQOQIc0eUPq95li+KnnoL2BWMls+9NBW4qS5CGFSctr2c
         h8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=N7DPFV5t7axTYYuOVVs8C+HbHaM0eXTf3d4X3HWnGPU=;
        b=P0x4rgGUtGe65hbbFzkVQsJcbpvAJX1Ge1FfyjQjAbAILuumTWkZlD9HbeZyKJp7Eh
         RW5MmGrGPLnuHBXMzrhCoKWUDo2B+6gWFvKNLCkHumMFcik/MOko6hbLTM0YhoPhpEKX
         mNkwt1p03CTb4nIlzs27YFvyVFWlPF7fA/kYubGu6paCjQy7xA196hFyKpqH7RFp61LG
         kOZIVZD4Dv/n1a9dA5Bg6IcJCTkTaXWZZstTGI7oDrbMGLSw89D++fLI5XtSdBe/ckEh
         Htl9napvzJjl3XXdFd1KQWjeRIZo4E+N4dQKFxsryjLbLaM8tpJuwPFnaLe6nrA8lQ3p
         DH3A==
X-Gm-Message-State: AJIora+/gecbvDsV1GkkfPpudjA4UqvMNw4qDgGW50uDyTRwzuoLUS++
        fDb/DrM4UTf8aVEiaRLyztJipKt9HQGT0vyGrRE=
X-Google-Smtp-Source: AGRyM1ugP3yIAQ+K2J2wm7xh9ScceNHn9mGQPRD/p8Ak8ZIwaPriUVSz93hpy/jNmRVpnNiluvEO+Q==
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id s7-20020a170902988700b001516e1c7082mr24023291plp.162.1655751033033;
        Mon, 20 Jun 2022 11:50:33 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id m7-20020aa79007000000b0051bdb735647sm9444459pfo.159.2022.06.20.11.50.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:50:32 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <117682F9-5CEF-44F2-935E-E048C8A9D75D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5E6B2CB8-94ED-489A-AD93-C072147FD469";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Overwrite faster than fallocate
Date:   Mon, 20 Jun 2022 12:52:29 -0600
In-Reply-To: <CAGQ4T_J-43q5xszJK8yDTUt14NGjjQACK4Z1RST-ZQkju3xSzQ@mail.gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Santosh S <santosh.letterz@gmail.com>
References: <CAGQ4T_Jne-bxdP9rMNBzqXw16a4kD4FM=F5VuGgUbczj5WgCLA@mail.gmail.com>
 <Yqz8a0ggTjIU3h7T@mit.edu>
 <CAGQ4T_J-43q5xszJK8yDTUt14NGjjQACK4Z1RST-ZQkju3xSzQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5E6B2CB8-94ED-489A-AD93-C072147FD469
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 17, 2022, at 5:56 PM, Santosh S <santosh.letterz@gmail.com> wrote:
> 
> On Fri, Jun 17, 2022 at 6:13 PM Theodore Ts'o <tytso@mit.edu> wrote:
>> 
>> On Fri, Jun 17, 2022 at 12:38:20PM -0400, Santosh S wrote:
>>> Dear ext4 developers,
>>> 
>>> This is my test - preallocate a large file (2G) and then do sequential
>>> 4K direct-io writes to that file, with fdatasync after every write.
>>> I am preallocating using fallocate mode 0. I noticed that if the 2G
>>> file is pre-written rather than fallocate'd I get more than twice the
>>> throughput. I could reproduce this with fio. The storage is nvme.
>>> Kernel version is 5.3.18 on Suse.
>>> 
>>> Am I doing something wrong or is this difference expected? Any
>>> suggestion to get a better throughput without actually pre-writing the
>>> file.
>> 
>> This is, alas, expected.  The reason for this is because when you use
>> fallocate, the extent is marked as uninitialized, so that when you
>> read from the those newly allocated blocks, you don't see previously
>> written data belonging to deleted files.  These files could contain
>> someone else's e-mail, or medical information, etc.  So if we didn't
>> do this, it would be a walking, talking HIPPA or PCI violation.
>> 
>> So when you write to an fallocated region, and then call fdatasync(2),
>> we need to update the metadata blocks to clear the uninitialized bit
>> so that when you read from the file after a crash, you actually get
>> the data that was written.  So the fdatasync(2) operation is quite the
>> heavyweight operation, since it requries journal commit because of the
>> required metadata update.  When you do an overwrite, there is no need
>> to force a metadata update and journal update, which is why write(2)
>> plus fdatasync(2) is much lighter weight when you do an overwrite.
>> 
>> What enterprise databases (e.g., Oracle Enterprise Database and IBM's
>> Informix DB) tend to do is to use fallocate a chunk of space (say,
>> 16MB or 32MB), because for Legacy Unix OS's, this tends enable some
>> file system's block allocators to be more likely to allocate a
>> contiguous block range, and then immediate write zero's on that 16 or
>> 32MB, plus a fdatasync(2).  This fdatasync(2) would update the extent
>> tree once to make that 16MB or 32MB to be marked initialized to the
>> database's tablespace file, so you only pay the metadata update once,
>> instead of every few dozen kilobytes as you write each database commit
>> into the tablespace file.
>> 
>> There is also an old, out of tree patch which enables an fallocate
>> mode called "no hide stale", which marks the extent tree blcoks which
>> are allocated using fallocate(2) as initialized.  This substantially
>> speeds things up, but it is potentially a walking, talking, HIPPA or
>> PCI violation in that revealing previously written data is considered
>> a horrible security violation by most file system developers.
>> 
>> If you know, say, that a cluster file system is the only user of the
>> file system, and all data is written encrypted at rest using a
>> per-user key, such that exposing stale data is not a security
>> disaster, the "no hide stale" flag could be "safe" in that highly
>> specialized user case.
>> 
>> But that assumes that file system authors can trust application
>> writers not to do something stupid and insecure, and historically,
>> file system authors (possibly with good reason, given bitter past
>> experience) don't trust application writesr to do something which is
>> very easy, and gooses performance, even if it has terrible side
>> effects on either data robustness or data security.
>> 
>> Effectively, the no hide stale flag could be considered an "Attractive
>> Nuisance"[1] and so support for this feature has never been accepted
>> into the mainline kernel, and never to any distro kernels, since the
>> distribution companies don't want to be held liable for making an
>> "acctive nuisance" that might enable application authors from shooting
>> themselves in the foot.
>> 
>> [1] https://en.wikipedia.org/wiki/Attractive_nuisance_doctrine
>> 
>> In any case, the technique of fallocatE(2) plus zero-fill-write plus
>> fdatasync(2) isn't *that* slow, and is only needed when you are first
>> extending the tablespace file.  In the steady state, most database
>> applications tend to be overwriting space, so this isn't an issue.
>> 
>> In any case, if you need to get that last 5% or so of performance ---
>> say, if you are are an enterprise database company interested in
>> taking a full page advertisement on the back cover of Business Week
>> Magazine touting how your enterprise database benchmarks are better
>> than the competition --- the simple solution is to use a raw block
>> device.  Of course, most end users want the convenience of the file
>> system, but that's not the point if you are engaging in
>> benchmarketing.   :-)
>> 
>> Cheers,
>> 
>>                                                - Ted
> 
> Thank you for a comprehensive answer :-)
> 
> I have one more question - when I gradually increase the i/o transfer
> size the performance degradation begins to lessen and at 32K it is
> similar to the "overwriting the file" case. I assume this is because
> the metadata update is now spread over 32K of data rather than 4K.

When splitting unwritten extents, the ext4 code will write out zero
blocks up to 32KB by default (/sys/fs/ext4/*/extent_max_zeroout_kb)
to avoid having millions of very small extents in a file (e.g. in
case of a pathological alternating 4KB write pattern).  If your test
is writing >= 32KB blocks then this no longer needs to be done.  If
writing smaller blocks then it makes sense that the speed is 1/2 the
raw speed because the file blocks are all being written twice (first
with zeroes, then with actual data on a later write).

32KB (or 64KB) is a reasonable minimum size because any disk write
will take the same time to write a single block or a whole sector,
so doing writes in smaller units is not very efficient.  Depending
on the underlying storage (e.g. RAID-6) it might be more efficient
to set extent_max_zeroout_kb=1024 or similar.

> However, my understanding is that, in my case, an extent should
> represent the max 128MiB of data and so the clearing of the
> uninitialized bit for an extent should happen once every 128MiB, so
> then why is a higher transfer size making a difference?

You are misunderstanding how uninitialized extents are cleared.  The
uninitialized extent is split into two/three parts, where only the
extent that has data written to it (min 32KB) is set to "initialized"
and the remaining one/two extents are left uninitialized.  Otherwise,
each write to an uninitialized extent would need up to 128MB of zeroes
written to disk each time, which would be slow/high latency.

Cheers, Andreas






--Apple-Mail=_5E6B2CB8-94ED-489A-AD93-C072147FD469
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmKwwe4ACgkQcqXauRfM
H+C7ew/+OZWg3D2aDd+7Ar7bmEl1+flbCDOJQ0ogkMw7pm1SeVikFLRhkRzbJ+wb
QVE5zeHMfixrCm8X+b+0dt6D8sE4v2Hj0D3VukcGWHM2dbhFwjw2l+bYVE4kZ7fw
tvkSH/vsKC/9KCCk83EkRFAheQJI+0k4AStjUDqiLDmgBHVGqnS+BzEumvO7SxPc
0svHW2vzC9Xt1tTXLW1tWuVWQv0vk+5F5G71Ks2E33juRQo5rZWAOcciT5hfr+wa
QMTsGJp358vBte3XPD2P9rLtCUuex8pelFsoT2tpcMw+Zmj3U4iTZKaue0RBnnBy
ksAxwOIQ2Qp253x+sD0WS/Hj2FV46DY4DN48CXK5xYxDnhGEmQr9FxVrHouC/JfB
orZbOO93a0EAvTbBcJ3tsIAQtAZpTkVu7GQ9nz0EGvgcX0RyMjWLdMWTTYXwG+zo
eo7xSJYqu3x2Zngme/ACj4nGsUJfoN5zRQivzIarmwtN8o/Ee8U1+7xKkZMzwwRC
QXf2Iw4LAFLSRvgrqZgCOMxDxaQiH59xn1Pza0vVlbEMK20H3GO4/o3OAX/cVnmm
L2w0LCN1Q1SgyAKUzAUHVxdZGP8O8Sv9mxIZnhLPRr8PfVQAPJKagclJ5rXD+oyS
ZFpa/AIwU7m4QN/FkUlj0JRuW7UeMIds5PA9KBJyS+OeyWdDOd4=
=tQuU
-----END PGP SIGNATURE-----

--Apple-Mail=_5E6B2CB8-94ED-489A-AD93-C072147FD469--
