Return-Path: <linux-ext4+bounces-12154-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D5CA39FD
	for <lists+linux-ext4@lfdr.de>; Thu, 04 Dec 2025 13:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B92F303280B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Dec 2025 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D42338590;
	Thu,  4 Dec 2025 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/cs7GO/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C533F386
	for <linux-ext4@vger.kernel.org>; Thu,  4 Dec 2025 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764851714; cv=none; b=YloHPguOaVZhy/22A3EKotW5AK29ju8D1ZwK2k2Wy4VcPo1xeb0yEoASoE4K+yAtXDauohnMuY5RpWEtacSB+5Xskc7rLD3psMGd6rDceM7ChAuiMJ/rTZfpnmduwRD/PIM+klV9dg9+4aitmJ6Zy5mJG5h5N/NobJMRvPLSisA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764851714; c=relaxed/simple;
	bh=giuujw4wWMYFZ/L9uYZJHqcifqomR2Z2F8dz07NJerk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPBESp+bBFOzc8KbVDqp+UIOujhUv8+vDlE0Lle64sqxjjCOBUUwA1KzuGrKfzCu+cfHFlF/eCKAo3vEImErcd/cxacTsht4ujQDqezXNkY3gM43UAXWP11lKDN+D8MVHhCb+5J2yWBKVe0DQJ2cIQnMnzshuwspB5TToWZqSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/cs7GO/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so610445f8f.0
        for <linux-ext4@vger.kernel.org>; Thu, 04 Dec 2025 04:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764851710; x=1765456510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rTyTaZGfT5ilY6rp9NwT1cgeVzIfAo+7DLel/usj2k=;
        b=e/cs7GO/DTMkPrE8bLqKn4uoCqSF1rL/RBTXDU5V+l7+W+KJFIfC3l92z2z1Rj6AnZ
         ECZ7Qlu6h8V1Imgi9nXj8WU/PoWR5MjXkUz1YIYue8N/QrORQe92dfkSKKmKPDge8GtM
         zHsTni0gYAgppC9BpOxrXYVDesbjLyNOW3HKKjvV7f51cvinxW+UnXRMTgFAYtbI+qMK
         ZpiG93G9qV46kwwZIP8DZtFwEKgQR3p8237Z/huMdXeqM4BgCvWfYrBJFTaLMCuT1ihG
         MCrs9+IjLWWye5sg9edVO/MqlAXUjwvzTtC56wUDN9FQpzv2Db58W1LK1raqqPytxCJF
         MYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764851710; x=1765456510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+rTyTaZGfT5ilY6rp9NwT1cgeVzIfAo+7DLel/usj2k=;
        b=gf/Ft78LH4YQnpshIUsyByvrbglQkcegNjWRHx/KKmexHTZPSx+yITF6rg+4B0Ewer
         kfuyDw/+gSni2+mf7fK/jQNB3mHIJ0cnO17+Fm5ViGDVmhabqGJsXp+O5IpCbOb3zvfe
         JopOS8MHLI2bKgjUwO/YAloOGostt/LjA2G4m50eSZdBGE5/xywxak01gQVFhffTMgb5
         eQG37/ddBfOQ1WwqZXk26iA6EMQva4wUMuD9A4Wqurai+kH8cZKG3hLWBE5gEdgTh8lP
         EOuBQMIAvwzQNLe9EqOnvk8f7eVEqcs8khjsm+qku14WgX0Ii5n9TrHrk5vlSGuCrY+h
         O1cA==
X-Forwarded-Encrypted: i=1; AJvYcCUB/gTjuHjoSEx7MaGYAyNi0m7wyl9FQuPAcjAK00CswAwVqBIZ0BVpuNVFSB1hJu57+PXNcWYgmu1M@vger.kernel.org
X-Gm-Message-State: AOJu0YwxfnvdhT2Ig/SR5C2NuaL0jIv8J2XK+PyO22+T2owwe0TSdY4r
	XuNVMXnR2xORRKY+YdGpsWhJtIDVIasUihRVoD+3Gzyaqmcsl7xZpMdlQIVATA==
