Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A31CBDD
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2019 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfENP2i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 May 2019 11:28:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44554 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfENP2h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 May 2019 11:28:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id g18so15391139otj.11
        for <linux-ext4@vger.kernel.org>; Tue, 14 May 2019 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=e2MVrEjVEd0MkDYrgk18+2jQ1/qDv9I1QiCyWwylG78=;
        b=yoaATWB0ru8+59Muj7odX3fKQK2hW5AmO7wXXcJ9oypDD0ksXosWUuhSrVCWg5JJ7w
         Tb0EnUFZbPKb6IhJM1/Ul4rhBr8jHl8CQ0SbEsSatjtSmh5KWGSOKYGT1CUA3+EGVXHe
         FXtMyM2NDuv6xAE7EdzKq35xEjAJh2+/XdJaKyF3cSOwufzUx0FyTaPxS0q/lpokxiqN
         UHi1gFRlt0DiwgqRlqgcXK5uj152mWg5Lh01Jy+4p4FhDkKRsVe3QnBHgWR7FJwMcYZj
         +5mzXCuWZjqqqcPFL6aarbGcX0jNv7cYRbbHDsJnE39gepf/MH9hc3rKFJF0u0aLIw7d
         iLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=e2MVrEjVEd0MkDYrgk18+2jQ1/qDv9I1QiCyWwylG78=;
        b=hSqbjnVWJaAl8jzTJg7RZ+DjeXD3I3u5kmsxWb9RN/5yjYW0S8X2koBgdcC4PqHpmX
         HJExNb1p3L/IEeH3Y+Ohp4BnBb0W0VzrCflv0k+DQrM6PbfRuzKHehR3sB0wZuIqjiUs
         8msjKgKZtcxW4/ODnZo038sza/F7fli0S6s7aycustMl7bgJWQpfDSNP/1ZBpEgrkmsc
         YLsn88b5/xUL3m3zlh98rkVMOV/Ro82K3CDbo3TsoqnFxYiltVQPXa/y6tWf0MNw5Xa6
         XmHHHANF+spg2BCCj5195ec/7gV1aqgDmtrPCqCBovnKOfz6+YvuXnL7s/vB0uvTbw26
         U1Xw==
X-Gm-Message-State: APjAAAW8zug135HIGyIC0tgq11xe964rV1Z0SQeVh314Q+KFT6e2mcga
        eLVL+r/28mmRy4gVtr0Sx2klsA==
X-Google-Smtp-Source: APXvYqy7uWJHlGi7aU+V/pVgD82oGE5YCBQYSgLyIGMlDTzCRAoXFs1FACFPw9eHn5KiDpTsPK0HBw==
X-Received: by 2002:a9d:7b46:: with SMTP id f6mr9277178oto.324.1557847716462;
        Tue, 14 May 2019 08:28:36 -0700 (PDT)
Received: from [172.25.180.192] ([129.7.0.180])
        by smtp.gmail.com with ESMTPSA id q9sm4865842otf.1.2019.05.14.08.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 08:28:35 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <01F47CA1-E737-4F52-8FF2-A3E0DCD8EB1B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_623AD491-9A75-42D2-BF6F-E631E2DDE765";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] generic: test statfs on project quota directory
Date:   Tue, 14 May 2019 09:28:38 -0600
In-Reply-To: <20190513014951.4357-1-zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
To:     Zorro Lang <zlang@redhat.com>
References: <20190513014951.4357-1-zlang@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_623AD491-9A75-42D2-BF6F-E631E2DDE765
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 12, 2019, at 7:49 PM, Zorro Lang <zlang@redhat.com> wrote:
>=20
> There's a bug on xfs cause statfs get negative f_ffree value from
> a project quota directory. It's fixed by "de7243057 fs/xfs: fix
> f_ffree value for statfs when project quota is set". So add statfs
> testing on project quota block and inode count limit.
>=20
> For testing foreign fs quota, change _qmount() function, turn on
> project if quotaon support.
>=20
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>=20
> Hi,
>=20
> (Long time passed, re-send this patch again to get reviewing)
>=20
> There's one thing I don't understand, so CC ext4 mail list. Please
> feel free to reply, if anyone knows that:
>=20
> $ mkfs.ext4 $SCRATCH_DEV
> $ tune2fs -O quota,project $SCRATCH_DEV
> $ mount $SCRATCH_DEV $SCRATCH_MNT -o prjquota
> $ quotaon -P $SCRATCH_MNT
> $ mkdir $SCRATCH_MNT/t
> $ xfs_quota -f -x -c "project -p $SCRATCH_MNT/t -s 42" $SCRATCH_MNT
> $ xfs_quota -f -x -c "limit -p bsoft=3D100m answer" $SCRATCH_MNT
> $ df -k $SCRATCH_MNT/t
> Filesystem    1K-blocks  Used Available Use% Mounted on
> SCRATCH_DEV    102400     4    102396   1% SCRATCH_MNT
>=20
> On XFS, the 'Used' field always shows '0'. But why ext4 always has
> more 4k? Is it a bug or expected.

Each directory in ext4 consumes a 4KB block, so setting the project
quota on a directory always consumes at least one block.

Cheers, Andreas

