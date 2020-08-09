Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3457D23FC95
	for <lists+linux-ext4@lfdr.de>; Sun,  9 Aug 2020 06:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgHIEcz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Aug 2020 00:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgHIEcy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Aug 2020 00:32:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB4AC061756
        for <linux-ext4@vger.kernel.org>; Sat,  8 Aug 2020 21:32:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so3138795pgh.3
        for <linux-ext4@vger.kernel.org>; Sat, 08 Aug 2020 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=kknXUs0CYy/ydtgYvE8vP2HIAC3lr88TssIJlLUZIys=;
        b=rAKkePaK+KAqThzRx3W7ncitYlJEWXDgwSfyFkpdqgoZYTb8zpjS6i8Z4Ud1h/mITJ
         Y+tx2vhR4Q0/NZdoaUUMfQjen7q5WSt71nRNnyTu7MSuhS4qSoZdePS+s6TD22pJ/7+M
         OtGlS8fBB3mFayX4m1B2lN+/+WofGklTwfjIQqhwTpN3vsbW8XPd5oLgeaGihuEqbWbC
         Lr+0n9Pxy+2QvExpnmDQp5I6WZC6BZH6U8E/EsdmKLLf2BQSNeb0LuE6mvRIL3nOiMZf
         M8E5LPxWdUEzFkX6LPyQgsb/f32lcOytHCc2YFvKpgiWDlh9L/AVN8M8DKSI56QHAgzb
         T5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=kknXUs0CYy/ydtgYvE8vP2HIAC3lr88TssIJlLUZIys=;
        b=CKWX1yWwV7gd+AVQsqf7vkfy+CqcQCwlRbPw9nbaS+7kuTJOrRh29rg3ajE7CkHz8A
         VFLZmI5N/to/VRBfvn3228aSaSJPJgKC0ZNTPxmco8xpujz6z9fXaFJP53rJ2EEVjJkt
         yFxpH+bIStgAsP/1BCHzkxNfK59pA0mJ6g6eLYyiz1g1rSkqzynucRxjKezP5fdwMV3D
         5cOB/4hx+3qhnDpbfvOKgB+CkCeD7ZeTKKLDkrA/0FsjKLAqeY8xL7LtvVdWyxqA6GNu
         EfcsA31aDKqwNtFDz9JT8g14vMBtAMj6DwTnFdaXMpuvE1vPtUVWoLOP2xcleXoxg6gX
         Pcow==
X-Gm-Message-State: AOAM530F5ejGAynxM1ZR9yP5O23xnq7YGMPcKVllPCgYSer2q6PM3ouI
        F2sXoFQr2t7y/PRlMXki0pOJHQ==
X-Google-Smtp-Source: ABdhPJynip03hBADZzgu+qxtphxtoDQD1yK3tHJYDHd8afYWL14+HkH2p5HhnT5D7P7KZC2g3I8oUQ==
X-Received: by 2002:a65:6381:: with SMTP id h1mr17977414pgv.0.1596947573741;
        Sat, 08 Aug 2020 21:32:53 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id d93sm16006221pjk.44.2020.08.08.21.32.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 21:32:52 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9789BE11-11FB-42B2-A5BE-D4887838ED10@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DB192F4F-721E-472E-9956-769DE2663962";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 1/2] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize
 trim
