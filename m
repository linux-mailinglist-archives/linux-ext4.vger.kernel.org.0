Return-Path: <linux-ext4+bounces-6853-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82B7A66791
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7753A9694
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8CF1AB50D;
	Tue, 18 Mar 2025 03:42:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2491A2643
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269326; cv=none; b=ZHZfx3nE4nasMc8aimdVNE4DUX6qNzXbQv7RG2vHZJeUgTe5FycDL9X8aJWEWJrN6Rly8255hTrDDzzxOyHTLy7k25MT9fB2w8idvzbYNzDGRcrUxI4wSlKKV5ukkb6fMW3bECoe2AeVyuqLKvvoH7tqxc6H2Id+rAcLAEBvI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269326; c=relaxed/simple;
	bh=aHoLFeS9wmOOx6ir4HAUA/HhDddPfzodCcgmDsAZrms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtfNSVQ9zEqDGPxe+pTSYgmog2rcdtbHVwiZSR7FxiMURHoWed5ZyuUVY9URDKrcKY3DnPoUwNwhr8fo8mtzCpZpPb3bnoLTbyf56+l0uhW0vdr3qgN3bCywZpSnE6nl1whGrwUxFHmrsSJWXsk7H6s44AtUpwrxEm6ITyvMWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fnIF012167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 00C662E011B; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, jack@suse.com, Zizhi Wo <wozizhi@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH] ext4: Modify the comment about mb_optimize_scan
Date: Mon, 17 Mar 2025 23:41:29 -0400
Message-ID: <174226639138.1025346.5200311084093814962.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224012005.689549-1-wozizhi@huawei.com>
References: <20250224012005.689549-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 24 Feb 2025 09:20:05 +0800, Zizhi Wo wrote:
> Commit 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning") introduces
> the sysfs control interface "mb_max_linear_groups" to address the problem
> that rotational devices performance degrades when the "mb_optimize_scan"
> feature is enabled, which may result in distant block group allocation.
> 
> However, the name of the interface was incorrect in the comment to the
> ext4/mballoc.c file, and this patch fixes it, without further changes.
> 
> [...]

Applied, thanks!

[1/1] ext4: Modify the comment about mb_optimize_scan
      commit: 447c11274113dd3543224816cca0d3027759c630

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

