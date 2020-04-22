Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B239D1B4DE6
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 22:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDVUB0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 16:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgDVUB0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Apr 2020 16:01:26 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D120CC03C1A9
        for <linux-ext4@vger.kernel.org>; Wed, 22 Apr 2020 13:01:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o185so1648732pgo.3
        for <linux-ext4@vger.kernel.org>; Wed, 22 Apr 2020 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ZfCevJBXV8zFRCuL/PTN5oheG+WXuKvn3y7G1sMFlw4=;
        b=ECO2V5id3EVxmPqwTpJPqDKhw0E7KsrBWghXc5y6a0Ka+GQ8KgfkOWnPt9TcUQ1Q4t
         Tt5LiXr44ePCFD/9wXi+ug6orPAlfvegBqZE6CwEmM0axXZu1kmsY7+mo+UfXN2Wamrj
         voEftCNDd0UyntBgSZCQJQZ9qAONBopI2HcD9ArVsrgUdIqybdRCYQtLD+hyiDaB9Qd9
         s7dyRkoSKnLqMHAWENQxljHcNusm61q0jBfE4tnJXvst64Cv8uRFceQFglX2OWwoNhuz
         4/taCTqBMg4lp0zMu//9vk1+Y4bTABTtqxWW946ydLC+pv9XpP4QTvAPr6D2ucvItkZJ
         glSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ZfCevJBXV8zFRCuL/PTN5oheG+WXuKvn3y7G1sMFlw4=;
        b=igQeVuofKsVTYssXjaC1JDXoWRWWOPaX8rlZGahDHI7OmnCHNSeuhSlyOCGsjdMHCh
         GFyWcvNQaLmO1YPx2lLtitq1cx8lp+ixBSvtCJMS2sO7czpFI6rWLDI+/wDnFVbXLHzo
         FJURxdK2ysm5O1S0xDAUjgDMRapGd/GI1MzYagvwxqjbRh9bnQFXXVLCO88uLJoQuLpB
         MWKC5PoHI64IPtNV2B7AzoxgowvN1g0ljpfTsX0mJCQGhXi2ZtpjKZQ1bXQM0k0f3QP1
         cjQIT1v8hZnJyRE54I7fZd2KmnILVCvaE7A3fjnEYlFQYEFfmRNHXuMyeoeHwuBG2wHA
         DGqg==
X-Gm-Message-State: AGi0PuYPBh2KikQG3xYFktYZsYrPJJoq1zhBOETKE+ioovwdi6+XCHjv
        LSGQo3OUJb3JVlTL1nMl9ZIhyHlc2HY=
X-Google-Smtp-Source: APiQypJ9xRmle+0U36L+H/ALWbxBqHEYVLtTCJW04JGEAQnCmMRbSferf0MJmc8KJPEBc2cCMo5yFw==
X-Received: by 2002:a63:350:: with SMTP id 77mr697335pgd.325.1587585685211;
        Wed, 22 Apr 2020 13:01:25 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c144sm295792pfb.172.2020.04.22.13.01.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 13:01:22 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FFFB9649-7F92-4857-83D8-9E26EC93EA14@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_50040CEB-A2B6-42C1-AC35-23CC9215932B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] LUS-1922 e2image: add option to ignore fs errors
Date:   Wed, 22 Apr 2020 14:01:16 -0600
In-Reply-To: <20200422175434.81072-1-artem.blagodarenko@hpe.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
References: <20200422175434.81072-1-artem.blagodarenko@hpe.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_50040CEB-A2B6-42C1-AC35-23CC9215932B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 22, 2020, at 11:54 AM, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
> Subject: LUS-1922 e2image: add option to ignore fs errors

Probably "LUS-1922" shouldn't be in the patch description, only linked
via "Cray-bug-id: LUS-1922" below.

> From: Alexey Lyashkov <alexey.lyashkov@hpe.com>
>=20
> Add extended "-E ignore_error" option to be more tolerant
> to fs errors while scanning inode extents.
>=20
> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
> Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>

Mostly OK.  I think the commit message change can be done by Ted at
landing time, and my other comments are mostly style issues that
Ted may have other opinions about.  So you can add:

  Reviewed-by: Andreas Dilger <adilger@dilger.ca>

if the patch lands as-is or if we decide to fix those issues.

> Cray-bug-id: LUS-1922
> Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
>=20
> diff --git a/lib/support/mvstring.c b/lib/support/mvstring.c
> new file mode 100644
> index 00000000..1ed2fd67
> --- /dev/null
> +++ b/lib/support/mvstring.c
> +char *string_copy(const char *s)
> +{
> +	char	*ret;
> +
> +	if (!s)
> +		return 0;
> +	ret =3D malloc(strlen(s)+1);
> +	if (ret)
> +		strcpy(ret, s);
> +	return ret;
> +}

Why not use "strdup()" for this?  It isn't really a problem with
this patch, since it was in e2initrd_helper.c previously and just
moved into the helper library, but seems strange.  The strdup()
function has existed for a very long time already, so there should
not be any compatibility issues, but Ted added a patch using this
function only a year ago, so maybe I'm missing something?  It dates
back to:

  2001-01-05 Use string_copy() instead of strdup() for portability's =
sake

It would probably make sense to remove the duplicate copies that
still exist in e2fsck/util.c and misc/fsck.c, and add a comment
why it is better than strdup()?

