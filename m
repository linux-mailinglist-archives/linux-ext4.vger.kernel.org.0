Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11E3524F5
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 03:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhDBBMP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 21:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhDBBMO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 21:12:14 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6D6C061788
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 18:12:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q10so2685406pgj.2
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7qaItdfmipkA2sqFGSwihfvOcV2MVwdU2LaM4bGHONQ=;
        b=SaBFw+TzoUyT8e6RdfMcPoQIByS5v6bwetcBiR2/k9Y2O8sK33Fojt4CXHPTpYVXJX
         9XstkkLIX3V4pdCpD3mMO5JwH/ntxGzxpyaPq5VO2F3QXtO9979kpMAjwK1Iz4LsaaF3
         lmAKvlDXNxTjg2Cjmxdy6nVZILje8gK2T1s0uqPeYa3uZlMIe98+hK6yTiPampDmczxX
         0xfrJqOFiUCoTRe8j0nJCnQjuSEk+JyKRKZQm7Np5IsS+8/uEW7lwNeTW3Ng3HUFxxF0
         pI+jvJJLE4KWAk8L0PLlqM6s/PrTgKyHIVHcydqRqNlF1BAtLsQzL+YkwjrB/BulPKjl
         0BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7qaItdfmipkA2sqFGSwihfvOcV2MVwdU2LaM4bGHONQ=;
        b=mEouVU1S1MBVBGGbx2dcVm8POjbkdfG1IvEOKNUH8BCOCirFlY8f1v1tCZkKa+iyQc
         hY4FP4OI97fOXIFOyoXo/NQBjL9HkId7dMhfiFzVhl8NDDeFMIO1jNTmTk/JP5qF9YU/
         yzKWbPZyZFxI8h6T04ZB+xpJRdQnOGJUjmNtVA/WGv1Ef+dooy1kjQ2E9tpRAoH6agU3
         JXO894qLjnZSvyRT9zku/zDsYdPC1Vfi7IrrVK46EtpCOuKOkM3AAZrvLEobWAnFA74A
         zyM37BVDWWAoE4R5KMo+UNZDB2yI0jQl4+QHelppAMeCIi2fc3O4AwhZ07wrsyFl1fQf
         1s9A==
X-Gm-Message-State: AOAM530n3YrLeo+4ynbQGjXkrMZ48Xqy6AAHFfDewMiK0VC/AhaJpOcZ
        k8qu2jyijaDtQhzbFQJbHio7Xg==
X-Google-Smtp-Source: ABdhPJy0gyhxOR32KiJiPLaHalUVmQRyYSs7jo3+qmTMB3RM9HKkoqLDPVlDQ1dCv8DClxarnhHzwQ==
X-Received: by 2002:a63:6482:: with SMTP id y124mr10034862pgb.60.1617325933241;
        Thu, 01 Apr 2021 18:12:13 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id e3sm6489581pfm.43.2021.04.01.18.12.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 18:12:12 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7103B623-9FD2-4BD2-8A44-8DBE38DFE291@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4B471937-B0F3-40E7-8F95-16FF8433D279";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Fix ext4_error_err save negative errno into
 superblock
Date:   Thu, 1 Apr 2021 19:11:57 -0600
In-Reply-To: <20210401072234.3338057-1-yebin10@huawei.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liu Zhi Qiang <liuzhiqiang26@huawei.com>
To:     Ye Bin <yebin10@huawei.com>
References: <20210401072234.3338057-1-yebin10@huawei.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4B471937-B0F3-40E7-8F95-16FF8433D279
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Apr 1, 2021, at 1:22 AM, Ye Bin <yebin10@huawei.com> wrote:
> 
> As read_mmp_block return 1 when failed, so just pass retval to
> save_error_info.

Thank you for submitting this patch, but it should not be accepted.

The commit message is confusing, since the code being changed relates
to retval from write_mmp_block().  That currently returns 1, but
only until your next patch is applied.

I think it is better to fix write_mmp_block() as in your next patch
to return a negative value to be more consistent with other code.

Cheers, Andreas

> Fixes: 54d3adbc29f0 ("ext4: save all error info in save_error_info() and
> drop ext4_set_errno()")
> Reported-by: Liu Zhi Qiang <liuzhiqiang26@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
> fs/ext4/mmp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 795c3ff2907c..bb8353e25841 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -171,7 +171,7 @@ static int kmmpd(void *data)
> 		 */
> 		if (retval) {
> 			if ((failed_writes % 60) == 0) {
> -				ext4_error_err(sb, -retval,
> +				ext4_error_err(sb, retval,
> 					       "Error writing to MMP block");
> 			}
> 			failed_writes++;
> --
> 2.25.4
> 


Cheers, Andreas






--Apple-Mail=_4B471937-B0F3-40E7-8F95-16FF8433D279
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBmb10ACgkQcqXauRfM
H+DN0w/+NNJTjEwtEZ2M4JU4O/swJYTPZRF8xJcn4A6siay+ty2jxadixjbCK8l4
7u7+7w9E+Ie6aPaq4b9QWwPkCE0gfR6BXVMQBV7bB+XNVnjOJzLlvVGSoaTH6FGa
f+JGSFDblAAK/uJLZu53mnwRioqmq/WP9xU26FplLbhAJ8QtyfLgN83/6zxnPjvI
MDQT6BhzdNHHCKOW/BgKKgo6GGJLL8gnFqjizoyd2kmrmtIjKDCWvNAdlN0PRnX7
6C/dVI0S6yQYiu8yCi+lQ2MCOB2TaZPIYCAM24KSRm8v4xyVLKFYThp+g0ZN6lUW
uFAyT9F/i/gRpzO2Va11hJy1RNDdsc/KFtQ0mUu2X3zGi9VZOc/MyUUUG10u+xYj
lo/VQWNI30p2Vki5o7a0wgHehvixwvsFiX+cwTl63NI9sJCY2AQbos7uM00wpH0k
ndHGX6ITDXfUiHoYqdFTqNhtZBsS3xK1CaFB0GjG/fD15kXF6cYqn08i7h3tcDT2
+P593M+jit1IvMTebzAtvHmBIhj+i4p1HggJjijsXaJN7VI8yjjuJh/Yyb9nMkZS
SSnHANSRyGBHlddX8tzwCTafAx6v5/O6Q01Q+jIeiy91jrSNJBlit4tgrJuufZiW
ANy4l4phLr48/bucl+o030FqlzA61dhIabElNGZodoOPI6URYno=
=fqAO
-----END PGP SIGNATURE-----

--Apple-Mail=_4B471937-B0F3-40E7-8F95-16FF8433D279--
