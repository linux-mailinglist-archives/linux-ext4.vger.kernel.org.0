Return-Path: <linux-ext4+bounces-1368-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3685FD37
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 16:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B7B28476
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C95150983;
	Thu, 22 Feb 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bZueVBJK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94914F9FD
	for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617306; cv=none; b=WGv8t7oQenG9IQ/yHj7E/khk71ZG8e9sg+YD9Lt6bSRhsrjfMmAlA28JAjldH9NFIU5u7I3zddavPJ8xeIlvllOM63C9dJ7lBkTQ83KGGRBRgyCFzzVm3zhMI6hAVrFCcFAiADMXrHZoc021Gixdu9d1GMIXaWFWVXCNUgN3mFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617306; c=relaxed/simple;
	bh=20fNwW74JC7aZ6Jn1yiRm/b9BWYAfjd6b+1wrgjBCks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDqxE/hZHWnMrPauPMp/XV05DcO0TXTijJV+aA+jqB4Rvuf12r3+rQtJ8riFEaAWKlyj1OGg8io+h1TkgiW0z++Slur5wYfSd0GGyXn6xYxVQ+fWVQdEiFmt/8xGg3pRdkIpKblyHKheI6s6rsrKiUbRL/EOaWu3CfvSCy3OU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bZueVBJK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MFsgk0030832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708617284; bh=2mvzlQJBJ2QbaWLHc9B+1WPB0IOg3byLhTEQ5VPqgUE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=bZueVBJKWshDp3Um7w0ZZrtpkbhJ0Fe/9t7dXTRIQO65VgNqy6psLKeYKnOG/8hHn
	 bUeZeOCCb4h4dTRbNDY2+uZtN4amQEZsV8jPxljLlkMvB/qO1WnUJlxAyYTsQHjo2B
	 x51F7/KJ41TPhd7ygRjlmXdyRw6vNHoblSyYTkmi+6p6aVpVXkrBJEonDs2iZ7G3Ii
	 /lUXmRje+q4mNghIPmQDt6kHj69cH//OFCTQ7V/DoHezs4XCl6vN/mNdrOtkeEd4rI
	 lfpcyuIM6lE2b9usphn02Mrm7D2kOJI83CFUjt64TJpz+JKZUEI1ouzaFh7wMR3C8V
	 Bzy6/8qHo7vyA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3EABF15C1476; Thu, 22 Feb 2024 10:54:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] More unit test for mballoc
Date: Thu, 22 Feb 2024 10:54:34 -0500
Message-ID: <170861726752.823885.15875774259762571954.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103104900.464789-1-shikemeng@huaweicloud.com>
References: <20240103104900.464789-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 03 Jan 2024 18:48:55 +0800, Kemeng Shi wrote:
> This series covers more function to mark on-disk bitmap. Besides, some
> code which is relevant to buddy cache is also tested.
> Before more work is done, I want to be sure I'm not on a wrong
> direction!
> 
> v1->v2:
> -Fix unused variable warning which is reported at
> https://lore.kernel.org/lkml/202311260042.kMxL6DnL-lkp@intel.com/T/
> 
> [...]

Applied, thanks!

[1/5] ext4: Add unit test for test_free_blocks_simple
      commit: 6c5e0c9c21456fb561d0997fe2c4d3cf59745ba7
[2/5] ext4: Add unit test of ext4_mb_generate_buddy
      commit: 67d2a11b22b4d520072db62620851615df13183e
[3/5] ext4: Add unit test for mb_mark_used
      commit: ac96b56a2fbd9e05b28488bdc5d3bd8006b61d35
[4/5] ext4: Add unit test for mb_free_blocks
      commit: b7098e1fa7bcf350e089af9500c4f9992a1bd6cb
[5/5] ext4: Add unit test for ext4_mb_mark_diskspace_used
      commit: 2b81493f8eb6fc0c263dbca0064e10e4c00e0f91

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

