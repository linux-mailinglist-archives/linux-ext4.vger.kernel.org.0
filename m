Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE55318786
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 10:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhBKJzb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 04:55:31 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:33910 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhBKJwy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 04:52:54 -0500
Received: from [192.168.111.113] (p4fd971d4.dip0.t-ipconnect.de [79.217.113.212])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 11B9ptWE008232
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Thu, 11 Feb 2021 10:51:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1613037116;
        bh=G+2UnajnP81FFlxwuwxMT+3dMca/ftJn/4u+nnK9BC4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Lkp7Qn5LGpxWxk8Dgs7uy6LLcxu6sqdDA45MrlMCgrpWcvtrNz8ma4C2amyf3/LkI
         qaniALZuvJRKVWqnOkQTMqCrirVGUWou+a1hX75sQREkeOcmd27Va6gGB14PlS+PZi
         QLlD0TeKX4hLfUArd7RDvTGWTpzhqLK8Vn9oK7dY=
Subject: [PATCH v2] Updated locking documentation for journal_t
To:     Jan Kara <jack@suse.cz>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
 <20210211093754.GJ19070@quack2.suse.cz>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Message-ID: <ad82c7a9-a624-4ed5-5ada-a6410c44c0b3@tu-dortmund.de>
Date:   Thu, 11 Feb 2021 10:51:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211093754.GJ19070@quack2.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ycz4DSNxyoWEiYKXLrSfByffiS1XQQsyc"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ycz4DSNxyoWEiYKXLrSfByffiS1XQQsyc
Content-Type: multipart/mixed; boundary="XeKzu853AAnfLW432352y3ymd1K11aocA";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Jan Kara <jack@suse.cz>
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <ad82c7a9-a624-4ed5-5ada-a6410c44c0b3@tu-dortmund.de>
Subject: [PATCH v2] Updated locking documentation for journal_t
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
 <20210211093754.GJ19070@quack2.suse.cz>
In-Reply-To: <20210211093754.GJ19070@quack2.suse.cz>

--XeKzu853AAnfLW432352y3ymd1K11aocA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Some members of transaction_t are allowed to be read without
any lock being held if consistency doesn't matter.
Based on LockDoc's findings, we extended the locking
documentation of those members.
Each one of them is marked with a short comment:
"no lock for quick racy checks".

Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
  include/linux/jbd2.h | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 18f77d9b1745..4dca33a063dd 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -768,7 +768,7 @@ enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
  struct journal_s
  {
  	/**
-	 * @j_flags: General journaling state flags [j_state_lock]
+	 * @j_flags: General journaling state flags [j_state_lock, no lock for =

quick racy checks]
  	 */
  	unsigned long		j_flags;

@@ -808,7 +808,7 @@ struct journal_s
  	/**
  	 * @j_barrier_count:
  	 *
-	 * Number of processes waiting to create a barrier lock [j_state_lock]
+	 * Number of processes waiting to create a barrier lock [j_state_lock, =

no lock for quick racy checks]
  	 */
  	int			j_barrier_count;

@@ -821,7 +821,7 @@ struct journal_s
  	 * @j_running_transaction:
  	 *
  	 * Transactions: The current running transaction...
-	 * [j_state_lock] [caller holding open handle]
+	 * [j_state_lock, no lock for quick racy checks] [caller holding open=20
handle]
  	 */
  	transaction_t		*j_running_transaction;

@@ -1033,7 +1033,7 @@ struct journal_s
  	 * @j_commit_sequence:
  	 *
  	 * Sequence number of the most recently committed transaction
-	 * [j_state_lock].
+	 * [j_state_lock, no lock for quick racy checks].
  	 */
  	tid_t			j_commit_sequence;

@@ -1041,7 +1041,7 @@ struct journal_s
  	 * @j_commit_request:
  	 *
  	 * Sequence number of the most recent transaction wanting commit
-	 * [j_state_lock]
+	 * [j_state_lock, no lock for quick racy checks]
  	 */
  	tid_t			j_commit_request;

--=20
2.20.1




--XeKzu853AAnfLW432352y3ymd1K11aocA--

--Ycz4DSNxyoWEiYKXLrSfByffiS1XQQsyc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAmAk/jsFAwAAAAAACgkQWT7tBbw+9v2d
iA/+OIItlenPIX84hr8W+cCkrWtxMOlH04PcakAieJKdAgXkEEiCDEDkaH9gXivog+9iOQ03uFvO
AJtzn/s3wE8EfEmO10kGMOVy6G/0NvFx1DNlGFXDMHagxSXSTum2Jh1UwJKOSk02WdyQ2V/6h5GZ
8oAUXWdh5cuRnOGniCxZPY+VfKp0s5lfyApWkAvIDO5jQkqbLenDW0sWs0bTl3N5bb9/rf5dqCqh
mRevi6bnUBccnPvfIOR6fKbERhxklnpkYR54+JZRrq1Ml3A9uTSKLIKg7tACG2KwviI9sSNRao6A
SYUU6Kx4U24kKx/LTNIck3wcwHCl5dx5QjxJ/yXE2nQXJ25oiYVSpBiSxNncP8V6YjdB2DAzMREB
R6xg4y+Ho/dKC/6IOLsTU0PhCXar4FNpWNp6kkqAVZRHqXWVapyxYKZUdT3GK187rxAYvaKizSIv
LZSP2UsjBQgcHDGXxOko4f+599XWQn26pqECFlruE541WDwpL4iu77DkFnd7v11pFNSedDO/u/nu
nm77tRFKAfoUU1NtH9PXfVRgxh//XVYcwhzq1EZ1ezPOfAhNvv5wZRpUjer6giFm3G402O/bKUv7
MgIFEx4NKM8K0DH1Ue+ohqNagUXzTxt0XJtYipGbbq/aTum84LRWND3gqj75Ri6msVo4xvP0fvh8
gl0=
=C5aW
-----END PGP SIGNATURE-----

--Ycz4DSNxyoWEiYKXLrSfByffiS1XQQsyc--
