Return-Path: <linux-ext4+bounces-11358-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB7C1F874
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 11:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251DD4273AB
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E0350D68;
	Thu, 30 Oct 2025 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcU6vQfR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FAB354AC1
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819929; cv=none; b=bQDnEHIngfepWQxwxEWw19bQZyHyk86a2GLuWfDkprWIHFBImBCG2upAmScNkHLc5xcLiml4Duuy4tSr63Z8RSUYdpV/R5hFQ+NjeCkuiDPeGtf3FCCpm8BdAeWUao6ZEMThqX5wQiMj0TWpKF28WakOyP5itoOBBp3oAa/9DB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819929; c=relaxed/simple;
	bh=JJIWNnCoiCiguK9/rbFMg0f0XCv3XZGq85zbgk4m07s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaTJxRSjh787D4sT4F7eAkDHimhriKqbV8sBBtKV0d3+onpGUdIAPHxMcVj4iHuDDEc82ZUVzbGir5+z4bk+DQwWg21KpdItLivSJkq3IH12rolaH3txNMiAHjLj1+ZXm2d+hFLbu8l4hEyIFAl23OcsUyiwM+b1OK87/BTZmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcU6vQfR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so406990366b.1
        for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761819924; x=1762424724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgOlSBWsltR3bwKZ0KqRU5bm8t/l2+tDWDnMT0PQAXc=;
        b=fcU6vQfR7+9qSnWQRvnD86md6lNKG5Pd/wTWJoW7Wg98i8LL3C2U1stMOizmJkJYQe
         Y8IcMIRergrEgRzZ3G+S2yrPfVKz5luZwBDVz7g8zLKSC6xKDYN60LZ3fpArJEphAcQ0
         WIjTVi0PG9jm/VGXYPauvzWEIjWEBFkLIUA2cGMIm7t92l6o1AXq1oo1//TeWLieg+k5
         khVPV4O8q1x78F6VH3cpUhTkRNW23Spi0Iv4Ypkz8UVMDv0D1cTZGn513If4v2iBRpQ9
         1UgjvL3+hspth9nRl86Ci4ltWRrUkzxc/zBnVdcffSEtIO+tiuIgrl5f24aAHgGXqZr0
         rHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761819924; x=1762424724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgOlSBWsltR3bwKZ0KqRU5bm8t/l2+tDWDnMT0PQAXc=;
        b=aOWUYq0lEsa5c10V7PYqzLCrT4ZFkxOsyy1eTEmjkE1mgwqtsRNN6EgAnJ3LzG2fGb
         /Je0XFW8NfDWXHMwWczETtCkAfKp+g/M6nZLyEthsh9U0WfdINTODc07DkFGpyWy5H3i
         JluMLq9FF3scTOIaZ8Y6lMzlKYZLvhldWQPFFB5f+T2rKDcPGAtWmu6XeInwmDNj9khe
         34fD9tX7sniN/J1X/dzZjrZrgCakGEE8ytsMM53kFYmfgnKu2orYsMK/M/Pmcfbmg087
         u/2TKyKbUVR7kDUBJsVvxjcbRGfOELhgt1GnCT4DUhkWGgafTSqTvFkDLUmL3k63wWPW
         J67g==
X-Forwarded-Encrypted: i=1; AJvYcCU0xiKxu1trwKOhP4zHs/gP8WRgDPnQWjyMtcTUm3lJzBBL/5/j5xsyUI46QeVoEF95sw3+2cMJO6VH@vger.kernel.org
X-Gm-Message-State: AOJu0YyyBJgr4f4t7WsX95myJP/jApEq7LBPpQB/KFzWyiuvvRja5fzM
	AqewuWpFFUjvFGk/vUS60r/frRq8/UERd/bgDON8ZIBXg3vr2dytBiLpCXbrH092oYv8Mu5iVeY
	JBZEfD/pMc2CEdaS48Aal/8r9Lodw1w4=
