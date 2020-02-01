Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C3314F664
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2020 05:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgBAEHr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Jan 2020 23:07:47 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:44732 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgBAEHr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Jan 2020 23:07:47 -0500
Received: by mail-pl1-f179.google.com with SMTP id d9so3587917plo.11
        for <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2020 20:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:subject:message-id:date:cc:to;
        bh=zAbmiwgPDgJ20WL5HTVlc7uPMUxuJ7MTjvjYNkKdbVc=;
        b=G0QSevO/OtXIyMF69BeVZ3np71qjUoQcuL0utY5ajrExmmOCgwZnTfoqbsbzFkKGMm
         35iOaifSzjrSuNDQJdpCdKnSv9j1WVTZFF3mJvdYKN74X5kiKOgzWoknt/ERnSvETes9
         bmqE3AUgZv2DixQkf8CMHq+K8k1rbsQlNkiz1+l/26orznxqyPQsR+dlqhsVklx0uSlP
         RAfBaBK/G7pwlcq3EaZckeqk0rgA77JomEgPeLoXbv+OZy8FNmlv6Bia1dcCkkXLWlRD
         ZjxlhXjRWaQ6GjCdg615JZo2g0jlS2i2yLjDxg08SJWuGZEhDobQpbRnioJZUY5SdoUW
         EmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:cc:to;
        bh=zAbmiwgPDgJ20WL5HTVlc7uPMUxuJ7MTjvjYNkKdbVc=;
        b=pqPBJbhMROUp1cqqQCRdO/U1nVU3Keqxt8+0BVs28f272xBZoHwCz5Vsg9oRmNUpY2
         IJDKSAyAek86V76Ca9KgH800/UK55A2yPS0y2xhjrFivDo5rZOqytW0fZn/OKL+Cm/Ru
         uvYmI1IdHcwuSLocFr4fixFhtdNSFayvmno4iiYAsZGBAkjQCUu5V5wdmzPgimS59XEl
         2yWFxiKAK1YSZ36qGXEzuPvQYZx2svLjx61Oyp4E1a+Gg2lpOrYws9X75CVE6OVS29n3
         piUduiQHfPY9KC/i4dFayfZDnsjq5OarKLrRLx+ikCVCkpHtSBw4AV3D2r/0tfPqVcNl
         Xaew==
X-Gm-Message-State: APjAAAVKPIFv+0kZyFjX6g+n+I08rKkmtGQQnZdmyEsefQGd0TRs8xrR
        wFTJxsj8OAq/ofE9T2RVDM5BR9dLIYXHuQ==
X-Google-Smtp-Source: APXvYqxa9ysychrJuZUEoIqO7NhgciY1rrgtvF5GuiLSbEcujxugFo51/klOgNG1vENDmHlRK7IqSA==
X-Received: by 2002:a17:90a:5d85:: with SMTP id t5mr16344475pji.126.1580530066077;
        Fri, 31 Jan 2020 20:07:46 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 6sm11885328pgh.0.2020.01.31.20.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 20:07:45 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_265A083A-375E-42B9-A5C0-B43CA36AE901";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: e2fsck dir_info corruption
Message-Id: <00CED351-2128-4DF8-B286-7774CCC1FC0A@dilger.ca>
Date:   Fri, 31 Jan 2020 21:07:42 -0700
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_265A083A-375E-42B9-A5C0-B43CA36AE901
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I've been trying to track down a failure with e2fsck on a large =
filesystem.  Running e2fsck-1.45.2 repeatedly and consistently reports =
an error in pass2:

Internal error: couldn't find dir_info for <ino>

The inode number is consistent across multiple runs, but examining it =
with
debugfs shows that it is a normal directory with no problems.  In order =
to
complete the e2fsck, we tried using "debugfs -w -R 'clri <ino>'" to =
erase
the inode, but this just shifted the error onto a slightly later =
directory
(which would itself now be reported consistently).

The filesystem is 6TB with 2.3B inodes, about 1.8B of which are in use.  =
The
inode numbers reporting problems are in the range of 1.2B.  e2fsck is =
using
about 45GB of RAM (with some swap on an NVMe SSD, so much faster than =
the
HDD the filesystem image is on).  It takes about 3-4h to hit this =
problem.

I was able to run e2fsck under gdb, though this slows it down =
significantly
(10-100x slower), if there are conditional breakpoints since they need =
to
be evaluated for each inode, which makes it impossible to use this way.

What I've discovered is quite interesting.  The ctx->dir_info->array is
filled in properly for the bad inode, and the array is OK at the start =
of
pass2 (2 is the root inode, and $66 holds the bad inode number):

    (gdb) p e2fsck_get_dir_info(ctx, 2)
    $171 =3D (struct dir_info *) 0x7ffabf2bd010
    (gdb) p *$171
    $172 =3D {ino =3D 2, dotdot =3D 0, parent =3D 2}
    (gdb) p $66
    $173 =3D 1222630490
    (gdb) p e2fsck_get_dir_info(ctx, $66)
    $174 =3D (struct dir_info *) 0x7ffb3d327f54
    (gdb) p *$174
    $175 =3D {ino =3D 1222630490, dotdot =3D 0, parent =3D 0}

The dir_info array itself is over 4GB in size (not sure if this is =
relevant
or not), with 380M directories, but the bad inode is only about half way
through the array ($140 is the index of the problematic entry):

    (gdb) p $140
    $176 =3D 176197275
    (gdb) p p ctx->dir_info->array[$140]
    $177 =3D {ino =3D 1222630490, dotdot =3D 0, parent =3D 0}
    (gdb) p *ctx->dir_info
    $178 =3D {count =3D 381539950, size =3D 381539965,
      array =3D 0x7ffabf2bd010, last_lookup =3D 0x0,
      tdb_fn =3D 0x0, tdb =3D 0x0}
    (gdb) p $178.count * sizeof(ctx->dir_info->array[0])
    $179 =3D 4578479400

