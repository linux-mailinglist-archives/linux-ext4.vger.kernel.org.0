Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDDD163311
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 21:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgBRU3n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 15:29:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45846 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgBRU3m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Feb 2020 15:29:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so11207564pfg.12
        for <linux-ext4@vger.kernel.org>; Tue, 18 Feb 2020 12:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Zg7EGzdIEvTM9KSE+xxt4lFBGZrzKomb+3ZlQ8MFsHU=;
        b=ZBQpname/KnWG21c1N1ErKjhlnTfk4tkAoujG/+ZZfmA/b8RlrvnuWaOIcPL+stTrF
         8v5FZahTQUSFXg/0ZikJe6sZVJ/9QF4RQRlxj3AnOrA5UoAzC3dR6dD1Qv6CBbPiU0Qk
         Slwzm6lwbvs/bbcaJ7vA3vF+bQr59qL56eXDu2vyJk0D6Q5uvttjNqzOOpf2j8k8et0F
         OJMajjOn0yEO5bMV28PqAigQAi4B/OjhMzbqNfLp/HTOJ83/w5Wt9rC6TUsRQ5nC0ncd
         xMZmRsPjhvRTwPChabIu+OEvhY/81Yrx5eEYi0oM/7NYU7yr1B0Yl52Jv3cSe9f1oUIJ
         6Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Zg7EGzdIEvTM9KSE+xxt4lFBGZrzKomb+3ZlQ8MFsHU=;
        b=cphMJpcL5PGCIfTnhCYHaKDkuojUaKjw0uDaD/y9J3CJEGEG6YxLqb7UIJcXdc73bn
         bvRNP80C/deq4udaw5Bk/BJU9+ZIr3ZK1bgFpYHCtDcWSACE69CmUdHc1xYx8JsR1wpW
         TFNiwi6pf1X/3aJB3hsTktQzoftMxcFlc8p+KRh3ojdGLcS2HD9bN3zYihmUvSp831ow
         gJfFAG6vuIr4VzVpRLRd9kQKTT92wPQHIg+q7cci5epBQaa2GlRJLxHGAHiI5pq89YPJ
         x+PMEUqc9Q0XsqXauHWWVD6oHlRN5boHtOgaqUU3a1I/wwD7kAtdEFqVMaaW0QzIWSy2
         ulJQ==
X-Gm-Message-State: APjAAAUhFtxXPzXWRpClBtLsvDkOE4rAvAIJxUNiBURYE6JzW8NhusA2
        62l8Dh251ktkcCX0/+ioKnnsjR2vA1PVEg==
X-Google-Smtp-Source: APXvYqzrzgQAWY1tSah8VdicdZ3RS3Cl9EohXXlZt4A47c+1ORGWQ93nLqidkEkdVoIpRNDFHhIj5A==
X-Received: by 2002:a63:7019:: with SMTP id l25mr24232662pgc.132.1582057780489;
        Tue, 18 Feb 2020 12:29:40 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id q11sm4963935pff.111.2020.02.18.12.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 12:29:39 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <39788032-EB47-4ACB-8DA2-3E30B0772847@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_53A16B12-7EB4-4A2E-9148-BA65B2CCFC6F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/7] tests: Modify f_large_dir test to excercise indexed
 dir handling
