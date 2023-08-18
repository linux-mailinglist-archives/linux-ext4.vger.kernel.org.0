Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9837813F2
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 21:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345315AbjHRTyR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 15:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379817AbjHRTx4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 15:53:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F56E40
        for <linux-ext4@vger.kernel.org>; Fri, 18 Aug 2023 12:53:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26d60e6fc4eso317547a91.1
        for <linux-ext4@vger.kernel.org>; Fri, 18 Aug 2023 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1692388433; x=1692993233;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbUHC2Tt0w5D8Jrx+xy/C30lnR8Pi6aiPP7HXNnAXeY=;
        b=bC0cyedXHYcRbI2N3z2EOyz6Xr4OLbGX1ru4J7WdHxC8Zv0UU0PrF0zx9LNAxg4h+o
         rlXoEAAsRAKT8xICSdqVKs1CqsN+0uZ1FPW1JcUdxZlXlPnH/rloC4kJPgzDcrrQGMRD
         6gr6uVwnxCGI3O3vY6C6VVUe917WdvistaorNlCB7tuBoGsVy/n70CUB8N4OxbnXrrVM
         YqAX7ttl4LtshG026lp4BdttF0lejJORa9rFpOCXQSpEla4lDU5R0miL4R8Z3fJjccuH
         8ZCcXDgxkwnBc9KQ6RKbM/9kmgjxEnN2D3M6LKF4p/HsA70+vwYtTaK+cxg3gP6iEb+A
         XfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692388433; x=1692993233;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbUHC2Tt0w5D8Jrx+xy/C30lnR8Pi6aiPP7HXNnAXeY=;
        b=IzJ6ZuDFs9kHOMrgDgAsmgi4XBU64wtVyz5QdW4di3LLIlUGOL5P5LSgVqR42S7eoD
         X8CGZTSK2k0UObPTin2TBkjhPPZ3dVDhK7hjVXnO5bPoSbDn6977FQKLlPuslBRl0icn
         as4bJ+TQLu3dFhkrIf73BxUAQhG8mMdIYmCYEKAy9/rtmnWcXuqn41z5AoDnafRorlzy
         OtDEj/rgMZ9K3z4kMBJHDGzvfiXvlnRz8o8qmLl9yV04nfdkukNncyZrnMS0/afUXddH
         TJ3lHJprMJOe9n2Te9LAfbktYjKfA2r08ETb3jLcNgfLhqgAR840nS1lPs4qNyfiJbfd
         TMnw==
X-Gm-Message-State: AOJu0YwxggXl6mcXWOGITJDGBoh0JouYaGudNrmZMS0XcoxWXQNbiYkq
        ej1SxWbX0R7VpJ2xHYUyUOARDeC4h1Beh+IZGKY=
X-Google-Smtp-Source: AGHT+IEli2GJhDCwQeuMb/K6G40jqGlJvGtt0qUlEg2QbQWFilW5NJ+YHYFQTbVxVItm5LRdXx5kgA==
X-Received: by 2002:a17:90a:bf12:b0:26d:1986:f7ec with SMTP id c18-20020a17090abf1200b0026d1986f7ecmr185235pjs.1.1692388433100;
        Fri, 18 Aug 2023 12:53:53 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0025645ce761dsm3658679pjb.35.2023.08.18.12.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2023 12:53:52 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4AC80CE0-34B3-4388-9FDB-D5069CD64781@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C71B1007-A9A0-461F-A4D3-794E76F598D2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: optimize metadata allocation for hybrid LUNs
Date:   Fri, 18 Aug 2023 13:53:49 -0600
In-Reply-To: <871qg347u6.fsf@doe.com>
Cc:     Bobi Jam <bobijam@hotmail.com>, linux-ext4@vger.kernel.org
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <871qg347u6.fsf@doe.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C71B1007-A9A0-461F-A4D3-794E76F598D2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 16, 2023, at 4:09 AM, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>=20
> Andreas Dilger <adilger@dilger.ca> writes:
>=20
>> On Aug 3, 2023, at 6:10 AM, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>>> 1. What happens when the hdd space for data gets fully exhausted? =
AFAICS,
>>> the allocation for data blocks will still succeed, however we won't =
be
>>> able to make use of optimized scanning any more. Because we search =
within
>>> iops lists only when EXT4_MB_HINT_METADATA is set in ac->ac_flags.
>>=20
>> The intention for our usage is that data allocations should *only* =
come
>> from the HDD region of the device, and *not* from the IOPS (flash) =
region
>> of the device.  The IOPS region will be comparatively small (0.5-1.0% =
of
>> the total device size) so using or not using this space will be =
mostly
>> meaningless to the overall filesystem usage, especially with a 1-5%
>> reserved blocks percentage that is the default for new filesystems.
>=20
> Yes, but when we give this functionality to non-enterprise users,
> everyone would like to take advantage of a faster performing ext4 =
using
> 1 ssd and few hdds or a smaller spare ssd and larger hdds. Then it =
could
> be that the space of iops region might not strictly be less than 1-2%
> and could be anywhere between 10-50% ;)
>=20
> Shouldn't we still support this class of usecase as well? ^^^
> So if the HDD gets full then the allocation should fallback to ssd for
> data blocks no?

It's true that this is possible, and I've thought about optionally
allowing e.g. "small files" to be allocated in the IOPS space while
"large files" are allocated only in the HDD space.  This involves
"policy" which is always tricky to get right.  What is "small" and
what is "large"?  At what threshold do we *stop* putting small files
into the IOPS groups when they get too full, or increase the size of
"small" files if it isn't filling up quickly enough vs. the non-IOPS
groups? ...

