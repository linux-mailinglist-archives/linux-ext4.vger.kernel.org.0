Return-Path: <linux-ext4+bounces-9904-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 231DCB51DBB
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 18:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4AE3A94B1
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0613375AB;
	Wed, 10 Sep 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lftCrs9k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070F322DD4
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521772; cv=none; b=WENL/zSEHCkVKdWurYyHTPB64alNHgJ9Ym76wUNd5IloxkPx6iaFC3jBc34TPUycDtLbcPwqgIZb5CjMFyaHxaODxeY4SAZmngtH+emG5lGO+k8dC5F9uEcOcVwiQQfFtpZGlOsDB+houGqVJpyRb4KbKh7KKXzkwOkmUiShkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521772; c=relaxed/simple;
	bh=yZYH92cSVk0Fokdd/F5dyEU1ZweIT2DNcMnk5Xe6iIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvJiPhcSqexE/2ERr735ReyU6oKObYVmZq2zHBwAXmvsiPYzD3GYlL+KeMNhddMZKo1u3ocu1EoOlVe0AFX9Rvn2eEQU5o4ePg6ce57Pnv7FIb0dKAFt+eGe6LQZlg3kWu2EgKi/n0YZJoVprtFaYIglHLyvWmVOvyoP42RA/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lftCrs9k; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so8210987a91.2
        for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757521770; x=1758126570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZYH92cSVk0Fokdd/F5dyEU1ZweIT2DNcMnk5Xe6iIs=;
        b=lftCrs9kRKZ278NTmDciCM+a/ePBdFlo0TqN45wixbQd8o2EznEvSpH392azJCRaLF
         aq+pSDRAo7MMZ02IEKJ6K/1BZGZlhiQ1DNThxLSUk4eo8c4urql9k6G35kNUkHHp1KT8
         /qYVItm6lLHYCLcria4M2oyQqe29DtS47YRklhMIvpFlsIj+p4PUcWRrTBUduGbfPzqW
         NKi5+jG3YkeG2gcToJ0fPUL/o+T6ZU07gEImSabkVwqKGRC5Zt73CwvSAwz1LBMX2h7l
         k7ZN2s4OXj0J8korghA+F7CWqN3B354XUo+lagHra41WAZI7d/1HHJR32NBmo9RQtXZa
         VbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757521770; x=1758126570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZYH92cSVk0Fokdd/F5dyEU1ZweIT2DNcMnk5Xe6iIs=;
        b=RKORhVrYIRlB/P4fPHSatDoR4uRvFzbOaKifyrkTxfmuDzpYREWXiR6Z2fpNQGZ4za
         +TymOLIcJSq1ntFuYB2TVeu/Gt3J7o35639/IyNuWuh6d1rWjmRY7LUncdkdo0eMDo1E
         rmZYa5xZCJPGhroW8OI+t/OT7FEiILKZ3S9t9iVTArykeN99/jVgG+JsGZ46SEWRp/s/
         9Qpz1K+eHooPW5C77HSNORpGWFgSMyB32b38rkh+sbVKCGC40LvMT97j/CyNTh0lOTQA
         WTAit8TrqxyPpjqU62UMnpJh+bBG0hDO6G4WyYZNZq74VqWUsJEQe+QI1+e+p5+w5YaD
         cJww==
X-Forwarded-Encrypted: i=1; AJvYcCVxmlUpwFCqXDpTNyXbdvKMaUbwLG5iyC3P8kZysWKVkPbXlC7bKxi69qrZRQEMI4EDHIP/Dfr2BcUn@vger.kernel.org
X-Gm-Message-State: AOJu0YykEiqc8g41Ii3IpZI75mSDy3S/49X+Vw+pSB8ZVq/fdpQZkM55
	uknioAKl2lRVxxE9qa1WkTtOBj5VsKrPMULNFHj/uOeq8l+6X4xf2Cax/t24+MocJqbEM2LMvVa
	RZRlBnj/IgXS4FMVVMWeie1s6/eVcFvyf5NB0RbkCvA==
X-Gm-Gg: ASbGnct8gY34gIgw2MQPtG21kVxVNXu0SE4edhcLoBLKxfPEyhV48GYwkcB6Hd7+EGo
	Fdac3wACDQA5y8uq+HS1KEMZ+afGdtrwHFbhVTenUPyVoA6CeZ2sNGDhPruyhCdx7dO1XTRPBJx
	2lQr/fH+tFFeEQanb0EambYKnzIAzRKcxFkQ/Hm03ZcSoQdAgSyRqTzCOM3797pU7WXNDs1DDaW
	jsA+vBon8FXUPZ+qw==
X-Google-Smtp-Source: AGHT+IGMCpP0DpRhFaHyvLkho579q8Mncp2fpoDAGWDyxN2219xrS2LJ4ROTkXTTXvgoDl8fw2EKqWgCYtLQ95v+VMY=
X-Received: by 2002:a17:90b:1dcb:b0:329:ed5b:ecdb with SMTP id
 98e67ed59e1d1-32d43fb5b92mr20937881a91.18.1757521770015; Wed, 10 Sep 2025
 09:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-mke2fs-small-fixes-v1-2-c6ba28528af2@linaro.org>
 <17EED9B4-41D4-4D1C-9838-1ECF5B39C00D@dilger.ca> <CANp-EDZF3sVLQWdL4+a1aQLa5uqt5R_trzOp3Hh+Kw21hRn0ZQ@mail.gmail.com>
 <20250910145241.GA3662537@mit.edu>
In-Reply-To: <20250910145241.GA3662537@mit.edu>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 10 Sep 2025 12:29:21 -0400
X-Gm-Features: AS18NWB-yOiF_FbJVL1VZV66MeDHnP_gGil012ctXOPhIqk3rxndARLnV2rrTzg
Message-ID: <CANp-EDZ-5_UC+p77d+ZPMMtbH3eXAPvoL4tR_EL3dcpBk-wKeQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mke2fs.c: fail on multiple '-E' options
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ted,

On Wed, Sep 10, 2025 at 10:52=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrot=
e:
> What I would suggest that you do is to move code which mutates the
> file system from parse_extended_opts() so it is only interpreting the
> options, and move that code to tuine2fs_main().

Yes, I see where you are going. Being able to deny read/write to a
block device that is mounted is a good goal.

But I am talking about mke2fs rather than tune2fs. I can't really see
a need for two code paths when creating a filesystem?

It would still make sense to separate the option parsing from the
mutation logic of course.

> That way we can call parse_extended_opts() multiple times.

Note this is already occurs in mke2fs: one call to process options
from profile/config file, and another call for command-line args.

So in v2 patch, I just made further calls, one for each -E argument.
So far it seems to work without problems.

Regards
-Ralph

