Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944C2163326
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 21:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgBRUeD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 15:34:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40843 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRUeD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Feb 2020 15:34:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so8529347plp.7
        for <linux-ext4@vger.kernel.org>; Tue, 18 Feb 2020 12:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=UIoo2ygVaA4wi74+iuBtgZ1rsILjHwxQQIKJUBC8pxs=;
        b=UOVrvASubE/SsTfQMvlzpO99ISfQtq6J1hRglt8TCa6Dj6sJNDJ5jaRpPsBqYGFFpZ
         pmhgnzZXUoMEMG79QIqO6DnB/K0+ST1ZyTIVQfSSb5S99QTMsdrTeFtUSz2+7zYTkR3B
         Ykzk2cDo9C7A/EMsQjoiY8iBC4HhYpgZp1H2IdwmXS1cln39yBAQBQ1Olog6hn0q3/6I
         U0UMhmhNUDEu2TDGyT3ARZ54qFZL4Y87XpFahE8KbU6LwGL9iXHD1rrE0VXc4hD40t3y
         1A9azTgjmHnDVhJVcgOqQG0UwFE+F2krYrzwVGXiHIVhP5HUHKEQfvjMyM9PsgWjeriX
         x3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=UIoo2ygVaA4wi74+iuBtgZ1rsILjHwxQQIKJUBC8pxs=;
        b=oi+elVa2pi7VhJKa84euqDl4tyc2inxCTP8dn+1+0b/T8I0M0nN9rVyBE4e8XlYqtR
         FMYCyFhM4mMjUPL+nG4RTj1TqlmWe6PVqmJIPksz6OAuL1y2D14e+d35HgdaANaaOlVr
         ZoPlgBhwaJ+lpP+nKCuyvnAw3GtGvqE9+0XMJpfbo7RwtjHbIhFwZyzWcLfGTr46T8sk
         lydHYDVNQo5JbpAOJ+n9Y61Qk13sELvD314KhNK8x0d0bpQf9wBP11z07J5JTIAXLrlm
         Y80rq4KXKp8CX1sQhHpxPzPjfasHd+c0W8G4soXgtJfegBoz3zO0OP8paU3n85aIjLaL
         lftg==
X-Gm-Message-State: APjAAAW3mp/0G9hgfRSEYbj2P8CirWuoUVUQNDVaZYM33/gQd+UuKDfD
        u72Uvw7KvjexgbjhPG7uVfG4yGuw0v7DwA==
X-Google-Smtp-Source: APXvYqwDVlL+V2hvtcYY3OUT1YwMofdehb9/+hvTAy7beMpy8aarxdyXZNWoTi7QVbyEFsy/V1HUFw==
X-Received: by 2002:a17:902:76c7:: with SMTP id j7mr22868447plt.45.1582058042708;
        Tue, 18 Feb 2020 12:34:02 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z4sm5146810pfn.42.2020.02.18.12.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 12:34:02 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8A45678F-C17D-417C-9BF0-9D123C846C58@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8D64B96E-7B6E-49C0-A83B-BD266C3CB47E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 6/7] tests: Add test to excercise indexed directories with
 metadata_csum
