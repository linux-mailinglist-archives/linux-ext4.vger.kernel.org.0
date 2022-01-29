Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F084A2B9C
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Jan 2022 05:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344578AbiA2EfZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jan 2022 23:35:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34298 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230242AbiA2EfY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jan 2022 23:35:24 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20T4ZEqh031387
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 23:35:15 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2AC2915C0040; Fri, 28 Jan 2022 23:35:14 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Yang Li <yang.lee@linux.alibaba.com>, jack@suse.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH -next -v2] ext4: Fix jbd2_journal_shrink_scan() and jbd2_journal_shrink_count() kernel-doc comment
Date:   Fri, 28 Jan 2022 23:35:11 -0500
Message-Id: <164343088807.815725.18138313955361994857.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220110132841.34531-1-yang.lee@linux.alibaba.com>
References: <20220110132841.34531-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 10 Jan 2022 21:28:41 +0800, Yang Li wrote:
> Add the description of @shrink and @sc in jbd2_journal_shrink_scan() and
> jbd2_journal_shrink_count() kernel-doc comment to remove warnings found
> by running scripts/kernel-doc, which is caused by using 'make W=1'.
> fs/jbd2/journal.c:1296: warning: Function parameter or member 'shrink'
> not described in 'jbd2_journal_shrink_scan'
> fs/jbd2/journal.c:1296: warning: Function parameter or member 'sc' not
> described in 'jbd2_journal_shrink_scan'
> fs/jbd2/journal.c:1320: warning: Function parameter or member 'shrink'
> not described in 'jbd2_journal_shrink_count'
> fs/jbd2/journal.c:1320: warning: Function parameter or member 'sc' not
> described in 'jbd2_journal_shrink_count'
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix jbd2_journal_shrink_scan() and jbd2_journal_shrink_count() kernel-doc comment
      commit: be74a53334ad38b11cc2998749837e87796375e2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
