Return-Path: <linux-ext4+bounces-3432-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A651693B72C
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 21:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0982857CF
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FB167D8C;
	Wed, 24 Jul 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFt1JwOC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE965E20;
	Wed, 24 Jul 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847997; cv=none; b=VzBsvmcENFTnFg6/j3S5wuY5r2f7lew6CuRNIPWrR+D9eNysutavSMXdk8kpOmbJvp6DnqbJIHf0qx1vLP+b3d+92c4Xm7TadALDReRMQVtGW0zriaTlGeep48KywRzpNbgTZ01w/hGuExcxcfiLk6IMYUUVMcxDGj7MOMwzfmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847997; c=relaxed/simple;
	bh=TJjdOHWTy2BrZ1KELRq5REFg1fcjDZ4jpfvlukHdK5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoFHZ6Wl0tBFQ+e5a7ne2eE+pbvAcMJxh2ToYO5bUMXR6FytemLuyMO888mFL/ik3jXLf2Zwd2eIX5/YSVwELzglcijlPIxxOLhKCj1nNdCy94+gkgL7qw7Gsa2RsSjDUvxkdjuSednqeuAV8rRNBx3EUwT+AlSKuK43Zb3KeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFt1JwOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C2DC32781;
	Wed, 24 Jul 2024 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721847996;
	bh=TJjdOHWTy2BrZ1KELRq5REFg1fcjDZ4jpfvlukHdK5A=;
	h=From:To:Cc:Subject:Date:From;
	b=IFt1JwOC1T6WZGTcLdTikzWhoINOTYK9L5VSd3EnjC6KGv0kTYdfFDhFYXnm6pWcJ
	 v6kTr3LFUthJkqCSEAQY7B4dFg3n2lp0F+Bd3oISjCCO3i0d460NN8M5c+IfxH9un8
	 CQs8Loy930pzfYPlbHe5u0D8hK4gBe6ZYEJbFOOmRS4MkUy7Yu9Eh8NjUnUaxiKotp
	 Z+jo81NT1Wl5RRNgJXAxmOGUT7uqpdWOJSijZc2eB2RzQ0tpYEI+hkZKJDOGcTl2FW
	 gmAqs3oJX8FiYd85MiJPulcwS5jGnNrJFjBCzEIzVrz0DvWo7Uz/EcTNNXMYN0lPpJ
	 PdCYqwGwtHvbg==
From: cel@kernel.org
To: amir73il@gmail.com,
	krisman@collabora.com
Cc: gregkh@linuxfoundation.org,
	jack@suse.cz,
	sashal@kernel.org,
	stable@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5.15.y 0/4] Apply fanotify-related documentation changes
Date: Wed, 24 Jul 2024 15:06:19 -0400
Message-ID: <20240724190623.8948-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

These extra commits were requested by Amir Goldstein
<amir73il@gmail.com>. Note that c0baf9ac0b05 ("docs: Document the
FAN_FS_ERROR event") is already applied to v5.15.y.

Gabriel Krisman Bertazi (3):
  samples: Add fs error monitoring example
  samples: Make fs-monitor depend on libc and headers
  docs: Fix formatting of literal sections in fanotify docs

Linus Torvalds (1):
  Add gitignore file for samples/fanotify/ subdirectory

 .../admin-guide/filesystem-monitoring.rst     |  20 ++-
 samples/Kconfig                               |   9 ++
 samples/Makefile                              |   1 +
 samples/fanotify/.gitignore                   |   1 +
 samples/fanotify/Makefile                     |   5 +
 samples/fanotify/fs-monitor.c                 | 142 ++++++++++++++++++
 6 files changed, 170 insertions(+), 8 deletions(-)
 create mode 100644 samples/fanotify/.gitignore
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

-- 
2.45.2


