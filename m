Return-Path: <linux-ext4+bounces-13284-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NWfM0Ltc2nfzgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13284-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 22:50:58 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8977AF95
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 22:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BB173004F3A
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 21:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5618521323C;
	Fri, 23 Jan 2026 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeivFwvd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44072631
	for <linux-ext4@vger.kernel.org>; Fri, 23 Jan 2026 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769205055; cv=pass; b=l69V7dE7aqzK/dTf+wDnLSjXZLwV94Of8E+Co+8UpUpkvevfgiGp7XUpmpS1ZpGpn7OK31D3hSCs3nIYQA8KXDjjOY8rgfWu6oKmIMIX6BMHaZw3f1U2y7DHGEVrq8Er7u2Ps4OB9+BQxIEeSa5IFH5mnpCE5PVrLzQAJnYNG8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769205055; c=relaxed/simple;
	bh=6IXzu5urvUpIOvNTmg0w02E+jJ0ffDlI4ifqyZP7KSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6kjXzpvkW8JvckVTAokUtX/qAj2XOVU+90/hiABzXCe+gkUAgEOQgGDF26yGLzD1MbYTlsl11hsBki9Pm62xftJgkydXAHy+W8hwt7OqJsuQAZNuY7wMQw3b0vf4KrppDNeGck2Z1SKJwR5a+S4n4UC0RQk/qR2VNkAg0m0YTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeivFwvd; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5014e8b1615so30870721cf.3
        for <linux-ext4@vger.kernel.org>; Fri, 23 Jan 2026 13:50:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769205053; cv=none;
        d=google.com; s=arc-20240605;
        b=X3RjBsxJNIePYZNCs+2Cg2gAmqt6zz15TWo+/T/I63rSMHZUVdbwVR0WJg/QGZaruy
         Pi4LcApCUrtgBEhkb0n8XI/a0DblknL7e9ZWzCPdxo1HpJ62FhULwkgeM9MyoI7oKAOB
         HFVitkxrpOp4UwDtaDo9uKJS93sy7v1BLELRVT2da1dCJnhvysvzHaEgn1ldXBOtT7iW
         YW/jDGHLXVWEklHchyssQjHztKOL/Tj24lKmumWH0R2w9cjMK6RBP+yXjCUv1PoWS2XD
         QUOUY9gy64JJxl+7NicMF5oqLDvJIF26MQORtv4eSxwSyvG3dMywkPvERHPOEWUDdWxV
         0dIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3RsJnPZvrF//Bx+/Oni1yeILddUVVYgZUnr0pj0hvM=;
        fh=VkAu4Ql0L6Z1H6M2RcKxjQ+SxERI9f8Yl5kGnuZZmf4=;
        b=HtgTEc6Vg48F5DT077yCkbXTbPVYw/LDQ+gFg6M8cEAvjhYtkpXnIaCnOc9ZHTCYON
         Dt3SrpTjH7jxcWyk1ywbiSuIUMGtDEvhd7rSk0uHp9G1AzAjWEWh+nqQdINcRl9MEbuz
         ph9JX87BlFvSazC4cQA6nAfkTd95VQFOVHDztwbtNb4xhg6KgGJ89x5e77t5UVm+NAyJ
         ilNq+5J3cd9mwRn3DLLmJdLHZ0QLSWMyKfpwv4FDNRGtZ3fKp9gbLtvC87uvWIAhxTfZ
         A6R5hx8q3WrQLM3iKUUQ+Ga9P+7PGfm1M4MclHC1SK9W9T0nvG2kg2Fw9KBmHX6bmobH
         YTgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769205053; x=1769809853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3RsJnPZvrF//Bx+/Oni1yeILddUVVYgZUnr0pj0hvM=;
        b=GeivFwvdR1iy1xBwOhVxI5ankoPxaRHi/ers7RP5h7Wf+YKTA5HEUNLaOW1RnsjmEf
         43Fc7ejW5dzZWy4ir4KudAhUyXwHFHD9EP0+sKH120WYkxkzN4ksEKkS3pA84zZYhoFf
         F/QKBtbZrZsby544iDycPEtKXN6vYveh6ne469CJT8UaHF1BIjhMkX4o/p1fggxkU7K1
         BpwnFUHTdZfIhhFse/8ZNbTjltrqJkPbKL19yzrQJmKQ6a8H0btzqNsmbT+fhNXxNhEf
         veCXb8637DiAKLRWrqnJG9lAcRRCid3CuaIBe577RQMksbmwYR9+2MOKkuf9rTs/naut
         Aw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769205053; x=1769809853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r3RsJnPZvrF//Bx+/Oni1yeILddUVVYgZUnr0pj0hvM=;
        b=aa7t56/QH9Pk5PU2Rc6/LJekwEZ1dbK4ROWfHdvTP6grTpcgIrDcZiiRGGoNxEKVDQ
         2Mjji0RcJiW4lQNK62GJgflL6qIUpWd9Sz2B6K9MaRl9RBRQ0izE+C8sET5KaMDcN72j
         ZTVIWSTzJc/1JI60+jv8ky8Y9h1vxl7bkpuSM0QUraid9UfAjLuUT6w8Nc7Ks/bUqWfz
         42S3cMidYO6bUuVK7rH4EX6jaxF9sdA0oBALnMH8sUtEqpk3kR9FQ96AdbAUzvsOqcAY
         XQlY5KVCrrWYRsF5YevztwBW8XGKUF3iPw39f4rIWPOBXcJIMU973JUROtPKbOjrPdof
         pWnw==
