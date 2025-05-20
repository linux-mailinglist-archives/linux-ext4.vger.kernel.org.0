Return-Path: <linux-ext4+bounces-8046-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD20ABDD69
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 16:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5181B6225C
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A565028FF;
	Tue, 20 May 2025 14:40:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202B23F28B
	for <linux-ext4@vger.kernel.org>; Tue, 20 May 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752032; cv=none; b=u+cvRm0ovket2CW6oIKj9aG9PwJ0US1LCgJzUivYPhZP1XIQJ2K1rDaiE1MzXY2cyLc75C2JR05IzXc1xcVXjPkjqxznqKzIT4UQ5jKVT6p101+kYuq8nyWgDtvA5DoFtJIAS45HT+Fn/ORpAngXAlGxPt6nK6Tc+rKH6lSrBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752032; c=relaxed/simple;
	bh=DziX7P32O0FHNTp8r6AMPqYH5/Jw/2pg7i4IrdvRqBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njwbCZ7gt9Xke6lqUbuE4ZBI5lRJmCsDbKZylj0RLtiV1hkQZVi9BkUMS46HWP0jAB8Xje0BoJylL2f7q61yOXgSZjjugypUZHAWYYRR7JpmWmML3orF3pbCB0WTykkmkKQnSJFxBF2uyCK/Jjz5OWQp6Lcv5C1CwRuwF9Z7wrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEeOcS013124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BC6432E00E2; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 0/4] ext4,jbd2: clean up unused arguments to checksum functions
Date: Tue, 20 May 2025 10:40:13 -0400
Message-ID: <174775151766.432196.2828492207378893037.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513053809.699974-1-ebiggers@kernel.org>
References: <20250513053809.699974-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 May 2025 22:38:05 -0700, Eric Biggers wrote:
> Since ext4_chksum() and jbd2_chksum() now call crc32c() directly, they
> no longer use their ext4_sb_info and journal_t arguments.  Remove these
> unnecessary arguments.  No functional changes.
> 
> Eric Biggers (4):
>   ext4: remove sbi argument from ext4_chksum()
>   ext4: remove sb argument from ext4_superblock_csum()
>   jbd2: remove journal_t argument from jbd2_chksum()
>   jbd2: remove journal_t argument from jbd2_superblock_csum()
> 
> [...]

Applied, thanks!

[1/4] ext4: remove sbi argument from ext4_chksum()
      commit: 6cbab5f95e49ec8a9f21784fae3ff0ee09b2dfbc
[2/4] ext4: remove sb argument from ext4_superblock_csum()
      commit: 6017dbb7b67a3ca90d339ca32fe6dde425686435
[3/4] jbd2: remove journal_t argument from jbd2_chksum()
      commit: 76005718cf8bfdb6b0f818ea75ca6a4b3bee34cd
[4/4] jbd2: remove journal_t argument from jbd2_superblock_csum()
      commit: fff6f35b9b2f0c79c9eb6106311530864d8f1394

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

