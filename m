Return-Path: <linux-ext4+bounces-7318-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A4A90A93
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Apr 2025 19:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51A91906F3E
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Apr 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9DC218AC4;
	Wed, 16 Apr 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ3NqI1S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6E189B8C;
	Wed, 16 Apr 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826179; cv=none; b=ZW3cLcnzx2AGvdfnYPhHY0B50cFy84bLsK/AeLh160NcD4yUe2YEFtt+ulL0bL0bx1Jeher57P+7QnYCQZuga//wzb/GgchCF3mGS832EBaKkwpfvS/dtALwUYKmnSP2WAllts9EYHxbNU4laepE8/RXT6bWbO+S5ZhiVYkclMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826179; c=relaxed/simple;
	bh=H0WXh36ys7jck0mPQQ9zQ+ukjOzF7jVDWWVZjc70wOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=swthoT8XAs/x7cUU56d7Q7qq1NWR+09TF1D1Q3l21yMpVgnQQh1CEkbwDPVk/vbhI+MHLix3Y/wnv2u80h/oRSkc7ONMlWK7U2b4BQz6uC35jDGvrk9BLsMSnZNyQgZEGHGfzBpRxeM7rZaEE60SAYAvBh0TDSWPBahqwoX0Q+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ3NqI1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DB5C4CEE4;
	Wed, 16 Apr 2025 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744826179;
	bh=H0WXh36ys7jck0mPQQ9zQ+ukjOzF7jVDWWVZjc70wOo=;
	h=Date:From:To:Cc:Subject:From;
	b=sZ3NqI1SOnKWWq3RSrekOWmPRzAmUxJ3n9uk9VED032vqEa4jP43M6OrCTGV1jsOF
	 tZ5zhOOL+pgfXaCJ45A3uL+ZQ59u4sYVOZDU+AlCxjGk1HL2tQW+GSlo6EEt60RtkK
	 rCrESqkXtOfWPBJIq9K32t/mJJOVY2QaB7oGuY9rWMScZiBqh+GPu91Cfg6fnDB8lS
	 7j7wcRRcLv0ZTOSA9qgq/UOZzcgcnnaO6zEaL/+mLOk/QoMC1Tvl0ABa7mFPwiBFt8
	 D69jjE/qhBQDnxoME7cQNsMh4r0PpsWSlBCqgCWE5eXw906HRBnoHKBxEMHKEZvyFS
	 v/7Z1Sz3xpYIw==
Date: Wed, 16 Apr 2025 10:56:17 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>, kdevops@lists.linux.dev,
	dave@stgolabs.net, jack@suse.cz
Subject: ext4 v6.15-rc2 baseline
Message-ID: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

ext4 developers,

kdevops has run fstests on v6.15-rc2 across the different ext4 profiles
it currently defines, and the results are below.

The profiles which kdevops currently supports are:

 - ext4_defaults
 - ext4_1k
 - ext4_2k
 - ext4_4k
 - ext4_advanced_features
 - ext4_bigalloc32k_4k
 - ext4_bigalloc64k_4k
 - ext4_bigalloc1024k_4k
 - ext4_bigalloc2048k_4k

These are defined in the ext4 jinja2 template on kdevops [0] and described
on the ext4 kconfig [1]. Adding support for more profiles is just a matter
of editing these two files, please feel free to send a patch if you'd like
kdevops to test more profiles. A full tarball of the fstests results are
available on kdevops-results-archive [2]. Since we leverage git-lfs, you can
opt to only download this single tarball as follows:

GIT_LFS_SKIP_SMUDGE=1 git clone https://github.com/linux-kdevops/kdevops-results-archive.git
cd kdevops-results-archive
git lfs fetch --include "fstests/gh/linux-ext4-kpd/20250415/0001/linux-6-15-rc2/8ffd015db85f.xz
git lfs checkout "fstests/gh/linux-ext4-kpd/20250415/0001/linux-6-15-rc2/8ffd015db85f.xz

Few questions:

 - Is this useful information?
 - Do you want results for each rc release posted to the mailing list?

[0] https://github.com/linux-kdevops/kdevops/blob/main/playbooks/roles/fstests/templates/ext4/ext4.config
[1] https://github.com/linux-kdevops/kdevops/blob/main/workflows/fstests/ext4/Kconfig
[2] https://github.com/linux-kdevops/kdevops-results-archive/commit/a74831cc4300e702eef9bafd31cc5dc4b8dda5e8

  workflow: fstests
  tree: linux
  ref: 8ffd015db85f
  test number: 0001

Detailed test report:

KERNEL:    6.15.0-rc2-g8ffd015db85f
CPUS:      8
MEMORY:    4 GiB

