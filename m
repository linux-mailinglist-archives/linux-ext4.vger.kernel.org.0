Return-Path: <linux-ext4+bounces-10439-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D8CBA53EB
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E34560A88
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA91296BC2;
	Fri, 26 Sep 2025 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="D9f57CKC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011F287253
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923282; cv=none; b=LqZjhPM1EEQMJz/sP2sOgJYXj/jlta8vhD87qPs/HM2pM0BDDrpodXQNedESxv1tFj1g2pd926m4OuHn52XvzuP6KNTD4z7hhVZwVge8zv7oGrMqmjD3CcYs0ssFOHh08JQv7/iV5Y3lm+oFi3xU0LUaNu4hPK8vNuar/UxZO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923282; c=relaxed/simple;
	bh=bNkHR/nLj7QeVWub7ZOwMbGz0IioNwY2+YRCCQb8XdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ksz9PJyLASlhstPZ7lqcs5mLJOxPFZvLwrFtJJRY7YlbZtdapwCHaopPV9gE6jroWi9zbTequ0nN/b4jV4j4zT/cLLn5KtLjMO6G5bpf6v4N+lJTZa8JyMuACdAO5Q26wBOcVhmcjzolAw2s9dqV7vlu4sVZx/Q4w9rgopfevn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=D9f57CKC; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLlspT014685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923275; bh=QYFU1eQAxRVovSWl9ik2D0LP7H7akVffIJQCa6m6zLk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=D9f57CKCCTruD3EIyyMDpRkt6ZIa7qus3+KLtR4YlNNMV2bQ2qyh6+Hrnw1ZTilbi
	 jfOvqSB2s5EoJ6P/KRH5hg1o/hhH03c0DDd1j2S5ljrIKtHfK2b0Nq+N57LAswnlRU
	 QXtFJ8H8yuEFYI4iOzr7m/NilWLJYdDBWgjL/NfMGm4pp1oxuM5XMqRc/Ol+qleewK
	 TRKP+trwZG+/AYNT4ncYkEJrzVeMgNlkCBSjKMpK+OwkgXqyvwur4FPRtALQW3Jbvq
	 gLPPC4HSQL96HI+CQttebkAraih7+eAlbwF/wfUrSYFqZDzLtc3iRWM67BdWvLnYRV
	 umKIgzlWI3VcQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D5EF72E00DB; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH] ext4: Fail unaligned direct IO write with EINVAL
Date: Fri, 26 Sep 2025 17:47:36 -0400
Message-ID: <175892300643.128029.2423032449227240852.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901112739.32484-2-jack@suse.cz>
References: <20250901112739.32484-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 01 Sep 2025 13:27:40 +0200, Jan Kara wrote:
> Commit bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> changed the error handling logic in iomap_iter(). Previously any error
> from iomap_dio_bio_iter() got propagated to userspace, after this commit
> if ->iomap_end returns error, it gets propagated to userspace instead of
> an error from iomap_dio_bio_iter(). This results in unaligned writes to
> ext4 to silently fallback to buffered IO instead of erroring out.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fail unaligned direct IO write with EINVAL
      commit: 963845748fe67125006859229487b45485564db7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

