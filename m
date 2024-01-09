Return-Path: <linux-ext4+bounces-746-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E4827D0C
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 03:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86451B228B3
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 02:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525C2555A;
	Tue,  9 Jan 2024 02:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UKQs21PK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19C28FD
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4092rSal010558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 21:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704768809; bh=wJjThj/L+4pgCgHHvQiPOC+bHviqX0aP3zZ61vZYdVo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=UKQs21PKPdREzagjxkTcwFENudXslVFgXsnDyE1JAhNfHTC3WsPVwOzC6EUeB6yjL
	 8bibniuScvUGOysrE1HRrfMt4NJ0lse86bpy5a/H799LzcPEk8dU+faJDSu1HhBWJx
	 jo3dLpXCB/uEGMJeNjVkl5Twh8BFhBuiouke9hwmPr1Xm2dSlMnp5emZBKezN4i+zr
	 ICAP8SReRtmx0hy+9RTDa/kTKmtAx6GLP4dRZGi4dXnitvyvXw1uHGG9H3ch3//ysY
	 nuCrdegkNaTVK8r0rWIw456g3c3UATr2lHXTAIrSzj0ONNpmOtvDOHyHsACwq1rjHD
	 7nZP3ACe8EuaQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 19C8E15C0276; Mon,  8 Jan 2024 21:53:28 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: jack@suse.com, Zhihao Cheng <chengzhihao1@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2 0/5] jbd2: Add errseq to detect writeback
Date: Mon,  8 Jan 2024 21:53:14 -0500
Message-ID: <170476879011.637731.3198917367251947159.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213013224.2100050-1-chengzhihao1@huawei.com>
References: <20231213013224.2100050-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Dec 2023 09:32:19 +0800, Zhihao Cheng wrote:
> According to discussions in [1], this patchset adds errseq in journal to
> enable JDB2 detecting meatadata writeback error of fs dev. Then, orginal
> checking mechanism could be removed.
> 
> [1] https://lore.kernel.org/all/20230908124317.2955345-1-chengzhihao1@huawei.com/T/
> 
> v1->v2:
>   Fix some misspelling words.
>   Patch 1: "fallen on" -> "written to"
>   Patch 4: "can detects" -> "can detect"
> 
> [...]

Applied, thanks!

[1/5] jbd2: Add errseq to detect client fs's bdev writeback error
      commit: 990b6b5b13b7993b7f44740c0add3119d407ccbf
[2/5] jbd2: Replace journal state flag by checking errseq
      commit: 62ec1707cb071c95706d1bab85fbee8d5a3d2f24
[3/5] jbd2: Remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'
      commit: 8a4fd33d879fb303b207f06ea6340d73f698c4ed
[4/5] jbd2: Abort journal when detecting metadata writeback error of fs dev
      commit: b4e73e61268903d82dacff2bc6f4bb766c6ed555
[5/5] ext4: Move ext4_check_bdev_write_error() into nojournal mode
      commit: ada3fb86a3f3aea40903d5ad9aeec708dc049b8b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

