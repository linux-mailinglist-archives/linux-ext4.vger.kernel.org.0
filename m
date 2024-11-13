Return-Path: <linux-ext4+bounces-5124-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA79C661D
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 01:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECFEB29718
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 00:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D479FE;
	Wed, 13 Nov 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dVyy42KB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDE259C
	for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457430; cv=none; b=Av4IZJr1m+nE1bwVUCyjBfQ1Pfw0JFrDAJDywKFapgQxB05FEQspOy/ya/0L6V0hu24Ztc06S8+ZZr5B9xKVBOJOaB3eqrczMYTOQeMu+3oc+HpyJyZi0leul//lFZ9qgVyFLVCGHAiys+3x709hCON0lz6p0Wd9kRFlbbvpXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457430; c=relaxed/simple;
	bh=3EvWd7pwnGEo7dSfx/lB6lTVU0t1HY+pMEl3MV/3ACE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2Mbx7ft8A87Ualvg04Eki/1Z+9WCQCpV18LWFV/qFyG6XJxJDW9mfPPQnOTo1lfGwYurNCfSdO4eJR8ak1yDkR9NsqBXsqGP0ccbeU5p0Hbk+cSVOAFaqkeijHiYHhVYhIgXwVP4/D1b+W8egsxgWeb7hDfe2k0sAxcwVN0mVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dVyy42KB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa1e633b829so183145766b.3
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 16:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731457426; x=1732062226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WupZbUO57pzsyzLIiF16uH4yNUQCRicfvRdbxH31iT8=;
        b=dVyy42KBN5IleYK8inNxVRsLxuZR08kjcoh4pV4rIpyhjmu+jL1W/SCzsSrwdr84Jm
         R885YEu93q3OL4rRfslRR3VsBE4HNuHDWCBotU0mm6B1WrzZF84VjibgIFl/8FM5h/Xm
         iGnmMrm5f60rd6M8GCe8UJ777ETNdW0WAq2f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457426; x=1732062226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WupZbUO57pzsyzLIiF16uH4yNUQCRicfvRdbxH31iT8=;
        b=SmQ0d1Q+CN+mzb8pPL0TidtIH2AqdR7vG4iwv28MSfvpL/TBq8ePbC4aooN8f0pNZj
         m4TODuo9NkHAdQ0Jdd+ZOOf1hrzr/RY6ri3LNbwa8na83pm9IuJDA3R14wMIizMc6P/i
         RfYE3DN4pxc1GXKwspmXn3FJLJPUEpdnf+19EW6HBR3TIqmicutA90F/rh/aBsM6dksP
         osJbPP5vwZZVCE1SBCimxS/vcf4JnBqrts+hZRoP5//jOuz+VIsGG3sSZ7XAKq7/tLO9
         c6yXcCprGy/Bke5PqiOQOSKNl6YqHLx7A15hUEyv3/sNQFpY2t28CvpNPh7Q0qF7yPLL
         vYfg==
X-Forwarded-Encrypted: i=1; AJvYcCXfVcpv3H/f1SArlEhO7lPJjBAMNHKVHbtpYJuvgzdhsEtK/+7sj18T4pehrHTaDJqWO5gv5C+k0Lis@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5O2i9J5A1+zLidMIGnFGGH5b7aqVt3hM2AgubqDJJvtxr2ZiB
	S6mW//JdZqv4ZyWCGm2fG1n4oZ5V1cOO8yujHKoSehfV4ne5p/Fa7KO4xFWsyYG9GruPsLN4geF
	pj4JTZg==
X-Google-Smtp-Source: AGHT+IELOwaDp+O3czUKxn33tX86MGwizqVBor4FTwYspqE8SWX+iUqFtzOyRoVbVdl930NU/dgy0w==
X-Received: by 2002:a17:907:26c2:b0:a9e:c442:2c15 with SMTP id a640c23a62f3a-a9eefff1869mr1877143866b.38.1731457426492;
        Tue, 12 Nov 2024 16:23:46 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17624sm790703366b.24.2024.11.12.16.23.45
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 16:23:46 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9ed49edd41so1073962066b.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 16:23:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoYy5oiH+Hx+z4Z2KSLhi3U5Kfyzjld4cYFVcKLeXjMe/092urXqeDPoIwMoAEpNO7HZZ3x8RlB3Sv@vger.kernel.org
X-Received: by 2002:a17:907:94c4:b0:a9e:8522:1bd8 with SMTP id
 a640c23a62f3a-a9eefebd13bmr1910160166b.6.1731457424914; Tue, 12 Nov 2024
 16:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com> <20241113001251.GF3387508@ZenIV>
In-Reply-To: <20241113001251.GF3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 16:23:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
Message-ID: <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 16:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Ugh...  Actually, I would rather mask that on fcntl side (and possibly
> moved FMODE_RANDOM/FMODE_NOREUSE over there as well).

Yeah, that's probably cleaner. I was thinking the bitfield would be a
simpler solution, but we already mask writes to specific bits on the
fcntl side for other reasons *anyway*, so we might as well mask reads
too, and just not expose any kernel-internal bits to user space.

> Would make for simpler rules for locking - ->f_mode would be never
> changed past open, ->f_flags would have all changes under ->f_lock.

Yeah, sounds sane.

That said, just looking at which bits are used in f_flags is a major
PITA. About half the definitions use octal, with the other half using
hex. Lovely.

So I'd rather not touch that mess until we have to.

                Linus

