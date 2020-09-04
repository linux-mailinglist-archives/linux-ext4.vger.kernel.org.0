Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBFF25E2FA
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Sep 2020 22:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIDUqz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Sep 2020 16:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgIDUqy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Sep 2020 16:46:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6378C061244
        for <linux-ext4@vger.kernel.org>; Fri,  4 Sep 2020 13:46:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p37so4923821pgl.3
        for <linux-ext4@vger.kernel.org>; Fri, 04 Sep 2020 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=myFuilDMcypamNNnUAV8SAfS0IZgTmYMPVDU6IAWNxQ=;
        b=05ELpjMqTiGc6T7J2okICQR4NldMShf+7h81AVOhljRjj5JB1uwqzSDaop8760h4gj
         5vrgy0MBF7zEoi66LiCeDpVYBtuIHxnGgTZQyXK2k5IXvi5+HrA0Au0ML8o1/M5kjbff
         prMwuYmAMNVZ+XBeo4M9Cpnedody/Juwmknrv7QF4GUSEwRzskCLeZechNSlZuyW5VNK
         zOSWTScvF1ZczMBcBxVhiU6gQe/mJcL5KD9WKa+qPqA4+5L+7oJN/IZcH23oHwxQ4ERN
         3i6+MsKLWHQJySpAQevpCE/I/iDWaBcvOqueQFOzKpV+eIYm0NR/4+3tgXo2j7v5sj8L
         6QqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=myFuilDMcypamNNnUAV8SAfS0IZgTmYMPVDU6IAWNxQ=;
        b=bM046QE16lCD/mu1K+ceTa1xRibeKSx3ywsF68YnYWjOJT/8Nr05XLT7RlR1gQn+8k
         seAO77rda1fPYfivkBzU8PF07JA/phT86PQKGuPaY6JxSzX/JoLs8saHwAqSnpLMNP9G
         ttAbhPCuFeW/xuT04iuidNGiLq1W/CDTKhiwYX1rGAcrxZuGE8RA28Tt4gTO92TWlE/l
         DdmR5wW6gapEDRVVvj1yRGmPEPbVq8vtbaV/ufq9dHVEiIH3YKnegSpbtOpABcyadksQ
         eoHmr4xl+cFLku3jywlFjWEQQMbyZw8VizxkCta6fkgRuRQbesvqAKemAcO+02iNCn3l
         RGPw==
X-Gm-Message-State: AOAM5323ygl3/8c5hud5ahCGFaxJ0aeFH8zu3eIpRq7FdmiyQm7jGkNV
        rjqK5egeL5+0Cj4dbbNVKUSL5w==
X-Google-Smtp-Source: ABdhPJxeezWqS76AYBUN8vJRyV7D4O34ii6SV34MUQrH1PUk2lZdjedS/DBD33Sm2GU0BMIRnNZ5sA==
X-Received: by 2002:aa7:93a8:0:b029:13c:1611:6534 with SMTP id x8-20020aa793a80000b029013c16116534mr8438175pff.6.1599252412707;
        Fri, 04 Sep 2020 13:46:52 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u5sm272041pfh.215.2020.09.04.13.46.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 13:46:51 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <459EE6E3-1CB2-4898-8C5F-283E821B2A75@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4D06B8B6-5BA9-44A7-A0A1-4E0109678C8C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: PROBLEM: potential concurrency bug in swap_inode_boot_loader()
Date:   Fri, 4 Sep 2020 14:46:48 -0600
In-Reply-To: <59AE9CA8-074C-4971-A857-175CA0E86420@purdue.edu>
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "Sousa da Fonseca, Pedro Jose" <pfonseca@purdue.edu>
To:     "Gong, Sishuai" <sishuai@purdue.edu>
References: <59AE9CA8-074C-4971-A857-175CA0E86420@purdue.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4D06B8B6-5BA9-44A7-A0A1-4E0109678C8C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Sep 4, 2020, at 9:57 AM, Gong, Sishuai <sishuai@purdue.edu> wrote:
> We found a potential concurrency bug in linux kernel 5.3.11. We were =
able to reproduce this bug in x86 under specific thread interleavings. =
This bug causes a =E2=80=9Cchecksum invalid=E2=80=9D EXT4-fs error.

I think there are two separate problems here, one that your test =
exposes,
and a larger an architectural conflict between swap_inode_boot_loader()
and metadata_csum.

The easier problem that your test code exposes is that the inode swap is
not "atomic" w.r.t. changing the data and updating the *inode* checksum, =
as
no sane user is going to be doing concurrent swaps on their bootloader =
inode
(race conditions would make it hard to know what the end result is).  =
This
also has an easy fix - add a mutex to ext4_sb_info and held at the start =
of swap_inode_boot_loader() to provide exclusion for the whole thing to =
avoid
access to the inode until the process is complete.  This is not =
performance
critical code.


The more complex issue (which you haven't hit, but initially I thought =
was
the culprit) is that there are checksums in the extent/index blocks that
use the inode number as part of the checksum seed, to allow detection of
incorrectly accessing extent metadata from the wrong inode, even if the
checksum of the contents would otherwise appear correct.

This means that the checksums for extents on the swapped inodes may need
to be updated as part of the swap to ensure that they are again valid, =
but
I don't see that being done anywhere.  The "swap" is merely copying the
contents of the in-inode block pointers between the two inodes, so it =
may
have the wrong checksums, if that feature is enabled.

