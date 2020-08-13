Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154452436D1
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMIo1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHMIo1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Aug 2020 04:44:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC46C061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 01:44:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 74so2448222pfx.13
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=YsaPfH6OIRUSxk0q3w7XpNO3LTpUv0FabKhBNcJj+5k=;
        b=YzREQl98Rd7mpLbhPnBMXNZGPg05hJB2UDNrm8qp/rMZ/Nhnl9OmXdAurQOh4XRP5B
         3AITNkOVDVvwvnKWHxTiZBdwghVw+TmQERH3Mjl/70tpl5Y5ip7CbQ9BQTqAhL7mw7Hr
         hqamS4cnK7UeQGQCJEXMEgXlKGGMRvfgYyYIF+MwxCIPonZCtHGdgK+RNykDrVLV/yoE
         rJtlIskVcpR19vkT+APJfCCGFOmgLLO+Xa8Zy6wpf0+j1414skKeqLjf9+Cg0un9Gdfl
         MfequMeFdG0UNU66LIMhwoNKOadb8gtUsexwkxm42zTDWr9kFSJWjcgwwMY5p6Nh0aft
         WGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=YsaPfH6OIRUSxk0q3w7XpNO3LTpUv0FabKhBNcJj+5k=;
        b=JBVfNs0KS3WmItsLEycwV514AABX0r0hcCwJiRG+g7WPgocFCwqp9OUdMYslu9sgMi
         vDLz5hRYCdDP9HQUGHoWXbN/sAAO2g11xwgw9V7oriHd31MIa5H4xQGQvTbvw9/YBq1m
         lkU9WCHGIEx5aLM9go9agy1QNACvbxebddhOOoZSEwR3mbdvQ0SLXyj+a2c1rsrV5LxX
         g6uIfqORazGkwuxEiDlzyznOLOfJiPZB9leKktKmcajKPlibWAorVmr9ZkCAYNWcLS76
         un/Dfk8e1CKxmweIPFnthj/n4uv/Avjrye8I6TJHGpNqWNHd8s4jA0pakNjhTheG2Pc+
         Nyqg==
X-Gm-Message-State: AOAM530PphroQKpFyvqFtPm+fZWDVCLDIortYOTBbYPjKP1X7M0kOCUW
        F9RFGPMF5EoR6tG67SsTKdupzQ==
X-Google-Smtp-Source: ABdhPJyStBVYUs0/qVm+fl/gKaQELNJm8zHfdFJAXUjVv9zui605bk9vasrFU/vanVjHlkiOTbEHgQ==
X-Received: by 2002:a63:ff18:: with SMTP id k24mr509513pgi.109.1597308266902;
        Thu, 13 Aug 2020 01:44:26 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id m26sm4909369pfe.184.2020.08.13.01.44.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 01:44:25 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <B72B3282-4D45-41BB-8A39-66618C1CE69A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_60D0F69B-B5DD-4D83-AA38-B9009ECDCE98";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: delete invalid ac_b_extent backup inside
 ext4_mb_use_best_found()
Date:   Thu, 13 Aug 2020 02:44:24 -0600
In-Reply-To: <0c77de22-c0d0-4c1b-645a-865bcd2edc0a@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <0c77de22-c0d0-4c1b-645a-865bcd2edc0a@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_60D0F69B-B5DD-4D83-AA38-B9009ECDCE98
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 7, 2020, at 5:32 AM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> Delete invalid ac_b_extent backup inside ext4_mb_use_best_found(),
> we have done this operation in ext4_mb_new_group_pa() and
> ext4_mb_new_inode_pa().

I'm not sure I understand this patch completely.

The calls to ext4_mb_new_group_pa() and ext4_mb_new_inode_pa() are
done from ext4_mb_new_preallocation(), which is called at the *end*
of ext4_mb_use_best_found() (i.e. after the lines that are being
deleted).

Maybe I'm confused by the description "we *have done* this operation"
makes it seem like it was already done, but really it should be
"we *will do* this operation in ..."?

