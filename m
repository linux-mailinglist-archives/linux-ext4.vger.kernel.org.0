Return-Path: <linux-ext4+bounces-8057-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C8AABDD8D
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B221899032
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869EA2517A9;
	Tue, 20 May 2025 14:41:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF0F24E01B
	for <linux-ext4@vger.kernel.org>; Tue, 20 May 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752080; cv=none; b=ZgjUNBSUcl0hw4rQz1LdQlMh8WXT7z3KuQFyvnQSAvw97WE8RoSsHRa61OK4ALqvvreVg2/ppomN6UfiWb1boNl1kNiAhZujvwZvIRlYZTLQ/0RWa1WbH6yiGIO0v37Acb2FwBZBV/GkvVyM03W7jxG6t7nWF67CS+hv+vj+ciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752080; c=relaxed/simple;
	bh=qRybH5cw5MW+2tIr6+LlsfuFuUK8mFtVjjDVpaujrY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T11KlP7eOT5los/94k8oNYpnGNXtwY7x6vAHwpFl3K0869Y/xE7B/hx5hLl3itCVUY0AOIl0FZ2yhCtX1+G9+6BuR3ua6VvqG1IYgYDKiN1sLUyYYHoqDQnSRwagk1HqAfVmrNPlDqgBdkYOY4tHSxv2rEr07gH4Af+DHk5X02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEeOXq013125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B4B552E00DE; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, Arnd Bergmann <arnd@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huawei.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shida Zhang <zhangshida@kylinos.cn>, Baokun Li <libaokun1@huawei.com>,
        Jann Horn <jannh@google.com>, Brian Foster <bfoster@redhat.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: avoid -Wformat-security warning
Date: Tue, 20 May 2025 10:40:10 -0400
Message-ID: <174775151764.432196.13613749014255693736.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423164354.2780635-1-arnd@kernel.org>
References: <20250423164354.2780635-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 23 Apr 2025 18:43:49 +0200, Arnd Bergmann wrote:
> check_igot_inode() prints a variable string, which causes a harmless
> warning with 'make W=1':
> 
> fs/ext4/inode.c:4763:45: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>  4763 |         ext4_error_inode(inode, function, line, 0, err_str);
> 
> Use a trivial "%s" format string instead.
> 
> [...]

Applied, thanks!

[1/1] ext4: avoid -Wformat-security warning
      commit: d612a07931e261c537978aad096e7340b687cd0c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

