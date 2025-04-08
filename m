Return-Path: <linux-ext4+bounces-7135-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E069A80CB9
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 15:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC9F3BD4E3
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057BB185935;
	Tue,  8 Apr 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ppf5C7GB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB65B664;
	Tue,  8 Apr 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119526; cv=none; b=EoGBibuuMTCp/VUankjvySBl8rpI5iSTtznS08tIc0BVke+z0c7XiFg3IXr8V9Mz+9pT2fTvnJRiVG3/ijHp9eOF2MlbSYpP8VBsPPLpT2anBVAU5XlP0xsMkxfS1HCKpuooIdI11x0quzDpVpzSqQZZBs/Ff+l6QfVPgUnAlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119526; c=relaxed/simple;
	bh=5YrJSsQfy0ot/rDrzBKb96pM7uj4Fw6yT+L+zjDaEl0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eOVHAPh2ZuH8yQz3DAAH0yMl1Ez2aqoZhJp92qFYjHzuMcyapFXl2pe44giOXYeWQtf+A/nK5T74Kow1rklxWZ0f4M37gHuDGrBnspbYQHViHTYx6f5PU+5ueZbtN2pirBI8U1c5pOv57jsdXMzKmIJ/dZAPLFxru69VfgECr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ppf5C7GB; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [192.168.100.10] (unknown [178.69.224.101])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0B062407851F;
	Tue,  8 Apr 2025 13:38:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0B062407851F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1744119521;
	bh=5YrJSsQfy0ot/rDrzBKb96pM7uj4Fw6yT+L+zjDaEl0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ppf5C7GByOwEdKivPsC5Ec5wpoa17VxnEMMcLHb8Nod6Xjt2YOEU+N0S61wO3IiCU
	 T7TnV+kOzkqzvCdXjypbGIhCjggCJ3I28HjxG17z4OxRPQn++TZdRFOOXWpHJx5/U/
	 GwljJgVFa0efMKXskTMtNfNWlYgRAoxIb/R+kPZQ=
Message-ID: <fc291720-bba7-4799-b451-ae7c84e6697c@ispras.ru>
Date: Tue, 8 Apr 2025 16:38:36 +0300
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Artem Sadovnikov <a.sadovnikov@ispras.ru>
Subject: Re: [PATCH] ext4: fix off-by-one error in do_split
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Eric Sandeen
 <sandeen@redhat.com>, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20250404082804.2567-3-a.sadovnikov@ispras.ru>
 <odgkvml62unm4ux3sbnympgyzj22z7dwjgdvdmlbgtiybq4j7z@gnnaygdp7muw>
Content-Language: ru
In-Reply-To: <odgkvml62unm4ux3sbnympgyzj22z7dwjgdvdmlbgtiybq4j7z@gnnaygdp7muw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.04.2025 16:02, Jan Kara wrote:
> Thanks for debugging this! The fix looks good, but I'm still failing to see
> the use-after-free / end-of-buffer issue. If we wrongly split to two parts
> count/2 each, then dx_move_dirents() and dx_pack_dirents() seem to still
> work correctly. Just they will make too small amount of space in bh but
> still at least one dir entry gets moved? Following add_dirent_to_buf() is
> more likely to fail due to ENOSPC but still I don't see the buffer overrun
> issue? Can you please tell me what I'm missing? Thanks!

add_dirent_to_buf() only checks for available space if its de parameter is NULL, but make_indexed_dir() provides a non-NULL de, so that space check is skipped entirely. add_dirent_to_buf() then calls ext4_insert_dentry() which will write a filename that's potentially larger than entry size and will cause an out-of-bounds write.

