Return-Path: <linux-ext4+bounces-5503-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3B79E773C
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 18:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5211887E1B
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211D4220680;
	Fri,  6 Dec 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="q8fXv2/i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B3220682;
	Fri,  6 Dec 2024 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506133; cv=none; b=cjQEBuiPSpM+IZqPZixXJtQATHUOn5lbotLgRqX1/3etkLUzZcopB1XKraquvQVsJdbcISlU3+KPWzZXipITe7Jhf4VuspApOIzEOarC9gGthVWp8oeeFy/bbxNUaLbajMTldP8BVKFrWJ+OJEnlS3QblSslVTUiQWtxZy5xfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506133; c=relaxed/simple;
	bh=XrBE9BU1MpcsnWYQCE/2v8ZD3TvZng2BdtYKI5XLzLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nhHXKL6ez+XY2wxtjMAL42PJ+aEysnUrH1ONXhCokO1gG72oJCm2rvdEugzGzHQt59FQ9Y6kFMCeIIqpLf9JVXnHH3tLk+rncBEMokBSC//CcyBpbzRyzwBoSipcY1cTbvkRMf6tYu2dYIOxqwTC2IZzxVTWZuYXLPAgGqJNQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=q8fXv2/i; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iN/YFG7gzkfXtESUbcl57NaiFA3xsD4YvA095Pbr0is=; b=q8fXv2/iZuLRFHjnsT7heCkZ+i
	e4TPrA94GTx+oOsqUlxqZPH5KlKG7tDXpNvjgwthNmE9PQoC/leZo0+HyffhLrDvxo/5CWCwkdrRg
	K503AXbv2nyIzova7aYUdxBsnwABRgUxIKdCSlH1lyYDXlI8CIvFq4uKzxXiGnXfet2a3v5zEkJzK
	5Xg7UDQv4UIuHhsmUk3wLQ9c7NOGzT20BMwqoQs83BvKz9s6p9uirdc7oo8IyaZujbFSTrmdCNeCF
	S6STotv4BMLzFrIEPsC688jhB7U3b8yXyiAq8BYR4SQgE5/0y+e4Zcg4QrDelg/cNguABq/yS/DgN
	nXB232kA==;
Received: from 179-125-79-245-dinamico.pombonet.net.br ([179.125.79.245] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tJc8E-00HUmO-EF; Fri, 06 Dec 2024 18:28:47 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 0/5] ext4: inline data cleanup
Date: Fri,  6 Dec 2024 14:28:23 -0300
Message-Id: <20241206172828.3219989-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series starts some cleanup of the inline data support, making it
easier to handle cases where the disk data is changed underneath the
system.

They were tested with some test cases that have good coverage with both
regular files and directories (indexed and not).

A few syzkaller or hand-written reproducers have also been tested and shown
not to crash the system anymore, but mount the filesystem read-only,
failing with -EUCLEAN.

Thadeu Lima de Souza Cascardo (5):
  ext4: inline: remove extra size check when writing data
  ext4: inline: use cached i_inline_size instead of e_value_size
  ext4: introduce wrapper to read data from inode
  ext4: add a wrapper to update i_inline_off and i_inline_size
  ext4: make i_inline_off point to data

 fs/ext4/inline.c | 176 ++++++++++++++++++++++-------------------------
 1 file changed, 84 insertions(+), 92 deletions(-)

-- 
2.34.1


