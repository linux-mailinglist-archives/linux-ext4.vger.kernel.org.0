Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC3325C17
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 04:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhBZDoF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 22:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhBZDoD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Feb 2021 22:44:03 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FDFC061574
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 19:43:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w18so5349610pfu.9
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 19:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Cdn7LLWIAjqZV+29vuWdlB+vRUGMEDSKSiUP8cZUiv4=;
        b=ojZUIyOcFcPbML4CcLqAU673Oz5pWTWLsvHAyBdPc1QAJ3z0Fcd4dw+Kn9jOyF4KXt
         iPWiaTVFSfxb8v7O81vXfaeEkzCwLsCD0ppIFIpePVcOR84sYCf6Epj9NTPUoMkUUHul
         HOb0Mgolm8g05a72cgW/JBJp8Wl4xvagfGA7FE59qRbd+FKHYoS9YrBAYPbVZi/zVUad
         cnS3dMuIEdL+wukSYEERPeDXXk11Sn3BslYZ5nSxYcPiLH53EubPRqBNG3MJZQQoUQ6Z
         KlCJFrbYEmp7plJ6aLwIfwYlTsVVtSj2rF2qbZ3YDijUbrQbE5D9mmhDtaE1G5U4YnZI
         4okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Cdn7LLWIAjqZV+29vuWdlB+vRUGMEDSKSiUP8cZUiv4=;
        b=eL5ZIbIyPxSqkIgtY72CsnvcbbiUNm/43Vt+fJbo2vg9uB6qIr1avRLKBSXrQnGX+S
         LtxEXmxTwj8Pqw+aCm+GyDsNJMZyt2UMAeDtJhT6kdZ/M1Z8EMDUpqLdZ/T0vxlJXg9T
         o2R+aQOsX4iNbM8csI2U1Emjdjigc7SObL00e0vuEr4OsSC4+GyRib77jqJ78aNZDmNS
         tuseKyio2XhkcC75nq02YGeod5Hc7h/QSLozRatOcxqqzpFoXOPV3BHHZb4Vdy6gFTOo
         xTD593Ms9q8ykkq8l1sYvX349gzIj6TQiqeUGurNkuxhHWN/dgcOEowgvo10aKgTEoUC
         56Qg==
X-Gm-Message-State: AOAM533lV3p1uP6HvEMGpyT2WzQUPSfQdgh0REBCPwAA/fjuoAWh0KxJ
        9qnh5AbM6ruzOelfeyTWHGN3Zw==
X-Google-Smtp-Source: ABdhPJw4vVGvyeYwwoF3YxVuLup53NfZts7ENlBpIdVNPi4nhAqiBygkJMdeQuDGe0bZ388UThi/9Q==
X-Received: by 2002:a63:504a:: with SMTP id q10mr1086390pgl.188.1614311002774;
        Thu, 25 Feb 2021 19:43:22 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id w16sm7452803pfi.96.2021.02.25.19.43.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 19:43:22 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E51E6ECE-469D-45A6-8255-2474CCF0A734@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9F9D3147-0C1A-4492-8F46-90C4892100E5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 4/5] ext4: improve cr 0 / cr 1 group scanning
Date:   Thu, 25 Feb 2021 20:43:20 -0700
In-Reply-To: <CAD+ocbwCEKjrSAuv8EKWRwq-tXva+w4=VxDwFJ2N3-VLaevp9Q@mail.gmail.com>
Cc:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        Shuichi Ihara <sihara@ddn.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-5-harshadshirwadkar@gmail.com>
 <BF6E7BBD-794A-4C02-9219-A302956F7BFA@gmail.com>
 <7659F518-07CD-4F37-BB6D-FE53458985D6@dilger.ca>
 <CAD+ocbwCEKjrSAuv8EKWRwq-tXva+w4=VxDwFJ2N3-VLaevp9Q@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_9F9D3147-0C1A-4492-8F46-90C4892100E5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 21, 2021, at 8:59 PM, harshad shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Thank you for all the feedback Andreas and Artem. Some comments below:

Thank you for working on this.  It is definitely an area that can use
this improvement.

>> I was wondering about the cost of the list/tree maintenance as well,
>> especially since there was a post from "kernel test robot" that this
>> patch introduced a performance regression.
>=20
> Yeah, I'm pretty sure that the kernel test robot is complaining mainly
> because of list/tree maintenance. I think if this optimization is
> turned off, we probably should not even maintain the tree / lists.
> That has one downside that is that we will have to disallow setting
> this option during remount, which I guess is okay?

