Return-Path: <linux-ext4+bounces-11499-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC987C37580
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 19:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C26314F116D
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3C2FD1AD;
	Wed,  5 Nov 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SjKKMhOk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D72BEC2A
	for <linux-ext4@vger.kernel.org>; Wed,  5 Nov 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367629; cv=none; b=ZsBNgIe389C7XBJHPh8MAIq+nWeMgI5UrecXl8NMH0N34waHjM8yM4fVoB+CS8nO5Fo7j0lmXhFZjKRl8rlEJXYxCqW1f5Ed2DUA23af50kv59sfdIp+teJA9o4qoSa+gUflU63TX0Bsm31apHhIZiEfblBlpddtkk/qN/x43GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367629; c=relaxed/simple;
	bh=QdIsCbGU61ikoVL7GQujIgBmKZhEQF493waeOpnzVho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAebfwpQouhpDze90L4kaLH+OLk/vKIQWLjB9s1iLPEs6F18F66cpUP2Sym6YjI4kxZ+uN5PtPPca9LTG/v4seWTbGg9jVsHpcaxvQP7ApdL6Znh+vJbIPVPyZHPr8/s0ADEdBmwnyMIxfZQMklWa4F+B8HtoV2Dt+STpQ6GT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SjKKMhOk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso106595f8f.0
        for <linux-ext4@vger.kernel.org>; Wed, 05 Nov 2025 10:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762367626; x=1762972426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw9BgXv3xuEvlMmxJm1mpqDieF/LQYS6cC55AYGAEG0=;
        b=SjKKMhOkVclgt5wp06tjOozRABfkZ157n3Ix5SYUyCzRY+YcIQn4QR4INg0zTXV7c3
         XQqAs/5SJF8dWArGKQr5D8jX+CBl8EQVU7u+hurVf1xXm1M0uR3lMX+wHxb8vRNPuSPK
         x4WoIBrMnpNbP+QNvjLsL3J8WYSLS2PzrFwkVegZOaDDYG5rYoQY90YxxZe2tqFrcVZ/
         NsAs0WqPGEAVPNGME6r72Hs9paI8xPPjpmqTY97a0odiAAIGcM8+DhblCWihcvFVsiCq
         v42x1ScK1W7eFMjWRS/gnctfipQXCjKwSEDOC/acfQ41eI3++x+s0/1tRNrYLaCQPmfx
         A5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367626; x=1762972426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xw9BgXv3xuEvlMmxJm1mpqDieF/LQYS6cC55AYGAEG0=;
        b=djUX92xhpUDLysxDieLk1dTKOaJwGjJBJVOLC7SIbK3fv/pyTL8To1ooI/EuZno+Q+
         +Oq33rOu9OZdi+/qfcT03XSMib9bBH0VgOhSA1HmI13uM6xxbB76paahAbViY7/ioGON
         rnYsGYU4jJ3XKSrL1w3HvhpUG2IrfQnVWwGL/A4jBURqGoXqJzJ6JrvfltGzjZtigLfK
         p8HlonvxYaCt2pA/rtHmz/FHg/9pqxJrAFkljuyCUk2mG6fXfdRls5HkS6AEEADUwSBk
         c79A8oc7GDhqRHAMb2/cHEFSvnJiVxusdK9mxtlE9+ls0ogBbnOziepFxDZy8s5SO1Fq
         BBZA==
X-Forwarded-Encrypted: i=1; AJvYcCVngjHzLDXoYLWG/IQD4nAvtRuzecbHmQ/Bz+TDgGoWHbhNYfcHj6S3nuzLV1RYJDw6k0v+ak43NfEj@vger.kernel.org
X-Gm-Message-State: AOJu0YxKfd8NldxCoXTa5hlzGqIsTRc6f74ZxVtQNXgsTIlsvtUgorNi
	z62ud/R5MJk0weQ8KxlE1YSL5RL75Np3rz4aObPnkgsSg9FOF9SD7Y4Lvf6cmbnd8ulOfzvcF3g
	PojJh+R5FhNqPmcxmqdRpBzicqmh80wPv+ZRMYmjI5w==
X-Gm-Gg: ASbGncu7JufTdJjkd47uHJI+saNZO1JOBXbUwkz0kxJi43OVHOu6GVslnK4Xy2Zpg+j
	ylde3n2Jd/UCnP6eMv1XoZH90RsBUXAz1icDfOLdfxnvfgXCmsweO76tWIjiT4oDEp+wH61MpTs
	ujDqGjK11wYK6QKTpmdFA3kbpFGTv5zI7uauMprKpVX/bkIXkEdG5UckAnTEYEuzbGKE6CsbkXH
	X4lCjEw37tg8A0cycrTIQZFMZkMsJI4wbmzyvq7OjZn8jZTjbBaLjYpJdmX/OTfUpX97FVvQOyk
	Se1Gpr/4Dfii9ERQ5oy00OfPPVwxLG1f0ZTfJzSPG8F4OKuMeCNCOv/xVg==
X-Google-Smtp-Source: AGHT+IFCZTc3E2XHwDCl+YRtQQFR97QktfT8RGPDVIDrhNNHjq8LIXQFn/CmjbQ3aTH0Rp5kdEDKiM0TTWzYhWFlzC4=
X-Received: by 2002:a05:6000:1849:b0:426:f9d3:2feb with SMTP id
 ffacd0b85a97d-429eb18aaacmr432745f8f.23.1762367625965; Wed, 05 Nov 2025
 10:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org> <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 19:33:35 +0100
X-Gm-Features: AWmQ_bl6PadzQPI3bpD_bJBLSeiXboTP6hljfgJQkUA_P8mn02EqfL9ZuICWSd8
Message-ID: <CAPjX3FeEZd7gX1OeCxRXrdBMafHOONB2WQO_JOZuxKoVEygzuQ@mail.gmail.com>
Subject: Re: [PATCH RFC 5/8] ext4: use super write guard in write_mmp_block()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 13:16, Christian Brauner <brauner@kernel.org> wrote:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/ext4/mmp.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index ab1ff51302fb..6f57c181ff77 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -57,16 +57,12 @@ static int write_mmp_block_thawed(struct super_block *sb,
>
>  static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
>  {
> -       int err;
> -
>         /*
>          * We protect against freezing so that we don't create dirty buffers
>          * on frozen filesystem.
>          */
> -       sb_start_write(sb);
> -       err = write_mmp_block_thawed(sb, bh);
> -       sb_end_write(sb);
> -       return err;
> +       scoped_guard(super_write, sb)
> +               return write_mmp_block_thawed(sb, bh);

Why the scoped_guard here? Should the simple guard(super_write)(sb) be
just as fine here?

--nX

>  }
>
>  /*
>
> --
> 2.47.3
>
>

