Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8207878F8
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 21:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242749AbjHXTtz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 15:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243209AbjHXTtk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 15:49:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68C1BE6
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 12:49:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc63ef9959so2352595ad.2
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1692906577; x=1693511377;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2acvlREbbFVeuBIk+mDDBuKIf3YkdhV0lWFHOjUkR6U=;
        b=2NwLIQeT1tgq+l41iUMSDdAneKs5p6h3Zsi4mp1papo8znPpa0L5YFj35tdRypUcHz
         UbHAH7aCuXlRHefe4gXVARU69AHkF7He7AEdKLcXIdwWmqLL4rJ+qdv6Pt5R/3UHCmqV
         uD3jP7dJdlR5vxd+RW1IDQDUuoQ+Jfs5tujd9dnVov2LN9HUiPu6D0dTtVNMMhpfMbkh
         1FVFf86il7oZ4xXqwRKmjmfXm/1ExlqJxLsAPAnMZcxiPx4VCoe7BoCL64D8KPEwBFi+
         Lq6nJtcH7REdi3KO7QQV5nNHjzSn++/ZbjjnIYMxHihr7P0arCxhPKkPEaFalMRDSanY
         oKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692906577; x=1693511377;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2acvlREbbFVeuBIk+mDDBuKIf3YkdhV0lWFHOjUkR6U=;
        b=Xbm2y1v7pKeDK9I6jTQcpE1VP6dPAcmmtO9RvRPS3sx2uqG9rA5/h+TgOpDi3EGmZ2
         SWDp8hhblGkorarS6pWMT9IEivzSvMMaDAMwvByr7nNvmvNhX1L3RI3UgAus7+g8YZSA
         KFqLYIh9RUF4GlVRn0W0aETyOeJ+Q7ll7k0N6ZjLv4Ekv2roGsmycssWvz0LHAOtif+I
         uP7amtxIs9efHW6zaJvOGCQbkXYmcF9OgcjkDgQrRRiU9bupgBpTBTCkACqBIFRFnQ+O
         Isz2pj582Md/n2kwGi5vQyrTwtsA6hV5pumF5xH6WnT1uZl7HuD2UxdomTZ2VAtDdELM
         N9qw==
X-Gm-Message-State: AOJu0YyBnBPs+FSdg0nNrH83I0FAzZEqP2DRLemOuRXqiHXKMWtzx3Ne
        INABWm4QdT6InEhBnvh/2EmJNQ==
X-Google-Smtp-Source: AGHT+IGlX3HN6FhhT2IohteB6Eu8xfShLeivYn+t8ca60oYuFnGg7gXpYzXGYB6AAsIoeSue48Vy4A==
X-Received: by 2002:a17:90a:db06:b0:26c:f9a5:4493 with SMTP id g6-20020a17090adb0600b0026cf9a54493mr15892219pjv.5.1692906577626;
        Thu, 24 Aug 2023 12:49:37 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a890a00b0026d214a2b33sm1992655pjn.7.2023.08.24.12.49.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 12:49:36 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <900CFAF0-71BE-416B-834B-576DD7B18863@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_64E6931D-6693-479B-841C-C0A0314C50D9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: delay quotas loading in release_orphan_inodes()
Date:   Thu, 24 Aug 2023 13:49:33 -0600
In-Reply-To: <c03c97b6-1a04-737f-c17b-8e35564f32df@huawei.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Zhang Yi <yi.zhang@huawei.com>, yangerkun@huawei.com,
        yukuai3@huawei.com
To:     Baokun Li <libaokun1@huawei.com>
References: <20230817081828.934259-1-libaokun1@huawei.com>
 <20230823170524.xox66gceoqrigtyo@quack3>
 <c03c97b6-1a04-737f-c17b-8e35564f32df@huawei.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_64E6931D-6693-479B-841C-C0A0314C50D9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Aug 23, 2023, at 8:27 PM, Baokun Li <libaokun1@huawei.com> wrote:
