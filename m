Return-Path: <linux-ext4+bounces-1806-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB13893C32
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9061C20C29
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528641740;
	Mon,  1 Apr 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W6LUUvI+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB023FBBD
	for <linux-ext4@vger.kernel.org>; Mon,  1 Apr 2024 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981439; cv=none; b=Vbcug3xfkhXL0WVCjF/N2dtJmO66tXBlufsY1t1MQ+TfNWaqr512kQTpOCZPcQpAYcI4K2jqa49sIpB1J6uelN3t1rXHVPwkvALAyIPz12c0eFwuTBOUUmmN92eT8Wd6+8jlUuJI3qobilRluHr2QfG6GEZCdWjWwAHKHiDXpgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981439; c=relaxed/simple;
	bh=GYqoCIrUSMqT/WrYlqYEW8WIHKXahVEyEOqT1UBvxK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OCYHjrnLezSfANr28qwRSHjn8M4oQRJP9NY/ZFUBzO8V68zOQ5/SNgwSAL4tWEQz3z66iSLxVyljMdFL0E1NqofijdlAOQ/LXdfHheVLMpOmSP8sqDqa8Djzr2x28ViXdxksElk4fjEMdhhOEV5WW/NcHBZS9nKFs/74hQEwNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W6LUUvI+; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711981434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1aQUhHQQfMXDd8XlpsAJbPmuvmkL70g2nOgoG1dTV7Q=;
	b=W6LUUvI+oi40lw+OPN8G7sKtP8W9p2tAdlMgddaNEeCX4JLFCLYokDk9CJfarlt0gwsfHO
	AW2NZmYzbeQif1A8KyVOHH2Y8XuiIRqUsFSb/z/dVqUSjyoVbuihcLxCs5sJRjgnOpS09w
	45j9MRZsXqhnBgTNEYwiu1rAtMP/M/A=
From: Luis Henriques <luis.henriques@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Wang Jianjian <wangjianjian0@foxmail.com>,  Ext4 Developers List
 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: Add correct group descriptors and reserved
 GDT blocks to system zone
In-Reply-To: <20230817170557.GA3435781@mit.edu> (Theodore Ts'o's message of
	"Thu, 17 Aug 2023 13:05:57 -0400")
References: <tencent_D744D1450CC169AEA77FCF0A64719909ED05@qq.com>
	<20230817170557.GA3435781@mit.edu>
Date: Mon, 01 Apr 2024 15:23:52 +0100
Message-ID: <87ttkl6u13.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Thu, Aug 03, 2023 at 12:28:40AM +0800, Wang Jianjian wrote:
>> When setup_system_zone, flex_bg is not initialzied so it is always 1.
>> ext4_num_base_meta_blocks() returns the meta blocks in this group
>> including reserved GDT blocks, so let's use this helper.
>> 
>> Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
>
> Thanks for the patch.  I ended up collapsing the two patches into a
> single one, and then fixed up some checkpatch errors.

Sorry for revisiting this old thread, but it looks like these patches
(commit 68228da51c9a "ext4: add correct group descriptors and reserved GDT
blocks to system zone") broke fstest ext4/059.

A (very!) quick look seems to show that it's related with the very fact
that sbi->s_es->s_reserved_gdt_blocks are now taken into account to
compute the number of blocks (which is the point of the patch, of course).
Maybe the test needs to be fixed, as it messes up with the GDT reserved
blocks...?

Cheers,
-- 
Luis

