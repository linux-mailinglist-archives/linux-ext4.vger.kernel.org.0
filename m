Return-Path: <linux-ext4+bounces-14190-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APG2Ft/0oGk8oQQAu9opvQ
	(envelope-from <linux-ext4+bounces-14190-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 02:35:27 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEA81B189E
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 02:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F5B6305C28F
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 01:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13302284890;
	Fri, 27 Feb 2026 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rddm3gQ1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA726CE2C
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156093; cv=pass; b=nmu7eI3e6Ft6OcQqUnXmCvG9MdaLtQd+orAlUNGQWFIbRhyXh/IydcFTEyqJJU1jkjuTz5FxKsA/rn4QaE7d9qKSfhXbLkt5zAZkVl/AL+q7Dbm4yDobW17VYj+dPGuAlrYC5Mk+hKTlpf97YhNSfc8NCdxNx9H70v4kwP9NJ4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156093; c=relaxed/simple;
	bh=z+/M+lo5ksz1TRd449byu/D3ls0drNyd6IdGp40lVms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQShjAUv8n0YvAnjMdEzyYHkThPpF73MiRdi4Gq8I5Id2XhHp1vrhtA4sc1w7N1k8fLq0298pNffX2PYU1J343wcCXKNrYXhHNsYLUW3v1Vicfy6zyy9tD1tQZ6e79C2POT+tB8Lk2a6m7iT7npUkKee49kgIxvbFM9al6d1GSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rddm3gQ1; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65fe2d2b744so4662a12.1
        for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 17:34:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772156091; cv=none;
        d=google.com; s=arc-20240605;
        b=i0HiCVUOttKWLv7pcunmFW6WgKZHkroL9b1NX/3uJ5Grz0tY6dveUZZPR4prq5yl9F
         7UPdYjVv2xR1aywYP04sFFD714gtEQD5tTpmMF5pfVpiabtEcphHATKI+J6wmzVu5qUN
         7VNzq7SNODsBlsqC42HTRax/782FxxArFJ9JIfwPLK62A8CsotJ+SyVDOEYTOLiOIGmW
         CrV0iWoAMWboadPRUtP66DOdzFFV2C4sS2+Rka20QkFpjZLYQR5Yd42PS1ZxHtJyb38k
         FYYx16P91JUxECi7C4moiGXyVqOpGzfXVlYfqVnZE9/5mzPaINtgSAmIpJPg6x79EVxW
         Q1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Xe9R0FTdq/8KgfEwhSHbjVGMoqD5nAmJr57+aBN6PM=;
        fh=bfzrzjx9DLzURwyX43Vb4TwdkU4+rQMVZVoQHjLnh5s=;
        b=J2Ae2n82Lgu/NF0SfErKncst7cL+bdgK6jkeEUHpmfzdDcpa5qyinGbeKS0oYqCpfE
         OsHAEdNrJS2H1UFD2AVHiQCmeWeum0UlUuA76XubuKUUsoetQtlFW1NNiM0rUpHm/kB3
         VcxZRO6EfhXquNF1r3cMI8Le8LiGBquGaHy4hg9vkCAlekU0Rw4WT4LloI7cZ4O4iySZ
         IGgrfIwY9MssBW11iVcGmLIQ+Qx/I5UdW88jIMbDyuN4C7IutUPFf75+od2xdI9T6Uz4
         pu5Ki4FdwdLaAShc3XYTfX5paO3BL6BD1lSnaOrWlLkOZO/vs3PQUfZgK95RIAdX31Ho
         OliQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772156091; x=1772760891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Xe9R0FTdq/8KgfEwhSHbjVGMoqD5nAmJr57+aBN6PM=;
        b=rddm3gQ1poAClVezwlhFzOklnlG2jCOcA8fPH+hPp39nqDYzbC13+YaQ5knel9Nc4X
         9txnBTkpriryN3sCntMm14YJHjPutq9y4fdcbgrBcx8QOfsslKMJRmijVl4Qr0dLfNmX
         sZ/QORdUvMtqPpg8a/G/Ao4vAZ6lxE5RahFokvAfNkUQCX6j5jlPFrA43P0Cfod1RJkD
         M0Ud3vrqyldiAZKDKgQ2bToAoJrckOSlpN1PLMP131kbZ/zi1uiaPq18LBiIt36QsWIt
         30JJ8ovJkBBLtU1MCuG7CwqmlwVn4f7QXR9ix1yfdhJb+4sHBp246ezHLS7EBQ8rPioS
         qnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772156091; x=1772760891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Xe9R0FTdq/8KgfEwhSHbjVGMoqD5nAmJr57+aBN6PM=;
        b=icZC9rRBv8RoJaXUZ90QDi704+f82hXNVBBD5TJLaC7NHx6dXeZ5VLAQPVDU8x/7kV
         BICjhaZQGYEbvcOeGgzKKTq9GQrikx4WRb0t/zhMbiGlEtt9QQcx1aEjkl0Q2kAdthz+
         gB1HG0j7gP19ekYLnzqE04BYfloKCEhqYKX+RgNNc9EcJ6eeBNlrPYXDuEyS9wh6innR
         /vAN45/B0Zkfx7xFlYpk/eo68+etCqHRtXvboXt0bLB9t8cSQqHxJlD+WlYOepAAUTpa
         fdszDxYUOgnM4eSQcqz1f8ibPwrnF6GtQfGXTeTP1K1daebwDLQV9OI6Xp95PSFtRa4O
         W7cw==
X-Forwarded-Encrypted: i=1; AJvYcCWHOgV5fJNlw7EOjiPL4tGpJHqga95LhEHduarJXw3OebtRHo3pyP4DLQ2O5giW/VzhEEC/NOs5GP+8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxjb/ClrsoILo2YwIXPOUPAn8oJ9AAfzHQoCm0bk8EWbLGV26M
	+yX5O28XCR30EO97eluLJG5MHcB5Gr1JBlbJLxZ3W5iQGz9qjLKJnkA0pOTCIMY8+gxVKYRBpoD
	7meozTbTzWaA/UM4ObOFU5Mnm91vMhvJ3oYyp/GMg
X-Gm-Gg: ATEYQzz/VS/UVbLL29fNmU578VKhknk0Xl5NoETcIDZTedHGQJFxIIvLXyeOXyGm9tD
	OuVeeCWJpBG+SyGFU1L0/olM8StBFzOEpHUB/fOs5r3sp4XWMMxsXsZMbaUI4UYbSNkiaYfzomz
	Z6BM59h8uT0P2O7g2ozONYEMutoeoyk02Z13wE71+T1+pLvit04GBZHSyFY2vEmvgZaAUtHIPYB
	ezOMqT38cb2d8ICmquJsb7K5iki3ZPCJSjh/4kx8ExjEcRijd2DyBupP3JZwMypFXWoBvxWV4sV
	2GWdFcO6ri7mObm0NMuFPjKglYE+k5+RiGD5FA==
X-Received: by 2002:a05:6402:4619:10b0:65f:76c8:b92f with SMTP id
 4fb4d7f45d1cf-65fab2c4155mr103050a12.0.1772156090158; Thu, 26 Feb 2026
 17:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
 <20260225000531.3658802-1-robertpang@google.com> <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
 <CAJhEC05L7QEc9iY7gFZVK3SPYvFhtFyURss6xQgZ-qWwZZkFjA@mail.gmail.com> <8a45c55f-8abe-4cdf-be70-208550edf320@huaweicloud.com>
In-Reply-To: <8a45c55f-8abe-4cdf-be70-208550edf320@huaweicloud.com>
From: Robert Pang <robertpang@google.com>
Date: Thu, 26 Feb 2026 17:34:38 -0800
X-Gm-Features: AaiRm52oy9vcXDycCt3HX0a8oowZo0wXmgzHk3BLllBwVjMbefXMCEMxh3i5upc
Message-ID: <CAJhEC04Vpo96SKN7iRjV0fUKXEj3oQ698RdoVAdWjRjVLpgvGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] nvme: set max_hw_wzeroes_unmap_sectors if device
 supports DEAC bit
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Zhang Yi <yi.zhang@huawei.com>, bmarzins@redhat.com, brauner@kernel.org, 
	chaitanyak@nvidia.com, chengzhihao1@huawei.com, djwong@kernel.org, 
	dm-devel@lists.linux.dev, hch@lst.de, john.g.garry@oracle.com, 
	linux-block@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-xfs@vger.kernel.org, martin.petersen@oracle.com, 
	shinichiro.kawasaki@wdc.com, tytso@mit.edu, yangerkun@huawei.com, 
	yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14190-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robertpang@google.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,huaweicloud.com:email]
