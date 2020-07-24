Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D1522C45E
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jul 2020 13:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGXL14 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jul 2020 07:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXL1z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jul 2020 07:27:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB117C0619D3
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jul 2020 04:27:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q6so9605312ljp.4
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jul 2020 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8HeVgGPueNBRRDpahYDN/80YdB4Ni14xuwuUIzLd78g=;
        b=jEfmKM4pU3jtbTxZGT+c8ZMmxrH3aso/dXfPd/YFYjxL6ebVYWfowrb8P0+/YYDDcz
         rOMyTxIurh1mXNV7lsgIodbw/Akn+Fk5FaTHne2CydV0lXAmuH71zCJOk2AGqt89R4oP
         bdlCibOEiYOJctRI2R0avb0c3C5iDoZiem9QRBXeV7+VcV70QTW+OIIwv3GgoutDPDI7
         3nQ245PRQ5AaYUpfTbFeMk0j9sz0DHZyHOiStA7q23H3hZHRJ5mliwCpqvQhfA71Kb/L
         CnsHRhtnEUtljks8AUayflMRr6g6K4Ri0UnQ4s+VamrKlahvmZRxafOustYx54wGMa+T
         lnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8HeVgGPueNBRRDpahYDN/80YdB4Ni14xuwuUIzLd78g=;
        b=sdeUVQfzmmb0dRQry0jGcd2pTIB6AO32Yo4VOTnESaPNP+pXc6j9+mXjb4hTY/WDb7
         ER57ERqL5u7AxMtu61Jw6scNTVSJM7ORrAhmh1EXYBzjaAILodFQXTuQmAJH7JLaHB8j
         /WMPNiehxTfoux8ik7gPvKs8gAXUqgiOGnR0a4dJJV37dpYkcYG+25OTrjygxiHJo4rk
         wdrCzxm/EFDy8ECZrRYxXAwp48oKCfjsNWu4xDsLfYdfosaIc6jUXU8DL2ZFax43FtwI
         U2zwpcmEEb34MvJLmC9J6qEopqs+89hpo6QHwBkCAmOYCaeB4DMVobQGOXVhFi+ooC9w
         x83g==
X-Gm-Message-State: AOAM530r1KOT5u8oTZ8lbIn0fzXqQ3RwiYoMyy8Gb2xVyyoVez7unAWi
        SWogDozpTxgvoZQT214mlSU=
X-Google-Smtp-Source: ABdhPJwGP8pxXXMm7lxWvfp40/2A8mokNaqLikCTwxcJFEn2i3ECq8OIPf9X3Fcfe0IBgSbkClfc4Q==
X-Received: by 2002:a05:651c:1291:: with SMTP id 17mr4471491ljc.286.1595590072273;
        Fri, 24 Jul 2020 04:27:52 -0700 (PDT)
Received: from [192.168.1.192] ([195.245.244.36])
        by smtp.gmail.com with ESMTPSA id b16sm178890ljp.124.2020.07.24.04.27.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 04:27:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 2/4] ext4: skip non-loaded groups at cr=0/1 when scanning
 for good groups
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20200717155352.1053040-3-tytso@mit.edu>
Date:   Fri, 24 Jul 2020 14:27:48 +0300
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        Alex Zhuravlev <azhuravlev@whamcloud.com>,
        Andreas Dilger <adilger@whamcloud.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <81448013-525F-4C51-A9F3-88969CB49B70@gmail.com>
References: <20200717155352.1053040-1-tytso@mit.edu>
 <20200717155352.1053040-3-tytso@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3445.104.15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good.

Reviewed-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>

> On 17 Jul 2020, at 18:53, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> From: Alex Zhuravlev <azhuravlev@whamcloud.com>
>=20
> cr=3D0 is supposed to be an optimization to save CPU cycles, but if
> buddy data (in memory) is not initialized then all this makes no sense
> as we have to do sync IO taking a lot of cycles.  also, at cr=3D0
> mballoc doesn't store any avaibale chunk. cr=3D1 also skips groups =
using
> heuristic based on avg. fragment size. it's more useful to skip such
> groups and switch to cr=3D2 where groups will be scanned for available
> chunks.
>=20
> using sparse image and dm-slow virtual device of 120TB was
> simulated. then the image was formatted and filled using debugfs to
> mark ~85% of available space as busy.  mount process w/o the patch
> couldn't complete in half an hour (according to vmstat it would take
> ~10-11 hours).  With the patch applied mount took ~20 seconds.
>=20
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-12988
> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
> Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
> ---
> fs/ext4/mballoc.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 8a1e6e03c088..172994349bf6 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2195,7 +2195,18 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
>=20
> 	/* We only do this if the grp has never been initialized */
> 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
> -		ret =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
> +		struct ext4_group_desc *gdp =3D ext4_get_group_desc(sb, =
group,
> +								  NULL);
> +		int ret;
> +
> +		/* cr=3D0/1 is a very optimistic search to find large
> +		 * good chunks almost for free. if buddy data is
> +		 * not ready, then this optimization makes no sense */
> +		if (cr < 2 &&
> +		    !(ext4_has_group_desc_csum(sb) &&
> +		      (gdp->bg_flags & =
cpu_to_le16(EXT4_BG_BLOCK_UNINIT))))
> +			return 0;
> +		ret =3D ext4_mb_init_group(sb, group, GFP_NOFS);
> 		if (ret)
> 			return ret;
> 	}
> --=20
> 2.24.1
>=20

