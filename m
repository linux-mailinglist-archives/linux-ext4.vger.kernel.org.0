Return-Path: <linux-ext4+bounces-1521-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B77872DD1
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Mar 2024 05:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B86B23BDF
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Mar 2024 04:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B314F7F;
	Wed,  6 Mar 2024 04:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3lyHxSa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6914AA0
	for <linux-ext4@vger.kernel.org>; Wed,  6 Mar 2024 04:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709697754; cv=none; b=ugPliyNYGvMueElL3ZayhJ4k7pdfQbqcbQ0oOA8PY8xY9Ln/7FR4FY4yu41ij5L5QfvcZVY2i26bYkmUoQGfGx1A/dpFs7n+0jQdmmCxFE2Yol/xWZmLm55lf1bIOcKzjfDPbdFbek6WJpgrStqWhEQINsKOQPPleYONtFOOa90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709697754; c=relaxed/simple;
	bh=Dt5wmqipR7fVi3HR1SR8hGWdIU4+LOlXh7MI1rtBj+4=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=Z5Vs5tY+4flbHZGpZa/o6vTsyndfAjIGpqRWOwoCvRcBd4qr+zaFyXSZWrhnP3ztK8awDWalqYaDrAEKd84LVWtdeuq4EQ11udWvYaLPtbJ8cINBKbiQOrudtFxsi6E47ZgbHfkUfMxT4bWIn8DtSAzEeIKPwRSrD0mugm1cb+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3lyHxSa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6082eab17so2920375b3a.1
        for <linux-ext4@vger.kernel.org>; Tue, 05 Mar 2024 20:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709697752; x=1710302552; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HMINz4z+0hf6cg9XnVUNN8G76dRxo2dVOSZnBiW8P7g=;
        b=h3lyHxSaaRqGiw3uUqfzgzchEKrG28ZM+d4oyRGizgSSC3OfkQfCnLUp5NoK9BIzlK
         CF1M8PF9a1elDVZoqgkYAGksMOK0AdNHjp4qiGnc8z7BahOXJzCpoKFU4lw1QQ1Gmai8
         zuaAhi6GMueRgZV+FyKy00Ub8eGlTPLWJNoIhq6jHmbbn2MM4gsTMhw22FD+EIHaoT4i
         VDiIzq7t39ONlIrCeENzOgmqS1fO+u6aLfBlNXCScz9NVAB7srUiSyfcWWa3N9+td9dj
         KjUoTFMAYPaVl8/T9jWY2id6R8UIzX5Gz7Ga+CBlXk5lLjcmeNP223UkTcKKC8ALn3b1
         vVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709697752; x=1710302552;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMINz4z+0hf6cg9XnVUNN8G76dRxo2dVOSZnBiW8P7g=;
        b=Xx3r4mTNGcsdhTxx1dCchGazB+g7Oee9lKXBdIThXgmnUZBtJQC8I/hmeeXBCY4OAF
         j7gmasI1DLlFtn6Kqd1FkJSx9UWJqEHiFAR35i3QhEI+O7hcWSqTGxHj6WPc1fELUK/i
         I7bftxJnIg4/2/XkHjeKIgrYKSSTwdoQWSkNB2fi+ss4HyZNYTrBTN7DkSHJrzlMsXlC
         pQOPKwfo6JKosxmsxj5sl4swZjvCptJR0yuD6NdLJGOPcPBMXNuS+8T2dzr6wRdg4oTn
         GhbuwAUzf8sIdzspl2g+yIcABqB6SHeRrkKR3D7JcT1ZCHCBE5/nr8LfItZ0ZYfPy4Lg
         Hx/A==
X-Forwarded-Encrypted: i=1; AJvYcCUUdR1SWQQc2E9U/nn/Irq0ZnhGOVecQYEenAf6qWr0uGnuoU7Qpju8wdA6aPuMJQdjQyoA4NkERXb4zOdT3md6U2jgoPv0Clqx0g==
X-Gm-Message-State: AOJu0YzfLeo3nFFgWk1PSLo2DbhmO1ohvf0Qr23i/mYKJj30SkHUAI5I
	zf0k5E4Ms7dQUuoOJmxv+eoXsEwr9D5+f3WsAoeow6+aKR++WT6u
X-Google-Smtp-Source: AGHT+IEkTZjbj6Fu7zgONat/WdPNWlL9EFqma5ceo2m9O5xpPdaaXfWNUihMz0dlZsHFhHbxIXmiXA==
X-Received: by 2002:a05:6a20:1611:b0:1a1:50c3:d564 with SMTP id l17-20020a056a20161100b001a150c3d564mr4145738pzj.1.1709697751707;
        Tue, 05 Mar 2024 20:02:31 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id m1-20020a635801000000b005dc120fa3b2sm8695166pgb.18.2024.03.05.20.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:02:31 -0800 (PST)
Date: Wed, 06 Mar 2024 09:32:21 +0530
Message-Id: <87o7bsovn6.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: Re: [PATCH] ext4: Enable meta_bg only when new desc blocks are needed
In-Reply-To: <20240227131329.2608466-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Srivathsa Dara <srivathsa.d.dara@oracle.com> writes:

> This patch addresses an issue observed when resize_inode is disabled

Other than "meta_bg unwatedly getting enabled when not required", is
there any other issue you observed?

> and an online extension of a filesysyem is performed. When a filesystem
> is expanded to a size that does not require a addition of a new
> descriptor block, the meta_bg feature is being enabled even though no
> part of the filesystem uses this layout.
>
> This patch ensures that the meta_bg feature is only enabled if
> any of the added block groups utilize meta_bg layout.

Make sense to me. 

>
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> ---
>  fs/ext4/resize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 928700d57eb6..99b52f26e818 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1996,7 +1996,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
>  		}
>  	}
>  
> -	if ((!resize_inode && !meta_bg) || n_blocks_count == o_blocks_count) {
> +	if ((!resize_inode && !meta_bg && n_desc_blocks > o_desc_blocks) || n_blocks_count == o_blocks_count) {

Beyond 80 chars line. You might want to fix that.

-ritesh

>  		err = ext4_convert_meta_bg(sb, resize_inode);
>  		if (err)
>  			goto out;
> -- 
> 2.39.3