X-Rspamd-Queue-Id: AFEA81B189E
X-Rspamd-Action: no action

Dear Zhang Yi

On Thu, Feb 26, 2026 at 3:09=E2=80=AFAM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> On 2/26/2026 5:43 AM, Robert Pang wrote:
> > Dear Zhang Yi
> >
> > Thank you for your quick response. Please see my comments below:
> >
> > On Tue, Feb 24, 2026 at 6:32=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.=
com> wrote:
> >>
> >> Hi Robert!
> >>
> >> On 2/25/2026 8:05 AM, Robert Pang wrote:
> >>> Dear Zhang Yi,
> >>>
> >>> In reviewing your patch series implementing support for the
> >>> FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
> >>> max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 54=
5fb46e5bc6
> >>> "nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" =
[1]. This
> >>> appears to be intended for devices that support the Write Zeroes comm=
and
> >>> alongside the DEAC bit to indicate unmap capability.
> >>>
> >>> Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk al=
ready
> >>> identifies devices that deterministically return zeroes after a deall=
ocate
> >>> command [2]. This quirk currently enables Write Zeroes support via di=
scard in
> >>> existing implementations [3, 4].
> >>>
> >>> Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_=
ZEROES also
> >>> to enable unmap Write Zeroes for these devices, following the prior c=
ommit
> >>> 6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I =
have
> >>> included a proposed change to nvme_update_ns_info_block() below for y=
our
> >>> consideration.
> >>>
> >>
> >> Thank you for your point. Overall, this makes sense to me, but I have =
one
> >> question below.
> >>
> >>> Best regards
> >>> Robert Pang
> >>>
> >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>> index f5ebcaa2f859..9c7e2cabfab3 100644
> >>> --- a/drivers/nvme/host/core.c
> >>> +++ b/drivers/nvme/host/core.c
> >>> @@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvm=
e_ns *ns,
> >>>          * require that, it must be a no-op if reads from deallocated=
 data