That said, it would make more sense to keep the one line here in
ext4_mb_use_best_found() and remove the two duplicate lines in
ext4_mb_new_group_pa() and ext4_mb_new_inode_pa()?  In that case,
the patch description would be more correct, like:

    Delete duplicate ac_b_extent backup in ext4_mb_new_group_pa()
    and ext4_mb_new_inode_pa(), since we have done this operation
    in ext4_mb_use_best_found() already.

Cheers, Andreas

PS: thank you for taking the time to look at this code and improve it.
I know it is complex and hard to understand, but going through it like
this and trimming off the bad bits makes it a bit easier to understand
and maintain with each small patch.

> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9b1c3ad..fb63e9f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1704,10 +1704,6 @@ static void ext4_mb_use_best_found(struct =
ext4_allocation_context *ac,
> 	ac->ac_b_ex.fe_logical =3D ac->ac_g_ex.fe_logical;
> 	ret =3D mb_mark_used(e4b, &ac->ac_b_ex);
>=20
> -	/* preallocation can change ac_b_ex, thus we store actually
> -	 * allocated blocks for history */
> -	ac->ac_f_ex =3D ac->ac_b_ex;
> -
> 	ac->ac_status =3D AC_STATUS_FOUND;
> 	ac->ac_tail =3D ret & 0xffff;
> 	ac->ac_buddy =3D ret >> 16;
> @@ -1726,8 +1722,8 @@ static void ext4_mb_use_best_found(struct =
ext4_allocation_context *ac,
> 	/* store last allocated for subsequent stream allocation */
> 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> 		spin_lock(&sbi->s_md_lock);
> -		sbi->s_mb_last_group =3D ac->ac_f_ex.fe_group;
> -		sbi->s_mb_last_start =3D ac->ac_f_ex.fe_start;
> +		sbi->s_mb_last_group =3D ac->ac_b_ex.fe_group;
> +		sbi->s_mb_last_start =3D ac->ac_b_ex.fe_start;
> 		spin_unlock(&sbi->s_md_lock);
> 	}
> 	/*
> --
> 1.8.3.1


Cheers, Andreas






--Apple-Mail=_60D0F69B-B5DD-4D83-AA38-B9009ECDCE98
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl80/WgACgkQcqXauRfM
H+C0lg/+JsptkofxlCAEQZB2GdJHqTCj1XRW/621+cBcJTI+PIxgxVrfYfz6pHaq
m2l1uejDlHvGWb7eIKZsX+qgvw8r22SKJmwwzBl9uanQFbugET31VJS6zuj3o9yy
EMkQiad7Mi5hzk2y/LecD68bViq2IJRAjWxXkrfmpXtDO4u302ZPPm9ywAjZXYGX
X++u8UouaA64A7Y4WskR9wevDMcOyuabgsloj5y7+1EvOjSQsQBR27gMSCyp1Eu8
o+WBfV7B6X+y/HJBhC1TDUcbgZwFjWhct+w5TsHggtJd8rXXXhfuxWisU4VuVNc5
u4VSk13pycdL+WCPAt9mLB9yKp6NDNkdXHIrotxQoDt1IzUP2psREbirJMIPUWpc
iLbg/F2tpLXZgE2NaQmbziREFjI6oSIo9Xck8d3aVUic45LnwG7tcaGjgPwwYbvZ
gFemBl6skAqVfcEiemHZFSrE2xBw6zeV6Tvg/LmKxNjHjU6fPohVXGczWjnzKz9r
FX/QhAgU84zKb6fWV620BCe/cRKJACZWXF4sxzjUwpc+m3E8lQia5E2R3ey57na1
Hrqt/tHPfi804a/WqP2LmCDCdicDPqQbBmeoKwhc7xCAEtZEGOvoRWrVRbut4Yh4
WDxgrgilLG0V/k7K6mieNqk0t8iMlUiVMyrnMk0NKEzyiJycFwU=
=92cs
-----END PGP SIGNATURE-----

--Apple-Mail=_60D0F69B-B5DD-4D83-AA38-B9009ECDCE98--
