Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED227BAC7
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Sep 2020 04:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgI2CYR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Sep 2020 22:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgI2CYR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Sep 2020 22:24:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57805C061755
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 19:24:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so3025206pfp.11
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 19:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=GItoqC8b+m/grhw0aOdRmvOlOsH1skKhKu+IwsddPhI=;
        b=eGH5a4XBkAhNbUuQUcimjS4gdVkqyCVhlFpmHsMMvizWc/LFBx65Suvupf3OW1P3wU
         3uq1cIBXsA2Xpafo+KVEnReSQncpCmMlTpvI5sfo6J9D3Z87VLjMB023CMLTRDE/XEds
         Z5KDrmUM8EXnmKeM8mBvqMoMbvm1WMDtE+Q6lxwHLT+Kh3XFXhtkFWsuuOCpluvbdiuN
         rtNqzbj/Qj9PGnSCHtWZTuKrnLNbto2oAINYwdX38DooxQG69v8LhEjhBBjwUif5LLWI
         DnQY01q99Cgoi+L67T729qZMyDkTHoa6JxgOx5zgzUtKUQDjyQnoJElgP7wT/sEjR9lv
         V0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=GItoqC8b+m/grhw0aOdRmvOlOsH1skKhKu+IwsddPhI=;
        b=LzZiI0hlxvqKrvHUNfW1mG6Rq7W+TTs2Lt3jRaD91EF8rZKcnCX3eggJrKSr/VmGnr
         tpW4eXV0FQv9feQHE/VZtrBB8FOMFbdZQ/X3sh5CCFzn4ArTgvOoTiDjbG8qxxRhFszJ
         4mZlJTHdRhkZXekvEpf/c2OHciU5+AcILMjL7YVGreLC6RFlwonWh2nGx7hYzty9AqGr
         gUN3qFRr6fS19yaRKn0YJzULh1tJK1HSzGUJA05oA6NXQt8TmQGxMI3UVNCoOYsTwpOZ
         LwsSZgs0ybd9/w8wlk2YGIQJpbFhakAadhIafbPDAk796zusvx5fwJdHP9Ton8at66+Q
         5wgA==
X-Gm-Message-State: AOAM532Ix0a1B3oKLBgkLx6NJeAFF7ozqP6jIqTIlfIH4IxwxjtLFi1+
        7mjFF8g3b3IoueMQlfWoTLsz+E41ntxe9G0s
X-Google-Smtp-Source: ABdhPJw6YtPsLLCg5HLfTPZ08ChBZ5sMoCyYY4mFYbBifHowGxl68RBI0JjRJAFvy7V7fiYEicjQCg==
X-Received: by 2002:a17:902:c151:b029:d2:ab80:5845 with SMTP id 17-20020a170902c151b02900d2ab805845mr75597plj.84.1601346256677;
        Mon, 28 Sep 2020 19:24:16 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id h11sm2637396pgi.10.2020.09.28.19.24.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 19:24:12 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <2A963475-D65D-4E58-9EDD-93D6784934B4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1895A279-0157-404F-935F-E0D4BCB0D12D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v4 1/4] jbd2: introduce/export functions
 jbd2_journal_submit|finish_inode_data_buffers()
Date:   Mon, 28 Sep 2020 20:24:11 -0600
In-Reply-To: <20200928194103.244692-2-mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
References: <20200928194103.244692-1-mfo@canonical.com>
 <20200928194103.244692-2-mfo@canonical.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_1895A279-0157-404F-935F-E0D4BCB0D12D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 28, 2020, at 1:41 PM, Mauricio Faria de Oliveira =
<mfo@canonical.com> wrote:
>=20
> Export functions that implement the current behavior done
> for an inode in journal_submit|finish_inode_data_buffers().
>=20
> No functional change.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>

A couple of minor cleanups below, but either way you could add:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> +int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
> +{
> +	struct address_space *mapping =3D =
jinode->i_vfs_inode->i_mapping;
> +	loff_t dirty_start =3D jinode->i_dirty_start;
> +	loff_t dirty_end =3D jinode->i_dirty_end;
> +	int ret;
> +
> +	ret =3D filemap_fdatawait_range_keep_errors(mapping, =
dirty_start, dirty_end);
> +	return ret;
> +}

(style) still prefer to wrap at 80 columns if possible.
(style) there isn't any benefit to "dirty_start" and "dirty_end" as =
locals
(style) there also isn't any benefit to "ret =3D ...; return ret"

I thought it might be coded this way because the function is changed in =
a
later patch in the series, but I couldn't find anything like that, so =
the
shorter form is just as readable, IMHO:

int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
{
	struct address_space *mapping =3D =
jinode->i_vfs_inode->i_mapping;

	return filemap_fdatawait_range_keep_errors(mapping,
						   jinode->dirty_start,
						   jinode->dirty_end);
}

Cheers, Andreas






--Apple-Mail=_1895A279-0157-404F-935F-E0D4BCB0D12D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9ymssACgkQcqXauRfM
H+A3JA//cVPI2Nq606YX32v0lhT6+6dXva9pFnqnM2xa8zDLQB6iutwdLE4R1sOL
7aVtwQlxQuUxCx1sMcYVjZ8YhatwSxzxrVkYbO3yLO3L/o9k0qL5Nwjk25vKqOzm
MUbyCpNfn+pqdiExsWcWL34ERUADVuO+oCNCS/x0hm0DndvM/QxW/XCR942VM9f/
AZjaXVV7wywlgGjMjDEZvSyFZXgJkNIEUTAHCBbR5y9QaQgNGU3p8bjM/vXNO1mU
anINlRXrIAHNbhpYEaVLvlx24cNVvv+644+H4/D6xxZj2XvFiE/8DmyqINXRcq8c
39OkLZU/ExDj2wcuZ4gz4nlccDox4wj34skex9G0L+mPsHSpzIXk+VJKArHOp6Eh
xwfI6GYG+jY78rIn53Dunh/rXlCNmB+x8X0Yo+180lyYXykCb0sn93JaFO+2CJxA
UMdqofeAuVzZs6yNO//27pcsJM8/REmqfwfJCMP6r9554ww8IlgPFtxoGPCamoyZ
H/MVzdfP8JgG5bg9tBx4Cq9nmwPFmtz7ZiAbe/m3N79UNh6b7FH8prn2AvwpAOZz
ZHDtm1n/jPN09xgXqPm+uX9jNk9v3ULr/w0UMSD0Ym509MAZUl4KN/qYblnlZJWx
Y8Hl2R41p3ln1eK8+uufPjA/y1KeYrmm2IqdEtkZmT+Ms36PsSs=
=M3+F
-----END PGP SIGNATURE-----

--Apple-Mail=_1895A279-0157-404F-935F-E0D4BCB0D12D--