> diff --git a/misc/e2initrd_helper.c b/misc/e2initrd_helper.c
> index 436aab8c..ab5991a4 100644
> --- a/misc/e2initrd_helper.c
> +++ b/misc/e2initrd_helper.c
> @@ -151,21 +152,6 @@ static int mem_file_eof(struct mem_file *file)
> 	return (file->ptr >=3D file->size);
> }
>=20
> -/*
> - * fstab parsing code
> - */
> -static char *string_copy(const char *s)
> -{
> -	char	*ret;
> -
> -	if (!s)
> -		return 0;
> -	ret =3D malloc(strlen(s)+1);
> -	if (ret)
> -		strcpy(ret, s);
> -	return ret;
> -}
> -
>=20
> diff --git a/tests/i_error_tolerance/script =
b/tests/i_error_tolerance/script
> new file mode 100644
> index 00000000..9cdec475
> --- /dev/null
> +++ b/tests/i_error_tolerance/script
> @@ -0,0 +1,38 @@
> +if test -x $E2IMAGE_EXE; then
> +if test -x $DEBUGFS_EXE; then

Having the nested "if" blocks is confusing at the end.  I was
wondering how "else #if test -x ..." was doing anything, or
why there were two seemingly-duplicate "else" blocks.

This should just check for both files at the same time, and
exit early if they are not found, like:

    if ! test -x $E2IMAGE_EXE || ! test -x $DEBUGFS_EXE; then
        echo "$test_name: $test_description: skipped"
        return 0
    fi

or maybe:

    if ! test -x $E2IMAGE_EXE; then
        echo "$test_name: $test_description: skipped (no e2image)"
        return 0
    fi
    if ! test -x $DEBUGFS_EXE; then
        echo "$test_name: $test_description: skipped (no debugfs)"
        return 0
    fi

> +
> +SKIP_GUNZIP=3D"true"
> +
> +TEST_DATA=3D"$test_name.tmp"
> +dd if=3D/dev/urandom of=3D$TEST_DATA bs=3D1k count=3D16 > /dev/null =
2>&1
> +
> +dd if=3D/dev/zero of=3D$TMPFILE bs=3D1k count=3D100 > /dev/null 2>&1
> +$MKE2FS -Ft ext4 -O ^extents $TMPFILE > /dev/null 2>&1
> +$DEBUGFS -w $TMPFILE << EOF  > /dev/null 2>&1
> +write $TEST_DATA testfile
> +set_inode_field testfile block[IND] 1000000
> +q
> +EOF
> +
> +$E2IMAGE -r $TMPFILE $TMPFILE.back
> +
> +ls -l $TMPFILE.back

In this case, it isn't clear whether there should be an error
or not (e.g. if "ignore_error" was the default), so I don't
think it should be checked, but...

> +$E2IMAGE -r -E ignore_error $TMPFILE $TMPFILE.back
> +
> +ls -l $TMPFILE.back

... should this return an error if $TMPFILE.back doesn't exist?

> +
> +mv $TMPFILE.back $TMPFILE
> +
> +. $cmd_dir/run_e2fsck
> +
> +rm -f $TEST_DATA
> +
> +unset E2FSCK_TIME TEST_DATA
> +
> +else #if test -x $DEBUGFS_EXE; then
> +	echo "$test_name: $test_description: skipped"
> +fi
> +else #if test -x $E2IMAGE_EXE; then
> +	echo "$test_name: $test_description: skipped"
> +fi
> --
> 2.21.1 (Apple Git-122.3)
>=20


Cheers, Andreas






--Apple-Mail=_50040CEB-A2B6-42C1-AC35-23CC9215932B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6goowACgkQcqXauRfM
H+DALA/+KWV+LJZlB+UhvkyH2o82vfj89FYv5AHI0w0If4oTRIXAbWvduNBOa6qn
rfOMzW5HJv5ASbvx9+JYVPeG3kubHUNActBfkwxejcnE7vV7/jxJpTtMCSeTrKKG
3RrnMZ1zkPHE377LnILrogx/wLJ8H2AnUF3NMiCGC07VbNFqOFSZgK94kW7rcfc4
tCnX8PhPdBrZ0JKOV5s5v3Z4wy2ANbS7P3eO6nGATVz4X9sdTJXUwtwh7H0CWUni
REqjKXESQPffkuNDS25u0BGJCs617ktbZNhkL6KG9lEgfq4doC2Ulc57EOY5BU5P
1g3SKdnNvk0xTCvCTtstl0WoV0SJ4AG1c72isKbruMmRnVa38WHqH/TaUXtYiIHC
50Q4mwQCFlNZVi9rPzujtAuiqrj9/yVgKrYtscH+AdlaxdfCEjsPSFBWX7GpJM7Z
YMjFG1gjafiIIQo9BDg4P7OWPQEoaYNNxmtMNSlJ3C6dh4lNxg8sYKAmed94p5O1
OJnxSW2Un5417v9JsaldJNxeYhU0mKYuC00RWyil2cx1T30QLq2G0MQkaY6tcJdg
zBtrCa9nCYpZe0NxhqQyR6R340kayMJws1eHBKw8cmLrALOMTmANvoT8eBPDdt4G
lgwnsrjGkN9Ze+ghqv5uP7MCGcm93/XwWRq6QD7Rjft3MdQ9Cm8=
=skpk
-----END PGP SIGNATURE-----

--Apple-Mail=_50040CEB-A2B6-42C1-AC35-23CC9215932B--