> On 2023/8/24 1:05, Jan Kara wrote:
>> On Thu 17-08-23 16:18:28, Baokun Li wrote:
>>> After 7d79b40b ("e2fsck: adjust quota counters when clearing =
orphaned
>>> inodes"), we load all the quotas before we process the orphaned =
inodes,
>>> and when we load the quotas, we check the checsum of the bbitmap for =
each
>>> group. If one of the bbitmap checksums is wrong, the following error =
will
>>> be reported:
>>>=20
>>> =E2=80=9CError initializing quota context in support library:
>>>  Block bitmap checksum does not match bitmap=E2=80=9D
>>>=20
>>> But loading quotas comes before checking the current superblock for =
the
>>> EXT2_ERROR_FS flag, which makes it impossible to use e2fsck to =
repair any
>>> image that contains orphan inodes and has the wrong bbitmap =
checksum.
>>> So delaying quota loading until after the EXT2_ERROR_FS judgment =
avoids
>>> the above problem.
>>>=20
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> This certainly looks better but I wonder if there still isn't a =
problem if
>> the bitmap checksums are wrong but EXT2_ERROR_FS is not set. =
Shouldn't we
>> rather move the initialization of the quota files after the call to
>> e2fsck_read_bitmaps()?
>=20
> When the bitmap checksums are wrong but EXT2_ERROR_FS is not set, we =
must
> have lost some data (error flag or group descriptor or bitmap), so =
there is
> something wrong with the kernel at this time, so I don't think we =
should
> fix the image directly, but rather let the user realize that something =
is
> wrong with the filesystem logic.
>=20
> Moreover, if we don't care how this happened, but just want to fix the =
image,
> we only need to run "e2fsck -a" twice. After merging in the current =
patch, we
> always empty the orphan list before loading the quotas, and =
EXT2_ERROR_FS
> is set when loading the quotas fails, so this will be fixed the second =
time
> you run e2fsck. It will not happen that every e2fsck will fail like it =
did
> before.

I recall that Ted prefers e2fsck to fix everything in a single pass, or =
at
worst if a fatal problem hit during the run it should restart itself so
that it will fix all of the problems before exiting.

Cheers, Andreas






--Apple-Mail=_64E6931D-6693-479B-841C-C0A0314C50D9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTntE0ACgkQcqXauRfM
H+BMjxAAtfixcp9X7y7Yh7yfRIPlj0BXv3QYwtIPeTqga0fS9KUepaWd6gAEMQFH
6fWEgbIS7ZQ5envqsOeAanE1g0KYFJLCTSAdW6XfsFvWxQBwI3GkXF9XFeTWUHjs
NS/8Lo8Avecjq4XyxZnBxOsb4ITVsdYmTlepCJghxBkIOBZWl7s7XUbLtEQmIzRf
u47OiNRjGB0m3KYJsAih1jy6yQESsN5oroj65bwZXrz6NNhewrBiUC07/GOKwGn1
toF5JXBKVDxR0528aJxCQHS9ThQCBt7qsIF4K3TP8rEBRicoZ32fJYe5YKViHdSn
7YsuMpBfWOlfEAfPLwkE6kclVA1bm7OtNe4SDY93Fniel6nfWjCsDNJYd9Sldtov
ZS8h2to/PZ6K7jelJehVFocgwyFZGLVDtqZIL8AKl1OqML/kmtt7DUlV25vUL370
tHNdpk8JNQYgh9/mL4TAe+l7M+auNHJKtPPkwy8HsmPDGkzxJTgvpPFRw45WfeKN
SqYe6nRLHqZKWbJCb8cYVqDmr32y30MNQEwE2IClAn4dRqyfhnBpoDKrB7jJBtUj
FVK08WF+iahH21uIsF3POPz/hl8PTq7O9xNxiSXdB6l8hfTx1d2hiZt9LgrsfV4+
yq6PeFcNI0HyOaUyVhmW3908oV6103rCyUcusrAh1AGilLlVz0U=
=vWkm
-----END PGP SIGNATURE-----

--Apple-Mail=_64E6931D-6693-479B-841C-C0A0314C50D9--
