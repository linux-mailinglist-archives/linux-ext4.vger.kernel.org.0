Return-Path: <linux-ext4+bounces-1383-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6CA862B59
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Feb 2024 16:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2431C210D3
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Feb 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499861757E;
	Sun, 25 Feb 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIGtpTVl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4291799F
	for <linux-ext4@vger.kernel.org>; Sun, 25 Feb 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876627; cv=none; b=kTzCpT8dLNukDjbN8sa3ecOiB/ce6xYfyJ+FBhDujVv7TsHwtTikddxqnm5LeZIYsX/gCpkNYZsRYHqDPs5bgGkDsAb66zw3UQ8HwEuZSKKiRX1sgEpBvTghCKVeU4TCXg3qbIOlXlYMH8+KZQC5WUPPneqbjzc3AwVpaO6nKdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876627; c=relaxed/simple;
	bh=fiKrljcZXZtlcaof47hzFGF90stgf/tcm7LbBRNJnbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzJA8CUa8yVG9YDaOYOQohvWdByjLGng4edRrIZQSunONjL9KxbO93WWwN17ItZDaVNxtYhwD1wVE363Xc4rRI6l4nlK1R80C/ZvC9Qsiw7pD0MytKkoVRJUsdPykeVkZ5D0hf/ddExcTW/j4Q+ZnnNum6wj0WoP8rWIwj15PH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIGtpTVl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708876623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hOtPeX/xXFWzaT6G1FW9bL5Z9wtGd/xkqwGLhxqceY=;
	b=aIGtpTVlJzSWVamlegya+wZmtlC/9TYD3yCgQWl5nRp1JLUHzjrThvrc7UV75Qtfv9k3dq
	zw/fdx23bJgy3HhsA8FB3unWRGNSNGmTNJ/0/mLu24/APhIxgnej4MHmF7ywVETEqp/27u
	ZsbpybmyCH3pae+yBt/Kc5jIZPlEObQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-KMegNXdkOpW97tssLFqcCw-1; Sun, 25 Feb 2024 10:57:01 -0500
X-MC-Unique: KMegNXdkOpW97tssLFqcCw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2993efc802dso651171a91.1
        for <linux-ext4@vger.kernel.org>; Sun, 25 Feb 2024 07:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708876620; x=1709481420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hOtPeX/xXFWzaT6G1FW9bL5Z9wtGd/xkqwGLhxqceY=;
        b=jCwvflbrVxY1xlMj51Jq+3gPvW/FiuYxcQ9Hh60OJG9VfCz7+cgo8brZTwtPUE15DM
         Fx/0OV3cSNh+wjf5dSW0LHRmpGXMbKIGlxUw1ymi5t4H8MJtpB04qPeGjYMHG2HZfp5a
         ZaEKoe/+wF/tbtznuoECW4hPP3RTCYCiShme3zCZ34ZrdmDl0jbR3htMtUqsS3qqvQUa
         4tKKj3CMwbfLgDliBbGZjZ9oSItFaaX6Agx/9hvLEUfseEcJrHHvdfElG13emEPQZ0v1
         4z8IuhfvbPxIidnumb7WIANR2jRPOT8kz+fOr182k+aTlWQwSF75t71//OnM/kUfd88O
         4Y3g==
X-Forwarded-Encrypted: i=1; AJvYcCVvkt+4zDJor6/siuKI4U5cO6sghagv1/GHpdHAT4GjLsK0I6R9sIjiNTV6Z9C2OlBpFVm4rHwT1ODtE2ib+rTcBiW67HEhyr2LKA==
X-Gm-Message-State: AOJu0YwszVSNpvAiVnzu7qut5aJv2Y6yPXrYTgcht7ub53DPeueekswK
	hVWC0AO3EDnp613qsFQRVMAJmeKgf8VKoLS0OZDedkF0yh75ty7edL4A2C3TsDAho4hiWbzrywq
	EE/Z6lBJO9TYmM/Adl5mPxHZmBOiQqTM2aP+ewZfse4GZdGOR71qje2CQXiw=
X-Received: by 2002:a17:902:cecc:b0:1dc:8f8e:63e2 with SMTP id d12-20020a170902cecc00b001dc8f8e63e2mr2027329plg.46.1708876620687;
        Sun, 25 Feb 2024 07:57:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYD4OIDKtJnVeUt3DUnxm+IFnlP4E8s3oJlEmqVr8y1fFPpOWIYUhm+rDjzfFzfsZ2c4W4Tw==
X-Received: by 2002:a17:902:cecc:b0:1dc:8f8e:63e2 with SMTP id d12-20020a170902cecc00b001dc8f8e63e2mr2027319plg.46.1708876620334;
        Sun, 25 Feb 2024 07:57:00 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902b40200b001db9c3d6506sm2357596plr.209.2024.02.25.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:56:59 -0800 (PST)
