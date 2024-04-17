Return-Path: <linux-ext4+bounces-2137-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC988A8F1F
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 01:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C626E1C2169E
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 23:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377685260;
	Wed, 17 Apr 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="CCcnGTgp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF579C8
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395285; cv=none; b=f2gZjydi99OqAMKOUIaqKsktVRkew85klqGsRdobfbkf41mkmSi2pnghb89hRM03Bs5bvvo8iulZp9Ns+ydBA9qBNCr4Zftiua2EmRYwmJ31frUOZAgzfvnnGAUvH5KbWnq3YncGc4+loB60G/HBbQJJmJRyfyRaRkNz68n6qO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395285; c=relaxed/simple;
	bh=wUZQyL7nqJZuXE5gc3b4E0Mx0C68yZG08+BdHve+PhI=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=X3zf5LFW2pEG3V3/rRdxkIXYCnTyIBY0W+FbVI8fK8qyesxsFVhx9f5J7l3AgR1VwfPD+96SW6tetEOWKT+DmswK7qEtumcvW/0E5dfsBfRH4qDpj/tOyzkmAVFn7IF/ZjMCm9uR9FHXKivUddKyudrpchvV/OuY7lcp83DQ3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=CCcnGTgp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so327800b3a.0
        for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1713395282; x=1714000082; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQgqtXC/bsRVwmgDSzDPYq/39ZqALQA3WR90I1cIXtk=;
        b=CCcnGTgpqWFKCb2QNccyfsbCaVC2OQrG7vaLf2HlfbE77xKQzylGFLNx1zqOHe8pOG
         H89Otrdzv6Y9szttWMql2n/V2zwWKItNxxeEYcwL+KRsF2oeH8Co6XPTidIyL3p1cfI5
         gMS8r86qqU7SRx/fHBgltzkl/77IFsnvyimrtuoN2pc2dWNUYQMqLeoX/44xinHC6wiT
         c8GKOfUgxym9749s1qNxCIs7ZcvP6DZYFgLAjN9jJdA00B4j0Jh82vJbZJP9JSJZwIQr
         e38Q7Jg/H4K3C4Djgxf617QK3FcocXqNJpwrd7VoHTeXNetW7/hY5l5lRbvrW35zX8kS
         L1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713395282; x=1714000082;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQgqtXC/bsRVwmgDSzDPYq/39ZqALQA3WR90I1cIXtk=;
        b=aNCL4PGquUpZQ28Qb5cFUnifMS6jpRCcFmoPYB86YpI2mQwDFMhhygxqgeh8pMC2vI
         BFK6eONHeMiDUpAlg+KtQ8aCfYqlgKTCdvRavp3iK5PHrfnIOOi7QTRu/eyH0En6D3bV
         4MDiBSeWEVn4bwnUxbZiqb7WwtHNvZbwHGVgeFpuDBdfbeBkX6n+Z1OTLLOZzyWPRqxy
         EK7KywggX4Xupn8BIfHWuunzhxpbBahL9BUIOu4vkz3Qg4az+CRUPt34BLqOyz4TBaBq
         Sat8ohyVYf9ZH8mkOcJHy1QA/Fu/tbET/m1mx6i4Xl686k/fdOXNSaG/SwWraj9vtfzL
         AMVg==
X-Gm-Message-State: AOJu0Yz9GUMhDhMHWX/PAaHQ7gkydVJyz/lOeA5mwIzgzSjHwMXBAXdX
	dVNc2HtYJebbV9FtIQPxFv75u7kk10tPNDShcbNR2jqj3J/HqJD67o6BIctLxoiMHBcwgDKGyie
	O
