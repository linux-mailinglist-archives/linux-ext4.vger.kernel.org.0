Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554EA42E72D
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 05:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhJODXn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 23:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbhJODXl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Oct 2021 23:23:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D07C061570
        for <linux-ext4@vger.kernel.org>; Thu, 14 Oct 2021 20:21:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so6344306pjb.0
        for <linux-ext4@vger.kernel.org>; Thu, 14 Oct 2021 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=+blC3RljJBKx+SoPQW/w6GKolYdslvy+BoMBgg4oluk=;
        b=259aJX5UJhG6sLVQcpX++53ZVehFbdAFegoq9xy8GCVeZDoEFSGKR9Njw6lPY3gCTS
         XjhaB6wBg2rV4/8uN1zbp+Ozw+MkD8js5kekU2Zm/g/zyLzornhAl3qHRv1gCpVU4rQC
         KVfuvHYK90jBRCoJ6iH0pInRcFsHwu5zo4X8A1SaEtz3nDiSo7UckyOOuqNCKTvFctBU
         CT6HzctIkM47NtdmfwabzGQgIn31G8OlKSAUaTlMO4FeDAyfVvgdtBSV0N9vdElYCzYd
         Hw+nebgvMm9WIfIM7qXtfouN3I1KjTcH7EeNw+nN3L6bkRqiWxPcEEdwFmw3pxkKWBzU
         FoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=+blC3RljJBKx+SoPQW/w6GKolYdslvy+BoMBgg4oluk=;
        b=bKk/cPXPXzGIFA3zUNkoTnVmLwnKjMJ01+h2MEIXG5LnbPaw9vof6Y0uS6Wg4hd7ya
         cinQdN0PC64TwSmkWuVMiHSfxdjpDXl10tyB8NDqpYZEJcNDHmPirISHKMHht+BBFwqj
         Wh7FJBf7RmpJLnahYTr1kB1O5tozRhR15LxirC1dNl0KM0ME9vguadzzY20tJXnMj8vr
         tIHHfLXU2NOX+6ASCsWDhJicgMxZWj41xK52USPwU7xq8br1QYFTIaVpms2/xP5h5BDF
         xDZkDJrSxSjGz6jxE/jdrpLQ4RpEM+9Bn+Hok6Dbi7fqFu78MOj0OPvdcDtTNRqSrbb0
         T9Hg==
X-Gm-Message-State: AOAM530o8PU5F85pazx8oC/OqWa5GxJ1DPnbnk74O/l82eJHULuz5G6x
        JXv6knz25MXeSq1RDwYvlIfYOZHah7qJjzwQ
X-Google-Smtp-Source: ABdhPJyyAJIE7hRO3N2Icifo9JJhAd6+lxND0Jyo/B6lSafkmiZrTnTcFVclWO0F2lct0BNHYvfxXw==
X-Received: by 2002:a17:90b:1d8f:: with SMTP id pf15mr10515434pjb.70.1634268095056;
        Thu, 14 Oct 2021 20:21:35 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x7sm9999637pjl.55.2021.10.14.20.21.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Oct 2021 20:21:34 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A3D2C77C-35E9-4EB7-8ECA-4043F24DF3E9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_43DCDECB-1CBC-4A80-9ECD-BD3E9B847A06";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH -next v2 2/6] ext4: introduce last_check_time record
 previous check time
Date:   Thu, 14 Oct 2021 21:21:29 -0600
In-Reply-To: <YWdSeMuosYio7TFv@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, yebin <yebin10@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-3-yebin10@huawei.com>
 <20211007123100.GG12712@quack2.suse.cz> <615FA55B.5070404@huawei.com>
 <615FAF27.8070000@huawei.com> <20211012084727.GF9697@quack2.suse.cz>
 <61657590.2050407@huawei.com> <20211013093847.GB19200@quack2.suse.cz>
 <YWdSeMuosYio7TFv@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_43DCDECB-1CBC-4A80-9ECD-BD3E9B847A06
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 13, 2021, at 3:41 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> On Wed, Oct 13, 2021 at 11:38:47AM +0200, Jan Kara wrote:
>> 
>> OK, I see. So the race in ext4_multi_mount_protect() goes like:
>> 
>> hostA				hostB
>> 
>> read_mmp_block()		read_mmp_block()
>> - sees EXT4_MMP_SEQ_CLEAN	- sees EXT4_MMP_SEQ_CLEAN
>> write_mmp_block()
>> wait_time == 0 -> no wait
>> read_mmp_block()
>>  - all OK, mount
>> 				write_mmp_block()
>> 				wait_time == 0 -> no wait
>> 				read_mmp_block()
>> 				  - all OK, mount
>> 
>> Do I get it right? Actually, if we passed seq we wrote in
>> ext4_multi_mount_protect() to kmmpd (probably in sb), then kmmpd would
>> notice the conflict on its first invocation but still that would be a bit
>> late because there would be a time window where hostA and hostB would be
>> both using the fs.

