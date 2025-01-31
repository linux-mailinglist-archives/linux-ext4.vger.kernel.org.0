Return-Path: <linux-ext4+bounces-6280-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F7A24394
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jan 2025 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5323A2A30
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jan 2025 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47A1F37C0;
	Fri, 31 Jan 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dPlLFIfM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C1446DD
	for <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738353618; cv=none; b=s1OsG2/Rr3x9rVmlAqOgD5NjJk3ZJ7vb0ceXi080hyX6pACR9F78ofN6WkH7Evv5nVCyQFgfCJdmFoBElqDRivwF6SAZ8OvOBjGzaUOToYbjpVUS/UMSdZcQECpxAtvEZjI2vqDVjNVvshM6Z7lLUen+VlgN521h7KhxRdwsR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738353618; c=relaxed/simple;
	bh=mESJj9WNZAGhoP88PwXyk6SgSBIq1RXBtiH16frMzTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tO+H4cJDKN71dK0do+TWLkEBH139qTzkd3L7Bocg+q2UMe93On2rQLvQ0zKNfPkG7kKR+BCpqI16T4CttAy8BhnDzEcQnoEV6YcDl33djhbRFj7Ic7cuWc5SWr+ej+WkaHMzOz+9dZdftZ+ZivzHYm2pMWyEk71UWXVEtfDFHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dPlLFIfM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso495836466b.3
        for <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2025 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738353615; x=1738958415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1VEMyzp2lsoEGf8wTQK/Tt97K6OMqjZreNFMoOiXZ5E=;
        b=dPlLFIfM+G/lEDPwPrinoJPSTGpf/quSRFWlHZwLTfO2iIdxA1VWUpZebWr1yuf6iz
         BdarU7DO0Hb/S0/QgTkLF6DNa6P/F7NxRb4FSHpoGRZw37Dc9Ya+o+M6mn6SCk0kcGCH
         7L39NJQjtPl8SwHIqLDrbq7guSpa8Iyio6i90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738353615; x=1738958415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VEMyzp2lsoEGf8wTQK/Tt97K6OMqjZreNFMoOiXZ5E=;
        b=vEO0klcBDq3ddbNersdkRPClEYIojKRfzlkScteDi0r+j2QS+Kh9zyQ5gmJZzk7upm
         T7QFjGKrA2sKKP2VBKDoKFlHAldhZU1cN2saqRy4qxHqTSq4mLUfVzhKRHwE6FR0dU8o
         deeIDT13inkq5IhrlhWs9FwQnpJCBseF2z4FF4FkSAqtWjkHG2aUu43ombOVqklbxWHE
         5h0SvOMgQ+9RF+J0dvl7jENfSEqZ/j8yJnjGC7IXuu8sQ4qHluyaWmpgbBb42GQuYDdi
         QbU1Axb44Cz5e9w50fzMQBlRcjOgWk0vAx9rnceU8KgqcHbXpNHvmHv2zP5rOsJ4OM8a
         91LA==
X-Forwarded-Encrypted: i=1; AJvYcCX/SDQGJ8JA1aIUx61NW8Jz7c0I3mtrnWzNC2yiuxXAbqDYBz8FdlPVgQaVii8DT2D5erJavOt8PAZ/@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzPXMlnbmmARO7RVw2BPiR2k9IbcK4nD5od6MEjnAB0FrcRL+
	1tIsy5D3RJi9zcpD2da3WuffOB2TpsujqHtEzCgweUjR7gTKGMlpZKgA5Hq552Uf1xq0T2UBw3G
	/bqw=
X-Gm-Gg: ASbGncsZhCO2xpXLqAM2BzlqQQkx6oB+FfDOY9NXaoNY3r8TZBGPdJyiWUL1bCSELW7
	h/dhw2+Bau2G3JhHlwOrjIy8Zm+7OnZZCLl5n3rddJYtnh5AaJcJTsAwR0TKEpFPfDtEs1+jkSQ
	XR9R9MjtxKvwZyFwV49sDoeXqonB8lPgGwhp0ett34ydNkiZ9aJ1D8GTvYXi9KyjLezaJNZ0ohf
	w442DYzfFIc1k34MkG2309X/XvSuWZKcP2yEEmO3505KuM6Chov/dJmonWbbaBBP1L07HYpyE9t
	uAuOmwJ3t6xUsM850IOwzCijux5jDZ7Vu9pZhJndblAzc96TND43wfqfMVKFQdgslQ==
X-Google-Smtp-Source: AGHT+IHigM1lWbx/t2WSAERaGMzKL7lFFTwoV9SDeNgM8Ks8p3MU+qqwD024D3zvUsIGNL5+9qdJsA==
X-Received: by 2002:a17:907:8688:b0:ab6:dd72:7752 with SMTP id a640c23a62f3a-ab6dd72779dmr1081389166b.6.1738353614574;
        Fri, 31 Jan 2025 12:00:14 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff77fsm346022866b.108.2025.01.31.12.00.12
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 12:00:12 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so3949288a12.0
        for <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2025 12:00:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcwE/MjjNu3t4W4TlTwa3h/82nGwY43J9lQosbvDYlnQBrTPjrrMBD7S0hz4IjWgstJVlQnWGoWqWi@vger.kernel.org
X-Received: by 2002:a05:6402:2709:b0:5da:1448:43f5 with SMTP id
 4fb4d7f45d1cf-5dc5effcc33mr12325224a12.31.1738353612239; Fri, 31 Jan 2025
 12:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com>
In-Reply-To: <20250131121703.1e4d00a7.alex.williamson@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Jan 2025 11:59:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
X-Gm-Features: AWEUYZmJHVy_un_wj0EXjvnXlSLyiKtpaVCBTRVD7w7Khb3Vui_AFXvwFXKGqO4
Message-ID: <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults for
 files with pre content watches
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, amir73il@gmail.com, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, Peter Xu <peterx@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jan 2025 at 11:17, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> 20bf82a898b6 ("mm: don't allow huge faults for files with pre content watches")
>
> This breaks huge_fault support for PFNMAPs that was recently added in
> v6.12 and is used by vfio-pci to fault device memory using PMD and PUD
> order mappings.

Surely only for content watches?

Which shouldn't be a valid situation *anyway*.

IOW, there must be some unrelated bug somewhere: either somebody is
allowed to set a pre-content match on a special device.

That should be disabled by the whole

        /*
         * If there are permission event watchers but no pre-content event
         * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
         */

thing in file_set_fsnotify_mode() which only allows regular files and
directories to be notified on.

Or, alternatively, that check for huge-fault disabling is just
checking the wrong bits.

Or - quite possibly - I am missing something obvious?

             Linus

