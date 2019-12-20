Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E931272B4
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2019 02:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLTBN3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Dec 2019 20:13:29 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:55025 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLTBN3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Dec 2019 20:13:29 -0500
Received: by mail-pj1-f49.google.com with SMTP id ep17so3342353pjb.4
        for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2019 17:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Jai7uigPqUL4YPUB+WsJ9AVMnMbwIv5GOyLJbKmVW7g=;
        b=DOLSzMKNiB8x76dofioL1GThHAgbNK7sLzSuiF4ePr2grgLOenowW6efSazzkOOOZj
         cS5I/5orGV6+OA6yurKdMhMHBoMSn/WsjRhhodSkK2paWMoAwpUrpsvXb+E1ldQ1GBIQ
         LBDfqCoviNyn0WQDy1uUmohxICleDW5p3JeEIKcUUEMx0LAzbkGXrnjvX3hyVilAw9Ix
         cXvRJs5UMfDU1zp1k0P/ckO8ZNrRwE0sjeE39EjpaoersRNzoi1FZacklXkgv4N0gJsM
         owvzmwBlqvk/I8e0XbYid7lipQEnQ4+X7DGAHoMSHnTM1gTBMSC8aQTfqGp7qayMj/4Y
         IkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Jai7uigPqUL4YPUB+WsJ9AVMnMbwIv5GOyLJbKmVW7g=;
        b=Ke4CuJM/EPn0xI5P+2ERwceT1GZt8O4PxXsoZkO4MPxEM+Un3StpDv20dt0GXUQfYB
         YxeVKpUM6EUYb1670r5L0w7w5K2MarOI/jBZGyzckIPzk6nds4msHAOI/iMVRVqOgeaJ
         DBa56ONEXCXs9INiqkN/CQBzUrOLfHsF2PTiQuSVp7LATrV8EsQtYWF20qLzTBQ+27t4
         2YV9hoEu+ReN6Nt8w0Mp/MYPIwcn7NAZ33vCyHzAxK+9I+RNItNn3oRWh/+3gihzLnok
         PdieYfk/1myZN1iRS9nekaHpFcTVghe5ErnvqdEcugihbPc2kTP1TV+Q+jfmUJ2mgsYA
         eG1g==
X-Gm-Message-State: APjAAAU+2MNGzEIlA2/vHNWWt2Yjd0i4PnMwWd+2oWUHtgVzeM7Eo+Cj
        0PydifpeBXNATxagfrdjjvU5e0+YDyAhDQ==
X-Google-Smtp-Source: APXvYqx7aNZxPKdrqMsDnY6NAxqjwIMZ+VI/RwsBwNLPXa5APNeaVkGm3ZmnLeZP9WP/kdPYDNpuTA==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr11725113pll.341.1576804408119;
        Thu, 19 Dec 2019 17:13:28 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id w66sm10295696pfw.102.2019.12.19.17.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 17:13:27 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F15C759F-AD76-43B6-99A4-1CE902FA3017@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_654D28AC-05FB-4971-9E59-0B8ED61BAACB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: 
Date:   Thu, 19 Dec 2019 18:13:22 -0700
In-Reply-To: <CAPnMXWX7LvMXWTTWf6WHSuOaU7EVVPRz88i-T0h9NBRy6imeKQ@mail.gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     liming wu <wu860403@gmail.com>
References: <CAPnMXWX7LvMXWTTWf6WHSuOaU7EVVPRz88i-T0h9NBRy6imeKQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_654D28AC-05FB-4971-9E59-0B8ED61BAACB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

These messages indicate your storage is not working properly.
It doesn't have anything to do with ext3/ext4.



