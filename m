Return-Path: <linux-ext4+bounces-11357-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1742DC1F729
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 11:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A965423BFE
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80F350A25;
	Thu, 30 Oct 2025 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbVoCkV5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE393546FC
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818767; cv=none; b=KnFU/4ul7f7oDBwlc4JuRdGLEWh+N7CJOhiSO0QqNblxe5nK1ohaL2V7wdr3OaiPQAOLjuesn+g8eqZGGhNm8Bj9pEkMF8B11WCcNFl+9B2IUhiD1alNsq67UIpPc+58VXj7o6DkW05uo95XBOahrYsb4wVZZzXEgWRIXLsuwGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818767; c=relaxed/simple;
	bh=ck8LSBHKPeutEEduvO4hk2YZpUlglnNVZAj0p3d+tZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNqQ8WWVyIONfNw6OnxPSLlRrqEdcOBS4MsK8E/ASczY0wI6Y78IWQFX2NYXbmRTgRnd6iQaXwz7qnVD/APa6uha7UrQzaUzvU71krA6uN5P1y2WJtVKHf8QrozC0FBH+nM9eQOvGCOGxHy4GWZOx/oQz+oeq1YTsb92kXEfpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbVoCkV5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso1634564a12.3
        for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761818763; x=1762423563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpRra+YYaNP2bxzICIK5uG5yzLGIWfb13z8p6QQVNS8=;
        b=KbVoCkV5XQDK6FQ5lr83bsRgtJIt+5Vc70zwmnwMH7yJUtE98px28O+LOgbwCl8AJN
         dsY2GPkE6gPDifn9bH6kNb5ckFO3pPd9Fe8smgdgvSA+mTKFKOfFA7uZf4QJFE3VauHu
         7uxRB6M727v511czL2O4jAnZ9qn4m2VElL/RAeQiPy9t5/bVFE7DOGD6QpwW4wgKO/rE
         8YeV9+9Un/rfK9dnGpBKhIX4BoDpiINpJMPAxTewj0k2KgDGZsrfcvU7qLjtd23Fstve
         bkh1iqmiqSDfCZszJYYBp1nv8eKXHJ/M3Fx0TwcL+x4PKzD2Tw7xBzvc9UcnrZCkmm6e
         zHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761818763; x=1762423563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpRra+YYaNP2bxzICIK5uG5yzLGIWfb13z8p6QQVNS8=;
        b=Xe9VnWU1+K06gu5++/1or8qVRonaJckbABBYKVcSCTAhobohQDU2FracqJlP823//B
         IA2d7uQ3LZX2bui0GwyUNR9k6p0X9Lqf36Z2MRKNb5tBl/U44DeWEYhq6Jz9CPtqAe4y
         gOV2Jra2iqMspHNHHmalGATiAUZf+hCMBZN9o9uobiL/+GXvDE45EQiVu1jZrLO7DrOP
         cJ+/r3pn2LtP/heF5EM48B4AKvOXW7L3+fQuSmLhuEW6EM0Kcx4r8+BqeHmdc6u/eJir
         PB0BGoDcVrQ/7C+dtUxdvmU1zKIL4jh0c4jRIjoVcOjQ1a+2OmtwId2mmDVyLvx9/f2D
         OKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzMePfbV+d2KXv2bCdtcLo0mbcjveUzRfXg6KuI1fVfAHR5FOKUhtreO/8RC3bq8TK80es/nWVoAU9@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwlQfpuTYIjn4OH2yWOvfeKQbP2P7SSPFSQpNsNoLUuy8pT2p
	Ke3YGn4KJ0C9Su+C8OVMcO7wczl/jmuMpq7wZAQv4BIKCkCBJgPbb7vWp7QHj3Xqc97u/+uB0/s
	mgJ/WFK+zQY0dGhTjpoePHick4UzDH2M=
