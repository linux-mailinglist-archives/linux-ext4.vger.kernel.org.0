Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523D377C6BC
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 06:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjHOEci (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 00:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjHOEcH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 00:32:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85088BB
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 21:32:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc73a2b0easo32294355ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1692073924; x=1692678724;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=f8P5nWTwrERnMb9sz1tb57Keeo64MCjaB9ZGtxO3GC8=;
        b=ImBQFjRirCCf28tFdVUlIjXkwk+Nud/H7wlK4wQvpw4hd6ESRvxdxrYvC1MyrE27rX
         cofAyv8Gb6D9SJoURqzGldR2UTr30haHF7aPB9I/iI8YdLMAHOYa49NjpRLozjl9V1r/
         diyuPzV+QevOa12ZP3pL/lT2CGL7W6AhwB/Y09tm/hvL5kRow8eJz5u00gRTM7IxJsh7
         GOtLSoFvgny1k/MQAV6y34omL6tvFqgZWyAlZCxtS7VQkAKwlOKyRexByyFuVvY+QqXS
         E1tTHph2tvm79K5q0OlaYB8NR8tIL3s0Mh8gKHQ62OZnnMguFC0TbqFoPtXf0yKVRqXr
         IghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692073924; x=1692678724;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8P5nWTwrERnMb9sz1tb57Keeo64MCjaB9ZGtxO3GC8=;
        b=Rj/ylAgY6pxynxJ6TAvmJouEE2eE/7+FOdW6IYoL/0z3SsFNSlLyGufE9mdCoLkYKZ
         Z5XBFhpvOoKHXSr0i8kOcVNyHfELbK+swJ7cUIARDJ+EdrhDI3lZ990v9jt/VLRMXJ+d
         zCe4Azel2UdVAkhIOPWdqesMCPg1EjcLRFat4H6QY6OsXf14fZ4G1C1BChgyxJn9qzJX
         yhhX7NGmzRYYYSeTYwA/DhAHX1Ld+xfSp3DPutS+6pNT6kSqF+ruQlCQc2MIBHzevq0d
         8Vf9yT+5+Cb0OGtKt/xI78LwMuRJp8EoxWav76sfY9mRCiMHc+lkOJy73AfL909MVnI3
         2Nkg==
X-Gm-Message-State: AOJu0YygVUOqtI6H9bmiDTPiWdxDVRw3KiHut+YkNIgH5BSdEB3jROna
        0CRdK0lGND+AFi7EsinIhP2QCA==
X-Google-Smtp-Source: AGHT+IEDc7/2ChCc54/jXXQwZS/fiG/LE0CcaD6wAg7b/4xnqBoYZF07Qj+pgdjfOZEORshjOgcRLQ==
X-Received: by 2002:a17:902:8c8c:b0:1b8:9b90:e2bc with SMTP id t12-20020a1709028c8c00b001b89b90e2bcmr8581436plo.52.1692073923896;
        Mon, 14 Aug 2023 21:32:03 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001b8a3dd5a4asm388456plb.283.2023.08.14.21.32.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2023 21:32:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E1C33FC3-CEF7-458E-AC1F-FAA3223D2CBB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_126CC69E-B366-4056-BAD7-C21538F0AB3E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: introduce EXT4_BG_TRIMMED to optimize fstrim
Date:   Mon, 14 Aug 2023 22:32:00 -0600
In-Reply-To: <20230811183558.GA1528742@mit.edu>
Cc:     Li Dongyang <dongyangli@ddn.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Shuichi Ihara <sihara@ddn.com>, wangshilong1991@gmail.com
To:     Theodore Ts'o <tytso@mit.edu>
References: <20230811061905.301124-1-dongyangli@ddn.com>
 <20230811183558.GA1528742@mit.edu>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_126CC69E-B366-4056-BAD7-C21538F0AB3E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 11, 2023, at 12:35 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Fri, Aug 11, 2023 at 04:19:04PM +1000, Li Dongyang wrote:
>> Currently the flag indicating block group has done fstrim is not
>> persistent, and trim status will be lost after remount, as
>> a result fstrim can not skip the already trimmed groups, which
>> could be slow on very large devices.
>>=20
>> This patch introduces a new block group flag EXT4_BG_TRIMMED,
>> we need 1 extra block group descriptor write after trimming each
>> block group.
>> When clearing the flag, the block group descriptor is journalled
>> already so no extra overhead.
>=20
> If we journalling is enabled (and it normally is enabled) then there
> is also writes to the journalling.  Updating the block group
> descriptor is also a random 4k write, which is not nothing.  So if we
> are going to do this, then we should not try to set the flag if the
> block group is unitialized, and we should actually send the discard in
> that case, since presumably the blocks in question were discard when
> the file system was mkfs'ed.

Sorry Ted, I'm not sure I understand your comment here.  If the device
is trimmed at mke2fs time, then the BG_TRIMMED flags are set in the
group descriptors, so if the flag is still set then no need to TRIM
those groups later.

The comment about "no extra overhead" is in the case of clearing the
BG_TRIMMED flag when freeing blocks.  In that case, the group =
descriptors
are already being updated with the new blocks count, so there is no
overhead to clear the BG_TRIMMED flag at the same time.

Definitely there is an extra GDT write after TRIM to set the BG_TRIMMED
flag, but since fstrim is done sequentially for groups it is likely that
multiple groups in a single GDT block would be updated at the same time,
so the overhead is relatively small.

>> Add a new super block flag EXT2_FLAGS_TRACK_TRIM, to indicate if
>> we should honour EXT4_BG_TRIMMED when doing fstrim.
>> The new super block flag can be turned on/off via tune2fs.
>=20
> I don't see the point of having the superblock flag.  It seems to me
> that either we should either do this via a proper feature flag, which
> means that older kernels (and grub bootloaders that get release
> updates at a super-lackadasical pace) won't touch file systems that
> have the feature flag set --- or we don't have any kind of flag at
> all, and kernels and userspace utilities which are EXT4_BG_TRIMMED
> enlightened will honor and set/clear the flag.

In the previous email thread about the persistent BG_TRIMMED flag,
you were requesting a superblock flag and not a full feature, to avoid
the incompatibility issues with a new feature for this:

=
https://patchwork.ozlabs.org/project/linux-ext4/patch/1592831677-13945-1-g=
it-send-email-wangshilong1991@gmail.com/#2502168

   "So what I was thinking was we could define a new flag which
    would be set in es->s_flags in the on-disk superblock:

    #define EXT2_FLAGS_PERSISTENT_TRIM_TRACKING 0x0008

    If this flag is set, then the EXT4_BG_WAS_TRIMMED flags will
    be honored; otherwise, they will be ignored when FITRIM is
    executed and the block group will be unconditionally trimmed.

    The advantage of doing it this way is that we don't need to
    allocate a new feature bit, and older versions of e2fsck won't
    have heartburn over seeing a feature bit it doesn't understand.
    I also suspect this is something that the system administrator
    will either always want enabled or disabled, so it's better to
    make it be a tunable to be set via tune2fs."

> This risk if we go down that path is that if we have a file system
> which is normally used by a kernel that has support for this feature,
> and that file system is mounted by an older kernel which doesn't have
> this flag, there might be cases where the file system would be trimmed
> without setting these flags, or blocks might get released on a block
> group without clearing the flag.  Fortunately, trim is advisory, so if
> we trim a block group that doesn't need it, or we don't trim a block
> group where discard might be useful, it's not the end of the world.
> And we could always have "e2fsck -E discard" ignore the
> EXT4_BG_TRIMMED flag, and just trim all the blocks[1].

I'm OK with the superblock flag.  Since TRIM is advisory you aren't
going to lose data or corrupt the filesystem if the flags are wrong.
At worst, some TRIM will be skipped until upgrading to a new kernel
or the flag is disabled in the superblock, but this is a corner case.

Cheers, Andreas






--Apple-Mail=_126CC69E-B366-4056-BAD7-C21538F0AB3E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTa/8EACgkQcqXauRfM
H+Ay5RAAhojsGAXDIVBOFdAmuSxfHaqKXYU8E8MSeZoxn0tlyrZOi1Ia5h5oZfpD
Vg200hI3wvqZKCGLso1QJ70yVxzaImGDwz08N9kKQZOZdUZClcKo745no6z47A0V
BVKizH5A1u4/RHEWgDmwVL/4fP5BZ/+jtPMW4LGOhIUi3Z6xkI6gpEOoLqZjoQnM
25dp2c8STaGWwmX/eRsUpwNQDGy0Kh4HNiuhHbt1lU+ZzznBWDFtMwmwzWmfJIEr
9z0FdMF4KKNiug2PApKhJ/BPtwMet1bLhq/r6CNNL1hf11c7uN9AznIEq4QCdxvY
FSNIYD/uH4xq9ZT2a5hJ9ukXcTqyYf5t1U0WHmGB9biQZNsDoKT1A+OzmYbj9j/B
shoaIRzx3EgjNN0/FTKrVQhTC/0Uc72UJ+Czt5mtuGSX22lJIeCD12XSaVTM8ZCB
DLnCQEIEBplBN3hBOESFnm/dCbD8ePxPKagWlt3XUI30DCm8h96DaBVgrIgvZcVn
I0Ci17ag1O9StZhFUwopEZ0Ya+BH/XeRQrxksFOXA/dDLZ+ew1FxBSV5ZUs0lrBe
aINX3EFOTImKuPpWVOpdo0tWSCXWLef0CeCRiZSeUe0PXbUWgH2ctssJ43pZdj2S
O819M5FflS2kBxDLSAgYnvpiqLXpaOscY/dZbA0wlhttlEI/Q74=
=AXAJ
-----END PGP SIGNATURE-----

--Apple-Mail=_126CC69E-B366-4056-BAD7-C21538F0AB3E--
