Return-Path: <linux-ext4+bounces-6854-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BD9A66794
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1710F189B533
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291AE1B4121;
	Tue, 18 Mar 2025 03:42:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611201AAA10
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269327; cv=none; b=fQvZ51vsxHSp7Wr/L93R7GskJzXbwqaxOFvATpP2HsRCoLhU4LVwEWX9NROvt5XZpUOoLyJ2l3uPUsSadNb0sT5nrN9hy7qF3MZx1NRdH/YBTP+2Ntc/L525dbpfvott+FY3Ao4XuYuKVS1yuSDKMEJiIGMERJQu8LH9FNT7uRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269327; c=relaxed/simple;
	bh=VLIhULSGMXzamCqlQjY10yT5QiYMa1qzsJ22BsNauFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AA1vgZ1fspnDCUSqsL4s3TJiBYhrvEzdPAu89LbaM1tt4HfaeQ8zVtEN8RY1Df2Ia+SQZF8jQmV+z27lxGsoUhhnOfYBN+eGp9AGE0PUO8+rS87w4GXbqMMy6z3VQfyWMQ+a0q0yS9080X+jOxmP1c6+RbF7uW/jU+vAEr6ZmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3flK6012129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:47 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D8D1B2E0111; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] ext4: Verify fast symlink length
Date: Mon, 17 Mar 2025 23:41:19 -0400
Message-ID: <174226639135.1025346.8601680057096942292.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206094454.20522-2-jack@suse.cz>
References: <20250206094454.20522-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Feb 2025 10:44:55 +0100, Jan Kara wrote:
> Verify fast symlink length stored in inode->i_size matches the string
> stored in the inode to avoid surprises from corrupted filesystems.
> 
> 

Applied, thanks!

[1/1] ext4: Verify fast symlink length
      commit: 5f920d5d60839f7cbbb1ed50eac68d8bc0a73a7c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

