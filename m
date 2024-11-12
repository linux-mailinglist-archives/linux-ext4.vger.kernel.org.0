Return-Path: <linux-ext4+bounces-5117-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 202039C6250
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 21:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3221F236FF
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 20:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F90219E26;
	Tue, 12 Nov 2024 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FcOcY1Xx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63579219CA1
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442362; cv=none; b=VhuKmClmfI2T0vpR8SjuPR+C+0dI6EboL/Ca39d8rF/pudAjEA4f28fwAnU+IxI+zLEJMIlIouRNgY6rayoKuFTONAlqtF2Cre1B0pU6DvMw0uYQEJvyqIVRoQteOrUzYtBB821NLi+kyTGoCwTTWLQj9DqR3itiV0DZ7DJsHdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442362; c=relaxed/simple;
	bh=APg3rcEySs1o4uLtYJBcvRsc9Qe6Q1ZTOQRJgr9MbAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ly71cGRxuPDCsZx0BiVvmsUmuHwu4NcaR5hbG0ASXsFtKM+LJIcHLXCVLquQweojmIaZw4inRxq9hS/vAa3cfiP7PCW76PjBVwXDJ9MW865s2Ro3V9jLbPh3z6HltZh4gzSJu0UQs1BdWbt48hNZL5X0S0q3omn46tc9O3TenDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FcOcY1Xx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f2b95775so7744613e87.1
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 12:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731442358; x=1732047158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0qYB3r0e+M+AIIS7skjeHUYQNaIJb6UwbAHof7SMGqw=;
        b=FcOcY1XxfT+AIEI3USMaJFNGOqARqrtF9owUJtu2wEb7/ptVNOsHJ84QKKDrH5zKzp
         90B3GLsaMtaZ4HVVL5aEiXKC15V6zMLNLhjI5TOcBsuOrvNzEgQIwbqIsahkizx7bcwv
         BNcShXFPkvJ4eS56JamG12HyOxMXJWxI5cuFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731442358; x=1732047158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qYB3r0e+M+AIIS7skjeHUYQNaIJb6UwbAHof7SMGqw=;
        b=UI7gUfH2f+FQHQkUojqjKQqji0rb43Yu6r+gzwGGSw2Yqzmhj+wCOySpTrnROTXmI7
         LPO7+ckODvPaCx6mMc/NpncI7ZQihmHY7PUEBBcH32uTRY3wbVLO4qWf2lK/prec+ZJm
         n/chOEEjN0W6lDwSlZN5VnxGugnQjsXcHQGfXam36q5zoWqanNWo9cl2gLeysKycDxNY
         orRxuUE9pUDcIth+Zw33/lob+81XE4EEuYBGPHbM6oVIXPngls5YRgSeFlyrjlsuAP0z
         SUIFqtb1Lv2CsPS2XNz4p0P6FR9tTnn26dng6IKgMgZWxaAWUE62IgQWn/PpfU9XwH/M
         zDQw==
X-Forwarded-Encrypted: i=1; AJvYcCVmaJveJyhNB/a0fdHIwZVZ3+i4x869PtPrBkv/Rd6z+JUCW8VIdCHeIfRjnvx5ydEaSKHQYW7XvXn6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsx8vr0s+orD8AaPbC6wO89tLwGacXt6TC6MaUhL0G+gLOnFPw
	tkNkwc2bM2UbvQ9F6q9KKV4i83gQsdDTLAA3c5yV7z/Rv+84bnd0KSX8KJ8nWNJ21NSUoBf3umC
	rlHWjbw==
X-Google-Smtp-Source: AGHT+IHqD9JiKMrHkUvuLp8WP7/x8XwhFQ4nbNSZEI1/e0MFnuq7ASJpl1jw6+BD7O5zXvaO0Qz4ow==
X-Received: by 2002:a05:6512:b1e:b0:53b:7ecc:5ddf with SMTP id 2adb3069b0e04-53d862cd080mr11864504e87.26.1731442358186;
        Tue, 12 Nov 2024 12:12:38 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4b90esm771861966b.65.2024.11.12.12.12.37
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 12:12:37 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so4163365a12.2
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 12:12:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmAqhb1/UT0lVWcOtKqHDVsUa1t3HElAyTEjSIKrks6/i0oytY+ifMXY0Cvg39ucCpAH8qCSiKMo4Z@vger.kernel.org
X-Received: by 2002:a50:cd1d:0:b0:5cf:22ab:c3b5 with SMTP id
 4fb4d7f45d1cf-5cf22abcab5mr13468088a12.1.1731442356992; Tue, 12 Nov 2024
 12:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
In-Reply-To: <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 12:12:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
Message-ID: <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
>
>  #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> +static inline int fsnotify_pre_content(struct file *file)
> +{
> +       struct inode *inode = file_inode(file);
> +
> +       /*
> +        * Pre-content events are only reported for regular files and dirs
> +        * if there are any pre-content event watchers on this sb.
> +        */
> +       if ((!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode)) ||
> +           !(inode->i_sb->s_iflags & SB_I_ALLOW_HSM) ||
> +           !fsnotify_sb_has_priority_watchers(inode->i_sb,
> +                                              FSNOTIFY_PRIO_PRE_CONTENT))
> +               return 0;
> +
> +       return fsnotify_file(file, FS_PRE_ACCESS);
> +}

Yeah, no.

None of this should check inode->i_sb->s_iflags at any point.

The "is there a pre-content" thing should check one thing, and one
thing only: that "is this file watched" flag.

The whole indecipherable mess of inline functions that do random
things in <linux/fsnotify.h> needs to be cleaned up, not made even
more indecipherable.

I'm NAKing this whole series until this is all sane and cleaned up,
and I don't want to see a new hacky version being sent out tomorrow
with just another layer of new hacks, with random new inline functions
that call other inline functions and have complex odd conditionals
that make no sense.

Really. If the new hooks don't have that *SINGLE* bit test, they will
not get merged.

And that *SINGLE* bit test had better not be hidden under multiple
layers of odd inline functions.

You DO NOT get to use the same old broken complex function for the new
hooks that then mix these odd helpers.

This whole "add another crazy inline function using another crazy
helper needs to STOP. Later on in the patch series you do

+/*
+ * fsnotify_truncate_perm - permission hook before file truncate
+ */
+static inline int fsnotify_truncate_perm(const struct path *path,
loff_t length)
+{
+       return fsnotify_pre_content(path, &length, 0);
+}

or things like this:

+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+       if (!(file->f_mode & FMODE_NOTIFY_PERM))
+               return false;
+
+       if (!(file_inode(file)->i_sb->s_iflags & SB_I_ALLOW_HSM))
+               return false;
+
+       return fsnotify_file_object_watched(file, FSNOTIFY_PRE_CONTENT_EVENTS);
+}

and no, NONE of that should be tested at runtime.

I repeat: you should have *ONE* inline function that basically does

 static inline bool fsnotify_file_watched(struct file *file)
 {
        return file && unlikely(file->f_mode & FMODE_NOTIFY_PERM);
 }

and absolutely nothing else. If that file is set, the file has
notification events, and you go to an out-of-line slow case. You don't
inline the unlikely cases after that.

And you make sure that you only set that special bit on files and
filesystems that support it. You most definitely don't check for
SB_I_ALLOW_HSM kind of flags at runtime in critical code.

               Linus

