Return-Path: <linux-ext4+bounces-8072-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFE6ABF85D
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 16:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74857AC4DB
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D7A219A6B;
	Wed, 21 May 2025 14:51:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA21EBA14
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839091; cv=none; b=rGOP7cSO2Vd0F91lEBx4uSQPVbZfwS/fpLeS1eu1wwgOxmZRcnqpyMhX7DS+FGIhsF2jkpqWu0PBPqpQn8BTyzgwWaSdiP9CDCIdyTzCUJp4zQ3Z8iqxRayLLjr9uuaEuzQOUJC7WIH8OC+KqzVZEHBdo+RffBriHH2IZWjThf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839091; c=relaxed/simple;
	bh=+l48c+P6ctQ8BJ09H5NCaMlxVZC83ju9zZ3JmyoSNzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwiWbJigoStJXGkCBqtCQU+n2pmhdSewOZkRqo44r8UWa6B6wr1FTMifMaZE7I8OoZGi5OlAqhHJjrYtWXaZ5Ro7wXCzkC94s5o6cc4g8qNwNJIOmO73xp0p+XCzb97arp9qhUk9912dT+wi5yXeCI7oufMLsKUdg37XgJDeA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54LEpEhe001403
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:51:15 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B90F82E00E5; Wed, 21 May 2025 10:51:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: jack@suse.cz, Gwendal Grignou <gwendal@chromium.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        uekawa@chromium.org
Subject: Re: [PATCH v2] tune2fs: do not update quota when not needed
Date: Wed, 21 May 2025 10:51:06 -0400
Message-ID: <174783906007.866336.3008986337412117293.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250103235042.4029197-1-gwendal@chromium.org>
References: <20240912091558.jbmwtnvfxrymjch2@quack3> <20250103235042.4029197-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 03 Jan 2025 15:50:42 -0800, Gwendal Grignou wrote:
> Enabling quota is expensive: All inodes in the filesystem are scanned.
> Only do it when the requested quota configuration does not match the
> existing configuration.
> 
> Test:
> Add a tiny patch to print out when core of function
> handle_quota_options() is triggered.
> Issue commands:
> truncate -s 1G unused ; mkfs.ext4 unused
> 
> [...]

Applied, thanks!

[1/1] tune2fs: do not update quota when not needed
      commit: 4ea1d7f202bb4350e8f517e604c6300a521a762c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

