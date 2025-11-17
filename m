Return-Path: <linux-ext4+bounces-11878-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 577D6C65E83
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id D5D6C241E2
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 19:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBCA3375D3;
	Mon, 17 Nov 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dI7uMBdB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB863358C7
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406852; cv=none; b=qUz3BIpdpeXHCcxur4z3+Ge9d5uVr8Y4a/iPzfmieTvvxx+72wt9mwP1Pa6txE+i4iXoyfuFAqTgiWSk3zp/eqhUq9CRUY4mMp1pC8zUcTbLGLELJxDNvUwnGZ5akbtzvypWwJ4vBRUojkZ+jbzvzXPjwyqUjRV/uGg9+CUerLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406852; c=relaxed/simple;
	bh=PryUqSfGOtu1dcSTzD75qS0pEoOvpvo9Zz0HJXw4wGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVUf3ZokbeS7flfOQ2RXFsLUW2Azyz7fpiJ6IFLKf48o4d7S28Fcyddmfe/D247/P4/55P9/zFmK2x2nv+5sN3ptCKQpLm2HTVcMCPLgVjblmtu+WelzpxhsSDFn2ib7H3rw3vmMpneKE9mb4ABdZR1jA2bdOLMpvqRmw6INOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dI7uMBdB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-69.bstnma.fios.verizon.net [173.48.114.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AHJDqWA020626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 14:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763406835; bh=qvVBBzm3gsdyD7wt7Gn9GqVdRulRxY/LXxZdqB1OiR4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=dI7uMBdBRYMjaX4ApDXoomGFjOOczaD1yvny4SV5Uf0sNJkO1ZZduBCYA0pezyqfm
	 4bGfvKLIOzgoggnGjOjtsamJ0ESTaUuVW01fsR9G4n19tSS24yfiMywRQovNHb0/R+
	 2o+0+ERvcki/8wDHeOwWrBVejHK7CYKhQFiM+7F20F9G3pWz2lJeSL+spOp/K3EhzN
	 Ejj9GjJizVWLbBh4+QDK4W4OSAweZEg8hmYEmOtc0IXN7hbZ1K6WIt45rFLErLikUG
	 FwWYZCICVuswwk8grfdHkNg1I5lUoyMfZZynLk4FEp/D/RxcChu0sB8BjjPo4jJRDT
	 k+/bbdgt5wGbw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 461672E00DE; Mon, 17 Nov 2025 14:13:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] jbd2: allocate lock_class_key for jbd2_handle dynamically
Date: Mon, 17 Nov 2025 14:13:35 -0500
Message-ID: <176340680642.138575.13187935729137016105.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <987110fc-5470-457a-a218-d286a09dd82f@I-love.SAKURA.ne.jp>
References: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp> <fwsxrb7ugi5zeosugo6hyjdbhw36ppa5kekfi6n7we2vvi3r7m@ljrizqoagsg7> <93744126-237b-4e36-8a62-a33e1fb52051@I-love.SAKURA.ne.jp> <mjzb7q6juxndqtmoaee3con6xtma5vfzkgfcicjjmt7ltv2gtt@ps2np5r36vn3> <96c8fca1-7568-46c8-a5ad-af4699b95d5e@I-love.SAKURA.ne.jp> <doq4csrkuhpha7v5lunesdrscmqmjvt3flids3iai2gvpbhp3j@mxldi4yvvymw> <a6fcc693-42f0-4d70-a1af-fc1bfb328eb7@I-love.SAKURA.ne.jp> <rajbaoxp7zvaiftmuip4mxdvrdxthhgvbjvtuq3zrwijtdab2j@ouligqrqxyth> <987110fc-5470-457a-a218-d286a09dd82f@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 22 Oct 2025 20:11:37 +0900, Tetsuo Handa wrote:
> syzbot is reporting possibility of deadlock due to sharing lock_class_key
> for jbd2_handle across ext4 and ocfs2. But this is a false positive, for
> one disk partition can't have two filesystems at the same time.
> 
> 

Applied, thanks!

[1/1] jbd2: allocate lock_class_key for jbd2_handle dynamically
      commit: 524c3853831cf4f7e1db579e487c757c3065165c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

