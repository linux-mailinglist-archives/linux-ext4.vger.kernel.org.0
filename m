Return-Path: <linux-ext4+bounces-3464-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9032993C674
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22DF1C2161C
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300319D89D;
	Thu, 25 Jul 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufjFf3YX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BB19D890;
	Thu, 25 Jul 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921556; cv=none; b=ixnjYJXdxg8CIoUhrQTwfGxK0lKvw0HAHQ6wsUdIduHQDBFgvYc/dAJb42BDxGFsh0dhVC0LoGqXCD850l8st9+UfgrNWF6ZIg+jy44NFupuiAKLb8d0yAbhbkwK2SPsVJs8pxTTIisdRQp/rm/U8UMwF+Xck9tlacg0DaIBWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921556; c=relaxed/simple;
	bh=XKb9N3QtFNM+J292AN8p78g+c+RPvkadH/ye12cgIsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE5t/TfNgso4HkjcCmbgItt8Tz6su+6kGOYUsDpwwwL13Mx+8+meZxq53hXqtKA18EdGr2wvid6HehjKVIMenpwwOzXl+NWE3Vp27bYhakQDQBbyVXtMFcAJAPToBjZ7RE4VV5YdHDTU7s8JaY+CZp8oXIJgbXmICYjOJI2TuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufjFf3YX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F20EC116B1;
	Thu, 25 Jul 2024 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921556;
	bh=XKb9N3QtFNM+J292AN8p78g+c+RPvkadH/ye12cgIsI=;
	h=From:To:Cc:Subject:Date:From;
	b=ufjFf3YXAEL2CMIVe6MSCGxJo43H4ldge8vHzlZhwf57K6RHDKV44OmopS6UAqPQe
	 Zbero/TKeeELOBn2lDyREK/a86FdoZbgKN/o2PmtGY/woBuIGDJsalobZFpfsQD40K
	 ASp0HrpST7T+VxbCVd/1F/o6m248TGk9bJ9Ap/3zIf9qGmtN1H6mks5S9Bvvy1vu4d
	 /qNYuU8Y2cHoO8w1681P4sdfmQPOBPU+Apg1TdqOfbKP3AcIpQm7iKDh2egLib3UFF
	 SM4bJMwe9QbAAVriw0cQ9PhX9HM+KZOtTo/ropHZYU+mHc783YI79TV7A0svULEqMS
	 lfDh+jCn0lnfA==
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
Subject: [PATCH v5.10.y 0/3] Apply fanotify-related documentation changes
Date: Thu, 25 Jul 2024 11:32:26 -0400
Message-ID: <20240725153229.13407-1-cel@kernel.org>
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
FAN_FS_ERROR event") is already applied to v5.10.y.

Gabriel Krisman Bertazi (2):
  samples: Add fs error monitoring example
  samples: Make fs-monitor depend on libc and headers

Linus Torvalds (1):
  Add gitignore file for samples/fanotify/ subdirectory

 samples/Kconfig               |   8 ++
 samples/Makefile              |   1 +
 samples/fanotify/.gitignore   |   1 +
 samples/fanotify/Makefile     |   5 ++
 samples/fanotify/fs-monitor.c | 142 ++++++++++++++++++++++++++++++++++
 5 files changed, 157 insertions(+)
 create mode 100644 samples/fanotify/.gitignore
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

-- 
2.45.2


