Return-Path: <linux-ext4+bounces-14472-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEeYGGdDpmlyNQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14472-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 03:11:51 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C131E7E4B
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 03:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 752BB306902E
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C634E765;
	Tue,  3 Mar 2026 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DQc9dPKx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B16330B0B;
	Tue,  3 Mar 2026 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772503900; cv=none; b=dmHJrKnvwxt9pxTA3N47Q3MkTeWfng/3GAT53DbrUt71AkBjgW9AMHWB+nzKyp5ZILItliZfj3qvy5aL6V7as7zVQJw5o8n5p9VqR8RurfYtOqL5pJKMPcpYB/pVFUC7/bp6CGNV0Ly2h/jUJSi4TYJduMlz5Ypuz/TLdrhfkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772503900; c=relaxed/simple;
	bh=X48+k5qA9PQ46GW/jztGCV/mM0ltPoP+BKObF2W8H7k=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qgkLhjwZKy3ar+N6ds+t9vdWIn4U7yFM8oWKlePfScPNLgcYLLdYveFzAP0TKOnqAvoWXLEdCv1rReMtTPpeTle3IZjJVKIZ1zg/fNnnC1fwIoYKSX+ISYJyx6qHBmkkbjcQvvpAUS/NEri0UpNz45owRIeJQTlmu+dpEymaH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DQc9dPKx; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZbOXwFI8ufgGK6gTJdsE49m/wTyhWiTOcsrAkxIpCEw=;
	b=DQc9dPKxQ0/I5Sk1qADPU/J2Zp42trQheOplD2+JBS8d3X2J56TrwB44k+ChspesK5Ajklv3C
	bup+WHKEUenlkFhCvanw4B0qjtLGfA7lxAk2BQrOBHCX7orrLw2MqpAxzlE4Me2NC70sF6Cbe+V
	bXBqFmFWVN0u8NrtxaUvQvA=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fPzh15NQQznTxj;
	Tue,  3 Mar 2026 10:06:57 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F5FD4056F;
	Tue,  3 Mar 2026 10:11:35 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 10:11:29 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 10:11:29 +0800
Subject: Re: [PATCH v3 0/2] jbd2: audit and convert legacy J_ASSERT usage
To: <jack@suse.cz>
References: <20260303005502.337108-1-nikic.milos@gmail.com>
CC: <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69A6434F.9070205@huawei.com>
Date: Tue, 3 Mar 2026 10:11:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260303005502.337108-1-nikic.milos@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Queue-Id: 06C131E7E4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14472-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid];
	TAGGED_RCPT(0.00)[linux-ext4];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The macro `J_ASSERT_JH` is a rather troublesome implementation. There
are numerous calls to `J_ASSERT_JH` within
`jbd2_journal_commit_transaction()`, and after compilation, these may
all jump to the same address for execution, making it difficult to
determine exactly where the assertion is being triggered. If there is a
functional issue in just a single file system, using `BUG_ON` to handle
it seems a bit too aggressive.
I wonder if you all have any good ideas or suggestions.

On 2026/3/3 8:55, Milos Nikic wrote:
> Hello Jan and the ext4 team,
>
> This patch series follows up on the previous discussion regarding
> converting hard J_ASSERT panics into graceful journal aborts.
>
> In v1, we addressed a specific panic on unlock. Per Jan's suggestion,
> I have audited fs/jbd2/transaction.c for other low-hanging fruit
> where state machine invariants are enforced by J_ASSERT inside
> functions that natively support error returns.
>
> Changes in v3:
>
>      Patch 2: Added pr_err() statements inside the ambiguous WARN_ON_ONCE()
>      blocks (where multiple conditions are checked via logical OR/AND) to
>      explicitly dump the b_transaction, b_next_transaction, and
>      j_committing_transaction pointers. This provides necessary context for
>      debugging state machine corruptions from the dmesg stack trace.
>
> Changes in v2:
>
>      Patch 1: Unmodified from v1. Collected Reviewed-by tags.
>
>      Patch 2: New patch resulting from the broader audit. Systematically
>      replaces J_ASSERTs with WARN_ON_ONCE and graceful -EINVAL returns
>      across 6 core transaction lifecycle functions. Careful attention was
>      paid to ensuring spinlocks are safely dropped before triggering
>      jbd2_journal_abort(), and no memory is leaked on the error paths.
>
> Milos Nikic (2):
>    jbd2: gracefully abort instead of panicking on unlocked buffer
>    jbd2: gracefully abort on transaction state corruptions
>
>   fs/jbd2/transaction.c | 115 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 91 insertions(+), 24 deletions(-)
>

