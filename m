Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBE82A3613
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Nov 2020 22:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgKBVhn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Nov 2020 16:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgKBVhn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Nov 2020 16:37:43 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BDCC0617A6
        for <linux-ext4@vger.kernel.org>; Mon,  2 Nov 2020 13:37:42 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b12so7508248plr.4
        for <linux-ext4@vger.kernel.org>; Mon, 02 Nov 2020 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=hC66qz17yYI4TBPWhq0F8w5gPfEffj7flykyynfyxO8=;
        b=eUrFynG6D7tYorhA7pdZfAQHVBACLQFh1zG//BU0DU1bihxGRtqYJGLySfKgFgANrf
         Xs7Pfz7K4BlrDA7D0bN+3MeObMih+Gp2hUscFTfUz/h7/LHWShrz2tfHA4v1JMwgqnW/
         y+XViHnxj9dcK2ZRY1faYXe7c3a7h/FfvooyGbcv6BFF59wXsKRYqRTdtzuUcJaZvJWd
         uviAgKD1gQDdHi+HdjEaj3/7lq/nkDUC182gjW5jaPA4Dzm0Gdl8j+euZcHAVMSYR+EN
         IU3g19/aMl2taOAfakIJ6URJkbk4ldi4qFJfwdDQPsZtv/flld+eGPaDapGNM9d8cAj5
         FX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=hC66qz17yYI4TBPWhq0F8w5gPfEffj7flykyynfyxO8=;
        b=rbG7niVk5GNWnvl1X5wdtFPSqFw5qbNsJ2JljmHaTDOoqwSHaBIYdAP8IScz4Yl3Cu
         T/YfKffa3t6a2aSo4Rkai/gMuGM1Tf6NwUs4AyENTa1AB5zTcc0HqugtEuck9XPy4QyA
         5T2uhhl57fSmxKucOz1vW6T50ntiimweN+n93ZvPsG1aT8KT6346FeUPO7+kM4jomOzo
         3QP/LZz8XAMRFVZ54OpCp/YYjDgOJ1jRuXWa7GQ7MhzDzYIZ3xNboUIQZu1ShFk8io9i
         M2b/+cdtVZmFiED7GjY40wydI+0/+wJbzSt4V3gBvvnrPed8OphyTCxbjkDNCVB+R93u
         ZGWg==
X-Gm-Message-State: AOAM530XDFdT90aWaX/uG70S72tnpU3d0l8ljFExtiMaAEcDMCpAJXBB
        A5+e49yOrvDPSDg8qeEGg8GAlw==
X-Google-Smtp-Source: ABdhPJzXtVxLWR/Thj54SlLyQvghZh0GhApBD2FGLBVsXbSSxFsDHUDx61ppaDFbVa2Y4dRVzThSFg==
X-Received: by 2002:a17:902:690b:b029:d6:41d8:bdc7 with SMTP id j11-20020a170902690bb02900d641d8bdc7mr21901507plk.7.1604353061635;
        Mon, 02 Nov 2020 13:37:41 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i17sm14627615pfa.183.2020.11.02.13.37.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 13:37:40 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <94DB7654-D529-499C-80F9-7ABF25FC3939@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AA550751-EE28-4E87-97DF-C7B839C1DA6A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] mke2fs: Escape double quotes when parsing mke2fs.conf
Date:   Mon, 2 Nov 2020 14:37:38 -0700
In-Reply-To: <20201102142631.87627-1-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
To:     Lukas Czerner <lczerner@redhat.com>
References: <20201102142631.87627-1-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_AA550751-EE28-4E87-97DF-C7B839C1DA6A
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Nov 2, 2020, at 7:26 AM, Lukas Czerner <lczerner@redhat.com> wrote:
> 
> Currently, when constructing the <default> configuration pseudo-file using
> the profile-to-c.awk script we will just pass the double quotes as they
> appear in the mke2fs.conf.
> 
> This is problematic, because the resulting default_profile.c will either
> fail to compile because of syntax error, or leave the resulting
> configuration invalid.
> 
> It can be reproduced by adding the following line somewhere into
> mke2fs.conf configuration and forcing mke2fs to use the <default>
> configuration by specifying nonexistent mke2fs.conf
> 
> MKE2FS_CONFIG="nonexistent" ./misc/mke2fs -T ext4 /dev/device
> 
> default_mntopts = "acl,user_xattr"
> ^ this will fail to compile
> 
> default_mntopts = ""
> ^ this will result in invalid config file
> 
> Syntax error in mke2fs config file (<default>, line #4)
>       Unknown code prof 17
> 
> Fix it by escaping the double quotes with a backslash in
> profile-to-c.awk script.

What about using single quotes for this?  That avoids the need to escape
the double quotes, and avoids significant issues (IMHO) when the number
of escapes grows over time as they are swallowed by various levels of
processing.

Cheers, Andreas

> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> misc/profile-to-c.awk | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/misc/profile-to-c.awk b/misc/profile-to-c.awk
> index f964efd6..814f7236 100644
> --- a/misc/profile-to-c.awk
> +++ b/misc/profile-to-c.awk
> @@ -4,6 +4,7 @@ BEGIN {
> }
> 
> {
> +  gsub("\"","\\\"",$0);
>   printf("  \"%s\\n\"\n", $0);
> }
> 
> --
> 2.26.2
> 


Cheers, Andreas






--Apple-Mail=_AA550751-EE28-4E87-97DF-C7B839C1DA6A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+gfCIACgkQcqXauRfM
H+DN+w/8DjqwNX/YeLXhZC+bqQtWBQ+m+s0EOReQiA/ph0kw0/QAc6CeabyDhoJd
tYxeK8pzopX1Vt4xrzhd4Q9moNe3VZZqQWxofOeNYxIuTc44fxv18RBX+7mVrLH1
/4rhHpZZqz7Ls2KOO2ycKz/+RWIJu9AEjPZzk/SdxB0oKUSnYpAfMrVitzneK3zU
9K1UvHmQNce20rT2y5p42K4i7rqOMdBh0WcVhxhU4MGtEJvD0eGkfiauzYLCBJxU
7Wg0luYmg1wHxGEDRe3/966rXWQ3txf9Z0Zc1hxOlNDE554JKxd2O2F/Tp7WLPEu
fxRaLQ9wl+NgLzybBqXSBC7jfX378V8xOhU6AkxxIHZ8zY0d4H8HmBVB7B5G891W
GY3yed4VK5tEVJsjf5FTUox/zp0wGxlmHDtIy4YvxjlKh6KZ4BLkUHuOxl8lWILK
H7Zl+rnQgCJmzx2Of5wl/8ClxMJulNULI73Zfn/YcL7MDOVa/mZGTnEdRmEXCO1y
X2EqyHzr90kAxcctSgRSIp0LTolz2epHCPo46tjEygfWRH2jWSGufXgKApVaOAUl
1/VAmBkQKpIUdoQYiFmWt+FcDZOFtO9vqZ73pLyzA+0vslPs5U39Am+APqG7M0de
1ICA81ki7JWLobWhmncaIiE0KbrotIkKQLZDjARH2F1PBbvKKeg=
=S+dN
-----END PGP SIGNATURE-----

--Apple-Mail=_AA550751-EE28-4E87-97DF-C7B839C1DA6A--
