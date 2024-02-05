Return-Path: <linux-ext4+bounces-1111-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A01849C3C
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421FE2856AA
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF320DF6;
	Mon,  5 Feb 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NcuWp1nl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F78320DF7
	for <linux-ext4@vger.kernel.org>; Mon,  5 Feb 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141130; cv=none; b=qU7k2+CkYbU4B4SBOGyXbXEI8ldSslJ52gtNDN+/rGcIaD6S8uJ97wIMkNBKAiWiITK20QIj7ejp9EQ8JsxCfeChhNQgYkSpwU5MTq70KNG6NGan/3E++MJJ8eZ4wnU/mkGmtoEcuPbEQVx2EorbVngFgrCQeldSCIy3Ts1H/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141130; c=relaxed/simple;
	bh=2Xv/TMPnZ6ACI/uw5nCEWZWMTiYPSRlxi3KzNmIW+M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxISBcScBO/lR8Mw9FuH4om1A2z9TQWuHdC/FnViI83qPGzfekjc4n9/rmWUd3A5gL5BATgyHezcoH3QMccgMXgfqB3LWNi42zr9q/EsKRIu4Vk1djaFcEc3vLqniFEeNNh6oPHNJjnn8Fnp2TePQr0flCON5BRSDRqjU1ZwGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NcuWp1nl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51109060d6aso6246707e87.2
        for <linux-ext4@vger.kernel.org>; Mon, 05 Feb 2024 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707141125; x=1707745925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xv/TMPnZ6ACI/uw5nCEWZWMTiYPSRlxi3KzNmIW+M8=;
        b=NcuWp1nlWvOmKDC+Us3xfB23YsW8RgUJlLlIRMYExr0fBNaaUQJBoDuLQn6Hzgd7ux
         5mS8g5eqer8E27aG2gtEBQlGEYw6eCfqtfGJ/JcpLxVKxlgtFL5dNs41yfVDg7eHBsN6
         ziM2eIdru4OyBQneL4aO4SU8i+lLz0z5AlCvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141125; x=1707745925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Xv/TMPnZ6ACI/uw5nCEWZWMTiYPSRlxi3KzNmIW+M8=;
        b=rkgt8Luk7EUPoWqeuuuJTIVu1h57FlMYj3mDsrk6xOH/B1PW6jY2L0/OeuXaQRELF5
         DsjJ9cus6CjIJ6ZUAmw7mVbt7Ss9s1uBmo4SjnZld8boNGKVnN+9IEGesTbfcPdW7+/X
         7wuAYNDtfTHMkdFXC9fTlNOh3ac/xH+dkhYGoLEYg6SHajAbGNMRqbFNyHGoQhmT6dI5
         92JD/ec8651v3f+LEVc7maYt49OVojm6zH1LtCi7J7BTS/7rcYUcPEv8cMKJb+WfVL/U
         gTQMLVUhzTQ8mosiuXOtPriJz92d13iu51lNzHbtovz8M1Y5+xcEdVxKdQEMMDYrT0+/
         gmSQ==
X-Gm-Message-State: AOJu0YxOxED7ZUT0LZS8PGVBL4S1J2W4WmCaULqDjuuWx46buMRQLPcG
	lKB3IRrEP3qbTMAmUGniPxfgkna3J2rcQiGd6PBRpHuiU/RCaPlbYLhlFR+6E2jGLuZ6dXpac+Z
	hAIiIf9bVk3lrgMAC0Rze4y1MgeNs1McRCfhoaQ==
X-Google-Smtp-Source: AGHT+IGCaEVVe6GrK1mvmKbk8cfbvkS3XUvRFFWxmUF4PfOm8rDUxdDRR8CpRP+LOC3U4ed7OovlnHoRwjwU+gtFl6o=
X-Received: by 2002:a05:6512:3b8b:b0:511:3e58:3cff with SMTP id
 g11-20020a0565123b8b00b005113e583cffmr6188837lfv.16.1707141125271; Mon, 05
 Feb 2024 05:52:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204021436.GH2087318@ZenIV> <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-11-viro@zeniv.linux.org.uk> <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
In-Reply-To: <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 5 Feb 2024 14:51:53 +0100
Message-ID: <CAJfpegtJtrCTeRCT3w3qCLWsoDopePwUXmL5O9JtJfSJg17LNg@mail.gmail.com>
Subject: Re: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 13:31, Christian Brauner <brauner@kernel.org> wrote:
>
> On Sun, Feb 04, 2024 at 02:17:37AM +0000, Al Viro wrote:
> > ->permission(), ->get_link() and ->inode_get_acl() might dereference
> > ->s_fs_info (and, in case of ->permission(), ->s_fs_info->fc->user_ns
> > as well) when called from rcu pathwalk.
> >
> > Freeing ->s_fs_info->fc is rcu-delayed; we need to make freeing ->s_fs_info
> > and dropping ->user_ns rcu-delayed too.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

