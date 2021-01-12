Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389612F390C
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jan 2021 19:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392489AbhALSko (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jan 2021 13:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392158AbhALSko (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jan 2021 13:40:44 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FFCC061786
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jan 2021 10:40:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b8so1891969plx.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jan 2021 10:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=mCH4H50/7V5nvUX3dyqeIiAyc+ai5I263zuCMd7txb0=;
        b=Eaiz8DuyGXhJBlvThLV8PK/haloH5oNVsh3N2IBwj3ik7g038g+AhaEOdkq3vBizzr
         4TV24bHI/Yb1ZFaHuQKNTBTfElHm41su+CxdI8wmp5GTCPN2D9cnUi7TXaDNWJ7Rg7E4
         +lMUTjE0kq5tjuXr5Eo5lwRP4LXePd6LuUPeHcfPnxagjQ5ailFPXzcC0c5qyRAO2KWq
         BKWUry9PWD4as+O+Evm3AGdaKD0nH65pRbIriGaPHxAaL7crUcBSz2KpEafs2eKKZ5Rk
         CdhMoZdh2NPVIBgjJ0xfR6blxaCVGSJZr4RurxnrXxNtWugpsveu5A9Tc4KfxgLiK1eW
         dzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=mCH4H50/7V5nvUX3dyqeIiAyc+ai5I263zuCMd7txb0=;
        b=o73fid03t8oErr8XZN3boyChsPUNgdGq2P7X+9szBASTwvOn3QcbiZX6mZcZb4kr/j
         zo2R/2cpkKCADu71ZqwF1+iB2GckcJJYKC4l4euAlDxP5xUQvFEZOMPcdYuDrI0tQSKR
         pLe0gsArprvBHopdKr2B2RNJZFm1Jb4nIO4OTYSfvhbhtUs+ck7I/qA4kBY92LVI/t92
         8o7brDT4vsZjBNiumRN0AGiyCihqChvFP9vBD9vBgzXBFH7N24+4Nt1ee+5jUPIFJ1Q1
         GPGr3v3ZyDTLPEYKQHvpgbreU8r+O0D4JkdOhsXw70QD0Mjgq90w8wKTOUQ/6QxEQ25X
         MyBw==
X-Gm-Message-State: AOAM533puVny4XIE3nDtrU0up413Qx1tyXHzk3odUGP/jz+Z9mxDuMUh
        EmXPaWxeK3usGfkSA4lNGZhxlQ==
X-Google-Smtp-Source: ABdhPJyg82QcC404DY+xFKeGFknbj1XA+YLo1jI7pK8Gx78vBD/qQ0bcFpknaNxaLH3CCzdxWv8Y1g==
X-Received: by 2002:a17:902:6a83:b029:dc:2a2c:6b91 with SMTP id n3-20020a1709026a83b02900dc2a2c6b91mr483210plk.8.1610476803259;
        Tue, 12 Jan 2021 10:40:03 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x28sm3925739pff.182.2021.01.12.10.40.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 10:40:02 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C8811877-48A9-4199-9F28-20F5B071AE36@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_18205AF5-844B-4234-8D8C-C01F711CDC6E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Date:   Tue, 12 Jan 2021 11:39:58 -0700
In-Reply-To: <20210112181600.GA1228497@infradead.org>
Cc:     Avi Kivity <avi@scylladb.com>, Andres Freund <andres@anarazel.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
To:     Christoph Hellwig <hch@infradead.org>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <20210104181958.GE6908@magnolia>
 <20210104191058.sryksqjnjjnn5raa@alap3.anarazel.de>
 <f6f75f11-5d5b-ae63-d584-4b6f09ff401e@scylladb.com>
 <20210112181600.GA1228497@infradead.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_18205AF5-844B-4234-8D8C-C01F711CDC6E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 12, 2021, at 11:16 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> On Mon, Jan 04, 2021 at 09:57:48PM +0200, Avi Kivity wrote:
>>> I don't have a strong opinion on it. A complex userland application =
can
>>> do a bit better job managing queue depth etc, but otherwise I =
suspect
>>> doing the IO from kernel will win by a small bit. And the =
queue-depth
>>> issue presumably would be relevant for write-zeroes as well, making =
me
>>> lean towards just using the fallback.
>>>=20
>>=20
>> The new flag will avoid requiring DMA to transfer the entire file =
size, and
>> perhaps can be implemented in the device by just adjusting metadata. =
So
>> there is potential for the new flag to be much more efficient.
>=20
> We already support a WRITE_ZEROES operation, which many (but not all)
> NVMe devices and some SCSI devices support.  The blkdev_issue_zeroout
> helper can use those, or falls back to writing actual zeroes.
>=20
> XFS already has a XFS_IOC_ALLOCSP64 that is defined to actually
> allocate written extents.  It does not currently use
> blkdev_issue_zeroout, but could be changed pretty trivially to do so.
>=20
>> But note it will need to be plumbed down to md and dm to be generally
>> useful.
>=20
> DM and MD already support mddev_check_write_zeroes, at least for the
> usual targets.

Similarly, ext4 also has EXT4_GET_BLOCKS_CREATE_ZERO that can allocate =
zero
filled extents rather than unwritten extents (without clobbering =
existing
data like FALLOC_FL_ZERO_RANGE does), and just needs a flag from =
fallocate()
to trigger it.  This is plumbed down to blkdev_issue_zeroout() as well.

Cheers, Andreas






--Apple-Mail=_18205AF5-844B-4234-8D8C-C01F711CDC6E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/97P4ACgkQcqXauRfM
H+Dh0Q/+LcuqzM/nBx/I2PSTKm5GEEoeRcv8sDW3Zn8xdeJOs6Th7HR5qKquEfnF
onPWybvGZO0VgUUr5KPqEvOAXD4d2AjjDeaDyH9LVh+J9auQ6Yyu09da69CZZdx5
U4s574V1R3+/5MaR8U4JwZh0BJneo4B9OUR79ckba/Vi0giwFOtB508zT+ObXmnP
bxmrUZNT1WG0GE8JSQ1tDA+noxd+oSzib0Q3K2Nql2VCRdh4XImepl4igbUpn+iS
Hx+K/dTjqqpbzmUWYyBcQNM8AEfhRX+i3nChNooZOSFLhc8JnJr1lclHywmQED1r
XP3N/Sk2j5DdyhKXiyopzRAo8jqEFmYO2ZppcF8Qm3oTY/IfHc/HQSOme2dTWINl
BU1o69HlmwPCXLUv0037uNA/Us0EC86M5OckqgY75cv8ckrJHavoN+vo7mZy8uck
9chA1ymU9e7CwgbJXT55IBtCC0W/BO0YTUYZ5/IkaHOiY82j4zzxk/81u8/yjfYJ
UExCs5ZQ7Zuim1PVP8L9Ezst4d/PAzQnCmhyWxVwFp7ldHpp6ZbIPstabuZk6UR1
k7jk8kcn+19Kxbg35r/ST0ODPCRubgxTAXTSirQM303NGo8lqbXBhUMvN3JkTTrC
Gvx+zo80ufyXr5/W5g6cTFBc5t878LmjQ9QDci1zXqi3zgo91Go=
=JqvM
-----END PGP SIGNATURE-----

--Apple-Mail=_18205AF5-844B-4234-8D8C-C01F711CDC6E--
