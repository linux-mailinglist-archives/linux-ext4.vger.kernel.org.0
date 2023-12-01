Return-Path: <linux-ext4+bounces-262-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC149800DA8
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 15:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0271C20ECA
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EFA3D38F;
	Fri,  1 Dec 2023 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HvE5Amno"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBCD10FA
	for <linux-ext4@vger.kernel.org>; Fri,  1 Dec 2023 06:47:40 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B1Ekv7Z005613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Dec 2023 09:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701442019; bh=axAJ7s8yGuvuaC0PW7KMO258MN4FK8/SQwcqIRrsns8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=HvE5AmnopAnTkloZtZihwh21GmQt/6ELOR0mHSiPSmMnUboDPtrWunMTrJOtLjfyh
	 /PxYM9yCKSJW+m+xmDXQqzxWz6zHxNmD/w4zt02UMrjdVsy8QgE8R0UEZBlx5z9Mv9
	 aDHJ0IzNR7hbZaiaD0qm/7wIb2FoZVv3nZ4pYtZzuAhba+EsdKkqnYgavcCTXUBhea
	 hi+YVOXNeAefj+Ox1bcf8wO0PKXskDVgHQHkFX4xtygDBz3ojrSmm9XFKQ3qilImQ+
	 8xn0JwWbJq6U0LEgBaSz0xhYRTMqarmJ02JEW9Hmi1sLGmqUNLU1k+NLf2rlX6jMQ3
	 /y0ruRp/jEtQg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 603E515C029D; Fri,  1 Dec 2023 09:46:57 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 1/2] jbd2: correct the printing of write_flags in jbd2_write_superblock()
Date: Fri,  1 Dec 2023 09:46:56 -0500
Message-Id: <170144199127.633830.17935358780145211210.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231129114740.2686201-1-yi.zhang@huaweicloud.com>
References: <20231129114740.2686201-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 Nov 2023 19:47:39 +0800, Zhang Yi wrote:
> The write_flags print in the trace of jbd2_write_superblock() is not
> real, so move the modification before the trace.
> 
> 

Applied, thanks!

[1/2] jbd2: correct the printing of write_flags in jbd2_write_superblock()
      commit: 85559227211020b270728104c3b89918f7af27ac
[2/2] jbd2: increase the journal IO's priority
      commit: 6a3afb6ac6dfab158ebdd4b87941178f58c8939f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