Date: Sun, 25 Feb 2024 23:56:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Henriques <lhenriques@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] vfs: fix check for tmpfile support
Message-ID: <20240225155656.yjqyuyjxsbtiqvb2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <87jzmxisqm.fsf@suse.de>
 <20240222-mango-batterie-505564cecb69@brauner>
 <87cysoh9wf.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cysoh9wf.fsf@suse.de>

On Thu, Feb 22, 2024 at 02:05:20PM +0000, Luis Henriques wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > When ext4 is used with quota support the test fails with EINVAL because
> > it is run after we idmapped the mount. If the caller's fs{g,u}ids aren't
> > mapped then we fail and log a misleading error. Move the checks for
> > tmpfile support right at the beginning of the test in all tests.
> >
> > Reported-by: Luis Henriques <lhenriques@suse.de>
> > Link: https://lore.kernel.org/r/20240222-knast-reifen-953312ce17a9@brauner
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> FWIW I've just tested this patch and I can confirm it fixes the failures I
> was seeing in ext4.  Again, thanks a lot, Christian.

Thanks for your confirm, I think we can have your "Tested-by" if you don't
mind.

> 
> Cheers,
> -- 
> Luís
> 
> 
> > ---
> >  src/vfs/idmapped-mounts.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> > index 547182fe..e490f3d7 100644
> > --- a/src/vfs/idmapped-mounts.c
> > +++ b/src/vfs/idmapped-mounts.c
> > @@ -3815,6 +3815,8 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
> >  		goto out;
> >  	}
> >  
> > +	supported = openat_tmpfile_supported(info->t_dir1_fd);
> > +
> >  	/* Changing mount properties on a detached mount. */
> >  	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
> >  	if (attr.userns_fd < 0) {
> > @@ -3838,8 +3840,6 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
> >  		goto out;
> >  	}
> >  
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >  	pid = fork();
> >  	if (pid < 0) {
> >  		log_stderr("failure: fork");
> > @@ -3991,6 +3991,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
> >  		goto out;
> >  	}
> >  
> > +	supported = openat_tmpfile_supported(info->t_dir1_fd);
> > +
> >  	/* Changing mount properties on a detached mount. */
> >  	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
> >  	if (attr.userns_fd < 0) {
> > @@ -4014,8 +4016,6 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
> >  		goto out;
> >  	}
> >  
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >  	pid = fork();
> >  	if (pid < 0) {
> >  		log_stderr("failure: fork");
> > @@ -7715,6 +7715,8 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
> >  		goto out;
> >  	}
> >  
> > +	supported = openat_tmpfile_supported(info->t_dir1_fd);
> > +
> >  	/* Changing mount properties on a detached mount. */
> >  	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
> >  	if (attr.userns_fd < 0) {
> > @@ -7738,8 +7740,6 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
> >  		goto out;
> >  	}
> >  
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >  	pid = fork();
> >  	if (pid < 0) {
> >  		log_stderr("failure: fork");
> > @@ -7929,6 +7929,8 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
> >  		goto out;
> >  	}
> >  
> > +	supported = openat_tmpfile_supported(info->t_dir1_fd);
> > +
> >  	/* Changing mount properties on a detached mount. */
> >  	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
> >  	if (attr.userns_fd < 0) {
> > @@ -7952,8 +7954,6 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
> >  		goto out;
> >  	}
> >  
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >  	/*
> >  	 * Below we verify that setgid inheritance for a newly created file or
> >  	 * directory works correctly. As part of this we need to verify that
> > @@ -8163,6 +8163,8 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
> >  		goto out;
> >  	}
> >  
> > +	supported = openat_tmpfile_supported(info->t_dir1_fd);
> > +
> >  	/* Changing mount properties on a detached mount. */
> >  	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
> >  	if (attr.userns_fd < 0) {
> > @@ -8186,8 +8188,6 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
> >  		goto out;
> >  	}
> >  
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >  	pid = fork();
> >  	if (pid < 0) {
> >  		log_stderr("failure: fork");
> > @@ -8518,6 +8518,8 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
> >  		goto out;
> >  	}
> >  
> > +	supported = openat_tmpfile_supported(info->t_dir1_fd);
> > +
> >  	/* Changing mount properties on a detached mount. */
> >  	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
> >  	if (attr.userns_fd < 0) {
> > @@ -8541,8 +8543,6 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
> >  		goto out;
> >  	}
> >  
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >  	/*
> >  	 * Below we verify that setgid inheritance for a newly created file or
> >  	 * directory works correctly. As part of this we need to verify that
> > -- 
> >
> > 2.43.0
> >
> 
> 