> On Dec 19, 2019, at 5:31 AM, liming wu <wu860403@gmail.com> wrote:
>=20
> Hi
>=20
>=20
> Who can help analyze the following message . Or give me some advice, I
> will appreciate it very much.
>=20
> Dec 17 22:14:42 bdsitdb222 kernel: Buffer I/O error on device dm-7,
> logical block 810449
> Dec 17 22:14:42 bdsitdb222 kernel: lost page write due to I/O error on =
dm-7
> Dec 17 22:14:48 bdsitdb222 kernel: Buffer I/O error on device dm-7,
> logical block 283536
> Dec 17 22:14:48 bdsitdb222 kernel: lost page write due to I/O error on =
dm-7
> Dec 17 22:14:48 bdsitdb222 kernel: Buffer I/O error on device dm-7,
> logical block 283537
> Dec 17 22:14:48 bdsitdb222 kernel: lost page write due to I/O error on =
dm-7
> Dec 17 22:14:48 bdsitdb222 kernel: JBD: Detected IO errors while
> flushing file data on dm-7
> Dec 17 22:15:42 bdsitdb222 kernel: Buffer I/O error on device dm-8,
> logical block 127859
> Dec 17 22:15:42 bdsitdb222 kernel: lost page write due to I/O error on =
dm-8
> Dec 17 22:15:42 bdsitdb222 kernel: JBD: Detected IO errors while
> flushing file data on dm-8
> Dec 17 22:15:48 bdsitdb222 kernel: Aborting journal on device dm-7.
> Dec 17 22:15:48 bdsitdb222 kernel: EXT3-fs (dm-7): error in
> ext3_new_blocks: Journal has aborted
> Dec 17 22:15:48 bdsitdb222 kernel: EXT3-fs (dm-7): error in
> ext3_reserve_inode_write: Journal has aborted
> Dec 17 22:16:42 bdsitdb222 kernel: Aborting journal on device dm-8.
> Dec 17 22:16:42 bdsitdb222 kernel: EXT3-fs (dm-7): error:
> ext3_journal_start_sb: Detected aborted journal
> Dec 17 22:16:42 bdsitdb222 kernel: EXT3-fs (dm-7): error: remounting
> filesystem read-only
> Dec 17 22:16:48 bdsitdb222 kernel: Buffer I/O error on device dm-7,
> logical block 23527938
> Dec 17 22:16:48 bdsitdb222 kernel: lost page write due to I/O error on =
dm-7
> Dec 17 22:16:48 bdsitdb222 kernel: Buffer I/O error on device dm-7,
> logical block 0
> Dec 17 22:16:48 bdsitdb222 kernel: lost page write due to I/O error on =
dm-7
> Dec 17 22:16:48 bdsitdb222 kernel: JBD: I/O error detected when
> updating journal superblock for dm-7.
> Dec 17 22:17:05 bdsitdb222 kernel: EXT3-fs (dm-7): error in
> ext3_orphan_add: Journal has aborted
> Dec 17 22:17:05 bdsitdb222 kernel: __journal_remove_journal_head:
> freeing b_committed_data
>=20
> plus info:
> it's KVM
> # uname -a
> Linux bdsitdb222 2.6.32-279.19.1.el6.62.x86_64 #6 SMP Mon Dec 3
> 22:54:25 CST 2018 x86_64 x86_64 x86_64 GNU/Linux1
>=20
> # cat /proc/mounts
> rootfs / rootfs rw 0 0
> proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
> sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
> devtmpfs /dev devtmpfs
> rw,nosuid,relatime,size=3D8157352k,nr_inodes=3D2039338,mode=3D755 0 0
> devpts /dev/pts devpts rw,relatime,gid=3D5,mode=3D620,ptmxmode=3D000 0 =
0
> tmpfs /dev/shm tmpfs rw,nosuid,nodev,relatime 0 0
> /dev/mapper/systemvg-rootlv / ext4 rw,relatime,barrier=3D1,data=3Dordere=
d 0 0
> /proc/bus/usb /proc/bus/usb usbfs rw,relatime 0 0
> /dev/vda1 /boot ext4 rw,relatime,barrier=3D1,data=3Dordered 0 0
> /dev/mapper/systemvg-homelv /home ext4 =
rw,relatime,barrier=3D1,data=3Dordered 0 0
> /dev/mapper/systemvg-optlv /opt ext3
> rw,relatime,errors=3Dcontinue,barrier=3D1,data=3Dordered 0 0
> /dev/mapper/systemvg-tmplv /tmp ext3
> rw,relatime,errors=3Dcontinue,barrier=3D1,data=3Dordered 0 0
> /dev/mapper/systemvg-usrlv /usr ext4 =
rw,relatime,barrier=3D1,data=3Dordered 0 0
> /dev/mapper/systemvg-varlv /var ext4 =
rw,relatime,barrier=3D1,data=3Dordered 0 0
> /dev/mapper/datavg-datalv /mysql/data ext3
> rw,relatime,errors=3Dcontinue,barrier=3D1,data=3Dordered 0 0
> /dev/mapper/datavg-binloglv /mysql/binlog ext3
> rw,relatime,errors=3Dcontinue,barrier=3D1,data=3Dordered 0 0
> none /proc/sys/fs/binfmt_misc binfmt_misc rw,relatime 0 0
> sunrpc /var/lib/nfs/rpc_pipefs rpc_pipefs rw,relatime 0 0
> none /sys/kernel/debug debugfs rw,relatime 0 0
>=20
> # ll /dev/mapper/
> total 0
> crw-rw---- 1 root root 10, 58 Dec 19 19:21 control
> lrwxrwxrwx 1 root root      7 Dec 19 19:21 datavg-binloglv -> ../dm-3
> lrwxrwxrwx 1 root root      7 Dec 19 19:21 datavg-datalv -> ../dm-2
> lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-homelv -> ../dm-4
> lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-optlv -> ../dm-7
> lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-rootlv -> ../dm-1
> lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-swaplv -> ../dm-0
> lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-tmplv -> ../dm-6
> lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-usrlv -> ../dm-8
> lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-varlv -> ../dm-5


