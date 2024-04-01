Return-Path: <linux-ext4+bounces-1810-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B589465A
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 22:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43CB1C21ABE
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 20:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018053E12;
	Mon,  1 Apr 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="eMe1P3Qm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1D537F7
	for <linux-ext4@vger.kernel.org>; Mon,  1 Apr 2024 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005190; cv=none; b=WkEFTeC7VYq+C08JvCrww5qvq7mdHit8PZ21pW2HQl+YC+8zf2Db4yNzfHdDJFOfPgM/Hc1ScHmQPsqFJTWe+N0Rff25fUy8bivkeJAcATgo089lRNqAJG59p0RMSykFFTmO875lIDVW4fg/0Ir/B9WUewBXUzejrA7t8sdyJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005190; c=relaxed/simple;
	bh=AWwG11TqGXgjhr7Z6zTkhCyGtnETjxSlYhIAtret7Q4=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=DPxnLfAi+6+0ZjQjmtNwkRFXBco6KRp2FnAJKQ5+7vAc6E0mPfen+kWUMrmERGGXAxo8EwbOuzivpmNonzNd1ERb+nT4i4HReG4bhCStAOGkT8SuQlGFcGnToJwI8/cqUJs8yuC+CfsgtdOqnAIUQvUB2IOLMO4x7uSCOZ7hmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=eMe1P3Qm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6fb9a494aso3525203b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 01 Apr 2024 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712005187; x=1712609987; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJtoewKNobdvOOe1JqSrcyLWsfJDe3yAq0JgRn7f0hQ=;
        b=eMe1P3QmIWBh6d+vru2qfd7SRbpUVEzKZNafhvGf/vO03KhiPW7sHKh2RK2ii6lkEd
         c1+EOthjx1drv82/JLcOxz1otesZc7oTut0WonZJO03Rv+uaDnNeW6Scrgjyo715/k5M
         O+6HZbbVe6q8ZgyY0S12h/WkNKfoTwqJYCQo1qYfdvdnIl4aRfgr7u7MPedWpo1eSDyh
         2Ztzkl7qeoG2G5XVbCCX+sStcw4QNQuoYDhx2ur3gyFLTujcFnwx2MwDDXG5LCxb71c5
         4eNYOcfnPLU9X5pQGbgEvZE2ItC8CSrxRNLguo/NAyblF52Tqz+CI54VLRR7UfN9uZ5q
         EtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712005187; x=1712609987;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJtoewKNobdvOOe1JqSrcyLWsfJDe3yAq0JgRn7f0hQ=;
        b=gwKWTQphXyzuvuOCQVjiFfbIpOkxu+goMUCYwOzfSiO206jgZGWSEODDbmPLHJRgdw
         +FEbi2sR2Fg0v3ZTqf/YfP1LirI4V2xqbe+5ROhjk01rvQ8y25nGdLxtcJjqvkMH5Ccs
         +fRJWTBcaL9j2qCl1mJVEGp4b9mA3dWSjhP/aa6paMKbHkrbv9zVbhM2Ard0dMY0maI5
         vthiimkqlA3YiLJNBcaDXtAz03ZQuYCGefsH+lxYPlWTG/MQUNC0KyMmJPoWtCtMXIR1
         wtXhBHnA8MnMWauCa7KJ//4filiz+TMfy60EPxG9v3eRM+ALoqkR/mZfB5MUR/Lk5+8W
         S2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWJqoNVXRf0QyYLYfKVHRzZR6iHV1kLtloEbVaDWuXTaxZtI8RwQ8R5lQ3JfUvQ3ZdFco6FWC3jCBC+e1vQbRzLqANHE8HyZVlVFQ==
X-Gm-Message-State: AOJu0Yyv0Gc62M9Yx2XF8s4Y4bhJNC7IVHhXwtUQDtlUJtKtDVwho6at
	vXKSrZls617hibflngBh0wIWcjdWOtJKeMoBlkFh9UoE1tHzltR2I60sp6jAtAM=
X-Google-Smtp-Source: AGHT+IFXlambapqrggAZZRYOid2gtUgMBuIUNdO1sXJ8vCfMeNRWkA816EULkB3KPPIiEkDhncv9vQ==
X-Received: by 2002:a05:6a00:3a18:b0:6ea:babb:f9c0 with SMTP id fj24-20020a056a003a1800b006eababbf9c0mr10756383pfb.16.1712005186757;
        Mon, 01 Apr 2024 13:59:46 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id e2-20020aa78c42000000b006eab60bca64sm8619608pfd.177.2024.04.01.13.59.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2024 13:59:46 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <D4FC7B67-F06B-493C-BCB7-29BD4A7D255F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4149A99C-565B-424B-987F-9E5F77CC64B9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/4] tests: new test to check quota after directory
 optimization