I put a hardware watchpoint on the ".parent" and ".dotdot" fields of =
this
entry so that I could watch as e2fsck_dir_info_set_dotdot() updated it,
but I didn't think to put one on the ".ino" field, since I thought it =
would
be static.

    (gdb) info break
    Num     Type           Disp Enb Address    What
    15      hw watchpoint  keep y              -location $177->parent
    16      hw watchpoint  keep y              -location $177->dotdot

The watchpoint triggered, and saw that the entry was changed by =
qsort_r(),
which at first I thought "OK, the dir_info array needs to be sorted, =
because
a binary search is used on it", but in fact the array is *created* in =
order
during the inode table scan and does not need to be sorted.  As can be =
seen
from the stack, it is *another* array that is being sorted that =
overwrites
the dir_info entry:

    Hardware watchpoint 16: -location $177->dotdot

    Old value =3D 0
    New value =3D 1581603653
    0x0000003b2ea381f7 in _quicksort ()
       from /lib64/libc.so.6
    (gdb) p $141
    $179 =3D {ino =3D 1222630490, dotdot =3D 0, parent =3D 0}
    (gdb) bt
    #0  0x0000003b2ea381e1 in _quicksort ()
      from /lib64/libc.so.6
    #1  0x0000003b2ea38f82 in qsort_r ()
      from /lib64/libc.so.6
    #2  0x000000000045447b in ext2fs_dblist_sort2 (
        dblist=3D0x6c9a90,
        sortfunc=3D0x428c3d <special_dir_block_cmp>)
        at dblist.c:189
    #3  0x00000000004285bc in e2fsck_pass2 (
        ctx=3D0x6c4000) at pass2.c:180
    #4  0x000000000041646b in e2fsck_run (ctx=3D0x6c4000)
        at e2fsck.c:253
    #5  0x0000000000415210 in main (argc=3D4,
        argv=3D0x7fffffffe088) at unix.c:2047
    (gdb) p ctx->dir_info->array[$140]
    $207 =3D {ino =3D 0, dotdot =3D 1581603653, parent =3D 0}
    (gdb) f 3
    #3  0x00000000004285bc in e2fsck_pass2 (
        ctx=3D0x6c4000) at pass2.c:180
    180       ext2fs_dblist_sort2(fs->dblist, special_dir_block_cmp);

AFAIK, the ext2fs_dblist_sort2() is for the directory *blocks*, and =
should
not be changing the dir_info at all.  Is this a bug in qsort or glibc?

What I just noticed writing this email is that the fs->dblist.list =
address
is right in the middle of the dir_info array address range:

    (gdb) p *fs->dblist
    $210 =3D {magic =3D 2133571340, fs =3D 0x6c4460,
      size =3D 763079922, count =3D 388821313, sorted =3D 0,
      list =3D 0x7ffad011e010}
    (gdb) p &ctx->dir_info->array[0]
    $211 =3D (struct dir_info *) 0x7ffabf2bd010
    (gdb) p &ctx->dir_info->array[$140]
    $212 =3D (struct dir_info *) 0x7ffb3d327f54

which might explain why sorting dblist is messing with dir_info?  I =
don't
_think_ it is a problem with my build or swap, which is different from
the system that this was originally reproduced on.

Any thoughts on how to continue debugging this?

Cheers, Andreas






--Apple-Mail=_265A083A-375E-42B9-A5C0-B43CA36AE901
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl40+Y8ACgkQcqXauRfM
H+DZhBAAmaTVseNMFhTtm7oFfggyFRvSCy5t3zxzIwxSQ323FHhyxu4fsvA8UbFm
0fKZowPmAu/lGBbnuOeR6VLuw2mu5P+vFgGDMj0zjnHP3BfGPzKuImVMzyyCN/VI
TZjNecRvnbrOciQB/ZTPztwa3TevJtIPwG5q30gQmPbmJN779YOBe2VqHCIkNDXq
RMONTtlchfYiD4cF6MpE49mHJ7dIMX7cIImGyoZpB2NvXKTfKdu0j8gAsejLm1vc
czxIPMusitklU0vxQsiMGSE7mv8Aki/6BvJJN3cNFeizydp6HRLUXJtt3dPa7hRu
rvAlGvAVIekMm/LolOv87mu5j6syDFcGwfZwsMi5ZMDL6+w/7YdkVi0i6edpJuQz
/lZnNVkxpjsbQFAallhTS86aQSGX+N+cgShjil/Vaf4jIlF5Nya09m2lOL4A8ymB
eVvqhFRWctJu4aVayG3scLmQrX06PV6nVn93fptil74xiKDz4cAaTG032p0L/wCK
cT/ik9yBa/olVFcP5iH47RTETNVY03PttGIOwV7TzAx75+rvgdo7grVe166loWvD
pH31CWNC447jlLYArgLPMrABlR/s8KoccJO/tUsF8g3v6bvGa4LS39wUHxIbfgGA
yKyxsH7c4BmpNWdg1L3uHBg0Qk8zsTNhSj83vKeUrbaXVpbIaSA=
=Wir1
-----END PGP SIGNATURE-----

--Apple-Mail=_265A083A-375E-42B9-A5C0-B43CA36AE901--