ext4_defaults: 793 tests, 20 failures, 271 skipped, 10397 seconds
  Failures: ext4/034 ext4/055 generic/082 generic/219 generic/223
    generic/230 generic/231 generic/232 generic/233 generic/235
    generic/270 generic/381 generic/382 generic/566 generic/587
    generic/600 generic/601 generic/681 generic/682 generic/741
ext4_1k: 793 tests, 19 failures, 326 skipped, 10898 seconds
  Failures: ext4/034 ext4/055 generic/082 generic/219 generic/223
    generic/230 generic/231 generic/232 generic/233 generic/235
    generic/381 generic/382 generic/566 generic/587 generic/600
    generic/601 generic/681 generic/682 generic/741
ext4_2k: 793 tests, 19 failures, 323 skipped, 9737 seconds
  Failures: ext4/034 ext4/055 generic/082 generic/219 generic/223
    generic/230 generic/231 generic/232 generic/233 generic/235
    generic/381 generic/382 generic/566 generic/587 generic/600
    generic/601 generic/681 generic/682 generic/741
ext4_4k: 793 tests, 19 failures, 320 skipped, 9026 seconds
  Failures: ext4/034 ext4/055 generic/082 generic/219 generic/223
    generic/230 generic/231 generic/232 generic/233 generic/235
    generic/381 generic/382 generic/566 generic/587 generic/600
    generic/601 generic/681 generic/682 generic/741
ext4_bigalloc2048k_4k: 793 tests, 43 failures, 357 skipped, 7481 seconds
  Failures: ext4/033 ext4/034 ext4/045 ext4/055 generic/075
    generic/082 generic/091 generic/112 generic/127 generic/219
    generic/230 generic/231 generic/232 generic/233 generic/234
    generic/235 generic/251 generic/263 generic/280 generic/365
    generic/381 generic/382 generic/435 generic/471 generic/566
    generic/587 generic/600 generic/601 generic/614 generic/629
    generic/634 generic/635 generic/643 generic/645 generic/676
    generic/681 generic/682 generic/698 generic/732 generic/736
    generic/738 generic/741 generic/754
ext4_bigalloc1024k_4k: 793 tests, 39 failures, 350 skipped, 7800 seconds
  Failures: ext4/033 ext4/034 ext4/045 ext4/055 generic/075
    generic/082 generic/091 generic/112 generic/127 generic/219
    generic/230 generic/231 generic/232 generic/233 generic/234
    generic/235 generic/251 generic/263 generic/280 generic/365
    generic/381 generic/382 generic/435 generic/566 generic/587
    generic/600 generic/601 generic/614 generic/629 generic/634
    generic/635 generic/643 generic/681 generic/682 generic/698
    generic/732 generic/738 generic/741 generic/754
ext4_bigalloc32k_4k: 793 tests, 27 failures, 350 skipped, 8434 seconds
  Failures: ext4/033 ext4/034 ext4/055 generic/075 generic/082
    generic/091 generic/112 generic/127 generic/219 generic/223
    generic/230 generic/231 generic/232 generic/233 generic/234
    generic/235 generic/263 generic/280 generic/381 generic/382
    generic/566 generic/587 generic/600 generic/601 generic/681
    generic/682 generic/741
ext4_bigalloc64k_4k: 793 tests, 27 failures, 350 skipped, 8575 seconds
  Failures: ext4/033 ext4/034 ext4/055 generic/075 generic/082
    generic/091 generic/112 generic/127 generic/219 generic/223
    generic/230 generic/231 generic/232 generic/233 generic/234
    generic/235 generic/263 generic/280 generic/381 generic/382
    generic/566 generic/587 generic/600 generic/601 generic/681
    generic/682 generic/741
ext4_bigalloc16k_4k: 793 tests, 27 failures, 350 skipped, 8755 seconds
  Failures: ext4/033 ext4/034 ext4/055 generic/075 generic/082
    generic/091 generic/112 generic/127 generic/219 generic/223
    generic/230 generic/231 generic/232 generic/233 generic/234
    generic/235 generic/263 generic/280 generic/381 generic/382
    generic/566 generic/587 generic/600 generic/601 generic/681
    generic/682 generic/741
ext4_advanced_features: 793 tests, 21 failures, 279 skipped, 10373 seconds
  Failures: ext4/034 ext4/055 generic/082 generic/219 generic/223
    generic/230 generic/231 generic/232 generic/233 generic/235
    generic/270 generic/381 generic/382 generic/477 generic/566
    generic/587 generic/600 generic/601 generic/681 generic/682
    generic/741
Totals: 7930 tests, 3276 skipped, 261 failures, 0 errors, 82423s

