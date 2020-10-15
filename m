Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9195028F4E0
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgJOOhy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 10:37:54 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:54123 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgJOOhy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 10:37:54 -0400
X-Greylist: delayed 4272 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 10:37:48 EDT
Received: from [129.217.43.37] (kalamos.cs.uni-dortmund.de [129.217.43.37])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 09FDQTdr004128
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Thu, 15 Oct 2020 15:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1602768389;
        bh=b9VPPwnOzce61iVQ6VPKecnM/BuvQ8ThJ6ilSnKcqXE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=soM5D3Glgh4SA00g4ic0YVrJ6iame3i6rnYN3mJD+V5dwO5PlBlfDqHJfNcMgdmMh
         xZf0TLVQri2D0a9hpiuudJh3GWhv85pKnY1TPuA4r8ox4mOcLZrl5SnNmgvtTJWu2G
         oCJX2o97gYyAGHpfROstkZeXcV/mOdoCevURcx84=
Subject: [PATCH v3] Updated locking documentation for transaction_t
To:     tytso@mit.edu
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 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
 VhopshUAQ+v/CLESeUrxbP19Qw==
Message-ID: <10cfbef1-994c-c604-f8a6-b1042fcc622f@tu-dortmund.de>
Date:   Thu, 15 Oct 2020 15:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LxPsIJ9o9eUkfLw4inCsMxbkSWuQLqcmz"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LxPsIJ9o9eUkfLw4inCsMxbkSWuQLqcmz
Content-Type: multipart/mixed; boundary="CFOzXPkzcSisgELVMl6z5MUZyWbLUyaM5";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: tytso@mit.edu
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <10cfbef1-994c-c604-f8a6-b1042fcc622f@tu-dortmund.de>
Subject: [PATCH v3] Updated locking documentation for transaction_t
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
In-Reply-To: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>

--CFOzXPkzcSisgELVMl6z5MUZyWbLUyaM5
Content-Type: multipart/mixed;
 boundary="------------F506B68D0B4F75469A7E83DF"
Content-Language: de-DE

This is a multi-part message in MIME format.
--------------F506B68D0B4F75469A7E83DF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi folks,

I've updated the lock documentation according to our finding for
transaction_t.
Does this patch look good to you?

Cheers,
Alex

--------------F506B68D0B4F75469A7E83DF
Content-Type: text/x-patch; charset=UTF-8;
 name="transaction_t-doc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="transaction_t-doc.patch"

commit 13ac907c45c5da7d691f6e10972de5e56e0072c6
Author: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Date:   Thu Oct 15 15:24:52 2020 +0200

    Updated locking documentation for transaction_t
   =20
    We used LockDoc to derive locking rules for each member
    of struct transaction_t.
    Based on those results, we extended the existing documentation
    by more members of struct transaction_t, and updated the existing
    documentation.
   =20
    Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>=

    Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 08f904943ab2..a11c78e4af4e 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -532,6 +532,7 @@ struct transaction_chp_stats_s {
  * The transaction keeps track of all of the buffers modified by a
  * running transaction, and all of the buffers committed but not yet
  * flushed to home for finished transactions.
+ * (Locking Documentation improved by LockDoc)
  */
=20
 /*
@@ -650,12 +651,12 @@ struct transaction_s
 	unsigned long		t_start;
=20
 	/*
-	 * When commit was requested
+	 * When commit was requested [journal_t.j_state_lock]
 	 */
 	unsigned long		t_requested;
=20
 	/*
-	 * Checkpointing stats [j_checkpoint_sem]
+	 * Checkpointing stats [journal_t.j_list_lock]
 	 */
 	struct transaction_chp_stats_s t_chp_stats;
=20

--------------F506B68D0B4F75469A7E83DF--

--CFOzXPkzcSisgELVMl6z5MUZyWbLUyaM5--

--LxPsIJ9o9eUkfLw4inCsMxbkSWuQLqcmz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAl+ITgQACgkQWT7tBbw+
9v00ChAAw51cEOobFSjWDUcqR59tRutBsupJ0p6FOlHAFKje23H6P19afdIWW6dr
mih+7RmcO81jQPC51o5yW12Q3E9ZUg8Ibqg2c9AeIurpotmlZBHCWx8aG9baU5Ha
WmbveGpA9OB1XQzLgYf2pKOCSBnbVGnqO8y7Svt+1xeRTo6AZZFazaVlW8UWeJCc
L6BoptPnvEGa+3+jrXTDy+ND6r44Ev7wM71BcBHIBJdpIgjSDFr4K2CkDWMeWmWt
W6wFBr9lTOqWlyKvMxcoJSfHLY3y1zZj9Ufzs8mJmW0yuTNCjZne5lrgNgO0z5rA
DeAkYuLyhSGpnGBKt2vX++AtrUVVKExvBvRACQWU5qoAVvuAPPjAU7ybfsOySrpN
a/d/gBb7Duyh56j9MmF655aHuHgnsJJyMjPr9nh5LNSlbzwekjHv+SuUAIE92fDs
W8ZCDwi8eL84xHR2pQWUkz1Hmv6hvAioj+w0BNohO9AOAPhHRwc1d/FPmO9hnrZl
QOm2COVoCgmpYmk2cwrShw8ddQiRloJaHo5n/ZRAJ2hokbu1uB2Fb+2RRvVwHWIt
8eZraefQ911jVYgvzctG5HgfEz33BXb7hmSO7nzP548qtV7cpUGY6GaO6KeRsvPL
x0YJmiBfKNoB87b43fXVXlLm7fpQ7BoWLEePtcbSJdRT2Yem9/c=
=Q3ZT
-----END PGP SIGNATURE-----

--LxPsIJ9o9eUkfLw4inCsMxbkSWuQLqcmz--
