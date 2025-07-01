Return-Path: <linux-ext4+bounces-8743-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506FAEF8F3
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 14:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892FB16FDA7
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C526E173;
	Tue,  1 Jul 2025 12:40:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E9273D7D
	for <linux-ext4@vger.kernel.org>; Tue,  1 Jul 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373645; cv=none; b=f8okutGhEe3/xd6Ga2yEjsn0VM0Qodgt1+VlKKnLbZ48If6YOkisBKaTUMc4IbIL4qSZ9AVvo0NZaKeXzIPs/9MFNp9caBCXjt9rhvUqIDXfoPVNGkfeNCCQGATSwaqTtydookhc0NvW+LTS2yH9ZSPD/Qsv5c0LFKZCwvnM1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373645; c=relaxed/simple;
	bh=WN4Hr0NAS32ZAWzZh4bavewfQ4BN1zFUrae+vK3Lkrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0wsAtKAe0h+ZEGv+G8f2EgA2pedYo6v3bX3uFkWJKT+QPQubQ14JBVlg+9BGfQl/HPWSIJF/IqUi4gqI1QTCQ5lB10XgHgu6Dfn77IJ2Q+ZNdqI1598s+AXFOzZ0+d/wVDTSI+uv4HHM1w4LH2jU4bPpgczFu4bty+NKq38LXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu; spf=fail smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-121.bstnma.fios.verizon.net [108.26.156.121])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 561Ce9Qu002183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 08:40:10 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 9A3862E00D5; Tue, 01 Jul 2025 08:40:09 -0400 (EDT)
Date: Tue, 1 Jul 2025 08:40:09 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zhangjian <zhangjian496@huawei.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] debugfs: fix printing for sequence in descriptor/revoke
 block
Message-ID: <20250701124009.GA461416@mit.edu>
References: <20250627212451.3600741-1-zhangjian496@huawei.com>
 <20250630151700.GB9987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630151700.GB9987@frogsfrogsfrogs>

Also, to clarify the code, please
also change the parameter names in dump_descriptor_block,
dump_revoke_block, and dump_metadata_block from transaction to
sequence.  That will make it clear that what these functions do with
the parameter is to print the sequence number, and avoid the confusion
steming from:

		fprintf(out_file, "Dumping revoke block, sequence %u, at "
			"block %u:\n", transaction, blocknr);

Thanks,

						- Ted

