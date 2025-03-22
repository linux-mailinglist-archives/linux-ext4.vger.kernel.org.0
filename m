Return-Path: <linux-ext4+bounces-6943-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5ACA6C772
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 04:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DEB18974A2
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 03:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9818633A;
	Sat, 22 Mar 2025 03:36:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61107083C
	for <linux-ext4@vger.kernel.org>; Sat, 22 Mar 2025 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614607; cv=none; b=nL/h7Vm2TwjEYXXyKCYchieITQHmC3PcXioweeV/63vZEfmKQPnZUq168V7nzWWrWH3w4BYm/cMcrcum5eS/SEQCF9+N7gh9Pcp4GwXwAwGhHBIdRNsa7GJgJz+aWAda0Y3E3+DLno+FCRHnELmB+IjfUyH8g4aXX4DwOZ7qWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614607; c=relaxed/simple;
	bh=hnh3r47MCqymd+jrutHSqC4mQGCHNJt41W4PME5+rfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCCixkcDqc7N8ky20Lw1ahNOhnyGB71cvhYJ5DmLUjgySBD8lYfcdWn35MyF2cemgiJ53rMbOnvjrQeZVUyCA5Ed6zUXJjaocBvbn6S372LWB/qSvYQkQHwKxnSjFUgRI7Etiand0YX4MtJYGXXk5R8ljSD+wsqojRE3Ge8yRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aMFq007705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:23 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BECA02E010E; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Fix a BUG_ON crashing the kernel in start_this_handle
Date: Fri, 21 Mar 2025 23:36:17 -0400
Message-ID: <174261457017.1344301.10860947796634385230.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1742279837.git.ojaswin@linux.ibm.com>
References: <cover.1742279837.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 18 Mar 2025 13:22:54 +0530, Ojaswin Mujoo wrote:
> ** Changes in v4 [4] **
> 
>   * some minor refactoring and typo fix
> 
> [4] https://lore.kernel.org/linux-ext4/cover.1741938027.git.ojaswin@linux.ibm.com/T/#m8b5191fef8b201246ab5b34f7dc11b79fe6afe99
> 
> ** Changes in v3 [3] **
> 
> [...]

Applied, thanks!

[1/3] ext4: define ext4_journal_destroy wrapper
      commit: 5a02a6204ca37e7c22fbb55a789c503f05e8e89a
[2/3] ext4: avoid journaling sb update on error if journal is destroying
      commit: ce2f26e73783b4a7c46a86e3af5b5c8de0971790
[3/3] ext4: Make sb update interval tunable
      commit: 896b02d0b9e7deb4a4eb365e13dd912b49916519

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

