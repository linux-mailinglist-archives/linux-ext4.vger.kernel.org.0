Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9032F3C759D
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGMRVj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 13:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMRVi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 13:21:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3EEC0613DD
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jul 2021 10:18:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so2549729pjo.3
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jul 2021 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=KmC9PqGKr2ILpbVQwV9g2D6L3OtYrbn8qOnUplZx+iI=;
        b=njNA0I+6hz9Jfn4Njkxrc7DMg7EOtHvBkOByo6Hzsc/Z80XxlQnso8vAuNJ62cKoUf
         Aci0lxEMSHBDebLw+3dhkbHEuai798pjsRMiU+c6WeqY2sM9l+gOrGzKw/KQPCILACFc
         H8m6GVahUKIYz7LQZhITjX7WfbHTp1NGH8GVSwhvGi+6nv+aBEGKjiRqs16vMmpzEqRb
         nldsSwyhXMVbIEy0F8Q2W89QSQLbQUI647eSp4qUiVWkGTJXWgS86BXQJulwjmFbGWdi
         dwE/vqIe/2u/NrbYw1G/g8uRL97X+lbMxtIvfVKyPK8dl2WHVmn7zOVD0Mx6JjfMTmT+
         wPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=KmC9PqGKr2ILpbVQwV9g2D6L3OtYrbn8qOnUplZx+iI=;
        b=JJ7W4g/UldxHlVo1O7qhMqYYDRwjdTaklWEhzsvq/STNSFWX5OIZ07EYAYKLRjE6T+
         lYykdy2x7Mmukxs1gC/ueHHqlW2J2mZ/7yRUn/yLce2E6Dvk3KoDjM0o8Fa+4g7UxtLR
         /wdv+TXeyogqrtbKEog9Hfl4EzRZT8BiSQAXf3A8zOOHCDxbqU76rfXpU3s+aS+x4KLF
         HLxv3uJVNPM8hY6mx3CJaYBHgr/VmfczzgFKj3Se3v/+ppWzak5U07eaXqywEvygmeA/
         t10khD95iVznb/HGdGeKvRw/mb3N9cmZLvA497mWq7UDvUkD9Cvl4wYdep1GLhLE8G1x
         fcIQ==
X-Gm-Message-State: AOAM533zG8GJtJEu44c/+QO8+PR2Y4gH5XoWkUWnltE7+ZoAaVWaPIRI
        aGlNQH+yHl8clzCyzw4sLXQffg==
X-Google-Smtp-Source: ABdhPJzd0wJV/9j7yMcch7NlugW+6N+rCME1YUBxhvoZ01nsstAJVXqNTfhO4oIK1aNIgcUVaw9FDA==
X-Received: by 2002:a17:90a:688f:: with SMTP id a15mr5367425pjd.84.1626196727189;
        Tue, 13 Jul 2021 10:18:47 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id t5sm23656606pgb.58.2021.07.13.10.18.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jul 2021 10:18:46 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F9C8FA1E-89ED-4FC5-B343-465459EBD3A0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F61A0383-2348-46C0-B7AD-5E1448A97355";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4] fs: forbid invalid project ID
Date:   Tue, 13 Jul 2021 11:19:11 -0600
In-Reply-To: <20210710143959.58077-1-wangshilong1991@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Wang Shilong <wshilong@ddn.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
References: <20210710143959.58077-1-wangshilong1991@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F61A0383-2348-46C0-B7AD-5E1448A97355
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jul 10, 2021, at 8:39 AM, Wang Shilong <wangshilong1991@gmail.com> wrote:
> 
> From: Wang Shilong <wshilong@ddn.com>
> 
> fileattr_set_prepare() should check if project ID
> is valid, otherwise dqget() will return NULL for
> such project ID quota.
> 
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> v3->v3:
> only check project Id if caller is allowed
> to change and being changed.
> 
> v2->v3: move check before @fsx_projid is accessed
> and use make_kprojid() helper.
> 
> v1->v2: try to fix in the VFS
> fs/ioctl.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1e2204fa9963..d4fabb5421cd 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -817,6 +817,14 @@ static int fileattr_set_prepare(struct inode *inode,
> 		if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
> 				FS_XFLAG_PROJINHERIT)
> 			return -EINVAL;
> +	} else {
> +		/*
> +		 * Caller is allowed to change the project ID. If it is being
> +		 * changed, make sure that the new value is valid.
> +		 */
> +		if (old_ma->fsx_projid != fa->fsx_projid &&
> +		    !projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
> +			return -EINVAL;
> 	}
> 
> 	/* Check extent size hints. */
> --
> 2.27.0
> 


Cheers, Andreas






--Apple-Mail=_F61A0383-2348-46C0-B7AD-5E1448A97355
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmDtyxAACgkQcqXauRfM
H+CTzg/+JZyNRieQ1mPAKlUt+HGoz9ZeEvCD+OuorOAxhYFmVoyOVKKpeXzkBDbr
cTt3eplnVEgwp5qLxX9CHoetTTEiZMv3r6HOG9qv2yYImkYP8vg0FxfvdGVI6uzL
sYin7lxfjCySdra6CQQ1NWKRVMzDUfQShxf6vAWnK1ltWs9tfBTxri0cuVMawC2T
y0dzyuGqmu+ALrqgl2bKw+vFR/igLBNKzUrpCF5KwV+VdFGrqgoL7VKbJwToZ8T5
AxPNUblB98CitSKOoIUL/cygq5IOo6IAAoUtJku18bmhzSwUxb19A/jPpsk35xy5
XC3dpEadhw0XA8+JefthWWucW7nGcOwUevFB2zHafSyFIdR+JpssFa+1sMHwek8X
7CYCZiEbj4bv/qmCIKd2W61veKacnD1i2ZLzyTrHbyA0CjmlYolstl3SQS3jLoKC
RQdkOW5uRU1WpEbT/OMnXnhMKg4oyZFReBMAsL8sSBOYitOHAkTTgxlXj3tLqyKl
kc6Lmy1cY6y9jrRfiFDcn+648exNDrP/WhzhEQt8RYDns3Sww3hapcye/vC8ksrv
7I4+pux8Mu1NYrJJ9XOZ5FLDaypGlTA3Uds+HzE5RGXe3wHF19Wb7KlAnoHMOeG2
A+ArrSOlbMhbPVx+P+5TPyIf4FYbZ691eyzNGde7yPRqT/e1qSc=
=aEGA
-----END PGP SIGNATURE-----

--Apple-Mail=_F61A0383-2348-46C0-B7AD-5E1448A97355--