X-Gm-Gg: ASbGncsVgy7iCNhR1hKrgJZy4d6NLJysqHRoyhTojlT0EX/gEa7mqzhRYx+wTbeJzLA
	kr2x1eATOjVO4h3vhiHdxax6kOIVnC09eyIzd4uFGfcAPyHGZT4ogpOUGO3vbLBEWnob2ebytjt
	BXBoXDk7uU7hT4TYQxrQtv/agEasI4ZIT2Y9Rg3Wz6IqxMkdkJ/cWopVkpXQSXhj+rMHe6yOraK
	Dwv2V1ZUozbk1CNuKh9XqDnPbDY9pH8pRHMjWNu8ZIFJvamFVq5eQc3k550CXdOUOQldSwqexAQ
	LemxBiGrhcmufhyx9Hw=
X-Google-Smtp-Source: AGHT+IG1s+J1qsSzRLjzHYiT/VYRPZob+nrmIAe/cGI1XD/nmjBEEnz4k4/6pM5ItnXuo6ggIslcbL4yDUTbDqlUHYY=
X-Received: by 2002:a17:907:1b1b:b0:b50:94d1:8395 with SMTP id
 a640c23a62f3a-b7051f6307dmr291641966b.9.1761819924384; Thu, 30 Oct 2025
 03:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs> <176169820405.1433624.15490165287670348975.stgit@frogsfrogsfrogs>
In-Reply-To: <176169820405.1433624.15490165287670348975.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 11:25:12 +0100
X-Gm-Features: AWmQ_bnLwEnVDgdX6KD058UE1kZn67zBdXIwzjqwbOoKyDUWo9XWQMSAUULwjQQ
Message-ID: <CAOQ4uxgQe5thjp_Pfmbwf-P+o9n7a93a7dzS4S0_Rnw--ULBfA@mail.gmail.com>
Subject: Re: [PATCH 23/33] generic/{409,410,411,589}: check for stacking mount support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:29=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> _get_mount depends on the ability for commands such as "mount /dev/sda
> /a/second/mountpoint -o per_mount_opts" to succeed when /dev/sda is
> already mounted elsewhere.
>
> The kernel isn't going to notice that /dev/sda is already mounted, so
> the mount(8) call won't do the right thing even if per_mount_opts match
> the existing mount options.
>
> If per_mount_opts doesn't match, we'd have to convey the new per-mount
> options to the kernel.  In theory we could make the fuse2fs argument
> parsing even more complex to support this use case, but for now fuse2fs
> doesn't know how to do that.
>
> Until that happens, let's _notrun these tests.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/rc         |   24 ++++++++++++++++++++++++
>  tests/generic/409 |    1 +
>  tests/generic/410 |    1 +
>  tests/generic/411 |    1 +
>  tests/generic/589 |    1 +
>  5 files changed, 28 insertions(+)
>
>
> diff --git a/common/rc b/common/rc
> index f5b10a280adec9..b6e76c03a12445 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -364,6 +364,30 @@ _clear_mount_stack()
>         MOUNTED_POINT_STACK=3D""
>  }
>
> +# Check that this filesystem supports stack mounts
> +_require_mount_stack()
> +{
> +       case "$FSTYP" in
> +       fuse.ext[234])
> +               # _get_mount depends on the ability for commands such as
> +               # "mount /dev/sda /a/second/mountpoint -o per_mount_opts"=
 to
> +               # succeed when /dev/sda is already mounted elsewhere.
> +               #
> +               # The kernel isn't going to notice that /dev/sda is alrea=
dy
> +               # mounted, so the mount(8) call won't do the right thing =
even
> +               # if per_mount_opts match the existing mount options.
> +               #
> +               # If per_mount_opts doesn't match, we'd have to convey th=
e new
> +               # per-mount options to the kernel.  In theory we could ma=
ke the
> +               # fuse2fs argument parsing even more complex to support t=
his
> +               # use case, but for now fuse2fs doesn't know how to do th=
at.
> +               _notrun "fuse2fs servers do not support stacking mounts"
> +               ;;

I believe this is true for fuse* in general. no?

Thanks,
Amir.

