Return-Path: <linux-ext4+bounces-1518-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC57871F6F
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Mar 2024 13:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6242E284501
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Mar 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD508565C;
	Tue,  5 Mar 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dKC+KEve"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AD85642
	for <linux-ext4@vger.kernel.org>; Tue,  5 Mar 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709642626; cv=none; b=u73a/xwbcqRmmmEO3cKtSy2sD6nYJIilCHbZuOUk4S3mdNhtEEk1IWbHNwJO5Ac6/WvjK5xhk8UZ8prygeWOskV8FwHytHnhK5TMHfUgTnCEhs0X34hfHeqX7zl4xgFFLPmF4bWtu6ALNOik3A38sP9KhAY+jOkYSpCWIfGoYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709642626; c=relaxed/simple;
	bh=hqXu4Imvd+YZYd3LEDpX+ZnPOXEZjX0E+C7N/22uaKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKmpfLfUzdUhJDMkmN2FuS6/ucTDcWjkIy5xZRoEGVxdz3kN5ad4AFRutdCweYG5blMe1es7QXLU7evo6n7AouyT3bj9NUMQ/OCt82NDMnm4Nd/5lxAK1Ec7IZ61DpxWNMLo4Y/udmGeQekfNV/jYED4OlwTT5mW8ZoLxQh7Yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dKC+KEve; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so70671661fa.3
        for <linux-ext4@vger.kernel.org>; Tue, 05 Mar 2024 04:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709642623; x=1710247423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hqXu4Imvd+YZYd3LEDpX+ZnPOXEZjX0E+C7N/22uaKY=;
        b=dKC+KEveoMrJox2JYoN1rvvJPEQQ5mCmK3iLWi4q4dPWC+fFRrXaIlNn1m/iKZ10cP
         nZeuPDRqkY+/3JruQ5n7cNfVoY9390s/JhFXC1tW0Qhc1LLfB2JFqWhBMHgPOxs48N93
         WQ+YO514bBN++CfZKG7X0nrtv1qxDtPJMscfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709642623; x=1710247423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqXu4Imvd+YZYd3LEDpX+ZnPOXEZjX0E+C7N/22uaKY=;
        b=e/ZgT5R9tH/gVbFY6pPC2d3wqloQMXjzI8M/xAAhnySmpUcz/aGFphi5oyib/5wbfe
         vjFCwRcW7RUxi1J/smj++yZ/BNrxh4/PDT2q2UQXSS/8l0XBtK7mFdnBpSZ+IoQ7ys2G
         lyQuHO/WMMZnAoL5ORy8OFCug4W25bfVtuuIbumtwOS0CE8o1Wyxd3q2r4DHwIKhSQu7
         Ny8CIbwg2PGqnewkzEvpONJmiwuEur6FeIktpC7OVvnbOQvZEnVakca3qHLMEk+vKUhK
         n5HKhKrQg0acVkuFM0M6QlVlhFbsuC1rCPf4srI8l4pupV/o8olx/sVXkEkShawIdU9M
         i73A==
X-Forwarded-Encrypted: i=1; AJvYcCUlItVX5PzD69wfkU4CwyY1mVuKnTl2+8p1+inPzm1w5B50WmRy20G5dGYGjWxVXukbGrHNfr3AG9XewXE78C/8ZsCsimaWCO1Uhg==
X-Gm-Message-State: AOJu0YzM3q0DmZR2AnpyMyYcKNvMRSpd6jcd5Ez1DPPi/gJ9fClw1qCk
	MxCBhBUcgry95o0q8JWDwphNN42q2aG6dFwglBGIKatUpDtIpfO5FEv6u1BMZMONy7bRMcEPLXs
	H/hlQG+MIAPiweP0TuGbSz78hhDzdGPsjqjRHDg==
X-Google-Smtp-Source: AGHT+IFDaUTfRvZDVguiUspJ8bW9xNWfKoMVLiqWzzQ2oinl9J77SQ70Ly+nbCnni8ZMPAqYVspxryxBQbzNkvrnVDU=
X-Received: by 2002:ac2:5e7c:0:b0:512:f5af:3bdf with SMTP id
 a28-20020ac25e7c000000b00512f5af3bdfmr1088535lfr.68.1709642622758; Tue, 05
 Mar 2024 04:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204021436.GH2087318@ZenIV> <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-11-viro@zeniv.linux.org.uk> <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
 <CAJfpegtJtrCTeRCT3w3qCLWsoDopePwUXmL5O9JtJfSJg17LNg@mail.gmail.com> <CAOQ4uxhBwmZ1LDcWD6jdaheUkDQAQUTeSNNMygRAg3v_0H5sDQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhBwmZ1LDcWD6jdaheUkDQAQUTeSNNMygRAg3v_0H5sDQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 13:43:31 +0100
Message-ID: <CAJfpegtQ5+3Fn8gk_4o3uW6SEotZqy6pPxG3kRh8z-pfiF48ow@mail.gmail.com>
Subject: Re: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 15:36, Amir Goldstein <amir73il@gmail.com> wrote:

> Note that fuse_backing_files_free() calls
> fuse_backing_id_free() => fuse_backing_free() => kfree_rcu()
>
> Should we move fuse_backing_files_free() into
> fuse_conn_put() above fuse_dax_conn_free()?
>
> That will avoid the merge conflict and still be correct. no?

Looks like a good cleanup.

Force-pushed to fuse.git#for-next.

Thanks,
Miklos

