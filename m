Return-Path: <linux-ext4+bounces-744-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFB5827D07
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 03:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EF42856F5
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 02:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11FDF62;
	Tue,  9 Jan 2024 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="eze4RAO0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8520B6106
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4092rS01010560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 21:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704768811; bh=dS0rHUHIXFe3N5enAhc30rZHiqo2/yFMRYHCtke7c3k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=eze4RAO0cvBZBGu8HF+lngKjVJ45ARPs/SQM9VpeEQtPhypDqJEDe7sxfRBF0A47t
	 BnwRhfhl0Q3MUnlVOdYabw54zcN+YEOX5xtEj2BCkmC3AniyXELCbXoCjRdOkJQg/C
	 2WeKo6czuyOBZkviXu9sEehMiB6smqLtNltsDtnm8OBUUCow/AAeJiNM9tuQi7We4c
	 HBFdw3HeYIjRwcbqCPA1BSt/n9iZ4bBbMO5ZmirYNmY4Bn+2TZ0Ps1wfD8/iQvlb7s
	 uku9JndipIaY6/B3ryiQZcd0gPlSko1yjNSBpcwfvo4QP2xfNIjJyAhtfVaiJAXemT
	 lqAnjPa1cqmDQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1D51C15C027B; Mon,  8 Jan 2024 21:53:28 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gou Hao <gouhao@uniontech.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        gouhaojake@163.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()
Date: Mon,  8 Jan 2024 21:53:16 -0500
Message-ID: <170476879010.637731.5184546578471274100.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231024035215.29474-1-gouhao@uniontech.com>
References: <20231023013416.17246-1-gouhao@uniontech.com> <20231024035215.29474-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 24 Oct 2023 11:52:15 +0800, Gou Hao wrote:
> 'blocks_per_page' is always 1 after 'if (blocks_per_page >= 2)',
> 'pnum' and 'block' are equal in this case.
> 
> 

Applied, thanks!

[1/1] ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()
      commit: f2fec3e99a32d7c14dbf63c824f8286ebc94b18d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