> common/quota          |  4 +++
> tests/generic/999     | 74 +++++++++++++++++++++++++++++++++++++++++++
> tests/generic/999.out |  3 ++
> tests/generic/group   |  1 +
> 4 files changed, 82 insertions(+)
> create mode 100755 tests/generic/999
> create mode 100644 tests/generic/999.out
>=20
> diff --git a/common/quota b/common/quota
> index f19f81a1..315df8cb 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -200,6 +200,10 @@ _qmount()
>    if [ "$FSTYP" !=3D "xfs" ]; then
>        quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
>        quotaon -ug $SCRATCH_MNT >>$seqres.full 2>&1
> +	# try to turn on project quota if it's supported
> +	if quotaon --help 2>&1 | grep -q '\-\-project'; then
> +		quotaon --project $SCRATCH_MNT >>$seqres.full 2>&1
> +	fi
>    fi
>    chmod ugo+rwx $SCRATCH_MNT
> }
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 00000000..555341f1
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 999
> +#
> +# Test statfs when project quota is set.
> +# Uncover de7243057 fs/xfs: fix f_ffree value for statfs when project =
quota is set
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	_scratch_unmount
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/quota
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_quota
> +_require_xfs_quota_foreign
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_enable_pquota
> +_qmount_option "prjquota"
> +_qmount
> +_require_prjquota $SCRATCH_DEV
> +
> +# Create a directory to be project object, and create a file to take =
64k space
> +mkdir $SCRATCH_MNT/t
> +$XFS_IO_PROG -f -c "pwrite 0 65536" -c sync $SCRATCH_MNT/t/file =
>>$seqres.full
> +
> +# Setup temporary replacements for /etc/projects and /etc/projid
> +cat >$tmp.projects <<EOF
> +42:$SCRATCH_MNT/t
> +EOF
> +
> +cat >$tmp.projid <<EOF
> +answer:42
> +EOF
> +
> +quota_cmd=3D"$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid"
> +$quota_cmd -x -c 'project -s answer' $SCRATCH_MNT >/dev/null 2>&1
> +$quota_cmd -x -c 'limit -p isoft=3D53 bsoft=3D100m answer' =
$SCRATCH_MNT
> +
> +# The itotal and size should be 53 and 102400(k), as above project =
quota limit.
> +# The isued and used should be 2 and 64(k), as this case takes. But =
ext4 always
> +# shows more 4k 'used' space than XFS, it prints 68k at here. So =
filter the
> +# 6[48] at the end.
> +df -k --output=3Dfile,itotal,iused,size,used $SCRATCH_MNT/t | \
> +	_filter_scratch | _filter_spaces | \
> +	sed -e "/SCRATCH_MNT/s/6[48]/N/"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 00000000..1bebabd4
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,3 @@
> +QA output created by 999
> +File Inodes IUsed 1K-blocks Used
> +SCRATCH_MNT/t 53 2 102400 N
> diff --git a/tests/generic/group b/tests/generic/group
> index 9f4845c6..35da10a5 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -542,3 +542,4 @@
> 537 auto quick trim
> 538 auto quick aio
> 539 auto quick punch seek
> +999 auto quick quota
> --
> 2.17.2
>=20


Cheers, Andreas








Cheers, Andreas






--Apple-Mail=_623AD491-9A75-42D2-BF6F-E631E2DDE765
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlza3qYACgkQcqXauRfM
H+BwsRAApJpYHp/WOqpERQcuzyA/bVa18eSNJHgDHVZN+aobM9rRuZPcFIPwr5lt
paeKISBJQ7dToNixmaDMuL5nolN0l8WH4ui0tdLUAhu+55GOvWGEJq9zbcuTbBaj
e3w1qHAL95Zh70ljb2lzt0jCjzD9XCDFC6bCRLMdKXICDSIgWl7jmczjkrf2PTk1
C+b/79fJWdjBCPFRnu6XZx8VTFqb+jvc3EWpgc9kr9aKiOcODbE0sfWxGnikuri9
nYqlCaLHOjdFdz6gbPYeErsUBfS3xOAfZLUYqzZ96DTdDVv0rFMCPKq+wMXBNGua
o9ONpXAPwWr0I32J3XeRNBEHiOiT1/rTf5whpy+cvB5wO3s4E4eGI288i2aJk3as
dWDV3h3uc7M0N4pK/UhqQISe71moR6oNmijqjM/gwYrmDQ28uVfTHgwXLFEvq+q7
P7eJi8p8jOhRZUG1J9aoblypILCiJ3+jaLPpjxGXDZ/lQ+EsV470N0yIZaDs9qg1
UO7pELIND5JCYHQu/MfGaHX44IQlr3+vei1vtHRQpbsODRV8RPhQPOW1Fqj+LzMA
ZnN43ieNhhDW8wk8EejLyrYicSj3ykgE1i68VmN3LfCZ1sNgMVCOtle9kURUIOej
wGTpuCnVAKYXm2sdi33e+wl7QVmK+ypBpN2iOLSIFSt8g6TjZSw=
=EfR6
-----END PGP SIGNATURE-----

--Apple-Mail=_623AD491-9A75-42D2-BF6F-E631E2DDE765--
