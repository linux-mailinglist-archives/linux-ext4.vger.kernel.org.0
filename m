Return-Path: <linux-ext4+bounces-4636-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D339A4715
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 21:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FAF1F24A6B
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082F204F8A;
	Fri, 18 Oct 2024 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="glpa/xfM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BB73477;
	Fri, 18 Oct 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280330; cv=none; b=Ij8E8mpEqc59vJVivdtM74RlMbTB4PYf77xBG5TxZeo9EltHZ+slkjukeUz+o+GX4mVp4HUb0JAk+2yrOCU/emi/q6K98khvYGdggqIYaQgX2jxbNfGWHX0c4ApYtMinYgEVKCczpXHLRQw0gbOdV/vSKtCpCZiZ8297GJx56v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280330; c=relaxed/simple;
	bh=Dpmh/VCAItpSGt4lH2D0VL+Tps0sHSABlbvDqvWcaXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z5oAnpKr0aAJ6vVCYgPXNlG3ChcYOdbdLW0jhXyFGnnZg4HzKpnpuiIhwtvwGyaAr1A+t6/OaNDv4PaUfF/zGBTuoC+U8EPhasciuj/za0nb/140I/BdULV3HBVlRM8WInGQ8W5rs4QLDZJKMHd+miz1Rg700hBBBLmhKJXO4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=glpa/xfM; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F2B860005;
	Fri, 18 Oct 2024 19:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1729280325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dpmh/VCAItpSGt4lH2D0VL+Tps0sHSABlbvDqvWcaXE=;
	b=glpa/xfMK9ZFTX0cHN4AYh9VwO6lsiDtD7Uo4faQ+WLxMkY4MLLk2L5v8uCd7d0PGGYUNi
	D208nof05tJYcP9vcoE3p59v7V1ts0n0OcZJ9zcs6LJY90o29O6DFoaW//7QB438/u6G06
	aVCIIc+ajowjePkiIV2TXiY8LucUP64r2jV5R4bZ4wmXzPsxPA+bi0D6Y61Zaosy0KrB/K
	b1dsjT/+Mw7J4wfSfUjGAgWDpO1UlNXBwXB1ev06wn6Sh/oj9WCbQnVpdUy6SP+S8WhRuh
	sQl/HJ/PMDwb/BcDD1x4Er195ClC/sfGek0fyyMDwMGsvE3FttmOJqNnso0tKw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger.kernel@dilger.ca>,  Hugh Dickins
 <hughd@google.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jonathan
 Corbet <corbet@lwn.net>,  smcv@collabora.com,  kernel-dev@igalia.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-ext4@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 5/9] libfs: Export generic_ci_ dentry functions
In-Reply-To: <20241017-tonyk-tmpfs-v7-5-a9c056f8391f@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 17 Oct 2024 18:14:15 -0300")
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
	<20241017-tonyk-tmpfs-v7-5-a9c056f8391f@igalia.com>
Date: Fri, 18 Oct 2024 15:38:34 -0400
Message-ID: <87sestyzet.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Export generic_ci_ dentry functions so they can be used by
> case-insensitive filesystems that need something more custom than the
> default one set by `struct generic_ci_dentry_ops`.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>

--=20
Gabriel Krisman Bertazi

