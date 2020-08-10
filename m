Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8B24071A
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgHJOAy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Aug 2020 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgHJOAx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Aug 2020 10:00:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F645C061756
        for <linux-ext4@vger.kernel.org>; Mon, 10 Aug 2020 07:00:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c80so7719614wme.0
        for <linux-ext4@vger.kernel.org>; Mon, 10 Aug 2020 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:autocrypt:to:subject:message-id:disposition-notification-to
         :date:mime-version;
        bh=bIJbEqs/TJd40HTuxYg5cbOjcjQK+JYmWk5uIkgm6gM=;
        b=GaJ1air8fbix/Rxz9pMgteePBcJImaEKY1FsBWZG7xRUSvmOKutGPAtYQVnSf8VsX8
         R/hse07OhS75znWyOs+9m9XfH/3IC7viDnSyvwrXVe9huY2S6oOs22+cBvmtAyVpF86U
         SEQhyqihPrUspxde3Xkqk1fgfCRIM8Shp6TzhtcfC/7HLjenU2JApT6lpUEyU8/MKg7V
         f6pQpHOAtzegDteJpheQUn2KTCXSb5053166Q1BjhtnFmCBdUR0bs8K6bKvsrMtuOW6C
         PdIsSMvUtZ0aAPsqoZ5/xm962pbyFs/G8f3Q1hZSPx0Rey7Qz+AkmEx1Dm72j/Mcrxkj
         GcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:autocrypt:to:subject:message-id
         :disposition-notification-to:date:mime-version;
        bh=bIJbEqs/TJd40HTuxYg5cbOjcjQK+JYmWk5uIkgm6gM=;
        b=dLUaf7U3R0YQgJl0rZViWllHKNxxW+AG9L1pZc6uL3yHyM8OJTtR9KyiWzOQpLxTNu
         NZr19seg67k7mN1klWbg/YWfvzTrLBQrXfSzzkmcY6A1Ui3iFjpvVcvvWzIggLmFk3/w
         9a7AUAPkWY207+TgSZ7RPtHhI9X4NQ7jAC9ubQpUMq64xRym7GkXL1pF/Uol87Dv1kc3
         PSCuj0xWjY9xnhbFOeg/pEaNDpD/udkJvFmCjap87A2fhYW+QdRpfzSICvz6/oha/MSt
         erTa+4E/hdSDxnMF6lxxUSO1g4grcc3lHxAE9H61S0axKHrz9czc921xRBv0Of+BC6hv
         5D4Q==
X-Gm-Message-State: AOAM530JsyKtuZa8TJxVRg/SpPefJqsNMSHauNLBCG3fKaJJKPrRzxzg
        eS04O3Q7d5+led4ZAABc8qZ664mJ
X-Google-Smtp-Source: ABdhPJyvdRQ3rYgrCqUh67XJfGBC0ZPpZaBreyRWzj/W/9l7/w8vsxYMnfxepkWbgbe1adnZ0rwc2g==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr27191577wmj.128.1597068051072;
        Mon, 10 Aug 2020 07:00:51 -0700 (PDT)
Received: from localhost (public-gprs551025.centertel.pl. [37.225.15.178])
        by smtp.gmail.com with ESMTPSA id t133sm157290wmf.0.2020.08.10.07.00.49
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 07:00:50 -0700 (PDT)
From:   Mikhail Morfikov <mmorfikov@gmail.com>
Autocrypt: addr=mmorfikov@gmail.com; keydata=
 mDMEXRaE+hYJKwYBBAHaRw8BAQdADVtvGNnC7y4y14i2IuxupgValXBb5YBbzeymUVfQEQu0
 L01pa2hhaWwgTW9yZmlrb3YgKE1vcmZpaykgPG1tb3JmaWtvdkBnbWFpbC5jb20+iJYEExYK
 AD4CGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQR1ZhNYxftXAnkWpwEy2ctjR5bMoQUC
 Xj79nwUJAwmsJQAKCRAy2ctjR5bMoSfMAP9ZBENeQz9MCxZwA11bL9b+ADaYruFlEWVKv9TE
 d+bHjAEApCH8boYJ5QZBD+HYwDCxxKYMiQ7yfhkn8sRWdIThYAq4OARdFoT6EgorBgEEAZdV
 AQUBAQdA1vPaWR/g6H2DzFqi6zjEBCqEv6bOg+N6lahCEuhLc24DAQgHiH4EGBYKACYCGwwW
 IQR1ZhNYxftXAnkWpwEy2ctjR5bMoQUCXj7+CgUJAwmskAAKCRAy2ctjR5bMoZIbAQChdKEJ
 zIXMxUOPs3fMn+cth5CB6NCVXQSF+BPhzJuNuQEA5WTZzlkCfKjXjkcqDGnDd7OHc8Es0OR1
 srTstnmwUAI=
To:     linux-ext4@vger.kernel.org
Subject: Lots of free extents, lots of contiguous free space, and
 fragmentation lvl is ~15%?
Message-ID: <e67feeeb-fe22-fb3d-563c-93c37fe13e06@gmail.com>
Date:   Mon, 10 Aug 2020 16:00:42 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zsCawvBIPHWLKvSyG3sdd7kZIuORWhpyv"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zsCawvBIPHWLKvSyG3sdd7kZIuORWhpyv
Content-Type: multipart/mixed; boundary="8yAETU0UivP8P4XNt3b2MrTyvFii8YXIg";
 protected-headers="v1"
From: Mikhail Morfikov <mmorfikov@gmail.com>
To: linux-ext4@vger.kernel.org
Message-ID: <e67feeeb-fe22-fb3d-563c-93c37fe13e06@gmail.com>
Subject: Lots of free extents, lots of contiguous free space, and
 fragmentation lvl is ~15%?

