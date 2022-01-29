Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063784A2B87
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Jan 2022 04:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352207AbiA2Dz3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jan 2022 22:55:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58964 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238931AbiA2Dz2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jan 2022 22:55:28 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20T3tEUC022904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 22:55:15 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BE7DC15C0040; Fri, 28 Jan 2022 22:55:14 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ext4: fix potential NULL pointer dereference in ext4_fill_super()
Date:   Fri, 28 Jan 2022 22:55:13 -0500
Message-Id: <164342850388.815473.363466652526479494.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220119130209.40112-1-lczerner@redhat.com>
References: <20220119130209.40112-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 19 Jan 2022 14:02:09 +0100, Lukas Czerner wrote:
> By mistake we fail to return an error from ext4_fill_super() in case
> that ext4_alloc_sbi() fails to allocate a new sbi. Instead we just set
> the ret variable and allow the function to continue which will later
> lead to a NULL pointer dereference. Fix it by returning -ENOMEM in the
> case ext4_alloc_sbi() fails.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: fix potential NULL pointer dereference in ext4_fill_super()
      commit: 7c6bb3d664aa05bf4366fd79a13921acfca28a6d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
