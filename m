Return-Path: <linux-ext4+bounces-9119-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8AAB0B433
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Jul 2025 10:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B653BC475
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Jul 2025 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A551CBA18;
	Sun, 20 Jul 2025 08:27:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4B3FC7
	for <linux-ext4@vger.kernel.org>; Sun, 20 Jul 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000067; cv=none; b=aT6EcxhHbabzyYFuVXMZ2obNzyQpyw76IqdIrk7mEUofcK1HP/C1bwOJPs5rYzQQ067W4FPcp6IkztoPJSqfEvJkruPXP9I2X6TKHI39m2v9y0kqUMHwxqW1TXINq0WdLhK+6JZUS3rfGwbQbH33j6oZZ7gjXzmvqz2Xz8yrW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000067; c=relaxed/simple;
	bh=SmlDm1RgMWqZWTnpBTYU+fhxobGRJCUmN4CfqLlDVi4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=jRH61HyWDu5oIrHwHxpGQEk8bj3cvykiBj2LaPqtpE6Mhg257HCHhOrGkjmx3pY2qtRSaDaNS8M4QpS6LjD1DLTJed9Zkx/6fyZTDBSVkJZaC32ENrhGqk/Dtoe1ihlztY1unTN6Vd4Uo/Clk3i9m41851f8i/b2/e1A0RmB+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5A633340D82;
	Sun, 20 Jul 2025 08:27:44 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: djwong@kernel.org
Cc: linux-ext4@vger.kernel.org,tytso@mit.edu
Subject: Re: [PATCH 2/5] fuse2fs: stop aliasing stderr with ff->err_fp
In-Reply-To: <174553064491.1160047.2269966041756188067.stgit@frogsfrogsfrogs>
Organization: Gentoo
User-Agent: mu4e 1.12.11; emacs 31.0.50
Date: Sun, 20 Jul 2025 09:27:41 +0100
Message-ID: <87seirz2pu.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This seems to have introduced https://github.com/tytso/e2fsprogs/issues/235.

