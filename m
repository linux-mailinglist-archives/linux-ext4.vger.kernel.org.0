Return-Path: <linux-ext4+bounces-10881-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D771BDC330
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 04:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F17B54E456E
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 02:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCA1B3925;
	Wed, 15 Oct 2025 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Xczzd6Xc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F234A32
	for <linux-ext4@vger.kernel.org>; Wed, 15 Oct 2025 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496326; cv=none; b=HAzc7Tg1seWVs/SSHNLoW5KK6hEYK4y1DNRDx+8kz2iNUq5qIjRLqIls4h5KuwCX97EkIhol+gG5jlEkGAlnLGN0iTKsbSpM4JmXvtR4FtjhxiWfJW6PstU4xFETS81kjntMnbM/nJ1CNajQpQebOkGdeuecjcuWR5JorVoweXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496326; c=relaxed/simple;
	bh=0m7IPn/1SIOCD1WmKB5636q2s3EVIub86zZXcPYzHzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNoud8FbO9ON4BZ6c2XfpqTUVxJxCJ5Fa5Q6v8SejTvR+++0XxYZRuDE0E7oGwlOfAhuoSnzCiCm4cU1JzuyilHa248UgU0L+hSF2D1e4dibC3gCtOn+SjQ3JGfAGmPXSh3zw0UJterrdafL4JGL/Dyz48j+sDRemPIV/YKhU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Xczzd6Xc; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59F2iJOA021691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 22:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760496262; bh=UrsOc80GHc6nE6wENKmzO4MeBeFSXWriYE+bMGSPnEI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Xczzd6Xc53pj7UVOcTkdJo8N/3WzgXWzT6z/nENoBj2EhzqxR2Br8a53osxqdmLC8
	 ZjqnOD/TRzc6Sna6A2Xz3lpSXIHVEZJOiPFiqhe5/Pue6gbaZwU+38RW7zsi4CUdih
	 UsnmoyFf5G9Am9d55bYzz5r0TFso38Coie7mNPELoJKd++lbBV8PAcwq9/tXpGjVFA
	 9ieE9YFWcSNBRBnO8PYWPvqsCUaBIMClnHtnlGGqrRVSOsvYT7gfvP1ms5UqBprhzV
	 fbI8LZIduUOx4ORe39et1jXSKxoG1PI5L3IqLCIHnC5kzJiE+DXxafLd/kWYs5VOeT
	 HSR9/ZSr/G4RQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3F0942E00DA; Tue, 14 Oct 2025 22:44:19 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Deepanshu Kartikey <kartikey406@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, yi.zhang@huaweicloud.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com,
        Zhang Yi <yi.zhang@huawei.com>
Subject: Re: [PATCH v4] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Tue, 14 Oct 2025 22:44:13 -0400
Message-ID: <176049624801.779602.18399405052764304689.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930112810.315095-1-kartikey406@gmail.com>
References: <20250930112810.315095-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Sep 2025 16:58:10 +0530, Deepanshu Kartikey wrote:
> syzbot reported a BUG_ON in ext4_es_cache_extent() when opening a verity
> file on a corrupted ext4 filesystem mounted without a journal.
> 
> The issue is that the filesystem has an inode with both the INLINE_DATA
> and EXTENTS flags set:
> 
>     EXT4-fs error (device loop0): ext4_cache_extents:545: inode #15:
>     comm syz.0.17: corrupted extent tree: lblk 0 < prev 66
> 
> [...]

Applied, thanks!

[1/1] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
      commit: 1d3ad183943b38eec2acf72a0ae98e635dc8456b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