Cheers, Andreas






--Apple-Mail=_654D28AC-05FB-4971-9E59-0B8ED61BAACB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl38IDIACgkQcqXauRfM
H+Dd+g//ZVCcACTjSkLABqaVOLGUROVjWf+YUZz8vunNeUGzkC75bcZqjLoa98Vj
ds94ja4n8RNOhbVauStvGVTK90TxHes5pgqwb7toMvMGuN0J5JlcaADRZ/RTew2x
dTIUG2ukWj/DnaIlklwW1rTgH0cU4rxr6zkv9G7wIIv0/qgBaXNgrr3OAPzM3JVf
Ba8VdZ61M+Z2siDHyimBGMfUldHphsYhYoWvjj5rcmooM26WF6LNYvw0rqdsrDp5
B9pBOtfPrEKp7jNAAeD7aRv6ScKmDiiEHRMJY83vNgC/WnRX7QU+HU1vIK6JDdQD
SydkGKXaLtmZskhA3MCQZc2mSBXiyeEHuCjB1+eRYxzODRi67sdqQ20WtCbaRKfs
OFRkNJZz/bqHnWkzvPgtXW6MvUWQL/GONsVZp6Uhj8dchfbhnU8ff41ra4ixSgwQ
0RMUKxKGpCoz1Z4J+dypdeomTxs0MKBOk7+IQUtwBMIQcdh2bqxHxeEzuo6AsDIZ
5H4LT6OqwYwWHJb2uxAqolpHDwY6ZDp8dEn31CylGC/gxXaESbMAIPMcXPKWn9Y9
VkyGGEbPsClC1euzyeBeUWxxg7fU2ejDLabIHqkHwf1YBYulq0CFFbFjolRt4FIN
l7Fj5wfXAfMV+Uittbw0Vnlvq5go0au9C9EJ42kB7un0Y2diLlI=
=MxFB
-----END PGP SIGNATURE-----

--Apple-Mail=_654D28AC-05FB-4971-9E59-0B8ED61BAACB--
