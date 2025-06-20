Return-Path: <linux-ext4+bounces-8561-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D64AE16E0
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 11:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEC3188998C
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB627E040;
	Fri, 20 Jun 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VELAa85w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1C27D763
	for <linux-ext4@vger.kernel.org>; Fri, 20 Jun 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409935; cv=none; b=EWHJ4kj+sKIoAutduF9K8tw0Kk8bSxhN2NByHFmfAaaNsB1ph/Bd+SgSOdvHfvrL2xqDHaqhWEEyQDirmjfI5RdVDRoL3ALOcpKPLl24MuW21g+SIIX0BnsIDQwK3dKL8JKJJ7wkvHeC3qizwjgKFUM+muOICpx/uk2kGVtLr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409935; c=relaxed/simple;
	bh=BpH0pHNPZm6LbbjEwIAiuSzrXdKhyBa5zujoGxkRqWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giBwaH27W/Y2AaSCRzKcXmUdKaXoEgr4iCiSm+V/zZ4Dft9JiD/ZDFdjVpJ9CnhW6Fxrl5NGfR5C8Ooh4ou3IsI2FStQxMrHXlzABpRc+H5xhE3Fpb3Jpad11ZzOSrz2Mu/TAgu3dJ7SfOWV+YyLZ4RncThd1K/YKD+jE/AhPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VELAa85w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750409932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QR8mG4qewbyLkZRi9qQoKnNeSih+x7nXiPiiahvnnPU=;
	b=VELAa85wPMTJ/HLyXk7FAHDK0I8iZ3RDtS7i0XP2D9E9Ocz2UPgoqhefhOZWzyfs8b9ssK
	s30O2MXPieRfegzuqUXf3kIijSEPtzBO6eI+dcdTXb1nKW0RPY9LPahRcllZhG0czBiHb0
	97xieqMrMMmSD4jfpuSvQ9Eo0NaIUYs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-hDel5lF0NxGrvjG54XgnZg-1; Fri, 20 Jun 2025 04:58:51 -0400
X-MC-Unique: hDel5lF0NxGrvjG54XgnZg-1
X-Mimecast-MFC-AGG-ID: hDel5lF0NxGrvjG54XgnZg_1750409930
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-60d60b8ef64so715997eaf.3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Jun 2025 01:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750409930; x=1751014730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QR8mG4qewbyLkZRi9qQoKnNeSih+x7nXiPiiahvnnPU=;
        b=OgHIUQG8Sh/qHPcjw+1YwAPECF7/vgYUar3HSllZZEPgRqavEHVaZ1mr/MfMNkx1At
         gwmh4OwnFCXuM79roNWQBynHt6I6hsAr4cXtF1a4StzxzAmtHcY4BOPae2o6PznzUITP
         3R7V8Rz0kTqRtPvAnjzwKkoG60CqpW0vUMJgsjTmP9u6AaF8Y0Vq3LnE51mauZFzuCkD
         Xd5SAJzKMevNzzILe0QeubHVjYiJqei4Cu4l0l14wN8W12NwuqIutROiu6c4t8GaKB7L
         1oeBUasDqLp/ynlycbhF3Ec6u7agBKo/XViiLmZVg554oLa0n7L28p/jY2LmKsMJwtB3
         Colg==
X-Forwarded-Encrypted: i=1; AJvYcCWJhX8etPJ61tkPGs/p+lhRdW+5xmRoL+CcFqVYmmRmz39HqLHbS29rCrIEZEW/SRktP4AOIbr4kSPE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57QCZ3EHwa8zKzF67mTCN/qUgybzCmSoj/Xco2kLGcNFkN5t0
	KFG4rOg7vC09G85hmYkDyb2cDefTC9ieKEasFbzXN0w4s0T6DcRdInrbPb+FkS0w3XNJONdSo20
	6mhqIb3sLb7m4od3svP5l22E5WNrGnKzNAgHAlJvkBuwunoz3JDFWHjXd9SHLdPtlIsM24186JN
	CrvolsY8sgexS0cswf2mAJYm+BtfzC524WhufLe7HN0gXXQaPS/5s=
X-Gm-Gg: ASbGncsHnOuPHqdDyVh6xH13baNHmvFfr7hj+4zdUpGIiBi6IrmqDJItKwqcWEV5psY
	YCXekm9dn/EiljEZ21EUqJZv+cPEteyBndLUWNWt2rESZgBF78roQyj3+Yfj57Z2ey7xOTnEUcE
	733yyU8WNosrwIt8M8vLx6E4GtHBr6rz25Fw==
X-Received: by 2002:a4a:ee06:0:b0:611:2c55:3b39 with SMTP id 006d021491bc7-6115b9ba12amr1442284eaf.3.1750409930066;
        Fri, 20 Jun 2025 01:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYB/C7y/mW7YGXkvLHZEzdWmX38VA5n5djcLK7T96pX0N2F2a4uL6sDg7dqqL+loHHQ+T7nIi2xdcPKAFDbCQ=
X-Received: by 2002:a4a:ee06:0:b0:611:2c55:3b39 with SMTP id
 006d021491bc7-6115b9ba12amr1442272eaf.3.1750409929749; Fri, 20 Jun 2025
 01:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs> <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs> <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs> <20250611115629.GL784455@mit.edu>
In-Reply-To: <20250611115629.GL784455@mit.edu>
From: Allison Karlitskaya <lis@redhat.com>
Date: Fri, 20 Jun 2025 10:58:38 +0200
X-Gm-Features: Ac12FXzaDyHQsHgJ6iv0tV4BMxjkmezK6KxBuWvqs_fjsJwR-0Nnv7GswYhoT4g
Message-ID: <CAOYeF9W8OpAjSS9r_MO5set0ZoUCAnTmG2iB7NXvOiewtnrqLg@mail.gmail.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, bernd@bsbernd.com, 
	miklos@szeredi.hu, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

hi Ted,

Sorry I didn't see this earlier.  I've been travelling.

On Wed, 11 Jun 2025 at 21:25, Theodore Ts'o <tytso@mit.edu> wrote:
> This may break the github actions for composefs-rs[1], but I'm going
> to assume that they can figure out a way to transition to Fuse3
> (hopefully by just using a newer version of Ubuntu, but I suppose it's
> possible that Rust bindings only exist for Fuse2, and not Fuse3).  But
> in any case, I don't think it makes sense to hold back fuse2fs
> development just for the sake of Ubuntu Focal (LTS 20.04).  And if
> necessary, composefs-rs can just stay back on e2fsprogs 1.47.N until
> they can get off of Fuse2 and/or Ubuntu 20.04.  Allison, does that
> sound fair to you?

To be honest, with a composefs-rs hat on, I don't care at all about
fuse support for ext2/3/4 (although I think it's cool that it exists).
We also use fuse in composefs-rs for unrelated reasons, but even there
we use the fuser rust crate which has a "pure rust" direct syscall
layer that no longer depends on libfuse.  Our use of e2fsprogs is
strictly related to building testing images in CI, and for that we
only use mkfs.ext4.  There's also no specific reason that we're using
old Ubuntu.  I probably just copy-pasted it from another project
without paying too much attention.

Thanks for asking, though!

lis


