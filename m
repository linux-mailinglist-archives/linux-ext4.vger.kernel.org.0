Return-Path: <linux-ext4+bounces-2124-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008F68A7A51
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 04:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3259E1C210F2
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 02:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDD96AAD;
	Wed, 17 Apr 2024 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cWzCY3Uz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C264C
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319439; cv=none; b=HXoWjp43D7ywQRM4Xb5f1bN8/YrLpZtgCnYF03Y9CgOw02D/lyUy3lkgEessejHd0tmK/yzVlyZKfPTcUn0kCARmoU6R0OaL8EbHAhaJJDUfLiVwPzmwUjeT0aYjwKlXYg+7oRpynVLOBEsoJVH97iOz3L2qcVdeJ7XHki20QEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319439; c=relaxed/simple;
	bh=evfIT0siSKMcRgPuDFowYfcazjKqxWDZrGgnne/Fs1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1Efml0wslm/02bL/rGudoKMHADlkY5oCK56s0e07hHakxhlRDjxhddUzl+9SLmMVnnIwsw4ZwHZH0aaFePLgwBZa0a73IpGFKnaWztWj3dabhLTbOtNq5JBmWwgxFEA66mwvowxLy7O1lH4YdGZJQgSBc1HUY75CUUmBVggPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cWzCY3Uz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43H23g3H013701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 22:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713319423; bh=YNRPqkRYKIZj+F2cbFoyhjusRmK9L7Vq3s+Uuss5GU4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=cWzCY3UzRKn3BF3mzvyecWPlLScjXnCtL+LhEY1LdUacV6Je23X+U9WEzSdz0Y2Vb
	 fSbEsbD/BjAfPXa5TTh2rA+ipqowQZBUOsRluzfC4GjXCJhmCJWI7HYSD2aEexfJUT
	 zFYe2eaVz2N7LabTUeCN+R34+T2Pjhim0p6/upbK2WHo7gL2BfxwSBPRcdgh7K2jvq
	 n76YyZ1tDML+Xa8jPL73lApo36iGyYVntY6Vom9Q3sis5n2WTf+USwMbsSXIkM2fbC
	 R3M41hwbnUra/Ez8fdgfk+MBT8kD/LdzgiY5gMFsY9HXG1Ztwuf/+JE//RW4rOdBbn
	 E4rxiYnpbiA1g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C365115C0CD7; Tue, 16 Apr 2024 22:03:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: Re: [e2fsprogs PATCH] libext2fs: fix ext2fs_get_device_size2() return value on Windows
Date: Tue, 16 Apr 2024 22:03:34 -0400
Message-ID: <171328638214.2734906.2248501686414066065.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230301034518.373859-1-ebiggers@kernel.org>
References: <20230301034518.373859-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 28 Feb 2023 19:45:18 -0800, Eric Biggers wrote:
> Creating a file system on Windows without a pre-existing file stopped
> working because the Windows version of ext2fs_get_device_size2() doesn't
> return ENOENT if the file doesn't exist.  Fix this.
> 
> 

Applied, thanks!

[1/1] libext2fs: fix ext2fs_get_device_size2() return value on Windows
      commit: 72e30620b1ebd4742a8cda6cd4220a5423ca3180

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

