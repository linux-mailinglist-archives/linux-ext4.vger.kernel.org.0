Return-Path: <linux-ext4+bounces-6847-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD77A6678A
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E9F189AA13
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535091A08B1;
	Tue, 18 Mar 2025 03:41:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39E1865E5
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269317; cv=none; b=nvdQNQf11E14SD7NC4AInQsBiinbZWLBsBchAQ/pEtGHEOAWv/n5q8VlwuKxTb6E8wsSG36c+iGojcdm8DDp58fnYfesi6WswN17OkWVIZZkfyys9wc+Iz6X8QOkFSpkHrjR5DZ2BCLKMBymnGbsODxWR2DQ2LzF/5o35IvbpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269317; c=relaxed/simple;
	bh=RIWLI4MuTo1lhqjZZ5aKwIGYDvk/D+YBxwhT62p+nAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOKdJt6DfB628Fka8yGZ40O7kBPgAfl/00voiwEE60I375BX0yAMkXVP2h/iWC0OWYZjz9MLXCkqUdmLpSq54TtD3u8MB9k5JlDrUZXKF2dtcCs1l4ekHjx/atsJWoAzwPm21TufE2i+KyuoB6sFB4I7CVHFOjX4fLwGiNKoZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fnfq012162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id EF6F52E0119; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Julian Sun <sunjunchao2870@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [PATCH v2 0/5] Some cleanups and refactoring of the inline data code
Date: Mon, 17 Mar 2025 23:41:27 -0400
Message-ID: <174226639131.1025346.17184173928017965569.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250107044702.1836852-1-sunjunchao2870@gmail.com>
References: <20250107044702.1836852-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 07 Jan 2025 12:46:57 +0800, Julian Sun wrote:
> Here are some cleanups and refactoring of the inline data code. Please see
> patches for details.
> 
> Julian Sun (5):
>   ext4: Remove a redundant return statement
>   ext4: Don't set EXT4_STATE_MAY_INLINE_DATA for ea inodes
>   ext4: Introduce a new helper function ext4_generic_write_inline_data()
>   ext4: Replace ext4_da_write_inline_data_begin() with
>     ext4_generic_write_inline_data().
>   ext4: Refactor out ext4_try_to_write_inline_data()
> 
> [...]

Applied, thanks!

[1/5] ext4: Remove a redundant return statement
      commit: f896776a7019ebc6403504262cd4239aaa9b99ba
[2/5] ext4: Don't set EXT4_STATE_MAY_INLINE_DATA for ea inodes
      commit: 90c764b4b7f683ca62dbeeceea0ea3a0c6831200
[3/5] ext4: Introduce a new helper function ext4_generic_write_inline_data()
      commit: 3db572f780e9dd7be33d5ac3fb3f0e70a9d4a82d
[4/5] ext4: Replace ext4_da_write_inline_data_begin() with ext4_generic_write_inline_data().
      commit: f9bdb042dfae981d34911a6184157a720fce5e3d
[5/5] ext4: Refactor out ext4_try_to_write_inline_data()
      commit: 30cbe84d48d7d704fdaaf5179a0f4e0764ca35ab

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

