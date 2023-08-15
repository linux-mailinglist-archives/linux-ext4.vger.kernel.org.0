Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F3C77C6AD
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 06:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjHOEQD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 00:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjHOEMX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 00:12:23 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DE5171F
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 21:10:11 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bd0911c95dso4548816a34.3
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 21:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1692072610; x=1692677410;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XekWSlNIMJA0Yurb+9+cWUybUA9oVXte/EYshLDfQI=;
        b=Q+nIBK7vWDB95dHSNoj1ZzUiaZYj2v3WGSsIrx/Gwyyb6Mrsmazrnue0rTDVkQEi2X
         a9vjoRJt4XW6R3BQu2MaFeDiteBPwocHabY8CkXW/xjtwgaSNU31m6IGKTh+le5XX1Sm
         MMhrxUx1QOIYhnlOgnb8T5vgpYrSQE+66o2ObDYuicCtrGT/q4arWCRHX5V14OQVnuQ6
         b89MTBTcoBJHESR0yGbFDAZQky663x/RlSz1zbGwPXIytB9CmcUJamC7JWST/v/neQ4x
         8rUTl6DmiffeOFN0GfWGCnss1aGC/mTRw+1oUYLEOW+TAElEoXScmyGysnQaYOiHvChj
         w0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692072610; x=1692677410;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XekWSlNIMJA0Yurb+9+cWUybUA9oVXte/EYshLDfQI=;
        b=CbetCWeWHEbAUptbBom48+lY5002JsW30I4CtB5lKqHfJxRTZtNoVJJ9GCyQm++k6A
         j3LxRf5ewRZt73upPDlANPYHVTuWlk9uq0gmc0RX9d33k32IMtxRxnAk+jG4MzGe1VXI
         M7NE645qiWxbREdSIn0BegpdoEPWXZxsY1q88Xj8kpbyd09AkitIXj0fDKgfsTkPIXzU
         84I157wlDheHiLwkLhBQ701nf4++LLQSbdKWAQRX1069C3nyx6WVQh5+bdxiyVC/PTHk
         fEe+JaanEQcvF65v7vlRMLtX1M4yU3G9si1wUnSbyDPtTSckAo03J21LIPJAB1/R0gdb
         IVbg==
X-Gm-Message-State: AOJu0YzkkpLMBj6IbeQGkj+8DrXgMGvKBBNYm9NcL22+cOGEY+Yl0nEg
        ww4C46jzGW54eyhdzTUPizGTKLFdZhMjeFkktAs=
X-Google-Smtp-Source: AGHT+IG1z9LK1yAS6A/nUyLaW7b99JowCUR8mFCZHfmgNkTvsUdmRzqNF4fIdSRHRC+xFLNhafaIqw==
X-Received: by 2002:a05:6830:4b0:b0:6b5:8a98:f593 with SMTP id l16-20020a05683004b000b006b58a98f593mr11263194otd.8.1692072610137;
        Mon, 14 Aug 2023 21:10:10 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id om14-20020a17090b3a8e00b00268b439a0cbsm527929pjb.23.2023.08.14.21.10.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2023 21:10:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8AF0F706-B25F-4365-B9F2-8CA1BB336EC3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9F3DBAD2-58B2-4790-9BA3-033EB7A74001";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: optimize metadata allocation for hybrid LUNs