If the bootloader inode is very large (over 512MB), or the allocation is
very fragmented and needs many extents to describe, it may also overflow
the maximum 4 extents that can fit directly into the inode.  That means
a traversal of the extent tree could be needed to update the checksums
in the index/extent blocks outside the inode itself.  However, this is
unlikely to be an issue for most systems, but could be hit in real =
usage.

One important question is whether the boot loader inode is actually used
by (m)any distros or not?  This would indicate how important this bug =
is,
or if this is currently only an academic exercise.  The easy workaround
would be to disable metadata_csum on the boot filesystem, but that isn't
very appealing.  Since concurrent swaps are already only a 0.000001%
issue, the mutex will fix those cases, but is unlikely to affect anyone.

The "fragmented and large" issue is more work to fix, and potentially an
issue that could be hit in real life.  I checked one of my systems and
see that /boot has kernels and initrd/initramfs in the tens of MB, and
filefrag shows them as having 1-4 extents.  Granted that my /boot fs is
small (190MB) it is harder to allocate contiguous extents.  When using
a boot inode inside a larger filesystem, that may be less of a concern,
but could still be hit, so will eventually also need to be fixed.

Cheers, Andreas

> ------------------------------------------
> Kernel console output
>=20
> EXT4-fs error (device sda1): swap_inode_boot_loader:124: inode #5: =
comm ski-executor:iget: checksum invalid
>=20
> ------------------------------------------
> Test input
>=20
> This bug occurs when a kernel test program is executed twice in =
different threads and ran concurrently. Our analysis has located that it =
happens when syscall ioctl with the EXT4_IOC_SWAP_BOOT flag is called =
twice and interleaves with itself.
> The test program is generated by Syzkaller as follows:
> r0 =3D creat(&(0x7f0000000080)=3D'./file0\x00', 0x0)
> ioctl$FS_IOC_SETFLAGS(r0, 0x40046602, &(0x7f0000000040))
> r1 =3D creat(&(0x7f0000000000)=3D'./file0\x00', 0x0)
> pwrite64(r1, &(0x7f00000000c0)=3D'\x00', 0x1, 0x1010000)
> r2 =3D creat(&(0x7f0000000000)=3D'./file0\x00', 0x0)
> ioctl$EXT4_IOC_SWAP_BOOT(r2, 0x6611)
>=20
> ------------------------------------------
> Interleaving
>=20
> Our analysis revealed that the following interleaving triggers the =
bug.
> CPU0								CPU1
> 									=
swap_inode_boot_loader()
> 									=
=E2=80=A6
> 										=
bytes =3D inode_bl->i_bytes;
>  										=
inode_bl->i_blocks =3D inode->i_blocks;
>  										=
inode_bl->i_bytes =3D inode->i_bytes;
> 								--->     =
	err =3D ext4_mark_inode_dirty(handle, inode_bl);
>=20
> 										=
ext4_mark_iloc_dirty() (fs/ext4/ioctl.c: 223)
> 										=
	ext4_do_update_inode()
> 										=
		ext4_inode_csum_set()
> 										=
			ext4_has_metadata_sum()
> 										=
				ext4_inode_csum()
> 										=
					ext4_chksum()
> 										=
						crypto_shash_update()
> 										=
							chksum_update()
> 									=
[context switch]
> swap_inode_boot_loader()
> 	ext4_iget()
> 		ext4_inode_csum_verify(fs/ext4/inode.c:4927)
> [EXT4-fs error]
>=20
>=20
>=20
>=20
> Thanks,
> Sishuai
>=20


Cheers, Andreas






--Apple-Mail=_4D06B8B6-5BA9-44A7-A0A1-4E0109678C8C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9Sp7kACgkQcqXauRfM
H+CCVhAAvzlnHObYZbz2goc9s5FvHBsjOpjatcSVskiK9BLiO6hno7Fw+mApNqu+
FJVX0kGdd3z5GwIhOvGzcG2g2ghepUIMBAPTU5ZM8LvdKI0YJ2qTZCcDxanjgMcK
5w+937lxAmgctE0I7ersGCBOxel8vuAZscECKU0zsREaWeRx+YKFON/nDRflbWvm
i3shfI+5/abRKndoeKb9RG036/4kjOUkW6sTQ/LbxtL4nhcbrscjDO+TKmGaxKTK
dWdQp5JjlLkUZF9YpfujHjKV0FinYwIXu7B6qmlNbVjSpeHoRILYh3OuEFMqgFeo
Foh20UGXiQM1a0ED7LmgNymjyFos8/YXAObHDIFJDM92eSsu70KBqs2WveDjp0Fk
JOrElyCn/WhQnkjdFeAunWDlNvqPIwMWIet37OBjCuYxBFklzjUo4mWg21F9MsJN
d9N89JjWPBbuGd3QR2kEa7yuzUYXVBORJOGNQrchuQ5uHJIZTvhjZSbiXYkb+ZME
LKKSGwd4/1mRz3/chqeyIXST+sOKMkEaz23FcInZarApe4UIR0mMCWmrHQPSWMKH
EPTr2RnW8TGjPbEitwliiXqgorTYjpF6GXJXF1ZURDW+iXf794VIcCyl+sIUkn49
pEdVlyVq60atQ+NeZLS6CbMedqq5tlx1QzwJuCQN+L99j1sWUYo=
=fzy8
-----END PGP SIGNATURE-----

--Apple-Mail=_4D06B8B6-5BA9-44A7-A0A1-4E0109678C8C--
