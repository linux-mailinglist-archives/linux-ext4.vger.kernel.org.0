Return-Path: <linux-ext4+bounces-5146-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5A59C7EAF
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 00:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364F8B2326B
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 23:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C113818C344;
	Wed, 13 Nov 2024 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c+fjZKm8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643518BC2F
	for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731539280; cv=none; b=icpqmuWJ2R8fgUmjOQcHv2qMSYbPrwHcVry1bE1nSJg2j+YcL1cyirVBZ6DFbSj9VCL+bXXdE6ivCyQU2lwUWZY6oMYO+PbAg2XLzDhkw2GSuirzJ+Pj2Cv0xrG8icGXa4pW1tSSC4SO6OcIxRiySP5gYSfH7MCABTxHRdSqeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731539280; c=relaxed/simple;
	bh=/tltkOoQpP8bcM74mMy2gPuKWTvbxMmV0LsxinTpOwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4eG1G2hiKdctOasuszFggqybY3mPvT5j0kJLhhSNfmHrP5mix1F2LuGaDoCIx+4xbAfgdIPTjlM580nDu0KUJhjgbrNYyTZuTKq/knVPDPYWumz2Z5xP+u4eRro6B3i3c4Rph89d92slXDrBITyCESPYosIhB/a+z7nEQee2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c+fjZKm8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9eb3794a04so9142366b.3
        for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 15:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731539276; x=1732144076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3uMAHPF1ytklJO173iJZDrJhJUNgUA50IG0+xtq7Xjg=;
        b=c+fjZKm8p3UEZc0j7u89ojYhXO/bX+KAVKzzCsxemjYevPZn5JAS7h8lYsaomNYGmB
         T77nAEwb8LdmBztPo1lpBo5HtLLgSoMOHz0w6KSm4ohWzXQ9FpUDNdWHUIIvp85peqPi
         hYPh6upICpbrrxfJcKEBLLg6FgbeK5IPhWrRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731539276; x=1732144076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uMAHPF1ytklJO173iJZDrJhJUNgUA50IG0+xtq7Xjg=;
        b=DSBQBIS72rsT3D858bGQ6piUYqjHEe6Clp8U5xzRubFU/yQmrphK05GYOHthRUam3T
         Vgllcq9zVKb5veCziGLeyOQ3I3StM8GHZ700Pnpn9K58pTCI4eInm6TYe21qR1vHlYSM
         GRf4JbQJKMnYyPOa58NGIj4FWC1bCJZYBTaN+UN6PuvCFU584ZwkKJAbrgwzh2WC7oBH
         A9Nyjhhf+Mm92bPxvW8DPuHmOgkZPbQiND6U4fxhZT0SD3LoMNDg2vWox59T010m08QO
         s+xNP5BXVl58tCv9T3D4/z4kAJ545oZk/W81cLNnYkjl+HuhlJvLkz9CEqIRpRbx5DWg
         KgkA==
X-Forwarded-Encrypted: i=1; AJvYcCUbaT10474nX4FBIYl5KxZq7EsCtqRsI6l096DqVvDZ97DqgYwQ4ftNl+1QBh1nzQ2ZzgvIzZOQKZmt@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+krFHkDmRqLJFiQP3eQarmpO0Iy531a/EycozXSquT9gzsr9
	EMo5uFojzQ2YQI4k3X6kRhCmDiDafcx2j5j4pwPwwrxJoVJQqc9KAnvT7wC7nuIqT5i6wdGhJAH
	+SaI=
X-Google-Smtp-Source: AGHT+IGzhB4S8w5MTMKYFhBt0TnSD+1fg31nH0gHrD59RSyPL8kX0x+/gRNBvKmIEEuu8I2NhmbONA==
X-Received: by 2002:a17:907:31c3:b0:a9e:b471:8006 with SMTP id a640c23a62f3a-aa1c57afcd8mr762117866b.43.1731539276567;
        Wed, 13 Nov 2024 15:07:56 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc5068sm929867866b.116.2024.11.13.15.07.55
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 15:07:55 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so11340984a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 15:07:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXl9cJss3vHopTrGi7n/qca/jK8nuNE3JqYhIi3gfvik5sVwxttFVwInIVwHRtHEjXrUwcYAzFOeNbo@vger.kernel.org
X-Received: by 2002:a17:907:5ce:b0:a99:5234:c56c with SMTP id
 a640c23a62f3a-aa1b10a372fmr767667166b.33.1731539274832; Wed, 13 Nov 2024
 15:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxjQHh=fUnBw=KwuchjRt_4JbaZAqrkDd93E2_mrqv_Pkw@mail.gmail.com>
 <CAHk-=wirrmNUD9mD5OByfJ3XFb7rgept4kARNQuA+xCHTSDhyw@mail.gmail.com> <CAOQ4uxgFJX+AJbswKwQP3oFE273JDOO3UAvtxHz4r8+tVkHJnQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgFJX+AJbswKwQP3oFE273JDOO3UAvtxHz4r8+tVkHJnQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Nov 2024 15:07:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTEQ31V6HLgOJ__DEAEK4DR7HdhwfmK3jiTKM4egeONg@mail.gmail.com>
Message-ID: <CAHk-=wiTEQ31V6HLgOJ__DEAEK4DR7HdhwfmK3jiTKM4egeONg@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 14:35, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Sure for new hooks with new check-on-open semantics that is
> going to be easy to do. The historic reason for the heavy inlining
> is trying to optimize out indirect calls when we do not have the
> luxury of using the check-on-open semantics.

Right. I'm not asking you to fix the old cases - it would be lovely to
do, but I think that's a different story. The compiler *does* figure
out the oddities, so usually generated code doesn't look horrible, but
it's really hard for a human to understand.

And honestly, code that "the compiler can figure out, but ordinary
humans can't" isn't great code.

And hey, we have tons of "isn't great code". Stuff happens. And the
fsnotify code in particular has this really odd history of
inotify/dnotify/unification and the VFS layer also having been
modified under it and becoming much more complex.

I really wish we could just throw some of the legacy cases away. Oh well.

But because I'm very sensitive to the VFS layer core code, and partly
*because* we have this bad history of horridness here (and
particularly in the security hooks), I just want to make really sure
that the new cases do *not* use the same completely incomprehensible
model with random conditionals that make no sense.

So that's why I then react so strongly to some of this.

Put another way: I'm not expecting the fsnotify_file() and
fsnotify_parent() horror to go away. But I *am* expecting new
interfaces to not use them, and not write new code like that again.

                  Linus

