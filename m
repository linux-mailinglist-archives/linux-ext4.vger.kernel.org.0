Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9F31D2BC
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Feb 2021 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBPWhO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Feb 2021 17:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhBPWhH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Feb 2021 17:37:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F609C061574
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 14:36:27 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z7so6302592plk.7
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 14:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vbkefW7BLJeqaSH+W/x1EytS+Q3carYqWdndABD5pcU=;
        b=ESnGn1CMUZ8JU1wiWtEVHDY5s8SxAvH9pLZTq3ZpruWmRil74FD7xzt8VdqWMqdXA9
         c4S9Hj/pwHLQwAxqMR4yfFrZm9FhZB4GhLBvO+thnpYiS1tVgSyF7Wd0iOYPFqHGlbxR
         y1cUpUbGqyAW/pSBcahr94dLcbdREqMKDBkAQGr7atgj4KssmjoAIdUvzB2ulXxwUkNS
         UsKYhdzUKr4UICO3jWMGcemt6UxBCtEIfusCA606/yyvNPyuPsuDdSxlawj/uUmP475P
         rFFLx/sY54VSymF3DXWYpGGQTpwwMrw+WzsISpKLPQ1AH+vjUz+Vwcw7NnI6fESsl2uL
         MVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vbkefW7BLJeqaSH+W/x1EytS+Q3carYqWdndABD5pcU=;
        b=llU0QPo6tEITq/1NeXsGYe6/8GjbRSqY5+hmz/U5CON70fteBxNd/3x4rOhSLdpFSM
         VIEMMiDYpVD3BkOx6R7uwQGYldZrk7K87sd05kfciprh1j4l7Z88PwcCogNaguEz0uSK
         mPz+9EywBEm+fV/md7gly2xIMe/EEf7NkBIvECJ5Rpoi5HoIzd65WUY7tkNb32NkN9VZ
         a1MGCiOzEq2QLKOyrPyesKcgZ1bJPag88MlDw0K2f4/a8oOZgdpzeKspi0kPLSePxkYm
         W8CaNEYMjY6NBy7/n79pR3GIzvPvpyyLHe78dv27Z6y+NysXicFeWG1+oFJjiwy+l209
         Sh8Q==
X-Gm-Message-State: AOAM530450xeOOmcvqI21DZ/XPwOfltuq8Tkdl5TQUmeT5+ZXQLeGUsa
        zLXeG0wvDje+Sl3oyQNEiyysvX6QPCT5Dh/5
X-Google-Smtp-Source: ABdhPJwQiPf69EV5Zcty49ZXepXrHMN7SEODbEMRjeJ03nFgf1cOpebghc73L5B9Elj6mK7wASaCew==
X-Received: by 2002:a17:90a:e644:: with SMTP id ep4mr3987240pjb.218.1613514986536;
        Tue, 16 Feb 2021 14:36:26 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 14sm5461175pfo.141.2021.02.16.14.36.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 14:36:25 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7659F518-07CD-4F37-BB6D-FE53458985D6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FCF23342-6A10-446B-84D1-C7CB44EA8240";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 4/5] ext4: improve cr 0 / cr 1 group scanning
