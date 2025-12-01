Return-Path: <linux-ext4+bounces-12106-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E1DC9839D
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC7343DD2
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75253346BC;
	Mon,  1 Dec 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ImUGPapr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33D333727
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606271; cv=none; b=AhQ3KaTKdpZ5HuQ6/ZIu1exHyxqnJIzW3T1YoVRtA2KCS5olxj7GaPLaEq6RzCzE+Md/boH9WEmAVPwAsMwdHKgmkzwqOGABlpnAgT5J2idTI/YJdN34bcMdQCse9ffDjepxSAuhZkKxUEByFjIMowoIq2qcMaQECATDe+uPKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606271; c=relaxed/simple;
	bh=lemxizQ/+tRCnjSo5Yj4xJIUdC15UFxVTRkVhrb6hGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbcPFEtMxm/WlekvpmpIvfCh2mwxkeNO/HfBU3eg+yXpGhvRxFCsAJQJsnuOvIDUJQIdXYeMAPkOqC31dawI45oOxcM40Rik+4i2vauaTB3kZGDqMscjfBWq/sNW6cPmbtPnYFUMn3sPy1+v9p+/48/1ksgAN6ijFKX/+wKPquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ImUGPapr; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B1GNuVZ008192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 11:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764606238; bh=hl0UvDfAinCsY2jcEY8VWzdGNvjdDswIPw6aIbxgKlw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ImUGPaprAYly41xQ6rC7O7mUuHmpNBznce6StlT4mnmdX76En5+B2Ya36m0iu7Rur
	 SHajJCNPev2jiJVBsY1VSMwLOrlHjz2BB4V/KtVuUStWOPLkx8/hraz/vSlLIqQ85Y
	 02quKjn6z6+thN6olI/HUpWr7QYhpiDtQzLXtjVQ01Z+O8XjiJQMji8wmqKkK/i6bM
	 EoPTDxunL8go008aVeR7+QC6mIfMNaW+KipW1ibos+WqqjOQRgAQHEXnNz/yRaOW+P
	 2/HrLykv4R3Bbgh3gGQ3l6TmjhbOtX2TnFMfYmZnqUultUFpiOgIUkoJBpPP0KuwX7
	 WaU0DFRrUewiw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0A0A72E00DF; Mon, 01 Dec 2025 11:23:54 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        Yang Erkun <yangerkun@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, yi.zhang@huawei.com, libaokun1@huawei.com,
        yangerkun@huaweicloud.com
Subject: Re: [PATCH v4 0/3] ext4: minor cleanup
Date: Mon,  1 Dec 2025 11:23:49 -0500
Message-ID: <176455640534.1349182.13313528599282978457.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112084538.1658232-1-yangerkun@huawei.com>
References: <20251112084538.1658232-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 12 Nov 2025 16:45:35 +0800, Yang Erkun wrote:
> v3->v4: remove "ext4: remove useless code in ext4_map_create_blocks"
> since we should keep this logic which needed for latter work from Yi[1].
> 
> v2->v3: remove "ext4: order mode should not take effect for DIO" since
> there is no measurable performance benefit
> 
> v1->v2: update comments for EXT4_GET_BLOCKS_SPLIT_NOMERGE
> 
> [...]

Applied, thanks!

[1/3] ext4: rename EXT4_GET_BLOCKS_PRE_IO
      commit: dac092195b6a35bc7c9f11e2884cfecb1b25e20c
[2/3] ext4: cleanup for ext4_map_blocks
      commit: a9272422316f6c0ddbdfd03e695079e2b3655995
[3/3] ext4: correct the comments place for EXT4_EXT_MAY_ZEROOUT
      commit: cc742fd1d184bb2a11bacf50587d2c85290622e4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