> >>>          * do not return zeroes.
> >>>          */
> >>> -       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3)))=
 {
> >>> +       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3)) =
||
> >>> +           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> >>> +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
> >>                                 ^^^^^^^^^^^^^^^^^^
> >> Why do you want to add a check for NVME_CTRL_ONCS_DSM? In nvme_config_=
discard(),
> >> it appears that we prioritize ctrl->dmrsl, allowing discard to still b=
e
> >> supported even on some non-standard devices where NVME_CTRL_ONCS_DSM i=
s not set.
> >> In nvme_update_disk_info(), if the device only has NVME_QUIRK_DEALLOCA=
TE_ZEROES,
> >> we still populate lim->max_write_zeroes_sectors (which might be non-ze=
ro on
> >> devices that support NVME_CTRL_ONCS_WRITE_ZEROES). Right? So I'm not s=
ure if we
> >> only need to check for NVME_QUIRK_DEALLOCATE_ZEROES here.
> >>
> > The check for NVME_CTRL_ONCS_DSM is to follow the same check in [3]. Th=
ere, the
> > check was added by 58a0c875ce02 "nvme: don't apply NVME_QUIRK_DEALLOCAT=
E_ZEROES
> > when DSM is not supported" [6]. The idea is to limit
> > NVME_QUIRK_DEALLOCATE_ZEROES
> > to those devices that support DSM.
> >
>
> OK.
>
> >>>                 ns->head->features |=3D NVME_NS_DEAC;
> >>
> >> I think we should not set NVME_NS_DEAC for the quirks case.
> >>
> > Make sense. In that case, will it be more appropriate to set
> > max_hw_wzeroes_unmap_sectors in nvme_update_disk_info() where
> > NVME_QUIRK_DEALLOCATE_ZEROES is checked? I.e.
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f5ebcaa2f859..3f5dd3f867e9 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2120,9 +2120,10 @@ static bool nvme_update_disk_info(struct
> > nvme_ns *ns, struct nvme_id_ns *id,
> >         lim->io_min =3D phys_bs;
> >         lim->io_opt =3D io_opt;
> >         if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> > -           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
> > +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
> >                 lim->max_write_zeroes_sectors =3D UINT_MAX;
> > -       else
> > +               lim->max_hw_wzeroes_unmap_sectors =3D UINT_MAX;
> > +       } else
> >                 lim->max_write_zeroes_sectors =3D ns->ctrl->max_zeroes_=
sectors;
> >         return valid;
> >  }
> >
>
> Yeah, it looks good to me.

Thank you for your confirmation. I will follow up and submit the patch
to other maintainers for their review.

Best regards,
Robert

> Best regards,
> Yi.
>
> > Best regards
> > Robert
> >
> >> Cheers,
> >> Yi.
> >>
> >>>                 lim.max_hw_wzeroes_unmap_sectors =3D lim.max_write_ze=
roes_sectors;
> >>>         }
> >>>
> >>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D545fb46e5bc6
> >>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/nvme/host/nvme.h#n72
> >>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/nvme/host/core.c#n938
> >>> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/nvme/host/core.c#n2122
> >>> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D6e02318eaea5
> > [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D58a0c875ce02
>