Date:   Tue, 16 Feb 2021 15:36:23 -0700
In-Reply-To: <BF6E7BBD-794A-4C02-9219-A302956F7BFA@gmail.com>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        Shuichi Ihara <sihara@ddn.com>
To:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-5-harshadshirwadkar@gmail.com>
 <BF6E7BBD-794A-4C02-9219-A302956F7BFA@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_FCF23342-6A10-446B-84D1-C7CB44EA8240
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Feb 16, 2021, at 12:39 PM, =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=D1=
=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC =
<artem.blagodarenko@gmail.com> wrote:
> Thanks for this useful optimisation.
>=20
> Some comments bellow.
>=20
>> On 9 Feb 2021, at 23:28, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>>=20
>> Instead of traversing through groups linearly, scan groups in =
specific
>> orders at cr 0 and cr 1. At cr 0, we want to find groups that have =
the
>> largest free order >=3D the order of the request. So, with this =
patch,
>> we maintain lists for each possible order and insert each group into =
a
>> list based on the largest free order in its buddy bitmap. During cr 0
>> allocation, we traverse these lists in the increasing order of =
largest
>> free orders. This allows us to find a group with the best available =
cr
>> 0 match in constant time. If nothing can be found, we fallback to cr =
1
>> immediately.
>>=20
>> At CR1, the story is slightly different. We want to traverse in the
>> order of increasing average fragment size. For CR1, we maintain a rb
>> tree of groupinfos which is sorted by average fragment size. Instead
>> of traversing linearly, at CR1, we traverse in the order of =
increasing
>> average fragment size, starting at the most optimal group. This =
brings
>> down cr 1 search complexity to log(num groups).
>>=20
>> For cr >=3D 2, we just perform the linear search as before. Also, in
>> case of lock contention, we intermittently fallback to linear search
>> even in CR 0 and CR 1 cases. This allows us to proceed during the
>> allocation path even in case of high contention.
>>=20
>> There is an opportunity to do optimization at CR2 too. That's because
>> at CR2 we only consider groups where bb_free counter (number of free
>> blocks) is greater than the request extent size. That's left as =
future
>> work.
>>=20
>> +static int
>> +ext4_mb_avg_fragment_size_cmp(struct rb_node *rb1, struct rb_node =
*rb2)
>> +{
>> +	struct ext4_group_info *grp1 =3D rb_entry(rb1,
>> +						struct ext4_group_info,
>> +						=
bb_avg_fragment_size_rb);
>> +	struct ext4_group_info *grp2 =3D rb_entry(rb2,
>> +						struct ext4_group_info,
>> +						=
bb_avg_fragment_size_rb);
>> +	int num_frags_1, num_frags_2;
>> +
>> +	num_frags_1 =3D grp1->bb_fragments ?
>> +		grp1->bb_free / grp1->bb_fragments : 0;
>> +	num_frags_2 =3D grp2->bb_fragments ?
>> +		grp2->bb_free / grp2->bb_fragments : 0;
>> +
>> +	return (num_frags_1 < num_frags_2);
>> +}
>> +
>> +/*
>> + * Reinsert grpinfo into the avg_fragment_size tree with new average
>> + * fragment size.
>> + */
>=20
> Walk along the ngroups linked elements in worst case for every =
mb_free_blocks and mb_mark_used which are quite frequently executed =
actions.
> If double-linked list is used for avg_fragments this function will =
make this change without iterating through the list:
> 1. Check with previous element. If smaller, then commute
> 2. Check with next element. If greater, then commute.

I was wondering about the cost of the list/tree maintenance as well,
especially since there was a post from "kernel test robot" that this
patch introduced a performance regression.

The tree insertion/removal overhead I think Artem's proposal above would
improve, since it may be that a group will not move in the tree much?

It would also make sense for totally full groups to be kept out of the
rb tree entirely, since they do not provide any value in that case (the
full groups will never be selected for allocations), and they just add
to the tree depth and potentially cause an imbalance if there are many
of them.  That also has the benefit of the rbtree efficiency *improving*
as the filesystem gets more full, which is right when it is most needed.

It might also make sense to keep totally empty groups out of the rbtree,
since they should always be found in cr0 already if the allocation is
large enough to fill the whole group?  Having a smaller rbtree makes
every insertion/removal that much more efficient.

Those groups will naturally be re-added into the rbtree when they have
blocks freed or allocated, so not much added complexity.


Does it make sense to disable "mb_optimize_scan" if filesystems are
smaller than a certain threshold?  Clearly, if there are only 1-2
groups, maintaining a list and rbtree has no real value, and with
only a handful of groups (< 16?) linear searching is probably as fast
or faster than maintaining the two data structures.  That is similar
to e.g. bubble sort vs. quicksort, where it is more efficient to sort
a list of ~5-8 entries with a dumb/fast algorithm instead of a complex
algorithm that is more efficient at larger scales.  That would also
(likely) quiet the kernel test robot, if we think that its testing is
not representative of real-world usage.

> On Feb 11, 2021, at 3:30 AM, Andreas Dilger <adilger@dilger.ca> wrote:

>> This function would be more efficient to do the list move under a =
single
>> write lock if the order doesn't change.  The order loop would just
>> save the largest free order, then grab the write lock, do the =
list_del(),
>> set bb_largest_free_order, and list_add_tail():
>>=20
>> mb_set_largest_free_order(struct super_block *sb, struct =
ext4_group_info *grp)
>> {
>> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>> 	int i, new_order =3D -1;
>>=20
>> 	for (i =3D MB_NUM_ORDERS(sb) - 1; i >=3D 0; i--) {
>> 		if (grp->bb_counters[i] > 0) {
>> 			new_order =3D i;
>> 			break;
>> 		}
>> 	}
>> 	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && =
grp->bb_largest_free_order >=3D 0) {
>> 		write_lock(&sbi->s_mb_largest_free_orders_locks[
>> 					      =
grp->bb_largest_free_order]);
>> 		list_del_init(&grp->bb_largest_free_order_node);
>>=20
>> 		if (new_order !=3D grp->bb_largest_free_order) {
>> 			=
write_unlock(&sbi->s_mb_largest_free_orders_locks[
>> 					      =
grp->bb_largest_free_order]);
>> 			grp->bb_largest_free_order =3D new_order;
>> 			write_lock(&sbi->s_mb_largest_free_orders_locks[
>> 					      =
grp->bb_largest_free_order]);
>> 		}
>> 		list_add_tail(&grp->bb_largest_free_order_node,
>> 		      =
&sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
>> 		write_unlock(&sbi->s_mb_largest_free_orders_locks[
>> 					      =
grp->bb_largest_free_order]);
>> 	}
>> }

In looking at my previous comment, I wonder if we could further reduce
the list locking here by not moving an entry to the end of the *same*
list if it is not currently at the head?  Since it was (presumably)
just moved to the end of the list by a recent allocation, it is very
likely that some other group will be chosen from the list head, so
moving within the list to maintain strict LRU is probably just extra
locking overhead that can be avoided...

Also, it isn't clear if *freeing* blocks from a group should move it
to the end of the same list, or just leave it as-is?  If there are
more frees from the list it is likely to be added to a new list soon,
and if there are no more frees, then it could stay in the same order.


Cheers, Andreas






--Apple-Mail=_FCF23342-6A10-446B-84D1-C7CB44EA8240
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAsSOcACgkQcqXauRfM
H+DxQg/+Oven5DeE8w4x39oqiqWnnPHsSIE0Z/1FFCIghbF1t7dPh7Sor2n5ZLRF
hOZbeBLEHrUB4h+pMZTg/0EQeprR49ByqI1DO29BWM0vFkoXbAH+pCSoRflOGEqU
DPYPI/J0LdtzVoZ/ojN9V7oOTMvA7gEce71cHpMIvzjit5Tl78DO3sbrgkl8vjSf
TvuoyEQSGFKX2i/rL5Fd5jH1ZCLjqxU+NtR++3/J9uVC+EHQqp+smV1FNnPdXUvR
qfpy1LJlfanmXzICv+VmZuX6FrWOEHP+v2x7rvr4OSBGd1S1fe6tdzpLqBpNwr8T
uTKpv4s5oLNlfEFHRikAQE8AQQlxhNAsI7F/34i1cD884v+i9fethmadYfSkVTaM
CungQk+yq6MjmNNNC6rvO7WEGZ//ZYhbE3/m2HwNnAkQpPbasmOe/7GesZNingvz
0tmhAM6/8aJwZhcpZT4c33h4qU01udtv1QsXEFER/MkXREbkudVIZyTAd8qH3JMb
Ca8MFbpv0MAXQu+phuN7KUfJ3UMtGJy/83dnqlTqCNxHG/gOMIy1TOrDS93P/v/U
eL2tlxgalS5NxTGfJyLxwuvTwEMIx0SdQSmpjgh9jtSWUW90TltURWOlQ+Jm1oDH
npmSi2Cz1o51Hp2JV5YM5JdNfIY/5tj1eJmwz+iucAAxorkWQbk=
=BnSq
-----END PGP SIGNATURE-----

--Apple-Mail=_FCF23342-6A10-446B-84D1-C7CB44EA8240--