Date:   Tue, 18 Feb 2020 13:34:25 -0700
In-Reply-To: <20200213101602.29096-7-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-7-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_8D64B96E-7B6E-49C0-A83B-BD266C3CB47E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 13, 2020, at 3:16 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Indexed directories have somewhat different format when metadata_csum =
is
> enabled. Add test to excercise linking in indexed directories and =
e2fsck
> rehash code in this case.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> tests/f_large_dir_csum/expect       | 32 ++++++++++++++
> tests/f_large_dir_csum/is_slow_test |  0
> tests/f_large_dir_csum/name         |  1 +
> tests/f_large_dir_csum/script       | 84 =
+++++++++++++++++++++++++++++++++++++
> 4 files changed, 117 insertions(+)
> create mode 100644 tests/f_large_dir_csum/expect
> create mode 100644 tests/f_large_dir_csum/is_slow_test
> create mode 100644 tests/f_large_dir_csum/name
> create mode 100644 tests/f_large_dir_csum/script
>=20
> diff --git a/tests/f_large_dir_csum/expect =
b/tests/f_large_dir_csum/expect
> new file mode 100644
> index 000000000000..aa9f33f1d25d
> --- /dev/null
> +++ b/tests/f_large_dir_csum/expect
> @@ -0,0 +1,32 @@
> +Creating filesystem with 31002 1k blocks and 64 inodes
> +Superblock backups stored on blocks:
> +	8193, 24577
> +
> +Allocating group tables:    =08=08=08done
> +Writing inode tables:    =08=08=08done
> +Writing superblocks and filesystem accounting information:    =08=08=08=
done
> +
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 3A: Optimizing directories
> +Pass 4: Checking reference counts
> +Inode 13 ref count is 1, should be 5.  Fix? yes
> +
> +Pass 5: Checking group summary information
> +
> +test.img: ***** FILE SYSTEM WAS MODIFIED *****
> +test.img: 13/64 files (0.0% non-contiguous), 766/31002 blocks
> +Exit status is 1
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 3A: Optimizing directories
> +Pass 4: Checking reference counts
> +Inode 13 ref count is 5, should be 46504.  Fix? yes
> +
> +Pass 5: Checking group summary information
> +
> +test.img: ***** FILE SYSTEM WAS MODIFIED *****
> +test.img: 13/64 files (0.0% non-contiguous), 16390/31002 blocks
> +Exit status is 1
> diff --git a/tests/f_large_dir_csum/is_slow_test =
b/tests/f_large_dir_csum/is_slow_test
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tests/f_large_dir_csum/name b/tests/f_large_dir_csum/name
> new file mode 100644
> index 000000000000..2b37c8c21f79
> --- /dev/null
> +++ b/tests/f_large_dir_csum/name
> @@ -0,0 +1 @@
> +optimize 3 level htree directories with metadata checksums
> diff --git a/tests/f_large_dir_csum/script =
b/tests/f_large_dir_csum/script
> new file mode 100644
> index 000000000000..286a965d5e6a
> --- /dev/null
> +++ b/tests/f_large_dir_csum/script
> @@ -0,0 +1,84 @@
> +OUT=3D$test_name.log
> +EXP=3D$test_dir/expect
> +E2FSCK=3D../e2fsck/e2fsck
> +
> +NAMELEN=3D255
> +DIRENT_SZ=3D8
> +BLOCKSZ=3D1024
> +INODESZ=3D128
> +CSUM_SZ=3D8
> +CSUM_TAIL_SZ=3D12
> +DIRENT_PER_LEAF=3D$(((BLOCKSZ - CSUM_TAIL_SZ) / (NAMELEN + =
DIRENT_SZ)))
> +HEADER=3D32
> +INDEX_SZ=3D8
> +INDEX_L1=3D$(((BLOCKSZ - HEADER - CSUM_SZ) / INDEX_SZ))
> +INDEX_L2=3D$(((BLOCKSZ - DIRENT_SZ - CSUM_SZ) / INDEX_SZ))
> +DIRBLK=3D$((3 + INDEX_L1 * INDEX_L2))
> +ENTRIES=3D$((DIRBLK * DIRENT_PER_LEAF))
> +# directory leaf blocks - get twice as much because the leaves won't =
be full
> +# and there are also other filesystem blocks.
> +FSIZE=3D$((DIRBLK * 2))
> +
> +$MKE2FS -b 1024 -O extents,64bit,large_dir,uninit_bg,metadata_csum -N =
50 \
> +	-I $INODESZ -F $TMPFILE $FSIZE > $OUT.new 2>&1
> +RC=3D$?
> +if [ $RC -eq 0 ]; then
> +{
> +	# First some initial fs setup to create indexed dir
> +	echo "mkdir /foo"
> +	echo "cd /foo"
> +	touch $TMPFILE.tmp
> +	echo "write $TMPFILE.tmp foofile"
> +	i=3D0
> +	while test $i -lt $DIRENT_PER_LEAF ; do
> +		printf "ln foofile f%0254u\n" $i
> +		i=3D$((i + 1));
> +	done
> +	echo "expand ./"
> +	printf "ln foofile f%0254u\n" $i
> +} | $DEBUGFS -w $TMPFILE > /dev/null 2>> $OUT.new
> +	RC=3D$?
> +	# e2fsck should optimize the dir to become indexed
> +	$E2FSCK -yfD $TMPFILE >> $OUT.new 2>&1
> +	status=3D$?
> +	echo Exit status is $status >> $OUT.new
> +fi
> +
> +if [ $RC -eq 0 ]; then
> +{
> +	START=3D$SECONDS
> +	i=3D$(($DIRENT_PER_LEAF+1))
> +	last=3D$i
> +	echo "cd /foo"
> +	while test $i -lt $ENTRIES ; do
> +	    ELAPSED=3D$((SECONDS - START))
> +	    if test $((i % 5000)) -eq 0 -a $ELAPSED -gt 10; then
> +		RATE=3D$(((i - last) / ELAPSED))
> +		echo "$test_name: $i/$ENTRIES links, ${ELAPSED}s @ =
$RATE/s" >&2
> +		START=3D$SECONDS
> +		last=3D$i
> +	    fi
> +	    printf "ln foofile f%0254u\n" $i
> +	    i=3D$((i + 1))
> +	done
> +} | $DEBUGFS -w $TMPFILE > /dev/null 2>> $OUT.new
> +	RC=3D$?
> +fi
> +
> +if [ $RC -eq 0 ]; then
> +	$E2FSCK -yfD $TMPFILE >> $OUT.new 2>&1
> +	status=3D$?
> +	echo Exit status is $status >> $OUT.new
> +	sed -f $cmd_dir/filter.sed -e "s;$TMPFILE;test.img;" $OUT.new > =
$OUT
> +	rm -f $OUT.new
> +
> +	cmp -s $OUT $EXP
> +	RC=3D$?
> +fi
> +if [ $RC -eq 0 ]; then
> +	echo "$test_name: $test_description: ok"
> +	touch $test_name.ok
> +else
> +	echo "$test_name: $test_description: failed"
> +	diff -u $EXP $OUT > $test_name.failed
> +fi
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_8D64B96E-7B6E-49C0-A83B-BD266C3CB47E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5MSlEACgkQcqXauRfM
H+AjvQ//aKG1AAZLJZ+DTATOVD4z4F+qJh48W+bLvR9p+pN9G9508a+NE+W+rM0N
MxT+XxIc4FbUfn/EalUhX6aGykmgsvc3BcdreK21Ghrvv6ZVUDsSojCgYUnF/nB7
cXbfXfblBrfmY4Zem88u598uM1vCmZC8FinhHcKovXAt1le95M1DztBv2VqJkosx
Y87R1xktZlq8L1rKJsRiYOKVQnKA9M/ebaCm7It/b0WwQU3GDBR8DmG97G0BE3La
SCuKhzRsa5gDJJh9oqVwTt46PO7cw0HMQDPSJfOMnJCcAr7QiX5Rc/ox8zayoY8c
s+9KOycGEwMi7NB9FhPA4yfbPIjDUOnH5ckYDyJ7H1yoaaPWC0Vak0UCnSX9C0Uw
katIJVEIXekQoYZKnaTkSMQIfZ+0FfySVYyK5Z/ts3XpmWQsOqpoVKwrxjJ5GxJC
0fVT3vB6Vc0N4pBQKo4IVFlQtI0ZqJQ89G1AqrrbqddTKkoHFAkLFHkijl0jY6yF
2wC6vLWY8W97Wi/63X6tj00knjIzOIEx/RMCOx0U/a5u63Vyn6qQID9wbun66d8T
t/inJ24lJbBruh+7OISSFMkcRtz2tkeuLjs5jL3t/4MMHWBTufogGjEBkHdHOndp
cJBVLtozgRFt4kzVmJJUiFBzXv5SX+lYs1+oQglk0TP0GCocicA=
=ADd5
-----END PGP SIGNATURE-----

--Apple-Mail=_8D64B96E-7B6E-49C0-A83B-BD266C3CB47E--