Date:   Mon, 14 Aug 2023 22:10:05 -0600
In-Reply-To: <87msz8wcm4.fsf@doe.com>
Cc:     Bobi Jam <bobijam@hotmail.com>, linux-ext4@vger.kernel.org
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <87msz8wcm4.fsf@doe.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_9F3DBAD2-58B2-4790-9BA3-033EB7A74001
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 3, 2023, at 6:10 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> Bobi Jam <bobijam@hotmail.com> writes:
>=20
>> With LVM it is possible to create an LV with SSD storage at the
>> beginning of the LV and HDD storage at the end of the LV, and use =
that
>> to separate ext4 metadata allocations (that need small random IOs)
>> from data allocations (that are better suited for large sequential
>> IOs) depending on the type of underlying storage.  Between 0.5-1.0% =
of
>> the filesystem capacity would need to be high-IOPS storage in order =
to
>> hold all of the internal metadata.
>>=20
>> This would improve performance for inode and other metadata access,
>> such as ls, find, e2fsck, and in general improve file access latency,
>> modification, truncate, unlink, transaction commit, etc.
>>=20
>> This patch split largest free order group lists and average fragment
>> size lists into other two lists for IOPS/fast storage groups, and
>> cr 0 / cr 1 group scanning for metadata block allocation in following
>> order:
>>=20
>> cr 0 on largest free order IOPS group list
>> cr 1 on average fragment size IOPS group list
>> cr 0 on largest free order non-IOPS group list
>> cr 1 on average fragment size non-IOPS group list
>> cr >=3D 2 perform the linear search as before

Hi Ritesh,
thanks for the review and the discussion about the patch.

> Yes. The implementation looks straight forward to me.
>=20

>> Non-metadata block allocation does not allocate from the IOPS groups.
>>=20
>> Add for mke2fs an option to mark which blocks are in the IOPS region
>> of storage at format time:
>>=20
>>  -E iops=3D0-1024G,4096-8192G
>=20

> However few things to discuss here are -

As Ted requested on the call, this should be done as two separate calls
to the allocator, rather than embedding the policy in mballoc group
selection itself.  Presumably this would be in ext4_mb_new_blocks()
calling ext4_mb_regular_allocator() twice with different allocation
flags (first with EXT4_MB_HINT_METADATA, then without, though I don't
actually see this was used anywhere in the code before this patch?)

Metadata allocations should try only IOPS groups on the first call,
but would go through all allocation phases.  If IOPS allocation fails,
then the allocator should do a full second pass to allocate from the
non-IOPS groups.  Non-metadata allocations would only allocate from
non-IOPS groups.

> 1. What happens when the hdd space for data gets fully exhausted? =
AFAICS,
> the allocation for data blocks will still succeed, however we won't be
> able to make use of optimized scanning any more. Because we search =
within
> iops lists only when EXT4_MB_HINT_METADATA is set in ac->ac_flags.

The intention for our usage is that data allocations should *only* come
from the HDD region of the device, and *not* from the IOPS (flash) =
region
of the device.  The IOPS region will be comparatively small (0.5-1.0% of
the total device size) so using or not using this space will be mostly
meaningless to the overall filesystem usage, especially with a 1-5%
reserved blocks percentage that is the default for new filesystems.

As you mentioned on the call, it seems this is a defect in the current
patch, that non-metadata allocations may eventually fall back to scan
all block groups for free space including IOPS groups.  They need to
explicitly skip groups that have the IOPS flags set.

> 2. Similarly what happens when the ssd space for metadata gets full?
> In this case we keep falling back to cr2 for allocation and we don't
> utilize optimize_scanning to find the block groups from hdd space to
> allocate from.

In the case when the IOPS groups are full then the metadata allocations
should fall back to using non-IOPS groups.  That avoids ENOSPC when the
metadata space is accidentally formatted too small, or unexpected usage
such as large xattrs or many directories are consuming more IOPS space.

> 3. So it seems after a period of time, these iops lists can have block
> groups belonging to differnt ssds. Could this cause the metadata
> allocation of related inodes to come from different ssds.
> Will this be optimal? Checking on this...
>     ...On checking further on this, we start with a goal group and we
> at least scan s_mb_max_linear_groups (4) linearly. So it's unlikely =
that
> we frequently allocate metadata blocks from different SSDs.

In our usage will typically be only a single IOPS region at the start of
the device, but the ability to allow multiple IOPS regions was added for
completeness and flexibility in the future (e.g. resize of filesystem).
In our case, the IOPS region would itself be RAIDed, so "different SSDs"
is not really a concern.

> 4. Ok looking into this, do we even require the iops lists for =
metadata
> allocations? Do we allocate more than 1 blocks for metadata? If not =
then
> maintaining these iops lists for metadata allocation isn't really
> helpful. On the other hand it does make sense to maintain it when we
> allow data allocations from these ssds when hdds gets full.

