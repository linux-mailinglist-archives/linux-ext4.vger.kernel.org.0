Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F89664A8C6
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Dec 2022 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiLLUfu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Dec 2022 15:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiLLUft (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Dec 2022 15:35:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FA563FB
        for <linux-ext4@vger.kernel.org>; Mon, 12 Dec 2022 12:35:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso1228249pjh.1
        for <linux-ext4@vger.kernel.org>; Mon, 12 Dec 2022 12:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fm70PtSd7GlnYymtXtu82ASGpG6hWKVNkMiCBVLujUE=;
        b=w0XSH4DluJSQg77iRJ+AdlQTqfEHcIY1nLnibZuKok8lGji0HIsQSgRAncwmL2UwCa
         EtKgxj0AlUI7kunQblD4N3CbNG3uL5W4pKTcctwHufPM9veDP0bcTmhV0UTcj5nOPj8Y
         aHEu8B2DrMchU0SKq+w/ElaiNtYLoBSe5ZVkjsuVT+8SS9H8blF6e3dl1B4+qp7iw4Zy
         FGuieE6eSi3XXcO9HeK8epcogQLoCwd2XAC3rs5haYCfYAfgM9Gp8tE2r16RVHp+5sSz
         skozST0sjKEAMUbRrqbCINqj7scyMW+BGXM0Vv4+jEnGAxcRqMHlxWsIkjFQVDqgqm8r
         7Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fm70PtSd7GlnYymtXtu82ASGpG6hWKVNkMiCBVLujUE=;
        b=jbyXNRwVejUlbSuAxwNKB50MvtdzsMHh1rDFvmjunsv4Um7mhSATOoJ0y4SPmyb+8B
         QCY3QiuQ8DPI5XHgZ1YR//nz7n+eoSoA2gsOWZoKOgK0fa8mWl6HyFKxMaSHIhEeSM+H
         ds6ii/O3e4p57sSS/506JOF9AgoEPlCwuRTAXuXI1rmu5rx+UV5HvNQCSbNQZRoWioDr
         jFsq7lIWA/o5k4MjNcYoIACkMfsffbK6pB+3c7tFsJSHqhf40kXaySMFnHglMmEWhgjJ
         O4t9ykx2rqjWu3K4rCvOqIt5JHv/IzpDjPTSGWREIXk9EcKoJin1bHUNaGDnMgruZzug
         JyYw==
X-Gm-Message-State: ANoB5pkewUJVSPG5nTPg+1flc/+gt9RUvvd3d5jvmNZoI+YbHvGHpBO/
        bAz8Hk4aiHDJIykIJ4BMTCFVEA==
X-Google-Smtp-Source: AA0mqf4+x/zY975VKopr/C84UIZsZRmawol0hpFoCXsF7DsNlbk7qByStocTu6lKlPteDyy+W2Orgg==
X-Received: by 2002:a17:90a:a581:b0:20d:bd5e:d54a with SMTP id b1-20020a17090aa58100b0020dbd5ed54amr17936606pjq.21.1670877347598;
        Mon, 12 Dec 2022 12:35:47 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z3-20020a17090a468300b00212735c8898sm5875411pjf.30.2022.12.12.12.35.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 12:35:46 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <18C6DFAB-B67B-45D0-9815-B3C1DF676495@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0C98C711-8E76-492D-B580-3BAD5DAAB728";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFCv1 13/72] tst_badblocks: Add unit test to verify badblocks
 list merge api
Date:   Mon, 12 Dec 2022 13:35:42 -0700
In-Reply-To: <9442bf260312e78236353ce1976ea7edc519d1cf.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wangshilong1991@gmail.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <9442bf260312e78236353ce1976ea7edc519d1cf.1667822611.git.ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0C98C711-8E76-492D-B580-3BAD5DAAB728
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 7, 2022, at 5:21 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> Add unit test to verify badblocks list merge api i.e.
> ext2fs_badblocks_merge()
>=20
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/tst_badblocks.c | 61 ++++++++++++++++++++++++++++++++++++--
> 1 file changed, 59 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/ext2fs/tst_badblocks.c b/lib/ext2fs/tst_badblocks.c
> index b6e766ab..946de0ae 100644
> --- a/lib/ext2fs/tst_badblocks.c
> +++ b/lib/ext2fs/tst_badblocks.c
> @@ -119,6 +119,40 @@ static void print_list(badblocks_list bb, int =
verify)
> 	}
> }
>=20
> +static void do_list_merge_verify(badblocks_list bb, badblocks_list =
bbm, int verify)
> +{
> +	errcode_t retval;
> +	badblocks_iterate iter;
> +	blk_t blk;
> +	int i, ok;
> +
> +	retval =3D ext2fs_badblocks_merge(bb, bbm);
> +	if (retval) {
> +		com_err("do_list_merge_verify", retval, "while doing =
list merge");
> +		return;
> +	}
> +
> +	if (!verify)
> +		return;
> +
> +	retval =3D ext2fs_badblocks_list_iterate_begin(bb, &iter);
> +	if (retval) {
> +		com_err("do_list_merge_verify", retval, "while setting =
up iterator");
> +		return;
> +	}
> +
> +	while (ext2fs_badblocks_list_iterate(iter, &blk)) {
> +		retval =3D ext2fs_badblocks_list_test(bbm, blk);
> +		if (retval =3D=3D 0) {
> +			printf(" --- NOT OK\n");
> +			test_fail++;
> +			return;
> +		}
> +	}
> +	ext2fs_badblocks_list_iterate_end(iter);
> +	printf(" --- OK\n");
> +}
> +
> static void validate_test_seq(badblocks_list bb, blk_t *vec)
> {
> 	int	i, match, ok;
> @@ -275,13 +309,13 @@ out:
>=20
> int main(int argc, char **argv)
> {
> -	badblocks_list bb1, bb2, bb3, bb4, bb5;
> +	badblocks_list bb1, bb2, bb3, bb4, bb5, bbm;
> 	int	equal;
> 	errcode_t	retval;
>=20
> 	add_error_table(&et_ext2_error_table);
>=20
> -	bb1 =3D bb2 =3D bb3 =3D bb4 =3D bb5 =3D 0;
> +	bb1 =3D bb2 =3D bb3 =3D bb4 =3D bb5 =3D bbm =3D 0;
>=20
> 	printf("test1: ");
> 	retval =3D create_test_list(test1, &bb1);
> @@ -346,6 +380,27 @@ int main(int argc, char **argv)
> 		printf("\n");
> 	}
>=20
> +	printf("Create merge bb list\n");
> +	retval =3D ext2fs_badblocks_list_create(&bbm, 5);
> +	if (retval) {
> +		com_err("ext2fs_badblocks_list_create", retval, "while =
creating list");
> +		test_fail++;
> +	}
> +
> +	printf("Merge & Verify all bb{1..5} into bbm\n");
> +	if (bb1 && bb2 && bb3 && bb4 && bb5 && bbm) {
> +		printf("Merge bb1 into bbm");
> +		do_list_merge_verify(bb1, bbm, 1);
> +		printf("Merge bb2 into bbm");
> +		do_list_merge_verify(bb2, bbm, 1);
> +		printf("Merge bb3 into bbm");
> +		do_list_merge_verify(bb3, bbm, 1);
> +		printf("Merge bb4 into bbm");
> +		do_list_merge_verify(bb4, bbm, 1);
> +		printf("Merge bb5 into bbm");
> +		do_list_merge_verify(bb5, bbm, 1);
> +	}
> +
> 	file_test(bb4);
>=20
> 	file_test_invalid(bb4);
> @@ -363,6 +418,8 @@ int main(int argc, char **argv)
> 		ext2fs_badblocks_list_free(bb4);
> 	if (bb5)
> 		ext2fs_badblocks_list_free(bb5);
> +	if (bbm)
> +		ext2fs_badblocks_list_free(bbm);
>=20
> 	return test_fail;
>=20
> --
> 2.37.3
>=20


Cheers, Andreas






--Apple-Mail=_0C98C711-8E76-492D-B580-3BAD5DAAB728
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmOXkJ4ACgkQcqXauRfM
H+COrA/9GZ6SkzjYEoRfVimnEeE8xshdueGLlVewnM0VgeSh5Hzx4LctBuGZX5KC
BmZ9aZQhRwFSSw3n0t0013Vwb5O5Tg+Q2ZPnkkCZQbedPZjntVsvyqsfkEA4Cmhg
9LKlcJZ/atWlgSPpPEbhgY15YeciH/UKuma8zZOYYohdyWNUf3arV+cjlEBQW+VU
afBzWLgyhp1Uq6XUKbX/vuT54EnQ1FkAH0+sJakOWo7pV6KVIoHw2VxOLw/dy8gG
p8N/Jrvj0JAt8nqYE80Sh3tgenxAVmVdJ/c++/y3HG1EjUYy3p3T5Xyu+wexp5n6
7s2hZx/WTSBlQdIbJfudZZU9cNk4JdBx+3CfOA07klfIOorlGhQLjkQ2PLQXcfyq
K8CBlzakwUfzi9f7dkVpjFRQWZ1nsGeEPpy3Ea73BSkfR4p1t+c7iW6MP8kmAsYI
NVeh94Fx8TMuiFg+kK85NHZX7cdstd1yBdVOBR847vlXWRzYLBShjNCqTB4O15OO
AfQQqFwIYU70trM30YdfWU2igshxWeD+sQlCvm5vocrbsRRqeTPKYyUcvDdUTzi8
QWRgBeooYA9rBokf6IzPdCAPlN16QoK+kNh460LWLd6yWYIgOGGQhxky+48GtJPb
tOKe2bdxhQIZCqszBixCCUiQenWq3OrdNxNKoMshPPHxMo5H0L4=
=v9k7
-----END PGP SIGNATURE-----

--Apple-Mail=_0C98C711-8E76-492D-B580-3BAD5DAAB728--
