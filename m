Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C19B2279E6
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 09:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgGUHwC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 03:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgGUHwB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 03:52:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B85C0619D8
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 00:52:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 8so604964pjj.1
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 00:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=BjwXl9xqkrKIpkB3qTfglQTUx0wT7oJf9Dckj86QjNk=;
        b=CMI1U6D1OsNe6YmZO/vg4KKbDleUECViWMdCw7g8dVSqmHCTPFl4I3/ieD0mPiroyy
         w3kXF0tmG9xj3wq1RFhTv8UFYk/cOaQLsFJA3pWkb5ZIyGaJIi9OfYJeve6bUYU/cmIQ
         iLGnLfTwHqO6GwjhN0c8ZQJGDSATYdNyrUWwkWh93XOWZ5dmOY0jTlwE1LUsaKdeAkzS
         dRdOT553BXDIe9xHW7WfYPkuE9kQJUS/W25kKSLeqmMP8sSjcI0lqw4Rp9xcaYxjoflY
         KE47W8bMAh1xllz4lg3GlLYNDuHTWFUgriOkLBe+ZogWfyUVqFBIDuhoy14QwztMbPyY
         jLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=BjwXl9xqkrKIpkB3qTfglQTUx0wT7oJf9Dckj86QjNk=;
        b=lWFSxHvufNTg/+3g8AU5vR6CRkJhwxR9oAMepd9VeKSR8ZKoBfBGnw8YkmxhM6x172
         tYQESsUxPHs5WXP6UW9hVJtZSnJjeXwXlrZrbGbZbceFFpIX7DHfsvagIMoT1zxJjWsc
         gqR/qMTYgjjkmW4qE/vwAPxrl4pieyeIAr0Hy2IRcLjx+alNbxZoxbLky9E/ZUNGyoy5
         iI/lakCmVPSf7tUFQuTa8Z3IvYoLBRlE8eERfq/9SH6J1Wn7mRNQlD7o58xIpfwc2e1U
         Zuvn9IEH0RDMpKa6b8iP2AnEZ/eETVKx8D5eZKF+cqX2DIgtI9pm/rZ4y5fsb2UxUY6S
         WV4w==
X-Gm-Message-State: AOAM5324ddEbkSILLoJMQUZE44YjRlURUfY0KKiXD9g+1nVPKh4b7Ghl
        FOz2/x17z3NF9+Cj5pchzhvPhhcv+6E=
X-Google-Smtp-Source: ABdhPJyyD0QcHt/BFKRMX8UhJGUbT21OmJVXqwy2AIG6JiuXEfjKNMAya4j1wkKdE8TrXhIzDHmkmw==
X-Received: by 2002:a17:902:d211:: with SMTP id t17mr21839109ply.106.1595317919439;
        Tue, 21 Jul 2020 00:51:59 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id mg17sm2048867pjb.55.2020.07.21.00.51.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 00:51:57 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <98AFEBD1-81E5-42ED-8851-4FA5FF3C62F1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_65F1E310-D202-4E92-8035-CA2402E8F12D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/4] ext4: indicate via a block bitmap read is prefetched
 via a tracepoint
Date:   Tue, 21 Jul 2020 01:51:56 -0600
In-Reply-To: <20200717155352.1053040-4-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alex Zhuravlev <bzzz@whamcloud.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20200717155352.1053040-1-tytso@mit.edu>
 <20200717155352.1053040-4-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_65F1E310-D202-4E92-8035-CA2402E8F12D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 17, 2020, at 9:53 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> Modify the ext4_read_block_bitmap_load tracepoint so that it tells us
> whether a block bitmap is being prefetched.
>=20
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