X-Forwarded-Encrypted: i=1; AJvYcCVhRS5Zm2bUyFJF+gKOyqGB9Oa0ljD1IohidPv7BV043y7sKEIWLOZFUZ92A+agC2h/K4ZLAbm//C7V@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26XwdJLBsQ1Xy6in+q+/VHYUz4ktkpnTaPr1Be+DecptdD2EP
	FVIQa7nxB70pdqo4hRwHjXm/1bzNkmwDyA8l5kZwY4RWjXHjRR8MiV+bxAetsjianEPO0cxVDtA
	l8/0yoNSUmtcKY+OVfT/gmifZAJZy+jk=
X-Gm-Gg: AZuq6aKyO5DSOePpVPOoogjGM3lIlJJXubSdQet1IQb2ux+kRvmFucJhmP8mghZ0vP/
	dqca1nUVWh8ZvYcGN+83s94Y/S6PK2+ypvw/h0oQtmI1Neee5RELdqBBMOF91oM/de03SDPCJVx
	M8ZJp2h+bJ8TKl3Xj5hs5liLM5sULfhjvX8Mg3I7u1QjsMSV9ZP8uFtwlXqFOh3JkLYB9GSTfKr
	LtY6p9MU4ItzaHaWJLOmAAE/BICf1Q2Fca+KJZVgvEH6SS5ouNP57nTX/8WYl/C+odBAw==
X-Received: by 2002:ac8:7c55:0:b0:4f1:ab79:fb18 with SMTP id
 d75a77b69052e-502f7747aa4mr55300201cf.25.1769205052741; Fri, 23 Jan 2026
 13:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810700.1424854.5753715202341698632.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810700.1424854.5753715202341698632.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 23 Jan 2026 13:50:41 -0800
X-Gm-Features: AZwV_QiX4hOk_3lPAHP4zgVxbMS4JU0Q0fRA5UCPS5O3nWxaluH3IssYOZyADgE
Message-ID: <CAJnrk1bymmhei7X15980THz8gnQCgm2ik2nLBOWkZ3NF5MXNXA@mail.gmail.com>
Subject: Re: [PATCH 16/31] fuse: implement large folios for iomap pagecache files
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13284-lists,linux-ext4=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D8977AF95
X-Rspamd-Action: no action

On Tue, Oct 28, 2025 at 5:49=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Use large folios when we're using iomap.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file_iomap.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
>
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> index 897a07f197c797..0bae356045638b 100644
> --- a/fs/fuse/file_iomap.c
> +++ b/fs/fuse/file_iomap.c
> @@ -1380,12 +1380,18 @@ static const struct address_space_operations fuse=
_iomap_aops =3D {
>  static inline void fuse_inode_set_iomap(struct inode *inode)
>  {
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       unsigned int min_order =3D 0;
>
>         inode->i_data.a_ops =3D &fuse_iomap_aops;
>
>         INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
>         INIT_LIST_HEAD(&fi->ioend_list);
>         spin_lock_init(&fi->ioend_lock);
> +
> +       if (inode->i_blkbits > PAGE_SHIFT)
> +               min_order =3D inode->i_blkbits - PAGE_SHIFT;
> +
> +       mapping_set_folio_min_order(inode->i_mapping, min_order);
>         set_bit(FUSE_I_IOMAP, &fi->state);
>  }
>
>

