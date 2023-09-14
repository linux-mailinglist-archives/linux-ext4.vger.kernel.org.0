Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F857A085A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Sep 2023 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjINPBV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Sep 2023 11:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbjINPBU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Sep 2023 11:01:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975FA1FC2
        for <linux-ext4@vger.kernel.org>; Thu, 14 Sep 2023 08:01:15 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-225.bstnma.fios.verizon.net [173.48.113.225])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38EF0jpt000409
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 11:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1694703647; bh=lrmQrJvIxyRlTUwEk2DAFIW09BK8fmo+w0FXcpX+fwo=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=DRrBl2gaykYyOeNDI6kPCZsGg//yU3c8kUacwsI8I2q3LoFP7nVm95MMLGfny86yK
         GNmS/14Tu7bDlczYFFbGCdEPRijJe11Rgvf8yb1NJXGB7HXnVnYmIX0bVUcQTywbFx
         Q4ifHqCJy64B1NNCy+E0iejZWVby6zyNzNiSF48QRYQsyAwsDym3xTmGSjQ3+yo56I
         75AMa5aOilGMo6qKUgtzRW/GT+zPRQgLb+RjKx8Ev2PPXJg8jnPGwMBEiBxH9dT+ks
         XxpNIX9VRAolNo3NJWWwG1/l9TTs/iHGfRztXpso9ZJ38a2AJMpVvkzSRt+bCUKZo+
         Ggr881zVnyHtQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E7C8915C0266; Thu, 14 Sep 2023 11:00:44 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        todd.e.brandt@intel.com, lenb@kernel.org
Subject: Re: [PATCH 0/2] ext4: Do not let fstrim block suspend
Date:   Thu, 14 Sep 2023 11:00:42 -0400
Message-Id: <169470363119.1407074.11495845673817769127.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230913145649.3595-1-jack@suse.cz>
References: <20230913145649.3595-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Wed, 13 Sep 2023 17:04:53 +0200, Jan Kara wrote:
> these two patches fix a long standing issue that long running fstrim request
> can block a system suspend as reported by Len Brown in [1]. The solution is
> quite simple - just report whatever we have trimmed upto now since discard
> is an advisory call anyway. What makes things a bit more complex is handling
> of group's TRIMMED bit - we deal with that in patch 1.
> 
> 								Honza
> 
> [...]

Applied, thanks!

[1/2] ext4: Move setting of trimmed bit into ext4_try_to_trim_range()
      commit: 5e4a9f11b5d7cb70a4e4474f0ba25d5f1fd2a8ed
[2/2] ext4: Do not let fstrim block system suspend
      commit: b016ebb300e514bc46151f8fc006caae141a8bde

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