Date: Mon, 1 Apr 2024 15:01:33 -0600
In-Reply-To: <20240328172940.1609-4-luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
References: <20240328172940.1609-1-luis.henriques@linux.dev>
 <20240328172940.1609-4-luis.henriques@linux.dev>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_4149A99C-565B-424B-987F-9E5F77CC64B9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 28, 2024, at 11:29 AM, Luis Henriques (SUSE) =
<luis.henriques@linux.dev> wrote:
>=20
> This new test validates e2fsck by verifying that quota data is updated
> after a directory optimization is performed.  It mimics fstest =
ext4/014
> by including a filesystem image where a file is created inside a new
> directory on the filesystem root and then root block 0 is wiped:
>=20
>  # debugfs -w -R 'zap -f / 0' f_testnew/image

I appreciate the test case, and I hate to be difficult, but IMHO this
test case is not ideal.  It is *still* reporting quota inconsistency
at the end, so it is difficult to see whether the patch is actually
improving anything or not?

This is because the image is testing a number of different things at
once (repairing the root inode, superblock, etc).  IMHO, it would be
better to have this test be specific to the directory shrink issue
(e.g. a large directory is created, many files are deleted from it,
then optimized), and ideally have a non-root user, group, and project
involved so that it is verifying that all of the quotas are updated.

Cheers, Andreas

