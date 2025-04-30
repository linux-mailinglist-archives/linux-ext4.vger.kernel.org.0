Return-Path: <linux-ext4+bounces-7587-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9ECAA5440
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 20:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2531BA214B
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4437263C7F;
	Wed, 30 Apr 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abZEbpQA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41822DC791
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039361; cv=none; b=YY7S+yq2z0RPfS5DiF4uz1dyF0X9NdQ7xD2bcDLnbkGuG7D4cC9Po2QTqmwhod4+HwPuOgvFzhTK+eq1sq2asNkhsghi7uoHAm4+9HUbcBbTnCtKSSDrNszcM3BiDcx1fOToTNPnLHuBajRheaM5RzXUx9NLj+WGgtA+gjmKT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039361; c=relaxed/simple;
	bh=PJG1C1wqXi9ts1dXrAvRyq2doB2BH88T233LBkM4b5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ8AUUb0R4RDRQ7GFDgNpXbDUSo3jhQoTYT6l3PmhycWC2oOGf8xBz599ymZRxlbSlk3M5IZ+6NlqCRN7W4iKh/PM0U86vRJ5WY+olcI9e+5eggoEUHEHJPq11BcP65BPSrMb8Z4SwFlaa9Rp9qez16ph8qP3m2AkBUbKtpmSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abZEbpQA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so1367845b3a.0
        for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746039359; x=1746644159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B0Sx117SregVeDKFzObe1oWNVZKAPXTD4QIH/pxJu0=;
        b=abZEbpQAMQ8JKzV/grKDfcvR47Ybx4uQM97j5keSMtoEpwMeFHsyaekuCDF4n/2qbx
         xWxwedRAtQiXOeTKU+68vydiJ6YEgHZXS8vJeu99sePhEPUJwueVgi1CfAuzPQZNLcUG
         JV5so5ZytoCJ3FbW6A8dx2Id/ZqlHPYJ9iADUMRvvgrjwa0WiEbNTlhy6Reex3k4UjBr
         UTmKfjDs6L3a+QO54pvcpsLEn2VPXKrzP6pwDVZ8d84Q8vVnZwiG+FjDQriLLixLXhM7
         Jao/RxfuSh96M4uhdPh1DlthAedDIS0VjzzVSx7+HVX49p/wN9kWG0di4ooKm3yMP4Jg
         nm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746039359; x=1746644159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9B0Sx117SregVeDKFzObe1oWNVZKAPXTD4QIH/pxJu0=;
        b=fVRix0EBdcMxyclVOQeguOlQJNFYHBQZR+XShUxDhxftS+/W2lZR6Sfww821BBWOPw
         xsX0j4jhLf63rdiWVF+Nn569RWM8ZoSxrH+u1CyzAia0EHQlHInao3tFQGVNB4VSLuuh
         huZD+CSaMcgls4yzrbAPAw63nlf1EtS9Xed3zlWOivnJx+i40sCsBK+j+QHEsHKe+tF9
         pfKQQq4FCVREFLq3xPEEezAWwX0KWyp6GYfA0e5PLD3AKYu1Z0l0Qd120OkpdiB5wGYn
         C0FkfTN9RfK1B0UCNIRhzVojbz9/b0RnkiXVEZR8iA/GvM9QnUl2EM/xGooyduRrpiex
         F4xQ==
X-Gm-Message-State: AOJu0YxtQTFw1mY/tjL3vu95C3w9WVig3sdFQ6MMJTfhDvGka+aPKMPH
	BUuiImRBPSGBO8e1CQa3lNmiEVrb435Cr9yl18OUvdyEriepYvgewIFS+VKRODeXDIobrvDsd1M
	I7VAwG6zc7V4gW42ogXC9/yBhbJ0=
X-Gm-Gg: ASbGncvuJpEjwGrkp9NS+ywNjJ1BDYuscyGBmRtxYkADbzbokXb2W/+IMQcEV4Zekh1
	qj0UkM0gYO2E6q+A/EjGa9IdBRyrcxXfF4gd4Ik5DxJpZqdQROVWtXuDIAgwQma2zMRqts+ZgS3
	Jhw3kNdzsTcwAwIPGVIw0B/kMZCtw7oLCl4n+pvwYy8CcvZfaEmbwcZr+o0xWEvA==
