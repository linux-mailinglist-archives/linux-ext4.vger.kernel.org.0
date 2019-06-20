Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028F34DC94
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 23:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfFTVbN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 17:31:13 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:36910 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTVbM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 17:31:12 -0400
X-Greylist: delayed 2706 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jun 2019 17:31:08 EDT
Received: from [192.168.111.103] (p4FD977A6.dip0.t-ipconnect.de [79.217.119.166])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.0.41/8.16.0.41) with ESMTPSA id x5KKjq9t000546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Jun 2019 22:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1561063553;
        bh=1RT4RaGFOuxytczWKKD79SOyxc+7CVYRHRkQb5AIx6w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UsgEcDQAyceN8ANJrKFYQVZUmOykK7I/fpUtxj9hauL4MLc3iaQgSKVnlf7nk0iZc
         RLwknvurcF5nZg3kbydyeiAt7juyvKSX2OYWWya5JmJQ+uxVTdJzdxS/8iFOxERSR0
         EDdHyU3sfFgqw6eLrQX0a06OFM6HjePi+wc9kq2s=
Subject: Re: [PATCH v3] Updated locking documentation for transaction_t
To:     tytso@mit.edu
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Openpgp: preference=signencrypt
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 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
 spNrcZJf1pbo3EKkCwUPAltq51ramtYzOu4K
Message-ID: <af5a4a51-c1e4-ab4a-14b4-5b0f120bd1be@tu-dortmund.de>
Date:   Thu, 20 Jun 2019 22:45:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dTegDOlfMbAaszSmCNvoVtvfPl6OLfVGQ"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dTegDOlfMbAaszSmCNvoVtvfPl6OLfVGQ
Content-Type: multipart/mixed; boundary="Lv8sljeDHsHtT3Z1ofyiywUqk3I9k1zo9";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: tytso@mit.edu
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <af5a4a51-c1e4-ab4a-14b4-5b0f120bd1be@tu-dortmund.de>
Subject: Re: [PATCH v3] Updated locking documentation for transaction_t
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
In-Reply-To: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>

--Lv8sljeDHsHtT3Z1ofyiywUqk3I9k1zo9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Ted,

Have you had the chance to review the most recent version of the patch?
Does it look reasonable to you?

Cheers,
Alex

On 08.04.19 10:35, Alexander Lochmann wrote:
> We used LockDoc to derive locking rules for each member
> of struct transaction_t.
> Based on those results, we extended the existing documentation
> by more members of struct transaction_t, and updated the existing
> documentation.
>=20
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
> ---
>  include/linux/jbd2.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 0f919d5fe84f..34b728e2b702 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -534,6 +534,7 @@ struct transaction_chp_stats_s {
>   * The transaction keeps track of all of the buffers modified by a
>   * running transaction, and all of the buffers committed but not yet
>   * flushed to home for finished transactions.
> + * (Locking Documentation improved by LockDoc)
>   */
> =20
>  /*
> @@ -652,12 +653,12 @@ struct transaction_s
>  	unsigned long		t_start;
> =20
>  	/*
> -	 * When commit was requested
> +	 * When commit was requested [journal_t.j_state_lock]
>  	 */
>  	unsigned long		t_requested;
> =20
>  	/*
> -	 * Checkpointing stats [j_checkpoint_sem]
> +	 * Checkpointing stats [journal_t.j_list_lock]
>  	 */
>  	struct transaction_chp_stats_s t_chp_stats;
> =20
>=20

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--Lv8sljeDHsHtT3Z1ofyiywUqk3I9k1zo9--

--dTegDOlfMbAaszSmCNvoVtvfPl6OLfVGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAl0L8IAACgkQWT7tBbw+
9v0M8w/+IO92XOSSEpd6QLEROA+/emFHZ77BBcK9Txbqb2PmfdoZu/r2e5AJ+R7J
YO/M2L58gbgDrYNA8e4BktOwoVYaHaLaXUsCRTzr/7Lk1VUxddwCIuAgUxNwB+H+
+rdIlnSDzgXtYaDIy0eU9YS0dMFvEBI0+w2gDhMwX8Db6yEWelcnmmalUHYKOeqx
6nUK+1R8fbgCOyUvQcliyw47CDvJKjluCJ+Hy/GfvR57EXo2mFJuXjZ96+v9gIi8
mX0fFmRrdfUFsRz3NGzDkmkjgapdg5VuMd0f+NvWCDTST0FiG9SYoUPzJQCCmoee
J5mYwjldAQatbL8uemgM/E2183fTqTomZDEne5iZkLUalL4uK8XfzT4dgwodzOQZ
cEr7Pny0qNbJf/vIBCXVOlYSbmwkfXOhtolNroG0ZN6P7gh/Zyh4yk2UCVwOT1vL
LmxKFN2LqYnpBxevjh0wKLo1u011J6J2KfcutL/e8+ws8jLm+xKZaziNoLuNq1HG
szoAl6LObJfZdIHL84EDmY0K/97pM4gpTIweWgrLCthHSMT9uJwtbhVyGZKAj1Og
CwztNekYTsVp9cT4QE+qHYs+0WBYmocTFjd9YjOP+BOgoPqea3/a8WGM9cXNE6tI
PtOgVKkCcM/3eftAgov+M61rGgQNt+YmiefLQTeMLPi8uiS/lpU=
=Wlf0
-----END PGP SIGNATURE-----

--dTegDOlfMbAaszSmCNvoVtvfPl6OLfVGQ--
