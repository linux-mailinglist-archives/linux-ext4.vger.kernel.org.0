Return-Path: <linux-ext4+bounces-5126-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321209C665A
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 01:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC457281A36
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 00:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6651805E;
	Wed, 13 Nov 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WrAMPD0h"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB8BA20
	for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459511; cv=none; b=YHTzKyulaoLbaBSkSUNXCfhC3wIxcv7xLLStt0N9lxAnOf2dZ40JI87JibY0lqV7UJsA1EswAH2ff1O7ekr3H9gzK/jgXH+p+E7xdKogsQ+h0XcEcONrw9pSFizv7X9mlHwvMQXjo3zyUf5qfARpgNT0b9GxDcK7zTF5xMWgbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459511; c=relaxed/simple;
	bh=n3j6hYJca3iK+8w4R60+GpDVT4tBx8PgHWEo86e/9FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dL654xbiWwU7bGxfoFSEJSC1xyCRtfeBx9vQ4T2x2eqfKvFillNFLg6SrLEvm5KS1d2QnnvVr2nEPkxkhJWvBniWIKwiuoJooJTN8Ctf1v6AKdIkPiBnn342w3aspOGI55GAXWtGiIBIxv7/0EvAmnnPqd2UHpgm+y9hFN3ldV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WrAMPD0h; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9eb3794a04so910144766b.3
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 16:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731459506; x=1732064306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tJ813zBq+G2Ew0iXW8JEVhQMVvtnrBGzEzzKoVgMoc=;
        b=WrAMPD0hBykJQg5vXL1ugr1Wt/FYOZNNQoH5TUoTzUZs90nZSTTil62NlehgKVoP1u
         OUqCX1u/q9GGrE8+qVutYWvdZmZ8e4vt1YJfyrRGHxvRgU3SHzsSg626TwsYQKqWtg58
         VZ5Fa6r/A24apSR/G5ihzY1GlQx9GqKL0laeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459506; x=1732064306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tJ813zBq+G2Ew0iXW8JEVhQMVvtnrBGzEzzKoVgMoc=;
        b=BSdSSLVtImC48Cp9Gh5gzgWl8VcL8K0lY7zDdbJtg9j3Z/jaWTydbMuxC4A3gQaJmu
         9twl+reN2hzAFcA8kFqrq3Io3E2phs+nqtqRxKFYVL1tELh8Qe2AHlPNx5D9H+xTOle+
         oRhsVU23Fh8nqbFuel05sLMPUl16nBzi7SuP6dpS5RSZuyQvDsUI2T+InpjRFheLwN2r
         tjTDbU8syU/wAX1gUaUKntytM6mpmYu6byQi47f7icPvOZZ5DiqoETXTaH+5/SKWTFkG
         xoPvxkRawyIK2usdiSxWczdbVu8G0X5wWwEHITWt6yHWE+NdBeq5sSVqLnIttTbGCU7h
         q3DA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Mjaw5zrghhd896oOSseok3uQCkXRWYHPEwwkTqFnaghECO1oo1Bg77gl98WEYUC61W3zvhThZFce@vger.kernel.org
X-Gm-Message-State: AOJu0YyjfbON70CmEyA1ZEqASaTDDiFrRI4Bp8Ri43nfCp4b+ZMRgbbx
	4QTD6ScWCMiePiR5GU4xGIk6TFFV4aZ20ogG/5Wr/z0/LX5xDAz8Id6E25/X21pIgNWnbJfIwfY
	HIzf0hw==
X-Google-Smtp-Source: AGHT+IFyb8RDMlBpPUKyyJW3rfIwGVOK58A+uuamleZnsg74wGMjfWTkLg+9//GArUw8Wfg/oyzHFQ==
X-Received: by 2002:a17:907:60d1:b0:a9f:508:5f5a with SMTP id a640c23a62f3a-aa1c57afceamr473975666b.40.1731459506212;
        Tue, 12 Nov 2024 16:58:26 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a46119sm786039966b.46.2024.11.12.16.58.22
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 16:58:23 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so1063652366b.1
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 16:58:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnqR/e+Q15NjEMWN5OgNG0wxoug8wISE1ZizNR+72To4WyqL/jbY9sAjCpmGzxwGMf05gOG+9x9ez5@vger.kernel.org
X-Received: by 2002:a17:907:1c11:b0:a9e:b08e:3de1 with SMTP id
 a640c23a62f3a-aa1b10a9779mr425956266b.36.1731459502310; Tue, 12 Nov 2024
 16:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com> <CAOQ4uxgakk8pW39JkjL1Up-dGZtTDn06QAQvX8p0fVZksCzA9Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgakk8pW39JkjL1Up-dGZtTDn06QAQvX8p0fVZksCzA9Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 16:58:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMy72pfXi7SQZoth5tY9bkXaA+_4vpoY_tOhqAmowvBw@mail.gmail.com>
Message-ID: <CAHk-=wiMy72pfXi7SQZoth5tY9bkXaA+_4vpoY_tOhqAmowvBw@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] fsnotify: generate pre-content permission event
 on open
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 15:41, Amir Goldstein <amir73il@gmail.com> wrote:
>
> You wrote it should be called "in the open path" - that is ambiguous.
> pre-content hook must be called without sb_writers held, so current
> (in linux-next) location of fsnotify_open_perm() is not good in case of
> O_CREATE flag, so I am not sure where a good location is.
> Easier is to drop this patch.

Dropping that patch obviously removes my objection.

But since none of the whole "return errors" is valid with a truncate
or a new file creation anyway, isn't the whole thing kind of moot?

I guess do_open() could do it, but only inside a

        if (!error && !do_truncate && !(file->f_mode & FMODE_CREATED))
                error = fsnotify_opened_old(file);

kind of thing. With a big comment about how this is a pre-read hook,
and not relevant for a new file or a truncate event since then it's
always empty anyway.

But hey, if you don't absolutely need it in the first place, not
having it is *MUCH* preferable.

It sounds like the whole point was to catch reads - not opens. So then
you should catch it at read() time, not at open() time.

                Linus