I think it is reasonable to not be able to change this at runtime.
This would only make a difference for a limited number of testers,
and virtually all users will never know it exists at all.

>> It would also make sense for totally full groups to be kept out of =
the
>> rb tree entirely, since they do not provide any value in that case =
(the
>> full groups will never be selected for allocations), and they just =
add
>> to the tree depth and potentially cause an imbalance if there are =
many
>> of them.  That also has the benefit of the rbtree efficiency =
*improving*
>> as the filesystem gets more full, which is right when it is most =
needed.
>=20
> Ack
>=20
>> It might also make sense to keep totally empty groups out of the =
rbtree,
>> since they should always be found in cr0 already if the allocation is
>> large enough to fill the whole group?  Having a smaller rbtree makes
>> every insertion/removal that much more efficient.
>=20
> Ack
>=20
>> Those groups will naturally be re-added into the rbtree when they =
have
>> blocks freed or allocated, so not much added complexity.
>>=20
>>=20
>> Does it make sense to disable "mb_optimize_scan" if filesystems are
>> smaller than a certain threshold?  Clearly, if there are only 1-2
>> groups, maintaining a list and rbtree has no real value, and with
>> only a handful of groups (< 16?) linear searching is probably as fast
>> or faster than maintaining the two data structures.  That is similar
>> to e.g. bubble sort vs. quicksort, where it is more efficient to sort
>> a list of ~5-8 entries with a dumb/fast algorithm instead of a =
complex
>> algorithm that is more efficient at larger scales.  That would also
>> (likely) quiet the kernel test robot, if we think that its testing is
>> not representative of real-world usage.
>=20
> Ack, these are good optimizations. I'll add these in V3.

For testing purposes it should be possible to have "mb_optimize_scan=3D1"
force the use of this option, even if the filesystem is small.

> Besides the optimizations mentioned here, I also think we should add
> "mb_optimize_linear_limit" or such sysfs tunable which will control
> how many groups should mballoc search linearly before using tree /
> lists for allocation? That would help us with the disk seek time
> performance.

There is already a linear search threshold parameters for mballoc,
namely mb_min_to_scan and mb_max_to_scan that could be used for this.
I think we could use "mb_min_to_scan=3D10" (the current default), or
maybe shrink this a bit (4?) if "mb_optimize_scan" is enabled.

> We discussed on our last call that we probably should consult with the
> block device's request queue to check if the underlying block device
> is rotational or not. However, we also discussed that for more complex
> devices (such as DMs setup on top of HDD and SSD etc), whether the
> device is rotational or not is not a binary answer and we would need a
> more complex interface (such as logical range to "is_rotational"
> table) to make intelligent choice in the file system. Also, in such
> cases, it is not clear if such a table needs to be passed to the file
> system during mkfs time? or at mount time? or at run time?

I don't think the hybrid case is very important yet.  By far the
most common case is going to be "rotational=3D1" or "rotational=3D0"
for the whole device, so we should start by only optimizing for
those cases.  DM looks like it returns "rotational=3D0" correctly
when a composite device it is made of entirely non-rotational
devices and "rotational=3D1" as it should when it is a hybrid
HDD/SSD device (which I have in my local system).

> Given the number of unknowns in the above discussion, I propose that
> we start simple and evolve later. So my proposal is that we add a
> "mb_optimize_linear_limit" tunable that accepts an integer value. In
> the kernel, for non-rotational devices, that value will be defaulted
> to 0 (which means no linear scan) and for rotational devices, that
> value will be defaulted to a reasonable value (-- not sure what that
> value would be though - 4?). This default can be overridden using the
> sysfs interface. We can later evolve this interface to accept more
> complex input such as logical range to rotational status.
>=20
> Does that sound reasonable?

Yes, modulo using the existing "mb_min_to_scan" parameter for this.
I think 4 or 8 or 10 groups is reasonable (512MB, 1GB, 1.25GB),
since if it needs a seek anyway then we may as well find a good
group for this.

Cheers, Andreas

