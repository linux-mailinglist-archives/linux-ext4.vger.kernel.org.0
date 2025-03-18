Return-Path: <linux-ext4+bounces-6863-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407DA667AE
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322043B82C6
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FC41E0DEE;
	Tue, 18 Mar 2025 03:42:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3641DF731
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269343; cv=none; b=uPuHYeZ0K7k/irCzNFsZGccwKU5nOJNQvHQR1WcTQOZ6mR4t07NTLYZoICl1z0xbRmnkO06epvM2L18X+3dQ9QGW6u1aAo2g+H1KOtnkJgq52xkCWFpbdOecrHuzKvIoroIAC+yktu9BU2AaLpLSY4GHHKKxKzVVEMGT0tF/vAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269343; c=relaxed/simple;
	bh=kc/CGIVJ2v2EexwqV5xHc2rwx2PKN+8i68IRbYqt838=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0Xh+q1UhhVhh8cGz/TIc5lLfMxTtseLdlH3Bytw+F2j2CRyq+J/VBKyksW1TP2KR5jLlRy7VVUs/+7iHGPz4CiZbu7CQHVWrkmMoNLn7LVZvGNDbJJP5XM09KNs9Okffp4PsGC6qBNLKeF9g9ivZYq5S9Hl4wRdNdx914jyWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fon0012184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:50 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 069C12E011D; Mon, 17 Mar 2025 23:41:46 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        leah.rumancik@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] jbd2: fix off-by-one while erasing journal
Date: Mon, 17 Mar 2025 23:41:31 -0400
Message-ID: <174226639137.1025346.3745775280459676334.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217065955.3829229-1-yi.zhang@huaweicloud.com>
References: <20250217065955.3829229-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 17 Feb 2025 14:59:55 +0800, Zhang Yi wrote:
> In __jbd2_journal_erase(), the block_stop parameter includes the last
> block of a contiguous region; however, the calculation of byte_stop is
> incorrect, as it does not account for the bytes in that last block.
> Consequently, the page cache is not cleared properly, which occasionally
> causes the ext4/050 test to fail.
> 
> Since block_stop operates on inclusion semantics, it involves repeated
> increments and decrements by 1, significantly increasing the complexity
> of the calculations. Optimize the calculation and fix the incorrect
> byte_stop by make both block_stop and byte_stop to use exclusion
> semantics.
> 
> [...]

Applied, thanks!

[1/1] jbd2: fix off-by-one while erasing journal
      commit: f0b48ab02c624d12643c4dbe62ec4c78789592de

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

