Return-Path: <linux-ext4+bounces-7258-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EE1A89996
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Apr 2025 12:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8E13B8CCE
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Apr 2025 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C34125F99C;
	Tue, 15 Apr 2025 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVJJvGpG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED425A79B;
	Tue, 15 Apr 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712042; cv=none; b=bCuifCvzZ79SNT0XJUJ5lzTUXxKpHbgJ+NZPnyHOA5BtxKTxMcRpgV+ylYcRcbCBz5ApqKA+seiI7AYXlTgT31xZLyF9nqLaEqdjiqIBXK6xwpQs0REMD5nSGj5PxKc0QkLSRkOGIzCa1oM+Usg8uEYtsdY9mDSfYXqJe3ebk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712042; c=relaxed/simple;
	bh=JuBCKkJaM3hmsEjaT1kgYwdjyRkGh72CJZBJOY1YxDE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=QuoV67u8xn4aG9kCN3yfmyrOItcU/I0xwWgaiId38E0ownn1smL58u4heZYVOq7hqx9qW6jWPBzPuwYDewJ2iFcPCG2pomiLBTxIX9ZmGp/+vDSuiphZoB2MBL+fOmKADOLWnKCM3jF8TlRUNLMB+2rpIjNVaA/JiQAUg6+I02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVJJvGpG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240b4de12bso72081305ad.2;
        Tue, 15 Apr 2025 03:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744712040; x=1745316840; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2yat5Q2ro2VdU/edk/vSlsoVMBmysgz9dlNkdYrGb7g=;
        b=MVJJvGpGwUhog0gLulETz4MH8KBqe69j7XeMNDQCsH4Y+30t/zBw8SUvz7d4m4B8xX
         Gc7AYwmgioK0X1ItXMEOTOsVQ792F/jV5QHHQGJM+0BsO2stkoKSV5ScNK2W8jMoB2gk
         OhJkI1p6JlRG5KRiLqsDv4iLlq0J7o7XH0p5h045e1i+KuggfxPW75I1zPJOzN4dh68e
         2Q+Nc6GBX8HTvxLG/MGEmmdV0rxZ1Pz3yG9krEMELtAbMkDG+/+D01/JfsaP7VnCkGih
         EU0pU3WdNjeVzBUvcH/8k1n3S0E10/goLaL4WopoVI7okXfCIRbsBWgakIhRnB76Bhxv
         9i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744712040; x=1745316840;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yat5Q2ro2VdU/edk/vSlsoVMBmysgz9dlNkdYrGb7g=;
        b=eqmUI7EjAjx1RgqjwCmVE8kVanGDR0o9TNEUm3/+KZ3CdwS58FmBt8qeBAvAkVMMAX
         Ojaoe6ynXP5lagi+qXJGm1uXwv08XkBwWV+91/nMbyWsOiN12yEPAKUpxVvVP3Y6ibiw
         Z/tB2YsamFQkISsHn+9bwI6POzDqg6hufKlYgeDnE1hSMo6WvW4rQa39xV00EkYUp7WH
         lotdjtvHVkFVh4KUjg0yhw97uUcFv4jKbWtMdEdpQy/uIiwCH2t/IofhW11J2w+04EwL
         x6LIW7jVZ6/Fem6zKx0qw/t184tNVv0DlaWaW5Sapg5AqH5ti8gQ2Ha5ka+bnjzqcnii
         NkGA==
X-Forwarded-Encrypted: i=1; AJvYcCUUyjK/QSqFkarrq/CzCENxvZcci4lqctLOX/UHdLp3/3zaB1NOeloyFtXQUxP1FnxwvBvKknTEUdy+@vger.kernel.org, AJvYcCWs+jcjpPxWZLbp5slWcWeHQkgdSo0cj0Ar62u+8gIH92EmkGNCk3PB5FIwwmOvqovmnMXYj696uDnP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5QuhPQUrUcE/KhdDX872jhotC0wJwosmxrk736d1rER4cqEr
	75uNwXkAGROJj4Y2wstbm6wy9B6QCchA7dYJkvD3o7B/ZQ/lgVl9
