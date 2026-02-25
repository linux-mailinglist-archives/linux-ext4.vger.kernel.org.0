Return-Path: <linux-ext4+bounces-14012-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNLCJiNun2m/bwQAu9opvQ
	(envelope-from <linux-ext4+bounces-14012-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 22:48:19 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE119E01D
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 22:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 564B430790A8
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A7A318EDE;
	Wed, 25 Feb 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcXnIIPe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF301316918
	for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055827; cv=pass; b=Cyv39NhRfmkO8lwiCy0G2+a97oHz+40gCRexttYbV+6vD6SHHgNAyoE5khbzOesHqFJKOWaqt8Zv+lP0pBoR9TuvduUvqiHugbLs+d2Mjwc6dRDOw8IBTSfxyQvV0KCGrfQRir2yjwFUD44LBysr/ioyIcFL2TrA2L+2yXbAd+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055827; c=relaxed/simple;
	bh=hoZBQczrzcuyVPOXD+tTAmFlTYabJ94zI9Irylb/EVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzYEoO44ES5QHptp3n1+RiPkPS7wibScBeo6QHC6iZkKMDbiW9+UADHQFCq7wuuBjtWMMMmaxuY9Aqi6H0y0aHN3HsbXVi3owCA2ulZSPncdyR5xA4Jia/PdMA7TK9pErWNwJ6anCUG/Tri49n12ehW6ZNeQRDEw0ApTlUDJWCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DcXnIIPe; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65f3a35ff13so3608a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 13:43:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772055824; cv=none;
        d=google.com; s=arc-20240605;
        b=VHC+IcdZ2eg0AvPilKSHYy3BczyNlpFCmMFtYeelzZf4I6ZcEMfci03PqRvg8fwgXB
         rKMMPGaikNE2A/pe4ZiN57dd19zIajtbbGoFt7i8H//C0ry3ylYeTko4U4dlGMVR2GXk
         9rRWovQ45l08ysDcPZN3bNx5xev/tAZ9AMjPrsq71kuYKINuFjf8VXVQs81H5x2eu5Oh
         dXh8p+2a3NY5LhvbggAdQeN4h3e/4PHQ7Wnnlkwn8ochyqevWMvbzoHX6f6YaODfqrsY
         S8tWQOa8hYNqfQA0TNSr86ZdVzdAbOiDccGH9qLa+n78vuieLVcyfLaMy/Lc4OgfjhYI
         rxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        fh=54y2aoEqJvnzETXkgZwaln0xxGFVT8hK666Ewx9Ymmo=;
        b=Xz+C5t1yz/G6/V/6+zLsKj7sHzHVRubGaCbmBxnB0G5MHmv++h05upiWA4ngf5srDG
         o6/DPS8IdSsJDrJem9Ye4Xs61GOeqb9Ac40MwMsg9kDch+8BVif5RkdXVhKmia6I0lGB
         wH0WBLhU7t1qrW3gk9L/MU6S/izm7Mu19MY1p0ETKHp1eDU7AXX1uRDOA8QSwuCnlYdu
         zZthwVSb6EMgWxj3imW9eU31WUOWbR0ZJyedjXUCQWmh53T6WbzE49Y5UAuKFsi80lNA
         nF4fTP2r4bY9EAqyJKS8PxVI010ZbssHrdlXpm0okpD6tLf/J4Ei4gTZ++eHsp/EjmvU
         FUZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772055824; x=1772660624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        b=DcXnIIPehOR7Zcc84tU5ax/4/X+fJQQXdh6G/qeIGgAwD6QNLuPBvyozFNu04p1olg
         g2ioHyEBoajIsPgNamu8pOCASAUioThGOznYmtfFxA2PNCUI/goNDca2bs4YaC57UiMX
         hrNrJLYnxtIrwCeUCMpB65/mfvXVpuwHhNmB8r2rpeEZVUk9JmP1VTBaWsG8jXrjKXwl
         UiqonoSGe9mduDMaJoz8Kgszdb+iCjKBceJQZRl2elaXYdryJsUcOdQPBv+X7m1a9tcz
         uA3wykguwgIff37UR05C2cadCAQdbVnrzA/akWYG16NJ0Q72rMQDl7LjJp/0lKeJMubA
         Zb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772055824; x=1772660624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        b=nDQdYODdWJtPZi8Y53gZGuWPdj0xKkJHk4EBIdduoMCV8MlrvC2tIjOF6VWIVlKOcA
         9uQZFYYcO2njGflG0b2eNKrJDw5qM2V+oP0BDVIAgGeaETysaeKfHY0dzUgQnXv+/fdD
         LXwLIAcJ46I0U/KxHBOAOHAqGy9VAaXSkS/NvR5igW2D48fkM6kb21EOblTDYGmX26qd
         H4BAbv4uVJynrRQLaM27RJE4ZBULrevC5QtdRw1WLcEUAQ9VYpSplCHW4y5ouA0d/3z2
         UvS/um0qSftYsWSG21SFRKw5+ORwnzXrqbe/ppZfJst/hY0X3EEa5pREKfl4P2B4ALlD
         vm3w==
X-Forwarded-Encrypted: i=1; AJvYcCWAd6eb5urHeTZwMWWeOm37sEQa+lQDH6WHyYIA+WK7LGy5lwkTYmC8vmKhJpmCuQi+WHhpujcpdGCx@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCsnBUe6uinxSKg0pLEXnTRpT/heLiYiq67nXXqqzqanjsBZO
	Bk1GIzsLNH1zXbkz9DQ4zOboVVXpeEYM5MigMWWtcQeHX8up64ZVyjUHx4YIAMKQEP/gABZUcrm
	yu7K3+q5qkwhYJeuchSi+ZbYgphanDFAvw4ttm1wW
X-Gm-Gg: ATEYQzzmqr9mOSWSPeIcepFNPjFR3u49iOhdoBUKr8PcVwUIEKrCe+F7Mg9cC8AZfOl
	jxObjwZ6GD8KuF2BjvbcnRlukX30FIRQI2sByyLVcfGUqNmV962rxoGu4MsjwdsymGJieZPv1b6
	7TH1WgdbjsgZLgGcLxGM4sb65DZlaDMQlIft/RV59/5tf+Czg5Qqe/pi8UtOupdw7QXx1Gtohmv
	QlMWyZQ/IPzksNBdVv30Ua7LZ/3wF76fPAa1do8kkooqpgAo3AoyGCennwGZtQsfsZNZjCG4oRf
	PU7vdSCcK+AAJ9PwGb5rIL0Y9M+2FTzFbt9Sbg==
X-Received: by 2002:aa7:c7cf:0:b0:658:e7a:6fa7 with SMTP id
 4fb4d7f45d1cf-65fab61a7b0mr11377a12.4.1772055823405; Wed, 25 Feb 2026
 13:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
 <20260225000531.3658802-1-robertpang@google.com> <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
In-Reply-To: <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
From: Robert Pang <robertpang@google.com>
Date: Wed, 25 Feb 2026 13:43:31 -0800
X-Gm-Features: AaiRm53fO14_kYBnlB-QimzynwfGzteAR7wRZiT1Sf0awQgFveGcUyR_Z7IWsCY
Message-ID: <CAJhEC05L7QEc9iY7gFZVK3SPYvFhtFyURss6xQgZ-qWwZZkFjA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-14012-lists,linux-ext4=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CFE119E01D
X-Rspamd-Action: no action

Dear Zhang Yi

Thank you for your quick response. Please see my comments below:

On Tue, Feb 24, 2026 at 6:32=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> Hi Robert!
>
> On 2/25/2026 8:05 AM, Robert Pang wrote:
> > Dear Zhang Yi,
> >
> > In reviewing your patch series implementing support for the
> > FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
> > max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 545f=
b46e5bc6
> > "nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" [1=
]. This
> > appears to be intended for devices that support the Write Zeroes comman=
d
> > alongside the DEAC bit to indicate unmap capability.
> >
> > Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk alre=
ady
> > identifies devices that deterministically return zeroes after a dealloc=
ate
> > command [2]. This quirk currently enables Write Zeroes support via disc=
ard in
> > existing implementations [3, 4].
> >
> > Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_ZE=
ROES also
> > to enable unmap Write Zeroes for these devices, following the prior com=
mit
> > 6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I ha=
ve
> > included a proposed change to nvme_update_ns_info_block() below for you=
r
> > consideration.
> >
>
> Thank you for your point. Overall, this makes sense to me, but I have one
> question below.
>
> > Best regards
> > Robert Pang
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f5ebcaa2f859..9c7e2cabfab3 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvme_=
ns *ns,
> >          * require that, it must be a no-op if reads from deallocated d=
ata
> >          * do not return zeroes.
> >          */
> > -       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3))) {
> > +       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3)) ||
> > +           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> > +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
>                                 ^^^^^^^^^^^^^^^^^^
> Why do you want to add a check for NVME_CTRL_ONCS_DSM? In nvme_config_dis=
card(),
> it appears that we prioritize ctrl->dmrsl, allowing discard to still be
> supported even on some non-standard devices where NVME_CTRL_ONCS_DSM is n=
ot set.
> In nvme_update_disk_info(), if the device only has NVME_QUIRK_DEALLOCATE_=
ZEROES,
> we still populate lim->max_write_zeroes_sectors (which might be non-zero =
on
> devices that support NVME_CTRL_ONCS_WRITE_ZEROES). Right? So I'm not sure=
 if we