I can't really say I know much about tracepoints, but the changes
look fine compared to other ext4 tracepoints.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/balloc.c            |  2 +-
> include/trace/events/ext4.h | 24 ++++++++++++++++++++----
> 2 files changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index aaa9ec5212c8..5a2f8837200c 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -494,7 +494,7 @@ ext4_read_block_bitmap_nowait(struct super_block =
*sb, ext4_group_t block_group,
> 	 * submit the buffer_head for reading
> 	 */
> 	set_buffer_new(bh);
> -	trace_ext4_read_block_bitmap_load(sb, block_group);
> +	trace_ext4_read_block_bitmap_load(sb, block_group, =
ignore_locked);
> 	bh->b_end_io =3D ext4_end_bitmap_read;
> 	get_bh(bh);
> 	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO |
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index cc41d692ae8e..cbcd2e1a608d 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -1312,18 +1312,34 @@ DEFINE_EVENT(ext4__bitmap_load, =
ext4_mb_buddy_bitmap_load,
> 	TP_ARGS(sb, group)
> );
>=20
> -DEFINE_EVENT(ext4__bitmap_load, ext4_read_block_bitmap_load,
> +DEFINE_EVENT(ext4__bitmap_load, ext4_load_inode_bitmap,
>=20
> 	TP_PROTO(struct super_block *sb, unsigned long group),
>=20
> 	TP_ARGS(sb, group)
> );
>=20
> -DEFINE_EVENT(ext4__bitmap_load, ext4_load_inode_bitmap,
> +TRACE_EVENT(ext4_read_block_bitmap_load,
> +	TP_PROTO(struct super_block *sb, unsigned long group, bool =
prefetch),
>=20
> -	TP_PROTO(struct super_block *sb, unsigned long group),
> +	TP_ARGS(sb, group, prefetch),
>=20
> -	TP_ARGS(sb, group)
> +	TP_STRUCT__entry(
> +		__field(	dev_t,	dev			)
> +		__field(	__u32,	group			)
> +		__field(	bool,	prefetch		)
> +
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	=3D sb->s_dev;
> +		__entry->group	=3D group;
> +		__entry->prefetch =3D prefetch;
> +	),
> +
> +	TP_printk("dev %d,%d group %u prefetch %d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->group, __entry->prefetch)
> );
>=20
> TRACE_EVENT(ext4_direct_IO_enter,
> --
> 2.24.1
>=20


Cheers, Andreas






--Apple-Mail=_65F1E310-D202-4E92-8035-CA2402E8F12D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8WnpwACgkQcqXauRfM
H+DCcg/7Bl0iLs+EtPCXiVIb5ZHKNNF7nPgu2giN4tIwRksvgATb8sVOcfVfZ0dM
plMDXXSqSSZqP0UcBOfcjtbO4td5OJiKiWN58PSHUTXd0HcwAA1jbapZeI8v29KF
dfsuaYxJhz65Du4XvvaT/n7IdRPpzl8Zhu7OH2wvu/kOkzMbJWPEaiiryBZqJW1x
lGYH9bQ8vN8FDIC/ACvxVErlF3PT2zBqV1Dz+srxPwn1TKxnwRYmtdZXnGtd20+/
z36u81jKkYmcHxnt5EQLZfK0KfKDQ9hppHfnXTI8aq32yilBGaeM/Adw53xW9dOU
4uysPfXE5oR7PmHilHDNrKQGHRljhhkaO6+v27VM7JMq8FY/SLGokY4FIio7HPeg
wPRczqOnvhtos5ty+4x0J2bOiemIFEceY1rOUAVPFValtua5mQkGF75XH4JrCT9G
EdcXVzxT2Wa88weojx7UF64OWZxZYNJxSF8PUh01j4L5CddLyfVP8vduZMwyz2ED
P9V7ist3c1zDgRtAwO4X6WKyaHeEBkj/EXguPIGaMDiSaiVkAxuD5zlEzQDzb10K
gvE9MBZASRZo1Q1AeWPHT0y8y6V+qfgYdK8e3BcQtd023PdFf/Ob7FLYOJ1pQQ29
ilOwuDDsbd6i8xrVt/QMpxbhl3a7XOw3PhxgiL4Msn0BlPo9QmM=
=Zx6Z
-----END PGP SIGNATURE-----

--Apple-Mail=_65F1E310-D202-4E92-8035-CA2402E8F12D--