I'd prefer to get the basic infrastructure working, and then we can
have the long discussions about how the policy should work for the
*next* patches, because those decisions do not have a permanent effect
on the on-disk format. :-)

> Or we can have a policy knob i.e. fallback_data_to_iops_region_thresh.
> So if the free space %age in the iops region is above 1% (can be =
changed
> by user) then the data allocations can fallback to iops region if it =
is
> unable to allocate data blocks from hdd region.
>=20
>      echo %age_threshold > fallback_data_to_iops_region_thresh =
(default 1%)
>=20
>        Fallback data allocations to iops region as long as we have =
free space
>        %age of iops region above %age_threshold.

IMHO, a simple "too full" threshold is sub-optimal, because it means
suddenly the IOPS groups would get filled up with regular file data,
and in the likely case that old files are deleted to free up space,
the IOPS groups will still be filled with the new files.

My preference would be to have a "base small file size" (e.g. 64KB)
and a "fullness ratio" (free IOPS blocks / free non-IOPS blocks) and
use the fullness ratio to scale the "small file size".  In case the
free IOPS blocks are very small (e.g. my initial proposal of 1% of
the total volume size, most of which would be filled with static
metadata) then e.g. files < 64 KB * 0.5% <=3D 3.2KB (probably *no* =
files,
since this is less than one block) would go into the IOPS groups.

If the ratio is more like 50% then files under 32KB could be allocated
into the IOPS groups, and if the non-IOPS groups end up filling faster
and the free space ratio is equal or even higher in the IOPS groups,
then 64KB or 128KB files can start to be allocated there.

> I am interested in knowing what do you think will be challenges in
> supporting resize with hybrid devices? Like if someone would like to
> add an additional ssd and do a resize, do you think all later metadata
> allocations can be fullfilled from this iops region?
>=20
> And what happens when someone adds hdds to existing ssds.
> I guess adding an hdd followed by resize operation can still allocate,
> GDT, block/inode bitmaps and inode tables etc for these block groups
> to sit on the resized hdd right.
>=20
> Are there any other challenges as well for such usecase?

At a high level, my expectation would be that resize would "work"
regardless of whether the IOPS groups have space or not, but how
optimal this is depends on how much free space is in the IOPS groups.
If the IOPS groups are over-provisioned, then it should be fine to
allocate bitmaps and inode table blocks in that space (with flex_bg).

It should also be possible to add more IOPS groups at the end of the
filesystem to help the resize to keep all metadata in the fast storage.
Allowing disjoint regions of flash storage is one of the reasons why
EXT4_BG_IOPS is a per-group flag and not just a "threshold" boundary
within the filesystem.


I only realized yesterday that online resize is completely disabled
for filesystems with sparse_super2.  I think this is actually a mistake
because the problem looks like a bad interaction between sparse_super2
having only 2 backup groups, and the resize_inode feature expecting that
there are backup group descriptors in all of the usual places.

So I think it makes sense to change the "cannot do online resize" check
to only the case of sparse_super2 AND resize_inode being enabled.  This
should be uncommon since sparse_super2 is mostly useful for filesystems
over 16TB in size, and resize_inode currently doesn't work in that case.

It does seem possible to fix resize_inode to work with sparse_super2 for
filesystems over 16TiB.  Originally the reason resize_inode is =
disallowed
for filesystems > 16TiB is because of the 2^32 block number limit for
non-extent files, and because the increasing numbers of backup groups
means a large number of blocks need to be reserved.  However, when using
sparse_super2 there are only 2 backup groups, and they can be located
within the first 16TiB (there is no reason that backup #2 has to be in
the last group) means resize_inode will have enough space in it to =
reserve
extra GDT blocks for the online resize to work smoothly, whether the =
IOPS
groups are in use or not.  However, that is a separate project...

Cheers, Andreas






--Apple-Mail=_C71B1007-A9A0-461F-A4D3-794E76F598D2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTfzE0ACgkQcqXauRfM
H+B/LA/7B1sOFABSQS3uS9dig4qSjaIjt5YUjyvliHe+ixh6CaOBSwBfRCBDjZgt
fqTn7HYae0nfo9stP2PepnSErn8d5m+JzphK+1lsjRxr128Q7DoeWOE93O/Khajc
apZajQGQBtFV79MUMHAsZexDiU1nJ9zoKq1ui/jqccbQjAuFFgoTivgNqOjwaTQf
6t6r0QYjgcD7QMuK8yOB5ubJEnaZXl79u7+lGw3jYNv6zkehzzpT6PXEY9BVhN6R
Kg+/I0Up9MynJt2J2RxNlOeKnTWiKLqwar+8tuBpwsNA4BQLXf+9YXj8PCITJuFQ
KzJil48MYUK8alOJzTBlxGfcbebb/SSdK8Af2xY0EJt/TFg24y2RSuzGe6QpJy5I
TWTkd/DEE8ZFraaBBWUAzKc1c/INOxnLqJh4R/yjjRVAsEludtQfJHEFJKW+XduG
IqTJ+sfaxl8ehq0oej2/uI/S1sgz6u79h4LOK2MoqzwSUJm1qwBQM9EXQVsn0clx
8EMPDSDz6HvLHphgI2p9DIjkOMXXutbKrTVoMb7/Sf4OfQjconM73RIzdIlz1xd+
zDgeOZ2M2byJ6Wbhx0l+mt/mD7KBssO+7VdOb1GfC1U97JHWx2ILLOrAnkNZ1Gcd
tbssN/1nmiYcUr6Jg6oeyBwVfwZWqU1Xg6M/jWN0dowiIkSqXqQ=
=lcdf
-----END PGP SIGNATURE-----

--Apple-Mail=_C71B1007-A9A0-461F-A4D3-794E76F598D2--