> only need to check for NVME_QUIRK_DEALLOCATE_ZEROES here.
>
The check for NVME_CTRL_ONCS_DSM is to follow the same check in [3]. There,=
 the
check was added by 58a0c875ce02 "nvme: don't apply NVME_QUIRK_DEALLOCATE_ZE=
ROES
when DSM is not supported" [6]. The idea is to limit
NVME_QUIRK_DEALLOCATE_ZEROES
to those devices that support DSM.

> >                 ns->head->features |=3D NVME_NS_DEAC;
>
> I think we should not set NVME_NS_DEAC for the quirks case.
>
Make sense. In that case, will it be more appropriate to set
max_hw_wzeroes_unmap_sectors in nvme_update_disk_info() where
NVME_QUIRK_DEALLOCATE_ZEROES is checked? I.e.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5ebcaa2f859..3f5dd3f867e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2120,9 +2120,10 @@ static bool nvme_update_disk_info(struct
nvme_ns *ns, struct nvme_id_ns *id,
        lim->io_min =3D phys_bs;
        lim->io_opt =3D io_opt;
        if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
-           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
+           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
                lim->max_write_zeroes_sectors =3D UINT_MAX;
-       else
+               lim->max_hw_wzeroes_unmap_sectors =3D UINT_MAX;
+       } else
                lim->max_write_zeroes_sectors =3D ns->ctrl->max_zeroes_sect=
ors;
        return valid;
 }

Best regards
Robert

> Cheers,
> Yi.
>
> >                 lim.max_hw_wzeroes_unmap_sectors =3D lim.max_write_zero=
es_sectors;
> >         }
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D545fb46e5bc6
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/nvme.h#n72
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/core.c#n938
> > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/core.c#n2122
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6e02318eaea5
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D58a0c875ce02