X-Google-Smtp-Source: AGHT+IEB0C/jdhCd4HpWtVN+1Tm9FL+qUj0jGzVk05iLingu6VLkZMIiuuH2VFvcz1mW7lwnuDfIwV37IEw6wUOVbOo=
X-Received: by 2002:a05:6a00:38cb:b0:736:5969:2b6f with SMTP id
 d2e1a72fcca58-740461715cfmr626338b3a.6.1746039359058; Wed, 30 Apr 2025
 11:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414165416.1404856-1-harshadshirwadkar@gmail.com> <20250424145911.GC765145@mit.edu>
In-Reply-To: <20250424145911.GC765145@mit.edu>
From: harshad shirwadkar <harshadshirwadkar@gmail.com>
Date: Wed, 30 Apr 2025 11:55:48 -0700
X-Gm-Features: ATxdqUEF-SIypyClOBs3sEvKKMNKYj-GFhKrN96HlTWYDDYtuciRC0f3j2Aj3Cw
Message-ID: <CAD+ocbzqihJidUkanZLwUfHFNyEs0SO_Tbx4ABr_9W3dRVbArg@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Ext4 Fast Commit Performance Patchset
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, jack@suse.cz, harshads@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ted,

I tried to run this on my end, and I didn't see the errors that you
pointed out. Here's my run:

Failures: ext4/049 generic/459 generic/506 generic/645
Failed 4 of 553 tests
Xunit report: /results/ext4/results-fast_commit/result.xml

END TEST: Ext4 4k block w/fast_commit Wed Apr 30 18:15:26 UTC 2025
-------------------- Summary report
KERNEL:    kernel 6.14.0-rc2-xfstests-perf-gff9ebf4dde0d #31 SMP
PREEMPT_DYNAMIC Sat Apr 12 19:35:39 UTC 2025 x86_64
CMDLINE:   -c fast_commit -g auto

I explicitly also ran the tests were causing error for you and I still
don't see any failures:

Ran: generic/127 generic/241 generic/418
Passed all 3 tests
Xunit report: /results/ext4/results-fast_commit/result.xml
-------------------- Summary report
KERNEL:    kernel 6.14.0-rc2-xfstests-perf-gff9ebf4dde0d #31 SMP
PREEMPT_DYNAMIC Sat Apr 12 19:35:39 UTC 2025 x86_64
CMDLINE:   -c fast_commit generic/127 generic/241 generic/418

Maybe my patches are conflicting with some other patches that are
being merged? Let's talk about this in tomorrow's call.

Thank you,
Harshad

On Fri, Apr 25, 2025 at 5:41=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Mon, Apr 14, 2025 at 04:54:07PM +0000, Harshad Shirwadkar wrote:
> > V8 Cover Letter
> > ---------------
> >
> > This is the V8 of the patch series. This patch series contains fixes to
> > review comments by Jan Kara (<jack@suse.cz>). The main changes are as
> > follows:
>
> Hi Harshad,
>
> I tried applying your patch set on top of 6.15-rc3, and a number of
> tests: generic/127, generic/231, generic/241, generic/418, and
> generic/589 are causing the kernel to OOPS, wedge, or reboot.  Most of
> the test flakes and test failures were there without your patch set,
> and we need to figure them out.... but Errors are new, and are
> regressions.
>
> I can send you the test artifacts under separate cover, or you can
> just try running those tests using kvm-xfstests or gce-xfstests.
>
> Thanks,
>
>                                                         - Ted
>
> TESTRUNID: ltm-20250423233632
> KERNEL:    kernel 6.15.0-rc3-xfstests-00009-gac4ab1811bb3 #22 SMP PREEMPT=
_DYNAMIC Wed Apr 23 14:28:04 EDT 2025 x86_64
> CMDLINE:   --kernel gs://gce-xfstests/kernel.deb -c ext4/4k,ext4/fast_com=
mit,ext4/fast_commit_1k -g auto
> CPUS:      2
> MEM:       7680
>
> ext4/4k: 587 tests, 55 skipped, 5243 seconds
> ext4/fast_commit: 602 tests, 20 failures, 3 errors, 55 skipped, 4564 seco=
nds
>   Failures: generic/506 generic/737 generic/757 generic/764
>   Errors: generic/127 generic/241 generic/418
> ext4/fast_commit_1k: 616 tests, 39 failures, 5 errors, 59 skipped, 6169 s=
econds
>   Failures: generic/047 generic/051 generic/455 generic/475 generic/506
>     generic/757 generic/764
>   Flaky: generic/627: 80% (4/5)
>   Errors: generic/127 generic/231 generic/241 generic/418 generic/589
> Totals: 1805 tests, 169 skipped, 59 failures, 8 errors, 15637s
>