X-Google-Smtp-Source: AGHT+IGmPONPM4X3emzKvehSWgslkwesaoOqFSRSsFJP8pgM0EwZ3Qax0C1n9uvuV9CWmWGGholu1g==
X-Received: by 2002:a05:6a00:2303:b0:6ea:950f:7d29 with SMTP id h3-20020a056a00230300b006ea950f7d29mr1209561pfh.20.1713395281918;
        Wed, 17 Apr 2024 16:08:01 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id i17-20020a056a00005100b006edcf5533cesm207426pfk.79.2024.04.17.16.08.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2024 16:08:01 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <DF4FF2DC-E1A1-4F65-9AED-DDDF177BA180@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DE71FC88-9358-4DD9-8FCB-DDC637D687ED";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsprogs: misc/mke2fs.8.in: Update default inode size
 description
Date: Wed, 17 Apr 2024 17:07:58 -0600
In-Reply-To: <E1rx4t4-00073d-1e@zenith>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
To: Pascal Hambourg <pascal@plouf.fr.eu.org>
References: <E1rx4t4-00073d-1e@zenith>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_DE71FC88-9358-4DD9-8FCB-DDC637D687ED
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Apr 17, 2024, at 5:48 AM, Pascal Hambourg <pascal@plouf.fr.eu.org> wrote:
> 
> Since a23b50cd ("mke2fs: warn about missing y2038 support when
> formatting fresh ext4 fs"), the default inode size is 256 bytes
> for all filesystems, including small and floppy, except for the
> Hurd since it currently only supports 128-byte inodes.
> 
> Signed-off-by: Pascal Hambourg <pascal@plouf.fr.eu.org>

Looks good.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> misc/mke2fs.8.in | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index 30f97bb5..8122e7f7 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -508,8 +508,8 @@ The default inode size is controlled by the
> file.  In the
> .B mke2fs.conf
> file shipped with e2fsprogs, the default inode size is 256 bytes for
> -most file systems, except for small file systems where the inode size
> -will be 128 bytes.
> +all file systems, except for the GNU Hurd since it only supports
> +128-byte inodes.
> .TP
> .B \-j
> Create the file system with an ext3 journal.  If the
> --
> 2.39.2


Cheers, Andreas






--Apple-Mail=_DE71FC88-9358-4DD9-8FCB-DDC637D687ED
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYgVk4ACgkQcqXauRfM
H+Dxkg/8C1JR5WkZRLc8Mfq5rY0ShxD3iAAgFr87Kc016+B19vn7d2jmAIj4zc3q
CsBEDniA3ylQHguYvsYjKGvMV/koPUqEPntYCNRjapxwOH9JTEkL5EabrkeJkhLf
eAf59VW4p9vBsO+Xzcn+PkMTBtsT63oLk6ClheWDEqL40z3wLbi/GLTYBx6+KVJq
TqvXmyBK6MPLE9pojaAui5F31XqkdWcddlpVpBv1zupFqiPi+uFzkMkKaCuHTY/3
G8kQ35gOXc08etIk33IKk5g6yP9KvktoBI4SBBwnKp280bA+zR+LggHvGSU/31hp
MEvdAO7+ZjdklGFknkB0YBIQqX1+nDR1uubw/YHTbLjLEmlTZzP0X9mW9geuSKnp
Hqlq0REsGntd3KDll7+5lUonUzgQ/dPKxiqM37D2os9xZBAEJ5QFvOsA8uE15x9u
Dy1IzutNO4Y1B45Kag3fNhOHHgi2nXCP6W9oNyRT0Cu37lHjCpS9D5P4b32J7bjC
v0CwU7ZzUgIYBxxsuRgn2GERK3vLfqIaQqiboSEzc3oRCCoC6KcVGbTg9N7jbSnt
AHEg8unTFXBzgEWZhhJLobd5AJcMPnXMeBSKiJhG2Zkza+ZvMETqjg7DF5l5GEx6
4xEhpGaTcppK4rkIcFsT0+fCB+6gkD73QKaV/0N8TDWl2ZZ7W04=
=rGH6
-----END PGP SIGNATURE-----

--Apple-Mail=_DE71FC88-9358-4DD9-8FCB-DDC637D687ED--