I don't think we *need* to use the same mballoc code for IOPS allocation
in most cases, though large xattr inode allocations should also be using
the IOPS groups for allocating blocks, and these might be up to 64KB.
I don't think that is actually implemented properly in this patch yet.

Also, the mballoc list/array make it easy to find groups with free space
in a full filesystem instead of having to scan for them, even if we
don't need the full "allocate order-N" functionality.  Having one list
of free groups or order-N lists doesn't make it more expensive (and it
actually improves scalability to have multiple list heads).

One of the future enhancements might be to allow small files (of some
configurable size) to also be allocated from the IOPS groups, so it is
probably easier IMHO to just stick with the same allocator for both.

> 5. Did we run any benchmarks with this yet? What kind of gains we are
> looking for? Do we have any numbers for this?

We're working on that.  I just wanted to get the initial patches out for
review sooner rather than later, both to get feedback on implementation
(like this, thanks), and also to reserve the EXT4_BG_IOPS field so it
doesn't get used in a conflicting manner.

> 6. I couldn't stop but start to think of...
> Should there also be a provision from the user to pass hot/cold data
> types which we can use as a hint within the filesystem to allocate =
from
> ssd v/s hdd? Does it even make sense to think in this direction?

Yes, I also had the same idea, but then left it out of my email to avoid
getting distracted from the initial goal.  There are a number of =
possible
improvements that could be done with a mechanism like this:
- have fast/slow regions within a single HDD (i.e. last 20% of spindle =
is
  in "slow" region due to reduced linear velocity/bandwidth on inner =
tracks)
  to avoid using the slow region unless the fast region is (mostly) full
- have several regions across an HDD to *intentionally* allocate some
  extents in the "slow" groups to reduce *peak* bandwidth but keep
  *average* bandwidth higher as the disk becomes more full since there
  would still be free space in the faster groups.

Cheers, Andreas






--Apple-Mail=_9F3DBAD2-58B2-4790-9BA3-033EB7A74001
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTa+p0ACgkQcqXauRfM
H+BaOQ//YlR2qA/iwDgUZgJNRh5C7iBFguPrKyC1IdbNWoXBbKUse1OulnZiYgPE
Y0OiDVGjcGTsTSs+1h6hBQDj3U7/5xOB2IOlxI7xX5Fejy9Ip15xnVYTGsLMN/qB
4CJ0yd0Si3/PHhL96Lk6B3xNjqqG3Lzsw2msLzE74KdgJHSM70Sm/k/q4ItR9x3g
Cey5TbDnNw++Z/mLilqhxpHdvF63MNm4iQovxMkVc4vEgfSyYe0LHKON65cDEvtK
0J7BDzS5U6HmW5NsTXmUmIC0NAHLNZqCgzOi/n7xpB7ofUUUdzLLPjHPqbXOyrYA
MBy6i+yDggkq0Baoe0UY02tv5fLS4X9QdFQul4wSw+JV+uOSivzZEurElN93uo9p
5Xn4YOwQXY8kqkMzw1CAqSzP1p+uaOQ4G0E3XESVtjqUQbYd1ML0Yf3XazZQlBw+
OHt3B/ox1WJz+gjxq4P7IEktbJ/DeOBsGq/nSJY9ISrCITRb4DFBL6Ze347vzDkD
usFb5v01sNYDaiJqn2/iQgs2HihAkWJM9mOUz/cGvzgYdM5FSP/LFfsd+YdcUf6H
6JV3LCMR6fExCBTVGeO3dXLg6rm2TKEBp8Siphp+r2FvF+tQKnG241rRB7z0GFCP
TN71rkTas/R7dD1E22a3UnvAUNHgmF0yZiTfGu97e261hWlotTE=
=h5FV
-----END PGP SIGNATURE-----

--Apple-Mail=_9F3DBAD2-58B2-4790-9BA3-033EB7A74001--
