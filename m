Return-Path: <linux-ext4+bounces-11880-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31470C65EB1
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02CE5364B00
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 19:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE52338596;
	Mon, 17 Nov 2025 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NiTxrsgY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512F3370EC
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406854; cv=none; b=oaZsk7kc2SGSRiqKSnJKxGdyNGhME5YzD6Y6GzQir+4wpuoKdrbwa21P81Zirh6VEDp3cql8G7U/FwjqgILlU800TzQMGsfXO27q+WEw7vnIcXFz0JhF6cBsKaxkrDmmojXtc8mg3KkUZqRWa1Tgs3SOUEs26wl9xJd3KJO3VBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406854; c=relaxed/simple;
	bh=/raFckIchGzzNugZVoBfkWiC70cjjTYZ8iT+OguuEJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2ZI+PpnYBJkJ7JSglDZ1jPh45ITvShqcsb/S3Ju9Nf8SGkuZHoHUFGXFJ6DxeVPSuBliWy8SdMaOdPwmVPvEmGni1ZMkhXgGZQAzsWA6LeVP4amJUuaLQc6V3zptZA8r+jWXzsul7DR6tXj+S3Pa6KwhPzSkt3qEdYVflXPbOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NiTxrsgY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-69.bstnma.fios.verizon.net [173.48.114.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AHJDoIb020572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 14:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763406834; bh=4sPsdubBU31q4wx8PUp1SERWhUxxXgN/q/I3QMN4Go8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=NiTxrsgY3Jriv7AnQiIZqISfO6PGHip8tDJn2SzeQ/l6n+tmx5lmcnxjp/v9G0ayz
	 RueTr1Bwj6rAXEN/5HSK/h1oI8rFp5BLBYQDafZ5645Ouejv7df7rg3BSy98b2oenk
	 I8SF1rKzzCjrq49e8bYfKvyu/FXTD1sBUyMymMfeDIKMeQ5dzU2HnFEhOTfp28GzBX
	 /V90sxAPW8rk3z9CYPTfztCJmcBXG7Hh1nkLP053Lnr7pmmZD/t6z9+g1TfTHZAIXJ
	 Fxq3y8gtvgznxc9Jrl7WxgEQumxzzU5MajetbSIlG5aDiB6lC73mAsw427D5UURhV0
	 qIsiqs6xyjLKQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 401072E00DC; Mon, 17 Nov 2025 14:13:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Karina Yankevich <k.yankevich@omp.ru>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Bhupesh <bhupesh@igalia.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-patches@linuxtesting.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] ext4: xattr: fix null pointer deref in ext4_raw_inode()
Date: Mon, 17 Nov 2025 14:13:33 -0500
Message-ID: <176340680641.138575.14674529109795333702.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022093253.3546296-1-k.yankevich@omp.ru>
References: <20251022093253.3546296-1-k.yankevich@omp.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 22 Oct 2025 12:32:53 +0300, Karina Yankevich wrote:
> If ext4_get_inode_loc() fails (e.g. if it returns -EFSCORRUPTED),
> iloc.bh will remain set to NULL. Since ext4_xattr_inode_dec_ref_all()
> lacks error checking, this will lead to a null pointer dereference
> in ext4_raw_inode(), called right after ext4_get_inode_loc().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied, thanks!

[1/1] ext4: xattr: fix null pointer deref in ext4_raw_inode()
      commit: b97cb7d6a051aa6ebd57906df0e26e9e36c26d14

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

