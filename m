Return-Path: <linux-ext4+bounces-5115-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BEF9C61B9
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 20:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B60428554A
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8DD219E20;
	Tue, 12 Nov 2024 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K+4ouhZl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9DE218947
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440779; cv=none; b=sOCJvF+oL0SqmZOrgU5HagT4iCBzzBOmhnFz+IeIIp3Z800VfsGi1i+4ddWbO40DGG4i9/70w+IvobrssuTgG3WdFzKDT9kx16cs+H+h2pXJ7/NZIbKn1vbrdcr/5d2iBOBLBFwCBmsHKNtNjZ1MuVsTnEVKZRVKpGWukjTCGMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440779; c=relaxed/simple;
	bh=bna1DQ543WyJHuuqATngsHU2aVkAWd+Y+jUOxH+XtcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXlNlOkzvfAxC8Y8i05sRpdJ9Y89VCg1kq5S7FzwFZ6r63LhhZP1rzcq018GF3ZmGQkAikVG0Jbx7Zz3ww2JfJQqtybzTUH4+mB6+VxzYPm5SapietJIGxGvK0xO6ehF/Gezvn/1bkgQbDTlXKn4j1uE21y93sqtYFXNZjb93FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K+4ouhZl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53d8c08cfc4so3484479e87.3
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 11:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731440775; x=1732045575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JlJJ+zcJgVAM09bT3idZLHPWsiy7qwqX02nyVSrJZ4I=;
        b=K+4ouhZllWioj40xDTui2QI0IZW8keClTqRnmIBmRyp4LoNsrQx5S34iT0OyHXoESz
         GIVrGX82oc3Gz/+r+ONA5F2hKCxv67dD6cxoJKx00h/u6pOUQUmDVEZEpKDNygnxayLv
         pfp2ZLcjXkn9Nie720lcQvHbzs/pzfuAbrHxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440775; x=1732045575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlJJ+zcJgVAM09bT3idZLHPWsiy7qwqX02nyVSrJZ4I=;
        b=AnuVvB5MMvfz/CVAZfjEfyexewjCZyqzQunCNrhnERDyjMZ7h9YEBbeA3TMNT+1iSa
         LF/yHGhTlYniCtflJEFhwRVV0lVg9kqDHmb6V618xzx7WFYxVe8eXd6pqhAphC/njJFM
         dOlPhxqsjP4HUbft74psQ+UFdmp2rMHvzUrMCSLOqHr/SbLEvULraYOoyl9vyqtvQxNm
         XwguMJxF6Mc2DuJY8ypHYXlFvoigt2se5nqWLB4jktyoEyegW0H7P/rDRyIggAuEk0IU
         W6rgog9iA6Uj6MmNmVZdgStVSH3ydoej9Dqv8iDkOebCwvPJhpcuy+ZORSpg2DjJxa21
         5lIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5k2h7Co9fF7D1fUZzs3uvwpYMtw6/ABIy8dgmRxu++9YwMdiB2w5jPCRgYmkDash3qSEEC3/ntFek@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2wtk8Ft90FVul2UGRWKGLLqZhl1UrB4KhbJ4tohXqzTAPHw+
	qEeVKwOdFhtohYaS2hBu8Rn9zE4CdBYrmbxt4xTor0+khFHu/B58RuF6ftPmi860gpUOHGTcByS
	in6gIAA==
X-Google-Smtp-Source: AGHT+IEJBQ1+0TRkJ7YJj21HV4lVKBQ2cxghp0y78zkttXQRNEkZGfAwr5pqaHr8l1nwe0i/JhLnjw==
X-Received: by 2002:a05:6512:45b:b0:53d:a00d:b343 with SMTP id 2adb3069b0e04-53da00db35bmr23901e87.36.1731440775142;
        Tue, 12 Nov 2024 11:46:15 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826aefc8sm1970474e87.260.2024.11.12.11.46.12
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 11:46:13 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539fe76e802so6808024e87.1
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 11:46:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW97fZCRmuDIOXOrrAOrIitmYi32IepPnXjF/xjNZgeGSd7BaovMTy22u4Xmw38NSG5/DGHISUrvfKr@vger.kernel.org
X-Received: by 2002:a05:6512:3d89:b0:539:d870:9a51 with SMTP id
 2adb3069b0e04-53d86302f33mr8492323e87.48.1731440772062; Tue, 12 Nov 2024
 11:46:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <8c8e9452d153a1918470cbe52a8eb6505c675911.1731433903.git.josef@toxicpanda.com>
In-Reply-To: <8c8e9452d153a1918470cbe52a8eb6505c675911.1731433903.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 11:45:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFKgs-to95Op3p19Shy+EqW2ttSOwk2OadVN-e=eV73g@mail.gmail.com>
Message-ID: <CAHk-=wjFKgs-to95Op3p19Shy+EqW2ttSOwk2OadVN-e=eV73g@mail.gmail.com>
Subject: Re: [PATCH v7 01/18] fsnotify: opt-in for permission events at
 file_open_perm() time
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
>
> @@ -119,14 +118,37 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
>          * handle creation / destruction events and not "real" file events.
>          */
>         if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
> +               return false;
> +
> +       /* Permission events require that watches are set before FS_OPEN_PERM */
> +       if (mask & ALL_FSNOTIFY_PERM_EVENTS & ~FS_OPEN_PERM &&
> +           !(file->f_mode & FMODE_NOTIFY_PERM))
> +               return false;

This still all looks very strange.

As far as I can tell, there is exactly one user of FS_OPEN_PERM in
'mask', and that's fsnotify_open_perm(). Which is called in exactly
one place: security_file_open(), which is the wrong place to call it
anyway and is the only place where fsnotify is called from the
security layer.

In fact, that looks like an active bug: if you enable FSNOTIFY, but
you *don't* enable CONFIG_SECURITY, the whole fsnotify_open_perm()
will never be called at all.

And I just verified that yes, you can very much generate such a config.

So the whole FS_OPEN_PERM thing looks like a special case, called from
a (broken) special place, and now polluting this "fsnotify_file()"
logic for no actual reason and making it all look unnecessarily messy.

I'd suggest that the whole fsnotify_open_perm() simply be moved to
where it *should* be - in the open path - and not make a bad and
broken attempt at hiding inside the security layer, and not use this
"fsnotify_file()" logic at all.

The open-time logic is different. It shouldn't even attempt - badly -
to look like it's the same thing as some regular file access.

              Linus