Date:   Sat, 8 Aug 2020 22:33:08 -0600
In-Reply-To: <20200808151801.GA284779@mit.edu>
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>
To:     tytso@mit.edu
References: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
 <20200806044703.GC7657@mit.edu>
 <CAP9B-Qnv2LXva_szv+sDOiawQ6zRb9a8u-UAsbXqSqWiK+emiQ@mail.gmail.com>
 <20200808151801.GA284779@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_DB192F4F-721E-472E-9956-769DE2663962
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 8, 2020, at 9:18 AM, tytso@mit.edu wrote:
>=20
> On Sat, Aug 08, 2020 at 09:29:50AM +0800, Wang Shilong wrote:
>>> I suppose the question is whether the sysadmin really wants unused
>>> blocks to be discarded, either to not leak blocks in some kind of
>>> thin-provisioned storage device, or if the sysadmin is depending on
>>> the discard for some kind of security/privacy application (because
>>> they know that a particular storage device actually has reliable,
>>> secure discards), and how does that get balanced with sysadmins =
think
>>> performance of fstrim is more important, especially if the device is
>>> really slow at doing discard.
>>=20
>> Yup, that is good point, for our case, fstrim could take hours to =
complete
>> as it needs extra IO for disk arrays, so we really want repeated =
fstrim.
>>=20
>> So what do you think extra mount option or a feature bit in the =
superblock.
>> In default, we still keep ext4 in previous behavior, but once turned
>> on it, we have this optimized  "inaccurate" optimizations.
>=20
> So what I was thinking was we could define a new flag which would be
> set in es->s_flags in the on-disk superblock:
>=20
> #define EXT2_FLAGS_PERSISTENT_TRIM_TRACKING 0x0008
>=20
> If this flag is set, then the EXT4_BG_WAS_TRIMMED flags will be
> honored; otherwise, they will be ignored when FITRIM is executed and
> the block group will be unconditionally trimmed.
>=20
> The advantage of doing this way is that we don't need to allocate a
> new feature bit, and older versions of e2fsck won't have heartburn
> over seeing a feature bit it doesn't understand.  I also suspect this
> is something that the system administrator will either always want
> enabled or disabled, so it's better to make it be a tunable to be set
> via tune2fs.
>=20
> The other thing we could do is to define a new variant of the FITRIM
> ioctl which will also force the unconditional trimming of the block
> groups, so that an administrator can force trim all of the block
> groups without needing to mess with mounting and unmounting the
> superblock.
>=20
> What do you think?

What about storing "s_min_freed_blocks_to_trim" persistently in the
superblock, and then the admin can adjust this as desired?  If it is
set =3D1, then the "lazy trim" optimization would be disabled (every
FITRIM request would honor the trim requests whenever there is a
freed block in a group).  I suppose we could allow =3D0 to mean "do not
store the WAS_TRIMMED flag persistently", so there would be no change
for current behavior, and it would require a tune2fs option to set the
new value into the superblock (though we might consider setting this
to a non-zero value in mke2fs by default).



The other thing we were thinkgin about was changing the "-o discard" =
code
to leverage the WAS_TRIMMED flag, and just do bulk trim periodically
in the filesystem as blocks are freed from groups, rather than tracking
freed extents in memory and submitting trims actively during IO.  =
Instead,
it would track groups that exceed "s_min_freed_blocks_to_trim", and trim
the whole group in the background when the filesystem is not active.

Cheers, Andreas






--Apple-Mail=_DB192F4F-721E-472E-9956-769DE2663962
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8vfIUACgkQcqXauRfM
H+CGPA//X8gsqVl6kIp+YUZpFGxUrC35riV+xiM5z3R3Sukea42jzNpUnbT4aX66
AfWcPt3UEoQjgNHQMQ1TqLy/t2HRgUtCkwx5xwSftVLzejtxiZ/hqp/cNBSumUQQ
48s4K7eWJm0OeZy2TodCVgORnosYvGDjG0kQLtpr5t80er2xldut00unIUNhB8jb
qByH6MYIKQ+crCxTAl/6Yqd+9UAlX86HmMJYvgkwuVPdgoKHhM17+CkhY4EuPIKE
sDRezS5tTdW7j6zCNNRYio6YxgdjMJLhUoLw9fnwBtEpBz/7MTL10YOwOk8C1qq/
aoiIbWnObdzfVqSx+teJGlCQ6laIgBI9SWpgxi2P81vt+vjOM+rUZ0RLG4nkvPX8
QcQFQlhZRwaqiIpbNUoFCQ/YnLpi94yA+tvsHOsyNoh1eidyL7/wOD48a49jMXQE
mksIUoD9lOK4AoFEIqh9nLQgXeXsFsZTYFEI14+PLWhUqJlap12lWfpatTykwor0
bpnX/qSYPsTpX7i9n6KjH26sx6eCycIYerH2/fe5XbjJLMtI1MAU61B0y5apfcPY
WwfcmTkWOfOYZ3Ycz7ti5Zdf7Pz1Pba6JzEz6KgQCT6LaC0aNCIYICBJ5dYjy/DU
ROqhvXHE317Rg6t474+BQYhsmiwAK4UT7RF0ARbp98rsNSkbvgI=
=uvhk
-----END PGP SIGNATURE-----

--Apple-Mail=_DB192F4F-721E-472E-9956-769DE2663962--
