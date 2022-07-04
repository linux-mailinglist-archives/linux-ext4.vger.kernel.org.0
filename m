Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F57565E9B
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 22:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiGDUpV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 16:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiGDUpU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 16:45:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835EF261A
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 13:45:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso3413709pjb.1
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ZRN+SVKsOnJKMG2HuaIxceRshbf8K8HdxHrruvFEc+A=;
        b=kMCiNEBIJndhfxsVXVF6lZt0B97LxbCcC82DxNUw+o93d1HhgmTIwUIGa4nsw5wVt9
         g6mE2NqRWDjY6H2wRbuYLtoxGDw+yumAcdoNy98V+Qwaxg5iHRR3tkeUJzIcZU+sYfk+
         hkGG4S8FFCIojJoCAvYkk813y7/uKNgGrV41hBCaPYm8LPMoOxLzzhFjmm2vfV2iWrMW
         0VlOWOa67AVaO6BBb5iPt7p6bZ1sK+GktGz3nNFdY23TEbF/DuVxwvjfbFB5QG/OS663
         6S93TqrAq5UlRMOL5EgNTTMxg79rfYxdYsJg0ZhpEdlUmLtZGEWG/57qcCwXHN1xceFj
         ad2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ZRN+SVKsOnJKMG2HuaIxceRshbf8K8HdxHrruvFEc+A=;
        b=OkUWHm6NSHEXU0b6AqTaw7jo2/kKx0EvIBR8DilGYcw1fortZiqxaZLU9Tw0rwAz7n
         /GvcBM22p3JOuODz2OTr6JWTlvW8Fh/E5BQVy7u/7dVK0dCfthTVcOPoj4ONfru0Q6hj
         4f3VgkYB3R2j7h1XS4Sz3tb6gQJ55U2gC9dkreJEkff4eJ924hRs9jQOHwr8QOCNpeDP
         w0E9hyk/hJim4T6U9A21J8Px8AOQOESvU+07URh5+xMF+wdjZ+/l/jXffeytXMdQYz+o
         BKvNkqkH48Ck2VYbtsieReTUcOZWYwkc8bXuZZ14jK9UZ0jMDimR/vCKGOLtFRYO2hBA
         k92Q==
X-Gm-Message-State: AJIora/hZEjadF29udPiN3zGlQh6tc04ENFFcb1ug49QqFYj2tt+S3vE
        d1hzFqheWmzqHol4uWTvQ0aviQ==
X-Google-Smtp-Source: AGRyM1vQsAf8Zvfu4IIIIiy/rYq6BHTbRcT456ScFfsi810M4MsQv32pkZ6qK721AaetlLCp0LEjtQ==
X-Received: by 2002:a17:90b:3b52:b0:1ec:db2a:b946 with SMTP id ot18-20020a17090b3b5200b001ecdb2ab946mr37168683pjb.229.1656967517723;
        Mon, 04 Jul 2022 13:45:17 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902c40e00b0016bdeb58609sm3607046plk.238.2022.07.04.13.45.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2022 13:45:17 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <2F240021-C24A-4F86-ACDA-2FF944F9FE6F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_96600856-1A1F-4AC7-B57C-EE26B4D16851";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: update s_overhead_clusters in the superblock
 during an on-line resize
Date:   Mon, 4 Jul 2022 14:47:43 -0600
In-Reply-To: <20220629040026.112371-1-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        stable@kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
References: <20220629040026.112371-1-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_96600856-1A1F-4AC7-B57C-EE26B4D16851
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 28, 2022, at 10:00 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> When doing an online resize, the on-disk superblock on-disk wasn't
> updated.  This means that when the file system is unmounted and
> remounted, and the on-disk overhead value is non-zero, this would
> result in the results of statfs(2) to be incorrect.
> 
> This was partially fixed by Commits 10b01ee92df5 ("ext4: fix overhead
> calculation to account for the reserved gdt blocks"), 85d825dbf489
> ("ext4: force overhead calculation if the s_overhead_cluster makes no
> sense"), and eb7054212eac ("ext4: update the cached overhead value in
> the superblock").

Would these be better referenced by Fixes: labels?

> However, since it was too expensive to forcibly recalculate the
> overhead for bigalloc file systems at every mount, this didn't fix the
> problem for bigalloc file systems.  This commit should address the
> problem when resizing file systems with the bigalloc feature enabled.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: stable@kernel.org

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/resize.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 8b70a4701293..e5c2713aa11a 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1484,6 +1484,7 @@ static void ext4_update_super(struct super_block *sb,
> 	 * Update the fs overhead information
> 	 */
> 	ext4_calculate_overhead(sb);
> +	es->s_overhead_clusters = cpu_to_le32(sbi->s_overhead);
> 
> 	if (test_opt(sb, DEBUG))
> 		printk(KERN_DEBUG "EXT4-fs: added group %u:"
> --
> 2.31.0
> 


Cheers, Andreas






--Apple-Mail=_96600856-1A1F-4AC7-B57C-EE26B4D16851
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmLDUe8ACgkQcqXauRfM
H+C6BQ//c1Ua2NWX/usTVAU7xwhrQ3d5frSzJcq48+NUKkZsqXdMyWo0gaXDmROY
MyYNgt0t/CZpw92UY3h/IIAJqM4U/4khTIytcnDs5VBgzb4YBDW9ApdkNufA/Eg9
2U02duNtG5aq7f2tWEOdQtMB//N+gXjTAFBBynv6FjYtwRhIA7AM8Rw/vvz3pER1
SDdJf/+ZhBOofNcyUU/sQkXPmYqG2JRngtzxvc5V2l6CMPNCX3WQCzIgIEUvvl01
G++xDF3mhLxzuYEZOCvSuLW4BQ5zWyVkDQsgYWDN5/nwleD10INM9S8lmPgjAzm8
AYjXx29BYUZbgtnVUTwj1I+moRw4XrNkBVSf8hSA3eNuGLWREgkhA+l01jsXUf+g
A4OpkA7QOSQ+LkGv+tRY3yDz4NrZvjR0hWYk7JcmW+sstuYyicYw45Pzpxbsjld/
EXdpFNbxofjM+n5sllauHyGU6I3wviC8WN3gJ3OlBRZB/W/ApXNutVGaVCMvtpkG
7oro6wlLyMHophfN+uTe9xGxrLjhMuaR90jZmx98OiPFMs57DXWeTSX9NdxNIVyZ
5SdtvkwTAb79iUpQwMcSAN53LLSfzSTM/JcQ0yTOcopHh0UTZt6ovPLvqjl+pTq5
oOhU/HvxcISKcxyCTTCCFk0WpjPHEKxxzbioQWstMbtMdzmUofE=
=ka7w
-----END PGP SIGNATURE-----

--Apple-Mail=_96600856-1A1F-4AC7-B57C-EE26B4D16851--
