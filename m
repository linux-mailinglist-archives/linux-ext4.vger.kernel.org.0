Return-Path: <linux-ext4+bounces-9115-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E75E3B0B1F9
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 23:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774E5189D44D
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2568E1C84A8;
	Sat, 19 Jul 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="eQBdRZBC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5EA3208
	for <linux-ext4@vger.kernel.org>; Sat, 19 Jul 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752961579; cv=none; b=FVMe6OSEIncBzHuigSi6bcMRks7rG9qu4V7E5K3y6boJHg+hKNvdgEGMc3pRgcKA0jpVY8jGx5IM89nRizL68zIzweSa38pn6PFOvFJWk+Uu7R1B+W+k8HYk6978ECCTI8cFBHXER8phYNS5FgZUvTbCgmGHhAhHxGi6DKwBck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752961579; c=relaxed/simple;
	bh=K7fmwbzAGB5SviPmGFl+B09mUOuJ9NRY2Punbj4PEfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpzxdEceGds2TaSs5lqKF19BlOVUklt3HnWtKUD5hraxcPgFY6yExCUrMSG0NA2srpE00X59v/JBjLDvhbQ17YIAWQLaGYO7qbzsirYa7jJv1xp8qhg0JojfTMBY6UmN4jPn7X+9uBCCBE8XJ5Ub6VDUYmXKsMfXNIQtSvdyGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=eQBdRZBC; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-117-186.bstnma.fios.verizon.net [173.48.117.186])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56JLk1af009673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Jul 2025 17:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752961564; bh=exflGeeC4CnyyIBrcYnERcNj2c+ONgP0MDuvyGETvs8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=eQBdRZBCWYDQ6fdES3LPsxSp2HFiYmX15OSSgZ+SEzIZd8O01X2YnK74p7tOrB/Tk
	 SUJoH11MN/ldLAmq4f0AFpqLkxSzobcQ6JBuDZPSSlxaguZ/aiGp08dtOEFtVnjHPX
	 U9mh+qKUnOK01wiQlZ32Octf89IXktoNmFr3A+vsVYI5s5F0GwB9buDFI6m7qeBdjG
	 4bj78mndaWXKk04oj0Jce1j6nOwXifD39VfsB1Ys3aX2b9hkiC4fKSYHI0WVdJgu4b
	 adUakxEN4nJgX/pY2johgCftVaR4B8Pch8nulOijyzQ6G/xviigjxASegIU2ut6W0b
	 GwizKCrXTXjMg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 250E22E00D9; Sat, 19 Jul 2025 17:46:01 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ext4: Refactor breaking condition for xattr_find_entry()
Date: Sat, 19 Jul 2025 17:45:55 -0400
Message-ID: <175296153001.397842.9125557926811806145.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708020013.175728-1-richard120310@gmail.com>
References: <20250708020013.175728-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 08 Jul 2025 10:00:13 +0800, I Hsin Cheng wrote:
> Refactor the condition for breaking the loop within xattr_find_entry().
> Elimate the usage of "<=" and take condition shortcut when "!cmp" is
> true.
> 
> Originally, the condition was "(cmp <= 0 && (sorted || cmp == 0))", which
> means after it knows "cmp <= 0" is true, it has to check the value of
> "sorted" and "cmp". The checking of "cmp" here would be redundant since
> it has already checked it.
> 
> [...]

Applied, thanks!

[1/1] ext4: Refactor breaking condition for xattr_find_entry()
      commit: 9d9076238fe9fe45257f298bf51b35aa796cf0f1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

