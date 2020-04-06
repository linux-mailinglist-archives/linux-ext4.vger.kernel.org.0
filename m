Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3DCE19EEF2
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Apr 2020 02:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgDFAnP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Apr 2020 20:43:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46477 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgDFAnP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Apr 2020 20:43:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id s23so5217251plq.13
        for <linux-ext4@vger.kernel.org>; Sun, 05 Apr 2020 17:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vQNJCwHqwBPkuyX7bpVC0v4eQJz7XRfrU4374VWybIk=;
        b=yN+6cFGGeSSHwKRGCTZoDRzypA+9bp991ep6niQCcvUjSiiHOxjjSuIDs7MIDVcLSa
         gz0sXyTS7MbMgyWSEG99FDkOl/h8tWYk/I/NotGd5acRTePZ1E4kmGVN9+ChDZ1fY4X+
         gYIYecpOCYTeMhaFKjnZ/8uJUFPf14McMso8+dKiWWyv0U8AGsfg9lwS3X2DK8cICYCO
         OrFIAqO8lds0tWThLX7AkmXCx03wfmA5PLHu6ZuAomDfYfHIpLLH9A9g2fuq0Y0NajbB
         fzf6IF8EUXc0lYKLgAFQZzuFWM8qB3VPBqswFF814j0JezFJNaAqdgtA/++bICfbsS/I
         wJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vQNJCwHqwBPkuyX7bpVC0v4eQJz7XRfrU4374VWybIk=;
        b=AjF6Oe8P8x3v642TZQzzvuoYWUeaV7Dfew3hIs0GSdyzZgeZO5UslMx2b9BSlydJGY
         JWX5V/ukftAXU/bht02WEDovLqzMAtPT48WWJOaluHiLAGfnpK6nGodwoOdFSe4bEq7q
         lPWN3x33Mm3STZ1jMxv6arw8zN0koB1Izbr9VFViMckg5b8p9C4yl/DqeNhYWoPvpQWY
         BuNkpso2DEWjGzp4aoDV6MYDhqRDCQqyDDOfZXZijsRKCrSAZkji+lXV+i62DiB6GLbP
         wBR6uR870yzywJILrzyhP8Rs9Zu53ft5Pbu2bmM7W95yJrOS3DZT80J62HfEY1YejLXD
         YQSw==
X-Gm-Message-State: AGi0PuYQxhOtSXfohPqMEvMld4otKyFjGlHVwfi4Af7LedZNF9f0yzga
        2RtR5O1hFfOpclfoFKFvCCb0venowzI=
X-Google-Smtp-Source: APiQypIMnCkBWeKEw1I0JOq4zvI8aREHz5I8YJX+VBlgZo62o9kX8klhVCzI2HOTJfRiF47y3vxUWA==
X-Received: by 2002:a17:90a:2226:: with SMTP id c35mr24157611pje.2.1586133793464;
        Sun, 05 Apr 2020 17:43:13 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id j17sm10334500pfd.175.2020.04.05.17.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Apr 2020 17:43:12 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8304797A-1199-45A4-818F-1BBE598C73A6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3A269B50-DE8A-4B22-9741-67F33A88CFC7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] libext2fs: avoid pointer arithmetic on `void *`
Date:   Sun, 5 Apr 2020 18:43:09 -0600
In-Reply-To: <20200405045346.21860-1-mforney@mforney.org>
Cc:     linux-ext4@vger.kernel.org
To:     Michael Forney <mforney@mforney.org>
References: <20200405045346.21860-1-mforney@mforney.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_3A269B50-DE8A-4B22-9741-67F33A88CFC7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Apr 4, 2020, at 10:53 PM, Michael Forney <mforney@mforney.org> wrote:
> 
> The pointer operand to the binary `+` operator must be to a complete
> object type.
> 
> Signed-off-by: Michael Forney <mforney@mforney.org>

Seems straight forward enough.  Not needed for GCC, but strictly correct.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/csum.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/ext2fs/csum.c b/lib/ext2fs/csum.c
> index 8513d1ab..c2550365 100644
> --- a/lib/ext2fs/csum.c
> +++ b/lib/ext2fs/csum.c
> @@ -274,7 +274,7 @@ static errcode_t __get_dirent_tail(ext2_filsys fs,
> 		rec_len = translate(d->rec_len);
> 	}
> 
> -	if ((void *)d > ((void *)dirent + fs->blocksize))
> +	if ((char *)d > ((char *)dirent + fs->blocksize))
> 			return EXT2_ET_DIR_CORRUPTED;
> 	if (d != top)
> 		return EXT2_ET_DIR_NO_SPACE_FOR_CSUM;
> --
> 2.26.0
> 


Cheers, Andreas






--Apple-Mail=_3A269B50-DE8A-4B22-9741-67F33A88CFC7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6Kex0ACgkQcqXauRfM
H+AlHA/+K/yIzip5shEh/ncbhTFUVsVp2MLl6YQ2JkT/bHEjhJkxGUFRnGE4m9c3
O4BleH5A4E+yWW83t4rWLyghpempGK8lB0bWVqB0fdYyE+GFRTpFWvHTVtsqlWmP
xrdLihoFbsHxdzcFMAhoYGVvgYMbj1GQOifg+R2CftNiqxDhiBTrr2FBKGiAVhED
VI1SKCgeCe4IW8r+NV780wCJ2GQLUetyr3kpcJwgRIkfq2Tk15xyvar8aK3hm6ox
8PFlMaaxMxAqT+5vlfoUE/d/LrbVbA59fNHR+/lJnuiCI3jM4I+tvs1/cv7a/aZx
CBnOSwi0wXtP5+8Xx4JMH9rZ6AuycXMfaFQSxLwr1pgFUJoEg0FDYTeTtptA/Spf
UOVmkXxVAF8AhmUJO9NgNchkbRkZvsQ+2ksN5NFsII6BEi9qEB+0Plo9U90QItSC
Jm76+yHY0ONwUYC0ctTsox/GyaQoA323Mj6vwUOLhFV9cw21LbNZYq5cRGYKb911
5/qgiNYP6aPvrmXC3E3VG2yQByrmnMkcreLeXTrjJu0zOCSfod/vK1TNvdBEqjYA
clsFX9f4hCL3f6BSJEPo5Sl7Kn2aOzm+Y//qVLTSAUGhykSf6Uz0Qgu6bvJ15Ruo
ZTewz2XxY3ZxsZhfIB8/CumJqeV1n6rJ47wSFW88K8q/h3zJzno=
=p8y1
-----END PGP SIGNATURE-----

--Apple-Mail=_3A269B50-DE8A-4B22-9741-67F33A88CFC7--
