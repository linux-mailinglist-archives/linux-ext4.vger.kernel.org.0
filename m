Return-Path: <linux-ext4+bounces-11501-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF385C375B9
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 19:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7572B1891377
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF228851F;
	Wed,  5 Nov 2025 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gisM+4T3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297624729A
	for <linux-ext4@vger.kernel.org>; Wed,  5 Nov 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368031; cv=none; b=e8gz7xSr7xwIwLmdhidrDgvZfy+IerLwBEMuJ513hUp/V9cktlevayxwrp+6QDwa/qaqOK+F2r7vuPHOkDP2qzhxvwCqQf1NKLaQ4dIxTg+VD2I2aUPiUjZT+nbqgjgIEMiOFWR11q/ANiPUTcNGEFotu304O7PlySblRDYGTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368031; c=relaxed/simple;
	bh=AvBw7pIapYDjfqbEZ1bgncfbRO2NgqW+PZq/6jkqGM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFv5qnA4uDgmx6rKAs4U0ZYwy43IQUe+3TVtnz45SZOothbGA0p63hPRFAsci0e944hzwwDv1/TTZkumE9PNvIs/KQWdjxH3Y/d7IBrrMrExbqtrVNEsCSd0kzUHcEMbN+w232LK6ZiaGSS1ngUp9/be05nkjvptptc+3qpm8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gisM+4T3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42421b1514fso84668f8f.2
        for <linux-ext4@vger.kernel.org>; Wed, 05 Nov 2025 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762368027; x=1762972827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XIyQJV0BoOq8cM6bW2Nc4tys93TVUqC9F2FCguuU5Y4=;
        b=gisM+4T3Q9267eqJ1ys58qBqAdKRrmOcVQb1cdNiSx2qEd6cyvWlRcW8mUU8WvIePz
         1HrZfi4mV+sXAsV/7HQHl1PJQmjJb667uvzaCzODUDwSeMD9VZv76Ye7JZyc5T2nSzp5
         ZuXCqKHPHPXQra6fPgpeIB7w9aXpQPJXACBYR8fWFMxgSz3Kvs1JAboHCMbeQB3C+2Wa
         0wLyX1yRhzSG1+7YSeGI9RNx8iAFDkUmKxSncp8mB7DrF06FvWOqzhpmJHKiIkynBLsw
         w+I38X/mNLUSVaukwi4bauaUP0xoBjL5uqF+s80cMD7Shg2gfpNSm5mfzEXHN4hEEUy7
         X7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762368027; x=1762972827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIyQJV0BoOq8cM6bW2Nc4tys93TVUqC9F2FCguuU5Y4=;
        b=POQYggBXUqd7hS7mjAxNF/AMJsKHXBmjAfHAUtVrt4STQYcilfQZN9FMrZsZo5qbyD
         t2d7GIjMIaoB8DZYSj/Xa2BgHhKTSYNj+EE0MxMokZbftd1W22Ok40T7arzGBHE3eII3
         AiEOCDYY2NptwI7KhRqAUutGQ2XIXDps9ru5M8Yn8r5ygkWKRekWKbh97G6Br/MY7Fpz
         pSqNrUp1of2OLF2LMobxNPGt5S+YyuybBOO0HFr7vKJCcBT5j39xGjiFLsJMQa4xhDVz
         MPFJSbKwrArMhLaRxdzha8q5XtoJ2k1Y1LzdxzZlZnhCYVjz7MnudGVzFBxkjFxu9mJA
         ORIg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Ewj/NNsAuS1/0vFlRLziitYxaYjXPmuGjjELIYV6W87+EIYTEllzHKBizRnOFgmCjl/9mTlGhIZg@vger.kernel.org
X-Gm-Message-State: AOJu0Yywfr6dIbJgzMxJEFQgfdeQ2eo0uCz5Ny2OrN1+6X8arsKoQfiM
	9cdno73N+9eRLEPImw2EwiFMvcIk6pHzGFVY7POAbEnkh10jGKPLwmUraNhFuYHDbU/rTcAv9uH
	Bb1SYd7TnUVJMmzpGi+YIYr+0Z9otXBj+Es5MZK6CYw==
X-Gm-Gg: ASbGncuIjJKeNCLkCyd8vxi8nVA0cY1euwD16tIh60vD2KxxHZHlO6k54zmiQTfuDDV
	OlIDw9MheYJTpq+rufK9Hunkb3faZB3a3i0KfVaYGBuXBIF5C1qgUwi368ond3cdRNmNSBi7yi+
	dOzD+pXHng62lTc+bxmic/wunZRoBQGOicTYMmBxxJWSBYSQYzLITGi4sGt+pjBCQf19Jl1ncde
	rRcZ0lD7FXYKFdG6uflFXDZODAGY/93lRS095g0PE3yUaLmV4XVYETZw7sWeB27ZCAYzLk4ad6H
	ft8mcFVnOL3STxiz1SdYtfc+W/kLQk4w3SaKGvcp8d7AhS4Fc0KG5wuEUA==
X-Google-Smtp-Source: AGHT+IE7JHWAjENwi47IGOpfVP4yA/c0uXNjUPhrOCm2JpvPKV7uVzx/cwlCOY7h0IJ+8GoTWuRVpHEfcxcTPv30XiU=
X-Received: by 2002:a05:6000:2184:b0:429:b8f9:a87e with SMTP id
 ffacd0b85a97d-429e32e9348mr2957432f8f.20.1762368027493; Wed, 05 Nov 2025
 10:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org> <20251104-work-guards-v1-8-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-8-5108ac78a171@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 19:40:16 +0100
X-Gm-Features: AWmQ_blzod4RW1ZTgCh0cBumT4ZK5h0yfmsbksJOvdN6HEySSPMcZBN44FECEdQ
Message-ID: <CAPjX3FfyQ4wDD54_=wz62OBsSO30C2f7dmXZcKEu2JgpuER_KQ@mail.gmail.com>
Subject: Re: [PATCH RFC 8/8] xfs: use super write guard in xfs_file_ioctl()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 13:17, Christian Brauner <brauner@kernel.org> wrote:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/xfs/xfs_ioctl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index a6bb7ee7a27a..f72e96f54cb5 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1408,10 +1408,8 @@ xfs_file_ioctl(
>
>                 trace_xfs_ioc_free_eofblocks(mp, &icw, _RET_IP_);
>
> -               sb_start_write(mp->m_super);
> -               error = xfs_blockgc_free_space(mp, &icw);
> -               sb_end_write(mp->m_super);
> -               return error;
> +               scoped_guard(super_write, mp->m_super)
> +                       return xfs_blockgc_free_space(mp, &icw);

Again, scope_guard where not needed, right?

--nX

>         }
>
>         case XFS_IOC_EXCHANGE_RANGE:
>
> --
> 2.47.3
>
>

