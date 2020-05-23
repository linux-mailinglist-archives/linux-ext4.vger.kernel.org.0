Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D131DF4E9
	for <lists+linux-ext4@lfdr.de>; Sat, 23 May 2020 07:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbgEWFMp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 23 May 2020 01:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgEWFMo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 23 May 2020 01:12:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74732C061A0E
        for <linux-ext4@vger.kernel.org>; Fri, 22 May 2020 22:12:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so5972524pgn.5
        for <linux-ext4@vger.kernel.org>; Fri, 22 May 2020 22:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=YhqmvycNcSTUWUPv5oYIa/05TcBuwvGvxwvt89ekYF8=;
        b=xobXDIPhK+QZx9VsI2/xBVdpHthmMIGIRYMLbYnJBzgV3ptLlnRiNNH/idq3emJa+9
         qnoz6wPpOJmjqXRClcR817o8MNamS6FD9MR412YQSrVRTHP325WKug8PqIm0cPIzDKvE
         OLAGYtTpHEXBRM0pE5BsP9gFt08ZEfZFK7pzBlU6Tjj9TyRy6vpc23CLnu4ABKyfkit3
         HZCAlzBK0Noe8nOrUwlvayhKwBOCvXWA3fK2JesWlLG/wfJ6YH2VM/aDw4bnETxF0tGl
         JOc2X21Im2fw5ARcSW+lgeRB854pLkVcNki8WAMuCoYDscWaDH2CnR5xsyyaRooMZK11
         vNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=YhqmvycNcSTUWUPv5oYIa/05TcBuwvGvxwvt89ekYF8=;
        b=DbFiu6dYIOb60oB69EaJJrbkyRrtqTwDXo8MjgWt5kAO7G+sIkXCGooLhlaWVCPEJ/
         KR++Ieto4vSZXzNZQLD/RGLccVtHH4kkiylvqxpQERbEPSwzV357ISuSD7jbKwbUDn8R
         +3Sg6fIecogMNQpYKLM6t8z+/M73VQJScHBm7T1KIgCP/lST4jA0wlYAtM/4N3xbEGdr
         0pODZ4PnFI5GWyCW+I4J7chaus5gA18eMwcKkzE0HFQjYIzP39FXnaj4EYATKjHDKhpJ
         Ks1GuGmXxN5F9isxfMxgJYezLa7KE6MjnFtrjXdJLUz/g/ezlXB8zSNr7IjDF9gqP308
         2zIw==
X-Gm-Message-State: AOAM531JLJfRbVbKqR1AdZDIikePTSAXyHppac+gTq+MzCwXtuNpxfkY
        r7tEXY947B/FmIlpCsjH3k6t257K0mOTCQ==
X-Google-Smtp-Source: ABdhPJyOQAKftM1szHBVvG2Fdp5AL0VD8Sr0QU/ykiRAcnoN5TF0J/OaD8L/dKi+jrFrSPn3HGRbaA==
X-Received: by 2002:a62:3287:: with SMTP id y129mr7289567pfy.167.1590210763845;
        Fri, 22 May 2020 22:12:43 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id y5sm8117974pff.150.2020.05.22.22.12.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 22:12:43 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <04681804-F540-48E9-BD4A-79AF89DBC6CA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_302C41CD-C167-4BE4-87B0-52F30249A7A3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: add comment for ext4_dir_entry_2 file_type member
Date:   Fri, 22 May 2020 23:12:41 -0600
In-Reply-To: <ad3290d5-86af-99c1-f9d5-cd1bab710429@jguk.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Jonny Grant <jg@jguk.org>
References: <ad3290d5-86af-99c1-f9d5-cd1bab710429@jguk.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_302C41CD-C167-4BE4-87B0-52F30249A7A3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On May 22, 2020, at 9:09 AM, Jonny Grant <jg@jguk.org> wrote:
> 
> From 4e9d768a0adb60698ba13e7b7522c15a4548332a Mon Sep 17 00:00:00 2001
> From: Jonathan Grant <jg@jguk.org>
> Date: Fri, 22 May 2020 16:07:58 +0100
> Subject: [PATCH] add comment for ext4_dir_entry_2 file_type member
> 
> Signed-off-by: Jonathan Grant <jg@jguk.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index ad2dbf6e4924..7a042896bab7 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2050,7 +2050,7 @@ struct ext4_dir_entry_2 {
> 	__le32	inode;			/* Inode number */
> 	__le16	rec_len;		/* Directory entry length */
> 	__u8	name_len;		/* Name length */
> -	__u8	file_type;
> +	__u8	file_type;		/* See file type macros EXT4_FT_* below */
> 	char	name[EXT4_NAME_LEN];	/* File name */
> };
> 
> --
> 2.17.1
> 


Cheers, Andreas






--Apple-Mail=_302C41CD-C167-4BE4-87B0-52F30249A7A3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7IsMkACgkQcqXauRfM
H+AHgRAAp9npP2ni47fSZi9ZbX6/Uo1ofdy8J4JD2DateL3H3L2eXbGiFxGDbWpc
vaCOra+hPpWbvSj5T+S5U9Em6GbgiXjg7gKIR/oT1K58jDPpHtylHpyl9QiiOjVQ
Pa/aD2ItBOYuGBtQzHpdcFhZyPSCSgOJ+x+3elVQKUvtNnv+4eC+AhfDkp0X1F8F
SyMb4dLdSrE6hvCQzSqq0uv9erFTR5GUDS0MZ3fhY2sVUxk5dl9QqN/4Dy70vh2X
kkY+9cpE/74vUrX57VBNDlYIfFOD+hMVA56p2OTYPSPYDzxdIHul8pPk5KXzztBN
T0kz9IkYPTgqo+GWh86d+DgUaUuVzUbGJSanv/7E0P2ZpExytOt/X3S+TKAU3MJT
S9ppeATXjIIvEivpMMVro6XLTMh2bxIp+DKPK2l5js5/ya4LRH65kBVQX4HEZ+gZ
OqJbhWGb5370aL8S+qNzCJqR69VV6YnaH72HImzg4sHjXptEK6mS66La8+Izqik9
G08qAU7DI4LlGvOY5RYUyBBo2gnEYjpgd6aCO4gVpCJy2uOGRRSuCWeTGQQ5vIkg
QXtZmDE7ve3lHRoBaIgIZqoDoSP8AWlQyrrVaQD2tN0xqjjXm5tUAx8Qe1OON6fW
V6oK5msVsxHuwqHwqxa53ciNUZDtpAlpcfcYv1Az6oyQQ+OfMoY=
=1T3y
-----END PGP SIGNATURE-----

--Apple-Mail=_302C41CD-C167-4BE4-87B0-52F30249A7A3--