It would be enough to have even a short delay between write and read to
detect this case.  I _thought_ there should be a delay in this case,
but maybe it was removed after the patch was originally submitted?

>> We could reduce the likelyhood of this race by always waiting in
>> ext4_multi_mount_protect() between write & read but I guess that is
>> undesirable as it would slow down all clean mounts. Ted?
> 
> I'd like Andreas to comment here.  My understanding is that MMP
> originally intended as a safety mechanism which would be used as part
> of a primary/backup high availability system, but not as the *primary*
> system where you might try to have two servers simultaneously try to
> mount the file system and use MMP as the "election" mechanism to
> decide which server is going to be the primary system, and which would
> be the backup system.
> 
> The cost of being able to handle this particular race is it would slow
> down the mounts of cleanly unmounted systems.

Ted's understanding is correct - MMP is intended to be a backup mechanism
to prevent filesystem corruption in the case where external HA methods
do the wrong thing.  This has avoided problems countless times on systems
with multi-port access to the same storage, and can also be useful in the
case of shared VM images accessed over the network, and similar.

When MMP was implemented for ZFS, a slightly different mechanism was used.
Rather than having the delay to detect concurrent mounts, it instead writes
to multiple different blocks in a random order, and then reads them all.
If two nodes try to mount the filesystem concurrently, they would pick
different block orders, and the chance of them having the same order (and
one clobbering all of the blocks of the other) would be 1/2^num_blocks.
The drawback is that this would consume more space in the filesystem, but
it wouldn't be a huge deal these days.

> There *are* better systems to implement leader elections[1] than using
> MMP.  Most of these more efficient leader elections assume that you
> have a working IP network, and so if you have a separate storage
> network (including a shared SCSI bus) from your standard IP network,
> then MMP is a useful failsafe in the face of a network partition of
> your IP network.  The question is whether MMP should be useful for
> more than that.  And if it isn't, then we should probably document
> what MMP is and isn't good for, and give advice in the form of an
> application note for how MMP should be used in the context of a larger
> system.

One of the existing failure cases with HA that MMP detects is loss of
network connection, so I wouldn't want to depend on that.

Cheers, Andreas






--Apple-Mail=_43DCDECB-1CBC-4A80-9ECD-BD3E9B847A06
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmFo87oACgkQcqXauRfM
H+DD9A/9GZLDTwqwdSR4DFx905Tg3vqqLcRJE4lZnKJeLYpk+n2IU77ZIwvmQrvs
Pf8Hs6juUopCrgmt0ltYQOOq5zUFz32eKQ/CBUbDieoV4WBk2KcYITGbywFDXvKg
JEBtwMF2miJOJ/ajb19Lh3yI63VklrHVbNEhWHYgNNCoHrsp2J3W9/91bknIP/w8
v7R19khuCx/s1McL/A1qZbPJFatZgSd+veojkt+FNm1ReGewVMuI4d8UIJTK4y+E
dOhTSaDG4H+QaA1M3rbeXm44Kwm59p/6pa2R/3+bjsjCBM90m+S7II5OWk2e35dL
RM35XESVs4t0k4/pSC0m95ow/gwFgdsH7IINqapJ227v84eSKyXV2sYHXnpqwOHa
NqVlkBuMcTDyLvlOuri2ECz3mzoB0dr2ddShEI6fl9s7QvsYQbLjM3JdGkFoOJ+E
YX9ymYz44zkm28jiZSefgHmSQnaKcNVNum99miY0l2xmwKhBVjTn3/o5xW1WJGv6
Q9tqUYyAdSuKAcsqRINCcigGpXAO3Ck7lUIoATKIWUIqFrtCYOgSHW8W2UMix5Mr
dkU2VSrkK6YSe3K13IJ5UOCRddHrsnJYXVdn30M3abJCOkt2BhCOn+J7HZdYJ/Y9
Q/wDXSB800mo5yUYQw1lr5NX54bSuoUpxThw43Xs+VR/L5lt8VI=
=aZ4Y
-----END PGP SIGNATURE-----

--Apple-Mail=_43DCDECB-1CBC-4A80-9ECD-BD3E9B847A06--