X-Gm-Gg: ASbGncsMe07jyyoxNt3bz3ejAmoEJrGwUtY3Xm7+EHjq9+8v2iqjdPN3QAzYV7etvlP
	jXktAlZOO5XSo/rks47ttA3A+8QVFH4IuKGZC+9dtMv13/+ORQjNVwNZ8KWcfrsfI8/kzM88CgI
	0y0BVLYyUMnu08RcidhxewXV2LhISU/7xdng+UMZrDnmrMn17pbYoJF03sIbBimAYAbzN2aTDiM
	tFDuIFIs6UgIOtZXyLxZ/z3+ZSVmgJZD91iI61j5zatgaT2RVo/CQzbA0GniFofzR9Jz3BYQCCB
	UnPVrodqtfie3r2FuN9hB8yaowZ2P87TxOWFDKxK98DuSgb8FzG57cndIM5KpTh2EmDCuZ9Z4xP
	rZQZXi6x6gBE88xtjbbvaUIkvfM43VI/XTqKipOgGXinqvwse0RxPxiik4ZAYlWlJ8yfJ+FuaLQ
	pZZzFBBLVnMbiF6yjiYUMg371dmbHDXVLDVSFZywMzb/0LjiViKybnIP6llN7I93E=
X-Google-Smtp-Source: AGHT+IFZz2nOAObl8bUScuFmASw62b5fUYYMyCWjTcl+7miVCAVGtUBlGJQB7wCxtgJ5k5wOHJl3Zg==
X-Received: by 2002:a5d:5d01:0:b0:429:c851:69ab with SMTP id ffacd0b85a97d-42f7985d653mr2308940f8f.55.1764851709860;
        Thu, 04 Dec 2025 04:35:09 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353c9esm2839400f8f.40.2025.12.04.04.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 04:35:09 -0800 (PST)
Date: Thu, 4 Dec 2025 12:35:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, "Darrick J. Wong"
 <djwong@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix ext4_tune_sb_params padding
Message-ID: <20251204123507.2e6091a9@pumpkin>
In-Reply-To: <20251204101914.1037148-1-arnd@kernel.org>
References: <20251204101914.1037148-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Dec 2025 11:19:10 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The padding at the end of struct ext4_tune_sb_params is architecture
> specific and in particular is different between x86-32 and x86-64,
> since the __u64 member only enforces struct alignment on the latter.

Is it worth adding a compile-time check for the size somewhere?
Since the intention seems to be that any extensions will use the padding.

	David

> 
> This shows up as a new warning when test-building the headers with
> -Wpadded:
> 
> include/linux/ext4.h:144:1: error: padding struct size to alignment boundary with 4 bytes [-Werror=padded]
> 
> All members inside the structure are naturally aligned, so the only
> difference here is the amount of padding at the end. Make the padding
> explicit, to have a consistent sizeof(struct ext4_tune_sb_params) of
> 232 on all architectures and avoid adding compat ioctl handling for
> EXT4_IOC_GET_TUNE_SB_PARAM/EXT4_IOC_SET_TUNE_SB_PARAM.
> 
> This is an ABI break on x86-32 but hopefully this can go into 6.18.y early
> enough as a fixup so no actual users will be affected.  Alternatively, the
> kernel could handle the ioctl commands for both sizes (232 and 228 bytes)
> on all architectures.
> 
> Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/uapi/linux/ext4.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
> index 411dcc1e4a35..9c683991c32f 100644
> --- a/include/uapi/linux/ext4.h
> +++ b/include/uapi/linux/ext4.h
> @@ -139,7 +139,7 @@ struct ext4_tune_sb_params {
>  	__u32 clear_feature_incompat_mask;
>  	__u32 clear_feature_ro_compat_mask;
>  	__u8  mount_opts[64];
> -	__u8  pad[64];
> +	__u8  pad[68];
>  };
>  
>  #define EXT4_TUNE_FL_ERRORS_BEHAVIOR	0x00000001


