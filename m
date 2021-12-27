Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC6B47F99D
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Dec 2021 02:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhL0BM4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Dec 2021 20:12:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34460 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234895AbhL0BMz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Dec 2021 20:12:55 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BR1Cl3Z012508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Dec 2021 20:12:48 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 616F015C33A3; Sun, 26 Dec 2021 20:12:47 -0500 (EST)
Date:   Sun, 26 Dec 2021 20:12:47 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [tytso-ext4:dev] BUILD REGRESSION
 cc5fef71a1c741473eebb1aa6f7056ceb49bc33d
Message-ID: <YckTD4NcqD8rdZDV@mit.edu>
References: <61c73848.ezrkzdC4STslya5j%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c73848.ezrkzdC4STslya5j%lkp@intel.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 25, 2021 at 11:27:04PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> branch HEAD: cc5fef71a1c741473eebb1aa6f7056ceb49bc33d  ext4: replace snprintf in show functions with sysfs_emit
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/linux-ext4/202112101722.3Kpomg0h-lkp@intel.com
> 
> possible Error/Warning in current branch (please contact us if interested):
> 
> fs/ext4/super.c:2640:22-40: ERROR: reference preceded by free on line 2639

The Intel test robot mis-identified the commit which introduced this
problem (it looks like the first commit with the problem is commit
e6e268cb6822 ("ext4: move quota configuration out of
handle_mount_opt()"), but it caused me to take a closer look, and this
looks... wrong.

From ext4_apply_quota_options() in fs/extr4/super.c:

			qname = ctx->s_qf_names[i]; /* May be NULL */
			ctx->s_qf_names[i] = NULL;
			kfree(sbi->s_qf_names[i]);
			rcu_assign_pointer(sbi->s_qf_names[i], qname);
			set_opt(sb, QUOTA);

sbi->s_qf_names[i] is an RCU protected pointer, which is used via
rcu_derference().  So how can it be safe to kfree() the pointer;
should that be kfree_rcu() at the very least?

Lukas, can you take a look and let me know?   Thanks!

       	       	      	       	      - Ted
