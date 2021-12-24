Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410B147E9DD
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Dec 2021 01:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350416AbhLXA2C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 19:28:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41338 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350413AbhLXA2B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 19:28:01 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BO0RqQc003097
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 19:27:53 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7C23715C339C; Thu, 23 Dec 2021 19:27:52 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     harshadshirwadkar@gmail.com, adilger.kernel@dilger.ca,
        Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] ext4: fast commit crash consistency issues
Date:   Thu, 23 Dec 2021 19:27:50 -0500
Message-Id: <164030564165.2940033.15238397285316201781.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211223032337.5198-1-yinxin.x@bytedance.com>
References: <20211223032337.5198-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 23 Dec 2021 11:23:35 +0800, Xin Yin wrote:
> This patch sets fix 2 crash-consistency issues of fast commit.
> First patch change to use ext4_ext_remove_space instead of
> ext4_punch_hole during replay delete range procedure. This
> avoid replay procedure being affeced by incorrect inode->i_size.
> Second patch correct the trank range logic for ftruncte.
> 
> After testing this patch sets with xfstests-bld, in the "log" and
> "quick" group with config "fast_commit" is selected. No regressions
> was found.
> 
> [...]

Applied, thanks!

[1/2] ext4: use ext4_ext_remove_space() for fast commit replay delete range
      commit: 20a262d66487b27133c3f8b7ac0245c2fabaa526
[2/2] ext4: fast commit may miss tracking unwritten range during ftruncate
      commit: 949197083545cbff930650f893135d30fd043d4d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
