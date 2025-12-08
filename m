Return-Path: <linux-ext4+bounces-12225-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03561CAC80B
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 09:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EDA73035A68
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 08:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B8C1E5B64;
	Mon,  8 Dec 2025 08:32:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691E179A3;
	Mon,  8 Dec 2025 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765182770; cv=none; b=qCkgWuI8xvOiwrGsxpOWSiAlS+J/C6NDRUafGYtMkaE1FfPfwKkUtGc6Ra5gle0ecByKQEsf2FKxCi76Y1ETpcsVA8g/zI+HzB8IN9lOAvWaFK2ARp6CoAiJY1Bsiz5io8XUvF9hDgM368GmppYZGdLC7ehVgnwdiq5bWe6SpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765182770; c=relaxed/simple;
	bh=yXKWp2NcADps9fYaDB8Ly9y0uJwo/jl25pC0Mv2BYVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WICUAqKUEJUYC6OxIvMeqASI5fxTLrS4BO8OqgJB6tcAZcmtS12z6LA9Pzi9wZa/cW6nCE1PvP0VJyOkzflkG9ES1yrFbb9J55Ppt9vlE+Ti9+oTO00ju49Pa8eHBQuVGlvRq042z8OwKknTFCZQkZlM1VpZBKPj5Ciohc1zwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8ECC4CEF1;
	Mon,  8 Dec 2025 08:32:48 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: [PATCH 0/2] ext4: align preallocation size to stripe width
Date: Mon,  8 Dec 2025 16:32:44 +0800
Message-ID: <20251208083246.320965-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Yu Kuai (2):
  ext4: refactor size prediction into helper functions
  ext4: align preallocation size to stripe width

 fs/ext4/mballoc.c | 159 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 117 insertions(+), 42 deletions(-)

-- 
2.51.0