Date:   Tue, 18 Feb 2020 13:29:56 -0700
In-Reply-To: <20200213101602.29096-6-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-6-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_53A16B12-7EB4-4A2E-9148-BA65B2CCFC6F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 13, 2020, at 3:16 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Modify f_large_dir test to create indexed directory and create entries
> in it. That way the new code in ext2fs_link() for addition of entries
> into indexed directories gets executed including various special cases
> when growing htree.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> tests/f_large_dir/expect | 10 ++++++++++
> tests/f_large_dir/script | 27 ++++++++++++++++++++++-----
> 2 files changed, 32 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/f_large_dir/expect b/tests/f_large_dir/expect
> index 8f7d99dc1ee7..028234cc6bb5 100644
> --- a/tests/f_large_dir/expect
> +++ b/tests/f_large_dir/expect
> @@ -6,6 +6,16 @@ Allocating group tables:      =08=08=08=08=08done
> Writing inode tables:      =08=08=08=08=08done
> Writing superblocks and filesystem accounting information:      =
=08=08=08=08=08done
>=20
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 3A: Optimizing directories
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +
> +test.img: ***** FILE SYSTEM WAS MODIFIED *****
> +test.img: 17/65072 files (5.9% non-contiguous), 9732/108341 blocks
> +Exit status is 0
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> diff --git a/tests/f_large_dir/script b/tests/f_large_dir/script
> index 9af042ca6ca8..e3235836f997 100644
> --- a/tests/f_large_dir/script
> +++ b/tests/f_large_dir/script
> @@ -26,17 +26,33 @@ $MKE2FS -b 1024 -O large_dir,uninit_bg -N =
$((ENTRIES + 50)) \
> RC=3D$?
> if [ $RC -eq 0 ]; then
> {
> -	START=3D$SECONDS
> +	# First some initial fs setup to create indexed dir
> 	echo "mkdir /foo"
> 	echo "cd /foo"
> 	touch $TMPFILE.tmp
> 	echo "write $TMPFILE.tmp foofile"
> 	i=3D0
> -	last=3D0
> +	while test $i -lt $DIRENT_PER_LEAF ; do
> +		printf "mkdir d%0254u\n" $i
> +		i=3D$((i + 1));
> +	done
> +	echo "expand ./"
> +	printf "mkdir d%0254u\n" $i
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
> 	while test $i -lt $ENTRIES ; do
> -	    if test $((i % DIRENT_PER_LEAF)) -eq 0; then
> -	    	echo "expand ./"
> -	    fi
> 	    ELAPSED=3D$((SECONDS - START))
> 	    if test $((i % 5000)) -eq 0 -a $ELAPSED -gt 10; then
> 		RATE=3D$(((i - last) / ELAPSED))
> @@ -54,6 +70,7 @@ if [ $RC -eq 0 ]; then
> } | $DEBUGFS -w $TMPFILE > /dev/null 2>> $OUT.new
> 	RC=3D$?
> fi
> +
> if [ $RC -eq 0 ]; then
> 	$E2FSCK -yfD $TMPFILE >> $OUT.new 2>&1
> 	status=3D$?
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_53A16B12-7EB4-4A2E-9148-BA65B2CCFC6F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5MSUYACgkQcqXauRfM
H+AJVg//Sje9gIbbVAtUMdGbMtckk3UnAwi5k8uHMo4DLx6fO03tzaXctS7Z25Jy
HlDiWIA+yfV8QbLoX7nLs4R7XQJ5v7Or19YoDktgeWDeBgW+RkfH72LxpqNrTWb3
svagylkynKAInSJBEBEwGCDYKL+Pnt7k3TXPg3MK2RvtypKt/QWdYWgPUavoBxYq
XkhWSv7tYwQrKlQwQFAra4pwxiDQ2J11GBXajDVcLuyRgemGRrV8BTx6loRdRDV7
GdBrn0uFEUv5taxiZb7O8bUM20DCoY+vsPobDrf4x824dnLR+975/TBrT0TfAwaN
sY06ihkxpHTO8X1/7ufo8EeGItBS+i0KRdaqd5ErQxjSBoK7FFIqREZISpEgChUU
sFuVj9J5HatYCKDHgV+aON/GqjxfAe2fgYtyKMlUU02P3A6PdKh8qK3fqxdzBWrm
6aBEG16tQ2nCEqoh7GfZeWYKNswmZzu5Bk0HZuQTCmJV8mw3R1SOwtIrmJ21PJPx
YiLt1v8fO1Jpa2o06SzyEaY9hQ/JLAmT33I4BCGxP9S2Us4dbh/7/9STTyhLNEBL
w5AIEJQZ6S4kA9tVVDcODSsdEZTFIj1LQ+BvZcHphnwysXZqOmdefA+eFwnWWgD3
0F40QXFOggbQOIujioJcLL6sEO+VfdaFwwRdyAl2sq2/AsP3OaM=
=vK1Z
-----END PGP SIGNATURE-----

--Apple-Mail=_53A16B12-7EB4-4A2E-9148-BA65B2CCFC6F--
