Return-Path: <linux-ext4+bounces-6862-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA6FA667A8
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE663BEA2C
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08621DED44;
	Tue, 18 Mar 2025 03:42:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2FE1DDC2D
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269338; cv=none; b=pT/K4tzsapmmqPPE00UtNvngKwXVaG2XZR4ejSZLXYw7ZDXluyI/2HJZsDCNTHQWnzLSXmSlSLptwghLa93s35aKVTodJ372iURxRjmJ/jQVCOYpmxSg3QOiXBG+0nqLkVh/0z6l+U+LclEDgunq7JsKQSMvBwOmu9HQCTn//p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269338; c=relaxed/simple;
	bh=Lo2NqF8xiou+MJCOyZZcCuVYQAN1YbMlZm8ZXxagtDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3ekzrHnXI32fo5fAEOZCLWBwlqPQIlfnzuHppf2lFzr7lOg5ffSQR2jkeGRdyej3YWWeBVt01L/yc6joaHWJLx8f04flSBGdkqR29j/NF0iPDAHJClrOkTcHM07CySp7gzsjmBeQmqZdxhTujDbDzyrQR5t7cekuvk9xYhgUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fjtt012114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:48 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D324D2E010F; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, shikemeng@huaweicloud.com,
        Charles Han <hanchunchao@inspur.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix potential null dereference in ext4 kunit test
Date: Mon, 17 Mar 2025 23:41:17 -0400
Message-ID: <174226639131.1025346.17589264624479359669.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250110092421.35619-1-hanchunchao@inspur.com>
References: <20250110092421.35619-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 10 Jan 2025 17:24:21 +0800, Charles Han wrote:
> kunit_kzalloc() may return a NULL pointer, dereferencing it
> without NULL check may lead to NULL dereference.
> Add a NULL check for grp.
> 
> 

Applied, thanks!

[1/1] ext4: Fix potential null dereference in ext4 kunit test
      commit: 57e7239ce0ed14e81e414c99d57f516f6220a995

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