>=20
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
> tests/f_quota_shrinkdir/expect.1 |  40 +++++++++++++++++++++++++++++++
> tests/f_quota_shrinkdir/expect.2 |   7 ++++++
> tests/f_quota_shrinkdir/image.gz | Bin 0 -> 11453 bytes
> tests/f_quota_shrinkdir/name     |   1 +
> 4 files changed, 48 insertions(+)
> create mode 100644 tests/f_quota_shrinkdir/expect.1
> create mode 100644 tests/f_quota_shrinkdir/expect.2
> create mode 100644 tests/f_quota_shrinkdir/image.gz
> create mode 100644 tests/f_quota_shrinkdir/name
>=20
> diff --git a/tests/f_quota_shrinkdir/expect.1 =
b/tests/f_quota_shrinkdir/expect.1
> new file mode 100644
> index 000000000000..812fe44b887d
> --- /dev/null
> +++ b/tests/f_quota_shrinkdir/expect.1
> @@ -0,0 +1,40 @@
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Directory inode 2, block #0, offset 0: directory corrupted
> +Salvage? yes
> +
> +Missing '.' in directory inode 2.
> +Fix? yes
> +
> +Missing '..' in directory inode 2.
> +Fix? yes
> +
> +Pass 3: Checking directory connectivity
> +'..' in / (2) is <The NULL inode> (0), should be / (2).
> +Fix? yes
> +
> +Unconnected directory inode 11 (was in /)
> +Connect to /lost+found? yes
> +
> +/lost+found not found.  Create? yes
> +
> +Unconnected directory inode 12 (was in /)
> +Connect to /lost+found? yes
> +
> +Pass 3A: Optimizing directories
> +Pass 4: Checking reference counts
> +Inode 11 ref count is 3, should be 2.  Fix? yes
> +
> +Inode 12 ref count is 3, should be 2.  Fix? yes
> +
> +Pass 5: Checking group summary information
> +[QUOTA WARNING] Usage inconsistent for ID 0:actual (4096, 5) !=3D =
expected (14336, 4)
> +Update quota info for quota type 0? yes
> +
> +[QUOTA WARNING] Usage inconsistent for ID 0:actual (4096, 5) !=3D =
expected (14336, 4)
> +Update quota info for quota type 1? yes
> +
> +
> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
> +test_filesys: 14/256 files (14.3% non-contiguous), 1146/8192 blocks
> +Exit status is 1
> diff --git a/tests/f_quota_shrinkdir/expect.2 =
b/tests/f_quota_shrinkdir/expect.2
> new file mode 100644
> index 000000000000..814f84a54fd6
> --- /dev/null
> +++ b/tests/f_quota_shrinkdir/expect.2
> @@ -0,0 +1,7 @@
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +test_filesys: 14/256 files (14.3% non-contiguous), 1146/8192 blocks
> +Exit status is 0
> diff --git a/tests/f_quota_shrinkdir/image.gz =
b/tests/f_quota_shrinkdir/image.gz
> new file mode 100644
> index =
0000000000000000000000000000000000000000..753774f6a11f8a60fdbdf2ce205e64a3=
6d753893
> GIT binary patch
> literal 11453
> zcmeI#YgAL|xd335ai~RPTIz*^A*;1VkEMb$7%yPVayrU5$Q=3DSCgrEpWB1A45hF}tu
> z3Y~H*WdsERqH+nj!C*iFAtIxUM=3DoR8*&De9N+r(Tgb2(g5J+~%uCD$#tH+*yUCWdG
> z>s#OZ=3Dl!1VUGMj9V*ZbQH1xa8ahq%s63@lQZkQXly%`x>n?3zvVAIw2zEfTQMdN?n
> z4!`*0mQQ{b@-w?%9o~BN+n?8F1biL!!S+)DJwM(tw|V<X$p=3D3<^*Go5@wLWi_YUoE
> z3xE4(j2rmgV)xLJ{#IFkb!)0+$?){-`!><Fq@dvUbAo9uEu+zw^((%DBe7jcRjGge
> zg-34T*4e>{g^H5Q;?4)Coh9@)rBCFSH0ST{P0Jki8N799=3D~_bYkWjf65kHqQeZP|L
> z>^wA?r7kp1#xG0hw-ia~&%WO5Mr>PpQ7+_L(#6$jk3GE#&r%Z5l5Y9a8KXTslU>%z
> zTJhZ-Zma15J|%drF9Dwu0=3D=3DO?;QPYE(4TUgIm-P<Cd=3D%?&3=3DoEw*q2Fynb1l_kB=
Mp
> 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
> Z|MrZm3H(16$j;kv=3D2v{eh7H*p{tBVyta$(c
>=20
> literal 0
> HcmV?d00001
>=20
> diff --git a/tests/f_quota_shrinkdir/name =
b/tests/f_quota_shrinkdir/name
> new file mode 100644
> index 000000000000..8772ae5c814b
> --- /dev/null
> +++ b/tests/f_quota_shrinkdir/name
> @@ -0,0 +1 @@
> +update quota on directory optimization


Cheers, Andreas






--Apple-Mail=_4149A99C-565B-424B-987F-9E5F77CC64B9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYLIK0ACgkQcqXauRfM
H+CVHA/7B6fWJdDe51xgQVPNdmxMiZQ61EIlDgPXkitnDxvOKN9jU9O0oMNnNdfH
HLqrvqq1wshhzsXKlVI5SzGO61eJ20dpjjhvAtAGNT39IbhnL7aaAbaxMkvForAm
SDzLi3SCsV3M4lr7hAcQipPMW9x0jFCpk0qxlM4k8C+Ug7GTWU4hlWUbrPJZKIz4
MtWtZYP3FqBsxk0BAKSS8HeAvEQNvQrn6+qX4O3eImjBDZG6NSDOTbhx3vPWt4Gy
nEe84zIOs17Hb0vme+zXtnMuODZn/TQHL26CmjJZHnlrT2BckpsOT6lJD6odpNLK
g3b9OkuMW3NBjukrcI9kg/Sv2TS9ziM9JXectFhBtDEgOsycFfdcugTJ/HILC88G
J4X1V+EGOGv8/wPrjspaJOIUaoxDQEP0/+pCPHxl3xqSG44iLZteiAHr1xzD36V9
JSjl79+uHkR1t3C1DhhsqGckl///UUra7XBxEMkkVibxsFA+LoBb+gBI1YZgc5HE
LxB14nYuTFJlf2P3rWoP/a8L0fzYvbo9bMN7+KUrBRt13sOu/BE+7Q4rCdKf3sru
xjgGbnaD/p+4MOkVXGN7k+SFzVrdrhY8aqF9wQTUwwTtG8GwhKjo+EmzrN3bg9Oj
5LgZiWQvmRI2i67KWhB18NXyKYw3a9xT4bhx5qJ3R6IazrakHCo=
=GN2L
-----END PGP SIGNATURE-----

--Apple-Mail=_4149A99C-565B-424B-987F-9E5F77CC64B9--

