Return-Path: <linux-ext4+bounces-4221-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF097C72D
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 11:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97BBB25EBA
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1519D086;
	Thu, 19 Sep 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EF3lNWmm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC0199FDC
	for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738771; cv=none; b=hbX2p+eqpc03wK5W7PRnMBy2LtoYNTKkJtJy4ui+c4Wq6Cy2rVjRN3wizyYVUwWSPZjQ6w6JS+Zx049nGV/HEgKwGgo3nc+0HzDTH+ftTPipKFQHrKPdbBH/4twodLn7iTAf15Q9+WcOCJ2pSl5/deX6ji0TazepZJDZzRUtOc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738771; c=relaxed/simple;
	bh=pa92/181DRBvJhWGybx1GT0Mvi8S2FHR71JnMoCENyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPZp8/CYK1MH2MtG3dcNvFCiHiprFmC+qP49x0tV/+jzl62YFBcC43KLOmWFSG585EpUU3Ni8V0SEwhf6SXf3Ol8y3YP5pKtp2wJvR7WJ5EQr0Qp/Fr1bG1JPYlHXxOYtsWdh04gGSUOMCa0YwxjNwXP6POKiR0YuNrtpXfaQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EF3lNWmm; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726738744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cQr+ffCjR6P/DqHvPifkRSBT+eAPFMU+HoGDQZb9RO4=;
	b=EF3lNWmmdqii0zj7BnezgTbtfpYxr8PV6QyN+wstpqB+mo0U0v5kfUbOhRQ89j8dxRpT6y
	8tvj+LgiHyjpX76QhaCt2A5ywbWXSNYxENAvjkmd4RCdqCN+fA9cNl5Cq3hDGvOBKoiK1e
	LdQDygkYGnj2M9I4j4tSYxoOOb+oSL0=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 0/2] ext4: mark FC as ineligible using an handle
Date: Thu, 19 Sep 2024 10:38:46 +0100
Message-ID: <20240919093848.2330-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi!

The following patches were suggested by Jan Kara[1] some time ago.  Basically,
they try to address a race that exists in several places, where function
ext4_fc_mark_ineligible() is called with a NULL handle: in these cases, marking
the filesystem as ineligible may effectively happen _after_ the fast-commit is
done.

There are several places where this happen, and the two patches that follow try
to address some of them.  The first patch fixes the calls that exist in
__track_dentry_update().

The second patch _partially_ fixes the call in ext4_xattr_set() -- this is
because it may fail to obtain an handle.  And, to be honest, I'm not sure what
to do in this case: try again to obtain a new handle just for marking the fc,
with a lower value for credits? or leave it as-is, with the NULL?

The other two missing callers are the ioctl for filesystem resize and
ext4_evict_inode().

[1] https://lore.kernel.org/all/20240724101504.e2t4pvgw6td7rrmm@quack3/

Luis Henriques (SUSE) (2):
  ext4: use handle to mark fc as ineligible in __track_dentry_update()
  ext4: mark fc as ineligible using an handle in ext4_xattr_set()

 fs/ext4/fast_commit.c | 19 +++++++++++--------
 fs/ext4/xattr.c       |  5 ++++-
 2 files changed, 15 insertions(+), 9 deletions(-)


