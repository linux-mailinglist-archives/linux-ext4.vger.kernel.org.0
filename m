Return-Path: <linux-ext4+bounces-743-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D22827D08
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 03:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF9ACB2254A
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 02:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E067DDAA;
	Tue,  9 Jan 2024 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EHAzW17P"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBE6104
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4092rSsg010561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 21:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704768813; bh=ZXnsh+p0Y5aT+oTCfe/acfGYOHQyaLsLY5kQyvPE0TI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=EHAzW17P+PSyk8ldswo4HRd1VdPwz4kmDDcOelrjdYbq6mCbf6K32WCf9zZg1XDge
	 ijxwXHhPYUwx+00Xhb52cTRHd6TDC06Bsyvb0Yh0po9tbqNtoqqhvaMDHqt0BtgfBl
	 FLEAzpK3vDuCtjTckxI9vLY68rsakidWQvvGhqF8qCJqb8aC/qTdx7u3tvD/dtuR5J
	 KY+AW2xxpNCu0C+uV89v7sSYJ8uTfrF96aIA5/wG9rhWO7SPsEX6TxTNejDXTQqDR6
	 mCvMYn99ljyMbVBfPYO3Fl6mQwCwXxzR+AZeDDi3YZ05wmGvua8SkECs2zhqJmHVKs
	 VSpLFBgN6Vxag==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 21B1315C0307; Mon,  8 Jan 2024 21:53:28 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        glandvador@yahoo.com, bugzilla@eyal.emu.id.au
Subject: Re: [PATCH 0/1] Fix for recent bugzilla reports related to long halts during block allocation
Date: Mon,  8 Jan 2024 21:53:18 -0500
Message-ID: <170476879011.637731.13228432208887255974.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702455010.git.ojaswin@linux.ibm.com>
References: <cover.1702455010.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Dec 2023 16:49:49 +0530, Ojaswin Mujoo wrote:
> This patch intends to fix the recent bugzilla [1] report where the
> kworker flush thread seemed to be taking 100% CPU utilizationa and was
> slowing down the whole system. The backtrace indicated that we were
> stuck in mballoc allocation path. The issue was only seen kernel 6.5+
> and when ext4 was mounted with -o stripe (or stripe option was
> implicitly added due us mkfs flags used).
> 
> [...]

Applied, thanks!

[1/1] ext4: fallback to complex scan if aligned scan doesn't work
      commit: a26b6faf7f1c9c1ba6edb3fea9d1390201f2ed50

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

