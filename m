Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C1727BACD
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Sep 2020 04:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgI2C2R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Sep 2020 22:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgI2C2R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Sep 2020 22:28:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BBCC061755
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 19:28:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jw11so1846912pjb.0
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 19:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pFklOzCmmD+XNgJnouQi4ImVeUsUwV2WYFotV7F6iWQ=;
        b=o2RoXORQ4BsP5jf1DL+vb0eUjycexPkgwtES7731e9m6pmnXo9YrAylI7thhEviANm
         bewGvX9YRaBjGHGvxKy80DkSWfS7vF5t54nsKiakm+asA+cZj6hkVGj43Ln8Dvt6nAJP
         c45+Mg9q8MpS3FNxYt5U1NbZSxp9kWD/nWjHXyUF3sJvHCj6av7qNiwo+3EkENUYnKl1
         jXbf740pr5svE/8fvvVOM8yAQGhEC7CRapif1tFYLz1M6Cxd5ic0n6HZLfnLrDo+Orvz
         XFQ5YsOS7i6AgGgpWiQEt5YbdIQSNWGsK2VLjIk+DiQwC9+icID2IedtqXUguK2oUB9a
         +eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pFklOzCmmD+XNgJnouQi4ImVeUsUwV2WYFotV7F6iWQ=;
        b=LM3GAILTruCZvXxY2KNgZyggNQpR0Vg5tqKOrWX5ZToCT/tzjeyGYrptALXFlLfXRh
         WZVr+/qnuMpAodGglwAlJHVSct47L7X905AKEruyTNIJk6McfAfksomyZA2Cawt3B64n
         4nIn1mluvjElTyKCuchoXjSiRtzTC/Mf63KRjuM1ul5SHRnKDwZcRyiGfMtz5vr9Pn00
         L53Xe81lWjffNmrxDOxQem3jk4KMIMnpHDKXYu948ErXmeBlUrT0tK+zrTARJbXeX3Vh
         NOc+/yXjtwU5IJtSgI/4wy9I6tk+Ke5FGrCVBPFMlkxGV5I8kLf7NtmjqhRgYpkVxq1Q
         bHyA==
X-Gm-Message-State: AOAM533nGoDNrJy+8XbU/ouH0Pe5DS8fGE5fY6dLCmQXH1NK8AZNWaw6
        kllTtz9iWtETG3+cnFej5Cg3xw==
X-Google-Smtp-Source: ABdhPJy5t2A4+AY2Nrbs0igfyIPIqHD/B2s0qHEu/4tph+STOnsnijZgD2k19LJq40c2A9zO55nT1g==
X-Received: by 2002:a17:90a:a78d:: with SMTP id f13mr1910588pjq.69.1601346495762;
        Mon, 28 Sep 2020 19:28:15 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id f19sm2757126pfj.25.2020.09.28.19.28.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 19:28:15 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6F2B356A-F952-4DC0-93DA-67D195029265@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4A1EEE90-E80B-47EC-9C4C-4744639CF168";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v4 2/4] jbd2, ext4, ocfs2: introduce/use journal
 callbacks j_submit|finish_inode_data_buffers()
Date:   Mon, 28 Sep 2020 20:28:13 -0600
In-Reply-To: <20200928194103.244692-3-mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
References: <20200928194103.244692-1-mfo@canonical.com>
 <20200928194103.244692-3-mfo@canonical.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4A1EEE90-E80B-47EC-9C4C-4744639CF168
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 28, 2020, at 1:41 PM, Mauricio Faria de Oliveira =
<mfo@canonical.com> wrote:
>=20
> Introduce journal callbacks to allow different behaviors
> for an inode in journal_submit|finish_inode_data_buffers().
>=20
> The existing users of the current behavior (ext4, ocfs2)
> are adapted to use the previously exported functions
> that implement the current behavior.
>=20
> Users are callers of jbd2_journal_inode_ranged_write|wait(),
> which adds the inode to the transaction's inode list with
> the JI_WRITE|WAIT_DATA flags. Only ext4 and ocfs2 in-tree.
>=20
> Both CONFIG_EXT4_FS and CONFIG_OCSFS2_FS select CONFIG_JBD2,
> which builds fs/jbd2/commit.c and journal.c that define and
> export the functions, so we can call directly in ext4/ocfs2.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas






--Apple-Mail=_4A1EEE90-E80B-47EC-9C4C-4744639CF168
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9ym70ACgkQcqXauRfM
H+AcOQ//TJff7PAnsaOC7GdGkA/isLtfy1R1XdCadVAronCnFnV2s/NTQbhjtSz2
gPpyXpS4stepDfTPsEt8nQpHD+rTe8KaAmAYtJBNz+ardS7k9BREz+0BNdRyp0Jz
IKHAoCCGCodGXqJjHyDU/TQ2c9/X2qiPjdg/fQj0Nc4THnKnbsGgru7Hf/zfcyo1
ra6VOdzbl/MKvfKUAutCUCpHd1ppnN7JIQfwm+UVAneS6MMw1OKqWh/zYGFqb8np
3a06k4+74q7YQuITggNiaCNLkbOMljvx13H4NygEcUu7JgZS3RiM68OG9fRPZYzL
j6awPJhkBFwEfx1MH58wWQiY6YewWIrYWnLJEwRVFxuNIeycypaEYNGkWIPVkJMu
LFvpYXsfF2FfY9TSYe/wdSeoxWjv+JxP9wjBBJzA3ZFwVUwHus01i4WaSAX1dQLv
WHDX1lOt+fAkB72LPFVkOtEskqUASnmaDv6L4FDfhXod+nNBQVmSGrCRINEjuJOB
N93YOaonqcnpF62y8loOm8Y365z4iTrZ9+RuQ7umJ4uS3YiF0YzUDEHl2KHsBNyr
5FEtvvOut66bLkYdgc12mvi0himtqOoRe8NuKrEf4WDOxfTURBewBD5kzbu5l945
IjYUEve2OZ4sJusdsfLLyoDj4fBfY47AXS+NNE9FX3W2Jgt8lsw=
=vDIQ
-----END PGP SIGNATURE-----

--Apple-Mail=_4A1EEE90-E80B-47EC-9C4C-4744639CF168--
