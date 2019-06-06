Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF837EF9
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2019 22:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfFFUul (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jun 2019 16:50:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40161 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFFUul (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jun 2019 16:50:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so1388973pla.7
        for <linux-ext4@vger.kernel.org>; Thu, 06 Jun 2019 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=W/Z9vU9x1g4annJYu+qk8lRObYcDVq8W/OJFBcJU1mQ=;
        b=s/dCAQCkBY5urkwGFHZbZNQjgOh4QXBHPWXgxhIhZTfbCQdyRXZiaJ2XcHokpSIcbQ
         +XE3nvMEz9tqLvgFFWsqBz9pw2Er8MDtqxPwFPcK49/U+tLQYQzgeqSA8vJO6kbmYytc
         90DvjxxHRw2kfoab31W8FDFDzMZbyCT+gF21ZJDIJZ20KsrHVi/3twp8XjsnV+7RqS/j
         DuAE/0CCcuRfJjx7jRUkRCPOStzYBE1Q5MDz9V2DXC1puY70x2q+aMdXX9OzYOG6BXWP
         AEmXliuZbrwEqNBUZHYgprqqVNZViwDr1QOkayauxviTfHpR38UnzWdlo5QQ0DyKWu0r
         1BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=W/Z9vU9x1g4annJYu+qk8lRObYcDVq8W/OJFBcJU1mQ=;
        b=tCnUDvAnFsTAFgr+aAuTqo9ZhQdgWrloJnqhDDxEFMRBkVni263ex0BsAfW+Kk+vvF
         dgNAIGAROu/WSUFnbNvXzyq+arrXlAdsQ/adeUfKthOEWxAILAgJN8gAMzzmK8GkoNUH
         hl9oASSCZ5Q5eK5Kd2rapewvYr+MkaoRWePIsLK9/QB0A5WSN4UbpkPZholqEhrvUyC9
         7iCq3nbDaFkh5GW/9K+xshpQ5Js8XOjIwS/t28tXKIWxCrf7kEYLLwwVFCPHt3VLFVxq
         B9nBWNpH4wLDS4qfKvqs2WTvbUmJEc9QP4zx6CzG8TpwkoItsReRlCiQuBYdCmXq04x7
         L7yg==
X-Gm-Message-State: APjAAAUTUX6LwqyzAQ+93lVyQS3aR2AVWral+eckrT8RGOYo3/8W+NYJ
        h6i3kJtrdLN4TdsMdTnIEhgR/Q==
X-Google-Smtp-Source: APXvYqwtMdTjS/13prOEgpTWiTkAHPf1yZTGznXE25ORbGx2NMxd2REuEr8a2AaFAQlUFSNnNCuG4w==
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr27299105plt.263.1559854240436;
        Thu, 06 Jun 2019 13:50:40 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f13sm28588pfa.182.2019.06.06.13.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 13:50:39 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E34F9A61-B05B-4CB8-8449-DBFF42A76BAA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CEA4CE2E-E440-4987-A85A-C24031FD0002";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: only set project inherit bit for directory
Date:   Thu, 6 Jun 2019 14:50:36 -0600
In-Reply-To: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_CEA4CE2E-E440-4987-A85A-C24031FD0002
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 5, 2019, at 10:32 PM, Wang Shilong <wangshilong1991@gmail.com> =
wrote:
>=20
> From: Wang Shilong <wshilong@ddn.com>
>=20
> It doesn't make any sense to have project inherit bits
> for regular files, even though this won't cause any
> problem, but it is better fix this.
>=20
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1cb67859e051..ceb74093e138 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -421,7 +421,8 @@ struct flex_groups {
> 			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL)
>=20
> /* Flags that are appropriate for regular files (all but dir-specific =
ones). */
> -#define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | =
EXT4_CASEFOLD_FL))
> +#define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | =
EXT4_CASEFOLD_FL |\
> +			   EXT4_PROJINHERIT_FL))
>=20
> /* Flags that are appropriate for non-directories/regular files. */
> #define EXT4_OTHER_FLMASK (EXT4_NODUMP_FL | EXT4_NOATIME_FL)
> --
> 2.21.0
>=20


Cheers, Andreas






--Apple-Mail=_CEA4CE2E-E440-4987-A85A-C24031FD0002
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlz5fJ0ACgkQcqXauRfM
H+Aheg//S3Q2mQJHspm7zlGAnn4OSmpLn1pE/0n217ziOTIShwC0jW60R1MgzOh/
PF5EZzw86Hwsmk9/e8AIcPKhxX2xFNVg8Invo28LCMmWfbxk6Uxjo4wis2VwzHCw
imMxSycKxCdXiY7LqPocqS3UXlQWFGpuenwUlFrwIhKHBnApxW2omafBktfiQV1K
DBhgbClDJChHNnyEgSGsczvjfmx0nolXk7XLK7lmTTjgwmVACl9VPQnJI+uf7cEf
kkVi2JFA5PK3tAG+GrCizU+F5a2q3J3vE2PzIOU1sLalsV/iwc4at7dobBTw4Dm/
cRBmpKNoDYYL2+EjixD4W7Rr9g9pxPbTWSBFznIhreodmPU3++88yASQtyZoWPbi
siIcAa8AHecINXL4Tlr5z3jLnaXwjRu2TmGKQINOIQJVEnqaOXU1zTNIupmHsbbQ
B44Gw6sQ8cVvpT0alpQ8t4CsYRlJJ6MkOAvNXPCis6aL8mwxjaUjCJpCyRTB93p3
gfFjDzkTRhVETX7s1KsyvDwGjUn3pe/qOOR/P32N5WTdFhT2LYWDM33TxGt4ivY/
vOxSamZFWr1t1qF1fmaf23oH7LRYV8E+TBBi6kD+T2C9Ydpk2OJhR1bZ+ayn9AWx
7h5Mjufd21KqhNFBB+AxqMPonL1sz0r4trmWiRkKwuIATU0BnX0=
=MJES
-----END PGP SIGNATURE-----

--Apple-Mail=_CEA4CE2E-E440-4987-A85A-C24031FD0002--