--8yAETU0UivP8P4XNt3b2MrTyvFii8YXIg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I have a 1G HDD which is used in LUKSv2 + LVM setup (10 logical disks). O=
ne of=20
the LVM disks is 320G in size. I had to split this partition into two sma=
ller=20
ones of about 160G each. The partition was filled with 75G of data, so ov=
er 50%
was free.

To shrinked the partition using the following command:

	# lvreduce -L -160G -r /dev/mapper/wd_blue_label-android

and after about 1 hour, the process was completed. When it was done, I in=
itiated=20
e4defrag, to defrag the files, and I noticed, that even very small files =

(10-100K in size) have 2+ extents:

	[591612/591617]/media/Android/AIO-TWRP-Compiler/compile.log:    100%  ex=
tents: 2 -> 2   [ OK ]

	# ls -alh /media/Android/AIO-TWRP-Compiler/compile.log
	-rw-r--r-- 1 morfik morfik 34K 2019-02-12 18:22:48 /media/Android/AIO-TW=
RP-Compiler/compile.log

	# filefrag -ve /media/Android/AIO-TWRP-Compiler/compile.log
	Filesystem type is: ef53
	File size of /media/Android/AIO-TWRP-Compiler/compile.log is 33999 (9 bl=
ocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: fl=
ags:
	   0:        0..       7:      10684..     10691:      8:
	   1:        8..       8:      10692..     10692:      1:             la=
st,eof
	/media/Android/AIO-TWRP-Compiler/compile.log: 1 extent found

And there are many files like this one.=20

When the defragmentation process finished it's job, there was this summar=
y at=20
the end:

        Success:                        [ 510319/591617 ]
        Failure:                        [ 81298/591617 ]
        Total extents:                  593408->593437
        Fragmented percentage:           15%->15%

Fsck says something like this:

	# fsck.ext4 -Dvf /dev/mapper/wd_blue_label-android
	e2fsck 1.45.6 (20-Mar-2020)
	Pass 1: Checking inodes, blocks, and sizes
	Pass 2: Checking directory structure
	Pass 3: Checking directory connectivity
	Pass 3A: Optimizing directories
	Pass 4: Checking reference counts
	Pass 5: Checking group summary information

	android: ***** FILE SYSTEM WAS MODIFIED *****

		  591626 inodes used (5.64%, out of 10485760)
			1311 non-contiguous files (0.2%)
			 265 non-contiguous directories (0.0%)
				 # of inodes with ind/dind/tind blocks: 0/0/0
				 Extent depth histogram: 587843/69
		20222806 blocks used (48.21%, out of 41943040)
			   0 bad blocks
			   3 large files

		  516113 regular files
		   69686 directories
			   0 character device files
			   0 block device files
			   0 fifos
			   0 links
			5818 symbolic links (3706 fast symbolic links)
			   0 sockets
	------------
		  591617 files
=20
and the free space looks like this:

	# e2freefrag /dev/mapper/wd_blue_label-android
	Device: /dev/mapper/wd_blue_label-android
	Blocksize: 4096 bytes
	Total blocks: 41943040
	Free blocks: 21720234 (51.8%)

	Min. free extent: 4 KB
	Max. free extent: 2064256 KB
	Avg. free extent: 8972 KB
	Num. free extent: 9681

	HISTOGRAM OF FREE EXTENT SIZES:
	Extent Size Range :  Free extents   Free Blocks  Percent
	    4K...    8K-  :           306           306    0.00%
	    8K...   16K-  :           432           997    0.00%
	   16K...   32K-  :          1127          5672    0.03%
	   32K...   64K-  :          3587         42393    0.20%
	   64K...  128K-  :          1306         30025    0.14%
	  128K...  256K-  :           837         37784    0.17%
	  256K...  512K-  :           411         36730    0.17%
	  512K... 1024K-  :           270         48248    0.22%
	    1M...    2M-  :           243         86984    0.40%
	    2M...    4M-  :           227        164786    0.76%
	    4M...    8M-  :           239        343081    1.58%
	    8M...   16M-  :           196        548225    2.52%
	   16M...   32M-  :           149        833919    3.84%
	   32M...   64M-  :           126       1389825    6.40%
	   64M...  128M-  :            95       2199517   10.13%
	  128M...  256M-  :            49       2322803   10.69%
	  256M...  512M-  :            38       3497585   16.10%
	  512M... 1024M-  :            31       5627846   25.91%
	    1G...    2G-  :            12       4503508   20.73%

So how to read the data? Are the files in this partition really fragmente=
d or=20
not?

--
Debian Sid
Linux version 5.8.0-amd64 (morfik@morfikownia) (gcc (Debian 10.2.0-3) 10.=
2.0, GNU ld (GNU Binutils for Debian) 2.35) #1 SMP PREEMPT Wed Aug 5 15:3=
5:00 CEST 2020
e4defrag 1.45.6 (20-Mar-2020)



--8yAETU0UivP8P4XNt3b2MrTyvFii8YXIg--

--zsCawvBIPHWLKvSyG3sdd7kZIuORWhpyv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQR1ZhNYxftXAnkWpwEy2ctjR5bMoQUCXzFTEAAKCRAy2ctjR5bM
oSxoAP92ThxbFZRqFOUSCuej2E2mLjHzm2dU7FwrDhBL6GIE8AD/ffmHRpc12e78
x6KZzIZq/KxEZc55vtKptU1AtjRclQ8=
=SZm3
-----END PGP SIGNATURE-----

--zsCawvBIPHWLKvSyG3sdd7kZIuORWhpyv--
