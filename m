Return-Path: <linux-ext4+bounces-5121-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA19B9C6599
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 00:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC5CB3C3A5
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 23:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB921CF9B;
	Tue, 12 Nov 2024 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NUFtFI+7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620B21C168
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455313; cv=none; b=HM89Y3/1uOWz1ZjXv87WfRRwsVAZTPoAIAJjxP8U+zXSAUhU5yG9ZUdlwjqev7CofxvR2DPqKkOfDQfjw7MobNOYxNTyHJSMVnlLqS81AmrCY1oJhvbmJxB9PXm/CmgXoskKUnSgCbztmteL+vVd3YQe4A8BG+BEIo1Dt8Agz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455313; c=relaxed/simple;
	bh=PtUR7xHG3XzaDOKNcGaWg+AXTkiClAf7xGs2wsblnAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLeKsZy3ozUejTnMSamqxuTczrNmXm3b8SVnh1tCPcfsv13V27xvvWWSp98epvsKlEmXnVuFgtukXOZ6jeSf+baexQPBfDMgvqfosBJY6SH80WVGgwYsxwckXaqlbgkT5N8QTPT2ks8QDlcBPNWgpfl2ipYRoXNJPlJkCcYf9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NUFtFI+7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a68480164so891122666b.3
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 15:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731455310; x=1732060110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cA/tzxVfR0e9vh4jgAsTIRH0TxinS/T5igog/R3JqgY=;
        b=NUFtFI+7lJgzVBqDXkQqDjgRb2wnWKNzv/uKVDPyVvwaXWVshp0MV1qnRXfStKIHTD
         DrRzqfFPpCbPU/pbdzfFeiugMK87+dvVseK+NiKlCrQ6Xv4bUI18nU/AeThre5okzfWd
         W0clNiyBzKvs0mOpWyWwMj0ht+2SbyygBZ+/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455310; x=1732060110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cA/tzxVfR0e9vh4jgAsTIRH0TxinS/T5igog/R3JqgY=;
        b=IjnMZTsVOmzQAI5lyGKyp9MoltAT/zTCoylAUfBvpjkGzbYTPMi3/eH78siz62Nu4Z
         tufcNcAQn4JX+IjFFoTjUrxuIq00a40+xhskvMGa/PG0uogbdkT3J65tMwRqBPmVTmgM
         jiA2ywPkvXmJnsPFU7Bu3XdTcL9gP93bJzAD9htugvIZTs6LcZqGpURC5ufh2NhpbpW6
         qI8XhcStmP8j0vxcdJh01fKMDrGe+bqGeYnDf2B6pT5TRwibRgTXWEXLu5PZn+VDM0+e
         crMQXy4kOukrlmwKIH+6pI51NIfDpCmL18z7V92fuj3p34//8MEdp3dT4mhkWzCGYTbX
         4llA==
X-Forwarded-Encrypted: i=1; AJvYcCXEe7Z0AbXffw5Qn5p6HHYa94h+jKKjNad24Vz/ATE8oFAzANd+eyp5u+kXC+r980i+9gmUlU9K+rDd@vger.kernel.org
X-Gm-Message-State: AOJu0YzCojCpr9n+11rnUZAxo4Rve+veYnCgJ0wXNsHeY4PpowvvHED9
	nvhyUzrYKAsUCAA0PXS4x/sNa1RW8Zeo+5eLAq9eeayzv8Qb4Lm3AForxDXN2G88hMRbGePKl6i
	d9rw5Sw==
X-Google-Smtp-Source: AGHT+IHidZq++WAvDE+25TT+ts+ZH2vncG9a79Yxt73zwCXdVgz/rbS7yP885TCW+hdH2BFqwmQcug==
X-Received: by 2002:a17:907:9603:b0:a9a:4d1:c628 with SMTP id a640c23a62f3a-a9ef0019754mr1743816866b.45.1731455310108;
        Tue, 12 Nov 2024 15:48:30 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17635sm781237766b.17.2024.11.12.15.48.27
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 15:48:28 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so9479549a12.2
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 15:48:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWq0m+NTjrfYZhZNVzBiFPBwIgUVBbJTVN1lTFTKMTP2ZyqntyC9Gndb2Mse52xu9oIPZnN3f5b+4ez@vger.kernel.org
X-Received: by 2002:a17:906:4f96:b0:a9f:168:efdf with SMTP id
 a640c23a62f3a-a9f0169008dmr1114854566b.6.1731455306729; Tue, 12 Nov 2024
 15:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com> <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 15:48:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
Message-ID: <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 15:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> I am fine not optimizing out the legacy FS_ACCESS_PERM event
> and just making sure not to add new bad code, if that is what you prefer
> and I also am fine with using two FMODE_ flags if that is prefered.

So iirc we do have a handful of FMODE flags left. Not many, but I do
think a new one would be fine.

And if we were to run out (and I'm *not* suggesting we do that now!)
we actually have more free bits in "f_flags".

That f_flags set of flags is a mess for other reasons: we expose them
to user space, and we define the bits using octal numbers for random
bad historical reasons, and some architectures specify their own set
or bits, etc etc - nasty.

But if anybody is really worried about running out of f_mode bits, we
could almost certainly turn the existing

        unsigned int f_flags;

into a bitfield, and make it be something like

        unsigned int f_flags:26, f_special:6;

instead, with the rule being that "f_special" only gets set at open
time and never any other time (to avoid any data races with fcntl()
touching the other 24 bits in the word).

[ Bah. I thought we had 8 unused bits in f_flags, but I went and
looked. sparc uses 0x2000000 for __O_TMPFILE, so we actually only have
6 bits unused in f_flags. No actual good reason for the sparc choice I
think, but it is what it is ]

Anyway, I wouldn't begrudge you a bit if that cleans this fsnotify
mess up and makes it much simpler and clearer. I really think that if
we can do this cleanly, using a bit in f_mode is a good cause.

                Linus

