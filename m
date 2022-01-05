Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBEC484CC0
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 04:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiAEDOt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 22:14:49 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45765 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232991AbiAEDOr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 22:14:47 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2053EfUi001138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jan 2022 22:14:42 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6923915C00E3; Tue,  4 Jan 2022 22:14:41 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] ext4: don't use kfree() on rcu protected pointer sbi->s_qf_names
Date:   Tue,  4 Jan 2022 22:14:37 -0500
Message-Id: <164135246476.257673.914145446344436987.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220104143518.134465-1-lczerner@redhat.com>
References: <20220104143518.134465-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 4 Jan 2022 15:35:17 +0100, Lukas Czerner wrote:
> During ext4 mount api rework the commit e6e268cb6822 ("ext4: move quota
> configuration out of handle_mount_opt()") introduced a bug where we
> would kfree(sbi->s_qf_names[i]) before assigning the new quota name in
> ext4_apply_quota_options().
> 
> This is wrong because we're using kfree() on rcu prointer that could be
> simultaneously accessed from ext4_show_quota_options() during remount.
> Fix it by using rcu_replace_pointer() to replace the old qname with the
> new one and then kfree_rcu() the old quota name.
> 
> [...]

Applied, thanks!

[1/2] ext4: don't use kfree() on rcu protected pointer sbi->s_qf_names
      commit: e1577876127c1e6827225997b64ef3577a4afcf3
[2/2] ext4: only set EXT4_MOUNT_QUOTA when journalled quota file is specified
      commit: d2717c29596304ada9edb78959baed8e0977018f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