X-Gm-Gg: ASbGncvStwjiKRMC58NxVW9NkTtGDVmWl0KR9UYuii+ZDC1/af/uIIQMVsNoGnIgL38
	KwVu/FIH8RoahjMorug01WNjajRqK2zaL8GaqS9znQJMfJuw6wspulc0vqtOCeb64ZkOFzYMB34
	2y620gbFvs4XbjZYjBPd2XIjRmdCYauPy0EdFr6wEvZ6qBfavwKlg7Vm9jSPXw5iPu7WbbGm5ia
	PxvE4lXlYfVqHbPY3xUsHdO+tbHiMeivYCyvrAGLjwdDWycjeAMmNQ7YQTLf4Mvnm4UxT0xGEPn
	ODzUt5kuRddiRLFk1ZY=
X-Google-Smtp-Source: AGHT+IEayt9kMjjupQxpl5WLpsB234iE8hKztdLOW4j/gh/ByTR/f9GKoYV6XqFI1badI7TIU5oxgv5EjeZJQhrKVsc=
X-Received: by 2002:a05:6402:5106:b0:63c:18e:1dee with SMTP id
 4fb4d7f45d1cf-64044252109mr5197576a12.24.1761818763254; Thu, 30 Oct 2025
 03:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs> <176169820480.1433624.3763033606730126640.stgit@frogsfrogsfrogs>
In-Reply-To: <176169820480.1433624.3763033606730126640.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 11:05:52 +0100
X-Gm-Features: AWmQ_bml8OwCVaqNQBU5P31b-DWNxcYedjaNrUhbws2VGFTKx58LLfTNxkNO3Ds
Message-ID: <CAOQ4uxgoZ_wrExQLsO2CfF8AFQ+n2T1WBHenwuteMUdnoO+Piw@mail.gmail.com>
Subject: Re: [PATCH 27/33] generic/050: skip test because fuse2fs doesn't have
 stable output
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:30=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> fuse2fs doesn't have a stable output, so skip this test for now.
>
> --- a/tests/generic/050.out      2025-07-15 14:45:14.951719283 -0700
> +++ b/tests/generic/050.out.bad        2025-07-16 14:06:28.283170486 -070=
0
> @@ -1,7 +1,7 @@
>  QA output created by 050
> +FUSE2FS (sdd): Warning: Mounting unchecked fs, running e2fsck is recomme=
nded.

oopsy here

>  setting device read-only
>  mounting read-only block device:
> -mount: device write-protected, mounting read-only
>  touching file on read-only filesystem (should fail)
>  touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system
>  unmounting read-only filesystem
> @@ -12,10 +12,10 @@
>  unmounting shutdown filesystem:
>  setting device read-only
>  mounting filesystem that needs recovery on a read-only device:
> -mount: device write-protected, mounting read-only
>  unmounting read-only filesystem
>  mounting filesystem with -o norecovery on a read-only device:
> -mount: device write-protected, mounting read-only
> +FUSE2FS (sdd): read-only device, trying to mount norecovery
> +FUSE2FS (sdd): Warning: Mounting unchecked fs, running e2fsck is recomme=
nded

and here

>  unmounting read-only filesystem
>  setting device read-write
>  mounting filesystem that needs recovery with -o ro:
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/050 |    4 ++++
>  1 file changed, 4 insertions(+)
>
>
> diff --git a/tests/generic/050 b/tests/generic/050
> index 3bc371756fd221..13fbdbbfeed2b6 100755
> --- a/tests/generic/050
> +++ b/tests/generic/050
> @@ -47,6 +47,10 @@ elif [ "$FSTYP" =3D "btrfs" ]; then
>         # it can be treated as "nojournal".
>         features=3D"nojournal"
>  fi
> +if [[ "$FSTYP" =3D~ fuse.ext[234] ]]; then
> +       # fuse2fs doesn't have stable output, skip this test...
> +       _notrun "fuse doesn't have stable output"
> +fi

Is this statement correct in general for fuse or specifically for fuse2fs?

If general, than I would rather foresee fuse.xfs and make it:

if [[ ! "$FSTYP" =3D~ fuse.* ]];

Thanks,
Amir.

