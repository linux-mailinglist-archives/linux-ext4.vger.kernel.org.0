Return-Path: <linux-ext4+bounces-3864-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF4395B932
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 17:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC5E1C20C80
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7B1CC163;
	Thu, 22 Aug 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hRE7dMNJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4443AC4
	for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338844; cv=none; b=d3Tk6hW+U/E6GIiWp70pVAmMGxuc8JRY7QuKVnWdhCR9QGd1Z1uUejsslkAGGuyiOusfajaRFCd9hcdtf9MSg5gYlROc271hjs2HwsYEU4JddRd9nXyX3657jbUb0wC14z0uzO19uYYPVYumHxbF4nd1tqsoChBojLLI/KrASLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338844; c=relaxed/simple;
	bh=8tUv51VwPcSZ4w6ClTUT54ff2br5Dj1ogZ2MlfHVh7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZHih6Bvq06DEEGti/h6zfyfoR+e0RtzbZZcg4Li4BzkDI2ALtc7aBIUHy8MbjqAJxihrkyMnt0rmV+A2K8n2f3dBxCOPOHo17d6HjAc61xxU/WQMFHHl+0RSX+895sgns41hrjs1CdvxJQI/xZld7heQCqTPX5eFAXUQrPT6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hRE7dMNJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47MF0Mrk022374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724338824; bh=o3v7o9Gpg/3fy9YRsgNSbSxPy/9otePhfGvjTkn19lg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=hRE7dMNJ/w4aivsRlikguJX0/dRblLz7USs1APkWjJYA6IZVkwi8MGIUY2VAXw/wM
	 UlQBVnehk62xuEALh6j2coq4LYspeXqt04zH/HmQ3dlHRjrqKlhhiV/44SUxFpnkLE
	 O8Cbj7WQt4kX6G2gx+cS3q1IxEwrwsS/tLkASl9kEq2LCD5vFf7ss9ZmeJ1nCQC43D
	 vT2lydjTkojfRco9n7TPEY9ycNc6oVZQvLsDosUJKBcEZbA341LVtaIUz13TFXuRZ3
	 gLoGS4Q4O7DjSebbqQO6eoOe2lrcmha+/h47fgIgC4TMGdQhi8W91i78XMRWtv7ot1
	 yizDpYchddNIA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DC57C15C02C0; Thu, 22 Aug 2024 11:00:21 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, carrion bent <carrionbent@linux.alibaba.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix macro definition error of EXT4_DIRENT_HASH and EXT4_DIRENT_MINOR_HASH
Date: Thu, 22 Aug 2024 11:00:09 -0400
Message-ID: <172433877724.370733.5850208811553534378.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1717652596-58760-1-git-send-email-carrionbent@linux.alibaba.com>
References: <1717412239-31392-1-git-send-email-carrionbent@163.com> <1717652596-58760-1-git-send-email-carrionbent@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Jun 2024 13:43:16 +0800, carrion bent wrote:
>     the macro parameter 'entry' of EXT4_DIRENT_HASH and
>     EXT4_DIRENT_MINOR_HASH was not used, but rather the
>     variable 'de' was directly used, which may be a local
>     variable inside a function that calls the macros.
>     Fortunately, all callers have passed in 'de' so far,
>     so this bug didn't have an effect.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix macro definition error of EXT4_DIRENT_HASH and EXT4_DIRENT_MINOR_HASH
      commit: f67fbacd923f280c55b9e26e49650331446ef335

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