>=20
>>=20
>>> On Feb 11, 2021, at 3:30 AM, Andreas Dilger <adilger@dilger.ca> =
wrote:
>>=20
>>>> This function would be more efficient to do the list move under a =
single
>>>> write lock if the order doesn't change.  The order loop would just
>>>> save the largest free order, then grab the write lock, do the =
list_del(),
>>>> set bb_largest_free_order, and list_add_tail():
>>>>=20
>>>> mb_set_largest_free_order(struct super_block *sb, struct =
ext4_group_info *grp)
>>>> {
>>>>     struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>>>>     int i, new_order =3D -1;
>>>>=20
>>>>     for (i =3D MB_NUM_ORDERS(sb) - 1; i >=3D 0; i--) {
>>>>             if (grp->bb_counters[i] > 0) {
>>>>                     new_order =3D i;
>>>>                     break;
>>>>             }
>>>>     }
>>>>     if (test_opt2(sb, MB_OPTIMIZE_SCAN) && =
grp->bb_largest_free_order >=3D 0) {
>>>>             write_lock(&sbi->s_mb_largest_free_orders_locks[
>>>>                                           =
grp->bb_largest_free_order]);
>>>>             list_del_init(&grp->bb_largest_free_order_node);
>>>>=20
>>>>             if (new_order !=3D grp->bb_largest_free_order) {
>>>>                     =
write_unlock(&sbi->s_mb_largest_free_orders_locks[
>>>>                                           =
grp->bb_largest_free_order]);
>>>>                     grp->bb_largest_free_order =3D new_order;
>>>>                     =
write_lock(&sbi->s_mb_largest_free_orders_locks[
>>>>                                           =
grp->bb_largest_free_order]);
>>>>             }
>>>>             list_add_tail(&grp->bb_largest_free_order_node,
>>>>                   =
&sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
>>>>             write_unlock(&sbi->s_mb_largest_free_orders_locks[
>>>>                                           =
grp->bb_largest_free_order]);
>>>>     }
>>>> }
>>=20
>> In looking at my previous comment, I wonder if we could further =
reduce
>> the list locking here by not moving an entry to the end of the *same*
>> list if it is not currently at the head?  Since it was (presumably)
>> just moved to the end of the list by a recent allocation, it is very
>> likely that some other group will be chosen from the list head, so
>> moving within the list to maintain strict LRU is probably just extra
>> locking overhead that can be avoided...
>>=20
>> Also, it isn't clear if *freeing* blocks from a group should move it
>> to the end of the same list, or just leave it as-is?  If there are
>> more frees from the list it is likely to be added to a new list soon,
>> and if there are no more frees, then it could stay in the same order.
>>=20
>>=20
>> Cheers, Andreas
>>=20
>>=20
>>=20
>>=20
>>=20


Cheers, Andreas






--Apple-Mail=_9F9D3147-0C1A-4492-8F46-90C4892100E5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmA4blgACgkQcqXauRfM
H+BCiQ//bDucC3LNdmdObrHeNl6IiPVzyO3OeUT/A/ua1DUJbN8sV2CSKBDichbP
cGI4XIHhIiB3RYeMGTzLqhByH9ZdSoUqF4zop638hyx+GAiWjtoTUURy6fgBEyfd
R4Hn/J4iRPFU4vFnBN8t4rqX/sJRFyT+FqIt1DCpFqFzTgFlDfoxf2y5yRh7Ru9Y
yRY/EtrPX6oeFH5GfuhnLI/lGxZKz8Fw1dW4S+BJNRdy5ESzfBZNAP3+OsaJ857m
NEc+l9f0WuVgHDMHjsmRTd2RV2PIdeJNGAjorPT59LJAqtlAwK9vhNrE+NmolSH5
GKOQCpmQNYW/9p1m8b2G3nMY8xLVkcDrGxbYRHq5n84JCLSJ4NwTh7mPnn+uVFfo
NYicTQJk1WTPyvikXO2Docf0cbaanTJyIC9fb+EuvUdQS89ghyrIv4xJbgEC4Tg5
RM0EVqNT50XqUKFAzfbQMuhxBVMK4GzC1EUj18OFwDLATfzVYFLG4VRUY5HY8Ypw
n59kseRyvgHVNQqYWGlzKtfDHyHcnEn5vjPK1Gdk33AFnl1ulvFQbr5uXXC/jOV1
epz4W6qHrxZzQa91903Dlls9IJ6uGhzSdGFJ3aqJ7BOTRLcrGllqDaZN4p1PWolp
lTpJ2CJV0yoWLpGChQHhbZhQ7hlNehFuzlSTXMglEV0pRYFLEKY=
=t08D
-----END PGP SIGNATURE-----

--Apple-Mail=_9F9D3147-0C1A-4492-8F46-90C4892100E5--