X-Gm-Gg: ASbGncvoj84b4KTOJIHfh5aPWjP9TL77hmQaw6EdYmQeb5DHTWqqLZjiXrUDLO61tkB
	OTfPMAJqe/SZIJaivEs/b2c9oK7XDKroDOLQb/mNs9HG0d+SuaSSnmIcQbjlKwdvwJTMg7Uj/17
	+SvzNPDzGpfgmuU+A2Mew9PtANQj9XjLBojpCBtFVWYdaC1iMzm+sE8sfSznc+s78povdEtfNVt
	CKWP2ixQ2FOPOy8oWreZCNTFzGGzkEPciKVXiit6eGWK9JkIiL0PRopWMvn8H7fZINPkkSAGepx
	tvV2knU6LVZC9SeowuEw/hSVe3WPxcBVbg==
X-Google-Smtp-Source: AGHT+IGVfEllxuwtyc1XzUKuSeTGsI+WI4RmVEcc1rP4Bl/ErN+obxeqncn3zygjzpfF9fdhNzIJoQ==
X-Received: by 2002:a17:903:985:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-22bea4c6897mr227721835ad.26.1744712040529;
        Tue, 15 Apr 2025 03:14:00 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b62943sm113511595ad.28.2025.04.15.03.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 03:13:59 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>, "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 2/3] check: Add -q <n> option to support unconditional looping.
In-Reply-To: <20250413214858.GA3219283@mit.edu>
Date: Tue, 15 Apr 2025 14:36:06 +0530
Message-ID: <87ikn523r5.fsf@gmail.com>
References: <cover.1743670253.git.nirjhar.roy.lists@gmail.com> <762d80d522724f975df087c1e92cdd202fd18cae.1743670253.git.nirjhar.roy.lists@gmail.com> <20250413214858.GA3219283@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Thu, Apr 03, 2025 at 08:58:19AM +0000, Nirjhar Roy (IBM) wrote:
>> This patch adds -q <n> option through which one can run a given test <n>
>> times unconditionally. It also prints pass/fail metrics at the end.
>> 
>> The advantage of this over -L <n> and -i/-I <n> is that:
>>     a. -L <n> will not re-run a flakey test if the test passes for the first time.
>>     b. -I/-i <n> sets up devices during each iteration and hence slower.
>> Note -q <n> will override -L <n>.

First things first -q is similar to -L except that it loops
unconditionaly even when there is no failure. (Bad choice of -q naming,
since -l was in use for something else)

>
> I'm wondering if we need to keep the current behavior of -I/-i.  The
> primary difference between them and how your proposed -q works is that
> instead of iterating over the section, your proposed option iterates
> over each test.  So for example, if a section contains generic/001 and
> generic/002, iterating using -i 3 will do this:
>
> generic/001
> generic/002
> generic/001
> generic/002
> generic/001
> generic/002
>
> While generic -q 3 would do this instead:
>
> generic/001
> generic/001
> generic/001
> generic/002
> generic/002
> generic/002
>

Yes, that's correct. Since it iterates at the top level, it also sources
some common configs, re-formats and does a mount re-cycle of the scratch
device during each iteration.

This mostly should not matter, since each test can anyways re-format the
scratch device when it needs to mount/test it.

>
> At least for all of the use cases that I can think of where I might
> use -i 3, -q 3 is strictly better.  So instead of adding more options
> which change how we might do iterations, could we perhaps just replace
> -i with your new -q?  And change -I so that it also works like -q,
> except if any test fails, that we stop?

I agree that in this case it make more sense to replace the underlying
functionality of -i/-I with what -q <n> is doing here. But maybe others
can comment, if anyone has any objection on this.

-ritesh

