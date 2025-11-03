Return-Path: <linux-ext4+bounces-11423-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3EAC2DB10
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 19:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 645D94F0E50
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82A4199949;
	Mon,  3 Nov 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7PnUwF1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79D33EC
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194674; cv=none; b=W+zmpCHkM2MJMrKBIUc2ZzhRUOx4YE2/XIb6/w2LKpHQtMGTLLyh1rfdVVvaVVjm5ftcHYSO0W0K3Otu73H7JMFrA2XT/jcGMKVI4TUK+LNXmwYhwou96+PGOqayQkwNN/rDCkyBUt5BrXqSLFZNM+q68DN93vjoRsBd8W186KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194674; c=relaxed/simple;
	bh=OPGO/1H2iTCRxm8R4jukSNwSpZk/lyTqRp/oYOMPAJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thbf+zNFWlyZ54LIf6rny3bDVAzHdJVOdfxpEj1kotDcE0c6qdv2MzVyDttm7Dn6K+dPlwMAYUmZhxlXSrTbrAb5XKmYhAWCGgDAVcHz8WpMYWyD7jI8JU5s5NJW0YCiZ1D64m2L1pi5bzpM9g1yVNosLpxqjAngtSj6h7NlU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7PnUwF1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eba0adfa04so63134001cf.3
        for <linux-ext4@vger.kernel.org>; Mon, 03 Nov 2025 10:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762194672; x=1762799472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lD7dMGvmXzUrTEuHDHSXB72jBP0Wp8AnuqrzmdlwiGE=;
        b=M7PnUwF1TAon+b0fbeZUBMw2FQMLP9rMt0mePBQs3UE0Ksg/bErEaf2DQr0THalR0C
         l5nvNpjfFot4T2PLnFHA6WK0IlN23CUq9gMXMdHRX/3ffkeiSe5ZgDMsHQUoX7V9YrvX
         uED+U8k6XwfzvIMLtmALuDD0Nkhtvdd2/l6OSI74sWpuRxtRpMk+sl80JF+TqS1QUH6W
         7wYymRVDGRACNIwo5COvtINSQvuAeFSQDJjwOVEIZzR/G9SFGooWy0BNMpHj2CsE/VKv
         7y9HYCcIFGdslePHAItU4UP3jJNRB/MaJxtuVJfKMHvcBZdOj9LJjVVKNeMvXkKO0pKz
         yg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194672; x=1762799472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD7dMGvmXzUrTEuHDHSXB72jBP0Wp8AnuqrzmdlwiGE=;
        b=X7Vm9pzgk2NBx8oCfTbXx/sX+KXMMeLW4QSWcrK8EUn5AGEnoSHD/+F7/Ju1dEgmL4
         F0B3PRNay0jbyX0kiyl7d/jwlHpXHZioN3/nFPKejQUXXt3Vpm1Bj2Fl/avpvBcVEFFH
         xRym+XcwqbLSdrjw6J6WcnAQTpqWJ0ARfvjU+6KhkZZWANYQn3aqf4vbiOoKOAgWGPhN
         YYsaSZ/dNZR28rojWdpbL77SJeKwEpcfjibpu4PZHjBz49ORvad43b5vnoXC41OA8tBG
         o3fnhDeEMxVgciqf/oxVhdyGNfdtWAWuOMo99/Vn8CsOvkMgKocJ1MzUmWXoVRp+KMtS
         x4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVBAXCvmmrrBgVk9khTRS2+vjro19DCo3Ou80lBSBFeU3JYZbevlYXgoOTJsMDlg5eESxxB4g1Dx/w4@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFh3AH3TRiy+RD0IbiqPhAnm+DI5yklB9hDeyqal9g54A3iMb
	IafGJwXOTPYjJICYgCdLlzSFDztbtlowyd17uzYe905D99FTKBBlTGhMGj3TnTnAXvkrjBeTHYx
	Cj2/hBx3ro+KzJqBPVi64oHlnj2XLJsY=
X-Gm-Gg: ASbGncsVTOzBtxXoSaz6lkwGxs/h82DVm2fxdp1YOaaQg+RTmEj0vx/YTOCFJCngL3R
	a6cdzMUzpzWnmm168+IPws0x6q9QkPf0XDMyAusNrfA0y+P8zNBisd7FlyEva7UJTMl/7V1t3aO
	+Si2G2DCLbEIQ1wGrT1b/zCprLEgy2N4qx3w/mL8eq82Vs9BTA3hXVi8vQ7TfTPkv9RhaGBAfcd
	HDUQ6G7+/7bBgEIWavJNBtnjziQugw6jjEOTEbBqcW1Lv2/fLtbMVc0ujPSM5Jog9HqAfQO/CPB
	w97whCBlaw3p0+bqQSOI0hl37JO+Hsxm
X-Google-Smtp-Source: AGHT+IEzEPHitXAFzxg9rQGY+E1yohbGccQhoZwxFWa0WKOj4yZLegW+WUEK9FGonURs5Mbl+6EzEe/cT7RjDPsX3cE=
X-Received: by 2002:ac8:5f91:0:b0:4e8:a97a:475 with SMTP id
 d75a77b69052e-4ed310aee0cmr190519601cf.79.1762194671771; Mon, 03 Nov 2025
 10:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs> <176169809317.1424347.1031452366030061035.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809317.1424347.1031452366030061035.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Nov 2025 10:30:59 -0800
X-Gm-Features: AWmQ_bkn2X4Muwa5YDwL9Za-RiF_QHq0X864fEq-zu6JPdwBbWdf06tO9q6nfDs
Message-ID: <CAJnrk1ZgQy7osiYfb6_Ra=a4-G4nxiiFJZgNLLZYnGtL=a7QBg@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index a8068bee90af57..8c47d103c8ffa6 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -140,6 +140,10 @@ struct fuse_inode {
>         /** Version of last attribute change */
>         u64 attr_version;
>
> +       /** statx file attributes */
> +       u64 statx_attributes;
> +       u64 statx_attributes_mask;
> +
>         union {
>                 /* read/write io cache (regular file only) */
>                 struct {
> @@ -1235,6 +1239,39 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>                                    u64 attr_valid, u32 cache_mask,
>                                    u64 evict_ctr);
>
> +/*
> + * These statx attribute flags are set by the VFS so mask them out of replies
> + * from the fuse server for local filesystems.  Nonlocal filesystems are
> + * responsible for enforcing and advertising these flags themselves.
> + */
> +#define FUSE_STATX_LOCAL_VFS_ATTRIBUTES (STATX_ATTR_IMMUTABLE | \
> +                                        STATX_ATTR_APPEND)

for STATX_ATTR_IMMUTABLE and STATX_ATTR_APPEND, I see in
generic_fill_statx_attr() that they get set if the inode has the
S_IMMUTABLE flag and the S_APPEND flag set, but I'm not seeing how
this is relevant to fuse. I'm not seeing anywhere in the vfs layer
that sets S_APPEND or STATX_ATTR_IMMUTABLE, I only see specific
filesystems setting them, which fuse doesn't do. Is there something
I'm missing?

Thanks,
Joanne

