Return-Path: <linux-ext4+bounces-11882-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B817C65EB8
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C62F23652BA
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 19:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1575133C535;
	Mon, 17 Nov 2025 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bzt+K3z/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC54339B37
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406857; cv=none; b=juiIpSD3Q4An5gyWqos5RifOizz/vlcCYylm56VyDFqajzgYUF+tU2v6UtsYcyE/UUk/VoGeMFZ/P7sSOr0q/7JGGdW093CgZqiDhEGt8GLa7erJLAvM0cgwRFu+cVbmbcF/f8okEWys1vNkiRFKhW+lyYFi449miAQdBSJNUPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406857; c=relaxed/simple;
	bh=S8+oYdvzJkqg5GnbKH1RT7Mgj2ukg9Yf1oBFfES9NFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfeA0+KN3lEj746beD9LwgsFyaeMPPF9K47BkvxryuDiRLfet4rKa4uiewfEXl25E+2jSGvsjiUTWQbBL8SMv38L5PUdW+Su+dBr9RLbmeaR23Fwr4GQ7R21npV0rDnkgmwtUUoBLN/yh5aHhqlN11tkxR3yP4Celzf2Sd53O2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bzt+K3z/; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-69.bstnma.fios.verizon.net [173.48.114.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AHJDqn9020625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 14:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763406835; bh=mNZ5GIaU4El1zYRELHlqutylXT+r7C+fyoeeZNVHpfY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=bzt+K3z/iCbZT5y2WMcWDVNp93G0iAunFTHHpfeaq0lo8aGc6TxynOQ/x0X27CDsM
	 aKDAAvQR2Nf3Rgu3bgCxixCqAMtkdYEREnGNwYC/46Plv/YM9IN5bypPQSw1jNfxDQ
	 EM7l4m0jFcQW0ErUjnY4IsApPWTUIebmCn9GtgQt+tDf591VTS4HOwKnop/LApWBZg
	 tOlMj3j92PF9uH0B6vd2MT/404x90sKGTWDd2HOj5t7zFLBfE6C4kT8hvbz30dNpGL
	 9UAJul1aj2qvtUGnD4jd7JHXJiF+6Qx6g4sdCHNW7sX1ORoNDmwt1CnWPFFZy3IQLg
	 Hp4J2i6w2eIRA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 48CD32E00DF; Mon, 17 Nov 2025 14:13:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alexey Nepomnyashih <sdl@nppct.ru>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC] ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()
Date: Mon, 17 Nov 2025 14:13:36 -0500
Message-ID: <176340680646.138575.18168327924359030421.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104093326.697381-1-sdl@nppct.ru>
References: <20251104093326.697381-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Nov 2025 09:33:25 +0000, Alexey Nepomnyashih wrote:
> Fix a race between inline data destruction and block mapping.
> 
> The function ext4_destroy_inline_data_nolock() changes the inode data
> layout by clearing EXT4_INODE_INLINE_DATA and setting EXT4_INODE_EXTENTS.
> At the same time, another thread may execute ext4_map_blocks(), which
> tests EXT4_INODE_EXTENTS to decide whether to call ext4_ext_map_blocks()
> or ext4_ind_map_blocks().
> 
> [...]

Applied, thanks!

[1/1] ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()
      commit: 103ce01cd045197461d654f62f1a30cabedbcad4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

